Return-Path: <linux-kernel+bounces-515811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DF8A36957
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FF201716E1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4652D515;
	Sat, 15 Feb 2025 00:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBitMgDj"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72B1A945;
	Sat, 15 Feb 2025 00:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577808; cv=none; b=S/9UTbEEbg0rPJhbbiBZ1GDoYYfZcoEo38A9JRtTi7SnoDZIQzFYP11dR1qvnmkXQxz6ohkwZh7PvZJbS3nWYqlaLkEH6vn88k1xm/PqE+FyWmaxkCbHOmXHlDhLv0B8yGGafz8NH08hp/EbX1aL6BVDTsYyrxfb5iWpcsjCyDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577808; c=relaxed/simple;
	bh=FjWbE1IyJWiBoXxC1LiNt46y4bEDaFe1rHhJ8Z+mnXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OU95a1dqnEMSWRrZvDMo4RYiAaEhhSrR+dXcFMMn4xNCurx+CvM1QeHJpnaQ+iCVxxnLiblVhvv6gcBtGvfgRLdvHAFjrqiJiw8MEuPUwYV0Z5Wpt+NMGjuOLklUTfphP1eN2dCK1wjRpDn+xNKBgVWQCPETohKnxIkNXUxQEUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBitMgDj; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21c2f1b610dso64158455ad.0;
        Fri, 14 Feb 2025 16:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739577806; x=1740182606; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xn/Q2lqhDKgzbaB/ZxoHF8BZNbugJdXImWKll5J9PmI=;
        b=XBitMgDjvOK+506fT+JaNe5zKTW+0SUi4qcck9miqERpTQGtUBQd29K8ui4ogHSz7J
         rqofsMa6p7iUNKmz4VzNXqIoOvBwYRxWd11spfo2TgQc3SRs8SicTiBqTogTkJu7DtiU
         JQPHRCqmrdw1V+mKuUL3f/rlQjErfIloGjECSn1nk/l1IVNMc2EXet/odg8MBuJl8WRA
         3Nc1pPOtt9caEGVZA55w2zK0HTTUP2NfogmrZjOm42KORexKZrG05AT8N5njVMIepQ4Y
         afCpZOz0JaEmO3P6QqANHOSYYgCucx7ePwrnPoAkR/vSrehR0Ba+l/x27N3C0JcdQdRN
         oRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739577806; x=1740182606;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xn/Q2lqhDKgzbaB/ZxoHF8BZNbugJdXImWKll5J9PmI=;
        b=PSWji7DhlCJoxZHJebelNDImlvmynaczhTZpJSGlZqV+MqWaZvNjYF4f5rLCUD9EmS
         UGRdjwzKABzXxLzEQq/U4iilMF3r5p0E+ypWNysMJXTN7jAVobak6lzTKppLG6EX5g6k
         5R4c4Py9oq5Bo5OnWZWBHLMVjZXhNjQQNvvo4hC46DHFgtfwMyHTkX/rIOAtdPuz1dwb
         aS7H0k8HZt9oIKVoyF3QSWFVtM7qhjPa4VJM+7WjkaZ3XSefQqVtN3zrSywo80+TxQuq
         U4oOnGzYpXJx5T500UelL4wsmxJzO8LwEscYG/uFKKfdWuA6gEG5VS2di81aEpdRTG6T
         gc1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4xh6fSKHwuhN0J18jhlTVo31zWchChEObDxik8sIiar+8yDfB7X9swbuZ/UBpeLCK4KH2Jo4d1477@vger.kernel.org, AJvYcCXBFFmbQCLNe4/qmQVoQCyO4/AzrhqIEdPIAyG0udFar6g26oXFi5j3YOsMGky1kp0kFMGnaDZVgl5rhnm9@vger.kernel.org, AJvYcCXRV9W+8p+aRRCrs6ebj1lWE/88B8IbXS5d2zdj3U8s02D+R4GpTGyCO4gNODnEbs7KUg1Zs9nuRBjqew8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBZBS/zFyrMHVP0zNurLRrgXsDehTAs7nRR8tPmCLgtXylH6xR
	G7zBEDYoWsBqOxAkYuZlHtzphJadHt9GaUCst/QahPq+HDCluSjj
X-Gm-Gg: ASbGnct733Fgix2nEku7op+CdpxLbW9puWBVsUvOSixxMTOYAvUfpVEeDMI0NolLOj8
	t6e0h9gefNITHdHTCL9Ii5a0AXjgKGjtTxwUlFkxdUgwp17mN2h0Vawi1hM0xq2q1Q7wZED5Svj
	iTT3AZmZvtUKjHnaklL9Im2zCQkmEolsBtWTi2impUa2e4GkEDeP0nQVldH1EzM3FM7AIwZdUdj
	rzs/AJPNQ+4FV2aejtOrrRFc46PKoyX1/6mFAxfOu9xKU8gt8e2qT8KDHNdECXgKOCqPibu65XP
	mZQDC7rdNj7CfSzb1sYN3K2CAkw/focBBUFKua56YnBG5VYLapt7xm02esFv52Iv84y10shwVv6
	AN1MnspY1Pg==
X-Google-Smtp-Source: AGHT+IEkI7hAIl1/LT5bR+p2wRPhjrdUdQ9wBURhs9JdkCPWqEzufYRgQeE+ueEqyVaIvunbeiOQJA==
X-Received: by 2002:a17:903:2f8c:b0:216:2bd7:1c4a with SMTP id d9443c01a7336-22104062be3mr18807575ad.26.1739577806066;
        Fri, 14 Feb 2025 16:03:26 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220f26ea127sm15071155ad.96.2025.02.14.16.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:03:25 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Sat, 15 Feb 2025 10:02:35 +1000
Subject: [PATCH 02/27] ASoC: dt-bindings: tas2770: add compatible for
 TAS5770L
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250215-apple-codec-changes-v1-2-723569b21b19@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=736;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=FjWbE1IyJWiBoXxC1LiNt46y4bEDaFe1rHhJ8Z+mnXQ=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOnrb25p4rOT1lxXpLQqq//RgdLpdU8Ml0XvlFmu0lJ4s
 09l6vOdHaUsDGJcDLJiiiwbmoQ8Zhux3ewXqdwLM4eVCWQIAxenAEykchnD/7S0NUcdaoLr50V9
 q7o2gf9clPc/98Vmaq7cvdtmVBRy+jEydOtMcH3SEF90ttXP9MKb89n3xfXTji09It+bwP3bVJu
 LDwA=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

A variant of TAS2770 known as TAS5770L is found in Apple Silicon Macs.

Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 .../bindings/sound/ti,tas2770.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/ti,tas2770.yaml b/Documentation/devicetree/bindings/sound/ti,tas2770.yaml
index 5e7aea43acedc0f7d8c22e36debfe805c7ebe74f..8eab98a0f7a25a9c87d2c56fd0635ff8ecee17d0 100644
--- a/Documentation/devicetree/bindings/sound/ti,tas2770.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,tas2770.yaml
@@ -23,6 +23,7 @@ properties:
   compatible:
     enum:
       - ti,tas2770
+      - ti,tas5770l # Apple variant
 
   reg:
     maxItems: 1

-- 
2.48.1


