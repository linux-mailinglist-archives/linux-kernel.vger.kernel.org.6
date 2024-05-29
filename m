Return-Path: <linux-kernel+bounces-193267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8198D2974
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 02:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09DFA1F2544C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 00:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3016415A49F;
	Wed, 29 May 2024 00:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SujxBDxU"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6220315957D
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 00:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716942831; cv=none; b=KmRGDb7vM4+5b/+y/+/VtLwFcYIglr/Mqgv0ggWluJVOfjsK+6lo1TyZe8tSNM/C2K85eAffIa0eeNaPojfN5qT1U3tzjawcCl5xQdB/gV04UdkAtY8oKBZuYL9fhSnxb6BNlRecQENbwe5B9wiV47T0nLsOE9yp4j8FHUTZ3kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716942831; c=relaxed/simple;
	bh=DnnR4m1p4oU4U6SccO/LeVG9lOdHFpIn9om0icQLd3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZgDt+RzdCK6pAcG4M1dmR0tyY1vjKbgAKDRoWyZAofa5Eh6U/+GVY8c37pBOnsv8thlr9sLFmG0Nq+peQqlG9gpVk2S/zFoEycSHFQt24VSTn7E5me4LJovA/gR4K1ExDEWItr2HeV3Jw55JaOwlEUaO0IyJtZS+wqmzGxofloo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SujxBDxU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f4a6a54416so2908005ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 17:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716942829; x=1717547629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZEoXkEUUAwl5YxPM26D+WgNJiJo07MgNYdTcPdzNMEE=;
        b=SujxBDxUi3M4wkfpRhLggafGcWPB2EHrdkBFl657HIInrTVpdj9Cot2U9Sr9JD/oSB
         0U5O4QO9DBjmn83zC3odp7p8RZN9JOu/Jt6PwLxB+yLhlet+8AKg1mxGuHS9tZM9NrjP
         nSjhRQIPOvkZQC2xgwi6swScqaNmmaj+2Wq72M2og9Xx19I4Y0/8X9MqJ60wTLBa6t9H
         UD3k5NmVskZPxulEePLct4lPY2Epbvu8/N249Ha5PulzqQB2wJzaovB4r2oHBqljYnfx
         UEqeGwA+gL3ZDIDJ5tZJGHjnPrjzTTdDH2pB3kENnfCNQXd6Hs5mg7e7oW7d4n746kg+
         NRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716942829; x=1717547629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEoXkEUUAwl5YxPM26D+WgNJiJo07MgNYdTcPdzNMEE=;
        b=lG7RhVY6KJ1Ip+BlpUQURYEsnYhOK3dKl9bAXu7VpSwW4K/L8ze31LP7vXrAu0KnNP
         8Afxdbib2ZkRN6/A/Jy5gOJJoC0A+sMnJTBUvHtoLNRpQl9+BK9vtIzCY3uH45GkBf8e
         hrzXJ30vqL0TO/jIQOqOXBSuYAN8ZFCFmjoxw3kSseFgMAp8p5V2KY3+NwxxktMJnGHI
         ywJz+soIZvbpWFYcEEgt2PM4aPh18Gg+GHee7UiXGHhwJE+tt5Nw3xWYKN2x55rwJU6r
         uE+IJ5Q8etlHee8MKVZ3xrm5klIreQf9zLtIRObSmlyvRvlMdnPjfsQpFJ5axBM1jm8l
         cKVQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+PH86rbE5TqEP8OrHqJatjGClcprLQ61pNNbzxY5GFwbEVWnofmb2xld+TGXIar/9r4obbgFlxN7BWGOksuwTcQGI2258xSIKYSNg
X-Gm-Message-State: AOJu0YzKJ9yvdh0pbLxDWtaQZWrKDkzHJb5BUbnAZ86vl05edjs4SxVC
	7D9Io0sL7qYsqBSQU5KoqivYIeUmI1vGbWz5fdg7RLOu9Pt8TbcOL48o3gOcwQ==
