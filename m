Return-Path: <linux-kernel+bounces-393993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06199BA852
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 22:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E3411C20AD2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 21:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A83419CC3A;
	Sun,  3 Nov 2024 21:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4SrgUmj"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10E0192595
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 21:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730669204; cv=none; b=EsNqXHpbbS8T6x9sYvwiUM9crInuC4zEuypv+Z+VCqaqL966LHM2L7wNgt56joWYGFvnF57cCRp2Gzb5zUXlGg7U1/6FOI5d9OXGxx9XlvMDT3OdOgSW3SZH3GCCiM5n5bsZCs7q/G2cPe3bwVjJHdfsqpzt0Z2WneUOM1hC19E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730669204; c=relaxed/simple;
	bh=8gIEE5erXu36bvNvc+z4d5bEU5WInaaHUZh7cwyNQlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0ELiWVZ8mYclDBoX6XRZm93TDEHDK7W+vOgcugIspj0UjDf9041md04Ig3w+lKbwAHF/jJ0sHHgQ6abEjUCuhExMPL38d+2qYgdXb99XjKthzA/9PLFIFPgRBGbUqUV4eUS20qYAFFKE4+jjutYOVIgFWp+OwyFm/XDTAOuJF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4SrgUmj; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43168d9c6c9so29213745e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 13:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730669201; x=1731274001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYNa6oziVbKvDXACDgmoC/if6wLv2o++lD6SKYvehsE=;
        b=W4SrgUmjsaNc3syAbV9BSWUt4haKtPC/YgTD2lhPEfQRQ1B3By+lbXJJcUKVlhQW6j
         pI026k52zdnw1gfXemxBooQ70QKePXTL4Hps5+pOVODwZEQLv4V7pun34X/oA/J4fGhg
         Gttarhw/wiYuU53JZWcVsXyGHWIovvxjfgkqJHUhxE+bTovujeajQHTutZyEJjLTfDJG
         6Dxieez9NeipqoOkOSa3zogd79b56TKIXNjNcdQZvTqZSW++ROsBuzET56Nw2nHUh+R2
         iAnVyeNsWHc/dyEpWfzOW1VcurH51tk44u4znW/DSo6OUcL+r1mWwKTb2Qkdz7uZ65WY
         7Y4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730669201; x=1731274001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYNa6oziVbKvDXACDgmoC/if6wLv2o++lD6SKYvehsE=;
        b=pvlk7PlgJIADbM8WwTd7BOHlP23wgksuZl87/XfFCRl/fJsfPsnMlYAuOi4nZQzDkd
         PtEko1Pzhdt1x27LKSXJohps3dIihXMyjEWuigfGU9qvBBH362oJuDIXstiyQYHTbgVi
         nKKhdolEPtZ9Y7l/UV3hPPnzqcHaXrX3xKL5gaE/oymXcNEyyAQE32Azuf/pLlG0Lg4V
         PQHqvxJ0YEowhIj9bGMcCaULMw/zB0cecZgOkB88XyRxZX/13G6T6zO40Xq2Z+WllffJ
         d37eESzHzDfeFmGraIdcZyLVNiVI8unSpk+QOiAVZXW7pESbQMeaTxJ074pwRHcEg9W2
         Z/3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU31OQhi/sGRrWeqXMZ31OP/6+J2kMTVAbJNHQQxnf0Yd5sWxw6c/8mcLYH08p8dWuX5usPg/v4c/TQTnU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/W+IBoFXB2VZ0jNbxqmpAclzYpctxXjTNA7EOFuQPMmPHriTE
	mFZhKvPDwTz0XNoFkFIz/yDMJhSfYCOS+wZr/6IU127CDCxud1p5
X-Google-Smtp-Source: AGHT+IHb3YtEMHY1k6tmQKANEvYPRbKK2yHTsy4WyjwdvdVI0PZbmxznTKoqhcHA21dXqtRaUQHOrA==
X-Received: by 2002:a05:600c:4e8e:b0:42c:b45d:4a7b with SMTP id 5b1f17b1804b1-4319ad146ebmr272532335e9.25.1730669201064;
        Sun, 03 Nov 2024 13:26:41 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd910718sm166150385e9.12.2024.11.03.13.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 13:26:40 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	arnd@arndb.de,
	dan.carpenter@linaro.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 09/11] staging: gpib: Remove GPIO14 and GPIO15 lines in lookup tables
Date: Sun,  3 Nov 2024 22:26:15 +0100
Message-ID: <20241103212617.13076-10-dpenkler@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241103212617.13076-1-dpenkler@gmail.com>
References: <20241103212617.13076-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GPIO14 and GPIO15 are not used in the current pin maps

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/gpio/gpib_bitbang.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/gpib/gpio/gpib_bitbang.c b/drivers/staging/gpib/gpio/gpib_bitbang.c
index fc8502379c28..78032af5061c 100644
--- a/drivers/staging/gpib/gpio/gpib_bitbang.c
+++ b/drivers/staging/gpib/gpio/gpib_bitbang.c
@@ -216,8 +216,6 @@ static struct gpiod_lookup_table gpib_gpio_table_0 = {
 		GPIO_LOOKUP_IDX("SPI_SCLK",	  U16_MAX, NULL, 11, GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP_IDX("GPIO12",	  U16_MAX, NULL, 12, GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP_IDX("GPIO13",	  U16_MAX, NULL, 13, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("TXD0",	  U16_MAX, NULL, 14, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("RXD0",	  U16_MAX, NULL, 15, GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP_IDX("GPIO16",	  U16_MAX, NULL, 16, GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP_IDX("GPIO17",	  U16_MAX, NULL, 17, GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP_IDX("GPIO18",	  U16_MAX, NULL, 18, GPIO_ACTIVE_HIGH),
@@ -248,8 +246,6 @@ static struct gpiod_lookup_table gpib_gpio_table_2 = {
 		GPIO_LOOKUP_IDX("GPIO11", U16_MAX, NULL, 11, GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP_IDX("GPIO12", U16_MAX, NULL, 12, GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP_IDX("GPIO13", U16_MAX, NULL, 13, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO14", U16_MAX, NULL, 14, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO15", U16_MAX, NULL, 15, GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP_IDX("GPIO16", U16_MAX, NULL, 16, GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP_IDX("GPIO17", U16_MAX, NULL, 17, GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP_IDX("GPIO18", U16_MAX, NULL, 18, GPIO_ACTIVE_HIGH),
-- 
2.46.2


