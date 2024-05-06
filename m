Return-Path: <linux-kernel+bounces-169492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 604C58BC979
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A8A4285128
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3649E1422A2;
	Mon,  6 May 2024 08:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="ixd3Ssnj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VAnb2qS3"
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369361420B7
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 08:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714983725; cv=none; b=MJ8TF9OjxqwOZuIlskJzhiXWsyFUONxMw9TiDCyEWZLDix8kmrYN1cPEetIatlvSXE2tR7Zvt/YldJqp8AWcqN89gjh/Pj0IcDOtMFNt+Bf13QhCMnVQd7q1A1UvYuBUCVvwgymdDSgP7WBzvyrnSdyJxY80rRVoWCk+B+PqsFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714983725; c=relaxed/simple;
	bh=DxALtaneb1zNDaPQg9Cu3NvwTJKu4BPV9aYAg4kaupc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTN3PP24L891aH9o3bLYKDIPZ40iOvG/f2iCgdPEK66vuSY1lpfBaEMr+AG+vKrp3GfNG4jN1ad4A42dbX5MNkVYMMJ1VhplM3m1y27N93hd/9GGNVMsbXrRRmbOsF2OuVg8x6ZzdNxCZ2c7xHdt/dkqkz4eYQtG0Yklzwn3e+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=ixd3Ssnj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VAnb2qS3; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 446281C000CE;
	Mon,  6 May 2024 04:22:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 06 May 2024 04:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1714983721; x=
	1715070121; bh=Ac8QBrxyIqupzoU+z/gO0cIeQW48EPxhU6j4BYZsQ94=; b=i
	xd3Ssnj6oD4Ufp0d3yjJpcz3zSidPCA0ZhZ16HYXIJt8Wftbg/9jCptA64aDkPwJ
	DVkYTRpLyTtKbCd9Wf25MaSJ+peUyA8leuPH5INICDQdd0gegv++/jGbHT/OOEhG
	b0I9WZTRVK8PLhZmbenI1e9zua/TeOJ2TSPfsmeTV6iBLAT5kn6/8UOGVr9Wj6y5
	KuFY2KG+VUuNuBIRGkNs0FeJqZ74bVNFSNpj0zmLTONNkY8jxjAJ3mhZwbGxHA3P
	k2g6lHvDaN7s0wiLNFZQE/9o/ujVuQy/rKnE7cDg1ZLgI7QAz+pB7RMDp6NIyvxm
	kxkHxp2tDNSwggYxSko6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714983721; x=
	1715070121; bh=Ac8QBrxyIqupzoU+z/gO0cIeQW48EPxhU6j4BYZsQ94=; b=V
	Anb2qS3d27d/+39CU67rs5e6Do/e2nd37wTgOpAfwqJY10c6KwVhtPyVR3cU9tIi
	o/rSU35xLvL6gez77ZzSzn8HDWgrD/qXNlp8WRwlcHYp0JlaeuLhKyvqUiuWdfIz
	Smespr2ffKKLxgAaeUBfTtMBMEMFp77nBQorQk6mHxLCqqsWloY+nlNV9uLmiNxt
	H8WqYrqFEcQTpI2xABaonHJpnc9yw4lfGNNbOzcewfV80+NUZc6WCIyeFDZvHWX/
	oZ2CWpUfsGnV6F2W5Bz6eGR/0CeX4MoIc94eTNhwUskC6I6o/OuVnCT0deFzbYa7
	FJr8GzI6z6oSVjE9p/mzQ==
X-ME-Sender: <xms:KZM4Zs3GFnxmm_mHUbDCd87S5WPXj4O6HA7_z3W_9vYJ1qCiuQVhIA>
    <xme:KZM4ZnHvQJ90QKRxHVC8MkpGARekbBlxQVMeJRHeGAs7bRFDHTzl55i4LwOtxLwMb
    W0oNmXrAztixD9pziA>
X-ME-Received: <xmr:KZM4Zk7RUddSHyOCvV1rHTPo7zlEIDRBlfX0-OC9NyqH68QlmAR4vpBhjZbWBnbcl_OL9LetOyBlpb-YHOxDq1xulQ9qPXVp-AM5p7jmqiAm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddviedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:KZM4Zl2erQw5f-oqNkvuK2Q_nBTBF2OWWsk-crf8sQpkzpxA4qShrQ>
    <xmx:KZM4ZvG_M0KPYc_fM8cF1xLxjNN0ETgyED8pi-kS2_x-zwaISzW_Ng>
    <xmx:KZM4Zu_bjR-vN1OjhgPzHkQ_5SQ9ZrvGzN6TAfm8C8s5jZBiuYEewQ>
    <xmx:KZM4Zknw8FeHsh0NjKV85bjDcLiGU7Zxoz1FLweqCrK0dpKuzxncug>
    <xmx:KZM4ZkR6gtaKWCWUKjYqDfB2NSwJ1Q1DFIQxW6dw8SXLZxnUoK-PaGI7>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 04:22:00 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] firewire: core: remove flag and width from u64 formats of tracepoints events
Date: Mon,  6 May 2024 17:21:54 +0900
Message-ID: <20240506082154.396077-2-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240506082154.396077-1-o-takashi@sakamocchi.jp>
References: <20240506082154.396077-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pointer to fw_packet structure is passed to ring buffer of tracepoints
framework as the value of u64 type. '0x%016llx' is used for the print
format of value, while the flag and width are useless in the case.

This commit removes them.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/trace/events/firewire.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/firewire.h b/include/trace/events/firewire.h
index 4163959be57a..cd6931b134ee 100644
--- a/include/trace/events/firewire.h
+++ b/include/trace/events/firewire.h
@@ -221,7 +221,7 @@ TRACE_EVENT(async_phy_outbound_initiate,
 		__entry->second_quadlet = second_quadlet
 	),
 	TP_printk(
-		"packet=0x%016llx generation=%u first_quadlet=0x%08x second_quadlet=0x%08x",
+		"packet=0x%llx generation=%u first_quadlet=0x%08x second_quadlet=0x%08x",
 		__entry->packet,
 		__entry->generation,
 		__entry->first_quadlet,
@@ -245,7 +245,7 @@ TRACE_EVENT(async_phy_outbound_complete,
 		__entry->timestamp = timestamp;
 	),
 	TP_printk(
-		"packet=0x%016llx generation=%u status=%u timestamp=0x%04x",
+		"packet=0x%llx generation=%u status=%u timestamp=0x%04x",
 		__entry->packet,
 		__entry->generation,
 		__entry->status,
@@ -273,7 +273,7 @@ TRACE_EVENT(async_phy_inbound,
 		__entry->second_quadlet = second_quadlet
 	),
 	TP_printk(
-		"packet=0x%016llx generation=%u status=%u timestamp=0x%04x first_quadlet=0x%08x second_quadlet=0x%08x",
+		"packet=0x%llx generation=%u status=%u timestamp=0x%04x first_quadlet=0x%08x second_quadlet=0x%08x",
 		__entry->packet,
 		__entry->generation,
 		__entry->status,
-- 
2.43.0


