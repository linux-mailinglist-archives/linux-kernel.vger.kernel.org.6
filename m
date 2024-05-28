Return-Path: <linux-kernel+bounces-193114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BF38D2705
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 23:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF3D28278B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85F817BB08;
	Tue, 28 May 2024 21:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zfk8zvpN"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B0417B432
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 21:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716931659; cv=none; b=FDK8x6aNmeAKrnyhhGyt4t82jbSzegdmCrbliSPE0+MvYgh+MpzYAeTmWOrDNCmzfaMXJxlp+ArQDvVoz7TStxB0BCqYWs2TkwuT12t1leyGw0lvJBVRjX86IlWOcfjkQZsSwFh8/XzSIDRZdF6TjIX7vi/5u8hYNYJEBOMOlGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716931659; c=relaxed/simple;
	bh=R4WiXUOZ6SlYfY4w744NdT1zsOVq7PiRX9/nU+mWjHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aT9dS5pot5O0n5RpM2NZL5Exq2cOsP14TyW7yQIN4dqg2oiShkgbMFfqojP0OsAy/kLdS/6YUsM8xnBRa5BrPQ2Eo1TC9a0J+TS2F/GjIE7W8O0H1xUR9k/Jpbs9CbmqRYWTYCHwWIovd7ebOzPTh8/3GADMWq2V6y3EP6Y5yZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zfk8zvpN; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f693fb0ad4so1102201b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716931657; x=1717536457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zhYBpb048Vv7F75xV5U9FayGuoc/70fRRb+jM4rD3Wo=;
        b=Zfk8zvpNR1ghYh7j7FCqSBIlyBtpM1XAgQJgXteyltxa+88CzPRaaJEYMdpTgKPz3p
         VHZPdQf9ZGM2vXaVPOwzl6tMZrP2vI/6thJHDDXLBcB3j/oLo/RLCXYlJAfqeF8OM46F
         h1kdHO6g3wcvjSZ7Ce360Z3IH7QLSofBcVI/BMJPT52EWioDKspT4JrEYURmGBHXV+jW
         sPoRvCwZeUYfSG7JAaPqSSU3nUZSY6M8S045sKNpftQOETPLlP4mk8PAdChJys/Gizhg
         r2+9+b3fukEqebSI+RQE5Y4aDw+Gd8KJAvaVeKSV9dRH68EjqbVf0L9z4v3aqId1Iz2G
         wPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716931657; x=1717536457;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zhYBpb048Vv7F75xV5U9FayGuoc/70fRRb+jM4rD3Wo=;
        b=C1ESa4qwsD/JGyX0URTqrB4U43JMe9IxJrFlCG9Zztsn9nCXggYvn0R4bqKIcT+fZa
         r8jU2/0p5yh0wF2+/RensT8Dlhlw8CqSS7pfU39tOCqko7EWnRm/xznbbZNJhx3utdOF
         CYH4jQLN/EZtD00gBUbYNVr+b0+sBrXIAxyoYOrJJ4+GLGbZnWYh+CuqvZ01Xo4unvCc
         bTWVeIwEJ+V9En3wjdbE2UziUAxR2mCXc89YW8cuX7p2t2lutxTTMeZdrAcNnY+smJWq
         5b0j+6SWOE0gqpzoyTKneqPbnxXVNyaIF7Awp/2JxJIdVxtOuJXVo/4HanM74rLPXqob
         OOJg==
X-Forwarded-Encrypted: i=1; AJvYcCWz1iiDJxuBZJUxwTKasJuFRXViPJA/fXrFqNKxM18D5V+0SriwDnipooxQmyxWe75ppg8ZZAu3cm4WI2ID5vml92omnncYRE9Nk7Ek
X-Gm-Message-State: AOJu0YyD1gsSpUmeEIY8NHams6BgTAiqdVSiVW7njJyzX2eniocE+u5m
	qvOjY/PeObdVWNp7RiL1+NLYgvw/8Q0vBxll+imvaEYeEm0BGt/29B1BiUKy3Q==
