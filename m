Return-Path: <linux-kernel+bounces-179422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D49598C5FE6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11FB21C22A60
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2DE5C60D;
	Wed, 15 May 2024 04:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="VwVgQo4m"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8813254903
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 04:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715748768; cv=none; b=UFL1wzfhStovhIrO/mcohw4J+9GuEJ1RZGlTWfqBqoXlDDpaf+ZXbutJ2p7pxrJnb+hMZYyJL9YLnQWnVvvqUpkVAmUHDErNpJm0b5RcGdjy9nPCeNANkEh1iKVufhoGjTX2FjK+STHS4CGhOo5EAyDtA7YJhg/OXuk2w+VhQ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715748768; c=relaxed/simple;
	bh=kmfTsVVKKi0K3wI96U4qSEQ5mx4UjunkStIgtro1AxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jspr7icnxe/7n8rhkI0qi150qS6NfjvljVCVsPP1e7uRnmwOK4ibdoLiFXY0mTJOXdxBxxBVEv/nPiGYjhii+zxQy+BdBT4J0LgGynOYqjEYVzEt07H5Cv8+uHGQ+1GRScJ/MeZUA+8cjaoVrMyyNRaDN8CRXaPfxmDcSM4Lkrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=VwVgQo4m; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c96fef64b3so3869417b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1715748766; x=1716353566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SO1LlzefJj0jEx0cVt/CtzEv69TIbxurb5KVwdnmKgs=;
        b=VwVgQo4mliXYvjVayeG1NvXeLOBqoIbObwoQDnAHdpMf3NX9MJvke4AQlulsAA1eJ6
         71VVvKaVnwOG3v73Yp7gbgraw0mYQB+elvem6WfBWNeO9q+p68nkr8Vb707BE1HaBvrZ
         OsdMmYx74JoU0SoDptA7QBIbsvUWKHZEclLnv/B4LY4HX4GtdlBxnPOUv24zy2JE6yKx
         atp2Uxl5B5Lq2qiOdGy4O1MYojqLJNjDWEsap44ffrEiShspNMMnSJ8u/JQjZ5KqxKbk
         +ttvsiccmrYY32txeUt26SpcBF0De2/2gslNPfIyeG5BLc6gEjagHGfmLxZsdpYq5XFg
         c5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715748766; x=1716353566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SO1LlzefJj0jEx0cVt/CtzEv69TIbxurb5KVwdnmKgs=;
        b=RvY6hc4fysaieZ09X4660lKhvvsou3EzBRdNuG+cpHV1jOZmm1VFTp7nYbFqMAL+vN
         GHVoPs3uo+BzahmV22gPseMYgEYzXN2ugrNH6ncTdYQCoAvz1SC5fAsA/T/qTHns6rtr
         53okhhQWXqib/a/xyl9pRYyuSx+PmRlGTbvMVIdA0xqqOZQlqdhbA3aOmwhxPffchoMK
         IsR0svr+hlR1plP8aYnxHKKany3l1g3g1z5KMVCuzIK6ZT9wvQtcRpeudF23veyjEPCI
         l2L/1FjDZDfEdarMs1VrXN9SxBkITbEA8wgwGrSuIyvcOya6N2u4E5WNoO5vTrRB4Bx8
         cogA==
X-Forwarded-Encrypted: i=1; AJvYcCWuUTNamv94APAh2vyR+oNRsj33Z5UMUDz3okNRtNZ+nnuLxM06PGXGsRQLSt1/Ilyn41Zn6Rp4T2AS5PFccpzY3k9xow6TxTaTEI4J
X-Gm-Message-State: AOJu0YxMv8Kh8Jk9rOrdSnaFtvNXwXHBaVFoZpcF8JXP4Q8kBYzgVaN3
	RQIQD+vq+2+LJbw9SRlxL6QHWeU1o9E1UzfQteYH8IXRVXS601Rvvm8beOeHvTc=
X-Google-Smtp-Source: AGHT+IErgHwGe3H39DkA2kst51IXK2X5EEwrOaq4xszCJiJUnT99jfyGTZo7CdqMZ0jgaBlobKy3ig==
X-Received: by 2002:aca:111a:0:b0:3c9:950c:2227 with SMTP id 5614622812f47-3c9970cc742mr16098502b6e.45.1715748766601;
        Tue, 14 May 2024 21:52:46 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a827fdsm10135035b3a.60.2024.05.14.21.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 21:52:46 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 17/31] Staging: rtl8192e: Rename variable nPadding_Length
Date: Tue, 14 May 2024 21:52:14 -0700
Message-Id: <20240515045228.35928-18-tdavies@darkphysics.net>
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

Rename variable nPadding_Length to npadding_length
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index fb679229f173..0db75fa7da1e 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -732,7 +732,7 @@ static u8 parse_subframe(struct rtllib_device *ieee, struct sk_buff *skb,
 	u16		ChkLength;
 	bool		is_aggregate_frame = false;
 	u16		nSubframe_Length;
-	u8		nPadding_Length = 0;
+	u8		npadding_length = 0;
 	u16		SeqNum = 0;
 	struct sk_buff *sub_skb;
 	/* just for debug purpose */
@@ -833,15 +833,15 @@ static u8 parse_subframe(struct rtllib_device *ieee, struct sk_buff *skb,
 		skb_pull(skb, nSubframe_Length);
 
 		if (skb->len != 0) {
-			nPadding_Length = 4 - ((nSubframe_Length +
+			npadding_length = 4 - ((nSubframe_Length +
 					  ETHERNET_HEADER_SIZE) % 4);
-			if (nPadding_Length == 4)
-				nPadding_Length = 0;
+			if (npadding_length == 4)
+				npadding_length = 0;
 
-			if (skb->len < nPadding_Length)
+			if (skb->len < npadding_length)
 				return 0;
 
-			skb_pull(skb, nPadding_Length);
+			skb_pull(skb, npadding_length);
 		}
 	}
 
-- 
2.30.2


