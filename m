Return-Path: <linux-kernel+bounces-416330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9429D435A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 22:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966401F22C87
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 21:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819191BD513;
	Wed, 20 Nov 2024 21:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjRuotsC"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E16F1946CA;
	Wed, 20 Nov 2024 21:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732136571; cv=none; b=gjAL9D4bUp/drtd/JGZa/p14OxMD5WRcbZth1JPwbancP546RWNM6y61NaOklem1QfUUAxVRSOSWfpQRCgeAHf5RTHBruCftB5LNBZDwBGKGnGorXpYuBjIkTMfLhcz0rODF26PV80ZzAqOi9wxJNYWqK3ZZ8P1qsRFVuxhHvsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732136571; c=relaxed/simple;
	bh=l+1UWZE/FneQaNmor7t7VOQyW1K40sQUIogRLrdtxu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bbiyK4EFNwX1Bf/Oni6U3HXA995ON9ZCIUMVImSiEtm+BStFC+Gd6pcvU++mNN3PRJA6uzKQSuke3Qfa7PSgUi5qnUFmluLBzh1JJXVL9FuIMWofU8lrQXulcIB2LLzedmfgc43eOlvRfZktqRC1PrmSQu3/QKMtLSOytF2hzXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjRuotsC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43161c0068bso1192225e9.1;
        Wed, 20 Nov 2024 13:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732136568; x=1732741368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0W86VFjt+Quipz5Nb0iH8DglZM9vyXbtWOfKsYcoOVE=;
        b=PjRuotsClifEuIVSxAk9JmqftVpHTilkZLsZhttg+jdQ/WNEB2eQxPmor/kOufWIuD
         iBUoKSqJK1U89CtVifXUGF30KISCLpIELjc0CwsWBuAdqa2/3lTM6nkhP7ZQrcRzfQdl
         a6BQb3h1LbVLvk/I6wC3KZq7fLBaVFGHfwNFhkZE6+YDUXX2RXgHDcoejPyjZgq426L9
         zLox+czfY3Uo02rGkDM4BgczlK1SX3na75b9Hekuk68UEWjLJfBCeW2BU6myqWbdMDLR
         ElB+lLzs8p/OwW3erpF3rgoG+lWjpGmb/ICTqtp4pYfmrA/sjV5LmtkA+EGFdl6Rnzno
         SA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732136568; x=1732741368;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0W86VFjt+Quipz5Nb0iH8DglZM9vyXbtWOfKsYcoOVE=;
        b=olKF4MB+fc9gbOU1ebiX2ppfuHa7gBfbcWBJjuFW3nk+9zqH+BTJZEAXVa+mtFES3s
         VWd1+F67oCaE+rmKW2WayaOgObPUs6fxGeELqHV1N7o+cRa7sWDQdWuqgX0RoLBdHukd
         RtViN4OsJNgL5GAhqnVuf++vYGmqmHSdZl9jUkc6hcFuji9qQUWcmCA9GQFtzLHfY0CY
         8l44bydvFbQblJy7gLArGoJmwE6N5bdg0JNxr7h/zJ7xdD7rAuD/nJzse6xJc4lIm2/M
         JOExTqgF6dVt8i9BGd2YgCq+c4IVKiTAjPoLKvzlQ0FAlTsX6gL14Hb2mWTKp70Po80N
         GhTw==
X-Forwarded-Encrypted: i=1; AJvYcCUP9eGz3p43tI4rYmRcr3Nx0+lzSEeJ4BLC4/1N/FyaUguf2v0YobbbaBPJ0O766Y4rc2N7/YtGSsWo6dk=@vger.kernel.org, AJvYcCW3tt+JHomupY66xdykhob609tjORqNk1XAGZ0jsXFXDQMP0+Q1Z6ShLlqHVFupPXQfTykX/IklUi9cbbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP5Jsiom6q/1778PtauazBPSr1EhdDzHV/MCSfXcBjw9hKnXf7
	R5YP+yA6Y7CrH+Qq27DiOHbhjesf0jdP7G1bQDD/tgw7qN9bhi5OZ1lsB6b1
X-Google-Smtp-Source: AGHT+IF+WGkTBr+0IZp/PelvWY5A1KaHqBiRh2Q9FUd5skJu6MnEGMlSt6tBYeUgrbDBapVo2LRhVw==
X-Received: by 2002:a05:600c:310b:b0:431:3b53:105e with SMTP id 5b1f17b1804b1-433489b4d16mr37864135e9.9.1732136568157;
        Wed, 20 Nov 2024 13:02:48 -0800 (PST)
