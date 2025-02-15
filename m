Return-Path: <linux-kernel+bounces-515819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B3DA36963
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93954188BCBA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC6D1624E1;
	Sat, 15 Feb 2025 00:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjnhQWxz"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1612D15EFA1;
	Sat, 15 Feb 2025 00:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577864; cv=none; b=KhoA7gGMNHoA/A8KD/320HypH/qg1CDveYaAuEIiTLEn6WNEQR8QHEIxBhbl3w08Ocl5E5NZNtf1+SJf3owiXc5o7MJ5THsXeRSEafzrIpoZkL4cuVzPUZss+rc1Lo+02En8z4OgiOxPvg+Wtbr4E3CS59lOonsJRPiE5cghfT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577864; c=relaxed/simple;
	bh=BrsmtKrvFG4a0pRLC8ZE/X1V1inlAR3fYFVsN8V+8RM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kX05ZshfYexlr3/yXQnPBud3Sm9Bi9WvnJ3gp7QZtoGOkPVrBmOuT32YjR/LCKMBvR5GDCDCoOzacShsT6BnTWKkd/e+FBRMIZQKqvzE1mbvqO355ffoBXB1zd5YxVixw29CPm1JiQYaFP45S85rixKBLxF6tXJlO3ZDfikOZhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjnhQWxz; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f7f1e1194so66199275ad.2;
        Fri, 14 Feb 2025 16:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739577862; x=1740182662; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ixZjGdAO8Dk62zg9tQbDbxW3/Bv3xplkaBFLbZEw6So=;
        b=QjnhQWxzK27+rKj8UwsTPAypCcTY3vYtk9sXYmNTB/+v40XtefYEP7sCjOpvRGxzk4
         04j5PCw5nFbw0XjQUgGpze/sFOkzjWt2qYl3y5QXWKAmOZYpy77yow1ijdKwi/GQTfDO
         oqzG0g7B+Nf0GqpfG2w4f7g+ILhQxFtnYLKgqH7xe25+hfPVTM9rWAqQTMnWeWbRHjjY
         P+IGAzua+fPvwFHnVqkci9a9w+0Qz79KP0BKFWeelJrZrBZavsU27ZgqLOI4eEwi0OAC
         q+xXB3C80GppSB4C1kR9RkXitbcedj5iUjqk3Th4rdF7foc/Acdib6WWBQXE9HgXqvk0
         RoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739577862; x=1740182662;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ixZjGdAO8Dk62zg9tQbDbxW3/Bv3xplkaBFLbZEw6So=;
        b=jLx+QDPLnOnRmM8DdNsRI3rnZE+QegXGqVK0JpQtbIjKcJijJVKupxIkeRz2qlXm+A
         bCnedzb5pqITXjvFR7nj75e0g/GliIH00Za86fBaDMEoIJBvpCadQkbpc/nytGMJL9E+
         HtOtdrc1qOPUJisousdY59JMT95dXHlFEzVts7fwRFZs/b2Aj0pRf99xCikV89i8MURI
         j4by00c8pEyeHd+KwriMQwXOFPAAX425YEl70Zc7sZMagv0DJTTFoJ7Pl4MyTMVzv00o
         +iyVW1u0m+DiSeiyKnHFczabSGkKqvu5o4lJk41myyNgpdB+osjPJIVeSSODoNuUACeH
         6ZOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAACW8Xh1ocGcj5i4rbD5JlnR391K/QiKCcwF290nY7rsG1c/PnTvlhhw3XGQp96jOdXzYI3RT+MZxcx8=@vger.kernel.org, AJvYcCWd2BMZBTa3rWk9dT+8BFpsyVAM2BQIPNiIgmudzwYrQ4z6LkduYeP8mD/7dUtxCPMH5TpyG2myYC0M@vger.kernel.org, AJvYcCXf0rlJaUARNvwsP1RPXbpi/L5AI3UCcWU5+i05mDWrvTlwk4szfj6Fe460+YGUSUPCoHybGnnO5A2lYcjR@vger.kernel.org
