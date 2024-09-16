Return-Path: <linux-kernel+bounces-331188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DDA97A972
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 01:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7989928677E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 23:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C706C13C8FF;
	Mon, 16 Sep 2024 23:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGQ2DnnR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28546200A3
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 23:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726527680; cv=none; b=obCKuO63H/cBCdg5frwwzloDzcix5XH8himVKf2v9646F4FasFVw0X108+uqB2pERAvy9gIdO6KvyPb+XRIzq8TfKwPmtPkg6jahl4njQlsgzETqiqhlwNUhJ5Sfv6HK5jcGE0UuT5p5kqw3tRs45bIUE+50Sb32FtrxgvysiHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726527680; c=relaxed/simple;
	bh=dXnYYzgT4Y8um0L1V181yNN66H8BKXdJKBHg814VIg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z1LzN/CBdnDoqUl2EcAVXQ0hMQkot35u2f3FLTNuZnFK3PsjUQoULWlrSEjupaZAEO2u6Y1yl69oiiGwkMj2XVar26XVXP96aznTJwo1HS05b8kQVOk0lI/DBjB/n3t5Et+W4Qk91BOl4HUHNrNQa9dTqx0oApNoLRLbDKzhdII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KGQ2DnnR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726527677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ReiFZDGjB1DBMuTATaZPvvJ9MFBiEJPVKpn5i9s1uXw=;
	b=KGQ2DnnRIu0qIYxjR+PFavAmF2LQ2p+by/aNFdNG6ryu/RZwMwx4joddU3YwN5DhjODouB
	bqpUstdS8mvB6kY7LVHYfdux3TcBU2+JDCdtYUwIGsDy549GsuJ2wDSKHvkalpjrIhUlOw
	brms0kV4lxT4F6LpqWdRxTGWZqjvNNM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-QgC0bBcIPpaEtXhzXCm05A-1; Mon,
 16 Sep 2024 19:01:15 -0400
X-MC-Unique: QgC0bBcIPpaEtXhzXCm05A-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E8A91955F43;
	Mon, 16 Sep 2024 23:01:13 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.33.131])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0865C1956086;
	Mon, 16 Sep 2024 23:01:10 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
	stable@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] drm/panic: Fix uninitialized spinlock acquisition with CONFIG_DRM_PANIC=n
Date: Mon, 16 Sep 2024 19:00:08 -0400
Message-ID: <20240916230103.611490-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

