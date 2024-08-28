Return-Path: <linux-kernel+bounces-305748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9309633C4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 23:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 516681C23C04
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A881AC8B5;
	Wed, 28 Aug 2024 21:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITVES9gb"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375A51A7074;
	Wed, 28 Aug 2024 21:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724880217; cv=none; b=mq3y+M62x8fU3cHaczz936rTOzLuuE0jFLalPkOM03wUKicalUfeipFA6Byvbtr5cov72dyCQ4SrS3jjyD8i/B1l30Lc33W7aP4oxyyZRP0k7dkS32F5tDJKhNdS+7/VndOjrXFk2vwTmcIJM0Pb+FVLWSvxoaWi4u9hQKXZWTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724880217; c=relaxed/simple;
	bh=08lMpUQJLl04+6uWNHhq9cLzIO4t/tS+ruExJGnS/j0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fPhcibxOSGBrs0QiTK/d4kM5ixUBpg45BcwvwkcCB5L7wxU2RtbBfZFX6+56pM75KqE3l0S3Iriv2nQviP3k6+uL8+lOM/2noOPweM3ffYYta4yT4VwtqsAwSxgEBmA6QiVAQzpGgLIunORQMfktb807bxWo1TiJrICiaGnmWiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITVES9gb; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2050b059357so2956775ad.2;
        Wed, 28 Aug 2024 14:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724880215; x=1725485015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hBMN1zMtydd9sGAxGScKs94sb1e1rvCLubo3KJTROMc=;
        b=ITVES9gbnCqBb4ohK4QCOTQczDn35ChWEW26ikoLd2tDIkW5IhFiX66w/D8Vw7dWm6
         vxzQ9mWzw1lkfaqWRf1VVFGGHfIpXXwYUCaIOsWjyLjGZlhDw/FLqPtE+B0rUsCI43lQ
         WRmPRPf7in4vuYeEk41GHFIXrf6+fo+JV5czGURESWgqMs3SU9GnT5ZGCUkAuVYKFACE
         ng2/FC0lH5/PUONRc5Lt3YUSd33rFadc5elXB98OWaMHM7JEH3anWNeOcfUyrqqFpRlA
         7HlNLzLB75jixz8e5uSwyiOMGF94F29c/zyKCz0nMkN8ecQjTXj8pAlUTE/fUAYQHv3v
         b5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724880215; x=1725485015;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hBMN1zMtydd9sGAxGScKs94sb1e1rvCLubo3KJTROMc=;
        b=Fms0j2M2R1zvfS2WOVEDnVNSQtKWirjDMT0awrp8iVkiZe1qIAv4EBUVBuorZEXShH
         trF1Wre+NYtQUnWyS7T3v+skKpp8GgENtvfX6iR1r1Bpl8FihPpj8bWAIvS7Hi4BbHEq
         MJze88kbywuXybnxU64z+NP1tkIgSj/9qFjoiMAD/KgWWWKbufjzx0gOJhqxVn3PjOhk
         6G6rZGYWpRu1TG/WVLn+l6ME0YUgTFizZaCQgokQ+8g0K4IuQUK+4ifzhlSTrVwn6lBT
         viNk9Aqo++PUV+3Mi9jXeOr9vu0R65XAfckmTMqZuQTpCelFiFM1RByvWyNruabwfGbv
         UT8A==
X-Forwarded-Encrypted: i=1; AJvYcCU31yetSmqNcSw3sAmm0LB+dr8HJIZSLXP/GX0nAvAf46HuykfBDinvBKK5CcmSAnyqv7mBo8D3aiE=@vger.kernel.org, AJvYcCVxngPKkMBOv8VONdY1CTIQO1F14ZIvDGavR6qIxc4hx6KLFa9e7KQxDAPMNgI7uSZ79Usvhwq97nyly6e2@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ+jjhsluRkUSKYnPNtxqQx9JJxJOS7Ghdzp2ffr1zSaHsTYEt
	lBlYkAf0x1QKd6UmmGLi+15G2CMkHCE4jNLSzBIhQwiULaYEuSUFVdXa55lL
X-Google-Smtp-Source: AGHT+IG9mVtuPXADPC6vXLDVbCynSJY9RUJDpsD4JhdJx3+qK4sKXBXzWx99/cBHuzI4p69hZk/flA==
X-Received: by 2002:a17:902:cf0a:b0:203:a0ea:5f93 with SMTP id d9443c01a7336-2050b4f09ffmr10718905ad.0.1724880215343;
        Wed, 28 Aug 2024 14:23:35 -0700 (PDT)
Received: from [0.0.0.0] (ec2-54-193-105-225.us-west-1.compute.amazonaws.com. [54.193.105.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557e7desm103108745ad.75.2024.08.28.14.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 14:23:34 -0700 (PDT)
Message-ID: <1b245182-09db-44a1-bdee-3ec0658bef47@gmail.com>
Date: Wed, 28 Aug 2024 14:23:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: analogbits: Fix incorrect calculation of vco rate
 delta
To: Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: samuel.holland@sifive.com, emil.renner.berthing@canonical.com,
 mturquette@baylibre.com, paul.walmsley@sifive.com
References: <20240827061954.351773-1-ganboing@gmail.com>
 <ad33e8561ca236c5f897003fb40bdc09.sboyd@kernel.org>
Content-Language: en-US
From: Bo Gan <ganboing@gmail.com>
In-Reply-To: <ad33e8561ca236c5f897003fb40bdc09.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/24 11:52, Stephen Boyd wrote:
> Quoting Bo Gan (2024-08-26 23:19:54)
>> In function `wrpll_configure_for_rate`, we try to determine the best PLL
>> configuration for a target rate. However, in the loop where we try values
>> of R, we should compare the derived `vco` with `target_vco_rate`. However,
>> we were in fact comparing it with `target_rate`, which is actually after
>> Q shift. This is incorrect, and sometimes can result in suboptimal clock
>> rates. This patch fixes it.
>>
>> Signed-off-by: Bo Gan <ganboing@gmail.com>
>> ---
> 
> Please add a Fixes tag.
> 
> Also, your patch has tons of diff context. Why?

Hi Stephen,

Thanks for the reply. I'll add the Fixes tag in v2. I explicitly enlarged the
diff to show more surrounding contexts for better readability. Any other issue
I should fix?

Bo

