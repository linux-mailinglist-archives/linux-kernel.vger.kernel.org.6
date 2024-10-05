Return-Path: <linux-kernel+bounces-351684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 792929914B3
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 07:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FA432827B5
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 05:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB9A40BE5;
	Sat,  5 Oct 2024 05:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjG0ntrA"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5A535280
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 05:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728107666; cv=none; b=HT6M2WEtytHKWFhzh1+u9qwnjDt6IvEYhkv+5o6JwMptF0R4At5Th9uFka/93ovgIqUe1E3zq8zMdly/nXs6I1K/dzfSxv9KsE5m0VIT0ypmpM8w5in4bugZ8vWd13GhD8RKYz9j9AJ4CNUszHOYQKJDVqKzmJJmDvdpzDxIhoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728107666; c=relaxed/simple;
	bh=8QAPfeHOQ0u0gPSnuOLtXEadGW+UdLUso0W0ZLetrac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AqNA0oEVQk90YO0M5Fi1Uq4Y9/3LUEZCyLo6Ha75EzHwdHVHFkSLi1fnXqw3oh8c3wnheyN4wt5UfdOfrAwtJ+xx+vrS9yWF6XTomc4nvMcrNoUUIFPd4XIq5IDqxmyqEf5zperLWTBF2+fZB5NY0JWPUigJIwLft5GqcZjdD+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjG0ntrA; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c42e7adbddso3299313a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 22:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728107663; x=1728712463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nqhjtJL2VH9Qi85YDoBXvJqfb6N4tZMSUhtI6I9yzkc=;
        b=SjG0ntrARW4G/PXzygFfVV24bb7TzVWsFqaqityVCUXBEZutUBKPZvQdGOiYC0Pmic
         ap4RIYqjbUn6fbvzxVI53BHgbw9c+XRsAX4oljVxf5VFPJw7z6tGRAXsphDpYkmrEv1P
         FPJGIPoLyGXy1sNrqVgImSOfFF9w6C0QMWdneJchub3nopgSccKfxIk/tAeyj03ARbvr
         ykRVMTjQZxSX+ASXEX8DQDebGvUxrp9fhsu900XWJNWsTHSKXBI/Qx+ottn1rdy3pdJm
         MYPjRQD5mtSwdspm1m7ke09A6oBzjH5FaIY5IiPVl5kOsZqe2e+Om7h+JX+bFNnQlz8z
         XvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728107663; x=1728712463;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nqhjtJL2VH9Qi85YDoBXvJqfb6N4tZMSUhtI6I9yzkc=;
        b=jFHV2qxSAY6dgzc2BaSt5z1v44rpmxeDJ72VOZzNzzGS+fIOlXdtwvDZ1kLo2ZdOKw
         Ln0Lb+dqTTHit7DDnJsvEKunn3tJR1pS2Nt17tzlP51Uhk6n6jS4YYOanljXvZ8MqNI1
         duNWdrdkOxce/ZR1D9MW0/Mr//hsRSNnstY+6Er1IWHGhByEwo/t7p1FuZtLYkarqqv8
         p2zBZMJWgFiCQMBA8BSI8UGf1MADs0a9whT+7GbO0tF0AFrLo3Oz3Ps87Kj/nxRlJs5f
         O2r+uGgf9+dGRRLWtHL97PCghGjgXbCedqsasYiRa+WD6EU9+HHbS2M2paecFgVQZkpZ
         sixA==
X-Forwarded-Encrypted: i=1; AJvYcCVcoOza1LmUi2zDl+VXb8lzzLxQRYuMZ4jeanYQgQpdc1FQ8xxl/srmD5tDY686iX4SCk5BujSN+K78OBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBd/chkeDvheRMgXPVhAVu0DPiVGbzV/SjOTUOsDwETiGcMt6T
	XsK1cyqnaG9e4DrFYcc899YndH/CNOvpJFAmFGqyymuEchjcp46k
X-Google-Smtp-Source: AGHT+IHsJ8wr3XwH1w8eyfs5MO/C+1coYSi6NdpkwFhI5qIBKYCJ789h1+Y8C3OE5KMxygJ3vog3PA==
X-Received: by 2002:a05:6402:354e:b0:5c8:7a0b:2848 with SMTP id 4fb4d7f45d1cf-5c8d2ee1d08mr3790977a12.36.1728107663248;
        Fri, 04 Oct 2024 22:54:23 -0700 (PDT)
