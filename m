Return-Path: <linux-kernel+bounces-570480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7E4A6B10D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56226982064
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 22:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759E6227E9B;
	Thu, 20 Mar 2025 22:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="U8axf0W3"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A089524F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742510358; cv=none; b=g7nTrNIMhyHKwY+hp8oHFcDcOZSD4X/ww6usOTELdTQx7em3ijhJ6hp9wCKOCf7YzxUtauccM5o7/DRBHV4DVOlMdh3LQmZWWlz7pseLciZQ5vO/w3IyNw/jK+HyNA5+XuoySD0ezBVs72dOiXvhrkzPcihGA4Zfvt5Y8UGz/E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742510358; c=relaxed/simple;
	bh=j8hDLkAQI9+JmAMX0TJqZyvjUEbu1kKiPGbRw7hGyE8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rUR7vVz4UJAt+XiW/lQ+a2q7C31gFO7S9ZCU+MW/5sM5qNWGBqi9yRgN6yEkq5K5UcAM9hfRdCvXtwYJEjM3hhxJarBwww07Kamm9e3s0beULsdjfDi5Vaa4t2e5XPFrb3I7+7u8rJbe/XPJFDKazE7EZJYbCjbHfrpZKf/QYRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=U8axf0W3; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-726819aa3fcso843402a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 15:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1742510356; x=1743115156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0fpBn8OJHb2DipzRLEI+UAj/Fv1bNkdtkXE17lBcc20=;
        b=U8axf0W3geH9bU0a8/oNck3oKiFq3/mi9h4L6FVu3iX0GulN9b98p2y3p4zai39R4G
         6aawtdLGCsgHBHBwLVhR7K5AMJ29n5ZXpwCycSy2qKI4Dk2QlFKpJ3ULB6Krlz6yQXfK
         BeEadLGFvPZ7btl9qgD5RPkBPs005+eF0C1Zh6frnG8dBvEQ84GkW/O0oRQBLPKJp/tw
         7OkANh/QZ0J3J8FPYO/4rMF/Kcy1zO7iy7QbP6sitooh4t9okKre/PeBTz24kzNgx9om
         tpnL+xPDCR3a+aR0RvySvXX3K7Sp74z4Xrqbb7B83U6WuNEpXj925/kOos8A7TTM5Oao
         FUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742510356; x=1743115156;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0fpBn8OJHb2DipzRLEI+UAj/Fv1bNkdtkXE17lBcc20=;
        b=Cznio+p9H/HH00kuBSwHxnb9prLBsEif54VtfEVp/PiZQ1XZ8wSvYsctG1qmvy3Gkk
         ePPUKq1RGXF5FMhUSkFX/BKHq94nedzzCV4azknz6gixzFAZFH12e04iStatoF957uLa
         fOsQqFmtiDlNsXMLgzZno4kV3Ci3Qy2WWFLirtnPfgxcZEhwr17WzTZhCeov74Z8Bp3F
         JLhyDIH+dnbw27p8l/a8nvExPsjIKsbzSYb0VOrZjgbWJymckgfVnPQU2DhqsDGud940
         tFPk78chu0v21vJ43Ry3UYgX4HqJTw1/NtIaAKJdGbu0a2n3czifnqkbVEE6KGnYe2B4
         NS+w==
X-Forwarded-Encrypted: i=1; AJvYcCXIF5bpiGgL766XB6N/ubYeidvpd7QTQPL+fQXqcUZhrBB6POa56Z5cUu6QoHYXbICOvpHGgRIPuKSoMxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjHj7iKtiOWI7m1wRphaMZveTBP08jvkPo7H/jEG9yPLociJZq
	2Bq0stvMAcLEWRn6OSYIJDaI1F9uMrO7I5KhpXaGHzbEnFGELjnlhMg2UZQTV5I=
X-Gm-Gg: ASbGncuFJ/GhpPMIEQQLCeLEN/+IYyRuSiT7IrOvLVuvhBDC3h6mywIp5vRJMzWPNIB
	SRsmxkp3bNtD0Rju6fIHGGVsk4l8wBFyVH6YeZ/2oMY0w2ti9uDfRqDcl2kvZhxCj5rz8VQscMv
	VOHhGyv+CmlJDSsgrNJkaYDWbHm8LGLA+HzFS6DAPuxljPiJCNDCG8ZpDX4I/giD3pVyRwdmpXn
	dVCzH/bpzb0ALoX2ucGxaKYidoJzkayiqNwO1XzHp9LKT0OtxASiH5TNk06I2D5fZyqTXGAS1Nv
	I6XBpVFShvqyepnnPsc/pe5QXv54GwdJnvqSEzyXQdC6eDwQUqUDAKEUaZ/XUZaQOZvh7Z9xGI9
	kPM3XMFBtJCj9nODQvw==
