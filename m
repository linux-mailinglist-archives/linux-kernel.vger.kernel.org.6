Return-Path: <linux-kernel+bounces-219522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCC190D3BB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD3E6284136
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0B51534E7;
	Tue, 18 Jun 2024 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6cLW8tn"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CC314F9DC
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719144; cv=none; b=irgb4evX2PEHUqSFaMEvCgYPpRkAmU0bWpfbNeUp/IePnvKw211e+cGdtM50/IRtPXnzteJJZsoiv9/Y+XsJLpe/6CNa42FOtqibEfJmo9dkXE3acT1ssTotkyDukoraX52S6kfdPInxpYkGH2uIKAcaefsrVGzLqI/O9tMQ4zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719144; c=relaxed/simple;
	bh=3Cc3/POGAkxTMFKNCvirXXg1K5WSLp77TWHFdRz5IXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FsTuJFLYkauVlV/ILbpyxuaRssudMcKdOhlsWc8LnLJv5a1KvsWuK6/I2IS82yNXpvlyLe+GebxEQr3IBj3DhKWs5oQhV1SoY8BGwZvlNweMgT+P9YZWvpTRjjQEK+U9rDKy9d3AS7vXxyIkHvy0GUfVv3rTJNQ3kP+Hy7Oyzj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6cLW8tn; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-705fff50de2so1479678b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 06:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718719143; x=1719323943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sik2h3nsDyel21Jp17t3SHjC9uUWJPp0CKLjhaHrkIk=;
        b=O6cLW8tn0Cb8Y78jaJTX2hvyTiOyrnAKVJZwSKy9fA43Xae6cDUXvGrtg3pX7cOaR8
         cZw3/sAWaMFZ98rhCiUpzq13ccvix3EvlVhV9dW5/4kbNd7Dro8v2dkdiBdki1J9zwdn
         BPYtWLJA6IpToUQ0UaSJ3k/lnai5dfL008XopgwS26BWzAW4symQ9BU6vB9lyw4gwpQQ
         m23Yx+r7thmwBWMk8uNpuKVoJKyWf8jmU4+nRcSmR4JPG1PhhkpJHXTd8ZA9CTqSMz+H
         yU4cSGzsA+I+cqYwNx9QP6FbRY1Ifd65UVlrAqND3asn2iMfPKDd/iKdbgnQLS3tldSX
         kqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719143; x=1719323943;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sik2h3nsDyel21Jp17t3SHjC9uUWJPp0CKLjhaHrkIk=;
        b=i6fGh/gRMPIyO4PFPm0xF+zldp9Bf2LGG89CveTlhM9tudhoOMyYsTNgrvyUVYjTQK
         YIue8ybq8kMY6PLhefvzzYQJXX3KunQMaE+olavCZLCyVsBBFUsid8yUVlfrC78MitOG
         6kkNqcg1kMcKPlEXpManWAfS6qPtUzBgpTcByIPn5g3ziA70jIxykMSUkS1/7NG7lngx
         1XcJZs4uaMrF5DMLL0uLdFT94Dl7YpnNqGg06rzgOd4/CDWQ8BaMM+r+o+59M0aHFfLy
         9hEohu2L0k1mHYA3WjIFj1c6Chw4gHWq+TkzOdjpNgheHO5esWz8YpMwe1B+0PVHXOOd
         Y7HA==
X-Forwarded-Encrypted: i=1; AJvYcCUCDo3zCMHIdInm2z5epH93juQQlJDPk+lY6QfI7f+7XS9OvYH6mzPNFdykFu6c2UL6vu53diHs0lp8VF83iXCdefbZczgy8/xPBgdR
X-Gm-Message-State: AOJu0YxBsPk/r4YzQvx+uSkeuJW/zDE9G+pWd4FOtTd22XFmwoC6zcY6
	Gw4/Iw1T9Mkd9uF7aFkfffl/24OsEAL3WJA+J2VLaRJNwlQKtvz5
