Return-Path: <linux-kernel+bounces-348943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B073B98EE46
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ADF728330B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6431552E7;
	Thu,  3 Oct 2024 11:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ELoH5JGx"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41F2823C3
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 11:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727955416; cv=none; b=qrRHn8J2BjXDRk2yVKUv4UUNo3ZCyazkCqRm6ZSziFpdKeqa1RPuDH8I0Zm5Q5cJfOqoEC/sgRZb4es9w5hDn6fXnIsaZWvboDXbDnuGRbwOFlhRk9qi5o0MiQbxnv31GS8uFRiGME4xttlC8/7lKRbfSJBcfONJoftc9fIKhIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727955416; c=relaxed/simple;
	bh=9XNu2YiPVfCXMRsCJIzq5HdVuO3OfnQEUwzdN5epTWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CGdDqbexNL3CEMkuDtxNGOVlCU4OuzBU+53ihv9ZPaZGhwgWgGWBXaaGnbMf8h8D29i3SSbsyxVakYELw6xE8mZ20BbBV3doOe2H0nEp78oD2/r/Ubd7B7G+3YFdZkxPTlc8aF4s4h4vY5Jyb+JKDjDkgJt2hj0Oz/63sNvV0kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ELoH5JGx; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e0b9bca173so659342a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 04:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727955414; x=1728560214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JQor36jTy9xL586/Rs54JpiyHVbpn/Wm9HFv91ZHsxY=;
        b=ELoH5JGxvH/X6L1FL33IWcnkGZ152De6eb2y4hlJj2a1orRgRK4NwPoss0YWLhFDln
         taOe1SeEpB29N3k3i/JRLCyz5VOPu4Z3jfP3jbgpuGPD/VhdaoeGVFBIb99c9AJwGUW1
         PLQbjHYkCUuhoInvxoibdT2raf4q1XxuI1kR3/Mi1qYRE+zk5pLDqFX30KjGUs1oi1IQ
         95xTUv/Mi+LJ6Uq5RuvQgnLmTes2Brtw4sxQwlYMeYmC/Jayhh+y1ynNn24q/aGMwvwn
         3jNHKlpAoXChpR+w3Y1LBIeNQqBuIa0k/exhUFfQf2pyZODno+ymLAQaD54hJKD34uCR
         crGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727955414; x=1728560214;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQor36jTy9xL586/Rs54JpiyHVbpn/Wm9HFv91ZHsxY=;
        b=vQ5VI2uKs/HIVPhmXZOB2I74Xyn4vvuYhRquBQXGF3EuAQKcvkcWeixSKDrNOfRBop
         N7exG0f6NihmuEIWu6VblhR0mHebIEIXK7HkN+aJRd7tLuIc7J98s2n9Ig+lar35cJIJ
         FfymIW72A/DV0fSKtitdULsg6gUVjnnOyAwwuucH76p8D5dxpNhch+iOOpfgjgva7UeU
         52hQ7OIiDUYXv0VDScWLgiry/Klg3Yd1/IKFL+r4D+hMshqRPG0uiVcui0ADsyfbI+52
         4fIB17SzvurXcXAVNx9KTvvVrMwZcKBU7RItxUEk1f4TR2E1JGkIy/mwgTX1C3aSgCh9
         qqsg==
X-Forwarded-Encrypted: i=1; AJvYcCXaDtbD5KwZR4jgOkzftMOr8PK56Y0F1v/pjXSDaqhy2jEs42muDQ2nxYK2fNLfl6IRKriTxBAkMKJdLNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycq46xZqRVD8Ec3Tglg3dPn/jzbBeQXDhO8pzL5XoMNBUQ45B7
	DO17vSizuO7nSOA83QYioe6HS63nEQ4wZBku6/NowalpvFS3Ycl1+bV6/U4I2ls=
X-Google-Smtp-Source: AGHT+IEQ68PlX9h44E20F8mxHs7TxeSSTPFiB6+vSfinW6ZvpbDDUvkv5/aJJDNY6+Od8jkr6Cptog==
X-Received: by 2002:a17:90a:a10d:b0:2d8:e524:797b with SMTP id 98e67ed59e1d1-2e1846be8fbmr6630662a91.18.1727955414243;
        Thu, 03 Oct 2024 04:36:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18fa05087sm3476494a91.39.2024.10.03.04.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 04:36:53 -0700 (PDT)
Message-ID: <9858968e-178b-4357-9eff-3374df84ec90@rivosinc.com>
Date: Thu, 3 Oct 2024 13:36:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 5/5] dt-bindings: riscv: document vector crypto
 requirements
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org, Conor Dooley
 <conor.dooley@microchip.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Andy Chiu <andybnac@gmail.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241002-defeat-pavestone-73d712895f0b@spud>
 <20241002-sincerity-urgent-acdb0e8d8a66@spud>
 <0fa7461f-5c7c-4f18-ac02-66d37e2c559c@rivosinc.com>
 <20241003-variable-quirk-9a13fe040e4a@spud>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20241003-variable-quirk-9a13fe040e4a@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 03/10/2024 13:05, Conor Dooley wrote:
> On Thu, Oct 03, 2024 at 09:59:38AM +0200, Clément Léger wrote:
>>
>>
>> On 02/10/2024 18:10, Conor Dooley wrote:
>>> From: Conor Dooley <conor.dooley@microchip.com>
>>>
>>> Section 35.2. Extensions Overview of [1] says:
>>> | The Zvknhb and Zvbc Vector Crypto Extensions --and accordingly the composite extensions Zvkn and
>>> | Zvks-- (sic) require a Zve64x base, or application ("V") base Vector Extension.
>>> | All of the other Vector Crypto Extensions can be built on any embedded (Zve*) or application ("V") base
>>> | Vector Extension
>>>
>>> Apply these rules in the binding, so that invalid combinations can be
>>> avoided.
>>>
>>> Link: https://github.com/riscv/riscv-isa-manual/releases/tag/riscv-isa-release-698e64a-2024-09-09 [1]
>>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>>> ---
>>>  .../devicetree/bindings/riscv/extensions.yaml | 32 +++++++++++++++++++
>>>  1 file changed, 32 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
>>> index abf2579171c5b..02b822bbf341d 100644
>>> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
>>> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
>>> @@ -651,6 +651,38 @@ properties:
>>>              - contains:
>>>                  const: zve64f
>>>  
>>> +      - if:
>>> +          contains:
>>> +            anyOf:
>>> +              - const: zvbc
>>> +              - const: zvkn
>>> +              - const: zvknhb
>>> +              - const: zvks
>>
>> Shouldn't zvksed and zvksh be part odf this list ? My understanding of
>> the spec might be wrong but "Zvks--" seems like a poor-man's wildcard
>> for Zvks* extensions ?
> 
> I don't think so, there's a corresponding -- on the first line of the
> quote. I think it is some really odd styling that should be replaced by
> commas.
> 

Oh yes, my bad.


