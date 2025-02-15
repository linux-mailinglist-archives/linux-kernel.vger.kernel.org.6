Return-Path: <linux-kernel+bounces-515827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E1EA36973
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8F0616F593
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0FB19C56D;
	Sat, 15 Feb 2025 00:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNimmc1U"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ECD2A8D0;
	Sat, 15 Feb 2025 00:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577919; cv=none; b=LkofittmVDC4M5YP2jZCdDm9oeu3QAd8G6/FA5/6pw2w1zoZE71m9lp3mE1AegeAp0YLE6LuzrJLJdQIKvMrIhojeSsCwFoCyOoi5qLAcaJuQ9NFrJ+SVFWLVSIxKm1cKLFRlUngjrwlLNJP9vPCpa0/PlAo4nHOHC6Oix4844A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577919; c=relaxed/simple;
	bh=tlnUo/drZpD4RYOQifGyN+9OXzAuy3Y1DCfVThMu564=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ac5BmLTdQq+0YHJDJi21TOfOoNqesVM0NdUAa+7/Tmb9gk/ecb7SqI2LkrfEDEVMBjaeBi3Q+gnBU7wX7sdbKPzP9LxOKV03I9jCaO03n7kXpeBcepllxFUv9DLe0K3hhjOw7UVpadCtewQ7HzRArHuAn0Mx6prMYh3nGqFWi0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNimmc1U; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220e83d65e5so35554235ad.1;
        Fri, 14 Feb 2025 16:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739577917; x=1740182717; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a+lScSJ9LmSRe7+AuGkyAbW9KCT1yWsEyguU2zwFGC4=;
        b=DNimmc1U3g0CGxUna0ugolLL1vpqCU4+d1YSD0P+KYYFKqx7A2+jLnAGQTVJz/ZzRR
         iDi7K0GjrtRnTolhfwkxPbO22A5zm3vQ6ExCYxNa0LkZZL8sUdg6PeyBR5e7xsAx9MSx
         +RK0PMq/sX0Mt3MSCtmtTd5m1WhLY5XlANh+obBrNMefdSJCfBPFCQQqBV1KzdkCWOo7
         hlKDrIHnQGX/BxPbnTjCf5CliKuh7PI+PACq4+aKOw9NLVaQb3BErppJCUNTgUQf9VDU
         mRYILydA1zSo56rBALd81jf0w9TinS3aNEF8yKyRJ0+rR2xDOQJKLGoRT7z+54pbfs6f
         v/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739577917; x=1740182717;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+lScSJ9LmSRe7+AuGkyAbW9KCT1yWsEyguU2zwFGC4=;
        b=o2cQtj/cSZOBbrpGcnJlLvVXw2/mxVjCSZhmIM7bv/z0G6cmY1rejbVbsm39wwfwHE
         lbg9Hv8/RS6PfMJr0nR+rrTrkSNLBv9Y+Krsm9dr5b50/hG2zfrOqBldQp5TqVKVcbOe
         2x826iOdswW+oqiyYlKbd41WyvKWrW6LdV57nLg0g+KQDyZf82wuiOxTXEbnGMScMyH6
         SjIxW1rTcsmPMcGVVIikVjn1vXu57Jj9RDxzOJY/zTww4azzQoLjK73R+rORNuSTIpIl
         eizabxfLBsMlgKVG5N+JtLXa4D66FXfAol/QB3BYjuCZ1IzT8r55AdFtEtBo8+vBVzzi
         IU5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFe9BnXZwZ2R5HHwmvTjsPbJSsimOG36zIfIqTEe6DaK2KVO8CyJ4EYgdWXrRxgvjQgafN95VFCA+Da/I8@vger.kernel.org, AJvYcCUImJFwsi/fOG4aODmTplUZYxHGU9q1oYiqZslN7zrwkGIXcSSe20zaz74+YYs7YvCDTgLMH9nUMi5+@vger.kernel.org, AJvYcCV6lmL/xBQ36mekYCInpicT571hwLri5HUfNtb6WcyySrRgms8hOQzOZIlk5o4RawIJ2sLD580w52iTPVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMNNxie6Fp2+Ps9PXM/IEt3/psRRzw5T1KALj4kEQ2LqoTy9iA
	j0H2Os/VIwb1LM4Z7ar8y62bymAde/iQ3rC0wG6/7w2TiBRnfDqq
X-Gm-Gg: ASbGncs98Yx7h4Y9rxFeo5jcsFwNl9YyPmeGYyjXbMIcRDfAJMNss1qvxK8bshuwM3v
	IYbMrloYIfcoFNCdPa/VeX2d1t1TpQMCUZtv6+cJFQqh/NNlLZ2yv+rtjfGC9FjoQjuBaG39ZVZ
	dq5mdbzj1TqPLoFp4MOn9oLgDEANODR3PH20ffNbhs1WQx9sF2BKwGzAQiJxXox0ipUF9uXRlHT
	+FyUWeJeeJ7bW4AwHO14aYWrSSuMOJacsfsYktU5yctVaIpwxTci+NFswgoawTuezKsM114O94u
	Lf8TP2ZarNw+bL+dFc/g4ywnuOoI5bn6cEp04HdEHVSG0vWL5pxq7qOicrqeUY4GR/i5dN4ijII
	ufyKe5uVVzA==
X-Google-Smtp-Source: AGHT+IEPIjvw4cmYTL9Hx6XsuDxSllH8Sdas9RtipG9OjZroTgCKr+EB27/N3ZXZNUXN3FaxP4oW+A==
X-Received: by 2002:a17:902:fc86:b0:220:f140:f7be with SMTP id d9443c01a7336-221040ac2eemr17296095ad.41.1739577917217;
        Fri, 14 Feb 2025 16:05:17 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220f26ea127sm15071155ad.96.2025.02.14.16.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:05:16 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Sat, 15 Feb 2025 10:02:51 +1000
Subject: [PATCH 18/27] ASoC: tas2764: Mark SW_RESET as volatile
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250215-apple-codec-changes-v1-18-723569b21b19@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=773;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=qo6yyujNAiynPY1OTmsJRYpCReZVUv81PffdNrMKl0A=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOnrb24/07OueJ6nTubXp1OsLdxDM42N/Bn1eY5dE12v/
 PZgbXBGRykLgxgXg6yYIsuGJiGP2UZsN/tFKvfCzGFlAhnCwMUpABNhO8DwvyZQv3DHAbveo37r
 dlVNn5GxZcOvRQxb9XnZDpj+c+jmbWP4Z6l543L85KlzMprOrv2s9o5v48+1gjvmPcqcuTKEfef
 sB5wA
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Hector Martin <marcan@marcan.st>

Since the bit is self-clearing.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2764.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index f8cf64c1777ad34fa7a42ca5316ffb980c63be29..409c54b41dda41d33e8501fff9de421c98f2541f 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -817,6 +817,7 @@ static const struct regmap_range_cfg tas2764_regmap_ranges[] = {
 static bool tas2764_volatile_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case TAS2764_SW_RST:
 	case TAS2764_INT_LTCH0 ... TAS2764_INT_LTCH4:
 	case TAS2764_INT_CLK_CFG:
 		return true;

-- 
2.48.1


