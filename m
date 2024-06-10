Return-Path: <linux-kernel+bounces-207686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC049901A75
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA1A282DF8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761B578C64;
	Mon, 10 Jun 2024 05:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="O9R4FBO6"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447EB76056
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998555; cv=none; b=mql7b+LB6/fpxdu3Xkp17ji8AoWms5YEd03FuWgWHeuZu2CxTQmYziL8NbBZCcxDwSqY/39dHoJOVm0Wwzmikq4RZQ4fmQfVAt6MN6kSpOpRRWSWXpOBnvP9pTUY0DOahgglGKRhSsXTKYGckj3HtPXPd2wSBBahnvBe+fzmwUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998555; c=relaxed/simple;
	bh=YSSCkUPWhj0gj8cLd3caar8iUYt4A9KmG6srrWfGldA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q1HsjyXrnSWq9H4pJt9nzl9vKDAHrcxQwWcwDwLGDor713itBLGoj9pBFI9UBrnhK0FmPc5GokXBs0O1NrtU7hTjRn3Q/Ka1k/nimeppRglRWrg6K0BQIBgdXhf06bPhsoCmTOz5m7stxVzrhZtPyuI+Wy9HHmczauOFPKD5Pp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=O9R4FBO6; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ff6fe215c6so3477264b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 22:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1717998554; x=1718603354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAqqY+LoHchiSuHoilEjGopTQ6RwSJwH85o8vDOSlSM=;
        b=O9R4FBO6erMppZuqYjMF2hONz0vzmm/f2I9j0Xd2+7qlSTsVoIzpLbwYuSB7UMN7kM
         H7r0KC5T4Oz7UePStDM3Css18wDFuJParBV6SZZRMmTY+lDjtJnz2ePzYPB3JGF9oNXt
         w97Sto98z11gjE7fIlrFndE5QByKA42NOOJXCsLyvCXnxMx3qIKM3nOvmvbPPiO7QI64
         UhVG14QkY2Q/OY/9CqJakFJ903gL8rzBNl0SkxdgLnD4HTR7uhGJ73YQ2EuUlyEXzXlo
         rEQaU341GiwsmKIhJOrSf5syEwHvK+AfhfhK3zh35sXNlRSDT8XdY+q4W/+iA2nvEKma
         fMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717998554; x=1718603354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAqqY+LoHchiSuHoilEjGopTQ6RwSJwH85o8vDOSlSM=;
        b=C/nHdrt1Bs2MFXc59ktR3DnQUeDU2gOBS+MQ76iK8zzUS0ZJToG848lNh5uDj4U567
         pXf1QsPWIhwg1ueWQ++mQ4IQGisLCt8gh+o7VbL/U97mnBl1p1OP6m/KEfd4N6byGwf8
         FcB8bNYxUpw17egVuCdjObzNM24UkJBdbVuknIKyHPyS2HMAwBtWJUxVDvZfoTxvKXrg
         P06VSEEFGXqyoH9Xrbfh3puV9dDPLFjSS4PCE9BJNx2jEIpz0CGe7bEAO2cxSpj+CkTo
         UW+NfmMuycyfTENw8R6Owbw8URXOX7P8UkBKfJt8gtMJVML3VSA9AO8peFtVfozxrnt9
         5W9w==
X-Forwarded-Encrypted: i=1; AJvYcCXkXVNY1fgrvh+E/siZukUee3JR/tGUlcWwcb5gsDnQTc1hfSJnkrfhWIwwhGOTWmQ4RwTHkEMP48n4lKwiIxF+tA7paBtw477FKoYL
X-Gm-Message-State: AOJu0YxhUdHfv55a4njDgs18Dz2EdY3D5TexInVK/lM1seOpNpIV2614
	Hfu1ILemTQKNTUEmQKfvDcts1n/nUSzDvz03MNnxzv4HL5AylW0lGJTjb8SSq7tlwq1/gNK9BT7
	lAxc=
X-Google-Smtp-Source: AGHT+IEBr9424Ps5fOgQVlG/45YsibmxXaLaRHS3ufkHJ+OHaEd1LLWJB41pwnvxEs+p8MQo0PyWIA==
X-Received: by 2002:a05:6a21:998d:b0:1b6:dffa:d6ec with SMTP id adf61e73a8af0-1b6dffad7a4mr2906556637.46.1717998553717;
        Sun, 09 Jun 2024 22:49:13 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f1aced64sm35653725ad.9.2024.06.09.22.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 22:49:13 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 23/24] Fix space/tab alignment to match open parenthesis in rtllib_tx.c
Date: Sun,  9 Jun 2024 22:44:48 -0700
Message-Id: <20240610054449.71316-24-tdavies@darkphysics.net>
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

Add spaces and tabs to fix warning: Alignment should match open
parenthesis.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_tx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index eb1668458e30..0f73dbf53c03 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -320,7 +320,7 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 }
 
 static void rtllib_query_short_preamble_mode(struct rtllib_device *ieee,
-					   struct cb_desc *tcb_desc)
+					     struct cb_desc *tcb_desc)
 {
 	tcb_desc->use_short_preamble = false;
 	if (tcb_desc->data_rate == 2)
@@ -331,7 +331,7 @@ static void rtllib_query_short_preamble_mode(struct rtllib_device *ieee,
 }
 
 static void rtllib_query_ht_cap_short_gi(struct rtllib_device *ieee,
-				      struct cb_desc *tcb_desc)
+					 struct cb_desc *tcb_desc)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
@@ -347,7 +347,7 @@ static void rtllib_query_ht_cap_short_gi(struct rtllib_device *ieee,
 }
 
 static void rtllib_query_bandwidth_mode(struct rtllib_device *ieee,
-				       struct cb_desc *tcb_desc)
+					struct cb_desc *tcb_desc)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
-- 
2.30.2


