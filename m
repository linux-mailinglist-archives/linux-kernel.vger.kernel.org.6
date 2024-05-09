Return-Path: <linux-kernel+bounces-174707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C62958C1340
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 18:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63BDCB2116A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9038C0B;
	Thu,  9 May 2024 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="CqCwZqh9"
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D6B4C70;
	Thu,  9 May 2024 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715273396; cv=none; b=qRXfPCn0gQfsiXvAibHiz6g+vzRETitmuPCJ58kY/yPd/d/mFIUCukER3qBB12lGDZUP9VWY9+3PbYAGTvxJ0FcQEe8cXVR6+c0rfIrLaN4pP9e8exXnZHxgJo/OCWA65481HNGWxCpalLRje2gwAgwQ3rYfi/uCSII35GfIt80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715273396; c=relaxed/simple;
	bh=Gf9y6jAuMcgqo9Gd+TKKg5IoxCdtOXzzseeLVLgbN/E=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=n7m6qN4FT1Hta53QVf2JoX/yCUBGg+5SnFCWG2dL3j5Z+29HyYJZcPwdz18fldfcLhdvNKeRutoIcCsfEXq2au1b6g/n+1L/OVlo9XGSwmEHvnnpmGQIU/H/wX/gFYOZ97FJjywEbGNB3FPCs9FNjMnTHJDQeD2xy2c2uva5LdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=CqCwZqh9; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1715273380; x=1715532580;
	bh=C60PPXrDiM6US9HUzSb1J44PAIcjYzqF9scPyqWaHcQ=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=CqCwZqh98z416mS2XCKqzmuiyUHMyT0Y7GpREyNWr0KK8SXQJj9rtR148itRyPaUx
	 cNn6GMjx1gIS5AuK1/E/BQIgB17tmnazOQypBfHRiWndN5EdDBtJXsBtPYHAX1/dkH
	 vBkfA2BY6/lzqcHw8SssMw2/OqQjg/klxkHNqMPPnQFWejgh84NHN9E/3Z3w5PteyL
	 IZwHYMZ+HcW/ZpuBxPW52JQmk2dVu0QJooQA4E9AOeLwsorToK0oRYk8DAx4i1f18Z
	 7vMqY2W0hBfb/SAuOxtIck6yLIQiX5PB+q3AIk8FvstCPM6O0SRcOTfRcUR8vS1w7/
	 kyrDRiw9GdxLw==
Date: Thu, 09 May 2024 16:49:34 +0000
To: Hans de Goede <hdegoede@redhat.com>, =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
From: bcfradella@proton.me
Cc: Ben Fradella <bfradell@netapp.com>, Ranjan Dutta <ranjan.dutta@intel.com>, Yifan2 Li <yifan2.li@intel.com>, Jonathan Yong <jonathan.yong@intel.com>
Subject: [PATCH] p2sb: Don't init until unassigned resources have been assigned.
Message-ID: <20240509164905.41016-1-bcfradella@proton.me>
Feedback-ID: 52522960:user:proton
X-Pm-Message-ID: b9b1474f879f010a3fa2db3d7408df99edc412c6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Ben Fradella <bfradell@netapp.com>

The P2SB could get an invalid BAR from the BIOS, and that won't be fixed
up until pcibios_assign_resources(), which is an fs_initcall().

- Move p2sb_fs_init() to an fs_initcall_sync(). This is still early
  enough to avoid a race with any dependent drivers.

- Add a check for IORESOURCE_UNSET in p2sb_valid_resource() to catch
  unset BARs going forward.

- Return error values from p2sb_fs_init() so that the 'initcall_debug'
  cmdline arg provides useful data.

Signed-off-by: Ben Fradella <bfradell@netapp.com>
---
 drivers/platform/x86/p2sb.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/p2sb.c b/drivers/platform/x86/p2sb.c
index 3d66e1d4eb1f..1938a3ef9480 100644
--- a/drivers/platform/x86/p2sb.c
+++ b/drivers/platform/x86/p2sb.c
@@ -56,12 +56,9 @@ static int p2sb_get_devfn(unsigned int *devfn)
 =09return 0;
 }
=20
-static bool p2sb_valid_resource(struct resource *res)
+static bool p2sb_valid_resource(const struct resource *res)
 {
-=09if (res->flags)
-=09=09return true;
-
-=09return false;
+=09return res->flags & ~IORESOURCE_UNSET;
 }
=20
 /* Copy resource from the first BAR of the device in question */
@@ -220,16 +217,20 @@ EXPORT_SYMBOL_GPL(p2sb_bar);
=20
 static int __init p2sb_fs_init(void)
 {
-=09p2sb_cache_resources();
-=09return 0;
+=09return p2sb_cache_resources();
 }
=20
 /*
- * pci_rescan_remove_lock to avoid access to unhidden P2SB devices can
- * not be locked in sysfs pci bus rescan path because of deadlock. To
- * avoid the deadlock, access to P2SB devices with the lock at an early
- * step in kernel initialization and cache required resources. This
- * should happen after subsys_initcall which initializes PCI subsystem
- * and before device_initcall which requires P2SB resources.
+ * pci_rescan_remove_lock() can not be locked in sysfs pci bus rescan path
+ * because of deadlock. To avoid the deadlock, access P2SB devices with th=
e lock
+ * at an early step in kernel initialization and cache required resources.
+ *
+ * We want to run as early as possible. If the P2SB was assigned a bad BAR=
,
+ * we'll need to wait on pcibios_assign_resources() to fix it. So, our lis=
t of
+ * initcall dependencies looks something like this:
+ *
+ * ...
+ * subsys_initcall (pci_subsys_init)
+ * fs_initcall     (pcibios_assign_resources)
  */
-fs_initcall(p2sb_fs_init);
+fs_initcall_sync(p2sb_fs_init);
--=20
2.43.0