X-Gm-Message-State: AOJu0YxPQKiurJ+TtU1W5TTjbe5rSpZqRIkv02xAfmlNLj7/Duqs1ten
	5QjkkUDrYi8WrKkV3LYS/+fPUbOePEnezIiZz2jz7IE3x/S9eqoF
X-Gm-Gg: ASbGncvjifGuVm8Tmhi5ocXpITxD7ffJjxkAmAhY1u+BqOZpd64wzBzSc4wL7Pan0/b
	5vUbH2tM6tOCTQkzhbUmABoqL3pubz+dfkX7ivxMHmzsZ+VsItWPbweEh7fzyaP2NtXqIl6Nkuy
	QqK4r4ma++Ny66j/oEUYzfhF0b6CZBgrcLAxpEvGSx7jOP74guutjjdwXK5l09CTK1NqwM7Q788
	dZpNq/rNVJ1q/cboQWApZwLpkXH4xkvuBsyxP4oJxIzVhK+Ll6RxondiwITkDwjj1qEOxKY0LF6
	oo/9S0tug612+DNDsRtA32q/R0PJ6YejnYn9nx/Xj2gq/LSTJcIwJ5hiS0kvzrH1ARKihUSsowj
	RmY45ocMssA==
X-Google-Smtp-Source: AGHT+IFp1yZKld9F0Cpx76Y3+E+3whJ29wQruICe7YSErFWEjmY7MpEWjhpNNumZxM14egj0CnHZwQ==
X-Received: by 2002:a17:903:18b:b0:220:f1db:d96b with SMTP id d9443c01a7336-221040b134dmr17009285ad.41.1739577862428;
        Fri, 14 Feb 2025 16:04:22 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220f26ea127sm15071155ad.96.2025.02.14.16.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:04:22 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Sat, 15 Feb 2025 10:02:43 +1000
Subject: [PATCH 10/27] ASoC: tas2764: Raise regmap range maximum
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250215-apple-codec-changes-v1-10-723569b21b19@gmail.com>
References: <20250215-apple-codec-changes-v1-0-723569b21b19@gmail.com>
In-Reply-To: <20250215-apple-codec-changes-v1-0-723569b21b19@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shi Fu <shifu0704@thundersoft.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
 Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, James Calligeros <jcalligeros99@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1112;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=Qdi6b++lP5KdcPGK1hbEg+oAmtT+Af+O6mSzIrCVfDE=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOnrb24r4Res13B/l37UuWpxS+cuA25v79taiw2ubD4yR
 dhAePGUjlIWBjEuBlkxRZYNTUIes43YbvaLVO6FmcPKBDKEgYtTACZyZR3D/7CaisebP+xSVVz0
 p/7X5inzD647WJKY9CBP5EnWcqkMDzdGhi8mH45PyXvbqv7h/KOFZ1ReWH98nfvozZ2Kh3vO7nk
 U85cZAA==
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Martin Povišer <povik+lin@cutebit.org>

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2764.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index 4923291e7a62bd33f0f8a934599c527033feb971..e32ac441cf3cfc8fd8c6a1839c68e84ac9347150 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -726,7 +726,7 @@ static const struct reg_default tas2764_reg_defaults[] = {
 static const struct regmap_range_cfg tas2764_regmap_ranges[] = {
 	{
 		.range_min = 0,
-		.range_max = 1 * 128,
+		.range_max = 0xffff,
 		.selector_reg = TAS2764_PAGE,
 		.selector_mask = 0xff,
 		.selector_shift = 0,
@@ -758,7 +758,7 @@ static const struct regmap_config tas2764_i2c_regmap = {
 	.cache_type = REGCACHE_RBTREE,
 	.ranges = tas2764_regmap_ranges,
 	.num_ranges = ARRAY_SIZE(tas2764_regmap_ranges),
-	.max_register = 1 * 128,
+	.max_register = 0xffff,
 };
 
 static int tas2764_parse_dt(struct device *dev, struct tas2764_priv *tas2764)

-- 
2.48.1


