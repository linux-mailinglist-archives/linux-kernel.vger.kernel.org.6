Return-Path: <linux-kernel+bounces-217299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA84F90ADF3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30ACEB25E22
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AA5195B23;
	Mon, 17 Jun 2024 12:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pp9R5ij3"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53157195971;
	Mon, 17 Jun 2024 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718627351; cv=none; b=FGwRrcfJmNq9+xTxlVZ+NTJVnXhS5TDvJj9njoThokSxRIcbAYr66gq+JgcOFKmxfQu0qp5lgl89/KiuWfQivMp7UBoY1xL587zHCjDFBOfe78/URWO6RkwjvaLZbPqtXsggIG0F1BQyWDJPfbjZuM35e02qwYTV0+GSBw45Yo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718627351; c=relaxed/simple;
	bh=kTwLRzuHZ4rQxBNiRcGhOk8o7CrdHie54ZwZ+nRp6Ns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j/hYl2LLDDUujhWrg/CJcChZRBcdZdvVOQN4LWdA3qTZEbfmOZE4s4lKVXVOlmyEhWjBdsMfbKAjbmFSuNCVx2ZyXkHcQYo+fmXXc7vnbZQzpJFpzLqwW+Pu0HIGGDBdnqG3metvw/s/rHcTMyRW+2qc/FwA6PTuEXBtf58jdZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pp9R5ij3; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7042a8ad9f5so3477182b3a.0;
        Mon, 17 Jun 2024 05:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718627350; x=1719232150; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GcWOvKjaH9VWKVfBKzGMg6R3MCBCRcDLPHcl7oHFM04=;
        b=Pp9R5ij3Qw/vIi5+geKCaHoR1SmK7DBfchaZ1h2Nnxof31MxvXhRuMmVyarg2tk4FY
         6pIUntvd7QG9vAiHDJ0DOI6cbeJ02vVCZCbOiA0jMZVoWnOGRipm6VLbElYNSOiW3Lnl
         IRe28oB7dkTnk/HaZei/x3AacXmXe3PnQX1nLw4PaB3OopiHFmZxCRy/D//BG09qYF4w
         q96XneuCuQ2sSB3hXyXHvwo7ymc/DajquRgvt4c9JDzRseCwJAuBuGOXe2//Qtqmo5ne
         KniQ/oQ0ivuSnA2v6CfxWxX3T3RoYfTq9tzjFyaF5ObzJFPBgi8Vz6TB6X7AMaxS8G9L
         JZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718627350; x=1719232150;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GcWOvKjaH9VWKVfBKzGMg6R3MCBCRcDLPHcl7oHFM04=;
        b=D5EJFZoNyjtR8VwxRP/R+e+acaLdIFyyfHffFKjpMiYrrsc6JOMlF7fqwIfJ0ppxqB
         7x6mYDsQEwBvdfLqcoRJbkHSmhGGwucFnj758qkXQgG4wZCShbAmIcTmofJEp1GqYA/0
         D6j+Hzdqhqr1c5drPT2lYnsTZXdVZn1w92GVU3M665igwMwCsTUvaQNx2o0BRVz7e9N2
         6oeCSIB14OlKzulQWYBJKzc3liFw5T/67oG5r8SiKNWl1TSyGtlO0CBgQUVVZNJLiCaX
         T+8MjwJK7bN31sVsnJCDNHhrfBXjjoC2rempe4ULLyP74ofXCC8GO5uKWycZNmTW331u
         pLaw==
X-Forwarded-Encrypted: i=1; AJvYcCVK7a0BYPDeBdOykgfF5MzLS9rGVF2DcixBu5W/DyOxcKw9OfEnX0xK0JZ3b+Aanb+okqXdYftsEZYx/u57ydw0sjP/h4i6yuRsMVEqo4r0UoBDseyyqx4sNsJ5kCbnl1IS3fuI2maRGg==
X-Gm-Message-State: AOJu0Yy5nUqYgkE9gaAHMpMgp4cBspY+S3hr1aiIGFoNyKmu6h8t8lIe
	zBp6Q4FtdNcI+wxL9IVRr5X/M/aQDx3OAbHCXWKF+EYSiAP7+amC
