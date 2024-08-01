Return-Path: <linux-kernel+bounces-270649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EBB9442C9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 07:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6B651C219A1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 05:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C8D142E83;
	Thu,  1 Aug 2024 05:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnfabdVT"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230D613D8B0
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 05:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722491255; cv=none; b=m1mgKTHPkqzGbotUBi+/+jK1WS/YiaLTB3DLwruJFrclHjTrolTBny6WQTW+mK4z6+e7TM6HlHtXa9c/lrT5WNceLK3e32p9c8BKNhgXAVKxT6uL0oHZuifPCfWOyZGv8rvGaxijX22+zVpXshZfqbl5SGWVwksHExZVLACdTAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722491255; c=relaxed/simple;
	bh=f+S7BZPM6Xg5KqQJRqmHxX+Gqio3PKUNMvLwlIlibT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=rHD8tHrHtZAGhn+xgPHrwKrsVWdr4N1QQTEDN9vucttMvseYwUomsPQ5RLmjcigWx5GB8vKN9NV7A2hrwOrzTqc+bUndY0TkfmMmGIBWw4w5lHqsNybvcI5+ImFgFZNHJgBaO/+Ee11rvBxEJlMUgXnRzOD0smnYmRrGxMOoV2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnfabdVT; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a2c49d5af3so825161a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 22:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722491251; x=1723096051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h75mYsQwpcVx1+pn5BOg6IvXWO045QlfJAGrJrEcU6s=;
        b=PnfabdVTtn0mx9fY3pL5oQq0uAOX8x5f0XDmRMaF7/orvf/ca2zTemaD1S4WRcObZk
         xV2GPRPDPaQLYHv797MwbHXP4TMuDHs2OoueO98m5q5gK+ARU3SX3tNw2yXghsd71/c9
         axSNMjtKVK/olzxrD+uEuTHtmBUp0r/jmh6BqJ5ZlWgM0UFzOFS7fx/+FzfYUIGo/vwo
         rvAf+0ekKVPq9jl/Unyz06xiZCyznhj/ys6ZSy0PrpReqRl2o9O4t0vSFpuWJ8FSooXX
         1qsimq65uJZybiutKQzjgn1VQpyUB6oLr0zffbemTl+PkguE3OAM2tHBBdh4YURwE4Bn
         pOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722491251; x=1723096051;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h75mYsQwpcVx1+pn5BOg6IvXWO045QlfJAGrJrEcU6s=;
        b=LkuDykpKiSZnaZQ59sOwR5YxGZRYufpJlsnZabjxlR7n+L3kdyHD/wzWuwMilH2xmf
         6iWYWmfGlnlzXcyitfTfJl+lmeenl4R1fgADm1I8he7aCTNvgSkuWx+YxeXygrFoU4oA
         6UceTpURp52KWTs5F2HwWFZFRghX1nvCQbdRUVcy3nv2s3ek3V/cMiLRXuKrRRJd1gMB
         JNw+yqFJ4sMJThoSfsATnzzrLykf0JuGVV9C1TXSpU5aO28vfLFOmNeaWi4j0Y7lR6/w
         K9LaKWpbawSeWBJOgod3UgwCgxgdr1lkOZphwaWZtcLO52u6E08USt3cDvB+q130FgSO
         9jhA==
X-Forwarded-Encrypted: i=1; AJvYcCU9gvkwxULNWdb9kRut+Mp9D7LtNsgjNWsJXVjCEcn6vCy5COotYhx079QPOh+rIVh9BEgPH/KHONP/9TU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5CUwucAMb0idx07SNOyCPMfbW89geVTqFUBRFrX0n1Eot8RCy
	IgufcyICAXWfT2586abzkgtwHZNA9tg2FT2P/S5k61Ncbeu4xfkE
X-Google-Smtp-Source: AGHT+IE6BMB5xFdd7X7wDrr6BN2cvvXd8XkQ/dTe9DrabMQ0F3ei5nDMKUEGhkpF+mCfVfPZMiD6xw==
X-Received: by 2002:a50:96d2:0:b0:5a1:6ed5:19aa with SMTP id 4fb4d7f45d1cf-5b6fe72af2emr378687a12.1.1722491250984;
        Wed, 31 Jul 2024 22:47:30 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8500:57d2:826:6de3:1237? (p200300c78f2a850057d208266de31237.dip0.t-ipconnect.de. [2003:c7:8f2a:8500:57d2:826:6de3:1237])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac64eb7c0fsm9569091a12.62.2024.07.31.22.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 22:47:30 -0700 (PDT)
