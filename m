Return-Path: <linux-kernel+bounces-327308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 537FB9773E8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 23:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F30811F255ED
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982181C244F;
	Thu, 12 Sep 2024 21:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HuQWY+Dp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A918B1C243C
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 21:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726178025; cv=none; b=a4m/K0x3vRvx0o5aKbrAAg4KuvAykfWViA4/tsswY5TFav5nkc5kujiBCVcJihMom/8edVofdc1bcJyyA3dqJvysMMTUjBp0poUiZZCauD/3qpdiM2fE/jbnqlYO6EAYi+dXEchaKZF8BX8HlOrzs5Y6tBUnqeRyl9tZF99V4i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726178025; c=relaxed/simple;
	bh=SSD3CXbSmy5PMYo/XtCxFdAXqVnofETmogiXlkTiyWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=icoCi6X27xbyEO/WrCBPOnESRg+g3BqhzLr7NSl15njKTKkjHN2BVZd4ySAXjZBOgMi89JGVuglwM8d6nmB+NQgTcNTCqs1Wvc5GpCZYssNZ3xS4d2dxtQNJbnsIkB+939I/S/2/v32NEgNTRvod0MAA37hyDmJoJfbfbA5J/1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HuQWY+Dp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726178022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kDBigamses4Q63edfd4mL7Y1CXoU8nV/VK3fhNy/pi4=;
	b=HuQWY+Dpqpefn0PiV3M2ZFUqqt5mSZT9YkvmQSqtk9zr6QKApBfDRKsSmABDvhMbhpCj91
	Lnla8EJpcKD8sHNWZ35LRXCb7XwgpEc1iwJW0aDwZ+l9boykAt8qu/t8eWz3+T/epdHjHs
	A/9t67RiGXt01fAd9SivLAepSaKnjWQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-mKut3Ej0MQmCAhVoEnXrfg-1; Thu,
 12 Sep 2024 17:53:37 -0400
X-MC-Unique: mKut3Ej0MQmCAhVoEnXrfg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C5D8019560B4;
	Thu, 12 Sep 2024 21:53:36 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.8.21])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 49ACB1956096;
	Thu, 12 Sep 2024 21:53:35 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: helgaas@kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	delineshev@outlook.com
Subject: [PATCH] PCI: Mark Creative Labs EMU20k2 INTx masking as broken
Date: Thu, 12 Sep 2024 15:53:27 -0600
Message-ID: <20240912215331.839220-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

As reported in the link below, a user indicates this device generates
spurious interrupts when used with vfio-pci unless DisINTx masking
support is disabled.  Quirk the device to mark INTx masking as broken.

Reported-by: zdravko delineshev <delineshev@outlook.com>
Closes: https://lore.kernel.org/all/VI1PR10MB8207C507DB5420AB4C7281E0DB9A2@VI1PR10MB8207.EURPRD10.PROD.OUTLOOK.COM/
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---

FWIW, a web search has a couple other hits of users experiencing
problems trying to assign this device which seems to corroborate this
most recent report.

 drivers/pci/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index a2ce4e08edf5..c7596e9aabb0 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3608,6 +3608,8 @@ DECLARE_PCI_FIXUP_FINAL(0x1814, 0x0601, /* Ralink RT2800 802.11n PCI */
 			quirk_broken_intx_masking);
 DECLARE_PCI_FIXUP_FINAL(0x1b7c, 0x0004, /* Ceton InfiniTV4 */
 			quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CREATIVE, PCI_DEVICE_ID_CREATIVE_20K2,
+			quirk_broken_intx_masking);
 
 /*
  * Realtek RTL8169 PCI Gigabit Ethernet Controller (rev 10)
-- 
2.46.0


