Return-Path: <linux-kernel+bounces-312688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC29B9699D6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4823AB21917
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBCF1AD26B;
	Tue,  3 Sep 2024 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="G8DkbHzp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H8ejT175"
Received: from pfhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9766745003
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 10:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358502; cv=none; b=YWTa+vg6od9CY1I6QHY8xQpdap9YWyDNEVBxidWfoRrhy2hK51hQEw+b+3iAczHYYFWv8KIMhb30XlBs/v6o9/OdPPNvMorLZXeCnkD7T5lbkX31OA7ZTia63Xrn+tpFN97sjRDGCJ1lxM9TTinoYt2oWzQmE82E240TlePtgUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358502; c=relaxed/simple;
	bh=KVMOq3+sSI0aDG//k6mpQqkxfoGps7TxFTMp1ubr8Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nXvm1YdoowBXMwghOMUqw/1jiFwqKeb1mJNQXtKF3Ef3H2O5x6a2v1z1v+O31uYKp7R5aGdg99fRk3SScvTagq8PrFscvw/ft6LatkRT9hvKgo+YqggWb7F4PJdWGfvIijN8UvLhOyn/hi7997rZl8LSwZXVJNddohxUUiLteT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=G8DkbHzp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H8ejT175; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 961811140100;
	Tue,  3 Sep 2024 06:14:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 03 Sep 2024 06:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1725358499; x=1725444899; bh=cQ3Cmnl22p
	JyvQzeMH+44ginKFaS1ZMnNT2AenBDixc=; b=G8DkbHzpEnATt0/HLcv+Eqf8B/
	JAtOAzQkCI+wbkXCIYHblnwv09ze9cLfpiTNAdOjMBMWOJSZWGHkU8e47ihEiYqP
	rG8mPpBYflwF3JdfX68t9ddVcYw/g8SbtAypJPisZfubdfMPpQwzUynh+quOfuFA
	qTfE3FmzgVUQdcg58C/Sh1oyu6kFiq8QabUU0FHKhXNUs0kvtnYRuFu7ukAq2CRI
	Uo952jgQiN+xQebqnIcApr/eXlT5Iyh7/HuMVOoZ5bTH15tpSsXRMYaKQaqBBqEW
	KX8jPjMUwQmKN/CkKB5Dh42s5AYgiBZ6DXR/QrvbtpNDL14t4K2LdI7tH38g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725358499; x=1725444899; bh=cQ3Cmnl22pJyvQzeMH+44ginKFaS
	1ZMnNT2AenBDixc=; b=H8ejT175tuxnTA/zEuvxb2q7daPqZTApKJm9L2p5Rx2O
	F7e8tZbYcGpJTZegJnfMKMwxx3gOBHecsNxBCVaj2l6VHKDzcmv1oiHkO1sGNvSO
	Kh1GABW0YJIumAiVp2tu90vqfoSmrbFkSh0XxkVQJp8SXO4TqUyP4iLm5kzUONK1
	vDGsYUje7UKWDY3L882Uxw+OOTMMFsXRC1UANNr7QIMJxb94qgmzWNLJAgLlDXw2
	9wtTvqqU5x7H2pfELlCXVN4lI4/aEh6Jz+2tLtVEweC7Bs576gFLjP6oakiDFXmF
	gqpPGxz9h/38w9OBRfJGtZ/GyYZ+XFPL7tYA2SgymQ==
X-ME-Sender: <xms:o-HWZo054JaJ3lOuPgU8Zo2-XHyBYMJLjiQtBI9ygEaTJNm7TyUChg>
    <xme:o-HWZjFLH02RWtKnqnOXdefSLO74dvctreUuCOf3XsE8N2OKMRfTyNo94cw2EDac8
    -zn901fXEsC3Tvbqzw>
X-ME-Received: <xmr:o-HWZg5ibbplkm1ZxSIJnaLcluKbqqgsODC0FNdbk4HB_QNF4OJ9McZgLa9Gm54PongqhP7QtW7d0xIOBgaicI0AU1vjGlDVQ7v8mwbX3R1PuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehhedgvdegucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:o-HWZh3AdnT27DnwCDYexig2V01iRdXitTHh5LawfvrViJAPd9L-Kw>
    <xmx:o-HWZrGeKcRoeIb59nwQKimJjm3ZDkdnn5FSNJiRFjzaueyroZpbmQ>
    <xmx:o-HWZq8zXjS14HO7rTnAbTBmN3FhaPbFfzO5ZHMp3bSOQyf37gW1Eg>
    <xmx:o-HWZgnNfMiw6x1nf6LBS05yHkzxLjQ9sAUaRXDJCBefl_8lUma-Eg>
    <xmx:o-HWZgRxTb4i0V9DPMWNLx5a8UoWiCC-MvcWmB6qVN_WeucYV5nQdjKw>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Sep 2024 06:14:58 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] firewire: ohci: deprecate debug parameter
Date: Tue,  3 Sep 2024 19:14:55 +0900
Message-ID: <20240903101455.317067-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many tracepoints events have been added to 6.10 and 6.11 kernels. They are
available as an alternative of debug parameter in firewire-ohci module.

The logging messages enabled by the parameter require some cumbersomes in
a point of maintenance; e.g. the code to decode transaction frame.

This commit adds deprecation text to conduct users to them..

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index a3a37955b174..e662dc30c21f 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -396,7 +396,7 @@ MODULE_PARM_DESC(quirks, "Chip quirks (default = 0"
 
 static int param_debug;
 module_param_named(debug, param_debug, int, 0644);
-MODULE_PARM_DESC(debug, "Verbose logging (default = 0"
+MODULE_PARM_DESC(debug, "Verbose logging, deprecated in v6.11 kernel or later. (default = 0"
 	", AT/AR events = "	__stringify(OHCI_PARAM_DEBUG_AT_AR)
 	", self-IDs = "		__stringify(OHCI_PARAM_DEBUG_SELFIDS)
 	", IRQs = "		__stringify(OHCI_PARAM_DEBUG_IRQS)
@@ -2197,6 +2197,11 @@ static irqreturn_t irq_handler(int irq, void *data)
 	if (!event || !~event)
 		return IRQ_NONE;
 
+	if (unlikely(param_debug > 0)) {
+		dev_notice_ratelimited(ohci->card.device,
+				       "The debug parameter is superceded by tracepoints events, and deprecated.");
+	}
+
 	/*
 	 * busReset and postedWriteErr events must not be cleared yet
 	 * (OHCI 1.1 clauses 7.2.3.2 and 13.2.8.1)
-- 
2.43.0


