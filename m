Return-Path: <linux-kernel+bounces-392432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF1D9B9402
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 16:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50001C20A83
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 15:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F931AC891;
	Fri,  1 Nov 2024 15:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpD4IMGA"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3B51AB517;
	Fri,  1 Nov 2024 15:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730473774; cv=none; b=LmkmhtA8lt8heRn/zOOjxBeZT4dLJLE/5LTrIRLeqAveNL5KBv49K4MgtGtEJKx39TczirNWqgaUpOb5yh/MaR6u716SacxuHVZKe0ms2PRc1gdjzprUJ2mxCfgmMY/2hLzL/Hp2C+CXhDveCto76IUmcRyqzJWluJYagNJBgPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730473774; c=relaxed/simple;
	bh=8O6+8zSdIrOsYZwhpn/UdsD7JMLogYbKMaHww4edegI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KwQGARShHqWVXpDUVHGbmXIsdtquMBKiniUKSabFBHr+YqN2/Yc5Mm33etiMJ1nSgChn9tQ96svzcZm7CDC8cRU4ACyarBVFriwM008q7Dao4NOdy8ufeN7USZR8bsgRcrKA25XPaVvwwVieDsebhFRbmdbIs9tVAuMXAd/628w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpD4IMGA; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7205b6f51f3so1845495b3a.1;
        Fri, 01 Nov 2024 08:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730473772; x=1731078572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gjnycSKe7PLm9xEIfiXtceGbvBfhF7/8n6iYzZypH+Y=;
        b=OpD4IMGAQasFlLTbG1WWViP5oR0n2jr3z85HRlBdNg3a2dCsiNfVOUcQhgGF+ge3eA
         pqvETLyUuaHlkOnWrM84DPvFm1GXEjTouu+GtwXj+Y4hSk+S8v1m1gEDdXRCC0RyK1Mx
         bNf1s2JYaKhv0CjOYgikfpSFM8cBpJmV/kO8oJqXB0daflmuZK3YqRKg5FiD9lAVlTWE
         duKJ4rHQnPAB5CuYJnFqhoVPWw9iuQeKFhcvQW3v3QgwLhCsAW1wcy4aYSxF9wBLr+yB
         w/WuNMN2jQl2AG0tZgKA/kvpgOQtTteLb0H+lSvl5MipwfFQnCQ3FS1KATMl006ATOyZ
         4S3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730473772; x=1731078572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gjnycSKe7PLm9xEIfiXtceGbvBfhF7/8n6iYzZypH+Y=;
        b=l8UQ68tz+j/nUolIIGsJnWmU1xDE+tRy99L4wQrrNlNERebSGsLXfl2gSHqXUxRxsQ
         mXKO4ZHhbcFoyOkbqo5debnfi6inbcKdM0OZD7rMdN7oOyyg2tpfVg8KLdctk9uOus6G
         v3CVFeT2ugha2NveZLbP0zqzTn4C3uy9M+tBJQeRixb4tjx5B4SSED+X/Xvngwe4xHmB
         2Me+ackEPkLXo4TGtlFW5jaz7uK3g/3PKB6AjtdxyW65cQQOSgQTwoVHse5u2a9fy079
         SV04+e1OysntrpjKWN0ypEYG8p0HlFRMAAPado5HfDv+HxhnMTCKSVpfmUrQxTB4x7my
         lIzw==
X-Forwarded-Encrypted: i=1; AJvYcCUGuCuM4ZKWH/ngqN0c265a4sV3LsugGt8C/DyV4Ci0BFSoG4X9E4jTeJN7PO6nPlPc/tbqrSwcN5ng@vger.kernel.org, AJvYcCXBVePs8Utis+KZavZ6Aaaq3fNA61lywDKnASd2vvMZi6ZoE9xE5YaUDGrfzV+q3zSPacjVU+tmRe4Fl9qN@vger.kernel.org
X-Gm-Message-State: AOJu0YwMub+RVLaT+XV9dlkpbpPeRhhSSjQvbvj6zLpziGxAo3xo7nwD
	ZJuOtU4pEXdzc+MLhrBlnbb4HuQGpHip8iXujKrMZSu4MlJxiM30K19SHB+/
