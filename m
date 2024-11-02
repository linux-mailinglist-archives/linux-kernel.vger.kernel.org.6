Return-Path: <linux-kernel+bounces-393308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 548449B9EEC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 11:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89EEE1C20AF3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 10:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D52016F0EB;
	Sat,  2 Nov 2024 10:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="QGrGgQkM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AMq17S6h"
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FC814D428
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 10:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730543534; cv=none; b=FOfkEGUgQfDvQp9Msf56t7vts2oPyPnc8fvW7L2nng1i+h+/UDK1axG4IsfP3fJgM7R00CE1Y4/ycJS+kKdhHrPTCj8xEL1FEy6wiG+kboDP0VJPSoubKhrO9TrPQofZYiMgcVXyvgYL6NwFxm6FGgU6x7pwGfkZSZ8h1iHxp5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730543534; c=relaxed/simple;
	bh=QZRWkWaLKVHDdoK9xFoH4f3lzJhPSR6YOBOZU00bs/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mMr6bl1gI7aGBHi+elo8z7/lfgVM4KN95WiwLbLyQuHI4ujdp617zq+E14HDohlKyZeigseCXkN+wEqhbh7JSNL5fhV8PKORjyV9Ft0tF2rWR5AASF+vnFr5NQJp7pkoDz9WUdddJvKluGK/JxX9qSJu7PQ+CNCYyqWEphU+SDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=QGrGgQkM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AMq17S6h; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 3493613801F5;
	Sat,  2 Nov 2024 06:32:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sat, 02 Nov 2024 06:32:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1730543528; x=1730629928; bh=nV
	1Nvld4DwKPoCOnM+4433i/xqh2HcIeKXwnwmgbL2I=; b=QGrGgQkMSHBDmpUQAL
	YdmiiVkJVB7b/cCrnQ3/WBVbqJFJTXoLKZiz4/AsugXzgxlyibgFnPrUDRlWfkpg
	V3XF508s55AfYCr94Z0mv8h25wKh0+I3QqkyOvC9+Z+ISsYwYiPiZUt+bciVY502
	jhvt6tlkrQ92ZT2cv2jF6dApMwvtkIdwSKFPI3Fk5QFDOkDpnzV8te1viUPh0y2o
	OFAQRH5rXvXZ/QwJJXwrraYSK5WXe785H9JQv0Ca9NxmnupuqOKxZbsETLo8Q8nh
	E036dAs+nfGI7PQ8EAM3sYsEzsQTBV0Nygzbk/QPEXLDjOARbr06Ne91OyaXWj4D
	kdHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1730543528; x=1730629928; bh=nV1Nvld4DwKPoCOnM+4433i/xqh2
	HcIeKXwnwmgbL2I=; b=AMq17S6hXEq3chROLsxEp1Btb6Yz+R1R/XTl3wxkwygg
	WmWRxTzNiQU7FXdzsbbDV5O4nGAf8r+/dKEckZU+eYaYg+Y4xmTe+iX0VoKDC1UU
	XB3UEjYBoc95/gG7Dmu1UkPyTLpYKk/wge4RBRVnAMD2EjvlH9RGZSwb/9yu9SpK
	lgkzUgTjU5soXwLjberzOMeHNWcG5LQoSXNve2Cx6Smm4vRSEgeQL4iPYVlaLPyi
	dAtrdYKJnlSnru2R0lansm3Xwvd3iwYwfMUASX66vE+HL7vy0FXtxfWTQjOZEuep
	rKh8hFLS1T9FWmsK0cogPaJIF/PlmxK6hw+hognBBw==
X-ME-Sender: <xms:p_8lZ45tcXCqPBnh3BblffkqDlDFcSQEcQsFf1EQxLwDOv9OshZArw>
    <xme:p_8lZ55VlzPLGpm6Sw-1mngSfMcZsQf-ma0oqxdFAtpu5eauPZLa6m2euyWNUBlv5
    nUAh88hU9uY8QegTw>
X-ME-Received: <xmr:p_8lZ3fAY9cnZbvTqx2lmjlcsbfbVHALNl_aH_yCmRzSfKXNB5ul1HX9FZJQ1xWQmi3rVOdFw7xziQ_mdpyHUCSuiU8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeluddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecu
    hfhrohhmpeetlhihshhsrgcutfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtf
    frrghtthgvrhhnpeevgeetvdefhefgkeeigfdtgfeiteeiieekteefteeitedtheefleei
    gfekjeetvdenucffohhmrghinheprhhsthdrrghtpdhkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehhihesrghlhihs
    shgrrdhishdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepsggtmhdqkhgvrhhnvghlqdhfvggvuggsrggtkhdqlhhishhtsegsrhhorggutgho
    mhdrtghomhdprhgtphhtthhopegsrhihrghnqdgsthdrthgrnhessghrohgruggtohhmrd
    gtohhmpdhrtghpthhtohepvhhishhhnhhurdgurghsrgessghrohgruggtohhmrdgtohhm
    pdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:p_8lZ9JI-zh56mXXbdHrFQJZH5F0fV8TKo2Hx7dWkqSzHNo2JEKCdA>
    <xmx:p_8lZ8JxRoDHea-zTNxkZSxf8pMpIz3G9xfqDwEkQv4IaHebbh67-w>
    <xmx:p_8lZ-xX8YNJNvP4knaASobRjxkykyjRbQ53_a6t2cgi--Z12CgERg>
    <xmx:p_8lZwIJ7ioMLHsb-y4NKL84HFDaLaXqsbLvk8F_5le29uhR_smsvw>
    <xmx:qP8lZ2gBy-qHqutej8LAGZTEKrAwcxsxntFfIrqh0nOgOaoyPiogg_K3>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Nov 2024 06:32:07 -0400 (EDT)
Received: by sf.qyliss.net (Postfix, from userid 1000)
	id 13F6F151096EC; Sat, 02 Nov 2024 11:32:05 +0100 (CET)
From: Alyssa Ross <hi@alyssa.is>
To: Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] VMCI: fix reference to ioctl-number.rst
Date: Sat,  2 Nov 2024 11:30:53 +0100
Message-ID: <20241102103052.7425-2-hi@alyssa.is>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There has never been an ioctl-number.h — this must have been a typo
for ioctl-number.txt (which later become ioctl-number.rst).

At the time this comment was written, the note didn't actually end up
appearing anywhere, but I fixed the omission from ioctl-number.rst in
0a8e4dc1d353 ("Documentation: ioctl: document 0x07 ioctl code").

Fixes: 20259849bb1a ("VMCI: Some header and config files.")
Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
v2: added patch description.
v1: https://lore.kernel.org/lkml/20240731111302.3072858-2-hi@alyssa.is/

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

base-commit: 11066801dd4b7c4d75fce65c812723a80c1481ae
-- 
2.46.0


