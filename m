Return-Path: <linux-kernel+bounces-169491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE9F8BC978
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A2941F2296D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB931420C6;
	Mon,  6 May 2024 08:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="KpnN8kLo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S7L5WXAg"
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC3F140E46
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 08:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714983723; cv=none; b=lDKRekhJ0XZtyjb3YrIyS2OAAa+wU1+n8qTOVsvXZ/pbZw3TROyHsAoxzvHXgTFIYRoyn8DfoZvDD5dh03+f53SfFFvIxXIRup5ILyUiHJzj2E+uIQ5UYxmCju+sX6JdxoeDr0QPX6E7GfdhLTwKrufWvrp1qYd9LF8pFQQ+iBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714983723; c=relaxed/simple;
	bh=t0vkSDTsgla9zTNzdbbcaA+WDWix0pJ42tCnDesWIdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jsGjCxxsTabaBMgCOD4dJx3YGwPW8xmtDWHL16gx8kNh5B6yHiLSdMwowM8fZKqLOGg3joptgHbs3xLPCWJlXOoWmbAqGwVg5/tFK3uUESdGjhq0f671IbCV4HCHj74lSECtIsccX9E+cvP1Ty7Lhhc5NJpHo4GxUK23paLIhMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=KpnN8kLo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S7L5WXAg; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 3C4C51C000B6;
	Mon,  6 May 2024 04:22:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 06 May 2024 04:22:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1714983719; x=1715070119; bh=K8f8zaE/5s
	/YLEFIoVR0uzOmwjq31kQM6GCmXVEQz4A=; b=KpnN8kLoOc3rx88tw5EQXIDU0G
	3/kooznyeFM5tCAObGT0a5ibiP6E17u+z7hvAq4+mEFA+IQj01tXqa5J+TB9RT31
	7zidSwbnvZgDnDULCTqw7jxsQQsj3w40ohkC/XMYM6WoBZzWaZUkz3BND82TbQUU
	aekhKUyfvG5sgnME+Yk4ketOyADGFQKzpFBHagYw7ysy6d7x0sfU3Y5un+pvazkh
	QsptLQyUscIPiS7/i3HMQqBURuI5gv1AkPMYf1Y1dYRPUq6d05U0/78Z3+1eVG/q
	yodhhKFpk4vc7VqRs11kl9/DInmYqtEHkW6fkaKLkHjZaLtb//eNA3xTijgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714983719; x=1715070119; bh=K8f8zaE/5s/YLEFIoVR0uzOmwjq3
	1kQM6GCmXVEQz4A=; b=S7L5WXAgH1s5Kx9wJTheAmEJOBSS8UDNumUB4iaSmqMp
	AAvNyIJTqLiTpjh/lm2U14tnAwRWZYXcQWep8+IwyYCwGxaQEEzeFpYVdsFTnle4
	Y2L1yJWQnl7AJvI5Ax3p8cenHtjtmt4nUoOTiA1FjVF9eAAJlzus4SlCyhggEb7y
	bj+v2jQot40mj6EEAvF8+8kirGCmLppuCpIxyhBu5DLims+rzO1QmthAOOzEfUOi
	yI4MS048YqrRpG8U2LHe0RM9MJVLhqt5vvD59zMRwQ8Qn13QneE3yfPNs0fm5N4K
	icKKxnectea2pN/S0kjkrxgyAwcwvj/PScNiaKik+Q==
X-ME-Sender: <xms:J5M4ZoNZ7hy3qMnirsrUqPSSZNIFI5vH_h3OXvV8DAGa8XRdkAZmFA>
    <xme:J5M4Zu_qodwCJt6SWsYKzmOcJOCBggxpEyhmK1FU7lUy1FtemZq3ecJ-YhnX95rjj
    V5LqTsexazVLrbLul8>
X-ME-Received: <xmr:J5M4ZvQZuDeHDF_8GbR_1oFy5vB-G5R_o5LSfgYT8Ntw2tT6zAMSsuIUc4b9gWCuifSDIGIjLVJsZnW90KOinO_e2V0nmCZvcJjNQSCG986Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddviedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeffvdeuleffve
    ekudfhteejudffgefhtedtgfeutdfgvdfgueefudehveehveekkeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrg
    hkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:J5M4Zguxh-rZAs40zcDcg3dJerG86V_-sO_mRsxvJGP8JB7Hs0C_GQ>
    <xmx:J5M4ZgcIPsGMhDr42QtJFx7aDZkj_RGOd0xC8Ju1s1Od0VMgO9g5UQ>
    <xmx:J5M4Zk1R-vsewqrauScrStT7R8AN9oPqKiyOEeXFFfWmWnY3OJ3jfQ>
    <xmx:J5M4Zk9dOVoW3A8DtvTwQxtrLwsjHMJFCuk765SRcmcI3W8vcPgDwg>
    <xmx:J5M4Zhpvya7fBGmezxrw4ImgQE0USWV4NThvmX03FRMG6MGPCosVC27g>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 04:21:58 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] firewire: core: fix type of timestamp for async_inbound_template tracepoints events
Date: Mon,  6 May 2024 17:21:53 +0900
Message-ID: <20240506082154.396077-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The type of time stamp should be u16, instead of u8.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/trace/events/firewire.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/firewire.h b/include/trace/events/firewire.h
index cd6931b134ee..d695a560673f 100644
--- a/include/trace/events/firewire.h
+++ b/include/trace/events/firewire.h
@@ -106,7 +106,7 @@ DECLARE_EVENT_CLASS(async_inbound_template,
 		__field(u8, generation)
 		__field(u8, scode)
 		__field(u8, status)
-		__field(u8, timestamp)
+		__field(u16, timestamp)
 		__array(u32, header, ASYNC_HEADER_QUADLET_COUNT)
 		__dynamic_array(u32, data, data_count)
 	),
-- 
2.43.0


