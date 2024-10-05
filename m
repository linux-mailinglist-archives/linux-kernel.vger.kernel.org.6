Return-Path: <linux-kernel+bounces-351696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2A79914E6
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 08:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB331C21A2D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 06:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F3239FCE;
	Sat,  5 Oct 2024 06:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIOnwIyd"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB962F2A
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 06:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728109994; cv=none; b=ftBr19jTGX+1k+4pii0S54SC9L/ISpkXaW16ag/L9VyICs1baIpoLzHrhQ9THQTKAPTtYzhntaq3ONW7MW7RZA4ck+wiS0/Tg2G8kWOPbqQaB2P0TZ2e8UqTfkGhNmSJTr6yXOxuDWicX1yInFDWyK5QgDJ41EqgeEkvHwhH7yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728109994; c=relaxed/simple;
	bh=AFowHCPUN7+Q3TJvLPfEP6g/uBJhiZzPjA7BrcUgNSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uxCaqmVh3pBZI/La8ntaHIyNxEBhdwqDs2adMOHlD+J1lmGkdsN+fyDaM/6eQAoDciPI8U/G9SJAvqH+boZPSa6TRQu7fB67VQrmRazj9JAih4ceHQAyxM9Kupr0XlkDBgVa+64ra+5K1sZOVg0k7RvryyihZpjT5GK/dN3cKQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIOnwIyd; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8a7596b7dfso488142866b.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 23:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728109992; x=1728714792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x7vLbW0akK7YwOkc2P66r1P01ycwp/GvBI6sSzlZ6JE=;
        b=VIOnwIyd27QcRGzn2rdTbCPmNZOTb4Fnm6MorhQRRbpYzIIQH904dcbHD+S+1KyorX
         kXL7uZ58OcpxtYqq7wI/adc7de6ba+UUbuGK92rHMHYvKswx8HiGKaV6fgWTXH7BcIZb
         bD+E9G5nGkLPeB6wkGzXMKnUst8AhuBbA456K/r9a/vLwZdYkL+bcS4RUqkLrNLBWGn3
         1EXHoMazwgr0FBoelvGthn5rx1iZf1URwT8/JadT2CGUD+7tOiNe1LcuZEUbyzW2Fk8h
         qDihS9owND06fSINbBYS/x4QnS6ErOrbdOTFkJMz7t0ALFPhDlLMRjgRzVTzSTb4m8VD
         UujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728109992; x=1728714792;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x7vLbW0akK7YwOkc2P66r1P01ycwp/GvBI6sSzlZ6JE=;
        b=Ztmo59QDjOpFYrzkKXeNyW2Bk8REyukdt+JWSzCClPJtw/xBWDX1QnC3TIBFAJ5IwX
         JI8nhtefTExR66pnrMWVTNyaRnTvNsmCwvpjanEAWR7PDpZ7MWBQc+J5PTET80KH+prp
         MngKxFxK/uaK2D4boT3HgmbP4qPh9DY96bZ0faaiVCsnxThmGDbvqYnC5cckskVHjzyr
         K/PH92b8qcouyMsJy5A7EA8xrwZr0bjHuR8VEEnN2sIzi/eV3g7TgF9KyTLojXndQMDe
         1UzZetfu3fo62EmtweWeViNiZQVUYT03MV8ko//rY05o+Jnld1rlbpVZz5RguQ05hqxz
         23IQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlUgBCsGfqD+IdkHFx4RHde2fcr++IG+WGEj40FWtuLg00dRj+VADl2jrgpEowIPoINjiDQxw4X0wIzbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpM3FMaOLYymLjvo65DcbgB2iifJC97eYoV2heFe5xtqOCcseW
	9RPRGYkyKVFVeo03rxpfH7qjcyUz6g6FsAjWTgXqGHEEgXAP+X4r
X-Google-Smtp-Source: AGHT+IH0HMdNMIZNdd2tNWTbK109LRw4fSWdIqpNDF3pp7Isnqrwz4ZYVRbRjl5UYq7cqGlP3Qy/CA==
X-Received: by 2002:a17:907:3f9d:b0:a98:f6dc:6cf3 with SMTP id a640c23a62f3a-a990a21d55emr982162566b.21.1728109991523;
        Fri, 04 Oct 2024 23:33:11 -0700 (PDT)
Received: from [10.32.3.23] ([95.183.227.32])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e5bbc20sm92337066b.41.2024.10.04.23.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 23:33:10 -0700 (PDT)
Message-ID: <d820e8be-c525-4435-99a3-b0eb076b3282@gmail.com>
Date: Sat, 5 Oct 2024 09:33:06 +0300
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

This is what I get on MT6735:

[    1.729467] mediatek-drm mediatek-drm.1.auto: [drm] bpp/depth value 
of 32/24 not supported
[    1.737777] mediatek-drm mediatek-drm.1.auto: [drm] No compatible 
format found
[    1.745943] mediatek-drm mediatek-drm.1.auto: [drm] *ERROR* 
fbdev-dma: Failed to setup generic emulation (ret=-22)

> 
> Regards,
> Jason-JH.Lin
> 
>>
>> - Adam Thiede