X-Google-Smtp-Source: AGHT+IGMG4IZrbeGjf0fVtb1fsD40Zt48ILPY0YEhyTQQVy/ubNjlBazTaLP/BgbOqPYwiU1sjCJgw==
X-Received: by 2002:a17:902:e5cf:b0:1f4:84e6:5a87 with SMTP id d9443c01a7336-1f4e9ea07damr9993335ad.9.1716942828183;
        Tue, 28 May 2024 17:33:48 -0700 (PDT)
Received: from [192.168.60.239] (213.126.145.34.bc.googleusercontent.com. [34.145.126.213])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c96f67fsm86723345ad.154.2024.05.28.17.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 17:33:47 -0700 (PDT)
Message-ID: <adabc6f5-1b87-4bbe-9070-984f0acc8e75@google.com>
Date: Tue, 28 May 2024 17:33:46 -0700
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
References: <ZkE-O0yJ33T9hWa0@pengutronix.de>
 <20240517014359.p2s44ypl4bix4odm@synopsys.com>
 <Zk03Ys1rA0I5yiZy@pengutronix.de>
 <20240522014132.xlf7azgq2urfff2d@synopsys.com>
 <3f404a27-50e8-42c5-a497-b46751154613@rowland.harvard.edu>
 <20240522171640.iuol4672rnklc35g@synopsys.com>
 <Zk4td_0RR0cMJKro@pengutronix.de>
 <f4f0b38a-1f8e-4cf5-8cf1-6da337a1c3c0@google.com>
 <ZlY88BebTEZs6urD@pengutronix.de>
 <0642b7a2-0982-4529-b742-3310f34d16b9@google.com>
 <ZlZeHLmKnw1mApKM@pengutronix.de>
