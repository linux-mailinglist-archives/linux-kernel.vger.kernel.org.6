Return-Path: <linux-kernel+bounces-187539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0508CD326
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A70001C21FFA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD3614A61B;
	Thu, 23 May 2024 13:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="c+2RCE0r"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFD414830E
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 13:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716469456; cv=none; b=AJ7gSWdpb6grZ+nou8g7khgU8ZuXEGU8e9lOjfmyhWzlDs5HzkpteSn+pmxbuOVsXWL2nlwmShkluXs2/fY6LTOxltJ82KwGMUxUoUfwsncGKTYgFcAYq8KuYSD6DdJKHmZVhItp3W6BkVHon8PIHRzC/aSdelU0EciHFb9mj0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716469456; c=relaxed/simple;
	bh=gPGMwLLeDLNkh3TYTRIn0gXVjE6IQM9ONM01R4ivyJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BCmY0FKIW4xjHlCT6tR6wvAEOI9qHJsKGSD4yVi37Pc+rEl+dSzeZaSNJj4B1U7iNiaPEmNPTCa+o96JX8xQaenwhorM5DyQBt+xs+mFEw13M+QoVuJB81qATJSjmODYT3Gh6YvnY7qb4q4vhnabeZP6w6C95fjWB+qRXjo1X0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=c+2RCE0r; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f34b98b9b4so66705ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 06:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716469451; x=1717074251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iPcBTM5I+MFfOzb0MSOYi+VNek3mHku58ke+pzSmNtQ=;
        b=c+2RCE0ru38BgMQZ3kdNaPfHWngzdAzopNdsAl/u0WNEIBTlOOUyTmzvr9ou8VFmGB
         vfNLVHfkWH8hMZr9OX1a73U9a/K327uRqtME5E40C9G8dDPr0TBqHI9YCLuCdx8MXr3g
         veo/pkn3gtqaxDnpaawh28PINkK5EcHGX44xWM2v2zQTJTseASiv43RNeqYyB4PtvtiU
         q7vh04CrUAnRp0pWTmrFbovCAFIXu2A0MKDvjc0ABZ7ikUdpQG/1T8bM00XSqWwPdT+n
         xrvXpjO74lyapsVcvK/cc2apCGrbLtsI0/vNWbJ8vjF45tLdct50LL170r1loR9PRhQc
         Ntlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716469451; x=1717074251;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iPcBTM5I+MFfOzb0MSOYi+VNek3mHku58ke+pzSmNtQ=;
        b=PPMWX7u5193MvlgG40avhKk2dlyugffDqhcZ4/MiXknRr2BHPycbeMYMNYVk4teI3J
         qcKyEqS+VYpvEhDVV+R3CM5ZpKXfAmMTo6bUsz17/zjgWglKcRCxZgoxLWjRo2LTP/l3
         EaWJE/hbgC9krVui7bALgKTGGnTpavpRFt8eJXIbQPcBS7k713ww4TnMih+M2eXBISu/
         UWIgMW6yNvC9dm6CgN1kGZ7v8sDSdmA8s66Xd8Ium/tTSmtaPgCly21gMfvqRgXgohfo
         K0mEMXJau0WmoLjuSaBGzo4Na622WFHicMA9iA0zuXAdgpPu3a6FT24/xws+GmKUE6Ea
         xY5w==
X-Forwarded-Encrypted: i=1; AJvYcCUW+TymPc8LE7K6Sft2rXd0Y6dJw4HnI7y07WSDNpLxTkicRhH1ep/D7PqHRxwyqJdV7yBJHeVH4UUTNdyg/nToYy15lwcpe+DsPMfd
X-Gm-Message-State: AOJu0YxjTUTnp+UYzuJwONLPZmuNgCmmjPrmLD5fI19XF0sum2I6+dFr
	NO71cjUBVPImjIUjkwsfuz6Gx6tYs6KQQExRTZg0nUaEq3QxuDJi4J6wZdvtip0vtdjk7N7PEyP
	f
