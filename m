Return-Path: <linux-kernel+bounces-366105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE9499F0F0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1FA22831DF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089311CBA1B;
	Tue, 15 Oct 2024 15:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ah+u9Blw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF711CB9E7
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729005723; cv=none; b=IEG7sO9LP88DDZkSCoC2wWcTG6mUKJRKbsiZZeNWoE4Nwk7e+BdPVhoJEb1rW1OEQK9J7MHW4rjZpT5TEaqYkmh8NjMwdC6Yh+GWbR4hKyTl6zUf1CBaXL/lH35HTg/8vOa8idphyjEogRabpGGqWpT+rLgjn1ZZGmuMqOlPKwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729005723; c=relaxed/simple;
	bh=yVHQVnLXAPgaiT2VfMOI4wCdmR3MlSS3dJqOw76r070=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IS3+t7RNKnTrHp3Komv09DhLIz5NC7YW2sBRJmDbd2aeaiv5Un+8pbDibpFOi7+kmP/4R51/rvBTJxYXoSGPYJLMLWkFtIsAWOfRzxlYHD/4wytRsdU6XHxr2emTjf8SuefEFOxmRdNe4weDKz9vglG+CEpTJVsxTZzt9UQHx+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ah+u9Blw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B9FC4CEC6;
	Tue, 15 Oct 2024 15:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729005722;
	bh=yVHQVnLXAPgaiT2VfMOI4wCdmR3MlSS3dJqOw76r070=;
	h=From:To:Cc:Subject:Date:From;
	b=Ah+u9BlwEeMsK35/m9vXnwHg5M6rbCCwJT0FOQAOBL1y2lckeGspKXg9+tYfRmY0T
	 OGwd0vylfg3ZPeMYfCvtBY6TvbXQMm2r3B8UtLJ/AmqXgL3IntrvKqTYp0f1HrMUEl
	 HKT5RhMvWTrJmkAh3ssPnPo7YI/XVHQl+/wFT0qWR3E7HNwX+uq7Sr6ncmdR0XLjGK
	 MwUemd1PrPQOUVpyImomxNMLtrDeNBZ3G7cfSDcIPlVaJ+sa29ntuuSbjGeP0c8zsC
	 pVmnYjUqLS8wiq9UwfIEL50k7q7lOeacvJmNKxXovuY14/WkK7emdK5hu5Bh6mHbZ+
	 5ldYgiA63Z30g==
From: Arnd Bergmann <arnd@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Maxime Ripard <mripard@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Imre Deak <imre.deak@intel.com>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i915: fix DRM_I915_GVT_KVMGT dependencies
Date: Tue, 15 Oct 2024 15:21:48 +0000
Message-Id: <20241015152157.2955229-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Depending on x86 and KVM is not enough, as the kvm helper functions
that get called here are controlled by CONFIG_KVM_X86, which is
disabled if both KVM_INTEL and KVM_AMD are turned off.

ERROR: modpost: "kvm_write_track_remove_gfn" [drivers/gpu/drm/i915/kvmgt.ko] undefined!
ERROR: modpost: "kvm_page_track_register_notifier" [drivers/gpu/drm/i915/kvmgt.ko] undefined!
ERROR: modpost: "kvm_page_track_unregister_notifier" [drivers/gpu/drm/i915/kvmgt.ko] undefined!
ERROR: modpost: "kvm_write_track_add_gfn" [drivers/gpu/drm/i915/kvmgt.ko] undefined!

Change the dependency to CONFIG_KVM_X86 instead.

Fixes: ea4290d77bda ("KVM: x86: leave kvm.ko out of the build if no vendor module is requested")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/i915/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
index 46301c06d18a..985cb78d8256 100644
--- a/drivers/gpu/drm/i915/Kconfig
+++ b/drivers/gpu/drm/i915/Kconfig
@@ -118,9 +118,8 @@ config DRM_I915_USERPTR
 config DRM_I915_GVT_KVMGT
 	tristate "Enable KVM host support Intel GVT-g graphics virtualization"
 	depends on DRM_I915
-	depends on X86
+	depends on KVM_X86
 	depends on 64BIT
-	depends on KVM
 	depends on VFIO
 	select DRM_I915_GVT
 	select KVM_EXTERNAL_WRITE_TRACKING
-- 
2.39.5


