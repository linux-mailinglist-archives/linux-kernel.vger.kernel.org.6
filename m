Return-Path: <linux-kernel+bounces-179427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E768C5FEB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 986051C237EC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32A63A1AC;
	Wed, 15 May 2024 04:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="j2ru2M3X"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD9E605BA
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 04:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715748772; cv=none; b=ZHivbAgjY+ZKartLcjwjucmIYENAQVsnMS6HS+1ThfOI2wX/UIBhEymIYaRFfS5TmLsSovu9CGICIjAy2Dgew2QRlBmA0lScaSwwXNQ7Ls0rL9ZSv0xg2KdGA29skC/T1KWI3EIgBFeYSUZq6fm7AWs7rOhIlLDmyu2bdhxXB98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715748772; c=relaxed/simple;
	bh=jeHwGwRspY2gSDSiW7bcMqqSAMEpU1ir/AH2Va5Ia+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oDcEV98/e7Up+KLv+nWGkpcPaz52FlhfnzwI2seNtK0VmeeQBQ15QYdmVQEpch1DhgqLUlUgZN0izjZS4ZcHzZuuZi4ksncchHECRLWHTSExHBGI2xvey1AITtno2Dvw8JG7TdCD6tSh4DAsPW6+uQI0ISZXVoT/bgfEepi+GZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=j2ru2M3X; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c9b74043b1so690156b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1715748770; x=1716353570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwhb6dTZ3C1pduwi/qMgE4+GQbsrnIG7yr+Npoq7eqo=;
        b=j2ru2M3XQ0rOTwWUMbhZ2lSsrye/gA4CZuYK/+IkA6FNG3LwKWu6FY9UtWqRztlaxs
         q2jFUf509Rrk2vtHc3Mz9rzgsrsIXO1gbCnVDXK20RkPdsZVjGIwIMtfuLMSk5wrYx82
         +AqWvAAekqpEIqQ9A2f7Xso0PdfiG6GcChsRxDrMOlNeWFsJvWrgCiA5/8M84z4fv57G
         YY5NFxoyb2WAEga5CcpdDhIxGDRMTFKkGF4skNkr4z2Op5QL6QlsMW0GLyMn+uqLNtfF
         RC7qa3Z6Xu7LOP4G9axHtjf0tAeGTlhRqu1etSv9Zgj3aI30b7XjmYmcAOWNnhr2pYSE
         TnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715748770; x=1716353570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwhb6dTZ3C1pduwi/qMgE4+GQbsrnIG7yr+Npoq7eqo=;
        b=T9fpIzkL6gz1lowNC7aTo2QSlVjCPHHvBJLejks50WDfGsys6Gg0nUwWQWlk0mK5dN
         6Yp5v1SZQgp3owxW673XEHGOt4jwpvJEqqudMGlPgb0LKkCkbcawiZkJH4jzlRgALyCp
         yESD+b7gWCKDbOLHZJgNqteN6+Vtf8M44vHRVTTunB4zPKzZDNr+cAadBNThlfXr8adT
         gxVKB9plP1gcR+YV7P1R7bqemQSwgLh/9hVCQvwFn7lAKsSIy5rgCpK0zBUHWrOnhzya
         44zUTIPkO0q/BbTAhx+gQAm/xG+UfXeIYVyMhmUv4nLCmus/MaP2fCkBLWoL8WeH+jCb
         3ELQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8Xrcn3KjtZy228w3LbiqG80jcyNXaYYg0yv6Y7dLdfJubrtE5UmTpRS5TRROqlYTEU29GeXXsT30xflmesFigWr4W3qV9DuSDMOdz
X-Gm-Message-State: AOJu0YzXdZ6wr0sxMVmtvCKNGP01+mKg2yEchgKAha76aha/UKZLxW5X
	hiwT0Eh80HReXIr310gKtyXgOJAnzYxV2auKO2Yanh52kIT7qn5KK1aUcVk4fAU=
X-Google-Smtp-Source: AGHT+IHt/YCmhxt/SaZFO/lhq5QXz83QsvoW3dfwRopaTVrCGTZvsqqqQtzcgIZIZCV6bMZ9j2/vCw==
X-Received: by 2002:a05:6808:1a17:b0:3c9:9fda:37f1 with SMTP id 5614622812f47-3c99fda38cbmr14168972b6e.29.1715748769895;
        Tue, 14 May 2024 21:52:49 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a827fdsm10135035b3a.60.2024.05.14.21.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 21:52:49 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 22/31] Staging: rtl8192e: Rename variable IsDataFrame
Date: Tue, 14 May 2024 21:52:19 -0700
Message-Id: <20240515045228.35928-23-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240515045228.35928-1-tdavies@darkphysics.net>
References: <20240515045228.35928-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable IsDataFrame to is_data_frame
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h    | 4 ++--
 drivers/staging/rtl8192e/rtllib_rx.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index f69f4ca39fd5..0914ba37f42f 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -338,8 +338,8 @@ enum rt_op_mode {
 #define RTLLIB_QCTL_TID	      0x000F
 
 #define	FC_QOS_BIT					BIT(7)
-#define IsDataFrame(pdu)	(((pdu[0] & 0x0C) == 0x08) ? true : false)
-#define	is_legacy_data_frame(pdu)	(IsDataFrame(pdu) && (!(pdu[0]&FC_QOS_BIT)))
+#define is_data_frame(pdu)	(((pdu[0] & 0x0C) == 0x08) ? true : false)
+#define	is_legacy_data_frame(pdu)	(is_data_frame(pdu) && (!(pdu[0]&FC_QOS_BIT)))
 #define IsQoSDataFrame(pframe)			\
 	((*(u16 *)pframe&(IEEE80211_STYPE_QOS_DATA|RTLLIB_FTYPE_DATA)) ==	\
 	(IEEE80211_STYPE_QOS_DATA|RTLLIB_FTYPE_DATA))
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index f276e52aab08..d4714e193df4 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -881,7 +881,7 @@ static int rtllib_rx_check_duplicate(struct rtllib_device *ieee,
 
 	if (!ieee->ht_info->cur_rx_reorder_enable ||
 		!ieee->current_network.qos_data.active ||
-		!IsDataFrame(skb->data) ||
+		!is_data_frame(skb->data) ||
 		is_legacy_data_frame(skb->data)) {
 		if (!ieee80211_is_beacon(hdr->frame_control)) {
 			if (is_duplicate_packet(ieee, hdr))
-- 
2.30.2


