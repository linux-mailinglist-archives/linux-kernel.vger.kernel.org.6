Return-Path: <linux-kernel+bounces-270946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2664B944774
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D54F5283FF7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984CC163A9B;
	Thu,  1 Aug 2024 09:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaYZU4LN"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2230816F8E7
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 09:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722503229; cv=none; b=uIQqwDwfPsuEILKnIgQdicqDVZTtj94cJFAhYTHGC3OmCU3d0B+Gj5AcUhLYizy3IqBroG5e7yojmbrmZ3Jh2RuO/qFvNDUepnfvtvV4S+8AEvI0vFHgXbKpdPsnUQaRRScQy4HdLyOgcda8eyVoOfLGMOZF3Qzd4uYOkbFUqYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722503229; c=relaxed/simple;
	bh=gsmNLOnLvcLWoYh5o6wZwKpIn8YC7FQTYJ+NLENYeEo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JTnu/ow9RL8OxiCgE6nejpqQF7uRwMSkyGhH8t4/PxjcnNbRihSNAOjNsXyNPuSbB5mnx+DPYxhw6llWspuGcPu0RwMH7fwyR1UO1TEdgUGpPTl6TsOzUv7wHhj3Zlalwnv8vlo+GtvPmdqu5spuWQmcNNIwqZu4qgVQ2ehwaFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EaYZU4LN; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7a9a7af0d0so877575666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 02:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722503226; x=1723108026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0ZBoY3AoVccb/INlrM3z9gGvON8IToRFWiibOBUz5W8=;
        b=EaYZU4LNoOxHtHhMWpflpsMsSB+zvaMmrQl8VRrbyK9ivj8r9jpxhqKS6cbgTTmx8J
         G5sg9a5LhWZ9SaEB8y5h+EKwpo8XkGT9rPgxOnv8vThmIas+puXGVsiU+USm6h0boqOh
         wG6h4ETchDaSDXowyIGm616ASF84I9iUKawVtcLzXIpmsPsd2Q+MchOw0qSbSSbSX4qQ
         kcWotPS0YpdO9ZXGVu5XFAFyHbg7vflEay2FC1lHqK2Le5u23cgxg4u/GghNjUXgK3f6
         B4EGYYXI+Qab/hsz4U+PvGKgmwHU8OrgdzYfsyA1GKs8IomdiroLp8+9g3M/XpAEdDe5
         Arcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722503226; x=1723108026;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZBoY3AoVccb/INlrM3z9gGvON8IToRFWiibOBUz5W8=;
        b=U+Dd4Bjsh6ZIC4HIONYMBtm2x7bj0ujuDqzcol86xZ6UASfqLcNwQOMTVFSYxJ5PpF
         yukhNDxc4G/utKHLnlQDw95l83WASm7vccWCC6hXDvXnYQsu3D1ckWke56SvOI5Mrlcx
         BBzJ6Ioj01IjmwV9krQuiRWWUrHnLLuTI4NQI9/+ZwaNlttAP46NAvPv/i/pS4pv7D/N
         5jrEqPw5FNv+1DsNUTe8ngWz0DmJr8+hDamGaR+ThMozrFujMjL/uhA/XsjGAfvnd3+8
         jkIakslSza07Yw1pqglosi7XmIjBLpawuFKM9noPq4Xxeohz6KS5EZbFRqyxMzaAwl0h
         MJVA==
X-Forwarded-Encrypted: i=1; AJvYcCVJPgXd7F/RgdR2Y9AV5LwM5qnHNcqeNJ068si1Pik+8xNS0ZtPycWkROc1m84YuWIh98o/9qw2MO961QYbkYh7eO9/4EWGs7IRyqBX
X-Gm-Message-State: AOJu0Yx7eTLuG8odMJFEDV+lfeyBxYrZ1MPr9CwBLP1IWWSiWaJLzzuZ
	ttj8KOK8ZPBUtGgITvu2/AjN7t73aM9f1E9ewrUJP0qoFGWxGT/l
X-Google-Smtp-Source: AGHT+IFkXQXLFJ5X+Na5/W+NzBmIf8q3vSnukCimnlNwYhkXd1AhMX9KBCaqr0DDQZcpDbO7MU+hlA==
X-Received: by 2002:a17:907:2d91:b0:a7d:340e:43a4 with SMTP id a640c23a62f3a-a7daf55e504mr102922866b.31.1722503225659;
        Thu, 01 Aug 2024 02:07:05 -0700 (PDT)
