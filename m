Return-Path: <linux-kernel+bounces-544733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0367A4E436
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 584E57A374A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB96C27E1B1;
	Tue,  4 Mar 2025 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DifDLZQq"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9910B27D79C;
	Tue,  4 Mar 2025 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102505; cv=none; b=Kao5lHliollAKpGNhu1/NAmnBYI2YIaSMYBbjVrga76VIzFAnX2dcA9FD08ZEVVowzBJ8jl3NLwngMEWNBjV6pbJLhSCT9y4t5w3rnb9gdpDJPfF7zzZ+pNM0vbw8Sq/4OX6C3eB8prL8NhOAuwcFuvSuc1NvyMzZkoSLzFfkRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102505; c=relaxed/simple;
	bh=O5BPl3Fu5wJkHXKEYtyH4ta5yhgbg1I1X4DpIIkIPh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MNSEiQb0mSM24hR+XIg4ATtsCNx39MAbWcEA/tivSaqzpEIFcbcmvkybkEh3croLlO42BG+o7vEG/BAJWfXHHoutPuAOhmQ4ifcTb+s51NVSEpA/TdRXNGBbSzA3YjtjGY4h+xm/3H+GtzXaJubyEQypE0Jrv6mFiC9Ejib1bkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DifDLZQq; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abbd96bef64so908810766b.3;
        Tue, 04 Mar 2025 07:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741102502; x=1741707302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XwZWXvpRlzaapz6M25h0ltLJIX9XFgudqnE1z2aOvDw=;
        b=DifDLZQqmuk/rICdGfbZqKus8gIQF0RsDlXWsCQA2tcgRyjxN229DOKlb9Ix/nKkc8
         xnZz0CaoMN0JeLRHv3Fgi2ymtg/ym7c1YUG6Yq2vt7sV3sXKxuhYnWQqWzWJ77yMBkmj
         vve/ORUY1TWmCAQMipJOFouP6ucnMFNLVYBucYO9HanRBIo9NUFAUy3YdV68hNbC5Xco
         nOwug+sR9sRaNUw351cv9gVGznzuo/0vbYnnFQ0iz0viUCBJ+bEu47X2jv6EfoQUsXYv
         5UxEiTc1obwPgDqXm59N2X5yUugn5EcBoJYXQaaOPOMxMi2pZ3Niq1C4VJDmWM98yZIx
         WO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102502; x=1741707302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XwZWXvpRlzaapz6M25h0ltLJIX9XFgudqnE1z2aOvDw=;
        b=kxVGH9fjKcogfMWt6+ecolEqbGyho2L895tAe/vywFete1hRLm4tnP6/tM+oV+gpcA
         jsCVouyxJXFKaS9KdMi2DbY86NqVlWXClGFFpKlhc1XyyTFYiCt9OdA3PW6Ba28hW2GZ
         lKr0PuG0U5JQwW8jXr+yNTyE+kOa7GXm5IjryE3of0xvKP+MgCm9LLlOfcODRWIRmHpv
         jSCvsb0F/Z7K7xJLmT3jSXhDAMe+CHURICh4gcLGXVc/oNlY6n0lEOV14le+BixBRcMV
         lm2BFoZ0DrtWZ+w9cA4JXwLOt6SYisAvQsLXacQ3T9xVfGSLRcIWa1F3QpTnnJRDVdO3
         P+eg==
X-Forwarded-Encrypted: i=1; AJvYcCUJHvON/LGHLNvs/tKtskjkTjF+3LuYn8+fiRAewCN6D8jSBoBbNUoB3ZJFVW5RjkCRRsZAR7GGJeKb@vger.kernel.org, AJvYcCVCvw5CtI4paRtg1QiklfZYJUtWkzxKJ1hlbir/3NrT5GxhWYbd/GInBORufuUdVRgG2Y98IMO3Ho2Lz4kH@vger.kernel.org, AJvYcCVSGRLW1AlYipcpkNWLCJmOjKvH0qgJ3h1UILSL7UDetkUSz1ynDS3pMXavFTKoFKFJiId845iNXGZV@vger.kernel.org
X-Gm-Message-State: AOJu0YzON4oqPqDdx/dLkSEyDpDdEn9ked41/dD+bKAFGNHEwuqBF2lI
	ZkD8L/sH5rxEH/7VROz/OGXKuCjbWZ3S/WhtTt3wJqK9oSoeZdqd
