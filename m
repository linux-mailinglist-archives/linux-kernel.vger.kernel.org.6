Return-Path: <linux-kernel+bounces-572464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5617AA6CA91
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 15:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19F063AEF17
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 14:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2C722155E;
	Sat, 22 Mar 2025 14:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="kEHuW3fP"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71467136E3F
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742653658; cv=none; b=iIa/w+0xYZvRKbNAfIr+zyBlmWnd8AagB0x0uU7uK/mlQ27NvvHbh+AXx0PwgENL1zQ7dcA+dMRulrYw/pqiYmvVyAtUCTEge30QJx8WKVwdxG0GSICgU5vEK5XJC3Z0MpJdXcLPm2+opt7E/d8OE4FNeXvAZbEgYTaLLmwpegM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742653658; c=relaxed/simple;
	bh=wpCm+hqOG2wsbtPLPSsueiJdiduXYzbm2JN6/V7qei4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y3j/jGG+xyoUuyJNFLvCdGLEDd3q59pQOcymkTROVpmJDypWb6X9U0dPUuWCjgcshjWpdTMJdZRoT0SiIWPkG19pY7il4dMsrDuT/4w2mKga18SsGAqOdP5DYx3Qeyoh6qXGuCyR/ji0h/5/D6JXnrit9gKgyRK/eK9mjF1k9QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=kEHuW3fP; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-85b4170f1f5so78822839f.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 07:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1742653654; x=1743258454; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZxLNYJpvB/TXLfXAqOdKhmy/q9FPbJFzYq67r8P8xbE=;
        b=kEHuW3fPfu726en3O8HTTUvD7b2bnYxF/E6T2FNNhZEAQqq986sLpeCS8/waNy+3zG
         i8iYZ2PYNQ9Hjh2I+ELvrGFjPj0IFPeajwjcn0HOCZKXnztsMyNGuUfW8ehxjjD9f4aT
         Cs1AlxPFtF/C4kOhyNl6zDvjeLKqmw+AjcybgoAJrXSM6vbNh68oTvND+XAjI4OuKnHQ
         6VIFiVJ/z0Hrq75nE72h7c/ePE/2+4XiSSfjanKyT1b7uV8QcHX7E5r27eXCXGEESv1/
         sKEuctf/5Dqj0Q7/lYfUTH7FKD1nqhQTBwaAN4ZUygR+BTE3LzJxrkdZPt4SF37nfGfz
         zwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742653654; x=1743258454;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxLNYJpvB/TXLfXAqOdKhmy/q9FPbJFzYq67r8P8xbE=;
        b=E6Sn76OZHIvfmRXalcdwgTLGMigbt/Yz13vvIFnlIYRfC8iOGsC8gCjj6DmoJchPzB
         7NBZodNZDm1XdsIxZU1HkZMj7lBNM6FvYTJHX7TbANrO2732jEg7rao+j2w/Qpt2Sylq
         Gjtk8QTCb7pTGccbQ6QEB/mhArKR3lN/r5zbjVaKdWUW/P6BiT4KnpV/qno3udqilYXF
         xUVcuJN0PW2s/YM5wGhY/ozM7ReORpCychbf0DnQ/3KnyoBCoNSo1umurzxydAmObr6b
         bZb0iBwOE8K+DZnaq6HCrDOVNvoDEM50V20AFSBp+KxWL/QhY/8Wd6ivOBecBoQvuIki
         NcHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaesvCElzMUG7+yfvaGWUCman5loC7GL5PVDnuuqjYh0OH0YCzD+TNdl0UShHaEPhjFhL0f+kpfjNn8qA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmawSVvzui0yTmJApC4GlPm8FGQiXOVK3OIpf0krpah2k7Lczj
	QzGVRXvXBHic4sBqqlDtSVJdgpYgnwS5DM3ncjYEAowCvefUULj3w+Trc3LwSPA=