X-Google-Smtp-Source: AGHT+IEEEVJD/4Lf5v1lrXLD7t+d+3ac46rcbELmWzB+2oXYHDXT7T4yOJTMsqW8IWKsrM5ps+HSzQ==
X-Received: by 2002:a05:6a00:e0f:b0:6f8:b6a1:317d with SMTP id d2e1a72fcca58-6f8f4609413mr13008401b3a.34.1716931656518;
        Tue, 28 May 2024 14:27:36 -0700 (PDT)
Received: from [192.168.60.239] (213.126.145.34.bc.googleusercontent.com. [34.145.126.213])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-701adb02472sm2255144b3a.13.2024.05.28.14.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 14:27:36 -0700 (PDT)
Message-ID: <0642b7a2-0982-4529-b742-3310f34d16b9@google.com>
Date: Tue, 28 May 2024 14:27:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] usb: gadget: uvc: allocate requests based on frame
 interval length and buffersize
To: Michael Grzeschik <mgr@pengutronix.de>
Cc: Alan Stern <stern@rowland.harvard.edu>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Daniel Scally <dan.scally@ideasonboard.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jayant Chowdhary <jchowdhary@google.com>,
 "etalvala@google.com" <etalvala@google.com>,
 Michael Riesch <michael.riesch@wolfvision.net>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
References: <17192e0f-7f18-49ae-96fc-71054d46f74a@google.com>
 <20240424022806.uo73nwpeg63vexiv@synopsys.com>
 <ZkE-O0yJ33T9hWa0@pengutronix.de>
 <20240517014359.p2s44ypl4bix4odm@synopsys.com>
 <Zk03Ys1rA0I5yiZy@pengutronix.de>
 <20240522014132.xlf7azgq2urfff2d@synopsys.com>
 <3f404a27-50e8-42c5-a497-b46751154613@rowland.harvard.edu>
 <20240522171640.iuol4672rnklc35g@synopsys.com>
 <Zk4td_0RR0cMJKro@pengutronix.de>
 <f4f0b38a-1f8e-4cf5-8cf1-6da337a1c3c0@google.com>
 <ZlY88BebTEZs6urD@pengutronix.de>
