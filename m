Return-Path: <linux-kernel+bounces-299969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 349B895DD1F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 11:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5BCC2823C8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 09:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7225E558B7;
	Sat, 24 Aug 2024 09:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8uD5bhW"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C9C153BD7;
	Sat, 24 Aug 2024 09:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724490516; cv=none; b=uG76O8sZxXYnVOiLA/uXjlRr5IqxYXAJBDZVxiV/nK5ORK/7dczmSoyiXMfg4ywtCkKlqV5b8/eIp4ZNQ0g67ug+JeEUhUcDf9Rmpa61CET7I/q6jkPGYNc7M6DW//l+OWfVwggPXlLTHUOPklv9d67je+AdJD5bl0wzzGbaKE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724490516; c=relaxed/simple;
	bh=dnrq3nAfAIjKHv4vgKKORz9Eu/PVTF68C2/MjqjoGgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=efyUt6i172Sgq+MFfJvMOEmjw77wo82g1prulqIjWv+yyo3PsicU4o7Ic6N2PDDIA5gF7wou8/ZwO6PkmzmC2rUnv2b5bSoVySewv9Rc0nR/+u+ZGFxUG/cLWrfbdHTSjNveeIy1oDoCtFb54A5MOyhLnefSMtzbdzCoBXKcbYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8uD5bhW; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f3f25a1713so29878741fa.2;
        Sat, 24 Aug 2024 02:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724490513; x=1725095313; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SzqC+bM7GYWxxOd8UV7RP5k+Z1ytl+o41N4B5Ixt0pU=;
        b=S8uD5bhWqUwEyAxxwxung88BKXvs5qmpZeCSfsABH/GeT/lYXgLJArnyL9ry8nvqmF
         tD4wWHBytbhdNskuBEMw1Y2+jP/Uz6vRt1ok82P0pj97eqvBC7RCvtaja49UWOt6q33c
         ByBvJSvbvJAyW5fXAMY+kzl8mEXSTWESHeZ/WW/2GZxw24s31Zgjy1xUwCNW+3s3qAen
         +64apPFwsyFhlyf7E88JebhSXaBf2G4metoBZ3F6tCFXWyUg6gn+d8+kryWh6T954xIh
         UqeZpxckalEbJLhnI6RrjRtMFzwFW0woC4cfCWxp5u91E2zuerDmTe0b77SgGRDv2lUZ
         BM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724490513; x=1725095313;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzqC+bM7GYWxxOd8UV7RP5k+Z1ytl+o41N4B5Ixt0pU=;
        b=BEQE3sBUXVdjTp5hkvTfk/DdIpupOxl+ScK0UWxHpfKxxgPScLMtGotqraXaGjNPgr
         tFworpwukQchFRPw1fd2+KlNH0/P0KjiEkes7+SkdRAPHhm0UsWgbZKMnjI7ZuYU1o+a
         bvxXC5g3wvDLEjOEu6+hqIISKjKtgBJp6du7WWT35YK4s6C+fTB9adK2Ef16bzsIJpnj
         02GH1XGtTi5wVk5YW3EsE527wjerfkEU5IzjDp87aXvhFEhbQbb+P6xJB3wiLVTLZiWY
         B9SgpQgDBouDWFYKPb/OJ3qCrVyNekAQHAabXPlHvD0fKKrDkMq3yGfgBonJo3HID8eC
         S1Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXF0D8V5mgRytXX7ma8HlFDmUCs/5a1iP3nHj5DgNB2MuzE5hap/Bn0CHkLrLdQiY2wwk5idvhvTjiXEBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuOH8lCXLy69NRajYJtOwtG02TfnVHFJo5uP0EpG3UqiN+bxen
	Icgw7fy608rMlWgjldEZ9OpQh4FGvnNiu4byvDnjjxIgznLXaKvjEA2Fyg4Qhto=
X-Google-Smtp-Source: AGHT+IExt61YW91dFLoRQK40P3IQvtOL+Im+C3TkCYSJOahFeS8y6zD09KodCzTpbndKpy1DrbtyrA==
X-Received: by 2002:a05:6512:1390:b0:533:c9d:a01b with SMTP id 2adb3069b0e04-5343878403emr3348395e87.29.1724490512566;
        Sat, 24 Aug 2024 02:08:32 -0700 (PDT)
Received: from [192.168.0.241] (85-193-33-51.rib.o2.cz. [85.193.33.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f47d1easm372626066b.160.2024.08.24.02.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Aug 2024 02:08:32 -0700 (PDT)
Message-ID: <51f28d92-f670-47de-8e2d-53cbecfac081@gmail.com>
Date: Sat, 24 Aug 2024 11:08:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH PATCH] arm64: dts: sunxi: nanopi-neo-plus2: Add pio
 regulators
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240824-b4-fix-nanopineoplus2-pio-regs-v1-1-7c5f7da445af@gmail.com>
 <761f18d4-9274-4983-a128-94efb96e1c59@kernel.org>
Content-Language: en-US, cs
From: =?UTF-8?B?S3J5xaF0b2YgxIxlcm7DvQ==?= <cleverline1mc@gmail.com>
In-Reply-To: <761f18d4-9274-4983-a128-94efb96e1c59@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I am sorry if the message is wrong, this is my first patch ever sent to 
the Linux kernel. I have checked the schematic of the board and it 
shares the same power line with mmc0, so I assumed I can use the same 
regulator. Thanks for your feedback and I would be glad for your further 
response.

Dne 24. 08. 24 v 9:40 Krzysztof Kozlowski napsal(a):
> On 24/08/2024 09:09, Kryštof Černý wrote:
>> The board does not have a dedicated regulator for pio and r_pio,
>> but this fixes the kernel warning about dummy regulators being used.
>> Tested on the actual board.
>>
> Judging by commit msg these are not correct regulators. Please do not
> add incorrect hardware description to silence some warnings coming from
> OS. Either you need proper (correct) hardware description or fix the
> problem other way, assuming there is anything to fix in the first place.
>
> Best regards,
> Krzysztof
>