X-Google-Smtp-Source: AGHT+IEqZumjDycfTAekXjBdCht0wMdxVooj/kFc6UYJXA9kMC56gWlA98Y7SCepLg/V0zaIRcI/CQ==
X-Received: by 2002:a17:902:d489:b0:1f2:f12e:27f6 with SMTP id d9443c01a7336-1f31c7ff1cdmr51407425ad.0.1716469451262;
        Thu, 23 May 2024 06:04:11 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f328767adesm28199705ad.189.2024.05.23.06.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 06:04:10 -0700 (PDT)
Message-ID: <ab21593c-d32e-40b4-9238-60acdd402fd1@kernel.dk>
Date: Thu, 23 May 2024 07:04:09 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loop: inherit the ioprio in loop woker thread
To: yunlong xing <yunlongxing23@gmail.com>,
 Bart Van Assche <bvanassche@acm.org>
Cc: Yunlong Xing <yunlong.xing@unisoc.com>, niuzhiguo84@gmail.com,
 Hao_hao.Wang@unisoc.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240522074829.1750204-1-yunlong.xing@unisoc.com>
 <5166bc31-1fd9-4f7f-bc51-f1f50d9d5483@acm.org>
 <68cfbc08-6d39-4bc6-854d-5df0c94dbfd4@kernel.dk>
 <f6d3e1f2-e004-49bb-b6c1-969915ccab37@acm.org>
 <CA+3AYtS=5=_4cQK3=ASvgqQWWCohOsDuVwqiuDgErAnBJ17bBw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CA+3AYtS=5=_4cQK3=ASvgqQWWCohOsDuVwqiuDgErAnBJ17bBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/23/24 12:04 AM, yunlong xing wrote:
> Bart Van Assche <bvanassche@acm.org> ?2024?5?23??? 02:12???
>>
>> On 5/22/24 10:57, Jens Axboe wrote:
>>> On 5/22/24 11:38 AM, Bart Van Assche wrote:
>>>> On 5/22/24 00:48, Yunlong Xing wrote:
>>>>> @@ -1913,6 +1921,10 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
>>>>>            set_active_memcg(old_memcg);
>>>>>            css_put(cmd_memcg_css);
>>>>>        }
>>>>> +
>>>>> +    if (ori_ioprio != cmd_ioprio)
>>>>> +        set_task_ioprio(current, ori_ioprio);
>>>>> +
>>>>>     failed:
>>>>>        /* complete non-aio request */
>>>>>        if (!use_aio || ret) {
>>>>
>>>> Does adding this call in the hot path have a measurable performance impact?
>>>
>>> It's loop, I would not be concerned with overhead. But it does look pretty
>>> bogus to modify the task ioprio from here.
>>
>> Hi Jens,
>>
>> Maybe Yunlong uses that call to pass the I/O priority to the I/O submitter?
>>
>> I think that it is easy to pass the I/O priority to the kiocb submitted by
>> lo_rw_aio() without calling set_task_ioprio().
>>
>> lo_read_simple() and lo_write_simple() however call vfs_iter_read() /
>> vfs_iter_write(). This results in a call of do_iter_readv_writev() and
>> init_sync_kiocb(). The latter function calls get_current_ioprio(). This is
>> probably why the set_task_ioprio() call has been added?
> 
> Yeah that's why I call set_task_ioprio.  I want to the loop kwoker
> task?submit I/O to the real disk device?can pass the iopriority of the
> loop device request? both lo_rw_aio() and
> lo_read_simple()/lo_write_simple().

And that's a totally backwards and suboptimal way to do it. The task
priority is only used as a last resort lower down, if the IO itself
hasn't been appropriately marked.

Like I said, it's back to the drawing board on this patch, there's no
way it's acceptable in its current form.

-- 
Jens Axboe


