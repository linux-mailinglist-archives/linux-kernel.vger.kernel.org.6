Return-Path: <linux-kernel+bounces-210861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 676DF904984
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 702351C2382B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC43286A8;
	Wed, 12 Jun 2024 03:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="FKdKoqnC"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08A21DFF0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718162557; cv=none; b=Vmugnq7tlbDTJO1/h5+a0Ny+IVGEqBFEK1FRD8wfxpTt/WPHqYbKCNVeQXXYmqTIo8CaDu8Ue4lkD/AhQYoVpHM9z8So7g6TDYSDfefp4V3nWhK+WCuhzoiRmj3g+RSHhtMgskfgvHZPHT42EtNSjqFq/hYfYl6LAjaKGBLaBCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718162557; c=relaxed/simple;
	bh=Z2Og8hD3ZwqLqSZxTqFmWZuV5tskamWURf9scY/q4VE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IHIqd8MNXW7I5vskaOTpF2R2K45Itb4k9PrH9c11uUpOsD7GS9jWBm9ybmX2klaSzWat6ojfBZr4ccITbU2/m2mlVq7VmAcWJ2C4kBEAoVsNaeoAG2Vlrf1saKJue/xdIRocFwk1OKr9hDn+JQnd4KxY0+DZjBT6fHy36S1cpJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=FKdKoqnC; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-375932c94f0so8805815ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1718162555; x=1718767355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kn6Y3ZurmMy+llEC4r5fkl0HupmvFt8cRPelN9RG3Yg=;
        b=FKdKoqnCR8MyNn0lEettBPWUcFHzUire574qHCL+L8mcSuwIcwyrV/eyuNmbfng+7D
         eTJ2p86XWZISNU+W+w0AGM16lXMcDIVooFvZBkVYYTdnNAdGJejQzBZ4Lyf3Ubux+McI
         PT6krMgcwLwjjeFnAk9DFAvpw3pD1gxbw/Xjruni9fK7vL+Lcr0xkpJiA5zMPlUfwOCL
         LDTyInBM3ojQaYIXKpyxac1S+GPVMKFdnCBIbiwzorJwmzWBCvyqvuhJ2/2U6GyCySid
         dw0sh0qfrHGBqtLkZ9WoRlMjs2OdNEPWW3H5FrDPXl531CvMlNdDhB6EEe8qiKCIPfBZ
         V2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718162555; x=1718767355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kn6Y3ZurmMy+llEC4r5fkl0HupmvFt8cRPelN9RG3Yg=;
        b=eMe0i/ZGACHB1etw55H2D6aRBkJCkJgITE+Lr8kBOqLEUFXY3qtQ5l1ecX53Kkt8+i
         dOKhdXo35cZhvaiCbRrjh6pTMAiXevML2x5/lsEoPPGzwbOe/QBFrxbpYo+WNqsV1S4F
         quAJoAb0SGmqVQVnKovv51lZH4EC8MTlZKoI6vPfsi6wYXcxj0qAM1Dw1EQNQNJOi63Y
         Iqh/hy/N7RpHNqRlYMuLyxKDLk6FG9x1g5+dyP0a2MgbiVpijbZqIa/gX9sUSrzTjp/G
         UByXnITWaql+Sbg0952+HiMG7ymd4Bh0jpXMV38mlkhuHah/nYf9l0O5081BAtm5ZF+x
         0mxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpxVqBcCerBcjbJ4RtbWgER4Rnyy/+IE88geynbn6fPfCOVeLGhXkU+eF6Q+/Aum0fCDAbZkuixivBMuAUz97zIvH+zZoJNdqp4+K0
X-Gm-Message-State: AOJu0YxpxzVy7bEvpN2wCa2ned9/52dLcQS0EMSuVysYqW3Lxv0XrBBA
	tu3S5awkY7cMJAtVUfeVQy5wmTKHvcOMvBcVFEyFuAOE7AC1Aji3tLp/Hl6M7Qs=
X-Google-Smtp-Source: AGHT+IHlb1SEKPZ48DLEKbZ8JbrKYCfG1s8maoccY1eQUTqDbRm0E8V53nWrYeQDI2gx7GqagFjmhQ==
X-Received: by 2002:a05:6e02:1c8a:b0:374:8e4e:86c6 with SMTP id e9e14a558f8ab-375cd14f8e3mr8105285ab.4.1718162554971;
        Tue, 11 Jun 2024 20:22:34 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e8e8a84949sm5635411a12.32.2024.06.11.20.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 20:22:34 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 02/24] Staging: rtl8192e: Rename variable bIsMulticast
Date: Tue, 11 Jun 2024 20:22:08 -0700
Message-Id: <20240612032230.9738-3-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240612032230.9738-1-tdavies@darkphysics.net>
References: <20240612032230.9738-1-tdavies@darkphysics.net>
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
v2: No Change
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