X-Google-Smtp-Source: AGHT+IEiinzFmHmdnmLYP4XsvIyrnVEQNRoyQtf+OGBitODon2aa67vxDN6ukc/624yPUW4OT8SVdw==
X-Received: by 2002:a05:6a00:228b:b0:706:1f67:64d3 with SMTP id d2e1a72fcca58-7061f6768c9mr2805782b3a.14.1718719142770;
        Tue, 18 Jun 2024 06:59:02 -0700 (PDT)
Received: from [10.0.0.19] ([122.172.85.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb8dd68sm8947876b3a.206.2024.06.18.06.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 06:59:02 -0700 (PDT)
Message-ID: <55d951fc-d5c4-4bd1-9629-352d1e7489f4@gmail.com>
Date: Tue, 18 Jun 2024 19:28:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panel: raydium-rm692e5: transition to mipi_dsi
 wrapped functions
To: Doug Anderson <dianders@chromium.org>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240615093758.65431-1-tejasvipin76@gmail.com>
 <CAD=FV=XRZKL_ppjUKDK61fQkWhHiQCJLfmVBS7wSo4sUux2g8Q@mail.gmail.com>
 <aa757abb-9883-4a46-a5e1-a7d4d5b044eb@gmail.com>
 <CAD=FV=XX-_YA6ZjiwfqttL5y4i+QRLJn=BQUM2ugSa8HNkEUtg@mail.gmail.com>
Content-Language: en-US
From: Tejas Vipin <tejasvipin76@gmail.com>
In-Reply-To: <CAD=FV=XX-_YA6ZjiwfqttL5y4i+QRLJn=BQUM2ugSa8HNkEUtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/18/24 7:06 PM, Doug Anderson wrote:
> Hi,
> 
> On Tue, Jun 18, 2024 at 5:25 AM Tejas Vipin <tejasvipin76@gmail.com> wrote:
>>
>>>>         rm692e5_reset(ctx);
>>>>
>>>> -       ret = rm692e5_on(ctx);
>>>> -       if (ret < 0) {
>>>> -               dev_err(dev, "Failed to initialize panel: %d\n", ret);
>>>> +       dsi_ctx.accum_err = rm692e5_on(ctx);
>>>> +       if (dsi_ctx.accum_err) {
>>>> +               dev_err(dev, "Failed to initialize panel: %d\n", dsi_ctx.accum_err);
>>>
>>> I'd probably change rm692e5_on() to take the "dsi_ctx" as a parameter
>>> and then you don't need to declare a new one there.
>>>
>>> ...also, you don't need to add an error message since rm692e5_on()
>>> will have already printed one (since the "multi" style functions
>>> always print error messages for you).
>>
>> I'm guessing that the change about regulator_bulk_enable and
>> rm692e5 should also be applied to all the other panels where
>> similar behavior occurs?
> 
> Yeah, I'd say so.
> 
> 
>>>>                 gpiod_set_value_cansleep(ctx->reset_gpio, 1);
>>>>                 regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
>>>> -               return ret;
>>>> +               return dsi_ctx.accum_err;
>>>
>>> Not new for your patch, but it seems odd that we don't do this error
>>> handling (re-assert reset and disable the regulator) for errors later
>>> in the function. Shouldn't it do that? It feels like the error
>>> handling should be in an "err" label and we should end up doing that
>>> any time we return an error code... What do you think?
>>
>> Personally I don't think this is necessary because imo labels
>> only get useful when there's a couple of them and/or they're
>> jumped to multiple times. I don't think either would happen in
>> this particular function. But I guess if you have some convention
>> in mind, then it could be done?
> 
> I think mostly my suggestion was just that we should also do the
> gpiod_set_value_cansleep() and regulator_bulk_disable() at the end of
> rm692e5_prepare() if `dsi_ctx.accum_err` is non-zero. Then you've got
> two places doing the same thing: here and at the end of the function.
> 
> ...oh, but everything below here is already a no-op if the error is
> set. ...so I guess looking at it closer, my suggestion wouldn't be a
> "goto" but would instead be to just move the gpio/regulator call to
> the end. What do you think?

Yeah, sounds good. I'll be doing that.

> 
> -Doug