X-Google-Smtp-Source: AGHT+IHs34JMMxUSWDdC9PVQ+jTFt1dLMIoOHcoE7HAc4QSMWJG3bWQkzm3dwwcsmhdR6Vmh2T9e0g==
X-Received: by 2002:a05:6a20:a123:b0:1b6:5b3a:9a4c with SMTP id adf61e73a8af0-1bae7d81c8bmr15214725637.2.1718627349711;
        Mon, 17 Jun 2024 05:29:09 -0700 (PDT)
Received: from localhost ([103.139.191.219])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-705ccb3bf1csm7210162b3a.137.2024.06.17.05.29.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 05:29:09 -0700 (PDT)
From: Kartik Agarwala <agarwala.kartik@gmail.com>
Date: Mon, 17 Jun 2024 17:58:26 +0530
Subject: [PATCH v2 3/3] dt-bindings: mfd: mt6397: Add reference for
 mediatek,mt6358-sound
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-mt6358-v2-3-5d9f0e99941e@gmail.com>
References: <20240617-mt6358-v2-0-5d9f0e99941e@gmail.com>
In-Reply-To: <20240617-mt6358-v2-0-5d9f0e99941e@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Kartik Agarwala <agarwala.kartik@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=664;
 i=agarwala.kartik@gmail.com; h=from:subject:message-id;
 bh=kTwLRzuHZ4rQxBNiRcGhOk8o7CrdHie54ZwZ+nRp6Ns=;
 b=owEBbQKS/ZANAwAKAXiEk+OPlULqAcsmYgBmcCvzz6KRHv41QQjOaa6CrJR8ssn/l0qpihn7K
 50tAMYY05GJAjMEAAEKAB0WIQSJkbnrkCGnamD0k/R4hJPjj5VC6gUCZnAr8wAKCRB4hJPjj5VC
 6liwEACPYyQ52WObSkBjIepDcdHpTXzMZUkawClG3gPNK3TJ/JcAR0YECJfhtzxVM+3n6y7QEi7
 EmxJr/o8H1VnbI9Y/zDuDo+6kGRz1noZiy9x5Vm82vs4KunuVsbgz52y+7SosdFW0LsSD8CF45n
 D/AgUy1kVAtZFS/PpXQOKbMr9VZ+prOJ4mmduw28LgiHc9vQtrwJceotJ5nBskqEQOSACNpVzhE
 52Z3QrcM7GP7iUwvici8hBZ6GAEfHzRI2+iSlvayO6d6BbX3r9FHDtlfYjVWVMLEVBJTiYpTpNQ
 twQNE8aFAm9YdhqbiIcYVohbScUAL667JjiaLpP13gqyztm9lrYGN8C0PWnIJzfgbqE/zgCVDPM
 c2ibDYHvEElRBDklvQ670w97PWHAOagoIAdVGYP4E712mQfs8awIcBQ9xjzaQGaEj7RHTDdzDPT
 ERD6zUbVbuS5LraNSliGBn3JuUY5FrqCYJ0Or/lz1xA9hBicUQvwEFoBs4nBVfL9B9plPC+1X44
 MnNvv9prYA4/w0+ED+DUQRn78OG6t8Ns824nvFbjOOzdeak6okc/98my9k0e9LrXs20KZw6tYQN
 By7ClnMVTqO4p5Tx9NqMwAZHiWU+b0Oi8BZAfeyUVoqk7wJev5BH6gpRqKCbyy1UV2zRawt4MNm
 30e/T8iXMJKO+uA==
X-Developer-Key: i=agarwala.kartik@gmail.com; a=openpgp;
 fpr=8991B9EB9021A76A60F493F4788493E38F9542EA

Add reference for mediatek,mt6358-sound
---
 Documentation/devicetree/bindings/mfd/mt6397.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
index 10540aa7a..cf7fcc402 100644
--- a/Documentation/devicetree/bindings/mfd/mt6397.txt
+++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
@@ -48,6 +48,7 @@ Optional subnodes:
 - codec
 	Required properties:
 		- compatible: "mediatek,mt6397-codec" or "mediatek,mt6358-sound"
+	see ../sound/mediatek,mt6358.yaml
 - clk
 	Required properties:
 		- compatible: "mediatek,mt6397-clk"

-- 
2.34.1