Content-Language: en-US
From: Avichal Rakesh <arakesh@google.com>
In-Reply-To: <ZlZeHLmKnw1mApKM@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/28/24 15:43, Michael Grzeschik wrote:
> On Tue, May 28, 2024 at 02:27:34PM -0700, Avichal Rakesh wrote:
>>
>>
>> On 5/28/24 13:22, Michael Grzeschik wrote:
>>> On Tue, May 28, 2024 at 10:30:30AM -0700, Avichal Rakesh wrote:
>>>>
>>>>
>>>> On 5/22/24 10:37, Michael Grzeschik wrote:
>>>>> On Wed, May 22, 2024 at 05:17:02PM +0000, Thinh Nguyen wrote:
>>>>>> On Wed, May 22, 2024, Alan Stern wrote:
>>>>>>> On Wed, May 22, 2024 at 01:41:42AM +0000, Thinh Nguyen wrote:
>>>>>>> > On Wed, May 22, 2024, Michael Grzeschik wrote:
>>>>>>> > > On Fri, May 17, 2024 at 01:44:05AM +0000, Thinh Nguyen wrote:
>>>>>>> > > > For isoc endpoint IN, yes. If the host requests for isoc data IN while
>>>>>>> > > > no TRB is prepared, then the controller will automatically send 0-length
>>>>>>> > > > packet respond.
>>>>>>> > >
>>>>>>> > > Perfect! This will help a lot and will make active queueing of own
>>>>>>> > > zero-length requests run unnecessary.
>>>>>>> >
>>>>>>> > Yes, if we rely on the current start/stop isoc transfer scheme for UVC,
>>>>>>> > then this will work.
>>>>>>>
>>>>>>> You shouldn't rely on this behavior.  Other device controllers might not
>>>>>>> behave this way; they might send no packet at all to the host (causing a
>>>>>>> USB protocol error) instead of sending a zero-length packet.
>>>>>>
>>>>>> I agree. The dwc3 driver has this workaround to somewhat work with the
>>>>>> UVC. This behavior is not something the controller expected, and this
>>>>>> workaround should not be a common behavior for different function
>>>>>> driver/protocol. Since this behavior was added a long time ago, it will
>>>>>> remain the default behavior in dwc3 to avoid regression with UVC (at
>>>>>> least until the UVC is changed). However, it would be nice for UVC to
>>>>>> not rely on this.
>>>>>
>>>>> With "this" you mean exactly the following commit, right?
>>>>>
>>>>> (f5e46aa4 usb: dwc3: gadget: when the started list is empty stop the active xfer)
>>>>>
>>>>> When we start questioning this, then lets dig deeper here.
>>>>>
>>>>> With the fast datarate of at least usb superspeed shouldn't they not all
>>>>> completely work asynchronous with their in flight trbs?
>>>>>
>>>>> In my understanding this validates that, with at least superspeed we are
>>>>> unlikely to react fast enough to maintain a steady isoc dataflow, since
>>>>> the driver above has to react to errors in the processing context.
>>>>>
>>>>> This runs the above patch (f5e46aa4) a gadget independent solution
>>>>> which has nothing to do with uvc in particular IMHO.
>>>>>
>>>>> How do other controllers and their drivers work?
>>>>>
>>>>>> Side note, when the dwc3 driver reschedules/starts isoc transfer again,
>>>>>> the first transfer will be scheduled go out at some future interval and
>>>>>> not the next immediate microframe. For UVC, it probably won't be a
>>>>>> problem since it doesn't seem to need data going out every interval.
>>>>>
>>>>> It should not make a difference. [TM]
>>>>>
>>>>
>>>>
>>>> Sorry for being absent for a lot of this discussion.
>>>>
>>>> I want to take a step back from the details of how we're
>>>> solving the problem to what problems we're trying to solve.
>>>>
>>>> So, question(s) for Michael, because I don't see an explicit
>>>> answer in this thread (and my sincerest apologies if they've
>>>> been answered already and I missed it):
>>>>
>>>> What exactly is the bug (or bugs) we're trying to solve here?
>>>>
>>>> So far, it looks like there are two main problems being
>>>> discussed:
>>>>
>>>> 1. Reducing the bandwidth usage of individual usb_requests
>>>> 2. Error handling for when transmission over the wire fails.
>>>>
>>>> Is that correct, or are there other issues at play here?
>>>
>>> That is correct.
>>>
>>>> (1) in isolation should be relatively easy to solve: Just
>>>> smear the encoded frame across some percentage
>>>> (prefereably < 100%) of the usb_requests in one
>>>> video frame interval.
>>>
>>> Right.
>>>
>>>> (2) is more complicated, and your suggestion is to have a
>>>> sentinel request between two video frames that tells the
>>>> host if the transmission of "current" video frame was
>>>> successful or not. (Is that correct?)
>>>
>>> Right.
>>>
>>>> Assuming my understanding of (2) is correct, how should
>>>> the host behave if the transmission of the sentinel
>>>> request fails after the video frame was sent
>>>> successfully (isoc is best effort so transmission is
>>>> never guaranteed)?
>>>
>>> If we have transmitted all requests of the frame but would only miss the
>>> sentinel request to the host that includes the EOF, the host could
>>> rather show it or drop it. The drop would not be necessary since the
>>> host did see all data of the frame. The user would not see any
>>> distortion in both cases.
>>>
>>> If we have transmitted only partial data of the frame it would be
>>> preferred if the host would drop the frame that did not finish with an
>>> proper EOF tag.
>>>
>>> AFAIK the linux kernel would still show the frame if the FID of the
>>> currently handled request would change and would take this as the end of
>>> frame indication. But I am not totally sure if this is by spec or
>>> optional.
>>>
>>> One option to be totally sure would be to resend the sentinel request to
>>> be properly transmitted before starting the next frame. This resend
>>> polling would probably include some extra zero-length requests. But also
>>> if this resend keeps failing for n times, the driver should doubt there
>>> is anything sane going on with the USB connection and bail out somehow.
>>>
>>> Since we try to tackle case (1) to avoid transmit errors and also avoid
>>> creating late enqueued requests in the running isoc transfer, the over
>>> all chance to trigger missed transfers should be minimal.
>>
>> Gotcha. It seems like the UVC gadget driver implicitly assumes that EOF
>> flag will be used although the userspace application can technically
>> make it optional.
> 
> That is not all. The additional UVC_STREAM_ERR tag on the sentinel
> request can be set optional by the host driver. But by spec the
> userspace application has to drop the frame when the flag was set.