X-Gm-Gg: ASbGncvI+s/iyHXNq/hqAHYl+lAB4KaqinWloWCn/wgsdctOLVOICxM/XvtcxIv6+4o
	UMoERTslc3A103CkqrzPLEUk8LE/vO4BLpCXpKq3wlmS1zQdy2jS5rCrTOdocVgoISpMw5LMybl
	K0AuGWtmFAEvq6+J23NOHBPpDmZYQK2m4bLuo9gDm3d2v6crG5+xqHNkm36YGqHqf8aw7fwScJJ
	Fv4spVMtOxTCMRPJIoGGC/fv5/T1ocdqpO9FjZqNWRq5I+9DWDwhqob2yepY3np6StgxZqppfod
	gNAITAhD0iGRwFj1OBUpOrHHCHHSykok/klNWs2LLDg0GAcHascSxSY/h2TX41yLnGWM9CLuM5A
	Z02jJYwuHUuf138iEzQ==
X-Google-Smtp-Source: AGHT+IHxH2JRqswkpmkABiwFlVLWGLbm4QGv8PyCPkc/LYC5FudrlksXf1TKCySAHhTc+btPlG9CLg==
X-Received: by 2002:a05:6e02:2585:b0:3d0:235b:4810 with SMTP id e9e14a558f8ab-3d5960bf9b9mr82023985ab.2.1742653654335;
        Sat, 22 Mar 2025 07:27:34 -0700 (PDT)
Received: from [10.211.55.5] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbecb453sm908223173.142.2025.03.22.07.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Mar 2025 07:27:33 -0700 (PDT)
Message-ID: <1d79fb7e-4501-4c62-8379-f00515dec3e4@riscstar.com>
Date: Sat, 22 Mar 2025 09:27:32 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/7] dt-bindings: soc: spacemit: define
 spacemit,k1-ccu resets
To: Yixun Lan <dlan@gentoo.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
 heylenay@4d2.org, guodong@riscstar.com, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, spacemit@lists.linux.dev,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250321151831.623575-1-elder@riscstar.com>
 <20250321151831.623575-2-elder@riscstar.com> <20250321222546-GYA11633@gentoo>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250321222546-GYA11633@gentoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/21/25 5:25 PM, Yixun Lan wrote:
> hi Alex:
> 
> On 10:18 Fri 21 Mar     , Alex Elder wrote:
>> There are additional SpacemiT syscon CCUs whose registers control both
>> clocks and resets:  RCPU, RCPU2, and APBC2. Unlike those defined
>> previously, these will initially support only resets.  They do not
>> incorporate power domain functionality.
>>
>> Define the index values for resets associated with all SpacemiT K1
>> syscon nodes, including those with clocks already defined, as well as
>> the new ones (without clocks).
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   .../soc/spacemit/spacemit,k1-syscon.yaml      |  13 +-
>>   include/dt-bindings/clock/spacemit,k1-ccu.h   | 134 ++++++++++++++++++
>>   2 files changed, 143 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml b/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
>> index 07a6728e6f864..333c28e075b6c 100644
>> --- a/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
>> +++ b/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
>> @@ -19,6 +19,9 @@ properties:
>>         - spacemit,k1-syscon-apbc
>>         - spacemit,k1-syscon-apmu
>>         - spacemit,k1-syscon-mpmu
>> +      - spacemit,k1-syscon-rcpu
>> +      - spacemit,k1-syscon-rcpu2
>> +      - spacemit,k1-syscon-apbc2
>>   
>>     reg:
>>       maxItems: 1

. . .

32
>> @@ -180,6 +184,60 @@
>>   #define CLK_TSEN_BUS		98
>>   #define CLK_IPC_AP2AUD_BUS	99
>>   
>> +/*	APBC resets	*/
>> +
> I'd also suggest to drop above blank line, keep style consistent
> with others in this file, some same below that I won't comment

OK, I'll fix the weird extra line and will drop these blank
lines as you suggest in v2.  I'll post another version after
Sunday.  I recognize the merge window means I can't expect
reviews during that time, but this code is waiting for the
clock code to get accepted anyway.

Thanks a lot.

					-Alex

>> +#define RST_UART0		0
>> +#define RST_UART2		1
>> +#define RST_UART3		2
>> +#define RST_UART4		3
>> +#define RST_UART5		4

. . .

