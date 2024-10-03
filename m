Return-Path: <linux-kernel+bounces-348710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 847D098EAD0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8F671C20B28
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6F9126C09;
	Thu,  3 Oct 2024 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="lD+OSZTb"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DAE13A869
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 07:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727941937; cv=none; b=BEDsT++BriieegkXCulbEYg82ZUhQHOwJNwmgLWJhOrHfy2WYm0poZy2mpodIy+cFb09TUumEDAGzY0/m+9jpA2ZgTCmWnQOGy14qRrBhqgOKLCs4TJ8VCVYu8y5NbTkyaMckT6YrVxbghO6FlkLNfEbzh4fOBlv3dpMegAaxZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727941937; c=relaxed/simple;
	bh=qxLGfFHk48N54tHtoOeSdcqqX6OYmX7Um0o4ucPkydI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gilIGtDd8n9mFufUShGTkxnVJXuMdQok6ONsCvguv899xBeGYjf0vu1T+hjUIfsNOfB9z92jibqHgDukBKvYU3NFsbkjVFHS+boKy/1AYAqquUvMbCiOG4xOyILB9bn0sws7D9gzk8ncx5v0oQprGDhGAbIDFlp0OJUNssVC9ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=lD+OSZTb; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cb6f3a5bcso8221055e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 00:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727941934; x=1728546734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hqwQ/zncqL+Otp1RcK1yRc78ue9IM5xaO84OK1nfH6k=;
        b=lD+OSZTbgdkDQQ0iImoXxfFV5KwjQ+saTnuNG/mOHcC7xwIZlrFkMoWzpS/7aN2gfq
         siid0QZWyzcK4E2W6T/69Nx3g6DtZO/zkQ5cZFr5xa9HeKBemhuyZjYtr+iyDvW8FlEs
         +JxMcPLFAbwRu147Efk5vK0/je333y3OrZ2+7wMjr6vobP0l6vSzuTNEXxvncGrkxLCs
         EcQDcjv8Mv1ROQS1Cjq/G8dIk1qrObB3jDn/yreXef5Sn1kgFf16D2Ji5XzMjEIr8c0P
         ccawvURAieMFMSmqsDqyGpL8jY+UcLAp4mlSMwlxwRD2YkaK3YCIXzzrOjwBhUs55HpD
         vhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727941934; x=1728546734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hqwQ/zncqL+Otp1RcK1yRc78ue9IM5xaO84OK1nfH6k=;
        b=XdJfBrxhrgb+h1PvmOmWmdQ0Hcdwnirvh3VR8MUarjPVPqifoG8jWWPB24SRb1hAhJ
         zWdWPxPKoECPi6NF+w2TAdD+7/TbI+2UKeIB8PlM2XGS6PRXYU8ajfFRL5n1K7FEJ30T
         stuonwgwtBU1/ECVSdzbVOwqdC99VENjRxpqvTVlCE/6U7KYtaLFhPRRiKw/Kv9EUwDq
         Hbj2lh1nzN2XxPkX9UeOrr7kpkWeoEicSowSIoM8KvaJwgu7ipy63Or37iQpjjUKPlcS
         zZLZV8n4DWZGdUwEz4n9FFMy6lR+aQBryyqbGmSMyi7MStDFSSyZHu2Y46F6SU0x8yph
         m0Og==
X-Forwarded-Encrypted: i=1; AJvYcCV2/an1HfIKKEm5RpN/lv8/nOCMB42b5poospC496rvm8XAHptWZcmBVloOUjCr2wbIyfb2gUegPnizMC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2mceCgTjXM4O/6Ou32J+nGQ7I1lK2Yn+bSBj2ElsYPk0BwFiD
	nZd+RYwd6zGh01m2ARB4fYOvsyAX86o4CG8vtCnc/9Z+g0Xj4DayUJdhcJO/bHo=
X-Google-Smtp-Source: AGHT+IGXlCpjd4tKzLHHj8wH2BDGO4iTZaoBK1oTq4S+8PGiA4E1uN9byvXyd5dtX9Xfr2ZPDnjeyg==
X-Received: by 2002:a05:600c:1ca2:b0:42c:b995:20db with SMTP id 5b1f17b1804b1-42f777b1fe6mr50087975e9.5.1727941933917;
        Thu, 03 Oct 2024 00:52:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f802a02d0sm8695285e9.29.2024.10.03.00.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 00:52:13 -0700 (PDT)
Message-ID: <e10bff0c-a243-4280-925a-ceba13d0f1b4@rivosinc.com>
Date: Thu, 3 Oct 2024 09:52:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 4/5] dt-bindings: riscv: add vector sub-extension
 dependencies
To: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor.dooley@microchip.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Andy Chiu <andybnac@gmail.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241002-defeat-pavestone-73d712895f0b@spud>
 <20241002-eagle-fresh-4b2e259e45ee@spud>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20241002-eagle-fresh-4b2e259e45ee@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 02/10/2024 18:10, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Section 33.18.2. Zve*: Vector Extensions for Embedded Processors
> in [1] says:
> | The Zve32f and Zve64x extensions depend on the Zve32x extension. The Zve64f extension depends
> | on the Zve32f and Zve64x extensions. The Zve64d extension depends on the Zve64f extension
> 
> | The Zve32x extension depends on the Zicsr extension. The Zve32f and Zve64f extensions depend
> | upon the F extension
> 
> | The Zve64d extension depends upon the D extension
> 
> Apply these rules to the bindings to help prevent invalid combinations.
> 
> Link: https://github.com/riscv/riscv-isa-manual/releases/tag/riscv-isa-release-698e64a-2024-09-09 [1]
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../devicetree/bindings/riscv/extensions.yaml | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
> index 779f5cfab806e..abf2579171c5b 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -605,6 +605,52 @@ properties:
>            contains:
>              const: zca
>  
> +      - if:
> +          contains:
> +            const: zve32x
> +        then:
> +          contains:
> +            const: zicsr
> +
> +      - if:
> +          contains:
> +            const: zve32f
> +        then:
> +          allOf:
> +            - contains:
> +                const: f
> +            - contains:
> +                const: zve32x
> +
> +      - if:
> +          contains:
> +            const: zve64x
> +        then:
> +          contains:
> +            const: zve32x
> +
> +      - if:
> +          contains:
> +            const: zve64f
> +        then:
> +          allOf:
> +            - contains:
> +                const: f
> +            - contains:
> +                const: zve32f
> +            - contains:
> +                const: zve64x
> +
> +      - if:
> +          contains:
> +            const: zve64d
> +        then:
> +          allOf:
> +            - contains:
> +                const: d
> +            - contains:
> +                const: zve64f
> +
>  allOf:
>    # Zcf extension does not exist on rv64
>    - if:

Looks good to me.

Reviewed-by: Clément léger <cleger@rivosinc.com>

Thanks,

Clément