Looking at the UVC specs, the ERR bit doesn't seem to refer to actual 
transmission error, only errors in frame generation (Section 4.3.1.7 
of UVC 1.5 Class Specification). Maybe "data discontinuity" can be 
used but the examples given are bad media, and encoder issues, which
suggests errors at higher level than the wire.

> 
> With my proposal this flag will be set, whenever we find out that
> the currently transferred frame was erroneous.
> 
>> Summarizing some of the discussions above:
>> 1. UVC gadget driver should _not_ rely on the usb controller to
>>   enqueue 0-length requests on UVC gadget drivers behalf;
>> 2. However keeping up the backpressure to the controller means the
>>   EOF request will be delayed behind all the zero-length requests.
> 
> Exactly, this is why we have to somehow finetune the timedelay between
> requests that trigger interrupts. And also monitor the amount of
> requests currently enqueued in the hw ringbuffer. So that our drivers
> enqueue dequeue mechanism is virtually adding only the minimum amount
> of necessary zero-length requests in the hardware. This should be
> possible.
> 
> I am currently thinking through the remaining steps the pump worker has
> to do on each wakeup to maintain the minimum threshold while waiting
> with submitting requests that contain actual image payload.
> 
>> Out of curiosity: What is wrong with letting the host rely on
>> FID alone? Decoding the jpeg payload _should_ fail if any of the
>> usb_requests containing the payload failed to transmit.
> 
> This is not totally true. We saw partially rendered jpeg frames on the
> host stream. How the host behaves with broken data is totally undefined
> if the typical uvc flags EOF/ERR are not used as specified. Then think
> about uncompressed formats. So relying on the transferred image format
> to solve our problems is just as wrong as relying on the gadgets
> hardware behavior.

Do you know if the partially rendered frames were valid JPEGs, or 
if the host was simply making a best effort at displaying a broken
JPEG? Perhaps the fix should go to the host instead?

Following is my opinion, feel free to disagree (and correct me if 
something is factually incorrect):

The fundamental issue here is that ISOC doesn't guarantee
delivery of usb_requests or even basic data consistency upon delivery.
So the gadget driver has no way to know the state of transmitted data. 
The gadget driver is notified of underruns but not of any other issues,
and ideally we should never have an underrun if the zero-length 
backpressure is working as intended.

So, UVC gadget driver can reduce the number of errors, but it'll never be 
able to guarantee that the data transmitted to the host isn't somehow
corrupted or missing unless a more reliable mode of transmission 
(bulk, for example) is used.

All of this to say: The host absolutely needs to be able to handle
all sorts of invalid and broken payloads. How the host handles it 
might be undefined, but the host can never rely on perfect knowledge 
about the transmission state. In cases like these, where the underlying 
transport is unreliable, the burden of enforcing consistency moves up 
a layer, i.e. to the encoded payload in this case. So it is perfectly 
fine for the host to rely on the encoding to determine if the payload 
is corrupt and handle it accordingly.

As for uncompressed format, you're correct that subtle corruptions
may not be caught, but outright missing usb_requests can be easily
checked by simply looking at the number of bytes in the payload. YUV 
frames are all of the same (predetermined) size for a given resolution.

So my recommendation is the following:
1. Fix the bandwidth problem by splitting the encoded video frame
   into more usb_requests (as your patch already does) making sure 
   there are enough free usb_request to encode the video frame in 
   one burst so we don't accidentally inflate the transmission 
   duration of a video frame by sneaking in zero-length requests in
   the middle.
2. Unless there is an unusually high rate of transmission failures
   when using the UVC gadget driver, it might be worth fixing the
   host side driver to handle broken frames better instead (assuming 
   host is linux as well).
2. Tighten up the error checking in UVC gadget driver -- We drop the 
   current frame whenever an EXDEV happens which is wrong. We should 
   only be dropping the current frame if the EXDEV corresponds to the 
   frame currently being encoded. If the frame is already fully queued 
   to the usb controller, the host can handle missing payload as it 
   sees fit.


- Avi.

