Return-Path: <linux-kernel+bounces-515823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC2CA36969
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC400189412B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A259B18C01E;
	Sat, 15 Feb 2025 00:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7vxy+0M"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8212D8624B;
	Sat, 15 Feb 2025 00:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577892; cv=none; b=lZ18LJD+mRz9mKvt1vZm7KldjT3407Z3YhH6F7ZxYD9E9gKdxRlJqkibA34SmkNyD8lz/9S/4Pe0meat49I/B2WSsjtF1RzKq4Nm2E7dQVknC09m0HAgVidzMvdQT5odTu212RPkDmH80K+ECP4a8+zvuPAYdVxUhUcQD99YJhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577892; c=relaxed/simple;
	bh=GEjShVsU6DYYV8fd1pZBUBYtNvYtHElztF/5Q8Jkp2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jQryAXAYH1Qe7UInMOWi7Rq8rwWJhRQk87OGUkufVYK+n7JDCDAAiFHiXbwAADs6UUCfnSZuhJfUCVnCP1ITerhmr0+agxhjoTJFRt61HHSWcJy53gFJuJlJg3LpdlcjXtJ9SrA33rVpf9RghUrEXpHy/e9MnvaS9ejnnj4vVWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7vxy+0M; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22100006bc8so12068155ad.0;
        Fri, 14 Feb 2025 16:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739577890; x=1740182690; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UzvCcM8dqvEuWNOieqFdaI3hJmC0KYxoNPBN84yDZV8=;
        b=c7vxy+0MF+6wVUoReryJKiM3B/PfhwG9IEdZFlBDelWojvmKuvVnt5XzqhfyyfGdtq
         yNS1Mieoi66Md07PlvEnioAlY5Bky6YK8RP3C+d96NWafqUvkOpdyn5rRjOrMfyxePN5
         E5kaMdmTDgkXxkBnLNdMyVI9oE6Gw+xjFKdXnckZfIfXjotr4H2WqCND0lIUqtslmpAE
         5ds9FdB8BXLPHN0zykDSAzxMQxaJEnya4q4O77JBNNHV5DUdAu0/o3ATokl8Oa9Z/i0V
         3Qv7CbhsZxti0kci2ekUPth0DjPWWhADJYH9AnBmIK17RzDMB+eX83W+SzrdE60j7ktD
         rwpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739577890; x=1740182690;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UzvCcM8dqvEuWNOieqFdaI3hJmC0KYxoNPBN84yDZV8=;
        b=DSbyI2NhoEDR8phmJlMtORRR4KmzcR4Q9KDwKFJ+jYgdPcrGYPVuj2ZSlSeLneTSfI
         H2+vRVBuWNtDGnAYhzhBqBHhLPm1Ved+3F6cnVIgbxA2hQl4IYRnUY6SC37TZi/RaBEw
         wAaytQ9ZQIV+lKLl/eGReYqTSttLkCzm+z3sns/Ao8uG7zHnVLMOtOT57KqxqQetNBtW
         OQgWDduuJlrraWW+FRXhgst//OwdsJb5hBrRjJsQa0axZrKIjyzyLjUJCU8IIqG7+VZ9
         o1OYq8u3l7qqe1g+luQe2GULwAfawDRbdDL/6Sn7SJC4x/FtJ9i5V10pKW3u8t0G0SXb
         g+3g==
X-Forwarded-Encrypted: i=1; AJvYcCWd3DwlcuLvDQgOmxc7XnbPrK/+M6XPAd2AnWwx6VNmijsvF9eTn4goa9X+n501gptqh6Y0bUlDyXJRxiR+@vger.kernel.org, AJvYcCX++YE1UnmG4pvaLQolScyZO3e0cTGUcqexkQ8BcyIVkaxcLSOEMlblqJsonrjRLbjnYzWkyeczcaqW@vger.kernel.org, AJvYcCX5YlDit6YJd0QEknwprJ5FJ6MpPeiiUZOnRShtq1TzB87H4+efwViFSpSH7wrEwVaRDf0eCBpbBl6ZT0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbaBZZZ9csBEadC5k2PDOkLBGLdToPm4ggSS0GsUfxMVx2pJv5
	PiAmpP4jlrmKg5kN8prj8JhWpYEaoe+VA5+CbXtthz5HfxirsZxx
X-Gm-Gg: ASbGncuHqqoU2yE1/vmuuM4b2pdTrzdw3MY0MRg6cWMjI8afCnNmhZJfI2A8166gSQn
	wKp+rRW8DSDQnUfrra1AYCtMt1AXch/0esGjOTX9xvX3B6DXnFKXrv0DtvH42unmcWKQF5eh5mb
	H9+AfnreVaOv3Nhh8roDJ6/a1a/sO9N6D8kHca022jfjmRlfK1V01kUq3CVd5hldLjf+Hli8bHp
	+DG5DPVwJhpZSsVBiXPDI14YtY3cNTA7aDBvoNSgYU6lSNfYAWOPHarlvkls9TGIdKDx2hCy4lT
	hzNoOgDFVGyix34c+nhige0eYWa5ygVOEJkI6KP8R8xzCLRZWl27v8HsJQMHlZdjMg/trm2fPJ9
	UkOSSJbH09w==
X-Google-Smtp-Source: AGHT+IHO3Y92kWYCbxnw51YFmW4Ac9MQWalph3Phy48CYG6q0zWxXYVjG3+VpTBbvTYtaNs+Fi0OFw==
X-Received: by 2002:a17:902:e886:b0:21f:9c48:254b with SMTP id d9443c01a7336-22104063669mr21120125ad.24.1739577889867;
        Fri, 14 Feb 2025 16:04:49 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220f26ea127sm15071155ad.96.2025.02.14.16.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:04:49 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Sat, 15 Feb 2025 10:02:47 +1000
Subject: [PATCH 14/27] ASoC: tas2764: Enable main IRQs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250215-apple-codec-changes-v1-14-723569b21b19@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=823;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=Yxab0QgYOU8S1cSF0st1NOwChnBkX/tdCsvBiQAenu0=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOnrb26T0BZ6dqI0pElib/Fx+diFRetU4zz+L5rLmtdnv
 +ZUP49PRykLgxgXg6yYIsuGJiGP2UZsN/tFKvfCzGFlAhnCwMUpABO5c5fhD+eCYHX92F+2yhsr
 Ndv2Z94UF74aepB9rWGghVFzjK1BE8P/5LRA7v3bN/W3HAr315lRt0Rau2O2osxd+WVSBS/PqsS
 zAQA=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Hector Martin <marcan@marcan.st>

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2764.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index 439e5bbd372cd467966ac9cac1c92e3e300fed54..75e49c85861b1eb6b312e8a455dadbbc7f54c836 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -660,7 +660,7 @@ static int tas2764_codec_probe(struct snd_soc_component *component)
 	regmap_reinit_cache(tas2764->regmap, &tas2764_i2c_regmap);
 
 	if (tas2764->irq) {
-		ret = snd_soc_component_write(tas2764->component, TAS2764_INT_MASK0, 0xff);
+		ret = snd_soc_component_write(tas2764->component, TAS2764_INT_MASK0, 0x00);
 		if (ret < 0)
 			return ret;
 

-- 
2.48.1


