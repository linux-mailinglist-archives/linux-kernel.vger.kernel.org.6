Return-Path: <linux-kernel+bounces-570554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEF2A6B1EB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 01:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0646B1891D92
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E5A2F43;
	Fri, 21 Mar 2025 00:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="eJ+33smC"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BD5360
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 00:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742515564; cv=none; b=DUE2haaH8ljg9mnrc0r/KeSdWr1fsOrVu2UThVtBk7CVw+YucCsZAZ39mxx/S1NYUUfzgeO5uUkB8pIb/IfwfA4KJZxQKTXEC8yiwbDnesp9H8erlavhXfvU+wjPrzkhveH1z3v8s4GFESIblaj97GHCr3K8OWTwWUetAGubT5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742515564; c=relaxed/simple;
	bh=4f49NoS6Ua2AtL9jlFnIAyhaoPKsxkb9yMLM+0JPwKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h/Eo681XXpazM7qzl5W/gQyvPGDVVyz414MPFPqakcDj9PKd5cnoFcxldjGQTVP2xQCOm414OJcwq7gwEB+Gi54yYt8P7vIkenotRjJhm+LWaWc4nn4KE/gd9D1c4icwblZ+YPuDnv7a5TE/5+Y67lmaSmp4NLY6oEg3avCBwOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=eJ+33smC; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-851c4ee2a37so92024439f.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 17:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1742515559; x=1743120359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n4TfadqjZ0j6MqAFYL1jRZZ+rK1DG5WpxhhztW2TPnw=;
        b=eJ+33smCVGN/OpGikNX/kc3IWU+asSq1neNaQ6GSnLCKBTlDiHhVPbzALfv892qyUh
         1jgcfqMO01t5Qzc7Qf8loUM8gWIleHUdxWuleLkb3tmtw5Sx45gUIoczFgrxeIFyhgRO
         8l+8VPVzZhqTjoskLXEpNQFSRWwVgkLTLMRtiMrzvelnLMZwnOJv90X84Yg3xleRoxSL
         89tFwZVGT80mCR8wUeGPoQ0WewS5RDc3ECKYAmdXssGq/ySPSoYAXQcfa1zv5HBckEbY
         uy3OpD3xDg7ZxBA+fLG/jcu15HFzLCuVndzqS4O9EAEcdKW1DI1bm82QI/ozWiwO1gKJ
         1JTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742515559; x=1743120359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n4TfadqjZ0j6MqAFYL1jRZZ+rK1DG5WpxhhztW2TPnw=;
        b=A/y9VWiyasbGBQYXDm03AnKUwl0257e7570Zwv8ygPEtyFZMsoXXYlurVIXJiVJPH3
         uS8jxycYeCQ1V9SVv/fWBKyHDsMPEdku/X/6r7ovPg1Xeu/pI4SF8rs/Vn05P8d4QDgl
         owS2JraaQcPc/3mYGpHJPoNIO1KaU1TLG2bGabGtjHg7gg1Z8OfzNTFjdKTiurhVrzNt
         GXPfvh90yD/OWFcPlYOq3PqQF/57gJ/AjbrfHeHNq+Z/3HCfy0QeJ5TCsX0RRTAf1jIv
         8tvv7Yr7xy00dfm/n/hEGUKMMkNZxKRFOFb28ffN1T82lAk8f+Cz22O9xvotBPflBe6L
         Z6FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUf64eqpt1VtpeNgIhs3/kGy6c8QJpYHoTg3f7IwkoPSsfevfuM1Z73N0GBbGFXwgjRRZ1WX8JPvOjMmdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5AHZyLlIufTmc9VEiA0wFqEs5QWAfssBCPATGlCIJqksArrhh
	BMSdDK//TbnvyjhpaeuaOgKK5KRW4JqI3ksHNu6CJp/h6oElEOgldoFKTxthQnfvRDW2cwZKcEn
	cx8YYbA==
X-Gm-Gg: ASbGncuYZf5G2r2ZJBgYMlhbNMEUizggdUjUzoyLNS22i08R/mAZzCeAwFiQ/YKKh6O
	XNha3PYP1FFkIepGuMxt7Y11tGzEUV2Vkd/jrzdgyUDybXREFXs1GE7GHzORxHutv7bfpWbhDv9
	cE1zXABkg1abe6fiTvC+PKmjkfb8Kuor1/3i1Xv5Sw3BVNZkLyGmUuoAbTRMaJWFMahqJ1RPFvN
	jODObON6xz3cKyk2jOhRggHf2Gpw4UFlq3FSGO9YKjXJuKtiISTCZNJy651g/PBcp8fwGBpriv6
	UHwG68vcwLYjDxMkxs1Xk9vHAFIVs3xVQMaEy9ikgCggTEinSmmbqaXQ90LmMiCHQIVP4AEFXL7
	TyH53o+eMUfmXl30GrBm5WyMWv/OD