X-Google-Smtp-Source: AGHT+IGj1ICWG+enL/mz+nRHk/RtiB2DmVTTu6rkphqnle4KBHonuvB3QqFfG5gzDuZ4/b49o0GKyg==
X-Received: by 2002:a05:6a00:3c91:b0:720:75c2:7a92 with SMTP id d2e1a72fcca58-720c98d32b7mr5329009b3a.15.1730473772025;
        Fri, 01 Nov 2024 08:09:32 -0700 (PDT)
Received: from [192.168.0.122] ([59.188.211.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2c38c7sm2745972b3a.125.2024.11.01.08.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2024 08:09:31 -0700 (PDT)
Message-ID: <b0e81bfe-f7d3-475c-95af-7824d60deed9@gmail.com>
Date: Fri, 1 Nov 2024 23:09:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH asahi-soc/dt 04/10] arm64: dts: apple: t7000: Add PMGR
 node
To: Rob Herring <robh@kernel.org>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241029010526.42052-1-towinchenmi@gmail.com>
 <20241029010526.42052-5-towinchenmi@gmail.com>
 <CAL_JsqLv2DJOsL=3bxf229ZdArL1TqArw+9cLtmjYMkm5yfZ7Q@mail.gmail.com>
Content-Language: en-MW
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <CAL_JsqLv2DJOsL=3bxf229ZdArL1TqArw+9cLtmjYMkm5yfZ7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/11/2024 21:04, Rob Herring wrote:
> On Mon, Oct 28, 2024 at 8:06 PM Nick Chan <towinchenmi@gmail.com> wrote:
>>
>> This adds the PMGR node and all known power state subnodes. Since there
>> are a large number of them, let's put them in a separate file to include.
>>
>> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
>> ---
>>  arch/arm64/boot/dts/apple/t7000-6.dtsi        |   4 +
>>  arch/arm64/boot/dts/apple/t7000-handheld.dtsi |   4 +
>>  arch/arm64/boot/dts/apple/t7000-j42d.dts      |   1 +
>>  arch/arm64/boot/dts/apple/t7000-mini4.dtsi    |   4 +
>>  arch/arm64/boot/dts/apple/t7000-n102.dts      |   4 +
>>  arch/arm64/boot/dts/apple/t7000-pmgr.dtsi     | 641 ++++++++++++++++++
>>  arch/arm64/boot/dts/apple/t7000.dtsi          |  14 +
>>  7 files changed, 672 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/apple/t7000-pmgr.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/apple/t7000-6.dtsi b/arch/arm64/boot/dts/apple/t7000-6.dtsi
>> index f60ea4a4a387..77d74d6af1c4 100644
>> --- a/arch/arm64/boot/dts/apple/t7000-6.dtsi
>> +++ b/arch/arm64/boot/dts/apple/t7000-6.dtsi
>> @@ -48,3 +48,7 @@ switch-mute {
>>                 };
>>         };
>>  };
>> +
>> +&framebuffer0 {
>> +       power-domains = <&ps_disp0 &ps_mipi_dsi>;
>> +};
>> diff --git a/arch/arm64/boot/dts/apple/t7000-handheld.dtsi b/arch/arm64/boot/dts/apple/t7000-handheld.dtsi
>> index 8984c9ec6cc8..566346be5b53 100644
>> --- a/arch/arm64/boot/dts/apple/t7000-handheld.dtsi
>> +++ b/arch/arm64/boot/dts/apple/t7000-handheld.dtsi
>> @@ -10,6 +10,10 @@
>>   */
>>
>>  / {
>> +       aliases {
>> +               framebuffer0 = &framebuffer0;
> 
> Looks like an unrelated change. Also, not a standard alias name. So please drop.
Alright, (for other SoCs as well) the next version will not have any
"framebuffer0"
aliases additions.

> 
> Rob

Nick Chan

