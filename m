Return-Path: <linux-kernel+bounces-515810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC77A36953
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01A3D172B56
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B90B567D;
	Sat, 15 Feb 2025 00:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6QiBMAB"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F072B7BAEC;
	Sat, 15 Feb 2025 00:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577801; cv=none; b=ptcsjZfv7K8z7CyuvMXOleZfaD/gzETqwJr+DGYrwFoUIyr449MvijIYqoCMRZ1dftWFylR0jodfhS41QKQJY1a16h2/QVcNOCrzOylZBBCW/LUeVc+aUJc+DvFCGmwCDbSgiwkPjcD0K2qCKPfQSMFz4Uo8osbRJmOCvRaE04E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577801; c=relaxed/simple;
	bh=CIEabKLwQYFi5rWVG64RsxgpPhddtq04bXOdegmdaRY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=srpZBo8ytrwKM+2pHmbel2jWeJMonkmXO7wJYngls8BvuUcad+nUXnuhyd0YEHdzAxWi+AjKbmprEyVshxMNJSQfUGf+H89LqymSd6Tatq3v6YYe2AeDOkh8duhqjTw0S5QRbqjJVeFtMMsBD6KqQEwfrNP7uDaKWCzFtDZGcJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6QiBMAB; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f3c119fe6so62662265ad.0;
        Fri, 14 Feb 2025 16:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739577799; x=1740182599; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ycy+7wK55n2BwKAQm8/kS9AwdfvEsdhnbKKp04wJVgI=;
        b=P6QiBMABJaDpGsI/hQxH3F+l/Ao/4ZSydbZoP8SsTM4OcY1AM/lbo52Q6CB5aPoaXW
         59wACGjl7sxP//VZ1ddA/xIgeE7CG6UUoyG+IaoPg3A9AioCMr0pHVtqkGJ/Ivmfc8hl
         /JPX5wylMsTkz909eGvwFDWymPuJmZLS6xKeRrzW72FpqQchrXkwWUMdf33/laoO277P
         bUEzPxGOlNTFoG4Gzpnwlpi5/92tohG6VzWi1Lwtn9DbYit+jxL0T28GXwdDOyBjNNg8
         +HGtQJ158FbYBiJxiIwb+Iy6IhrF7GfteEh4e+m85avzOzvEYGM03iwPyH0KMCaLXYJL
         kC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739577799; x=1740182599;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ycy+7wK55n2BwKAQm8/kS9AwdfvEsdhnbKKp04wJVgI=;
        b=fE1nw95XH5ivMqXaEiHZmlK6ecNWFJKeMD3nEG0rGzMeN8/fP1KX1MOvd5ZFTqxwJJ
         tKxzl+rjiQLFcjN2qqJoVGWhanJrYv5lEaWL1ysXSPA2yyEH9unHHuhraYBk38OY65nP
         /eQ4AApUjgd71ufXDTf9/iBAV/e9Wy1+LQdsnOhpmGcnqwemHGc5Kwvbzxd8TUtLdT2t
         D0XEqJ3umRIGLQAuIdUa3RU6yw15v8aMUWmObyu5TDBWt7li8C/CW/6rJ8C2Z9o9k8ZE
         MaPeaDFM+1mG27PvxDGgNCdoBejcvJoHQDMl3p6/cH85y5c2G6ic9XhPs4ySYNAuUiO2
         ZtCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHK0NlL9XygHjvlBFPpp7JkZLhdHHPl7yE/MmT3f+dQsLIV6Op3moiPV28v18iN4eiBcZjrAN0Y0q0@vger.kernel.org, AJvYcCWB67RLtw7mM9xgBmDeme+fCb4PjsaZfMfcs0R8355EUJdEti25smLmnpcajUdD5mGpP3KPJufBHyuwF5c=@vger.kernel.org, AJvYcCXAHqpQ/IbmXmvJPylkHbLEZbKvXdeyBRLO2Rbn9uAdER/sqKjrdTDKifxid7k4+t3YOPmvgzW2o4ZX1sdH@vger.kernel.org
X-Gm-Message-State: AOJu0YwJaRAfvgqu8SkUf8goQDluIMGWhwrbVeCCxcnqnN2f6lWr0QWl
	lET11Go54NM/gVMWnQx80/VaLwiqIciA8fks8aF1BoCl24Q6rh50
X-Gm-Gg: ASbGncs0BGy4BolUcFhI32GZGkyoBen9XNp74aHfwpVX+3NCPQQUx4n6CVVb4+up0a8
	MagF9vjUNtKWaCXmd2AUnLlKU609kvtxuSUKSbX+Pr5/e2fu9ric5XOPSrR+K+OubXZlsFfKf16
	dmoyDQaHdzj4oYTnuiD428n2g8SnKncHkT6SlZ4q+uvneoKGG0+BZVD3CDgGh4gC/1KF0tb1IsS
	u0ol0a7cuyN7xBaETx2qxVcEf1l51GsvqMwfNb1nV4HQm/7okx7TBz3tAM182m25LElYU8c3tD3
	MYsgRtxP/utQWJbJj7PageVi0+XJGxJhVP8elYB/+u0i6hMIxk65suVFuW97c18q9QnA2xbdfyD
	W5fH4C1MgAw==
X-Google-Smtp-Source: AGHT+IEQm7tez2sFvaRnjwzh7kSHWcuD4/AClFoJ/jh+RwdHvWH7dcB1tkblv6tQ6+TIuQ9PaI+aIQ==
X-Received: by 2002:a17:903:2341:b0:21a:8d8c:450d with SMTP id d9443c01a7336-221040d11e4mr18863625ad.53.1739577799290;
        Fri, 14 Feb 2025 16:03:19 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220f26ea127sm15071155ad.96.2025.02.14.16.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:03:18 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Sat, 15 Feb 2025 10:02:34 +1000
Subject: [PATCH 01/27] ASoC: dt-bindings: tas27xx: add compatible for
 SN012776
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250215-apple-codec-changes-v1-1-723569b21b19@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=910;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=CIEabKLwQYFi5rWVG64RsxgpPhddtq04bXOdegmdaRY=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOnrb24xXsK/dc2f4GcLfycVX/oQqmQ3y39WUYHQ91+98
 9+6apUpdpSyMIhxMciKKbJsaBLymG3EdrNfpHIvzBxWJpAhDFycAjCRG54M/5MXt1c+rym55Xun
 fIk7m3dq2X/RBTtLWKSKNlqWv/p0s4OR4dqbFAPZrcvu8m3bxNDsIFPcbRdRbPvmwNNXixs93xZ
 mcAAA
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

The TI SN012776 is a variant of TAS2764 found in Apple Silicon Macs.
It continues Apple's long-standing policy of getting vendors to
spin out subtly incompatible and Apple-exclusive variants of their
publicly available parts.

Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 .../bindings/sound/ti,tas27xx.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/ti,tas27xx.yaml b/Documentation/devicetree/bindings/sound/ti,tas27xx.yaml
index 5447482179c14ee78885e5bee02f4549428694a6..fcaae848e78a1137e4d44f98258207bba68772b9 100644
--- a/Documentation/devicetree/bindings/sound/ti,tas27xx.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,tas27xx.yaml
@@ -24,6 +24,7 @@ properties:
     enum:
       - ti,tas2764
       - ti,tas2780
+      - ti,sn012776 # Apple variant of TAS2764
 
   reg:
     maxItems: 1

-- 
2.48.1


