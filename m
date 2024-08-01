Return-Path: <linux-kernel+bounces-270623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD82944242
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 06:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5611C21EBC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 04:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7426F13D89A;
	Thu,  1 Aug 2024 04:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIvZjXaW"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCAA1386B3
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 04:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722487312; cv=none; b=eijzJ40ysgsrDzWvVUZrc6J1gxjnaGatpC2RdJjFEyNIm4Wxc0io8lOyqoXkArzFRKobNSSE55570p2nWdrwkJeZ5CJjh5HvBCXIYPQlKPveId9Bqfps+QtxHGE9D+W0teeRClgKrvuU41aAqJG548WRK0oGKXOMihZoc5ADVVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722487312; c=relaxed/simple;
	bh=sfZQ1ozZhmA8NPgCes7c/cHK2rpdRwyE/IjXpfYTMrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MLpmabgpUHYSI0Nj46RV77mEgh/D1s+qE/pMYeVAvrX11TL5dt8u5oLOaW6NSs/Y07tHYi6lX83tBdgatG9z94cKJlAR4flA7ULGqGaJT0c8I0MD1BI1kMt4RD5bsLvJFSAHvlJ7p1Uue4eSm53CJ9UnCzGiQwal+KGlQTUY1pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIvZjXaW; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-395e9f2ebc0so36767655ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 21:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722487310; x=1723092110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TrS7ZmWwF7HPF34u2t9hLe1InvTL4w8sJTnePBAV3mg=;
        b=FIvZjXaWFpqiaX/NmrL4pcC3AAZJOevyCf5Y1APOwLFSC9JSieGQ7XEE4Y4mnKqbWd
         71PBd0/EOqrTCHHDJGFzNlvqKMiT52zNH3mmSwdgXuf66e1oRB4yDnSo7BE5Go5GcGjW
         XYx70wAuQfln9kiR72FSi41v6XiUbesDlvacqnCp59myAvPbiYSjlSqezZRKDmIMZQzV
         D4BMZ2ZhFHiGJq6PgBzkuR3Cwz4Ablq+VCb9BCyyFCQc/PaOxdGFAR3PLE6YbMmhXqbG
         PxnaMxviNI0iI0GgzLFmLpQASE0KlNBk50W8irYvANmN41A7JWiw9CFQbbK2SRMivd9C
         b1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722487310; x=1723092110;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TrS7ZmWwF7HPF34u2t9hLe1InvTL4w8sJTnePBAV3mg=;
        b=vPSZB6yjJrzj/LIGVKRooPYX4AK5H03ZnBtCP02ca6CqlwKEB6/7BxyhAjfAgkgsyS
         kNRbB/35xvZ8etcYyCgcJpInN2ZsQ19cRsKf4CoMLZu9t7gbt/U3eufsLaEOX0tZYHXK
         ws3SXjXISd+1qpaPM3vIwNiUP7J4KNI1g07hBxQCeEGG0OYAPSW46u5vCQKpvqbo7pK5
         +zkKYJufWYTw2l43QwMWF7svB6n7j7dyEQ3MrEEmDEopD4wjYpzcWQk/vP8Mg3AYNPNg
         U7aQsIOhMk1qZQaoMZiwoSQVh6YJaOBGAK8pOFBbArhx3Xb+XDjbPUR7DDLJ8ef2Wdqx
         5oQw==
X-Forwarded-Encrypted: i=1; AJvYcCUMbfJ0J5HzPe07+ryxtVHcAZD+7NxBC+of5hJJKevmrHqhm2IlkwkYJ+rFzRK6+cfpE39O3xUGZLFaaDTev9QF+YjKJVuERRrhRE5P
X-Gm-Message-State: AOJu0Yyf+mxaSQaCVYR1yc8+/d2gB65O0LwLq/ciVyS/0rdXU2xPuKod
	n3GiZjkG0jnPWYqsz8tPCV1hIxNYxER5suaDSWc+ZviFbgLrsJ6F
X-Google-Smtp-Source: AGHT+IHOO+qv2QQwi+jWLgh6b+xMILAAavu2vX5eMe2CcHpvUKecTXPxU7Ozo6PD4cg1UgEckJCnJQ==
X-Received: by 2002:a05:6e02:1586:b0:398:b5b8:a683 with SMTP id e9e14a558f8ab-39b18362baemr18700575ab.9.1722487310120;
        Wed, 31 Jul 2024 21:41:50 -0700 (PDT)
