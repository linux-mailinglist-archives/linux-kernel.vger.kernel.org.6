Return-Path: <linux-kernel+bounces-239760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFAD926506
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B4EF1C21529
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A9E18306F;
	Wed,  3 Jul 2024 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxWEiMrP"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63847181B9D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720021081; cv=none; b=Owdk+fibI42T19TyGQ1wVQniA5OxGliGDFzkAPyYnzNnWl8PvtQMZjnFDyjjuG+SI2ZlrOFpHbMkoALo/66JEhb8ROuTATHhMxVucfiAYQfaJj7jaqqDJvI71T9HJj+YzWVvnFL3KECQIGSK60RS4U6DEtX/qvhc9ab14f6osb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720021081; c=relaxed/simple;
	bh=8qNQgtXLskJ3JD7MfZcxgVkS1/WPuU7p5nRkqlB17Cw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AydyxuwNVHJkydBbqcWGNc1z6Jr1PVsdz/Cwx1QpMhIdXWZ8CUA3S/E7ZQe94aBBzGBz1F+dg0JG/BOB85pTCyVJohf9bvpElaSYxULqyacIcuslqDxbPPJKiuHor1jeO6Nyct6EFG4ZY0Mo+/Yjbo+j6E//5vhtrsgXRumNYLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxWEiMrP; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-58bac81f3f9so2803037a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 08:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720021078; x=1720625878; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7BZW6Clmw00UsBy9Or8rZFzpnqAmpBKvhrxIEAj2Ylg=;
        b=QxWEiMrPkxqvFyV/hjqNp57oCnf1aAeoNojY8EwpAR9tFXdvOzAEg1uw1f8GiUSd0l
         lXk8dMFQzWAIv8qX2+64mzLvXZSwOHMHxpqZIoEziesKSCSJ0dWBYB+NFCBxSDt5hrtj
         7FGtn3H3bN3OA6BS1OUFSmWkTgSvJp2gTvazeZ/0QXjWeW0jAG4aZh4JqgB8usyCAwCK
         g7pWfQyFYlxd9wuOycLS3t1ujoW/oApzpkRzsFzAisZvl8Uk9902X5pvgvya59DcY2Ly
         XxF/N2uQcDn+CuZyWEz81/JwTTKQaeE00fFHjXUmxcCpe87gugoAA/SN8IZLF7dnCHpr
         azmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720021078; x=1720625878;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7BZW6Clmw00UsBy9Or8rZFzpnqAmpBKvhrxIEAj2Ylg=;
        b=aO++Laze/BoAWQzwxZGCuTMTujr2iOmekCh1otCkqX8TVQ0CALUyL74xfW7pjOG1Oz
         JhafoibEsp2yD78Qk9ahmvrM5bUSHn7F2uGLjaRJJOLHd201fsrdKHDrBqBbvwnNTOeF
         cdcxWtSbWfKOwc0LEcsUP1mNbETt3pD6HJ8iJA25ncjlsJvyfezGlMwe7UnhnKVBQADL
         SYVh2SJ+UZkYTTwp+VdZ9rAQGzZgXqbChrk7XPsNkF2znBjt8yzpF3zzwWMCwxU8pFrY
         nmVN2uYEdjO7j0rcM8+9DefyGK4ap/gJmLbraSDunjfLiVHVESGJTSAszY5m4ZQ6ldR6
         y96g==
X-Gm-Message-State: AOJu0Yy2qj4oQ+5Tsj4wBfH/QfZikShAvBSRVjsKcx+717yZeKnJywX+
	dWareQPZNF6RVjASZ/vaqDTddglDCzB8HyAH1iHcczOzKIU5kiOL
X-Google-Smtp-Source: AGHT+IGFCEGCVL8xe48SJMKTBOgWG1qXrZGAA6LbS42EdNNuflIBA1IaCbstX5MqqaIgbYZM1pm5bQ==
X-Received: by 2002:a05:6402:84b:b0:57a:1e0a:379f with SMTP id 4fb4d7f45d1cf-5879efce90dmr7971249a12.16.1720021077494;
        Wed, 03 Jul 2024 08:37:57 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5861503b4c5sm7119512a12.93.2024.07.03.08.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 08:37:57 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 03 Jul 2024 17:37:34 +0200
Subject: [PATCH 1/7] mfd: da9062-core: Constify struct regmap_config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-mfd-const-regmap_config-v1-1-aa6cd00a03bd@gmail.com>
References: <20240703-mfd-const-regmap_config-v1-0-aa6cd00a03bd@gmail.com>
In-Reply-To: <20240703-mfd-const-regmap_config-v1-0-aa6cd00a03bd@gmail.com>
To: Support Opensource <support.opensource@diasemi.com>, 
 Lee Jones <lee@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, Xu Yilun <yilun.xu@intel.com>, 
 Tom Rix <trix@redhat.com>
Cc: linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720021075; l=1046;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=8qNQgtXLskJ3JD7MfZcxgVkS1/WPuU7p5nRkqlB17Cw=;
 b=tA0HRKlqggTv2Fd1V19K86G+Yyi45xWEVdHkWl7kQMrbRuJ6OCFOtxuinqMC1lblNZPbVt9pP
 aAkD4iyxYcuCXevg9WBtFHzkib+xOP+J8NejZoUYzN5IZtAIKb803LS
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

`da9061_regmap_config` and `da9062_regmap_config` are not modified and
can be declared as const to move their data to a read-only section.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/mfd/da9062-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index dbbc4779170a..5e55c6cbf5e0 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -470,7 +470,7 @@ static const struct regmap_range_cfg da9061_range_cfg[] = {
 	}
 };
 
-static struct regmap_config da9061_regmap_config = {
+static const struct regmap_config da9061_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.ranges = da9061_range_cfg,
@@ -576,7 +576,7 @@ static const struct regmap_range_cfg da9062_range_cfg[] = {
 	}
 };
 
-static struct regmap_config da9062_regmap_config = {
+static const struct regmap_config da9062_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.ranges = da9062_range_cfg,

-- 
2.40.1