Message-ID: <20fad314-6b8f-429a-bb39-921ece6e46ab@gmail.com>
Date: Thu, 1 Aug 2024 07:47:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8723bs: rtw_mlme_ext: replace spaces by tabs
To: =?UTF-8?Q?Santiago_Ruano_Rinc=C3=B3n?= <santiagorr@riseup.net>
References: <20240730080531.991195-1-santiagorr@riseup.net>
 <800efa55-1765-48ea-8648-f9a6739342b6@gmail.com> <ZqrAgXs7qbt3RVaD@voleno>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 helen.koike@collabora.com, ~lkcamp/patches@lists.sr.ht
In-Reply-To: <ZqrAgXs7qbt3RVaD@voleno>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/1/24 00:53, Santiago Ruano Rincón wrote:
> Hello Philipp,
> 
> El 30/07/24 a las 21:18, Philipp Hortmann escribió:
>> On 7/30/24 10:05, Santiago Ruano Rincón wrote:
>>> Fix checkpatch error "ERROR: code indent should use tabs where possible"
>>> in include/rtw_mlme_ext.h:388.
>>>
>>> Signed-off-by: Santiago Ruano Rincón <santiagorr@riseup.net>
>>>
>>> ---
>>> I am (mostly) a newcommer. Could you please tell me if there is anything
>>> wrong with this patch? Thank you!
>>>
>>> checkpatch reports a warning in line 387:
>>> "WARNING: line length of 135 exceeds 100 columns"
>>> Should I fix the warning in the same patch, or should I send a second
>>> patch to fix it?
>>> ---
>>> ---
>>>    drivers/staging/rtl8723bs/include/rtw_mlme_ext.h | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
>>> index 5b8574f5a..720aeeb00 100644
>>> --- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
>>> +++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
>>> @@ -384,8 +384,8 @@ struct mlme_ext_priv {
>>>    	unsigned char default_supported_mcs_set[16];
>>>    	struct ss_res		sitesurvey_res;
>>> -	struct mlme_ext_info mlmext_info;/* for sta/adhoc mode, including current scanning/connecting/connected related info. */
>>> -                                                     /* for ap mode, network includes ap's cap_info */
>>> +	struct mlme_ext_info mlmext_info;	/* for sta/adhoc mode, including current scanning/connecting/connected related info. */
>>> +						/* for ap mode, network includes ap's cap_info */
>>>    	struct timer_list		survey_timer;
>>>    	struct timer_list		link_timer;
>>>    	struct timer_list		sa_query_timer;
>>
>>
>> Hi Santiago,
>>
>> it could be two patches or one. You are only allowed to do one thing at a
>> time. So it is also a little depending on your description. The way you
>> describe this it is more like two patches.
>> If your description would be like:
>>
>> Insert line break to comment, that exceeds 100 columns, to improve
>> readability.
>>
>> It would be OK to correct the indent as well.
>>
>> If you send in a second version of this patch please use a change history.
>> Description from Dan under:
>> https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/
>>
>> In case of questions feel free to contact me directly.
>>
>> Thanks for your support.
>>
>> Bye Philipp
> 
> Thanks a lot for your explanation. Much appreciated.
> 
> Greg has added the commit to his staging-testing branch. So I guess
> the only choice to fix that warning (a CHECK, actually) now is through a
> separate commit.

That is correct.

> Maybe several warnings/checks of the same type in the same file could be
> handled together in a single commit? 

Yes you can fix several issues in one commit if they are of same type. 
Example: Missing linebreaks

But is it worth the effort to fix
> them (when they are non-ERROR), or does it represent more work for you?

If you consider checkpatch warnings and errors it is more complicated. 
We want to fix all errors and warnings when it makes sense. Sometimes 
checkpatch is wrong. Finally you always need to judge if your patch is 
an improvement for readability.

Example:
Checkpatch warnings about not needed brackets in logical statements are 
most likely to be wrong. Reason is that the readability for those 
logical statements is extremely lowered when omitting the brackets.

I cannot respond to you alone as Greg insists on all mails to be on the 
mailing list.
https://lore.kernel.org/linux-staging/001101dae31f$d5ef44d0$81cdce70$@samsung.com/T/#m83a1aac71249e9d6b658bc5e4a7190c757d3547e

Thanks for your support.

Bye Philipp




