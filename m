Return-Path: <linux-kernel+bounces-300064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E33195DE54
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 16:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BA0E282F23
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 14:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B7E176AC1;
	Sat, 24 Aug 2024 14:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOhWRufE"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A8B224FA;
	Sat, 24 Aug 2024 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724509487; cv=none; b=MDjhYKOZR5+Cml7JSNhypW6of/obMS4aYEsAyjckslzjvh8i6PKz9kIKxut5TmgG32Q9N5Oq6P/i08EB2ZBBKKMi1kO7zliHC0oHuv31jj7C66AaaOcnN9PGTPE2AoNowznetFUR0WmDAIJnZ/w3skhWY3iWPYLAccvmiO2wxzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724509487; c=relaxed/simple;
	bh=Pzlpm1U5Hh/l25Nd14ZVktI3g3nu2blzLBRseCLtI9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E6/HPRC1aJaGqEwEYlFUByzcVMHfQRWQAqUqU/Sv1vLI3PFGW8H4Dr1YzobOu2xNUCzDoFpRyStmmK1vFivnzO+wTh9sV+r2I1u9nitYRsCsQWGwcPrQCKSJzGPiJzZhD1Cg5g27YxXW1wZt5Fn0bQTGWbb898OhRnCNnC7fEvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOhWRufE; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37186c2278bso2047378f8f.1;
        Sat, 24 Aug 2024 07:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724509484; x=1725114284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lIhY95YBiA5IEBvFsoRskljHwYpqZBhPcTrq+7ZZ12o=;
        b=IOhWRufE/svDC0oLR8LTq/Hm9RnrsS75/Dt1GevQZYnjChZ2lL4uguYsGOOba3c58T
         Ae5YjrKxnqeSmz9JRd71paZPQAitmWAInkv7j1dxnWVjtjxFgjDCSGoOYNs+1v+EUufQ
         h1JAaAxjDuGOX3mFokm/0j4bdm1FkavRAF8J72VwJIRlgVwaLSfjUj9SIk5LSAoAIRXv
         RAU5OIijsrGR/4p7oNUlFgqBRlitQEe1ymWMexZludtpzKXUTxtrQxCelO6rqkWrGv7t
         fiHN89IdoIUD4jCP5i6bbXNYSFwNanqOO/g2a/pSEqfWoUrMr8HAaBZ63sIxEzzVJcXm
         RGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724509484; x=1725114284;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lIhY95YBiA5IEBvFsoRskljHwYpqZBhPcTrq+7ZZ12o=;
        b=ORN9LIQrZqjMl5UaC2fxP6pxGzKLTV7BLVT5JAymRPGWy5hWxiHmaR19j+PrBjUqyA
         DsoAcd1tc+m3VzeANDuCvF2hcOLWU3W64u48i1ZfpowhgmXC29bf1k8nDWfSXKxwcX8a
         6AqHlz9hgNO1BWJUlVxsLhf2PQDY3ILfzYphJf7YbMzDpGW/evuJTwaQdQykHLkFJnIR
         zq4IY98ZuRK7riscIikVvqZvp1+xrhnsuNkMHQdJuv3Jwi7w1/Cxpto3ryuncbfxnoip
         wbYH0ov87jrzJovpnYphB0j8krCmQGFrzhhWHKRBk/0kt/d1ZoqE1FSo91pNwuHge/FV
         xIpA==
X-Forwarded-Encrypted: i=1; AJvYcCUd3HoTCL98D1JormqB8RhykIVEg7jjMvp1xjIro/FvwSnzZAGpXUNQjepyaZZCmqVl5h3jbwGIc/eB@vger.kernel.org, AJvYcCWBZcvwyq/1/x77xI7eeM5y6k7+nJpAr9GJWto3oNKnlSbDOolkDXa4Csn2VynVRtOzPqtYuN8ZL4eK16KZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxHJ7EV6HEl+SXWUKKdwum8Toh0eBvH6nZqqr9cRIREcddfYnWj
	tqOj03jbLhw4s/YaXPzafrn/72DYYPeV9BIv4lMv0IxY3t8ctaSD
X-Google-Smtp-Source: AGHT+IEF8eS5Jk/Zs8iIWVZRQw3hbxWOnuvXeJ7gHzY3H6qlkumhIhgHfYfIoRkLx4ce9M/FKKp5/Q==
X-Received: by 2002:a05:6000:1b0f:b0:366:dee6:a9ea with SMTP id ffacd0b85a97d-373052dbfedmr5680683f8f.26.1724509483381;
        Sat, 24 Aug 2024 07:24:43 -0700 (PDT)
