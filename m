Return-Path: <linux-kernel+bounces-207664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64874901A5F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0952A1F210A7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C7C15EA6;
	Mon, 10 Jun 2024 05:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="P67iGjie"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DCEF9E8
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998541; cv=none; b=j1yqYMFweNrNlXR7EM0ZOWPjQQ2ufuKOlWRXx7s/CDXwziYUkglh4AQxTQxrlFezUA1hO6d3h782xg+B4qAmInd9UE3Cp6Us7/S60ZM9B2/1FKP6NKpQO0LakWgVryTe3J/gESceAKMRGS9+ofgW1eDQ2ASl381GpF+iJm/Iwyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998541; c=relaxed/simple;
	bh=t8bUqFZN1owoEoHVvTQ4d2z8i0LYblqwDfyn4BS8DSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bMVB644twZfGB4330bGbeBlxuMvKu0oDsjddYfZCFyL9iu4tLdyqJZVIsyZzI8v4Zoloh5aLEpxfnEvSbUmdogQkyMIJugQJpiDa1vfw9MxYpQSwmbENzPyes0vWaBrS2Yg6aM4FTjzDizc7iEis7OvJc3zfdsSjkMiMMQZsBAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=P67iGjie; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f68834bfdfso29701435ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 22:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1717998539; x=1718603339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBV/g926v6WU268d43iPrmXQkFNUHSMZ6p/vRmizITE=;
        b=P67iGjiebkPtfuipzOs1u9vpxdbdpZv4WCN3uoZon7nuSX1kBGu1YW72D1kyGigndE
         zl1cFxE26RlctYfmiAlHNXQrqZar9QWRW9ZxnGr77Qa2+g0nAtRo1oWAwYmPuVphoO5E
         Nzaw1W7nkanM8j7k3wqn6QsJNnk4eDTqakt/uhY6jgVtdqNvEMDRyeO/mrPvfHTZbxr4
         ofWRoHzmsvsXggcgS9FMAW4WlzelU9Rdg5ljw9Y64iX9DKqKtEPRSafATpDBoxsFLEM6
         Q5KYFzOfvu0oeKLd2pIFTqyXG24r5rSjyPz7rRN5AjnHEMxtsToZoxjHXzzre/KY9tIx
         opNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717998539; x=1718603339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nBV/g926v6WU268d43iPrmXQkFNUHSMZ6p/vRmizITE=;
        b=lQ0P74vQBWoIKUpzZkIJeNwRVXKu+7Zq6rFReCFyQZcSXj/OZ1s+sFdDvXofLh4eAA
         IGCA42MbJ36Y7Y6BwQh8hYCnVGKY91XSjHodeGeGojzqVnd7AL5jVI9yKf70knU8c9b9
         1BVh4AEODgh1mj+Zd151Hsfxynd2+HnHsYuSaDUtlWyxIMa51P/knHP1EzemGjgUVePg
         ceXGmJJFrZDpbP4spoG5XQVjeD9/qUEhHWx5bCoLJMDBUg9pRMVHfh4Ap3uC9RkMkW89
         FpXAFEIQDoc60ut20N0NZ7w9wQQJT4YsVe5l7x9TTG3MQctZVoKEwFVUxBKH25Nptan5
         VIdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUerVLEww2l+Z/F46JJA3+TpdTrbB9JabggrUVJvbYUnCc3FcpDTfKeq+eAwnx9rQMq1nGWWsKJJNBaJFIRNLT+l+c/6KeRDuJfeDpp
X-Gm-Message-State: AOJu0Yzbsujgp68Dcl6sJt5LTKQORykdYlpVgjkVY3q5+69DdDY6Q3s1
	KCNBaUMqZl7LOmq3Zae8T7hYK5Qri4OR+9CoFBnFmo0uZMfAcBhVvj3mhePKyz0=
X-Google-Smtp-Source: AGHT+IHjXzYTyqNnCOBveV6jWpuqnfHdjUVpEylW4oFwYpVmuRo5xWs1vZQkRQS7r0zRpzUVfC9BoA==
X-Received: by 2002:a17:903:2347:b0:1f7:187f:cb5b with SMTP id d9443c01a7336-1f7187fcd7bmr11855255ad.64.1717998539001;
        Sun, 09 Jun 2024 22:48:59 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f1aced64sm35653725ad.9.2024.06.09.22.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 22:48:58 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 02/24] Staging: rtl8192e: Rename variable bIsMulticast
Date: Sun,  9 Jun 2024 22:44:27 -0700
Message-Id: <20240610054449.71316-3-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240610054449.71316-1-tdavies@darkphysics.net>
References: <20240610054449.71316-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable bIsMulticast to is_multicast
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_tx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 87d1ff943617..8856191a1228 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -538,7 +538,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 	u8 src[ETH_ALEN];
 	struct lib80211_crypt_data *crypt = NULL;
 	struct cb_desc *tcb_desc;
-	u8 bIsMulticast = false;
+	u8 is_multicast = false;
 	u8 IsAmsdu = false;
 	bool	bdhcp = false;
 
@@ -655,14 +655,14 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 			ether_addr_copy(header.addr3, dest);
 	}
 
-	bIsMulticast = is_multicast_ether_addr(header.addr1);
+	is_multicast = is_multicast_ether_addr(header.addr1);
 
 	header.frame_control = cpu_to_le16(fc);
 
 	/* Determine fragmentation size based on destination (multicast
 	 * and broadcast are not fragmented)
 	 */
-	if (bIsMulticast) {
+	if (is_multicast) {
 		frag_size = MAX_FRAG_THRESHOLD;
 		qos_ctl |= QOS_CTL_NOTCONTAIN_ACK;
 	} else {
@@ -774,7 +774,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 			/* The last fragment has the remaining length */
 			bytes = bytes_last_frag;
 		}
-		if ((qos_activated) && (!bIsMulticast)) {
+		if ((qos_activated) && (!is_multicast)) {
 			frag_hdr->seq_ctrl =
 				 cpu_to_le16(rtllib_query_seqnum(ieee, skb_frag,
 								 header.addr1));
@@ -809,7 +809,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 			skb_put(skb_frag, 4);
 	}
 
-	if ((qos_activated) && (!bIsMulticast)) {
+	if ((qos_activated) && (!is_multicast)) {
 		if (ieee->seq_ctrl[UP2AC(skb->priority) + 1] == 0xFFF)
 			ieee->seq_ctrl[UP2AC(skb->priority) + 1] = 0;
 		else
-- 
2.30.2