Content-Language: en-US
From: Avichal Rakesh <arakesh@google.com>
In-Reply-To: <ZlY88BebTEZs6urD@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/28/24 13:22, Michael Grzeschik wrote:
> On Tue, May 28, 2024 at 10:30:30AM -0700, Avichal Rakesh wrote:
>>
>>
>> On 5/22/24 10:37, Michael Grzeschik wrote:
>>> On Wed, May 22, 2024 at 05:17:02PM +0000, Thinh Nguyen wrote:
>>>> On Wed, May 22, 2024, Alan Stern wrote:
>>>>> On Wed, May 22, 2024 at 01:41:42AM +0000, Thinh Nguyen wrote:
>>>>> > On Wed, May 22, 2024, Michael Grzeschik wrote:
>>>>> > > On Fri, May 17, 2024 at 01:44:05AM +0000, Thinh Nguyen wrote:
>>>>> > > > For isoc endpoint IN, yes. If the host requests for isoc data IN while
>>>>> > > > no TRB is prepared, then the controller will automatically send 0-length
>>>>> > > > packet respond.
>>>>> > >
>>>>> > > Perfect! This will help a lot and will make active queueing of own
>>>>> > > zero-length requests run unnecessary.
>>>>> >
>>>>> > Yes, if we rely on the current start/stop isoc transfer scheme for UVC,
>>>>> > then this will work.
>>>>>
>>>>> You shouldn't rely on this behavior.  Other device controllers might not
>>>>> behave this way; they might send no packet at all to the host (causing a
>>>>> USB protocol error) instead of sending a zero-length packet.
>>>>
>>>> I agree. The dwc3 driver has this workaround to somewhat work with the
>>>> UVC. This behavior is not something the controller expected, and this
>>>> workaround should not be a common behavior for different function
>>>> driver/protocol. Since this behavior was added a long time ago, it will
>>>> remain the default behavior in dwc3 to avoid regression with UVC (at
>>>> least until the UVC is changed). However, it would be nice for UVC to
>>>> not rely on this.
>>>
>>> With "this" you mean exactly the following commit, right?
>>>
>>> (f5e46aa4 usb: dwc3: gadget: when the started list is empty stop the active xfer)
>>>
>>> When we start questioning this, then lets dig deeper here.
>>>
>>> With the fast datarate of at least usb superspeed shouldn't they not all
>>> completely work asynchronous with their in flight trbs?
>>>
>>> In my understanding this validates that, with at least superspeed we are
>>> unlikely to react fast enough to maintain a steady isoc dataflow, since
>>> the driver above has to react to errors in the processing context.
>>>
>>> This runs the above patch (f5e46aa4) a gadget independent solution
>>> which has nothing to do with uvc in particular IMHO.
>>>
>>> How do other controllers and their drivers work?
>>>
>>>> Side note, when the dwc3 driver reschedules/starts isoc transfer again,
>>>> the first transfer will be scheduled go out at some future interval and
>>>> not the next immediate microframe. For UVC, it probably won't be a
>>>> problem since it doesn't seem to need data going out every interval.
>>>
>>> It should not make a difference. [TM]
>>>
>>
>>
>> Sorry for being absent for a lot of this discussion.
>>
>> I want to take a step back from the details of how we're
>> solving the problem to what problems we're trying to solve.
>>
>> So, question(s) for Michael, because I don't see an explicit
>> answer in this thread (and my sincerest apologies if they've
>> been answered already and I missed it):
>>
>> What exactly is the bug (or bugs) we're trying to solve here?
>>
>> So far, it looks like there are two main problems being
>> discussed:
>>
>> 1. Reducing the bandwidth usage of individual usb_requests
>> 2. Error handling for when transmission over the wire fails.
>>
>> Is that correct, or are there other issues at play here?
> 
> That is correct.
> 
>> (1) in isolation should be relatively easy to solve: Just
>> smear the encoded frame across some percentage
>> (prefereably < 100%) of the usb_requests in one
>> video frame interval.
> 
> Right.
> 
>> (2) is more complicated, and your suggestion is to have a
>> sentinel request between two video frames that tells the
>> host if the transmission of "current" video frame was
>> successful or not. (Is that correct?)
> 
> Right.
> 
>> Assuming my understanding of (2) is correct, how should
>> the host behave if the transmission of the sentinel
>> request fails after the video frame was sent
>> successfully (isoc is best effort so transmission is
>> never guaranteed)?
> 
> If we have transmitted all requests of the frame but would only miss the
> sentinel request to the host that includes the EOF, the host could
> rather show it or drop it. The drop would not be necessary since the
> host did see all data of the frame. The user would not see any
> distortion in both cases.
> 
> If we have transmitted only partial data of the frame it would be
> preferred if the host would drop the frame that did not finish with an
> proper EOF tag.
> 
> AFAIK the linux kernel would still show the frame if the FID of the
> currently handled request would change and would take this as the end of
> frame indication. But I am not totally sure if this is by spec or
> optional.
> 
> One option to be totally sure would be to resend the sentinel request to
> be properly transmitted before starting the next frame. This resend
> polling would probably include some extra zero-length requests. But also
> if this resend keeps failing for n times, the driver should doubt there
> is anything sane going on with the USB connection and bail out somehow.
> 
> Since we try to tackle case (1) to avoid transmit errors and also avoid
> creating late enqueued requests in the running isoc transfer, the over
> all chance to trigger missed transfers should be minimal.

Gotcha. It seems like the UVC gadget driver implicitly assumes that EOF 
flag will be used although the userspace application can technically 
make it optional.

Summarizing some of the discussions above: 
1. UVC gadget driver should _not_ rely on the usb controller to 
   enqueue 0-length requests on UVC gadget drivers behalf;
2. However keeping up the backpressure to the controller means the 
   EOF request will be delayed behind all the zero-length requests.

Out of curiosity: What is wrong with letting the host rely on 
FID alone? Decoding the jpeg payload _should_ fail if any of the 
usb_requests containing the payload failed to transmit.

Was there a situation where usb_requests were failing but jpeg
decoding succeeded  (i.e. the host was unaware of failure)? Looking at 
the error handling on the gadget driver side, I see there is space to 
improve it, but maybe we can do it in a way that doesn't add more time 
constraints!

- Avii.



