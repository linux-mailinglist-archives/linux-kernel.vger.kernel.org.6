Return-Path: <linux-kernel+bounces-395327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924F49BBC62
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0150EB217AE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE721CEE8A;
	Mon,  4 Nov 2024 17:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfCf81qr"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556D91CACD8
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742640; cv=none; b=dDvL4GCEL3P3sbsZOqN+2tRm6IxcCVIPl9x0D5pLKbM2LuPEeRaN1I242w8imbsQ6iX3zJ+AyOZ9bsZnfzs0GwAxRSRi+9vaweVAYatcW8DaYKkEag2s8QrTGwoEDcyfjShOqY8/Ed5MYQGXorUFartXYcOCBRUBqiN5KBx1Byo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742640; c=relaxed/simple;
	bh=8gIEE5erXu36bvNvc+z4d5bEU5WInaaHUZh7cwyNQlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHKgTEV7MZ6fFNxpniQ9TvHWRCP0D/sSPemZXeOgj93iwAulIkp2pFl4WjrVuLnD5pm7psz0eAk4TFiSnGJEiS7d5NAmdiKfYFYqWAwoL2bUCMtQavCb9lrf9GmAvfuvCDpV02OFUpsehCmPYzQlPrKfgDgS4yJ5d1+YPbM+yzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfCf81qr; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43161c0068bso37328095e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 09:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730742636; x=1731347436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYNa6oziVbKvDXACDgmoC/if6wLv2o++lD6SKYvehsE=;
        b=jfCf81qrmdhncrkFJc6jbhsfsjiRdUGwYMtDgVxVRNqKWj4MOxb8czezULWAtbiBT8
         imuaiMTMaBiXPgP+laX2/EPBdVSKjOXDPQjBVccOcA2lwnlLPbmDkCr7/NJnNMN1L7en
         C35JeXsVTxdB7eSODvKe9s5LQXcdpcnEWQWFgFStv5yZ1we8LkUqTZrMxFHjyZcT1cqt
         wNJoelxNWgiUr3AchioJdkzyzRnhqF3zW7oyF+sL3lVdnsKS+RL/7/D3gV1FvX12tP/B
         asykJ2arGj/W/lKGVoUhnDA6CiaY8nq6GLbnor6PVW5hMPsGpzaPGdZlxppcpGB+AVvQ
         EtfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730742636; x=1731347436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYNa6oziVbKvDXACDgmoC/if6wLv2o++lD6SKYvehsE=;
        b=nlc6v8BUAoJp2nf2+Z8fX8Y4aemovMmo67pfha2l+2BkkNr3DEU03wuiljuZDiVBNc
         ueRs0DIkHNHp7u5vsihXjrP19bqit9YLYHW0xMPN7QqgyYDaRPqy8oGV/go5PSijP2I2
         JtU9P3CsKVzSo1Z7YjwF8+qPD8SE0ehalOkVioFteWEcfGT4dacowIIH2W4DKM1mKyEs
         0LLeaEw38LbY2U+r1bmZQplr9p4Yfcz2vIeXNiJIK5JibjKbdOSscv7mLgE+vFb5FW8f
         /EC2a8Rldrq1yqyp6jA/l+DMbQP8rDj0HtXykc2nvTPyMdXgZOanPY/XaKTofbb4Pp/+
         gfrg==
X-Forwarded-Encrypted: i=1; AJvYcCVSEXawqPCdfxWRhisuGJm9KG/xuIlbjvFvwXCwhVYR3DWk4aiFJTVbln70g3mXRgOiSjzogfcC4tGgk1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOzH2e1HUBknZe5OKmRSdwKjE591+7XowWa/5D+rqpSr4nvIt+
	0YFxKCn9igzXSBrYPhMMgszTVA0B3NLuaLMHNHwpceZyi9C7gwRHAng+EOJ5
X-Google-Smtp-Source: AGHT+IGnVgxrx5ovonj/QGgF0+NBzmzt37wTCOqj6iqbkg5z7fiN4rOHRJNLIbNl8YLUTY1JcGmxVg==
X-Received: by 2002:a05:6000:1fa1:b0:37c:c842:a16e with SMTP id ffacd0b85a97d-381c7a47818mr8476760f8f.5.1730742635646;
        Mon, 04 Nov 2024 09:50:35 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7f80sm13839821f8f.20.2024.11.04.09.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 09:50:34 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	arnd@arndb.de,
	dan.carpenter@linaro.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH v3 10/12] staging: gpib: Remove GPIO14 and GPIO15 lines in lookup tables
Date: Mon,  4 Nov 2024 18:50:11 +0100
Message-ID: <20241104175014.12317-11-dpenkler@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241104175014.12317-1-dpenkler@gmail.com>
References: <20241104175014.12317-1-dpenkler@gmail.com>
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