It turns out that if you happen to have a kernel config where
CONFIG_DRM_PANIC is disabled and spinlock debugging is enabled, along with
KMS being enabled - we'll end up trying to acquire an uninitialized
spin_lock with drm_panic_lock() when we try to do a commit:

  rvkms rvkms.0: [drm:drm_atomic_commit] committing 0000000068d2ade1
  INFO: trying to register non-static key.
  The code is fine but needs lockdep annotation, or maybe
  you didn't initialize this object before use?
  turning off the locking correctness validator.
  CPU: 4 PID: 1347 Comm: modprobe Not tainted 6.10.0-rc1Lyude-Test+ #272
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20240524-3.fc40 05/24/2024
  Call Trace:
   <TASK>
   dump_stack_lvl+0x77/0xa0
   assign_lock_key+0x114/0x120
   register_lock_class+0xa8/0x2c0
   __lock_acquire+0x7d/0x2bd0
   ? __vmap_pages_range_noflush+0x3a8/0x550
   ? drm_atomic_helper_swap_state+0x2ad/0x3a0
   lock_acquire+0xec/0x290
   ? drm_atomic_helper_swap_state+0x2ad/0x3a0
   ? lock_release+0xee/0x310
   _raw_spin_lock_irqsave+0x4e/0x70
   ? drm_atomic_helper_swap_state+0x2ad/0x3a0
   drm_atomic_helper_swap_state+0x2ad/0x3a0
   drm_atomic_helper_commit+0xb1/0x270
   drm_atomic_commit+0xaf/0xe0
   ? __pfx___drm_printfn_info+0x10/0x10
   drm_client_modeset_commit_atomic+0x1a1/0x250
   drm_client_modeset_commit_locked+0x4b/0x180
   drm_client_modeset_commit+0x27/0x50
   __drm_fb_helper_restore_fbdev_mode_unlocked+0x76/0x90
   drm_fb_helper_set_par+0x38/0x40
   fbcon_init+0x3c4/0x690
   visual_init+0xc0/0x120
   do_bind_con_driver+0x409/0x4c0
   do_take_over_console+0x233/0x280
   do_fb_registered+0x11f/0x210
   fbcon_fb_registered+0x2c/0x60
   register_framebuffer+0x248/0x2a0
   __drm_fb_helper_initial_config_and_unlock+0x58a/0x720
   drm_fbdev_generic_client_hotplug+0x6e/0xb0
   drm_client_register+0x76/0xc0
   _RNvXs_CsHeezP08sTT_5rvkmsNtB4_5RvkmsNtNtCs1cdwasc6FUb_6kernel8platform6Driver5probe+0xed2/0x1060 [rvkms]
   ? _RNvMs_NtCs1cdwasc6FUb_6kernel8platformINtB4_7AdapterNtCsHeezP08sTT_5rvkms5RvkmsE14probe_callbackBQ_+0x2b/0x70 [rvkms]
   ? acpi_dev_pm_attach+0x25/0x110
   ? platform_probe+0x6a/0xa0
   ? really_probe+0x10b/0x400
   ? __driver_probe_device+0x7c/0x140
   ? driver_probe_device+0x22/0x1b0
   ? __device_attach_driver+0x13a/0x1c0
   ? __pfx___device_attach_driver+0x10/0x10
   ? bus_for_each_drv+0x114/0x170
   ? __device_attach+0xd6/0x1b0
   ? bus_probe_device+0x9e/0x120
   ? device_add+0x288/0x4b0
   ? platform_device_add+0x75/0x230
   ? platform_device_register_full+0x141/0x180
   ? rust_helper_platform_device_register_simple+0x85/0xb0
   ? _RNvMs2_NtCs1cdwasc6FUb_6kernel8platformNtB5_6Device13create_simple+0x1d/0x60
   ? _RNvXs0_CsHeezP08sTT_5rvkmsNtB5_5RvkmsNtCs1cdwasc6FUb_6kernel6Module4init+0x11e/0x160 [rvkms]
   ? 0xffffffffc083f000
   ? init_module+0x20/0x1000 [rvkms]
   ? kernfs_xattr_get+0x3e/0x80
   ? do_one_initcall+0x148/0x3f0
   ? __lock_acquire+0x5ef/0x2bd0
   ? __lock_acquire+0x5ef/0x2bd0
   ? __lock_acquire+0x5ef/0x2bd0
   ? put_cpu_partial+0x51/0x1d0
   ? lock_acquire+0xec/0x290
   ? put_cpu_partial+0x51/0x1d0
   ? lock_release+0xee/0x310
   ? put_cpu_partial+0x51/0x1d0
   ? fs_reclaim_acquire+0x69/0xf0
   ? lock_acquire+0xec/0x290
   ? fs_reclaim_acquire+0x69/0xf0
   ? kfree+0x22f/0x340
   ? lock_release+0xee/0x310
   ? kmalloc_trace_noprof+0x48/0x340
   ? do_init_module+0x22/0x240
   ? kmalloc_trace_noprof+0x155/0x340
   ? do_init_module+0x60/0x240
   ? __se_sys_finit_module+0x2e0/0x3f0
   ? do_syscall_64+0xa4/0x180
   ? syscall_exit_to_user_mode+0x108/0x140
   ? do_syscall_64+0xb0/0x180
   ? vma_end_read+0xd0/0xe0
   ? do_user_addr_fault+0x309/0x640
   ? clear_bhb_loop+0x45/0xa0
   ? clear_bhb_loop+0x45/0xa0
   ? clear_bhb_loop+0x45/0xa0
   ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
   </TASK>

Fix this by stubbing these macros out when this config option isn't
enabled, along with fixing the unused variable warning that introduces.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Fixes: e2a1cda3e0c7 ("drm/panic: Add drm panic locking")
Cc: <stable@vger.kernel.org> # v6.10+

---

V2:
* Use static inline instead of macros so we don't need
  __maybe_unused

---
 drivers/gpu/drm/drm_atomic_helper.c |  2 +-
 include/drm/drm_panic.h             | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 43cdf39019a44..5186d2114a503 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -3015,7 +3015,7 @@ int drm_atomic_helper_swap_state(struct drm_atomic_state *state,
 				  bool stall)
 {
 	int i, ret;
-	unsigned long flags;
+	unsigned long flags = 0;
 	struct drm_connector *connector;
 	struct drm_connector_state *old_conn_state, *new_conn_state;
 	struct drm_crtc *crtc;
diff --git a/include/drm/drm_panic.h b/include/drm/drm_panic.h
index 54085d5d05c34..f4e1fa9ae607a 100644
--- a/include/drm/drm_panic.h
+++ b/include/drm/drm_panic.h
@@ -64,6 +64,8 @@ struct drm_scanout_buffer {
 
 };
 
+#ifdef CONFIG_DRM_PANIC
+
 /**
  * drm_panic_trylock - try to enter the panic printing critical section
  * @dev: struct drm_device
@@ -149,4 +151,16 @@ struct drm_scanout_buffer {
 #define drm_panic_unlock(dev, flags) \
 	raw_spin_unlock_irqrestore(&(dev)->mode_config.panic_lock, flags)
 
+#else
+
+static inline bool drm_panic_trylock(struct drm_device *dev, unsigned long flags)
+{
+	return true;
+}
+
+static inline void drm_panic_lock(struct drm_device *dev, unsigned long flags) {}
+static inline void drm_panic_unlock(struct drm_device *dev, unsigned long flags) {}
+
+#endif
+
 #endif /* __DRM_PANIC_H__ */

base-commit: bf05aeac230e390a5aee4bd3dc978b0c4d7e745f
-- 
2.46.0


