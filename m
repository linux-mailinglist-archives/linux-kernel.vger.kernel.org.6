Return-Path: <linux-kernel+bounces-448224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1106C9F3D27
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 583DB1889406
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81EA1D619F;
	Mon, 16 Dec 2024 22:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="id3WywLl"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172741D63CC
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 22:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734386407; cv=none; b=Ai8WWrHFMTSQ8ZcTu+XYAky0/ivSX3KaW83D3ymxKyFT3ieaT7pCqiF4Icyx7HGq1XfzZk3uD4hPhCp0ML9iqh9JYFhkigMKOuRqxxlGLNZSMsoh+trMf0kSE+BWXB5QmBti7mk/w4mknBqTV6QfTS75xxYq085Kl54BIeUz6t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734386407; c=relaxed/simple;
	bh=WY1yk75xj3D29k5mczcyeteQJJJq8P3Ye1L3yD6YJMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k+APpVwRiuOWhodlqtcWwtQ9YpV2yh1/c5sbUuPFfAqhXU2mdUjxKfZV++y8sp4wMXKsSVls89FiJviqtU6rqPJga4vb5avx9mx8piEgrG2VfHpg7IqguFN86YwwS9/KLrLDoHyIa2SgaTmJtHXQ6EdR6tLlogt//DoabReCvtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=id3WywLl; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a77980fe3aso15223265ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 14:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1734386403; x=1734991203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M9GAPUOnO/AZAUr8mlWdqcXEUNfkQg4dQQPEXS1LGaw=;
        b=id3WywLlm5GdGdXLtHYpT9Q36oZ8Fld3Hrj9xJh6ZB7CZQDnkK5tiY8Fo3aQO/boJ8
         FQclL1JAkbmLsAmwRfQ8srBrzYVG6QHRsvklyxg8SIIKtOiXtL1GD5qOUNlfjVB9F+Z4
         RHwCdDhFhC/LNQpVFKesYTPc8ydxbwOL+JkisZJKN23nGKgOPlmCAFWsuUjhdPA13QJ5
         pgBgP/mK60m4790PgnZ9E2/TSK0ovWTANSFuYjHaynj1G2C/Io8/Nu4S68ov5lRYgULV
         BtsIcEuNzNooWMTYAcPatTsv7F3xlDrlHK7XkojUqwYJh3Kcqvbn9O/tTtFguVYlEw7J
         9Vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734386403; x=1734991203;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M9GAPUOnO/AZAUr8mlWdqcXEUNfkQg4dQQPEXS1LGaw=;
        b=cnK59U4t615Wp5FyJTZ6dl4w5dSOwvuvE2LMJCyUNItz/iiP6Mpptce1ch+TN+cH/z
         bSodFUFfSPjt3i4QBA12b2eeYgGI9TPbrZsBP4nO0G8g6lNPBlwd/2qxfx0tg0Yh/+4t
         fFT1Z7yidqU/qvVGnE22cbuscm5SFUmAvAwA44ThONjJ6ZOd+rGMYzcM6q5L6UIc13f2
         Ip2NkFaAJsJaFW9j2giA3v+Mx9bKMcpIb89P0qhV9Jn3s1JcalWbLY19hPqVZOQMNrTE
         xVp53NYOMiWN7/TwIW72PdiKRSO5Vrg6YTRt35ZJZi6QsQ315zrMNvR0zDXNF0VS0suN
         p6YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIbwqkFk1/hZlANBPzQqCUUC4Gx2FnBbRknMQQSLJE7oozRwPj6qmgoqd8daV+lnUQt6o3njNC60LW9QI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/bG7dVH7QdDulfQOibuZjoGF+IyPe4rClf1xxPjPlTMgd8V94
	9Yze1QKXHHYoEUkVbc4XEFTas0Yu5l6LsmyxfGXFPM6n4E0//xjruzizRx11ndk=
X-Gm-Gg: ASbGncveQ36oUYZCZ75Ri2ADvfuIp+8A/pejA/wSHLSph/JFnxOAYDKtswUnNo5viXV
	XlV9Ir46oJ2uVnXbUaMj69moDnA8BYx16Nsktbfa16qcOJLNhIvwgpFciNP5ezmPgoebOQ+QOOp
	4VpRbJuozk/dJSJScTAmc6Z1iiBXscsmuwF9yFdNrZ7Ckssndy1XJ6DIuC18fGhb0kYqUBxewOC
	IYy/uocxHHUnWONxoPVJPfrHXrWTzzRh4W/UJ8V6lda9qSu2iXOV4JtRIXAbwQcbCFQ8xHAYVnK
	772BNA==
