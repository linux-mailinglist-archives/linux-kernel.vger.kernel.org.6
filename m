Return-Path: <linux-kernel+bounces-273840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCC6946ECA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 15:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B273281BB5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 13:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECCA3AC0D;
	Sun,  4 Aug 2024 13:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="nqKC+niX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gXOK+yaL"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8482200C7
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 13:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722776553; cv=none; b=Yxi2gOXvHwDOidTvzpNtVzr/2f9U1ddCYLNwaebCBQlo5+GnTkcztQzf8qB4RhhZzbVzhmkIzoIrpH+QtNTPU3GdLb0/LBEDzr0J6ktSI/H/Xk8dfL9mNkPndF8tMor/Zn1lrhbgAX3lfFqxOm9aiE8+r3IWfO42rbBXGzPmf/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722776553; c=relaxed/simple;
	bh=LTZgk4Q7yEHgsYa/3BCj3o9FpVWAGqL0/melW16hM1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kd3P2Pm+H50SLs8NjV68CEJ8zgHRRDj9zoFbpJVNWMz0LlDL5V+k/0MnUwYHVnKeowSMF6B1P1Ehec79Vr89StKXbbM2/mRKZBVSVyN6R3qaHpQd5nCoYKontgAM+FQgEUNtXtv05JD42vnYU/UFd+CGP7mbUK0Yv6KdhNW5roA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=nqKC+niX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gXOK+yaL; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E1B411147F19;
	Sun,  4 Aug 2024 09:02:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 04 Aug 2024 09:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722776550; x=
	1722862950; bh=96B7qG2RXUCqvEU76ArBM5B2OlW27Ke00tHiDtOnSak=; b=n
	qKC+niXkISymn3iskL0ys42fhe2+ytiQA8OUhgoRrZThgtAbMbd010xCuoWTX1b7
	dIXPgNjE89Ub/8Az5IiYGyGxOgl08XmJJ3SqxBgY8qdmOion9prMvt1IWzRTy4qm
	LiIpKtB5mgScrEvWVVlBX0JO1GHLbnVd7ndzeNOIxeRN6C4Ch5CE3bo7jHGn8kMm
	V3q6Gapyc3HJ6FFmcQB5LXLkYw2an1ha367Tn8dHOiK8OD42g0Jc1dMMunfc/JT9
	zSH8YgCxLhaHvf+WhNYiIE36mKEWmxE8PysB8Oa5+LvJPABOBSHbRX8ZwXn5QhPH
	/tDM07zWHBQRq4VHySmGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722776550; x=
	1722862950; bh=96B7qG2RXUCqvEU76ArBM5B2OlW27Ke00tHiDtOnSak=; b=g
	XOK+yaLdLPYnJaufcWddCBJBO9+3pTlky1W+Clwki/ENP9KMktbxcRE8WMTEvLsE
	Wl8bgeJKud1myjKj58qe9zEzQ9+cdGVFP0lQP03r/9Vk916TwdnV1GeC4fSSEuzt
	68s8oGKjLL30vRA3aKQoZTHRuwHtsL2Y/UM5hBDQYZq3SuPTKuL1XqHEspwBnyf3
	1ameW/1WmyETcvpcm8q2K9uYzY/GNWA4bMLHRrKNCwId0P+IG1be8Zc2ZiXEPtPs
	xSA8E3zFPJEk4s2UQxDjqMVs3pKcdXYJloBAiCF5OTJ4Vqk0wUcwsWE12muKlWsm
	dnvMLzJSUjLnr/wSGERdg==
X-ME-Sender: <xms:5nuvZvwn-P_h9UDTEUUJpgOS1qAGQIpudhPBGZAG250aQ3caghjfYA>
    <xme:5nuvZnSK25yh8EGsGe4xQILT6Dx0KJ_IcfQd2DELssFuLcxhwa4Ohhn-u_fmxZV4j
    7n4y5z7fTjfcgCSs8M>
X-ME-Received: <xmr:5nuvZpWDLjpftTcPmDdnbpQOg2zSKsoAOo5ZMlC8HCSp-fccfhi8WJzAoxfh4np9VM5ow2qxXGQ3PsjtowL2kLYlDyVJLAuuIPDSJXZXlCxTcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeggdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:5nuvZphQRViyafhRZZvn8axXkLOVLxjvpKoIJ3hULJY7Ez_NtCR_Xg>
    <xmx:5nuvZhClTzSRhfYSlMh83DTVPx0NdUG2UEpMxmCHF_IVIlaa1UR5Ug>
    <xmx:5nuvZiJE3F_v_2sdaZDqppzPNREqsf2i6CZozjxbCAzqWltV4TJLvQ>
    <xmx:5nuvZgAg9XP5BTXnhPkEtQ1tGriNXMAQ2ZzZOV_N5Q7XbPEvzkDA_Q>
    <xmx:5nuvZkNE5L3cA3MKQvJfcwdZXY43jXqOxr2Wrz6Ic4GspzS6wdwrHEpZ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Aug 2024 09:02:29 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 01/17] firewire: core: use guard macro to maintain static packet data for phy configuration
Date: Sun,  4 Aug 2024 22:02:08 +0900
Message-ID: <20240804130225.243496-2-o-takashi@sakamocchi.jp>
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

The core function provide a kernel API to send phy configuration packet.
Current implementation of the feature uses packet object allocated
statically. The concurrent access to the object is protected by static
mutex.

This commit uses guard macro to maintain the mutex.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-transaction.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index a89c841a7dbe..2a2cbd6e2f9b 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -494,7 +494,7 @@ void fw_send_phy_config(struct fw_card *card,
 	phy_packet_phy_config_set_gap_count(&data, gap_count);
 	phy_packet_phy_config_set_gap_count_optimization(&data, true);
 
-	mutex_lock(&phy_config_mutex);
+	guard(mutex)(&phy_config_mutex);
 
 	async_header_set_tcode(phy_config_packet.header, TCODE_LINK_INTERNAL);
 	phy_config_packet.header[1] = data;
@@ -508,8 +508,6 @@ void fw_send_phy_config(struct fw_card *card,
 
 	card->driver->send_request(card, &phy_config_packet);
 	wait_for_completion_timeout(&phy_config_done, timeout);
-
-	mutex_unlock(&phy_config_mutex);
 }
 
 static struct fw_address_handler *lookup_overlapping_address_handler(
-- 
2.43.0


