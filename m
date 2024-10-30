Return-Path: <linux-kernel+bounces-387975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0DA9B58A8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 01:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EF541C2295A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8D01773A;
	Wed, 30 Oct 2024 00:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dhXgK30M"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4032FCA64
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 00:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730248445; cv=none; b=EPUCcNEssL+LGb+osVVaP6ajG0B0ZQfO7zCwQL50aR1ZzvF/1Z4uuYDoOuhHNwHS44cmLBsVOf8Ld8Up3kfEU36oaUAqkuDGwR/+6Ewk8oL4CstdPCO/j+S5rMQPh+kSnnzHNFDtF3UJOiQEYYRIZYmVFv1ff20DGeIVnC8UJS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730248445; c=relaxed/simple;
	bh=tiAvgvsLE6rjpX7zEzepkjPGcET4GcjB8ZZIJl9FiQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mdVQ/yOUqrMQETX8Q/FKr7EDvxVBBqeJH3XFb+dFifNHkOvSrA9Qse9jCQo/aAP1AsGbm7WRVcP+HMJQGrNVKc1T2NT56SIcDzTxbbFzofvK+zm/2rHhbPuU18YK92+EATJEhz4PuMFMgCkj80v6AzVKOaVvV5wIQ90hMZbwMlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dhXgK30M; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-720aa3dbda5so447420b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 17:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730248441; x=1730853241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KbSDJBLlHKSyAOrci8Zs8o4I4XPAIgb9/ixhHZj1G84=;
        b=dhXgK30MfAyBqhbo/NPXfBRLAErvXfhQb1BKZldMOk7y7XhyUQUO1/AHYvqD4+MCkF
         3sbubeqe4vVN31pqhK2gg+ia4eRzXxTEF/hpG7FGe+mOSsdVT0tbiTFVp3IDaBU24LQg
         merpdQaqB4faBffkTTe0zHi6871Jmb4wetq4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730248441; x=1730853241;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KbSDJBLlHKSyAOrci8Zs8o4I4XPAIgb9/ixhHZj1G84=;
        b=HXHRkpYvyOZU2gcBMis8KIZlEN1iooO5z1coojNjw8dnSqmE1ARpcW4onl7fMGMH87
         TLyXZz8WuE9wxEdnh5i8Zj18jOY4038BP1cLZOurymeDY4z8FfUfGEGMHu++z9jNm3Hx
         DFbNj5ttVOL92Wqs8NYO36V0LMI2Pj0HlosE6sT4qkbCgtjmesVFvKXOLyqgjLTPJvMO
         CXpvaHMlSUp8L+wJTDi5mI8PixpeTcjtHmbL18JPLYo0F/94uLGoxZU8WEMsJU0ZfbDd
         FwUgTgiEoGr3a0LFBhgKa9qrsCEdR25e69n9lhr2HLWHUOOy5a7vvl4CpTQ/Vjr3el9H
         ArGw==
X-Forwarded-Encrypted: i=1; AJvYcCXcSsUHZJI+iEivUmKa8wdXoYaYrtLcvrhVNwr0JDjZl4O3+w2xQdqOcummjDfqhPxw9wy6iiZw6y4DwGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YypIwotaNI0KNz9CvtsHr+5XH+BH/LmnE66D4S/uaR/g5pqqKdI
	gPb+cfOMMRaAAI2F0MsZaoM47095sXRorfXGLfVFVZPPW55vaKs9PqMI4acWezE=
X-Google-Smtp-Source: AGHT+IH2cTe+PK1Hmka5/vXl3rFpatrvZI9Mvd9gJVCCzK2p32J0VD5FZNZXyzUF5VZjFDcy1lQ4SA==
X-Received: by 2002:a05:6a00:811:b0:71e:50ef:20f3 with SMTP id d2e1a72fcca58-720ab4c705fmr1875194b3a.28.1730248441305;
        Tue, 29 Oct 2024 17:34:01 -0700 (PDT)
Received: from [192.168.3.101] (p8535228-ipngn42701marunouchi.tokyo.ocn.ne.jp. [180.15.75.228])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a1fe82sm8136175b3a.164.2024.10.29.17.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 17:34:00 -0700 (PDT)
Message-ID: <663beaef-6e02-4a8c-b380-247050f8936e@linuxfoundation.org>
Date: Tue, 29 Oct 2024 18:33:54 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb:core: Remove unused parameter struct usb_hcd *hcd in
 usb_hcd_unlink_urb_from_ep
To: lizhe <sensor1010@163.com>
Cc: gregkh@linuxfoundation.org, linus.walleij@linaro.org,
 stern@rowland.harvard.edu, ok@artecdesign.ee, mathias.nyman@intel.com,
 b-liu@ti.com, valentina.manea.m@gmail.com, shuah@kernel.org, i@zenithal.me,
 niko.mauno@vaisala.com, dvyukov@google.com, andreyknvl@gmail.com,
 tj@kernel.org, viro@zeniv.linux.org.uk, christophe.jaillet@wanadoo.fr,
 stanley_chang@realtek.com, sylv@sylv.io, lee@kernel.org,
 colin.i.king@gmail.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241027163130.5368-1-sensor1010@163.com>
 <e31ef46a-ebaa-4040-9e56-b83afb414683@linuxfoundation.org>
 <2692e3ef.b806.192d8f95cf3.Coremail.sensor1010@163.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <2692e3ef.b806.192d8f95cf3.Coremail.sensor1010@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/29/24 09:51, lizhe wrote:

