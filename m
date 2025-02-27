Return-Path: <linux-kernel+bounces-536231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D139A47D2A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C978C7AA80A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414ED22DFB3;
	Thu, 27 Feb 2025 12:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ys2A8S2U"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE7622D790;
	Thu, 27 Feb 2025 12:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658149; cv=none; b=siTpeFaCvwF317PNzP8OA3wVUytJfsZnJ1ESUBDV/YFBmI50J1nG5AGS375rkyMh6O90rBPfmW8XqsiKM7rrJrnueNjGuDJwmv2N0zCh9W738naLfIq63VIyjEXxvghImiC+IZqoqXzx982858CPam5J4IcKAHC/bnmwVBWgMBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658149; c=relaxed/simple;
	bh=6I6kevtGt5Xf+IFLuo9iZloEKxJU0BXvwM8XaAJw7vM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bRI9A3TTRCUofiLmVPYIFx9UysErxqYyzckfqXnQvfhv+O4xOxwTjocpIftm/hRnsZkkRtDc2La51Z9nGlGxZheJwud7N0zEbGPHEphWY9+/NdCTdeqb41ml2XitW8E1KlwiZ0muyFEOd0ytPkZq+/JaoQxyB+dpnUhAyV5pWFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ys2A8S2U; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22334203781so26104175ad.0;
        Thu, 27 Feb 2025 04:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740658147; x=1741262947; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DJObarpxJa//O5mByq2DhOQ2HixpCHNevhGqWbFtG6s=;
        b=Ys2A8S2UzTU7R86zr+Xv9Jv8U7KlzJ78O7+FVw4UIOFkmz6GR3mFM7unczihvf6XbP
         w+7n/jiYLaYb6z4S4sRrR49GW0Waen7YjVzIPrkPq6c5Jp6DnkxFKrSmMY09DUR++e/m
         SypiUVrgwtVYNGc12+LBo4Jonbv/EKfAta2uulaveRriM4e2eM9KYNSJLGyKIM0z9gIZ
         G6tnLwsDAaXvZrf7i+bcGXDkRSmVWbV5sjssvh7k0s6ZbvINrU2tU5F+XWwgdj+M5qAO
         cDXEA99V79q3A9O5CqQ5C8FaXz1lWhu1WwGevQ2K/fSmDBNmtj7S9znFQRT1DaCi0KJE
         O88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740658147; x=1741262947;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJObarpxJa//O5mByq2DhOQ2HixpCHNevhGqWbFtG6s=;
        b=c5ybS9SyC5C2KNj9CMkcfzxQPag3g1BZBLfBzNUtbE0qFmOu8cZEHyP5cy4HgbcPe0
         RJ+rI/VIjsCugI/HLyfvAjDfH8kq+O5S4aJMRKDqmb/PAVy0zWexkJoh7yM30UbuAbhG
         P5bw408qFaHr9aNt2kk+SKuix9Ffy9nUgODuGh7+4rQ6Q9mXQXbfSOhBdLju0kdN+eIt
         T03x0v4Y4A8Qpl4N8yS2hU7O09L/EjMQY8oeT41Ez7IJ34qtf9+ZWK8NGEzKs3rQUHCg
         b+QcxjPMAm+HDyz370twoHSAnHrQHpDWIprcx7WsFMUylDo4nv1r34wdRYeBP6Bunu7+
         w3hA==
X-Forwarded-Encrypted: i=1; AJvYcCV9EAJQk3qB9i1X4BOetJzE3z5/TNGqjiHebWW4VJkGRGv8ZOkkNHxjz2oG/BmQXI4Oc06ZGuxMxpccchM=@vger.kernel.org, AJvYcCVVOJnxx6vfubkB7gKpLGuxGaAAUQPJCEcKOCHxw2jPQia0NR6mEssql3PlFFpfkBcTBevY435WJ/dJ@vger.kernel.org, AJvYcCWf5zbzgoMoVIvocg9JMY1e/xBnQQ4fFGEhTR0fVTlLNgZ3UgSmDBcf5W8uEkhxG6HdU23/3+1XOB1iYkM7@vger.kernel.org, AJvYcCWwUvAfLWceDpDOyO8es9rMbWcMdASYvul76WgVsUDDFw4SZoqmph1Ir5KozXUFCynHw0glso2wC8tt3WU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAe7Wet3GjeU1TPxjvJ9j3pbdplyjUlk/e14/4kRND/WYqINM/
	xwtq/YJvG7SU2DaZNQEzMOeL8l9GO4I3uvsgtEdStiSM8Vde1IIT
X-Gm-Gg: ASbGncuUWGIJ1y2h6YGWRUDrxMU+ag2wf7p6tLqU7y5PWUUrRsle6x20tY7m7dATygi
	tfOD/XNuRQAae9lNG1kty163xxgLlvMzRS5LrPCoNBIi/KLJEgLvtG8OvZBa+tf0twLvDjTqSHK
	uzdTWLhEDiEV2I/e0/TyzUzPd/PB+W93d6ViBfj+XQq8LUy8PJDwM4kwh8vNYWKHbmykywN0QoA
	2TVxJZFtBguenmuwn3ERHMi3vnTZgYUNjt5zHxVWywUBabLtgR1FkHZvhVtaIVvapmMxIeZWn3y
	5hrWDH6iXOZ2MAQk3oV0QuO8cpMnqRzPuUd+YzdY9mZscc+1R3gjSwU2tfS58MDqpMOXKMG/oAr
	jy4Av8TBPQQOc4Y9XoBYw
X-Google-Smtp-Source: AGHT+IF5/22JZWa7rQmFG5HLtLWGAWukMonyo6ZnXXa9jydidl+I5GkF7eR1H3SEQLaPfx5JePYS1g==
X-Received: by 2002:a05:6a21:3a83:b0:1ee:ab52:b8cc with SMTP id adf61e73a8af0-1f2e399e4acmr4948662637.21.1740658147355;
        Thu, 27 Feb 2025 04:09:07 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de19cdasm1074217a12.24.2025.02.27.04.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:09:07 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Thu, 27 Feb 2025 22:07:29 +1000
Subject: [PATCH v3 02/20] ASoC: dt-bindings: tas2770: add compatible for
 TAS5770L
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-apple-codec-changes-v3-2-cbb130030acf@gmail.com>
References: <20250227-apple-codec-changes-v3-0-cbb130030acf@gmail.com>
In-Reply-To: <20250227-apple-codec-changes-v3-0-cbb130030acf@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shi Fu <shifu0704@thundersoft.com>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
 Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-hwmon@vger.kernel.org, 
 Neal Gompa <neal@gompa.dev>, James Calligeros <jcalligeros99@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=825;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=6I6kevtGt5Xf+IFLuo9iZloEKxJU0BXvwM8XaAJw7vM=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOkHQk/WfVbVsDlc+/Of8a3ExRNn9e9/5CR0KSRPXHhu8
 wf/dVv2dpSyMIhxMciKKbJsaBLymG3EdrNfpHIvzBxWJpAhDFycAjAR00aG/+5rGuST7D8FS8n9
 W3hH3cCZU/7ATIanD8Q/Z1z7NG9+1WVGhgMmT0TdyhbVnJnAz132XNBj9dWFBil+ysINe4pajt/
 U4QcA
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

A variant of TAS2770 known as TAS5770L is found in Apple Silicon Macs.

Reviewed-by: Neal Gompa <neal@gompa.dev>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
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