Received: from [10.3.80.76] ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f817aebasm11378845a12.28.2024.07.31.21.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 21:41:49 -0700 (PDT)
Message-ID: <96048585-28e4-4bdd-b73c-1e2d6f806f91@gmail.com>
Date: Thu, 1 Aug 2024 10:11:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/mipi-dsi: add more multi functions for better
 error handling
To: Doug Anderson <dianders@chromium.org>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, neil.armstrong@linaro.org, quic_jesszhan@quicinc.com,
 airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240730060659.455953-1-tejasvipin76@gmail.com>
 <20240730060659.455953-2-tejasvipin76@gmail.com>
 <CAD=FV=XGzQN0LK6SBOY_6P8eF-cAuP4hRwsS+NTZEaik_Os7NA@mail.gmail.com>
Content-Language: en-US
From: Tejas Vipin <tejasvipin76@gmail.com>
In-Reply-To: <CAD=FV=XGzQN0LK6SBOY_6P8eF-cAuP4hRwsS+NTZEaik_Os7NA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/1/24 2:59 AM, Doug Anderson wrote:
> Hi,
> 
> On Mon, Jul 29, 2024 at 11:07 PM Tejas Vipin <tejasvipin76@gmail.com> wrote:
>> +/**
>> + * mipi_dsi_dcs_get_display_brightness_multi() - gets the current brightness value
>> + *    of the display
>> + * @ctx: Context for multiple DSI transactions
>> + * @brightness: brightness value
>> + *
>> + * Like mipi_dsi_dcs_get_display_brightness() but deals with errors in a way that
>> + * makes it convenient to make several calls in a row.
>> + */
>> +void mipi_dsi_dcs_get_display_brightness_multi(struct mipi_dsi_multi_context *ctx,
>> +                                              u16 *brightness)
>> +{
>> +       struct mipi_dsi_device *dsi = ctx->dsi;
>> +       struct device *dev = &dsi->dev;
>> +       int ret;
>> +
>> +       if (ctx->accum_err)
>> +               return;
>> +
>> +       ret = mipi_dsi_dcs_get_display_brightness(dsi, brightness);
>> +       if (ret < 0) {
>> +               ctx->accum_err = ret;
>> +               dev_err(dev, "Failed to get display brightness: %d\n",
>> +                       ctx->accum_err);
>> +       }
>> +}
>> +EXPORT_SYMBOL(mipi_dsi_dcs_get_display_brightness_multi);
> 
> I'd be interested in others' opinions, but this function strikes me as
> one that *shouldn't* be converted to _multi.
>

Only reason I converted the function at all was really for uniformity's
sake. But I don't think that's valid anymore seeing how there's already
other mipi_dsi funtions that I'm not converting and this function
probably wouldn't show up in the context of the other multi
functions.

> Specifically the whole point of the _multi abstraction is that you can
> fire off a whole pile of initialization commands without needing to
> check for errors constantly. You can check for errors once at the end
> of a sequence of commands and you can be sure that an error message
> was printed for the command that failed and that all of the future
> commands didn't do anything.
> 
> I have a hard time believing that _get_ brightness would be part of
> this pile of initialization commands. ...and looking at how you use it
> in the next patch I can see that, indeed, it's a bit awkward using the
> _multi variant in the case you're using it.
> 
> The one advantage of the _multi functions is that they are also
> "chatty" and we don't need to print the error everywhere. However, it
> seems like we could just make the existing function print an error
> message but still return the error directly. If this automatic
> printing an error message is a problem for someone then I guess maybe
> we've already reached the "tomorrow" [1] and need to figure out if we
> need to keep two variants of the function around instead of marking
> one as deprecated.
>

One thing that struck me as odd was that the callers of
mipi_dsi_dcs_get_display_brightness never bothered to print errors at
all? If we want to print errors for non-multi functions, then I think it
would be best to just modify the existing function. And in the case that
someone doesn't want those errors showing up, I agree with what Maxime
said [2] and let users handle it.

> NOTE: If we don't convert this then the "set" function will still be
> _multi but the "get" one won't be. I think that's fine since the "set"
> function could plausibly be in a big sequence of commands but the
> "get" function not so much...
> 
> [1] https://lore.kernel.org/r/CAD=FV=WbXdnM4or3Ae+nYoQW1Sce0jP6FWtCHShsALuEFNhiww@mail.gmail.com

[2] https://lore.kernel.org/all/20240726-cerise-civet-of-reverence-ebeb9d@houat/
-- 
Tejas Vipin

