Return-Path: <linux-kernel+bounces-272139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9369457B7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 07:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2684CB23454
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 05:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CC23B796;
	Fri,  2 Aug 2024 05:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y51xctEV"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163D98F47
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 05:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722577422; cv=none; b=hccyK3HWeuAaw3+NqMhDM/Yq8zCenMJJ1G5vMF8HoXdgrNiGcphyFaoLAIGwm+M3WFieL0tX6zjyBrQAe7fOYeuK5WO0Uys8/BjIewapyqz8O19bp+R/jSoeEQ/qNAreJ68KOrB8Wyj8jJ4NGBO1MmPUU62OQdZ7fpOggfUI4mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722577422; c=relaxed/simple;
	bh=kwugU2UFUzr0D34pJ5kn/KtonwtPl3uwg8rExbn4g9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9PGY17N53Ys5FDSY4fKyXHZNm53LifwHy8cvKw/n0h8SF/JlhHGsXQjowJKT82DsMr4/YzfmbSP/xBGQH1hS0ygvYJTjlB2OVJNlYLkMyAstcAwIU9sj8ZYrfBqt2s/VWvL/OkJzexWcDOYWs73Ds0TGf41dHbkPxOlm8UiOz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y51xctEV; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7a23fbb372dso5077162a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 22:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722577420; x=1723182220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CV96Rrr15/ft2YFeifq6BUH0I2YfHmcQYyT9Zz0Haa4=;
        b=Y51xctEV+CYk7DAtn9ayiQt1vPUgT7Eq077vmsIBlfdCOZJSQvubp2OhRU3TfzKfBJ
         xzrR3l6M/d0UNPR4zZFbZPcyNIAKxUq/IPsoED04KgHIQdnt1Sp+M13dOg0qnbXyCRPl
         oZrRARf7zHV2vbGuwDkujeDYo5OXfz9ALBaFGUmP6tkS01whsInIUaxZMZxg06X+FbT5
         kHFCmZ6VS2t02BYutVHdKZc5KLdYmTRBTCtpamRn2OzlZvsZOVUZMA0W4/McczCRABzB
         NCfb9ESR851+yDaPw99RVTl8vDKPUX8mGRrtkSl2J5+JZLVJqEwaMWEFD/ObQx8TBPZK
         9huQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722577420; x=1723182220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CV96Rrr15/ft2YFeifq6BUH0I2YfHmcQYyT9Zz0Haa4=;
        b=AUWooXJGVLjWnmEanQH2obvHNfdqdEmp72dBpNGUZTBWGROvSk2V6rpEtxy5YxFofU
         xQup0HF54aLufTyexkCt+MnVQ8U1RRXRoNgsmXL99zLA4F0tL4feZSuRpbBDSlTtKBFO
         alefKeHWf04jWEcjnkvPWQ6gOwTrKqcdZmQGKe9WwRvzzgAw+I7QvvIA8NsXoTqkFi3D
         0OTRGW3r80A9FTgDXqiS6IUjT3pTlEv/jW/cpiLuQ8LdbAS6/KHRh+bSAtlrRbGOqBIh
         fVxIxLrWbVgGQtIA3+CY8DrKcFyDhzdPyNixRr1ZouKHuUFUF03W8aWoNwDhnWOLye1g
         42ig==
X-Forwarded-Encrypted: i=1; AJvYcCV/mC3TcQBb/WeG6SFhnsGxJPhWa2OFw18J/94irNgMD72gtS780JMx5LIP/s2k7Jx5ZVIgN+uTKeqUjHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDCVBULBLVo7T/y6vEu98xkqYI8ZrrlbtMFXsk8OcTXQHL9L+w
	Xskz+dvQ9qlhTbuqEDmUtgZ6GK73386/9bG/rE032+XaWSwtyyRLwx6be3m5FTs=
X-Google-Smtp-Source: AGHT+IG6sw+WJ2qv1fQRZamLam3tbLf5Nh0t8Ucj6Iomk9TBTmtrCG+gPTjyNvgL4gYFnWtiVNT/bg==
X-Received: by 2002:a05:6a21:2986:b0:1be:c3c1:7be8 with SMTP id adf61e73a8af0-1c699585b09mr3351145637.26.1722577420320;
        Thu, 01 Aug 2024 22:43:40 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec1c1d6sm694636b3a.6.2024.08.01.22.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 22:43:39 -0700 (PDT)
Date: Fri, 2 Aug 2024 11:13:36 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the cpufreq-arm tree
Message-ID: <20240802054336.xdhkubya44j5dcfa@vireshk-i7>
References: <20240802105726.6ce93aa8@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802105726.6ce93aa8@canb.auug.org.au>

On 02-08-24, 10:57, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the cpufreq-arm tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> In file included from include/linux/cpufreq.h:17,
>                  from drivers/cpufreq/spear-cpufreq.c:17:
> drivers/cpufreq/spear-cpufreq.c: In function 'spear_cpufreq_probe':
> include/linux/of.h:1435:51: error: lvalue required as unary '&' operand
>  1435 |                  of_prop_next_u32(_it.prop, NULL, &u)};                 \
>       |                                                   ^
> drivers/cpufreq/spear-cpufreq.c:201:9: note: in expansion of macro 'of_property_for_each_u32'
>   201 |         of_property_for_each_u32(np, "cpufreq_tbl", &val)
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/of.h:1437:62: error: lvalue required as unary '&' operand
>  1437 |              _it.item = of_prop_next_u32(_it.prop, _it.item, &u))
>       |                                                              ^
> drivers/cpufreq/spear-cpufreq.c:201:9: note: in expansion of macro 'of_property_for_each_u32'
>   201 |         of_property_for_each_u32(np, "cpufreq_tbl", &val)
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>   e960bbac0af4 ("cpufreq: spear: Use of_property_for_each_u32() instead of open coding")

Fixed as:

diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
index 4d28147c23f1..777f7f5b3671 100644
--- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -198,7 +198,7 @@ static int spear_cpufreq_probe(struct platform_device *pdev)
                goto out_put_node;
        }

-       of_property_for_each_u32(np, "cpufreq_tbl", &val)
+       of_property_for_each_u32(np, "cpufreq_tbl", val)
                freq_tbl[i].frequency = val;

        freq_tbl[cnt].frequency = CPUFREQ_TABLE_END;

-- 
viresh