Please don't top post. It is harder to the thread.

> 
> Hi， Shuah Khan
> 
> 
> *usb_hcd_link_urb_to_ep() which is link counter part takes hcd*
> 
> in usb_hcd_link_urb_to_ep(), the hcd is used.  but, hcd is not used in usb_hcd_unlink_urb_from_ep()
> 
> just because hcd is used in usb_hcd_link_urb_to_ep(), must it be retained in usb_hcd_unlink_urb_from_ep() ?
> 
> 
> *It makses sense to specify hcd to which this urb belongs to*
> 
> this is good to keep as-is for documentation alone, it doesn't actually change anything (---by greg k-h)

This sounds like this change isn't required?

> 
> doing this increases the overhead of entering the stack .

Right. Can you quantify the overhead?

> 
> 
> thanks,
> 
> Lizhe
> 
> 
> 
> At 2024-10-28 11:17:43, "Shuah Khan" <skhan@linuxfoundation.org> wrote:
>>On 10/27/24 10:31, 李哲 wrote:
>>> The first parameter of the usb_hcd_unlink_urb_from_ep() is not used.
>>> This causes many callers to have to pass an additional parameter
>>> unnecessarily. Let's remove it
>>
>>How did you find this problem and how did you test this?
>>Even if hcd isn't used, usb_hcd_link_urb_to_ep() which
>>is link counter part takes hcd
>>
>>It makses sense to specify hcd to which this urb belongs
>>to. Can you give more details on why this change would
>>make sense here.
>>
>>> 
>>> Signed-off-by: 李哲 <sensor1010@163.com>
>>> ---
>>>   drivers/usb/c67x00/c67x00-sched.c    |  6 +++---
>>>   drivers/usb/core/hcd.c               |  9 ++++-----
>>>   drivers/usb/fotg210/fotg210-hcd.c    | 10 +++++-----
>>>   drivers/usb/gadget/udc/dummy_hcd.c   |  2 +-
>>>   drivers/usb/host/ehci-q.c            |  4 ++--
>>>   drivers/usb/host/ehci-sched.c        |  6 +++---
>>>   drivers/usb/host/fhci-q.c            |  2 +-
>>>   drivers/usb/host/isp116x-hcd.c       |  4 ++--
>>>   drivers/usb/host/isp1362-hcd.c       |  4 ++--
>>>   drivers/usb/host/max3421-hcd.c       |  4 ++--
>>>   drivers/usb/host/octeon-hcd.c        |  6 +++---
>>>   drivers/usb/host/ohci-hcd.c          |  2 +-
>>>   drivers/usb/host/ohci-q.c            |  2 +-
>>>   drivers/usb/host/r8a66597-hcd.c      |  4 ++--
>>>   drivers/usb/host/sl811-hcd.c         |  4 ++--
>>>   drivers/usb/host/uhci-q.c            |  4 ++--
>>>   drivers/usb/host/xhci-ring.c         |  4 ++--
>>>   drivers/usb/host/xhci.c              |  2 +-
>>>   drivers/usb/musb/musb_host.c         |  6 +++---
>>>   drivers/usb/renesas_usbhs/mod_host.c |  2 +-
>>>   drivers/usb/usbip/vhci_hcd.c         |  6 +++---
>>>   drivers/usb/usbip/vhci_rx.c          |  4 ++--
>>>   include/linux/usb/hcd.h              |  2 +-
>>>   23 files changed, 49 insertions(+), 50 deletions(-)
>>> 
>>> diff --git a/drivers/usb/c67x00/c67x00-sched.c b/drivers/usb/c67x00/c67x00-sched.c
>>> index a09fa68a6ce7..28f07e9bb708 100644
>>> --- a/drivers/usb/c67x00/c67x00-sched.c
>>> +++ b/drivers/usb/c67x00/c67x00-sched.c
>>> @@ -429,7 +429,7 @@ int c67x00_urb_enqueue(struct usb_hcd *hcd,
>>>   	return 0;
>>>   
>>>   err_epdata:
>>> -	usb_hcd_unlink_urb_from_ep(hcd, urb);
>>> +	usb_hcd_unlink_urb_from_ep(urb);
>>>   err_not_linked:
>>>   	spin_unlock_irqrestore(&c67x00->lock, flags);
>>>   	kfree(urbp);
>>> @@ -450,7 +450,7 @@ int c67x00_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
>>>   		goto done;
>>>   
>>>   	c67x00_release_urb(c67x00, urb);
>>> -	usb_hcd_unlink_urb_from_ep(hcd, urb);
>>> +	usb_hcd_unlink_urb_from_ep(urb);
>>>   
>>>   	spin_unlock(&c67x00->lock);
>>>   	usb_hcd_giveback_urb(hcd, urb, status);
>>> @@ -484,7 +484,7 @@ c67x00_giveback_urb(struct c67x00_hcd *c67x00, struct urb *urb, int status)
>>>   	list_del_init(&urbp->hep_node);
>>>   
>>>   	c67x00_release_urb(c67x00, urb);
>>> -	usb_hcd_unlink_urb_from_ep(c67x00_hcd_to_hcd(c67x00), urb);
>>> +	usb_hcd_unlink_urb_from_ep(urb);
>>>   	spin_unlock(&c67x00->lock);
>>>   	usb_hcd_giveback_urb(c67x00_hcd_to_hcd(c67x00), urb, status);
>>>   	spin_lock(&c67x00->lock);
>>> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
>>> index 500dc35e6477..c0e159ad7bae 100644
>>> --- a/drivers/usb/core/hcd.c
>>> +++ b/drivers/usb/core/hcd.c
>>> @@ -707,7 +707,7 @@ static int rh_call_control (struct usb_hcd *hcd, struct urb *urb)
>>>   
>>>   	/* any errors get returned through the urb completion */
>>>   	spin_lock_irq(&hcd_root_hub_lock);
>>> -	usb_hcd_unlink_urb_from_ep(hcd, urb);
>>> +	usb_hcd_unlink_urb_from_ep(urb);
>>>   	usb_hcd_giveback_urb(hcd, urb, status);
>>>   	spin_unlock_irq(&hcd_root_hub_lock);
>>>   	return 0;
>>> @@ -753,7 +753,7 @@ void usb_hcd_poll_rh_status(struct usb_hcd *hcd)
>>>   			urb->actual_length = length;
>>>   			memcpy(urb->transfer_buffer, buffer, length);
>>>   
>>> -			usb_hcd_unlink_urb_from_ep(hcd, urb);
>>> +			usb_hcd_unlink_urb_from_ep(urb);
>>>   			usb_hcd_giveback_urb(hcd, urb, status);
>>>   		} else {
>>>   			length = 0;
>>> @@ -845,7 +845,7 @@ static int usb_rh_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
>>>   			del_timer (&hcd->rh_timer);
>>>   		if (urb == hcd->status_urb) {
>>>   			hcd->status_urb = NULL;
>>> -			usb_hcd_unlink_urb_from_ep(hcd, urb);
>>> +			usb_hcd_unlink_urb_from_ep(urb);
>>>   			usb_hcd_giveback_urb(hcd, urb, status);
>>>   		}
>>>   	}
>>> @@ -1210,7 +1210,6 @@ EXPORT_SYMBOL_GPL(usb_hcd_check_unlink_urb);
>>>   
>>>   /**
>>>    * usb_hcd_unlink_urb_from_ep - remove an URB from its endpoint queue
>>> - * @hcd: host controller to which @urb was submitted
>>>    * @urb: URB being unlinked
>>>    *
>>>    * Host controller drivers should call this routine before calling
>>> @@ -1218,7 +1217,7 @@ EXPORT_SYMBOL_GPL(usb_hcd_check_unlink_urb);
>>>    * interrupts must be disabled.  The actions carried out here are required
>>>    * for URB completion.
>>>    */
>>> -void usb_hcd_unlink_urb_from_ep(struct usb_hcd *hcd, struct urb *urb)
>>> +void usb_hcd_unlink_urb_from_ep(struct urb *urb)
>>>   {
>>>   	/* clear all state linking urb to this dev (and hcd) */
>>>   	spin_lock(&hcd_urb_list_lock);
>>> diff --git a/drivers/usb/fotg210/fotg210-hcd.c b/drivers/usb/fotg210/fotg210-hcd.c
>>> index 3d404d19a205..1b7285885915 100644
>>> --- a/drivers/usb/fotg210/fotg210-hcd.c
>>> +++ b/drivers/usb/fotg210/fotg210-hcd.c
>>> @@ -2221,7 +2221,7 @@ __acquires(fotg210->lock)
>>>   #endif
>>>   
>>>   	/* complete() can reenter this HCD */
>>> -	usb_hcd_unlink_urb_from_ep(fotg210_to_hcd(fotg210), urb);
>>> +	usb_hcd_unlink_urb_from_ep(urb);
>>>   	spin_unlock(&fotg210->lock);
>>>   	usb_hcd_giveback_urb(fotg210_to_hcd(fotg210), urb, status);
>>>   	spin_lock(&fotg210->lock);
>>> @@ -3043,7 +3043,7 @@ static int submit_async(struct fotg210_hcd *fotg210, struct urb *urb,
>>>   
>>>   	qh = qh_append_tds(fotg210, urb, qtd_list, epnum, &urb->ep->hcpriv);
>>>   	if (unlikely(qh == NULL)) {
>>> -		usb_hcd_unlink_urb_from_ep(fotg210_to_hcd(fotg210), urb);
>>> +		usb_hcd_unlink_urb_from_ep(urb);
>>>   		rc = -ENOMEM;
>>>   		goto done;
>>>   	}
>>> @@ -3855,7 +3855,7 @@ static int intr_submit(struct fotg210_hcd *fotg210, struct urb *urb,
>>>   
>>>   done:
>>>   	if (unlikely(status))
>>> -		usb_hcd_unlink_urb_from_ep(fotg210_to_hcd(fotg210), urb);
>>> +		usb_hcd_unlink_urb_from_ep(urb);
>>>   done_not_linked:
>>>   	spin_unlock_irqrestore(&fotg210->lock, flags);
>>>   	if (status)
>>> @@ -4553,14 +4553,14 @@ static int itd_submit(struct fotg210_hcd *fotg210, struct urb *urb,
>>>   		status = -ESHUTDOWN;
>>>   		goto done_not_linked;
>>>   	}
>>> -	status = usb_hcd_link_urb_to_ep(fotg210_to_hcd(fotg210), urb);
>>> +	status = usb_hcd_link_urb_to_ep(urb);
>>>   	if (unlikely(status))
>>>   		goto done_not_linked;
>>>   	status = iso_stream_schedule(fotg210, urb, stream);
>>>   	if (likely(status == 0))
>>>   		itd_link_urb(fotg210, urb, fotg210->periodic_size << 3, stream);
>>>   	else
>>> -		usb_hcd_unlink_urb_from_ep(fotg210_to_hcd(fotg210), urb);
>>> +		usb_hcd_unlink_urb_from_ep(urb);
>>>   done_not_linked:
>>>   	spin_unlock_irqrestore(&fotg210->lock, flags);
>>>   done:
>>> diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
>>> index 081ac7683c0b..d6ff455ed9ba 100644
>>> --- a/drivers/usb/gadget/udc/dummy_hcd.c
>>> +++ b/drivers/usb/gadget/udc/dummy_hcd.c
>>> @@ -1988,7 +1988,7 @@ static enum hrtimer_restart dummy_timer(struct hrtimer *t)
>>>   		if (ep)
>>>   			ep->already_seen = ep->setup_stage = 0;
>>>   
>>> -		usb_hcd_unlink_urb_from_ep(dummy_hcd_to_hcd(dum_hcd), urb);
>>> +		usb_hcd_unlink_urb_from_ep(urb);
>>>   		spin_unlock(&dum->lock);
>>>   		usb_hcd_giveback_urb(dummy_hcd_to_hcd(dum_hcd), urb, status);
>>>   		spin_lock(&dum->lock);
>>> diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
>>> index ba37a9fcab92..af3f39d28f65 100644
>>> --- a/drivers/usb/host/ehci-q.c
>>> +++ b/drivers/usb/host/ehci-q.c
>>> @@ -271,7 +271,7 @@ ehci_urb_done(struct ehci_hcd *ehci, struct urb *urb, int status)
>>>   		urb->actual_length, urb->transfer_buffer_length);
>>>   #endif
>>>   
>>> -	usb_hcd_unlink_urb_from_ep(ehci_to_hcd(ehci), urb);
>>> +	usb_hcd_unlink_urb_from_ep(urb);
>>>   	usb_hcd_giveback_urb(ehci_to_hcd(ehci), urb, status);
>>>   }
>>>   
>>> @@ -1133,7 +1133,7 @@ submit_async (
>>>   
>>>   	qh = qh_append_tds(ehci, urb, qtd_list, epnum, &urb->ep->hcpriv);
>>>   	if (unlikely(qh == NULL)) {
>>> -		usb_hcd_unlink_urb_from_ep(ehci_to_hcd(ehci), urb);
>>> +		usb_hcd_unlink_urb_from_ep(urb);
>>>   		rc = -ENOMEM;
>>>   		goto done;
>>>   	}
>>> diff --git a/drivers/usb/host/ehci-sched.c b/drivers/usb/host/ehci-sched.c
>>> index 7e834587e7de..7f78b63010d1 100644
>>> --- a/drivers/usb/host/ehci-sched.c
>>> +++ b/drivers/usb/host/ehci-sched.c
>>> @@ -957,7 +957,7 @@ static int intr_submit(
>>>   
>>>   done:
>>>   	if (unlikely(status))
>>> -		usb_hcd_unlink_urb_from_ep(ehci_to_hcd(ehci), urb);
>>> +		usb_hcd_unlink_urb_from_ep(urb);
>>>   done_not_linked:
>>>   	spin_unlock_irqrestore(&ehci->lock, flags);
>>>   	if (status)
>>> @@ -1964,7 +1964,7 @@ static int itd_submit(struct ehci_hcd *ehci, struct urb *urb,
>>>   		status = 0;
>>>   		ehci_urb_done(ehci, urb, 0);
>>>   	} else {
>>> -		usb_hcd_unlink_urb_from_ep(ehci_to_hcd(ehci), urb);
>>> +		usb_hcd_unlink_urb_from_ep(urb);
>>>   	}
>>>    done_not_linked:
>>>   	spin_unlock_irqrestore(&ehci->lock, flags);
>>> @@ -2341,7 +2341,7 @@ static int sitd_submit(struct ehci_hcd *ehci, struct urb *urb,
>>>   		status = 0;
>>>   		ehci_urb_done(ehci, urb, 0);
>>>   	} else {
>>> -		usb_hcd_unlink_urb_from_ep(ehci_to_hcd(ehci), urb);
>>> +		usb_hcd_unlink_urb_from_ep(urb);
>>>   	}
>>>    done_not_linked:
>>>   	spin_unlock_irqrestore(&ehci->lock, flags);
>>> diff --git a/drivers/usb/host/fhci-q.c b/drivers/usb/host/fhci-q.c
>>> index 669c240523fe..108d19907036 100644
>>> --- a/drivers/usb/host/fhci-q.c
>>> +++ b/drivers/usb/host/fhci-q.c
>>> @@ -198,7 +198,7 @@ void fhci_urb_complete_free(struct fhci_hcd *fhci, struct urb *urb)
>>>   			urb->status = 0;
>>>   	}
>>>   
>>> -	usb_hcd_unlink_urb_from_ep(fhci_to_hcd(fhci), urb);
>>> +	usb_hcd_unlink_urb_from_ep(urb);
>>>   
>>>   	spin_unlock(&fhci->lock);
>>>   
>>> diff --git a/drivers/usb/host/isp116x-hcd.c b/drivers/usb/host/isp116x-hcd.c
>>> index a82d8926e922..f2c001cd526a 100644
>>> --- a/drivers/usb/host/isp116x-hcd.c
>>> +++ b/drivers/usb/host/isp116x-hcd.c
>>> @@ -304,7 +304,7 @@ __releases(isp116x->lock) __acquires(isp116x->lock)
>>>   
>>>   	urb_dbg(urb, "Finish");
>>>   
>>> -	usb_hcd_unlink_urb_from_ep(isp116x_to_hcd(isp116x), urb);
>>> +	usb_hcd_unlink_urb_from_ep(urb);
>>>   	spin_unlock(&isp116x->lock);
>>>   	usb_hcd_giveback_urb(isp116x_to_hcd(isp116x), urb, status);
>>>   	spin_lock(&isp116x->lock);
>>> @@ -824,7 +824,7 @@ static int isp116x_urb_enqueue(struct usb_hcd *hcd,
>>>   
>>>         fail:
>>>   	if (ret)
>>> -		usb_hcd_unlink_urb_from_ep(hcd, urb);
>>> +		usb_hcd_unlink_urb_from_ep(urb);
>>>         fail_not_linked:
>>>   	spin_unlock_irqrestore(&isp116x->lock, flags);
>>>   	return ret;
>>> diff --git a/drivers/usb/host/isp1362-hcd.c b/drivers/usb/host/isp1362-hcd.c
>>> index 31059c8f94e6..ba52edd31d09 100644
>>> --- a/drivers/usb/host/isp1362-hcd.c
>>> +++ b/drivers/usb/host/isp1362-hcd.c
>>> @@ -466,7 +466,7 @@ static void finish_request(struct isp1362_hcd *isp1362_hcd, struct isp1362_ep *e
>>>   		"short_ok" : "", urb->status);
>>>   
>>>   
>>> -	usb_hcd_unlink_urb_from_ep(isp1362_hcd_to_hcd(isp1362_hcd), urb);
>>> +	usb_hcd_unlink_urb_from_ep(isp1362_hcd_to_hcd(urb));
>>>   	spin_unlock(&isp1362_hcd->lock);
>>>   	usb_hcd_giveback_urb(isp1362_hcd_to_hcd(isp1362_hcd), urb, status);
>>>   	spin_lock(&isp1362_hcd->lock);
>>> @@ -1384,7 +1384,7 @@ static int isp1362_urb_enqueue(struct usb_hcd *hcd,
>>>   	}
>>>    fail:
>>>   	if (retval)
>>> -		usb_hcd_unlink_urb_from_ep(hcd, urb);
>>> +		usb_hcd_unlink_urb_from_ep(urb);
>>>   
>>>   
>>>    fail_not_linked:
>>> diff --git a/drivers/usb/host/max3421-hcd.c b/drivers/usb/host/max3421-hcd.c
>>> index 9fe4f48b1898..f7a1d8fb3085 100644
>>> --- a/drivers/usb/host/max3421-hcd.c
>>> +++ b/drivers/usb/host/max3421-hcd.c
>>> @@ -779,7 +779,7 @@ max3421_check_unlink(struct usb_hcd *hcd)
>>>   				retval = 1;
>>>   				dev_dbg(&spi->dev, "%s: URB %p unlinked=%d",
>>>   					__func__, urb, urb->unlinked);
>>> -				usb_hcd_unlink_urb_from_ep(hcd, urb);
>>> +				usb_hcd_unlink_urb_from_ep(urb);
>>>   				spin_unlock_irqrestore(&max3421_hcd->lock,
>>>   						       flags);
>>>   				usb_hcd_giveback_urb(hcd, urb, 0);
>>> @@ -1352,7 +1352,7 @@ max3421_urb_done(struct usb_hcd *hcd)
>>>   
>>>   		max3421_hcd->curr_urb = NULL;
>>>   		spin_lock_irqsave(&max3421_hcd->lock, flags);
>>> -		usb_hcd_unlink_urb_from_ep(hcd, urb);
>>> +		usb_hcd_unlink_urb_from_ep(urb);
>>>   		spin_unlock_irqrestore(&max3421_hcd->lock, flags);
>>>   
>>>   		/* must be called without the HCD spinlock: */
>>> diff --git a/drivers/usb/host/octeon-hcd.c b/drivers/usb/host/octeon-hcd.c
>>> index 19d5777f5db2..2f13b3e2475f 100644
>>> --- a/drivers/usb/host/octeon-hcd.c
>>> +++ b/drivers/usb/host/octeon-hcd.c
>>> @@ -2036,7 +2036,7 @@ static void octeon_usb_urb_complete_callback(struct octeon_hcd *usb,
>>>   		urb->status = -EPROTO;
>>>   		break;
>>>   	}
>>> -	usb_hcd_unlink_urb_from_ep(octeon_to_hcd(usb), urb);
>>> +	usb_hcd_unlink_urb_from_ep(urb);
>>>   	spin_unlock(&usb->lock);
>>>   	usb_hcd_giveback_urb(octeon_to_hcd(usb), urb, urb->status);
>>>   	spin_lock(&usb->lock);
>>> @@ -3161,7 +3161,7 @@ static int octeon_usb_urb_enqueue(struct usb_hcd *hcd,
>>>   					   >> 11) & 0x3,
>>>   					  split_device, split_port);
>>>   		if (!pipe) {
>>> -			usb_hcd_unlink_urb_from_ep(hcd, urb);
>>> +			usb_hcd_unlink_urb_from_ep(urb);
>>>   			spin_unlock_irqrestore(&usb->lock, flags);
>>>   			dev_dbg(dev, "Failed to create pipe\n");
>>>   			return -ENOMEM;
>>> @@ -3231,7 +3231,7 @@ static int octeon_usb_urb_enqueue(struct usb_hcd *hcd,
>>>   		break;
>>>   	}
>>>   	if (!transaction) {
>>> -		usb_hcd_unlink_urb_from_ep(hcd, urb);
>>> +		usb_hcd_unlink_urb_from_ep(urb);
>>>   		spin_unlock_irqrestore(&usb->lock, flags);
>>>   		dev_dbg(dev, "Failed to submit\n");
>>>   		return -ENOMEM;
>>> diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
>>> index 9b24181fee60..47f4b071322c 100644
>>> --- a/drivers/usb/host/ohci-hcd.c
>>> +++ b/drivers/usb/host/ohci-hcd.c
>>> @@ -226,7 +226,7 @@ static int ohci_urb_enqueue (
>>>   	if (ed->state == ED_IDLE) {
>>>   		retval = ed_schedule (ohci, ed);
>>>   		if (retval < 0) {
>>> -			usb_hcd_unlink_urb_from_ep(hcd, urb);
>>> +			usb_hcd_unlink_urb_from_ep(urb);
>>>   			goto fail;
>>>   		}
>>>   
>>> diff --git a/drivers/usb/host/ohci-q.c b/drivers/usb/host/ohci-q.c
>>> index 3b445312beea..ad96205510ef 100644
>>> --- a/drivers/usb/host/ohci-q.c
>>> +++ b/drivers/usb/host/ohci-q.c
>>> @@ -70,7 +70,7 @@ __acquires(ohci->lock)
>>>   	}
>>>   
>>>   	/* urb->complete() can reenter this HCD */
>>> -	usb_hcd_unlink_urb_from_ep(ohci_to_hcd(ohci), urb);
>>> +	usb_hcd_unlink_urb_from_ep(urb);
>>>   	spin_unlock (&ohci->lock);
>>>   	usb_hcd_giveback_urb(ohci_to_hcd(ohci), urb, status);
>>>   	spin_lock (&ohci->lock);
>>> diff --git a/drivers/usb/host/r8a66597-hcd.c b/drivers/usb/host/r8a66597-hcd.c
>>> index 6576515a29cd..3002e0b1442a 100644
>>> --- a/drivers/usb/host/r8a66597-hcd.c
>>> +++ b/drivers/usb/host/r8a66597-hcd.c
>>> @@ -823,7 +823,7 @@ __acquires(r8a66597->lock)
>>>   			flush_dcache_page(virt_to_page(ptr));
>>>   	}
>>>   
>>> -	usb_hcd_unlink_urb_from_ep(r8a66597_to_hcd(r8a66597), urb);
>>> +	usb_hcd_unlink_urb_from_ep(urb);
>>>   	spin_unlock(&r8a66597->lock);
>>>   	usb_hcd_giveback_urb(r8a66597_to_hcd(r8a66597), urb, status);
>>>   	spin_lock(&r8a66597->lock);
>>> @@ -1943,7 +1943,7 @@ static int r8a66597_urb_enqueue(struct usb_hcd *hcd,
>>>   
>>>   error:
>>>   	if (ret)
>>> -		usb_hcd_unlink_urb_from_ep(hcd, urb);
>>> +		usb_hcd_unlink_urb_from_ep(urb);
>>>   error_not_linked:
>>>   	spin_unlock_irqrestore(&r8a66597->lock, flags);
>>>   	return ret;
>>> diff --git a/drivers/usb/host/sl811-hcd.c b/drivers/usb/host/sl811-hcd.c
>>> index 92f2d1238448..2bb21437671c 100644
>>> --- a/drivers/usb/host/sl811-hcd.c
>>> +++ b/drivers/usb/host/sl811-hcd.c
>>> @@ -429,7 +429,7 @@ static void finish_request(
>>>   	if (usb_pipecontrol(urb->pipe))
>>>   		ep->nextpid = USB_PID_SETUP;
>>>   
>>> -	usb_hcd_unlink_urb_from_ep(sl811_to_hcd(sl811), urb);
>>> +	usb_hcd_unlink_urb_from_ep(urb);
>>>   	spin_unlock(&sl811->lock);
>>>   	usb_hcd_giveback_urb(sl811_to_hcd(sl811), urb, status);
>>>   	spin_lock(&sl811->lock);
>>> @@ -951,7 +951,7 @@ static int sl811h_urb_enqueue(
>>>   	sl811_write(sl811, SL11H_IRQ_ENABLE, sl811->irq_enable);
>>>   fail:
>>>   	if (retval)
>>> -		usb_hcd_unlink_urb_from_ep(hcd, urb);
>>> +		usb_hcd_unlink_urb_from_ep(urb);
>>>   fail_not_linked:
>>>   	spin_unlock_irqrestore(&sl811->lock, flags);
>>>   	return retval;
>>> diff --git a/drivers/usb/host/uhci-q.c b/drivers/usb/host/uhci-q.c
>>> index 35fcb826152c..7980bc666af1 100644
>>> --- a/drivers/usb/host/uhci-q.c
>>> +++ b/drivers/usb/host/uhci-q.c
>>> @@ -1472,7 +1472,7 @@ static int uhci_urb_enqueue(struct usb_hcd *hcd,
>>>   	uhci_free_urb_priv(uhci, urbp);
>>>   done:
>>>   	if (ret)
>>> -		usb_hcd_unlink_urb_from_ep(hcd, urb);
>>> +		usb_hcd_unlink_urb_from_ep(urb);
>>>   done_not_linked:
>>>   	spin_unlock_irqrestore(&uhci->lock, flags);
>>>   	return ret;
>>> @@ -1550,7 +1550,7 @@ __acquires(uhci->lock)
>>>   	}
>>>   
>>>   	uhci_free_urb_priv(uhci, urbp);
>>> -	usb_hcd_unlink_urb_from_ep(uhci_to_hcd(uhci), urb);
>>> +	usb_hcd_unlink_urb_from_ep(urb);
>>>   
>>>   	spin_unlock(&uhci->lock);
>>>   	usb_hcd_giveback_urb(uhci_to_hcd(uhci), urb, status);
>>> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
>>> index b6eb928e260f..4c3eb475147b 100644
>>> --- a/drivers/usb/host/xhci-ring.c
>>> +++ b/drivers/usb/host/xhci-ring.c
>>> @@ -775,7 +775,7 @@ static void xhci_giveback_urb_in_irq(struct xhci_hcd *xhci,
>>>   		}
>>>   	}
>>>   	xhci_urb_free_priv(urb_priv);
>>> -	usb_hcd_unlink_urb_from_ep(hcd, urb);
>>> +	usb_hcd_unlink_urb_from_ep(urb);
>>>   	trace_xhci_urb_giveback(urb);
>>>   	usb_hcd_giveback_urb(hcd, urb, status);
>>>   }
>>> @@ -4178,7 +4178,7 @@ static int xhci_queue_isoc_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
>>>   	ep_ring->enqueue = urb_priv->td[0].first_trb;
>>>   	ep_ring->enq_seg = urb_priv->td[0].start_seg;
>>>   	ep_ring->cycle_state = start_cycle;
>>> -	usb_hcd_unlink_urb_from_ep(bus_to_hcd(urb->dev->bus), urb);
>>> +	usb_hcd_unlink_urb_from_ep(urb);
>>>   	return ret;
>>>   }
>>>   
>>> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
>>> index 899c0effb5d3..780c2c89407e 100644
>>> --- a/drivers/usb/host/xhci.c
>>> +++ b/drivers/usb/host/xhci.c
>>> @@ -1789,7 +1789,7 @@ static int xhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
>>>   err_giveback:
>>>   	if (urb_priv)
>>>   		xhci_urb_free_priv(urb_priv);
>>> -	usb_hcd_unlink_urb_from_ep(hcd, urb);
>>> +	usb_hcd_unlink_urb_from_ep(urb);
>>>   	spin_unlock_irqrestore(&xhci->lock, flags);
>>>   	usb_hcd_giveback_urb(hcd, urb, -ESHUTDOWN);
>>>   	return ret;
>>> diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
>>> index bc4507781167..7d574b40af6a 100644
>>> --- a/drivers/usb/musb/musb_host.c
>>> +++ b/drivers/usb/musb/musb_host.c
>>> @@ -280,7 +280,7 @@ __acquires(musb->lock)
>>>   {
>>>   	trace_musb_urb_gb(musb, urb);
>>>   
>>> -	usb_hcd_unlink_urb_from_ep(musb->hcd, urb);
>>> +	usb_hcd_unlink_urb_from_ep(urb);
>>>   	spin_unlock(&musb->lock);
>>>   	usb_hcd_giveback_urb(musb->hcd, urb, status);
>>>   	spin_lock(&musb->lock);
>>> @@ -2157,7 +2157,7 @@ static int musb_urb_enqueue(
>>>   	qh = kzalloc(sizeof *qh, mem_flags);
>>>   	if (!qh) {
>>>   		spin_lock_irqsave(&musb->lock, flags);
>>> -		usb_hcd_unlink_urb_from_ep(hcd, urb);
>>> +		usb_hcd_unlink_urb_from_ep(urb);
>>>   		spin_unlock_irqrestore(&musb->lock, flags);
>>>   		return -ENOMEM;
>>>   	}
>>> @@ -2292,7 +2292,7 @@ static int musb_urb_enqueue(
>>>   done:
>>>   	if (ret != 0) {
>>>   		spin_lock_irqsave(&musb->lock, flags);
>>> -		usb_hcd_unlink_urb_from_ep(hcd, urb);
>>> +		usb_hcd_unlink_urb_from_ep(urb);
>>>   		spin_unlock_irqrestore(&musb->lock, flags);
>>>   		kfree(qh);
>>>   	}
>>> diff --git a/drivers/usb/renesas_usbhs/mod_host.c b/drivers/usb/renesas_usbhs/mod_host.c
>>> index ae54221011c3..a3646bace962 100644
>>> --- a/drivers/usb/renesas_usbhs/mod_host.c
>>> +++ b/drivers/usb/renesas_usbhs/mod_host.c
>>> @@ -652,7 +652,7 @@ static void usbhsh_queue_done(struct usbhs_priv *priv, struct usbhs_pkt *pkt)
>>>   
>>>   	usbhsh_pipe_detach(hpriv, usbhsh_ep_to_uep(urb->ep));
>>>   
>>> -	usb_hcd_unlink_urb_from_ep(hcd, urb);
>>> +	usb_hcd_unlink_urb_from_ep(urb);
>>>   	usb_hcd_giveback_urb(hcd, urb, status);
>>>   }
>>>   
>>> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
>>> index 8dac1edc74d4..a182ffa32c99 100644
>>> --- a/drivers/usb/usbip/vhci_hcd.c
>>> +++ b/drivers/usb/usbip/vhci_hcd.c
>>> @@ -806,7 +806,7 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
>>>   	return 0;
>>>   
>>>   no_need_xmit:
>>> -	usb_hcd_unlink_urb_from_ep(hcd, urb);
>>> +	usb_hcd_unlink_urb_from_ep(urb);
>>>   no_need_unlink:
>>>   	spin_unlock_irqrestore(&vhci->lock, flags);
>>>   	if (!ret) {
>>> @@ -912,7 +912,7 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
>>>   		 * vhci_rx will receive RET_UNLINK and give back the URB.
>>>   		 * Otherwise, we give back it here.
>>>   		 */
>>> -		usb_hcd_unlink_urb_from_ep(hcd, urb);
>>> +		usb_hcd_unlink_urb_from_ep(urb);
>>>   
>>>   		spin_unlock_irqrestore(&vhci->lock, flags);
>>>   		usb_hcd_giveback_urb(hcd, urb, urb->status);
>>> @@ -977,7 +977,7 @@ static void vhci_cleanup_unlink_list(struct vhci_device *vdev,
>>>   
>>>   		urb->status = -ENODEV;
>>>   
>>> -		usb_hcd_unlink_urb_from_ep(hcd, urb);
>>> +		usb_hcd_unlink_urb_from_ep(urb);
>>>   
>>>   		list_del(&unlink->list);
>>>   
>>> diff --git a/drivers/usb/usbip/vhci_rx.c b/drivers/usb/usbip/vhci_rx.c
>>> index 7f2d1c241559..236d0dd95d3b 100644
>>> --- a/drivers/usb/usbip/vhci_rx.c
>>> +++ b/drivers/usb/usbip/vhci_rx.c
>>> @@ -101,7 +101,7 @@ static void vhci_recv_ret_submit(struct vhci_device *vdev,
>>>   	usbip_dbg_vhci_rx("now giveback urb %u\n", pdu->base.seqnum);
>>>   
>>>   	spin_lock_irqsave(&vhci->lock, flags);
>>> -	usb_hcd_unlink_urb_from_ep(vhci_hcd_to_hcd(vhci_hcd), urb);
>>> +	usb_hcd_unlink_urb_from_ep(urb);
>>>   	spin_unlock_irqrestore(&vhci->lock, flags);
>>>   
>>>   	usb_hcd_giveback_urb(vhci_hcd_to_hcd(vhci_hcd), urb, urb->status);
>>> @@ -172,7 +172,7 @@ static void vhci_recv_ret_unlink(struct vhci_device *vdev,
>>>   		pr_info("urb->status %d\n", urb->status);
>>>   
>>>   		spin_lock_irqsave(&vhci->lock, flags);
>>> -		usb_hcd_unlink_urb_from_ep(vhci_hcd_to_hcd(vhci_hcd), urb);
>>> +		usb_hcd_unlink_urb_from_ep(urb);
>>>   		spin_unlock_irqrestore(&vhci->lock, flags);
>>>   
>>>   		usb_hcd_giveback_urb(vhci_hcd_to_hcd(vhci_hcd), urb, urb->status);
>>> diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
>>> index ac95e7c89df5..9a451658a779 100644
>>> --- a/include/linux/usb/hcd.h
>>> +++ b/include/linux/usb/hcd.h
>>> @@ -425,7 +425,7 @@ static inline bool hcd_uses_dma(struct usb_hcd *hcd)
>>>   extern int usb_hcd_link_urb_to_ep(struct usb_hcd *hcd, struct urb *urb);
>>>   extern int usb_hcd_check_unlink_urb(struct usb_hcd *hcd, struct urb *urb,
>>>   		int status);
>>> -extern void usb_hcd_unlink_urb_from_ep(struct usb_hcd *hcd, struct urb *urb);
>>> +extern void usb_hcd_unlink_urb_from_ep(struct urb *urb);
>>>   
>>>   extern int usb_hcd_submit_urb(struct urb *urb, gfp_t mem_flags);
>>>   extern int usb_hcd_unlink_urb(struct urb *urb, int status);
>>
>>thanks,
>>-- Shuah
> 

thanks,
-- Shuah

