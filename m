Return-Path: <linux-kernel+bounces-515826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B887FA36976
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50AFF3B1662
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D07519ABB6;
	Sat, 15 Feb 2025 00:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAMjiDjj"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F40013CA9C;
	Sat, 15 Feb 2025 00:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577912; cv=none; b=RCtoiZQsE8OsibRZqUf/2PFm8R3Rk4ZObnKbTyohejOMqf7BSD+l+29nUwHpdkngm4TpWSBlk0PM0UNuDcUkHo+SFE9ASJWeUNzJk4EKMhKftNLS5vkgAIV0TQ4Wo028k9gdLfOytlvLnLXLeNGru9XvtqOovtR8XgOg+ri0KTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577912; c=relaxed/simple;
	bh=qrdHDdumFDDqJ0SZZmbMmJtJOOOmuZKYoWQGrKWzy8Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qdW32wFqpYJminMkOFHl2BaKFixgEFYE1VZeP103aAHB5EfK+Q/wChCJmEvYyZVQmRJ6jU6ULxwdSkky6II6iQwK3UGC98vsoD0fyrht+GBG3DQPG4eXZTyTK12OP9lo5sOpc6Rml3fDRAh9iZVM151kjIdJcb2uQmu4xycCaMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAMjiDjj; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220ca204d04so35680965ad.0;
        Fri, 14 Feb 2025 16:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739577910; x=1740182710; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zg/yh1Q3W91JaRTRaWlghJ3PTeHHtFr4YAjiGtG2cm0=;
        b=hAMjiDjj7xmECx6hrb95zofe2VfcjnktUsu9aVaTqxqvndJ5X/s/7IUaues2nh9OJu
         VYvr6MiswlT/8WQ6yJ/J9iL8b+yNVD2/D8Qp/jW55P/QSIg7CI943VGqg1Jc0qk1JP0z
         7Ep/m7ZdZhDCepzrp3q0n61ASRLJbjdsX/U58jn4AtFqzKJNVQOpbM+6bWZpnGT9DJdH
         cVYPAfi4Su+VH1fst1sPSE7gEY84g48Bti/zSLbjTRsFg2L2/gM06O5i+yl2t75P2zAa
         yA/lC/3DrSoPqOu4vytaigOmHIrw6QJz7vkowowlTg6/sc35i2SbSKZEuFZIsfOEvdrl
         BAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739577910; x=1740182710;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zg/yh1Q3W91JaRTRaWlghJ3PTeHHtFr4YAjiGtG2cm0=;
        b=wBMqHOsABkUQ2KQ/nt2UYnKBsOkA16roVa/kP3bv0H/dAKyHkkylF8wN3XasnBt5sx
         xKcVGkrQs/LKvsJlAciaYGyaoK7m/8bEfD9PHaT5xmYPSjUJT79PC34JRAOnF6f/uilx
         RIJp/zseYzRi73RyqMndBcmodyZGZ525YwTN31fhSbBA7VBlKcdCXyRANmVKNvlwCjdh
         iDV7rubnUYADM3iBr96CTL0eBjhD/1M4x6JXwARZQd5OfW6Jp0GnrRW15epCPFj4UHR5
         K3IOpz7AFnTwHZ+ES8hwIO85kZTTcWZPhQDGV+LK/Oq3dYwdUMps0cmsG3bFaVwMaow9
         j04Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOvonG5tNAVBoMazEO3PdC0pVkCcfqmmUyGX0LJ0dMK476Q/x31JyBJ3TsEfCJPKFKj8/2ltyP1DP5wcI=@vger.kernel.org, AJvYcCWoRdI9z7wLuRC5JflvYz07RcjqxEg70BL5/A5aM0hk5ucEuy3QRdlp6ZsLFUi/+BJ4f7s0YAbdBiOJ7KXS@vger.kernel.org, AJvYcCXMKUSOK4I0hUOmsmZsfWCBY0CQ9U5Z7Pk97lKuuakRl1rvUHeFf5Z2N9yb4Lk5CYeziT1aFYn2zeCY@vger.kernel.org
X-Gm-Message-State: AOJu0YxEkTMLsxIfmIn3XezghiWkQud/akzXj75IQOibGeIkTyUaJ8s8
	wVGVKWugWKFKU/6zUHAiyj/FO//0w9s/OwJgWzrFwl4Dfh3lQM5g
X-Gm-Gg: ASbGnctiW+FoPlyf6jaA24f4AE6R3ZgEh0+K28PRFxAGZ9WpxeKTYRxVIY6gxsuZqp2
	pOy5jrOMm5rBAo+PisQEjrPnWyhdjxJtkypW17VKHJEBEYegkxWHeCGWTztPgNYHBTGUeWbtoHi
	/YWTc9Xa+SVhkxezXl1/hZtATby1FQa/lhktzM7DdI1S7D0/wB0m23y5QXKoKzzsCDzFx6cdocv
	McAd//pBABAN9JYWkxh1OaCWVkkzWtnRWqioz/bq8eSKPmZfzlxFAk4uUTLBaZ2rL7zZI1xSamK
	necMVSr5dFxZ+qwlpEfDw761K530KL7gw2XQ51u+2RyLeANA3ThKROBhSX1msq/zYeGMaJMXU2F
	RiQNuP0KUEQ==
X-Google-Smtp-Source: AGHT+IHrsigKT7LpWl1KQKXia7FZvx3q49hOJoUjF+arH5gfvsW87Gu5wSgR1gXBYRimubCS+5z4yA==
X-Received: by 2002:a17:903:28f:b0:21f:85af:4bbf with SMTP id d9443c01a7336-22103f0d484mr15162445ad.20.1739577910471;
        Fri, 14 Feb 2025 16:05:10 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220f26ea127sm15071155ad.96.2025.02.14.16.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:05:09 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Sat, 15 Feb 2025 10:02:50 +1000
Subject: [PATCH 17/27] ASoC: tas2764: Add reg defaults for
 TAS2764_INT_CLK_CFG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250215-apple-codec-changes-v1-17-723569b21b19@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=715;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=z8NB5K9sZ3BbykPadxZ0GdwwAkJwiu32NmFXGmJTVY4=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOnrb27nchNijTT658Qhkvibd2pFhji7Y8Ck1RHf/xf/T
 s3S5fnYUcrCIMbFICumyLKhSchjthHbzX6Ryr0wc1iZQIYwcHEKwEQeSDAyNDoKHd//OXi91b17
 d3dc5e5SK9bhFVY2kNKLPe9m7lD2neF/QdSpwuuetwLv5HlNNZVqdYxsbb7c8viwmdKbZM0F3D+
 4AQ==
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Hector Martin <marcan@marcan.st>

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2764.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index d1eb8ee30415e335adf8e14d14aaa207c949ddcb..f8cf64c1777ad34fa7a42ca5316ffb980c63be29 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -799,6 +799,7 @@ static const struct reg_default tas2764_reg_defaults[] = {
 	{ TAS2764_TDM_CFG2, 0x0a },
 	{ TAS2764_TDM_CFG3, 0x10 },
 	{ TAS2764_TDM_CFG5, 0x42 },
+	{ TAS2764_INT_CLK_CFG, 0x19 },
 };
 
 static const struct regmap_range_cfg tas2764_regmap_ranges[] = {

-- 
2.48.1


