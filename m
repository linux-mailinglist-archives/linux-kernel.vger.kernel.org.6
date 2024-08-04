Return-Path: <linux-kernel+bounces-273847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6A5946EE3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 15:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE7881C2112F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 13:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB03A12D20D;
	Sun,  4 Aug 2024 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="jsgF6qVn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ic0zytln"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7456A8CF
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722776562; cv=none; b=S99YtDRqUbd+TGUepjYPsUzyWHjjST6z1IAAaqgGtuVwJCFknrrZjaYQt6zGc+O3uFEopBBQISAwB6b90fewvZrHAnWigN3goLaVQPA11QBvQH2cJxV82T4qvy6lf7RofBuSZoCsYE9CO4Fa9Ty3fouLpfEUurqmIJi8tEXBwjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722776562; c=relaxed/simple;
	bh=0zT4ELUdypbLDPtYPoNIq0nN4q+2KRKcNt9sf1SBc84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VVkeczvl6DW3r1p9b2BXLRM1FR33+cn7/ilPm+yE1AJI0Ew+zqDW3buQf9D7W8mzzmVOEDusTJ24cPQIgCIlxAoroGNpL0wWkhuE0wcgGD7jqoqqohSbH7fvE53vgMzE1rjB3No/x88UC6NSN6es6ZvQ0S8kPiO9UTGItbtkl1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=jsgF6qVn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ic0zytln; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 55AAA1388062;
	Sun,  4 Aug 2024 09:02:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 04 Aug 2024 09:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722776560; x=
	1722862960; bh=riXT/ZPaI3yITLXofYuDWzvYYTW64WraJqRL8dIk1u8=; b=j
	sgF6qVnFxJ9MLP3LeORc+R1PNncoIFM9zgGsyGdkUPE+VW3VN1Ja51EWMWpxnSn3
	pDNsVO6yLFDl2ScXZEHuzZnSfv2ykIZDHijt2kW6/QsIb9Fx/D0OY98NNIWykKbh
	iPV2Czbb6d2OuGdw9st6R4DiVm3pT3bEsk8nu5BNfyWESaER8n/MhUKE3+JsA337
	eLlFgs/qkmBL3nYZQnzWFtwIRDhQTFO8IRC5NnIKPBDYqjeX2FbfSx1hB+Yieg5P
	XR6e4O4m0fIu386ZteCH6GA0fzCxMDoXoUnDbaADxMsVVaAoheReARD3XBkuGb+M
	E073eCAh4cc6dHG4Z4P1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722776560; x=
	1722862960; bh=riXT/ZPaI3yITLXofYuDWzvYYTW64WraJqRL8dIk1u8=; b=i
	c0zytlny3tW5mxYP9Q96bT+HC5/eGZ4+XbqhrHtj7oSPjGkgdsIQsvvj8qOaGyZX
	TdafKBoqN1ovXhgOHMWNTdlbTHTD+W3KVfVXGV7iqVxDn0UTn74gDuI0dAB3ic2X
	zS0CfxxJZIw1ypWuUjvYGyyh9W8QkX0xqRs19QMxBBTbW5ZNthDASwtO5D2Dyrqj
	B3hnqJRuOKezzOJuR/oO36IKSHw1nEDsqwNtBbnj1QtvZgW4OftQYY2d7CRHrshT
	cKm3SZ2NmI5p7A5Q7ZHeziG/HdhSXA4h+/PJVca5P6zbLk3gggNgcA60PiKED+my
	krK5Rus4OlhIzvV125SHg==
X-ME-Sender: <xms:8HuvZnk5jbHd5FWrhKTIauz1eiLD1U3AEJYPqVnXokppjjBkiwf4_g>
    <xme:8HuvZq1KRqyyVbYwScZWuZWw9s3hnPW1W6W0tlf10MBpUjFEO49G98mfG1LZ13cgY
    af15ZB2aun8SiOYJPw>
X-ME-Received: <xmr:8HuvZtqR4VV_22Sa4xPxaqR1XkZoOf1RBi6d6ufaPVfGr_T1yMkeqDKi1eAlLu_hes_Ph2Csvnoan5uy4GolKMPDEl57nxhjK_5qs23XBDtl5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeggdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:8HuvZvlh8P-Hj7GiMND1-be3ADT016lnynvvFDryW8WPBQt2SlSTug>
    <xmx:8HuvZl0xL20k9DrqdB2VA00IeLInpPY7w6SQPkOaVN9aKbVshkUBkw>
    <xmx:8HuvZusuFIy4VyEArVFZ-8Fr89DQUffpzdEaWKTIZniICh2S5HOLWw>
    <xmx:8HuvZpWtAETnh6bjgL40PerGn4zaeBNn4GsNY1bvWsnUDAWnLiUJvQ>
    <xmx:8HuvZjAt-gTKyCc7f6Yot7PYNQK953SRydj7aZkBkrnpmr5kYfje2MHB>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Aug 2024 09:02:39 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 08/17] firewire: core: use guard macro to disable local IRQ
Date: Sun,  4 Aug 2024 22:02:15 +0900
Message-ID: <20240804130225.243496-9-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240804130225.243496-1-o-takashi@sakamocchi.jp>
References: <20240804130225.243496-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The core function provides an operation for userspace application to
retrieve current value of CYCLE_TIMER register with several types of
system time. In the operation, local interrupt is disables so that the
access of the register and ktime are done atomically.

This commit uses guard macro to disable/enable local interrupts.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-cdev.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index c3baf688bb70..90e9dfed8681 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -1263,29 +1263,27 @@ static int ioctl_get_cycle_timer2(struct client *client, union ioctl_arg *arg)
 	struct fw_card *card = client->device->card;
 	struct timespec64 ts = {0, 0};
 	u32 cycle_time = 0;
-	int ret = 0;
+	int ret;
 
-	local_irq_disable();
+	guard(irq)();
 
 	ret = fw_card_read_cycle_time(card, &cycle_time);
 	if (ret < 0)
-		goto end;
+		return ret;
 
 	switch (a->clk_id) {
 	case CLOCK_REALTIME:      ktime_get_real_ts64(&ts);	break;
 	case CLOCK_MONOTONIC:     ktime_get_ts64(&ts);		break;
 	case CLOCK_MONOTONIC_RAW: ktime_get_raw_ts64(&ts);	break;
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 	}
-end:
-	local_irq_enable();
 
 	a->tv_sec      = ts.tv_sec;
 	a->tv_nsec     = ts.tv_nsec;
 	a->cycle_timer = cycle_time;
 
-	return ret;
+	return 0;
 }
 
 static int ioctl_get_cycle_timer(struct client *client, union ioctl_arg *arg)
-- 
2.43.0


