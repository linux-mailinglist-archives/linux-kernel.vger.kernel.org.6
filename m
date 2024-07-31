Return-Path: <linux-kernel+bounces-269065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C6E942D05
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAD361C237EA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5656E1AD3F9;
	Wed, 31 Jul 2024 11:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="rrgTglXU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CeGFb1BO"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560BE1AB531
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 11:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722424468; cv=none; b=NIYvpXhx9Y2TtrRQg74QuNtuR8zSFfy7P41GxZAST4/kaMsOCZawyA3ZU9X5RKAg+mIqWs2D368BQcD+ZrZXSzES5Bv07HwZSy5OHDXIM+FXSK12CaqqIj2HrrCbGLC9ZPLTOSvtYAEJqEdmbKCw66Y2I4sJxJPBQk6+egtsyzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722424468; c=relaxed/simple;
	bh=DOBSWQTIKLSmnSD9RKYcOZOaTVLgLR1j48z8auY6zK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hW2vKvtyetv9OHCWq1ifSLdZOWx2eCmk4+zAadQDWrMMfDHbA9AuuuRbaXKaFljohhB17DjAjyfhm5eub1lzwQ86B/F0428kESKUdYOmN5ociySYfIiaZlUZIatXXONhfBsWQjHArCWnASkH/bhcJ+lF47V3INe1Pf5oSJmZZ8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=rrgTglXU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CeGFb1BO; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5AB041146E48;
	Wed, 31 Jul 2024 07:14:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 31 Jul 2024 07:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1722424464; x=1722510864; bh=eCXBIyPqwvOILLDz8424S
	c020ymYIO3Ie5hmMKC2phM=; b=rrgTglXUYMVSUbnPE7ELCuyzTjL+O3UDSFQ16
	R91lC5MyfA3W+THZ40f2c6DoOA1hYF2zAUBl59+joGQ3gMesTOi2pTAUivmD+erq
	cH6URmpA2xX4DwOiwSTQSFn7gqqe/2kxExYb0K+PnYU1EJZ6NfCvuXGNGDtUlcCj
	jyniasmw/5pvkCnBdp3NYH+V3SkMdxML/wHHH12TCvLNKpwVL2b52ZUSxENy1BXm
	2KYQejbZEu/N1RRpElYtB7pl4nZVL8ZBB4dYcoJ/Dgl+1K93KlRirkflA2CL9qbE
	d8vTf5zrqdq56BSCzOHugNXV/mVs7vC0S6StWk/WmrFHph7KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722424464; x=1722510864; bh=eCXBIyPqwvOILLDz8424Sc020ymY
	IO3Ie5hmMKC2phM=; b=CeGFb1BOEsMehEZ6Z7VTnijgihmQdoqweNVj1vsVL85l
	p1JDJQE3DyWRb8DbnFYXq9JHQpQn/M1ihSzB702r/A0JF33e3kqPIuE2qzr6EypP
	25llKlfuwJX2GMs/NGFk/yUDlfuycUGHnjkrzG3knUWviIgAwMf0TedeLg5n53rx
	UNZDR/5cyRpZUi73LdZdo2ZY0FnXJPR1M0iSUchjUeAcimuctzNHqEJoLvU9PviF
	G7nsH2NPUh2kt0MgDbIDlJOYbX/R2RPKc2Gp4PXlcOJxZyZdXt3VlnI9MjX/W3iz
	7LwqoLd0gQC9auNjpKVT26H4PEqnuCP2n9Kxm1GBQA==
X-ME-Sender: <xms:jxyqZoOfJeHOvQ9HIm28hdXF18nGAOecgnfMIegOr5gdbZwowVIAeQ>
    <xme:jxyqZu-4DpmBfNtjjQbytghw6Ks6QoATq5glqg21l5QdmHmsAFC1AE3Jh9VTv2ULh
    4Oq11vRcqRw6HGlHw>
X-ME-Received: <xmr:jxyqZvTPHxt78mhf7cfQMLSozCrST4l9CpsYLzBI26C0qFHuIItrjWdyC5wxwQCZ6pc_C4km8dAGRXFN6lzk4y3ey3QH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeigdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetlhihshhsrgcu
    tfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpeeufeeivd
    ehffevgeeijeejvefgjeejudevkeffieevueevvdetvdfhleeiuedtgfenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhephhhisegrlhihshhsrgdrihhspdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:kByqZgsvNLMtlCF-hdna_r9iXaDgZMFLN9p23dKJx5_ymny7itnAHA>
    <xmx:kByqZgeu41PUG8ah4N3uKBrZIcmCocaSP7F1wjHSHRmoTaNh1gX1GQ>
    <xmx:kByqZk3_pUcHTS9XYzyzEEIWYCeCFI4cRIXCZI-zVkNAU8ugRidGTQ>
    <xmx:kByqZk9zpjhALZMBp2ZljSjv4eFxgSubYPTq_3BCdSwu2F4YifJVFA>
    <xmx:kByqZlFiNV9W9ZB0-FWWgYlXcFPEcD59H_zGuCxSGkT1yNnEb02FNlVD>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jul 2024 07:14:23 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id E5C6C3A6C; Wed, 31 Jul 2024 13:14:21 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] VMCI: fix reference to ioctl-number.rst
Date: Wed, 31 Jul 2024 13:13:03 +0200
Message-ID: <20240731111302.3072858-2-hi@alyssa.is>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: 20259849bb1a ("VMCI: Some header and config files.")
Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
You may notice that ioctl-number.rst does not actually mention code 7 — 
I've had a separate patch accepted to do that:

https://lore.kernel.org/all/20240725171120.12226-2-hi@alyssa.is/

 include/linux/vmw_vmci_defs.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/vmw_vmci_defs.h b/include/linux/vmw_vmci_defs.h
index 6fb663b36f72..244c5ff412e1 100644
--- a/include/linux/vmw_vmci_defs.h
+++ b/include/linux/vmw_vmci_defs.h
@@ -431,11 +431,11 @@ enum {
 	((((_p)[0] & 0xFF) << 24) | (((_p)[1] & 0xFF) << 16) | ((_p)[2]))
 
 /*
- * The VMCI IOCTLs.  We use identity code 7, as noted in ioctl-number.h, and
- * we start at sequence 9f.  This gives us the same values that our shipping
- * products use, starting at 1951, provided we leave out the direction and
- * structure size.  Note that VMMon occupies the block following us, starting
- * at 2001.
+ * The VMCI IOCTLs.  We use identity code 7, as noted in ioctl-number.rst,
+ * and we start at sequence 9f.  This gives us the same values that our
+ * shipping products use, starting at 1951, provided we leave out the
+ * direction and structure size.  Note that VMMon occupies the block
+ * following us, starting at 2001.
  */
 #define IOCTL_VMCI_VERSION			_IO(7, 0x9f)	/* 1951 */
 #define IOCTL_VMCI_INIT_CONTEXT			_IO(7, 0xa0)

base-commit: e4fc196f5ba36eb7b9758cf2c73df49a44199895
-- 
2.45.2


