Return-Path: <linux-kernel+bounces-312690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAB99699DA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95DF9B25DC3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E4319F42C;
	Tue,  3 Sep 2024 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="cSLMPLFk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pkaA3Df1"
Received: from pfhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC3A1A0BED
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 10:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358529; cv=none; b=YxBd3TTLcK0vEixd64OuaA9Ihxso0P/0NDcUP4jqfMONkAIHSeni28p9jeUTvFffXn7GRtALaTmpa5H9TjAqk3zeSYfvn/IwvH/6/dL5rPDBivKkcnZonUHvdwokbp+pU9h0f/uDx9JlVbgNRYDIXs57Lj9lRuvklqsX4/emDoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358529; c=relaxed/simple;
	bh=G/PvEY3igPVstOiobgTRHCXGTmIr9SML5otHwVdoxFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lM84NYM0E6sZM3uXVi4E0rSx26Ee7Aapw9Kh3e1uTf3/oAksje2A07yk5D1vdbXT0rJTZBZNCi6DUIbS9uGwlHRbSRt8ani1s7vPOtkwK0RLmAE7i77vr0BC5dASMmOsaKD8ALr/E25mBgBfRLYuQ4t+TcWaiivFg85bGCNLEmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=cSLMPLFk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pkaA3Df1; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EDEE91140100;
	Tue,  3 Sep 2024 06:15:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 03 Sep 2024 06:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1725358526; x=1725444926; bh=hievqMDYxf
	TONiyF8th4rDfFHnRvVJ8WTM3zZAohKSo=; b=cSLMPLFktmplNGaHNwoeAaYyZc
	S6Um4dWP4cQnpmmUIoPHX2JBBGN92pXhMIaYEcrJwWJ2A0p0x2BJeqYoF3BmJHhz
	Ae6cu0Nemawze80s2gSpQf899n4Rpf03/3odFBiao9V41m3JrIZSccSFztWBXi0L
	bhmyiKFWmwYf6+LaHUFMSoEu2PNqV50SLWdHMj5zk1QgOrZyrlsYIGAqgi7c3E1e
	6gRmv+tvcmlpvkrbrtdf8kAxGWP4SauJ0N9yMzLAw0S85e7MI87svgkf9o+eGykB
	+lBMh1/HloTZuwok+GH2K69NRiuqAKTI0GOCo+mK8abW695Ue7hA3FyduTGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725358526; x=1725444926; bh=hievqMDYxfTONiyF8th4rDfFHnRv
	VJ8WTM3zZAohKSo=; b=pkaA3Df1Lb6hzf8S27UsEXHjrwjb74RrVzs2H4PUn5kY
	c/xFT5bP/9IiolwQbfGcx0h7DL72gtJ1hvDQ6+h643drKDf2bwmtS0skIPRcyawd
	azC0u0upH4HOShHMxFdWQQYHU1srj9k0KZWwVobM9KrtV8AeGoarVzSlCvlWWSbC
	qA0LbUO3rhrxjDTSxDtz5Xuaf5sz3ZnEQQUW9kfmsDCHK0q2ldVsCeL+KDnflwOD
	EBolFXi6ss7nsECjIiE782d1R7x4+iYbfoGc7wRBHKomK1T/bXIKcr6KyF5ab3/F
	2hqL1SRXDjcM1SrgKtuqIhpttZxLthFUkxzRJUmrOg==
X-ME-Sender: <xms:vuHWZj0F5aBvNcVcBgB0Uv6PuYDOhx-RsVj25bgY0ajTB-4C9nr10Q>
    <xme:vuHWZiElakYQcKiCjHVwBcfQQ3k9Hut8vCFdp30xIsVksoJO7OHmAc2f5YaHOUea0
    2UJzKlKPVfGMX0ocs4>
X-ME-Received: <xmr:vuHWZj7NWSjty0DeozbvaolcsXvCQ9dzEBa_Dk0dmM3j6nKqMh_5umm23SAFpT3okp6aN-nCOGV13PHjwsq9tc71uJIE7Hu5C9E5bkFqUlVoGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehhedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohht
    ohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtth
    gvrhhnpeffvdeuleffveekudfhteejudffgefhtedtgfeutdfgvdfgueefudehveehveek
    keenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqd
    htrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgtphhtthhopedvpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigudefleegqdguvghvvghlse
    hlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhugidq
    khgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:vuHWZo2DrRq6ozn1huYI-HqipG1JF88pAn38hxceFwhHAQ65E_Zekg>
    <xmx:vuHWZmF1UQiJdvOCCCkDNgbOSlIKVZG2l71t7rOnBnbsf0SWmMkY5w>
    <xmx:vuHWZp-8do5SBL04WzLxSbH04w7t8CZH25z900p3U34V9NTHj8hx_g>
    <xmx:vuHWZjm7No31pM5IOJpBWnhabwQAK6BOeL61piPIpci5yUA2Mz5uGA>
    <xmx:vuHWZrRtN51pSlboahwEvWXUenjKXPQQjr4tywg84PeHpKL0_YboUljL>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Sep 2024 06:15:25 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] firewire: ohci: obsolete direct usage of printk_ratelimit()
Date: Tue,  3 Sep 2024 19:15:23 +0900
Message-ID: <20240903101523.317110-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A commit 77006a0a8282 ("ratelimit: add comment warning people off
printk_ratelimit()") has already deprecated printk_ratelimit().

This commit uses alternative functions to obsolete its usage.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index e662dc30c21f..3930fdd56155 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -2268,13 +2268,11 @@ static irqreturn_t irq_handler(int irq, void *data)
 		reg_read(ohci, OHCI1394_PostedWriteAddressLo);
 		reg_write(ohci, OHCI1394_IntEventClear,
 			  OHCI1394_postedWriteErr);
-		if (printk_ratelimit())
-			ohci_err(ohci, "PCI posted write error\n");
+		dev_err_ratelimited(ohci->card.device, "PCI posted write error\n");
 	}
 
 	if (unlikely(event & OHCI1394_cycleTooLong)) {
-		if (printk_ratelimit())
-			ohci_notice(ohci, "isochronous cycle too long\n");
+		dev_notice_ratelimited(ohci->card.device, "isochronous cycle too long\n");
 		reg_write(ohci, OHCI1394_LinkControlSet,
 			  OHCI1394_LinkControl_cycleMaster);
 	}
@@ -2286,8 +2284,7 @@ static irqreturn_t irq_handler(int irq, void *data)
 		 * stop active cycleMatch iso contexts now and restart
 		 * them at least two cycles later.  (FIXME?)
 		 */
-		if (printk_ratelimit())
-			ohci_notice(ohci, "isochronous cycle inconsistent\n");
+		dev_notice_ratelimited(ohci->card.device, "isochronous cycle inconsistent\n");
 	}
 
 	if (unlikely(event & OHCI1394_unrecoverableError))
-- 
2.43.0