Received: from [10.50.4.74] ([95.183.227.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05acccbsm655755a12.32.2024.10.04.22.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 22:54:22 -0700 (PDT)
Message-ID: <885f3994-49a9-4aff-bbea-11e8a4383719@gmail.com>
Date: Sat, 5 Oct 2024 08:54:17 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/14] drm/mediatek: Support DRM plane alpha in OVL
To: =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
 =?UTF-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
 "djkurtz@chromium.org" <djkurtz@chromium.org>,
 =?UTF-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
 =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
 "daniel@ffwll.ch" <daniel@ffwll.ch>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "me@adamthiede.com" <me@adamthiede.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "littlecvr@chromium.org" <littlecvr@chromium.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: =?UTF-8?B?WVQgU2hlbiAo5rKI5bKz6ZyGKQ==?= <Yt.Shen@mediatek.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240620-igt-v3-0-a9d62d2e2c7e@mediatek.com>
 <20240620-igt-v3-13-a9d62d2e2c7e@mediatek.com>
 <1a3af354-bd15-4219-960e-089b6a6e673c@adamthiede.com>
 <49df03e8b982cc5ee97e09ef9545c1d138c32178.camel@mediatek.com>
 <00ebe9ca262b6a95fd726e5be06334b1e923db02.camel@mediatek.com>
 <5975b361-c1b4-4c57-89d4-0d247ae99d8c@adamthiede.com>
 <272b47f0c9e27268d29b58c341e0b48bce7e8e25.camel@mediatek.com>
 <06ed4527-3749-4fac-bd38-d837f1593311@adamthiede.com>
 <f7b4c6601d648e0eba2dc66f0fe1f34ca3d29cfb.camel@mediatek.com>
Content-Language: en-US
From: Yassine Oudjana <yassine.oudjana@gmail.com>
In-Reply-To: <f7b4c6601d648e0eba2dc66f0fe1f34ca3d29cfb.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 03/10/2024 8:17 am, Jason-JH Lin (林睿祥) wrote:
>> Jason:
>> That is a lot of information, and quite above my head! Thank you
>> though.
>>
>> I should note that the log items I sent you are from the "good"
>> kernel -
>> 6.11 with the commit reverted. Here is a much longer set of logs:
>> https://termbin.com/co6v
>>
>> I've rebuild 6.11 with the log statement enabled and the "bad"
>> behavior.
>> Here is a dmesg from that: https://termbin.com/xiev
>>
> Hi Adam,
> 
> I think something wrong with your dmesg links, both logs look the same.
> We should see this log in the "bad" one:
> fmt:0x34325258, has_alpha:0x0, alpha:0xffff, con:0x2000
> 
> But anyway, I think the reason for the downgrade is clear enough to me.
> So let's try to figure out the solution.
> 
>> These logs are both from `dmesg`.
>>
>> I'm fairly certain I've built with the patch you referenced enabled.
>> The
>> kernels I run are just release kernels, not RCs or git branches or
>> anything. The mainline v6.11 kernel is the one that has this problem.
>> If
>> that patch has been merged into 6.11 (which, looks like it has) then
>> it's in the kernel I'm building.
> 
> Got it.
> Then OVL_CONST_BLEND might be the unsupported configuration in MT8173,
> I think we should remove the XRGB8888 format for MT8173.

I've carried patches that add MT6735 support in my tree for a while and 
MT6735 broke as well with this patch. Turns out MT6735's OVL doesn't 
have the CONST_BLEND bit. It's highly likely MT8173 also doesn't since 
MT8173's DISPSYS is very similar to MT6735's.

> 
> Could you please try this modification and see if it'll change to use
> others supported format to show the text?
> 
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -102,12 +102,9 @@ static inline bool is_10bit_rgb(u32 fmt)
>   }
> 
>   static const u32 mt8173_formats[] = {
> -       DRM_FORMAT_XRGB8888,
>          DRM_FORMAT_ARGB8888,
> -       DRM_FORMAT_BGRX8888,
>          DRM_FORMAT_BGRA8888,
>          DRM_FORMAT_ABGR8888,
> -       DRM_FORMAT_XBGR8888,
>          DRM_FORMAT_RGB888,
>          DRM_FORMAT_BGR888,
>          DRM_FORMAT_RGB565,
> 
> 
> Regards,
> Jason-JH.Lin
> 
>>
>> - Adam Thiede