Received: from [192.168.199.20] ([95.76.0.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b463ad1fsm31501395e9.38.2024.11.20.13.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 13:02:47 -0800 (PST)
Message-ID: <57a3a34c-261d-44ec-b96e-05fecb0b7cab@gmail.com>
Date: Wed, 20 Nov 2024 23:02:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] ALSA: usb-audio: Fix missing xrun report in lowlatency mode
To: Takashi Iwai <tiwai@suse.de>
Cc: Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
 Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org
References: <25d5b0d8-4efd-4630-9d33-7a9e3fa9dc2b@gmail.com>
 <874j425pjz.wl-tiwai@suse.de> <87v7wi484f.wl-tiwai@suse.de>
Content-Language: en-US
From: Leonard Crestez <cdleonard@gmail.com>
In-Reply-To: <87v7wi484f.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/20/24 10:33, Takashi Iwai wrote:
> On Wed, 20 Nov 2024 08:31:44 +0100,
> Takashi Iwai wrote:
>>
>> On Tue, 19 Nov 2024 22:54:19 +0100,
>> Leonard Crestez wrote:
>>>
>>> Hello,
>>>
>>> I’m investigating an issue where USB Audio does not properly send
>>> XRUN notifications.
>>>
>>> The issue can be reproduced with aplay: enable xrun_debug, aplay -D
>>> plughw:0 and CTRL-Z - no XRUN message is seen
>>>
>>> Disabling lowlatency_playback via modprobe parameter does make this
>>> issue go away - XRUNs are reported correctly without any changes.
>>>
>>>
>>> After a lot of tracing the following seems to be happening:
>>>
>>> - prepare_playback_urb find avail=48, meaning 48 bytes still to-be-played
>>> - snd_usb_endpoint_next_packet_size decides that 48 is too little and
>>> returns -EAGAIN. Specifically -EAGAIN is returned from
>>> next_packet_size
>>> - The return value of prepare_playback_urb is propagated through
>>> prepare_outbound_urb back to snd_usb_queue_pending_output_urbs
>>> - snd_usb_queue_pending_output_urbs receives -EAGAIN from
>>> prepare_outbound_urb
>>> - since err is -EAGAIN the ctx is pushed back to the ready list and
>>> transmission is aborted but notify_xrun is skipped
>>> - no more playback?
>>>
>>> It is possible to make XRUNs happen by caling notify_xrun even on
>>> -EAGAIN, diff looks like this:
>>>
>>> diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
>>> index 568099467dbb..da64ee0cf60a 100644
>>> --- a/sound/usb/endpoint.c
>>> +++ b/sound/usb/endpoint.c
>>> @@ -495,10 +495,11 @@ int snd_usb_queue_pending_output_urbs(struct
>>> snd_usb_endpoint *ep,
>>>                          break;
>>>                  if (err < 0) {
>>>                          /* push back to ready list again for -EAGAIN */
>>>                          if (err == -EAGAIN) {
>>>                                  push_back_to_ready_list(ep, ctx);
>>> +                               notify_xrun(ep);
>>>                                  break;
>>>                          }
>>>
>>>                          if (!in_stream_lock)
>>>                                  notify_xrun(ep);
>>>
>>>
>>> This mail was not formatted as proper patch because this seems very
>>> likely incorrect, it undoes an explicit check. What would a correct
>>> solution look like?
>>
>> The -EAGAIN there itself doesn't mean the crucial xrun yet.  There may
>> be still pending URBS to be processed.  The real XRUN happens only
>> when there is no URBs pending, hence nothing will be taken further --
>> at least for low-latency operation.  (In the case of implicit feedback
>> mode, it can be driven by the feedback from the capture stream, and
>> the empty URB check might be wrong.)
>>
>> Could you check the change below?  (totally untested)
> 
> A bit more change would be needed because it can lead to a false xrun
> at draining.  At stopping, it shouldn't reach to that code path.
> The revised patch is below.

> --- a/sound/usb/endpoint.c
> +++ b/sound/usb/endpoint.c
> @@ -403,10 +403,15 @@ static int prepare_inbound_urb(struct snd_usb_endpoint *ep,
>   static void notify_xrun(struct snd_usb_endpoint *ep)
>   {
>   	struct snd_usb_substream *data_subs;
> +	struct snd_pcm_substream *psubs;
>   
>   	data_subs = READ_ONCE(ep->data_subs);
> -	if (data_subs && data_subs->pcm_substream)
> -		snd_pcm_stop_xrun(data_subs->pcm_substream);
> +	if (!data_subs)
> +		return;
> +	psubs = data_subs->pcm_substream;
> +	if (psubs && psubs->runtime &&
> +	    psubs->runtime->state == SNDRV_PCM_STATE_RUNNING)
> +		snd_pcm_stop_xrun(psubs);
>   }
>   
>   static struct snd_usb_packet_info *
> @@ -562,7 +567,10 @@ static void snd_complete_urb(struct urb *urb)
>   			push_back_to_ready_list(ep, ctx);
>   			clear_bit(ctx->index, &ep->active_mask);
>   			snd_usb_queue_pending_output_urbs(ep, false);
> -			atomic_dec(&ep->submitted_urbs); /* decrement at last */
> +			/* decrement at last, and check xrun */
> +			if (atomic_dec_and_test(&ep->submitted_urbs) &&
> +			    !snd_usb_endpoint_implicit_feedback_sink(ep))
> +				notify_xrun(ep);
>   			return;
>   		}

This makes more sense than what I hacked to together and seems to work 
well in initial testing.

I'll report back if issues are found.

--
Thanks,
Leonard

