Return-Path: <linux-kernel+bounces-546665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2693AA4FD78
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 573381685A6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB002233701;
	Wed,  5 Mar 2025 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="qGvzD8SY"
Received: from ksmg01.maxima.ru (ksmg01.maxima.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2F7230274
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 11:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741173659; cv=none; b=AI8Y7nhsSlJVrTzn8Yg6M0yFGLFtWxm0DmyZ5kdmSBf/qyXI0f3XJ4NMJ4RGQ0JxAZYuah2E1VNoYf/2X5ouhGTCYB1BYNW7jeestS15si/H8DVXjCnoCuHE9D2VGwZg7CuJ/Xw+flLnDvmAOuWMBakOdDQ8hogejYvwId8LcS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741173659; c=relaxed/simple;
	bh=jFhZ/zyUSVLSaQigU27srs+qbHtTWp1g3/LyJ3cpEHI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XMc5OnCnqzwoL45lskMDEbTgqRMvHMciU1KkyVfExUp6h3LPdv1DnDUu9408kIp9uzbQ7b0WEBUfkU8BPzxlEMpjGyvMta3voFyTpr1CQ+x7e+KBLDhBKajMw4KSClbyFnlpUvBFTz1/0JoPsvcsiacXMOo6jDvnSo7Hn09NfMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=qGvzD8SY; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id A3D94C001C;
	Wed,  5 Mar 2025 14:20:52 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru A3D94C001C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1741173652; bh=n/KI5uq203cxGaXCTBoOYd74pMZghtHUgweaiwsP5CM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=qGvzD8SYK1o2oZhlbWPxGIX3jPXDzxyVFHTOdtIIKrdYnn1B2VjCnJjJemm7i6BwK
	 YleXo1DnHkWlFt3rC3xOwG6/lPtOXewRVCHYOvw95Nb2/omM+JAcgaxnvGMwWRgC6t
	 MM3VRWK/e0j9S+x/Km5WKtazi/H/XFh6nhqbGOxI6FdPR++bkVBe9Fp5S6LinUEOXO
	 F+OfYIotAj2hH9ymrNG9yW8+b/+cVz6265dRzDwMSdF8KIFre+onEPftpP0Oh2qSC1
	 5A/r033cWvOmyrnSJmfqmdX1Q+5YaycBeK9e3aSFwpjX4V7CRB1bumctKCIzYBGtMa
	 toJJP97cr/DbA==
Received: from ksmg01.maxima.ru (autodiscover.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Wed,  5 Mar 2025 14:20:52 +0300 (MSK)
Received: from saturerate.maximatelecom.ru (10.0.247.123) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.4; Wed, 5 Mar 2025 14:20:50 +0300
From: Ivan Abramov <i.abramov@mt-integration.ru>
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
CC: Ivan Abramov <i.abramov@mt-integration.ru>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas <helgaas@kernel.org>, Sinan
 Kaya <okaya@codeaurora.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] drm/gma500: Add NULL check for pci_gfx_root in mid_get_vbt_data()
Date: Wed, 5 Mar 2025 14:20:37 +0300
Message-ID: <20250305112038.43852-1-i.abramov@mt-integration.ru>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mt-exch-01.mt.ru (91.220.120.210) To mmail-p-exch01.mt.ru
 (81.200.124.61)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: i.abramov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, mt-integration.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;81.200.124.61:7.1.2;ksmg01.maxima.ru:7.1.1, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 191499 [Mar 05 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/03/05 09:56:00 #27614020
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

Since pci_get_domain_bus_and_slot() can return NULL, add NULL check for
pci_gfx_root in the mid_get_vbt_data().

This change is similar to the checks implemented in mid_get_fuse_settings()
and mid_get_pci_revID(), which were introduced by commit 0cecdd818cd7
("gma500: Final enables for Oaktrail") as "additional minor
bulletproofing".

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: ba99d8348864 ("drm/gma500: Deprecate pci_get_bus_and_slot()")

Signed-off-by: Ivan Abramov <i.abramov@mt-integration.ru>
---
 drivers/gpu/drm/gma500/mid_bios.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/gma500/mid_bios.c b/drivers/gpu/drm/gma500/mid_bios.c
index 7e76790c6a81..cba97d7db131 100644
--- a/drivers/gpu/drm/gma500/mid_bios.c
+++ b/drivers/gpu/drm/gma500/mid_bios.c
@@ -279,6 +279,11 @@ static void mid_get_vbt_data(struct drm_psb_private *dev_priv)
 					    0, PCI_DEVFN(2, 0));
 	int ret = -1;
 
+	if (pci_gfx_root == NULL) {
+		WARN_ON(1);
+		return;
+	}
+
 	/* Get the address of the platform config vbt */
 	pci_read_config_dword(pci_gfx_root, 0xFC, &addr);
 	pci_dev_put(pci_gfx_root);
-- 
2.48.1