X-Google-Smtp-Source: AGHT+IHIM+DoAUO4uH+jY49Cft/09OtchiEcCTITNYy9jOukvV//rMl/YNzathv8XDZ/7POhKMPjZQ==
X-Received: by 2002:a05:6e02:18ca:b0:3a9:d0e6:abf2 with SMTP id e9e14a558f8ab-3bb0ac12780mr11516415ab.10.1734386403225;
        Mon, 16 Dec 2024 14:00:03 -0800 (PST)
Received: from [100.64.0.1] ([165.188.116.15])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e5e3c69e2asm1403241173.138.2024.12.16.14.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 14:00:02 -0800 (PST)
Message-ID: <5e878b5b-b49d-4757-8f7e-4b323a4998b3@sifive.com>
Date: Mon, 16 Dec 2024 16:00:00 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: riscv: add bfloat16 ISA extension
 description
To: Inochi Amaoto <inochiama@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Chen Wang <unicorn_wang@outlook.com>, Jonathan Corbet <corbet@lwn.net>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?=
 <cleger@rivosinc.com>, Evan Green <evan@rivosinc.com>,
 Charlie Jenkins <charlie@rivosinc.com>,
 Andrew Jones <ajones@ventanamicro.com>, Jesse Taube <jesse@rivosinc.com>,
 Andy Chiu <andybnac@gmail.com>, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Yong-Xuan Wang <yongxuan.wang@sifive.com>
References: <20241206055829.1059293-1-inochiama@gmail.com>
 <20241206055829.1059293-2-inochiama@gmail.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20241206055829.1059293-2-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-12-05 11:58 PM, Inochi Amaoto wrote:
> Add description for the BFloat16 precision Floating-Point ISA extension,
> (Zfbfmin, Zvfbfmin, Zvfbfwma). which was ratified in commit 4dc23d62
> ("Added Chapter title to BF16") of the riscv-isa-manual.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../devicetree/bindings/riscv/extensions.yaml | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
> index 9c7dd7e75e0c..0a1f1a76d129 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -329,6 +329,12 @@ properties:
>              instructions, as ratified in commit 056b6ff ("Zfa is ratified") of
>              riscv-isa-manual.
>  
> +        - const: zfbfmin
> +          description:
> +            The standard Zfbfmin extension which provides minimal support for
> +            16-bit half-precision brain floating-point instructions, as ratified

I think you mean "binary" here and in the entries below, not "brain".

> +            in commit 4dc23d62 ("Added Chapter title to BF16") of riscv-isa-manual.
> +
>          - const: zfh
>            description:
>              The standard Zfh extension for 16-bit half-precision binary
> @@ -525,6 +531,18 @@ properties:
>              in commit 6f702a2 ("Vector extensions are now ratified") of
>              riscv-v-spec.
>  
> +        - const: zvfbfmin
> +          description:
> +            The standard Zvfbfmin extension for minimal support for vectored
> +            16-bit half-precision brain floating-point instructions, as ratified
> +            in commit 4dc23d62 ("Added Chapter title to BF16") of riscv-isa-manual.
> +
> +        - const: zvfbfwma
> +          description:
> +            The standard Zvfbfwma extension for vectored half-precision brain
> +            floating-point widening multiply-accumulate instructions, as ratified
> +            in commit 4dc23d62 ("Added Chapter title to BF16") of riscv-isa-manual.
> +
>          - const: zvfh
>            description:
>              The standard Zvfh extension for vectored half-precision
> @@ -663,6 +681,33 @@ properties:
>          then:
>            contains:
>              const: zca
> +      # Zfbfmin depends on F
> +      - if:
> +          contains:
> +            const: zfbfmin
> +        then:
> +          contains:
> +            const: f
> +      # Zvfbfmin depends on V or Zve32f
> +      - if:
> +          contains:
> +            const: zvfbfmin
> +        then:
> +          oneOf:
> +            - contains:
> +                const: v
> +            - contains:
> +                const: zve32f
> +      # Zvfbfwma depends on Zfbfmin and Zvfbfmin
> +      - if:
> +          contains:
> +            const: zvfbfwma
> +        then:
> +          allOf:
> +            - contains:
> +                const: zfbfmin
> +            - contains:
> +                const: zvfbfmin
>  
>  allOf:
>    # Zcf extension does not exist on rv64