X-Google-Smtp-Source: AGHT+IGazuW7zMOIIFe93a/pSjwb+ABWXp4kDIdJjL+/LiLiDiWbJ1EYQxh1QRi47IqHdMLVTvHmPg==
X-Received: by 2002:a05:6830:7302:b0:72a:1626:21e9 with SMTP id 46e09a7af769-72c0ae6a1f9mr908678a34.10.1742510355967;
        Thu, 20 Mar 2025 15:39:15 -0700 (PDT)
Received: from [10.211.55.5] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72c0abac23esm140838a34.7.2025.03.20.15.39.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 15:39:15 -0700 (PDT)
Message-ID: <84232793-9cba-4148-9875-d996e85b81be@riscstar.com>
Date: Thu, 20 Mar 2025 17:39:13 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] clk: spacemit: Add clock support for Spacemit K1
 SoC
From: Alex Elder <elder@riscstar.com>
To: Haylen Chu <heylenay@4d2.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Haylen Chu <heylenay@outlook.com>,
 Yixun Lan <dlan@gentoo.org>
Cc: linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 spacemit@lists.linux.dev, Inochi Amaoto <inochiama@outlook.com>,
 Chen Wang <unicornxdotw@foxmail.com>, Jisheng Zhang <jszhang@kernel.org>,
 Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
 Guodong Xu <guodong@riscstar.com>
References: <20250306175750.22480-2-heylenay@4d2.org>
 <20250306175750.22480-5-heylenay@4d2.org>
 <d625c473-789c-42f9-918c-8a649d058513@riscstar.com>
Content-Language: en-US
In-Reply-To: <d625c473-789c-42f9-918c-8a649d058513@riscstar.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/11/25 6:19 PM, Alex Elder wrote:
> On 3/6/25 11:57 AM, Haylen Chu wrote:
>> The clock tree of K1 SoC contains three main types of clock hardware
>> (PLL/DDN/MIX) and has control registers split into several multifunction
>> devices: APBS (PLLs), MPMU, APBC and APMU.
>>
>> All register operations are done through regmap to ensure atomiciy
>> between concurrent operations of clock driver and reset,
>> power-domain driver that will be introduced in the future.
>>
>> Signed-off-by: Haylen Chu <heylenay@4d2.org>
> 
> I'm very glad you have the DT issues resolved now.
> 
> I again have lots of comments on the code, and I think I've
> identified a few bugs.  Most of my comments, however, are
> suggesting minor changes for consistency and readability.
> 
> I'm going to skip over a lot of "ccu-k1.c" because most of what I
> say applies to the definitions in the header files.

FYI I encountered a problem I mentioned below.

. . .

>> +/* frequency unit Mhz, return pll vco freq */
>> +static unsigned long ccu_pll_get_vco_freq(struct clk_hw *hw)
>> +{
>> +    const struct ccu_pll_rate_tbl *pll_rate_table;
>> +    struct ccu_pll *p = hw_to_ccu_pll(hw);
>> +    struct ccu_common *common = &p->common;
>> +    u32 swcr1, swcr3, size;
>> +    int i;
>> +
>> +    ccu_read(swcr1, common, &swcr1);
>> +    ccu_read(swcr3, common, &swcr3);
> 
> You are masking off the EN bit, but you should really be
> using a mask defining which bits are valid instead.  As
> I said earlier:
> 
> #define SPACEMIT_PLL_SWCR3_MASK    ~(SPACEMIT_PLL_SWCR3_EN)
> 
>> +    swcr3 &= ~PLL_SWCR3_EN;
> 
>      swcr3 &= SPACEMIT_PLL_SWCR3_MASK;
>> +
>> +    pll_rate_table = p->pll.rate_tbl;
>> +    size = p->pll.tbl_size;
>> +
>> +    for (i = 0; i < size; i++) {
>> +        if (pll_rate_table[i].swcr1 == swcr1 &&
>> +            pll_rate_table[i].swcr3 == swcr3)
>> +            return pll_rate_table[i].rate;
>> +    }
>> +
> 
> I have a general question here.  Once you set one of these
> clock rates, it will always use one of the rates defined
> in the table.
> 
> But what about initially?  Could the hardware start in a
> state that is not defined by this code?  Do you *set* the
> rate initially?  Should you (at least the first time the
> clock is prepared/enabled)?

When doing some testing today I found that the WARN_ON_ONCE()
got called.  I added some information and learned that the
values in hardware of the swcr1 and swcr3 registers were:
   swcr1:  0x0050cd61
   swcr3:  0x3fe00000
I'm not sure which PLL was being used.

So clearly this can happen.  Somehow you need to find a way
to ensure that these registers are initialized to a sane
state (meaning one defined within pll_rate_table[]).

					-Alex

>> +    WARN_ON_ONCE(1);
> 
> Maybe WARN_ONCE(true, "msg");. . .

