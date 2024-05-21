Return-Path: <linux-kernel+bounces-185274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603558CB2F9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 19:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B2DB2827A6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 17:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2893A148318;
	Tue, 21 May 2024 17:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xiRjkSxx"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261227F48D
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 17:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716312986; cv=none; b=s8Yhiy7pF1w68wqLvyk9iC4zG8A1ZvcpaPRF+gGoHH9mL1zy6Bqr8IuN8x8rZer0GhuUsjFJQg7w6P6lAyajwR64wSlRsPVYoAONbSV0DeCEFEoJ20PGXZZUZl8SThC/xo7Lt4zAkHIY+63322u3blxnrAyKpF0VtaEU/1qZ5fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716312986; c=relaxed/simple;
	bh=8Gli0BGCzmpOJS0PeIquJpQ2yCEw7IsocVvUgPq5HIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=celW5rqRSUEK2xCEbKZRwTH8vm1T9eI45B+NSleIt/sTbi5PXnRnJlRjECJDlmpOizNYoUoD8wVKSL4y9NxeSF08PaqboxdXPUmVBqQ5yywuayYy2Q3WUKenrt6uNqIxdHAytEdr7Vb+lgPS+ibqVR8MGybWvYFL546VlGJd7OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xiRjkSxx; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e576057c56so46993511fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 10:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716312981; x=1716917781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aPgEx3GtMaUfzrhotDmNS7q39kZcogdON2mF0DZp2xw=;
        b=xiRjkSxx73C3hOiRXqZTf4L5j7/0PR8qOcyv0OTaAG/1XUEh/hyRWCCqJEbeq1ZJMC
         W1zAN/YGlsmIzzL8Xd9kXJqN1o4RF6QaVgBUbxrGhanw5akAmHigab7seIp7W1p/Qw1e
         1jr/txsjUEX2qo3PfPjPupXxDmSbdFbpAFgrav5vwbAdQINonmhtSCZyrYYlM04v7Hkh
         683yliHiaOxRA6FgIjf/nObTo4YFGf+F8jqHKcCFNVug3K4XBFkmiHyCqBQLW645FcjP
         tbl5pG4rij1VwHDatzdmZNpKG+VhBKx56MTr2SgP4O9CCPiPQagCBWWsgGlQM4PZrjjM
         iXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716312981; x=1716917781;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aPgEx3GtMaUfzrhotDmNS7q39kZcogdON2mF0DZp2xw=;
        b=pEC6a5zfD3fmkVspEdAmAoZLoI6IM3RKL8/yfo5TeNcKBp3OiE5GlWGtiTfcFH1CBj
         UYlk1IDUNG8xHKRH+f7J8yeUEGj6xqiqcLDLGqyEUTQV+XeowC++IlyHfXifhjTuLi0C
         uluxhxB4PU6Kws5NSXbVXulCkzcxu/xlmpe5KsXohaiLnHCt5KgawjF1USJJpZeNqSvP
         4711+AIGf0KRd61M2t+25TgaB3V/PmV/Gb0reUgKrajb7r/lpbtfO2AJqXBBUp1Y0H4m
         oIUbLGF4kKbAI3QciPSG+2rz/GGacJb627vJPFx9dKNW0SEWxc+JfdMjuXicfIPOBv0j
         jbQA==
X-Forwarded-Encrypted: i=1; AJvYcCXrfVcBN02Rau4BYhq7SsKzbGTJs8soa/hmnc1DqJhb/txFv/uIBSXZpJUXt0aWxXa/5W80oRIpp0h4W7reuc+1bc1+3IJL9FXKyqe2
X-Gm-Message-State: AOJu0Yww1dhwJ66uNyBAfYEE0VipZS1jMZAoOtpEO/N+y5qiHTtCxe95
	Za808t05IBETiPecSn8pyCDSKqT4VBzm0Gp95VgIIBW1jmuJ+nijHF47r7c0nuI=
X-Google-Smtp-Source: AGHT+IFjJk9ErXRZ9mgIVn9Q70lSKsJgFXX9/mhVTn1VEkxcNEDE0qL/KX6kDba10kEFw4rs+oNWEg==
X-Received: by 2002:a2e:9b19:0:b0:2e8:60e2:3c8d with SMTP id 38308e7fff4ca-2e860e242f2mr6435921fa.12.1716312981380;
        Tue, 21 May 2024 10:36:21 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baacfc6sm32606201f8f.72.2024.05.21.10.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 10:36:21 -0700 (PDT)
Message-ID: <a2ef92ad-7704-49d2-9cb7-783047e5676d@baylibre.com>
Date: Tue, 21 May 2024 19:36:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: mfd: mediatek,mt8195-scpsys: add
 mediatek,mt8365-scpsys
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 MandyJH Liu <mandyjh.liu@mediatek.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240518211159.142920-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20240518211159.142920-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

On 18/05/2024 23:11, Krzysztof Kozlowski wrote:
> Add a new mediatek,mt8365-scpsys compatible, for the SCPSYS syscon block
> having power controller.  Previously the DTS was re-using SYSCFG
> compatible, but that does not seem right, because SYSCFG does not have
> children.

-- 
Regards,
Alexandre