X-Gm-Gg: ASbGnct78r5lKFy1osokgTGJTytw0CxdOb6Etd1VdEMtMf0KCjhYAgsvQ19sJddFciV
	NeeEeQhQcvj4+t2drXRrPM7GyOksBvEeTi2X1PBlxrvUhlyfwTfcwbWOv8yXA0Upn8cePGyu0jO
	iqWR0p2eYrfybcvhOt0DbfPVZvehxm/D1wJWbY2ZtvMSLv/AuXwIvhtklwSoFX0qNIycMP+7kKa
	EtFV9QmpmxrGqF/bMLWhmdqbgCPSJRTtRL6nkXsfXswtI5e1HobEx9SnVTKnWVrBw7g02SHV+7k
	fyE0LihdS1LAopES8k0k9rI+3bIhTPK2I/Zm06fzMS+9tfbAqbeUj6+9lq8vghp6GxdvbO6Faw=
	=
X-Google-Smtp-Source: AGHT+IGYG9XakyW+UdqNNLCDXpKkxXWG7Y4hV03XJnaZ6z+kf+TWlmY7SAdaNuPfFRb4w3Wi/uqpzw==
X-Received: by 2002:a17:907:988:b0:ab7:da56:af9f with SMTP id a640c23a62f3a-abf26859581mr2151760166b.49.1741102501551;
        Tue, 04 Mar 2025 07:35:01 -0800 (PST)
Received: from [192.168.1.132] ([82.79.237.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf74e85fbfsm404613066b.15.2025.03.04.07.35.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 07:35:01 -0800 (PST)
Message-ID: <09aba9f8-354d-4987-9026-37eb3ca26d6f@gmail.com>
Date: Tue, 4 Mar 2025 17:34:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] clk: imx8mp: fix parents of AUDIOMIX DSP/OCRAM_A
To: Abel Vesa <abel.vesa@linaro.org>, Abel Vesa <abelvesa@kernel.org>,
 Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Marek Vasut <marex@denx.de>, Stephen Boyd <sboyd@kernel.org>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Adam Ford <aford173@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-clk@vger.kernel.org, imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250226164513.33822-1-laurentiumihalcea111@gmail.com>
 <174102305899.2928950.8837177294161174759.b4-ty@linaro.org>
 <Z8Xn7f6vXg0aM4zx@linaro.org>
Content-Language: en-US
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <Z8Xn7f6vXg0aM4zx@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/3/2025 7:33 PM, Abel Vesa wrote:
> On 25-03-03 19:30:58, Abel Vesa wrote:
>> On Wed, 26 Feb 2025 11:45:09 -0500, Laurentiu Mihalcea wrote:
>>> Correct the parent of the AUDIOMIX DSP and OCRAM_A clock gates by setting
>>> it to AUDIO_AXI_CLK_ROOT, instead of AUDIO_AHB_CLK_ROOT. Additionally, set
>>> the frequency of AUDIO_AXI_CLK_ROOT to 800MHz instead of the current
>>> 400MHz.
>>>
>> Applied, thanks!
>>
>> [1/4] dt-bindings: clock: imx8mp: add axi clock
>>       commit: 2471a101938b0d1835b1983df08daeb98eef1205
>> [2/4] clk: clk-imx8mp-audiomix: fix dsp/ocram_a clock parents
>>       commit: 91be7d27099dedf813b80702e4ca117d1fb38ce6
>> [3/4] arm64: dts: imx8mp: add AUDIO_AXI_CLK_ROOT to AUDIOMIX block
>>       (no commit info)
>> [4/4] arm64: dts: imx8mp: change AUDIO_AXI_CLK_ROOT freq. to 800MHz
>>       (no commit info)
> Applied only patches 1 and 2.
>
> My b4 setup messed up. Sorry.
would it be possible to also have patch no. 3 merged via the IMX CLK tree? I'd like to at least keep the first 3 patches together as they all fix the issue of OCRAM_A/DSP clocks having the wrong parent. if not, Shawn would you mind picking up patches 3 and 4? Thanks!

