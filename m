Return-Path: <linux-kernel+bounces-348717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0E798EAF4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2621B25666
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52FA823DF;
	Thu,  3 Oct 2024 07:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wlOQzFRn"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA64953363
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 07:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727942383; cv=none; b=rcIRwqh9H6omH3pCPXXyedRIF3pDDJRJD3G62pjwM70jDCTLBVQcvBI//cjvtVQUiBMuJDiCOV/ZvgyGyj0pQWXeqK82PkNeB0ZrUguFIrmA7Mu1PIvyC3C3AXyxcYm653EPkyOx5o4M2nenOHFLkkN79tVORHaIJ1LP6cyrJxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727942383; c=relaxed/simple;
	bh=CzdQ3i2VK7UMasif6892vGA/ET644xX++JhT4/OWUH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YKGUMhWIgUSL/H9sH9+n5MP+nyvA1MoiHDZ48nxGZHSA3fdbC38VCqeQsWQnc7WdhwoAO5m0SGL1Rq6sR6gtj1GeldrD9jjnMbNqambskm9k1Y4Yn5anONuwFWjisSaDhg8CbuyefwsF//jz3cNKbXpN+iMsrwr3LQnju0QiWMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wlOQzFRn; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cb8dac900so5875275e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 00:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727942379; x=1728547179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7wZTumvS1FX7esdrpRKhVgflOZWM/kXat3TeZ3vkWLk=;
        b=wlOQzFRnh6SzE4mZbV61+OolH9ndGmRDUM+ac8msJLPES30SQF8r3yNSICUjRqFo8Y
         Do65/XugIeLWBkT0e/NQcLs/0av7X5eBUzKS2TU+KgWSUIU7p2pc/0Skr4jow11ulmsX
         eO2r3u5Fn1FumazFhsBkDW5oHT22mQIWNWvCXfCorKs4n0oDllSuG088MqWtYNKmuezD
         VPV/sA1e9Er/HeiRJWMJfju93rr3+Ok/NxLlxI0C+RIVdDmVa0+VUcT8SPeywT+oJYqF
         ywZG88zTOkzBA4B2wZoXw4JRTtVP70Ni044tu/8kDqwhal2rTcpwLZHV5KxDS1mO/cVN
         e0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727942379; x=1728547179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7wZTumvS1FX7esdrpRKhVgflOZWM/kXat3TeZ3vkWLk=;
        b=l2n056l+nLdiG3qWNkDztb3mxixkzV+dsxWXI0eT/+jeB7tVMT5Dc82RNgpzYl4ePa
         2+Aozdh+VvizA3IjzV4AlPNiDVdkvlmxUKH+T3AVPLtglitkJj5VTOcCllrbAvSd+0Xf
         EUAGvwVs9LRrlABNBhVZSBofFLBPfdf5UuyTjth2XQXwm+EsjYpLsVWeZQNjbjs2/DQg
         rn+D+c8iZQMgrQ2q0xVwoKlX9bUipKri88FC9+Og0wW9SR0ot0NdR8Ri0Cg7zV+HQIq6
         h5p4VaFP8JbeCrboD4ud1PXjrhE5JJjOTIgAE1c3LKZOsIvFi/a/nwJAa3ms5tlOUWJ1
         O4+g==
X-Forwarded-Encrypted: i=1; AJvYcCX6vj3LRDLV2QrJ1phIu/Nfgn+7sp6VHrSqqMN0v3oxy3loaxlA8zWXBNB4co5NHPku7Jb88nT/TSm9nco=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIvE5kBRjzVo95KvRADRq15qruxBIXIoMa3j01eF0IdYGJ0IdU
	LTuPBo0TBTP8ZVqbGHmT/N8gSM1b09NCF9hYmvQKuB2vJc8zPfriIlcfnZgoIXI=
X-Google-Smtp-Source: AGHT+IEsSdfcRZjKJ41FslpC8TPMBC/B2mp/qcKIEx519I9XW873b+QBemVm6u81uqeEgDbbK7zeeQ==
X-Received: by 2002:a05:6000:1547:b0:374:c075:ff34 with SMTP id ffacd0b85a97d-37cfba04c19mr4773570f8f.38.1727942379165;
        Thu, 03 Oct 2024 00:59:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082d94f1sm669315f8f.110.2024.10.03.00.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 00:59:38 -0700 (PDT)
Message-ID: <0fa7461f-5c7c-4f18-ac02-66d37e2c559c@rivosinc.com>
Date: Thu, 3 Oct 2024 09:59:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 5/5] dt-bindings: riscv: document vector crypto
 requirements
To: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor.dooley@microchip.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Andy Chiu <andybnac@gmail.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241002-defeat-pavestone-73d712895f0b@spud>
 <20241002-sincerity-urgent-acdb0e8d8a66@spud>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20241002-sincerity-urgent-acdb0e8d8a66@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 02/10/2024 18:10, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Section 35.2. Extensions Overview of [1] says:
> | The Zvknhb and Zvbc Vector Crypto Extensions --and accordingly the composite extensions Zvkn and
> | Zvks-- (sic) require a Zve64x base, or application ("V") base Vector Extension.
> | All of the other Vector Crypto Extensions can be built on any embedded (Zve*) or application ("V") base
> | Vector Extension
> 
> Apply these rules in the binding, so that invalid combinations can be
> avoided.
> 
> Link: https://github.com/riscv/riscv-isa-manual/releases/tag/riscv-isa-release-698e64a-2024-09-09 [1]
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../devicetree/bindings/riscv/extensions.yaml | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
> index abf2579171c5b..02b822bbf341d 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -651,6 +651,38 @@ properties:
>              - contains:
>                  const: zve64f
>  
> +      - if:
> +          contains:
> +            anyOf:
> +              - const: zvbc
> +              - const: zvkn
> +              - const: zvknhb
> +              - const: zvks

Hey Conor,

Shouldn't zvksed and zvksh be part odf this list ? My understanding of
the spec might be wrong but "Zvks--" seems like a poor-man's wildcard
for Zvks* extensions ?

Thanks,

Clément

> +        then:
> +          contains:
> +            anyOf:
> +              - const: v
> +              - const: zve64x
> +
> +      - if:
> +          contains:
> +            anyOf:
> +              - const: zvbb
> +              - const: zvkb
> +              - const: zvkg
> +              - const: zvkned
> +              - const: zvknha
> +              - const: zvksed
> +              - const: zvksh
> +              - const: zvknc
> +              - const: zvkng
> +              - const: zvkt
> +        then:
> +          contains:
> +            anyOf:
> +              - const: v
> +              - const: zve32x
> +
>  allOf:
>    # Zcf extension does not exist on rv64
>    - if:


