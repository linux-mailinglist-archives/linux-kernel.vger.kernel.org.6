Return-Path: <linux-kernel+bounces-225720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D52D7913456
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 16:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76BCD1F23612
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 14:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AC116F909;
	Sat, 22 Jun 2024 14:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrJtsv5O"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E60116F85C;
	Sat, 22 Jun 2024 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719064882; cv=none; b=lihNffdYggwXjiLgRp1dM/1PlXxpqpMeGFs7I8+z17DD2dxURBggD6wVyErhWe9luqb5k571soEhUvL+yFhHnd8FumPiFgHRVIl25dy9J+P4w/1mWl4G+kEWGEUMrhUs7SBJasd2EuiFnUvaNXpY7Awr11hTR3psSs4Gl6Wi0mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719064882; c=relaxed/simple;
	bh=lFWwzDoIiLwg5G9weEu651ErjbaKSHLHyoI3Cu8v9gQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Os88vjRUqZwapKCrTRjr2wKNaReEyBb4nSFcfG0UJGrONKiKH7CC/nIaUkUkpsAhPXUQ5TcOrTvlFZY/viwQsZaHgBxdzIV4c4K+Gs+/zbYY+zd19uTtZWOMYpao8bMl5WWLGCJiqB0QDiS5gLnaSWbEOcpaI4usxMqcUCpDWAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TrJtsv5O; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a72420e84feso24048466b.0;
        Sat, 22 Jun 2024 07:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719064879; x=1719669679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lA5SnMtVhJJ4EmNcwVGq3ZRuVABb+oRfT1B+Ka9IE8k=;
        b=TrJtsv5OsiKvvh5bUkvyaDkJPSRP9PsODr1o2sbpqkomEM5zfFPYDhjVZy+gfWhbWR
         ARYI7to5TSnV8gA8Uv1d1jHK6fim+83t+fD8qTbfh488h8trXnxRjKYXXFtdySHqO713
         a8ETCZpoAYnOvuZuLytzsfS+SlqkAhTamMpsMEglRTfPVMKU9rYNii4MQsMGu0CTMeax
         fVm/H8AjXmJlyM/3do9JTxNc3VyIWv3L8k2pPBQqcjMotAYfswhyzgWuDINF2jwOR2uE
         B23EwQsRHgFvfo04ijPa14J7+NdlykYbiSsi7YyaRiLBW32jrYsaNZcYd2Gm4EHxo69v
         2qJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719064879; x=1719669679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lA5SnMtVhJJ4EmNcwVGq3ZRuVABb+oRfT1B+Ka9IE8k=;
        b=LuGPMhJpfxD1ZRSLTGcsWG/sIC2DaB4GD5gHb2XHXXScBNoKaGAyR16OKrxqmLN6Fg
         sJuqZIVGP/9AXYaDJZhBC7Xe1FJ31C1a4Mv9CJQ+/qEB6zS/9l/hTfYLVsKo7k6PuZ3d
         Of6+xIJeL9UjMe9U1BsQSY39x4RD3vSF7dy9vqD9pw0DKDnEToJKvRw66e8YFz7MD3pa
         +MchECrd7BUN/2CtL0TN95AzJDVUZjw4pK0NQWH7zQp78dwrjuVL7g4P9nyAWPQ4VeKv
         zAQ9dCT/uAFz2v+Dgv6eVc1gqP+zA12Zu5yL2xzsoTzfbbOeDmsj6QNZYvqbFHHm/Iu3
         T7+w==
X-Forwarded-Encrypted: i=1; AJvYcCXvrZHujsud3UbHA02Fkk12vfe/d5rdnSD1xYgq05e87sYDcPX95BOijkPAdt/VO8sBd7KrF7uKZgrgW4C5/w6ydtZZmJHp8A8cpiipFr3FBTnz0qpvjVCtwvMTfNKYReqPUp0b8pBnEw==
X-Gm-Message-State: AOJu0YzTR7keFY5TMy8yrGP8TkKrGz1SuV8csqfr9HCzkbkty29CJmEi
	bUgndwE9cM0soami/oGfat5jAVvo+HBHdq/0UrrE5Z+8U9pVmczX
X-Google-Smtp-Source: AGHT+IGUV0qFTomyL/WYqqWowX4elU56jWmHT8HLyEZ8zCX2IRpIDfw86zqynqlRnnsH6M9PkbF43w==
X-Received: by 2002:a17:906:52cb:b0:a6f:5f:8b7 with SMTP id a640c23a62f3a-a6fab62a997mr798048066b.21.1719064879424;
        Sat, 22 Jun 2024 07:01:19 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf549166sm198715166b.132.2024.06.22.07.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 07:01:19 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Christian Hewitt <christianshewitt@gmail.com>,
	Emanuel Strobel <emanuel.strobel@yahoo.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/3] dt-bindings: arm: amlogic: add support for Dreambox One/Two
Date: Sat, 22 Jun 2024 14:01:11 +0000
Message-Id: <20240622140112.2609534-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240622140112.2609534-1-christianshewitt@gmail.com>
References: <20240622140112.2609534-1-christianshewitt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dreambox One and Dreambox Two are DVBS/T2 receiver boxes based
on the Amlogic W400 reference board with an S922X chip.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes from v1:
- No changes

 Documentation/devicetree/bindings/arm/amlogic.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 77f8dfa86e6a..b39eb17abbba 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -176,6 +176,8 @@ properties:
               - azw,gtking
               - azw,gtking-pro
               - bananapi,bpi-m2s
+              - dream,dreambox-one
+              - dream,dreambox-two
               - hardkernel,odroid-go-ultra
               - hardkernel,odroid-n2
               - hardkernel,odroid-n2l
-- 
2.34.1


