Return-Path: <linux-kernel+bounces-182972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E39C18C925A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 23:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75CA41F2139A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 21:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0894B5C613;
	Sat, 18 May 2024 21:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HKkvhDBo"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAD3101CE
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 21:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716066726; cv=none; b=kKtZUqXeYB6v8FUO7kWiLV43p8EaRriw88E6IPxfQE1MBEjrJNoA1ztFxyNShpymOk1YyhZeM1xEEyn1hiFbbqsHBSdg8H7fV6oJ5Y1vpb7je0cgVbd5imkkFOVLHUSYQbZX7LotQBIvWHXpqpdXTu+3shtej3wNC8EE/f1iZ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716066726; c=relaxed/simple;
	bh=OGj59+yUG5SeBGumRF0wXId3HtaJLcxLvX5eUu1k4sY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kAxag3ciTzNoEQSEgSdhnEsWNOkFl06a6lAzy95357VjSSqvNsndDIbLZsVQvK5iC6ZSPl+h4FMzVUGAkvh5Mxd6CN6MOtMhWOJcLEXjQy1Nat846mNqVrlGOI+PHHO/ChhuF2H+6vRXZkuscV7buQHo/y+Xi8NxwVxKjG2Ljgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HKkvhDBo; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e6792ea67fso34623611fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 14:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716066723; x=1716671523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=brMOoyRcmQ5W7Ic7tEkLMb8OY3+MtSi2g93xfzfzyoU=;
        b=HKkvhDBoaMmayXSSkENdYtxT3AvHjkffNxJzrHj4Hr5xH/qNtpAmSA76yixiuk2Z4j
         TslUEF3Ths4Bz1NP1rpecS5s2V0yqZ4s630jwGlMvF/omoMa9IaDI78nqHyyYhbfemiI
         BfrfM04XwcaaUgMHnCxRvrcqi0KOtO1Jh4A8nLKGKJB7YElx82/pvzebq+8+a4mJLZjC
         fvGIHxDmyvE3rjzJ81pcqvqWn7sZCpqorD6dWjSVuasrlhl2uFNn4HuZpD6unp+JfwGk
         gq95LHFcaSdP4RrskaRuPfJ1N8dYJEnaduzgY3VR1stw4BYpoQh0UBJD9LZPcXnJGJ6j
         yWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716066723; x=1716671523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=brMOoyRcmQ5W7Ic7tEkLMb8OY3+MtSi2g93xfzfzyoU=;
        b=mmERjnpNvn3uzxKVkq1kb47VyqkVtEIcUAsKdTBIaVWRUixXp0fGNRxPyHXGz46seR
         gWNBHoNxy0RnNb1BT1WtmVgsfcsBbXWRKUMfoBOV3hTt0z6asFiuj1fASfN0/NkIXrMa
         ohXHuNL/4c4oh5Bi5i1Q76LvWIaCjuX7CeUgaZgUDeS9mc2jgVwmRfg59E2JASbr3+hP
         jRojVB9MIY3agDXYuZM36D0fVbH29HqPtJScSzLk1RubyVZVBLiPd0lh958HA5L4+M6U
         e5/yTLjgnSOZjuRmk6pFoq08pKc9WMudfNoS96KksCi6emX5Nq079nsCunw1h539o/Pb
         l8kw==
X-Forwarded-Encrypted: i=1; AJvYcCUqki0xsJ/I+jHiLA+U1fxQc1OjocrjKrfUO0k8so0JNHCtr+TixdJcsdQTZLNS9OuO1axhk+E4DtyQ4GsRU3re54qJcNZAwjuZOTCT
X-Gm-Message-State: AOJu0YyCyLM0cZNPrRaJ7sUEQidS82hEQUxpt5Tt8yLxhiahaW+CJaiU
	lok++Btky0Pr9I8D14h25vS3PQT4rOyZb7Tziub8aUYe1hpTDTkRCNFCK0LFb5Y=
X-Google-Smtp-Source: AGHT+IHcZoP6Of5YY+498D+2p+mQKWV47GgZqqRIdg7kVoGGBD308008Ffbm9x3P/U7/JXkzTx3MfA==
X-Received: by 2002:a2e:be9c:0:b0:2dc:b04b:b3c0 with SMTP id 38308e7fff4ca-2e51fe52160mr207086061fa.6.1716066722853;
        Sat, 18 May 2024 14:12:02 -0700 (PDT)
Received: from krzk-bin.. ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c323d3asm13151340a12.90.2024.05.18.14.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 14:12:02 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	MandyJH Liu <mandyjh.liu@mediatek.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/4] dt-bindings: mfd: mediatek,mt8195-scpsys: add mediatek,mt8365-scpsys
Date: Sat, 18 May 2024 23:11:56 +0200
Message-ID: <20240518211159.142920-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new mediatek,mt8365-scpsys compatible, for the SCPSYS syscon block
having power controller.  Previously the DTS was re-using SYSCFG
compatible, but that does not seem right, because SYSCFG does not have
children.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
index c8c4812fffe2..1aa27d14145b 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
@@ -24,6 +24,7 @@ properties:
           - mediatek,mt8186-scpsys
           - mediatek,mt8192-scpsys
           - mediatek,mt8195-scpsys
+          - mediatek,mt8365-scpsys
       - const: syscon
       - const: simple-mfd
 
-- 
2.43.0