Received: from ?IPV6:2a04:cec0:1113:4afb:5fa3:8d9c:6e3d:1966? ([2a04:cec0:1113:4afb:5fa3:8d9c:6e3d:1966])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab4de06sm868138666b.71.2024.08.01.02.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 02:07:05 -0700 (PDT)
Message-ID: <94ecd3a6-3a62-4be6-b384-c8237c818e98@gmail.com>
Date: Thu, 1 Aug 2024 11:07:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
Subject: Re: [Linux-stm32] [PATCH RESEND v3 0/3] Update STM DSI PHY driver
To: Yanjun Yang <yangyj.ee@gmail.com>,
 Philippe CORNU <philippe.cornu@foss.st.com>, yannick.fertre@foss.st.com
Cc: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240129104106.43141-1-raphael.gallais-pou@foss.st.com>
 <21f4d43d-4abd-4aca-7abb-7321bcfa0f1d@foss.st.com>
 <CAE8JAfy9NtBa--DnUt2AEZPFnvjU6idj8DqUbaeLaH0DMFvuhw@mail.gmail.com>
 <e059f157-ff9c-32cb-57a6-48f2331f2555@foss.st.com>
 <ZqeZEB9peRSQkOLZ@void.tail05c47.ts.net>
Content-Language: en-US, fr
In-Reply-To: <ZqeZEB9peRSQkOLZ@void.tail05c47.ts.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 29/07/2024 à 15:28, Yanjun Yang a écrit :
> On Fri, Jul 26, 2024 at 09:55:35AM +0200, Philippe CORNU wrote:
>>
>>
>> On 7/22/24 10:38, Yanjun Yang wrote:
>>>
>>> This patch (commit id:185f99b614427360) seems to break the dsi of
>>> stm32f469 chip.
>>> I'm not familiar with the drm and the clock framework, maybe it's
>>> because there is no
>>>    "ck_dsi_phy" defined for stm32f469.
>>> PS:  Sorry for receiving multiple copies of this email, I forgot to
>>> use plain text mode last time.
>>>
>>
>> Hi,
>> Thank you for letting us know that there was this error. We should have
>> detected this before merging, really sorry for the problems caused by this
>> patch. We will investigate the issue and get back to you as soon as
>> possible. In the meantime, I think you can revert this patch in your git
>> tree.
>>
>> Philippe :-)
>>
> 
> Hi,
Hi,

FYI
DSI clock tree for stm32f469 can be found here:
https://www.st.com/resource/en/reference_manual/rm0386-stm32f469xx-and-stm32f479xx-advanced-armbased-32bit-mcus-stmicroelectronics.pdf

Refer to Figure 17: DSI clock tree.

After some research I think "ck_dsi_phy" was introduced in stm32h7 
platforms. There is a mux which interfaces between various clocks (among 
ck_hse) and the byte lane clock. stm32f469 has a much simpler clock tree 
in which we did not bother to implement this "go-between" clock, even 
though they is an equivalent of the mux.

> After some testing, the reason behind my problem is the parent's name of
> 'clk_dsi_phy' for stm32f4 is 'clk-hse' other than 'ck_hse'.  I don't
> know which is the better why to fix it:
> 1. Change "ck_hse" to "clk-hse" in where "clk_dsi_phy" is defined.
Doing so will definitely break other platforms.

> 2. Use "pll_in_khz = clk_get_rate(dsi->pllref_clk) / 1000" instead of
>     "pll_in_khz = (unsigned int)(parent_rate / 1000)" when get the clock
>     rate.
dsi->pllref_clk refers to the HSE clock if you take a look in the 
device-tree. This is the reason why this work on your setup. I doubt 
nevertheless that it wouldn't work on other platforms. But this would be 
a semantic nonsense, since the DSI byte lane clock is not always derived 
from HSE clock on other platforms.

Looking again at the clk-stm32f4 driver and the DSI clock tree linked, 
we can maybe implement the desired clock even if it is not represented 
on the diagram.

Eventually if this solution does not work we will go to the second 
solution you suggested and we will test it on all platforms.

@Philippe, @Yannick
Do you agree with this workflow ?

Regards,
Raphaël


> 
> Both method can fix my problem. The first one might break other
> platforms. Maybe I should change the clock name of 'clk-hse'. However,
> I can't find the defination of this clock name for stm32f4.