Received: from [192.168.0.241] (85-193-33-51.rib.o2.cz. [85.193.33.51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730813c465sm6676244f8f.32.2024.08.24.07.24.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Aug 2024 07:24:42 -0700 (PDT)
Message-ID: <aa33692c-4cae-4c41-959d-f2ecd56334b7@gmail.com>
Date: Sat, 24 Aug 2024 16:24:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH PATCH] arm64: dts: sunxi: nanopi-neo-plus2: Add pio
 regulators
To: wens@csie.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240824-b4-fix-nanopineoplus2-pio-regs-v1-1-7c5f7da445af@gmail.com>
 <761f18d4-9274-4983-a128-94efb96e1c59@kernel.org>
 <51f28d92-f670-47de-8e2d-53cbecfac081@gmail.com>
 <CAGb2v65M6Zz7=TfRwF0urbELNaaazMZYsd3dtHYzwdJvzoho3A@mail.gmail.com>
Content-Language: en-US, cs
From: =?UTF-8?B?S3J5xaF0b2YgxIxlcm7DvQ==?= <cleverline1mc@gmail.com>
In-Reply-To: <CAGb2v65M6Zz7=TfRwF0urbELNaaazMZYsd3dtHYzwdJvzoho3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Yes, you are right with vcc-pd, I misunderstood it, thank you. Let me 
explain and ask about the rest:
VDD_SYS_3.3V = reg_vcc3v3
Groups PA, PE, PF are powered from vcc-io, according to Allwinner H5 
datasheet, Vcc-io is connected to VDD_SYS_3.3V, just like mmc0. Should 
those be set or omitted?
vcc-pc (ball G15), which is labeled as vcc_io2 (probably wrong), which 
is also connected to VDD_SYS_3.3V.
vcc-pd (ball J15) is bonded to VDD_PHY_2.5V, which is always on and made 
from VDD_SYS_3.3V, so I should make a new fixed regulator of name 
"reg_gmac_2v5"? Mainline eth driver does not implement this pin, so it 
would be used only for the pio.
vcc-pg (ball H7) is also VDD_SYS_3.3V.
While PL is supplied from vcc-rtc (vcc_rtc, ball K6), it is connected 
directly to the VDD_SYS_3.3V too, should this be the same regulator or a 
new one or omitted too?
Do you agree with my findings? I hope they are 100% now. If so, I will 
try to make V2 with a new fixed regulator of 2.5V for the PD.

Many thanks for your replies, I will do better next time.

Dne 24. 08. 24 v 14:34 Chen-Yu Tsai napsal(a):
> Hi,
>
> On Sat, Aug 24, 2024 at 5:08 PM Kryštof Černý <cleverline1mc@gmail.com> wrote:
>> I am sorry if the message is wrong, this is my first patch ever sent to
>> the Linux kernel. I have checked the schematic of the board and it
>> shares the same power line with mmc0, so I assumed I can use the same
>> regulator. Thanks for your feedback and I would be glad for your further
>> response.
> So some of the pin groups do have dedicated supplies, and should thus be
> described, but not all of them. The schematic only shows dedicated
> supplies for PD and PG pingroups. So just add those. PD supply is from
> 2.5V ethernet PHY I/O regulator supply, so you would need to add that
> as well.
>
> The datasheet also mentions a separate supply pin for PC pingroup, but
> it is not shown in the schematic. I would just omit that.
>
> And as Krzysztof mentioned, device tree changes should be to model
> the hardware, not to work around some operating system warning. At
> least most of the time that is. So your commit message should also
> be about fixing the description or providing more detail, and not
> about the operating system.
>
>
> ChenYu
>
>> Dne 24. 08. 24 v 9:40 Krzysztof Kozlowski napsal(a):
>>> On 24/08/2024 09:09, Kryštof Černý wrote:
>>>> The board does not have a dedicated regulator for pio and r_pio,
>>>> but this fixes the kernel warning about dummy regulators being used.
>>>> Tested on the actual board.
>>>>
>>> Judging by commit msg these are not correct regulators. Please do not
>>> add incorrect hardware description to silence some warnings coming from
>>> OS. Either you need proper (correct) hardware description or fix the
>>> problem other way, assuming there is anything to fix in the first place.
>>>
>>> Best regards,
>>> Krzysztof
>>>