X-Google-Smtp-Source: AGHT+IGzFnEpgZCQdgtfV3+fVi3PtzjOuuJwDIrbNxEcjYjLjI8xkEowRotMUucCu+Yti4QqnIOtrA==
X-Received: by 2002:a05:6602:3f08:b0:85d:a5d3:618c with SMTP id ca18e2360f4ac-85e2cb59310mr109252739f.11.1742515559239;
        Thu, 20 Mar 2025 17:05:59 -0700 (PDT)
Received: from [10.211.55.5] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbeb21b0sm167895173.115.2025.03.20.17.05.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 17:05:58 -0700 (PDT)
Message-ID: <fe26de4f-5593-4f34-a752-5fb051972c31@riscstar.com>
Date: Thu, 20 Mar 2025 19:05:57 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] clk: spacemit: add K1 reset support
To: Yixun Lan <dlan@gentoo.org>
Cc: p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, heylenay@4d2.org,
 guodong@riscstar.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250320194449.510569-1-elder@riscstar.com>
 <20250320232128-GYA10498@gentoo>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250320232128-GYA10498@gentoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/20/25 6:21 PM, Yixun Lan wrote:
> Hi Alex:
> 
> Thanks for sending this patch series
> 
> Can you also CC spacemit mailing list: spacemit@lists.linux.dev
> it should be handled automaticlly in next 6.15-rc1 version as the
> MAINTAINERS file updated
> https://web.git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/commit/?id=4a0c4e723c94

Sorry about that.  I will copy it on my next version.

Are you asking me to RESEND this series with that addition?

					-Alex

> On 14:44 Thu 20 Mar     , Alex Elder wrote:
>> This series adds reset controller support for the SpacemiT K1 SoC.
>> It is based on Linux v6.14-rc1.
>>
>> It is built upon the clock controller driver that Haylen Chu
>> currently has out for review (currently at v5):
>>    https://lore.kernel.org/lkml/20250306175750.22480-2-heylenay@4d2.org/
>>
>> It also depends on two commits that will land in v6.15: 5728c92ae1123
>> ("mfd: syscon: Restore device_node_to_regmap() for non-syscon nodes")
>> and 7ff4faba63571 ("pinctrl: spacemit: enable config option").
>>
> you can use b4 to handle patch dependency, and currently you may got
> linux.riscv.bot complaint, but may fix later
> https://github.com/linux-riscv/github-ci/issues/24
> 
>> The first patch adds three more system controller CCU nodes to those
>> implemented by the SpacemiT K1.  The second updates the existing clock
>> driver with a structure used for OF match data, allowing both clocks
>> and resets to be specified.  The third provides code that implements
>> reset functionality.  The fourth defines groups of reset controls
>> implemented by the CCUs that have alraady been defined.  The fifth
>> makes it possible for a CCU to be defined with resets but no clocks.
>> The sixth defines three new CCUs which define only resets.  And the
>> last patch defines these additional syscon nodes in "k1.dtsi".
>>
>> All of these patches are available here:
>>    https://github.com/riscstar/linux/tree/outgoing/reset-v1
>>
>> 					-Alex
>>
>> Alex Elder (7):
>>    dt-bindings: soc: spacemit: define spacemit,k1-ccu resets
>>    clk: spacemit: define struct k1_ccu_data
>>    clk: spacemit: add reset controller support
>>    clk: spacemit: define existing syscon resets
>>    clk: spacemit: make clocks optional
>>    clk: spacemit: define new syscons with only resets
>>    riscv: dts: spacemit: add reset support for the K1 SoC
>>
>>   .../soc/spacemit/spacemit,k1-syscon.yaml      |  13 +-
>>   arch/riscv/boot/dts/spacemit/k1.dtsi          |  18 +
>>   drivers/clk/spacemit/ccu-k1.c                 | 393 +++++++++++++++++-
>>   include/dt-bindings/clock/spacemit,k1-ccu.h   | 134 ++++++
>>   4 files changed, 539 insertions(+), 19 deletions(-)
>>
>> -- 
>> 2.43.0
>>
> 


