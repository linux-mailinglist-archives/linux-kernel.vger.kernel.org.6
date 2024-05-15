Return-Path: <linux-kernel+bounces-179410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F27E8C5FDA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FA201C216BD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724D93D575;
	Wed, 15 May 2024 04:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="hEfLXf/e"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9063A1CA
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 04:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715748760; cv=none; b=QQdW2Yn7iMr/mBBTW04iyM809ImwToJGBJuRfX5PXO0Xwmi727h77jfj0iaZXq1/WVWQdIJjs2YA8/bkSW90T7Ve87raWyHJy8PCZQ3zvlbOZ6no8/vye1j8jdCvJHXP7VkEnbpfVaAWD5ChzJDuTkkuHXtt7THByd+pzwJax3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715748760; c=relaxed/simple;
	bh=M1i5JBTKlNnw4whqC38Y2pbLHdg0Zlv9LjifcLqh63I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jbdlzNTQNKCpFtJX8OuQ8LcWcU+9xDLzWbyrlYErKZjpdu9I0mWP305lS7SAk+8F9tGuDXyYU8u/UAebHM8M7PoCa2Qe2RAPyFQ7VrrxuXiS+ZtI68JA49SvjLqt0DUtyt/naGe8YGufn6q0aDPetQpFayr1dsIAA6JqEycs/ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=hEfLXf/e; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c99501317bso2878713b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1715748758; x=1716353558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpFlgt+m9Kz07NZXk8W/VHWKrgS7n4msDSGzYUnX+ns=;
        b=hEfLXf/eeGp6kKSCJJAVwhX88KA6qopu/mTORg92tT6Kv85nFr32fME0FAzdVE+jYd
         jBPED3bRq+VZir9Ngi78FOhFMITxqpNGUndycfeZt8ioegTZ2S/uzVhQKaSBhlub5hh4
         AproneMMN6xBqxWN06F8zU1h7Hs6ZfwMnQaa8VrO2SZ1ex95mTKMwmmvlzqKcsnSyenD
         8sTZlLflTlEuCEq3Ctl4dIKGOxCGwQXFEw8fVMJ0hpRYZ4qweoOMoLYfzzfgmUFAxYBr
         WRbQFr58goBBKCD5GbV4oukeRS4e8TTDvFGgAOcQQK06LXduKR7hrntoON733hoBV6Zg
         6/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715748758; x=1716353558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UpFlgt+m9Kz07NZXk8W/VHWKrgS7n4msDSGzYUnX+ns=;
        b=mstqXO1btDquSA1/g6W+q3lZSNmctnk8Zlt7XcR6w1wDNhbs9AIZRIBL1KPEh12xqw
         HgzkaevbHfQuNHuRD3zxgnQ3ggt57J6My5uIgnwMDkacKbJ1yIeY0FJPs/IwTRUhmor5
         7iZyUtUjS2tKk13TPPpxhsaDT0bl/VVYkK3YzuHP3citWFn2aYKEJRxx7gEt3lngZK6X
         /znXMTSBugI8cKAgPJ7U4swaSHzrI1MSxcYwBNCn6BxdocQNPCucIm2QfH/mU1gWa3FK
         uPqieySyKihTA55zsrMdc9KppZYTSToH0lXqO2r4vAk5N31Utrw+zOu6EmuyX9DAmDuM
         tBQg==
X-Forwarded-Encrypted: i=1; AJvYcCWDo8jQPR0Nubt8LxlpNok+4wJ8lQvCsPUqLV6e5g8YNShORlAucNhtBBicPWZRenEUjUva8ikmBzeC+0ISxvFZIX/3qOUA3QW+mCB7
X-Gm-Message-State: AOJu0YyrBr3AbsLz5mz5ZndD5hCEMNpBqZRYcD3SOdn5RfY/I7cPdQL3
	W8j3nliQQwswz4SLyThXZQ26dsd6JH/FrPgPD2zopMvHLRYtjLgiPnMmpAag7Bk=
X-Google-Smtp-Source: AGHT+IEy1CDCsDrqestxfvP2fDjq92ZAOn9EMoRVQIJUC1nXX9nNjFTbjLmuZ9aRwgAsI9uvqcEJgw==
X-Received: by 2002:a05:6808:86:b0:3c9:6987:1799 with SMTP id 5614622812f47-3c9970cf876mr14095003b6e.55.1715748757877;
        Tue, 14 May 2024 21:52:37 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a827fdsm10135035b3a.60.2024.05.14.21.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 21:52:37 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 05/31] Staging: rtl8192e: Rename variable bContainHTC
Date: Tue, 14 May 2024 21:52:02 -0700
Message-Id: <20240515045228.35928-6-tdavies@darkphysics.net>
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

Rename variable bContainHTC to contain_htc
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h    | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 40ec29434d68..ce0cd1f557c3 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -489,7 +489,7 @@ struct rtllib_rx_stats {
 	u8    RxBufShift;
 	bool  bIsAMPDU;
 	bool  bFirstMPDU;
-	bool  bContainHTC;
+	bool  contain_htc;
 	u32   RxPWDBAll;
 	u8    RxMIMOSignalStrength[4];
 	s8    RxMIMOSignalQuality[2];
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index d4dbf8052c30..4e7c491c0aaf 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -743,7 +743,7 @@ static u8 parse_subframe(struct rtllib_device *ieee, struct sk_buff *skb,
 
 	if (RTLLIB_QOS_HAS_SEQ(fc))
 		LLCOffset += 2;
-	if (rx_stats->bContainHTC)
+	if (rx_stats->contain_htc)
 		LLCOffset += sHTCLng;
 
 	ChkLength = LLCOffset;
@@ -862,7 +862,7 @@ static size_t rtllib_rx_get_hdrlen(struct rtllib_device *ieee,
 			netdev_info(ieee->dev, "%s: find HTCControl!\n",
 				    __func__);
 		hdrlen += 4;
-		rx_stats->bContainHTC = true;
+		rx_stats->contain_htc = true;
 	}
 
 	return hdrlen;
-- 
2.30.2


