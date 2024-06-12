Return-Path: <linux-kernel+bounces-210882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14A190499C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 046821C2399F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CC084A54;
	Wed, 12 Jun 2024 03:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="TJAMnp/1"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F10A839E5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718162575; cv=none; b=fugmRNmo0eEbeJIamaCcJqdA+BxLafU1BRCYtKy7uw5UtDH/GVgwIp3nprQnv4P8MbCs3A+ZmvPtjxmQKFbJ+pGhuHXB8S/wxJZwEMqEiKLR7pTVRUAhXQQ8CPp+GuwrLz5i2dXWhMVQHMuX0xumbLUxkDmstp1f6/Y0i4evTjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718162575; c=relaxed/simple;
	bh=+hkSQsHkHuNFjHWC3sYMEtLK6wx5aCSN95mhnv+qW/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sRvh7d/OAQk2XzYOkKEpfPFhYWCQUog58v+xWrgFqwVmCdRbIhb9q1/EC8dlFX/gc4t2JuG9YeYF8jzeSg5CijkW/xrok5SjA00Q2Opq3TI0eDz2KbZSjdLzqaTCP8hrCsE9T/phMzf/Vbuo29wxwh2R/DXWFgCE8S/YIvWtB84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=TJAMnp/1; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5b52b0d0dfeso3181229eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1718162572; x=1718767372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nb8O2azIXxdt4GxCY1fQnfF3h/5DHYmDEmQNF62iLI=;
        b=TJAMnp/1mAyMhE/2F98FiREC10pC8aO0V09fKEVjv8MpiIihI/OzxLUprBozlD+3QX
         wkLntI8BdWw2RSxiEabzPwcdAdTsMqI9qdm1pryWfPlMLhCs1UFZs6MYEOJqfi8NWFif
         wVI7k10LRSIwoFq83U5Nwj+Mrs+/J74JGsiik8rXEjvREDYFEPDAmXtMtG5x/7JOvWAP
         fTkqWRr9wabto1dJ56WcJ/Vujbwne9AvMFf9tVYeCkW5R+mLQJT/XnFh54VcSqhpUW5j
         hYNv0UV8sB3u23K9IQxbe56GfUg/WiPeCzd4Ii6G9uujp6MMFQlx/gHV3zITJ8Z7VoUO
         sefw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718162572; x=1718767372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nb8O2azIXxdt4GxCY1fQnfF3h/5DHYmDEmQNF62iLI=;
        b=BODPcn6cdKZYUas+vH4W6WKOLcbNK8TCAAuNmZUnR7lbWjZas8vPOJq8ahczSaUfGh
         wMIPsCDnNqT+pnf8V8Nrsb9jrX/2iDIDks8ibLzNeNwlHlZ3OcVyxxVluE2jC7B/3UuV
         fjujSN2586PvlPvSm17QXLMS6eA9BtvXiV4Z0plcywb29U93yUJ7IYq1gqKbcZeA1UwQ
         4tl4G2EQ38YjSDU9kQXcW/QqB6zdNEwegP/3JAeVrmWoe4DW3Lru5OqEYY8lYPHLT9X+
         q8x9jBKMRGQbiGnI9OqRHqTnBDHkjbpuPF/izJDxruoQHzX3okU9NOuYXr544aAh0fiw
         bAIA==
X-Forwarded-Encrypted: i=1; AJvYcCXRy+FmBi7hGqY6535SeiOXaiVgCdL0slEiK37MbPyoi7q0oFiM76ydVR/r3O0i97G33GoAAW8+tUD+JUk1rvQzJSXaKHg8aiylCa5S
X-Gm-Message-State: AOJu0Yw8Uz8Dx/KEjzWqHeTH9xNQGzqvnoToKS/uwbqCMQmvMAnHYAVW
	KWxxmIeP9+RTmSL55ZFOnGQl2yze19j4m+YDOvGeV6UN4OtULAxENkrQIaeq/Pc=
X-Google-Smtp-Source: AGHT+IEnGI7AT5ngPRYTMTtEcNd8mtD023Qkq2VHWARRINuGHnkE+kMqpXdURqn/Qa4rIy63aBHtsQ==
X-Received: by 2002:a05:6358:6f9c:b0:19f:4d27:fb76 with SMTP id e5c5f4694b2df-19f69cf707emr88629155d.7.1718162572397;
        Tue, 11 Jun 2024 20:22:52 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e8e8a84949sm5635411a12.32.2024.06.11.20.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 20:22:52 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 23/24] Staging: rtl8192e: Fix alignment to match open parenthesis in rtllib_tx.c
Date: Tue, 11 Jun 2024 20:22:29 -0700
Message-Id: <20240612032230.9738-24-tdavies@darkphysics.net>
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

Add spaces and tabs to fix warning: Alignment should match open
parenthesis.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: Update subject prefix with 'Staging: rtl8192e:'
 drivers/staging/rtl8192e/rtllib_tx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 2f5005689a36..8e2abd16eb86 100644
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


