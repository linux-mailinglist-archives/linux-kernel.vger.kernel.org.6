Return-Path: <linux-kernel+bounces-201485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E818FBEF7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13AC0286272
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 22:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36EB3BBF2;
	Tue,  4 Jun 2024 22:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0vYPZsne"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8E0142634
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 22:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717540340; cv=none; b=LLTK6n2B56uY1e2P4Mu2UyDh2KpKK6QtWBXXp9cIg5mCAz4wjBsTmV0QB62e7wHCw9Q9K5c3bOKEI2nK6D3Hhz1HmmdgjL6FZS6t73cSZ6+gy///PZLCCh52g3oV3lX6dKrhymj3TBfESi5PMWTqNfZ8e336hAGAHeuoPyX2GQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717540340; c=relaxed/simple;
	bh=AsKB6DPmRmGCoakcfG6rcKKrmELOS0mxPRiLIBXDxiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PYUV44tHQoloBNvjazhGmUMpfi4Kxabn9oRMdjs0796szdxe0OADp7reKR+/+AQppFG93pRGwP17KGQAuxSUlebel8AEw9st2nwEv4OWwzeP3Qx6PAJWh+QNqA7HHy5GSRCcSZ6veMYeWHd8ARpUaOlx88ElmjinxCKGdq/Ny7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0vYPZsne; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-701ae8698d8so4633180b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 15:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717540338; x=1718145138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eOcZRUFo+Zg79q4b2VwYjnq6VvA9LjCrSMhI7zwKOLc=;
        b=0vYPZsneGOIyBS+5Q+yUgxpHnwdlVSW35Due530aQBM8LDaDLHeih8O9cXB/ViAbad
         BVb3H+7YIYTvYYiMD6rZkh+k5Lspzxy5U4GSAISKi1GausGHzy7fCrjY6hIrmzrODn1U
         TSprS4Zz4niEXYu/NH50X/anwxRDjRFPsaSjdWaq4FqKuJcXOCKO59XETPyYhIGuImrH
         2NGJlzSQMvcK3S+/JNW2MYXGe70wepFnDpkzQxk1zf4/BoA2xUJ8PdO9/3L43DATsle4
         YBjG1b/uQA6ZvtD6vS5monF8P6IHMydyRSOmbxhdtHJbROzo8y+zPz/QMtOzDC82YqKa
         OahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717540338; x=1718145138;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eOcZRUFo+Zg79q4b2VwYjnq6VvA9LjCrSMhI7zwKOLc=;
        b=WtKhX3R9XXz6D0xb6l5JwPV31+Y9tg1qeVJkGugnyqEhbZ7YYodb+q0FpvOFY10I59
         ZD10+q/VbxPTxg0t9adhgAiQjiK0nBXJoTs1+a2xHcldz6c3/aUChqPJswpX9XqJyeW3
         AM1t9wukgGZ3wxul+PbXmmFRxpIDFczaZNQr9kZFQGEPsL6O3BxrKcZOPFK5Vp6PIgDK
         TJRg8JbaOnH6/3v9Dtz9Eh8MB+A5boWReVzI55IsQTjlSkN2MhehjQ4MbSI2BR8qpd33
         BJAPF6k1tV7QLeqHOS6EdXvu9T55ify04xfG1K17pFrYoSsQDJ/DD17jLJp7URy6h4Oe
         Y6UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk5edDr9L6QavzgUfvU5Fv4EDLQeM2IFZ4L2LaW39qFfgvBYDdkt3Gl5c0HW7XaIxnjk/7cSoq4+zbH9TrnkvG8EAQME8r7tzEHH7i
X-Gm-Message-State: AOJu0YwgcYnZ0YxqVZdz7kiLSq5q/4GemQCtZ1EEitsR1K6MOTZ1jCyI
	eRluln609HappugkpXRsxlQbm/NC0oVNdSI3okBfsX8QY+IqZdCLoC5bjvhrwA==
X-Google-Smtp-Source: AGHT+IHUk3udE+fZnFkbvaq+nAn6iapJhfQlFosMCRZi4PqIZSI1W8StjCpNIa99B4EhExbHG/V5FA==
X-Received: by 2002:a05:6a00:23ca:b0:6f8:caf2:eead with SMTP id d2e1a72fcca58-703e59e4ba5mr820051b3a.22.1717540337911;
        Tue, 04 Jun 2024 15:32:17 -0700 (PDT)
Received: from [192.168.60.239] (213.126.145.34.bc.googleusercontent.com. [34.145.126.213])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242c245absm7477337b3a.200.2024.06.04.15.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 15:32:17 -0700 (PDT)
Message-ID: <6b0421e0-8c5a-409b-8f34-3a041c838748@google.com>
Date: Tue, 4 Jun 2024 15:32:15 -0700
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
References: <Zk03Ys1rA0I5yiZy@pengutronix.de>
 <20240522014132.xlf7azgq2urfff2d@synopsys.com>
 <3f404a27-50e8-42c5-a497-b46751154613@rowland.harvard.edu>
 <20240522171640.iuol4672rnklc35g@synopsys.com>
 <Zk4td_0RR0cMJKro@pengutronix.de>
 <f4f0b38a-1f8e-4cf5-8cf1-6da337a1c3c0@google.com>
 <ZlY88BebTEZs6urD@pengutronix.de>
 <0642b7a2-0982-4529-b742-3310f34d16b9@google.com>
 <ZlZeHLmKnw1mApKM@pengutronix.de>
 <adabc6f5-1b87-4bbe-9070-984f0acc8e75@google.com>
 <ZledAuxYrxZlJ0ow@pengutronix.de>
Content-Language: en-US
From: Avichal Rakesh <arakesh@google.com>
In-Reply-To: <ZledAuxYrxZlJ0ow@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/29/24 14:24, Michael Grzeschik wrote:
> On Tue, May 28, 2024 at 05:33:46PM -0700, Avichal Rakesh wrote:
>>
>>
>> On 5/28/24 15:43, Michael Grzeschik wrote:
>>> On Tue, May 28, 2024 at 02:27:34PM -0700, Avichal Rakesh wrote:
>>>>
>>>>
>>>> On 5/28/24 13:22, Michael Grzeschik wrote:
>>>>> On Tue, May 28, 2024 at 10:30:30AM -0700, Avichal Rakesh wrote:
>>>>>>
>>>>>>
>>>>>> On 5/22/24 10:37, Michael Grzeschik wrote:
>>>>>>> On Wed, May 22, 2024 at 05:17:02PM +0000, Thinh Nguyen wrote:
>>>>> One option to be totally sure would be to resend the sentinel request to
>>>>> be properly transmitted before starting the next frame. This resend
>>>>> polling would probably include some extra zero-length requests. But also
>>>>> if this resend keeps failing for n times, the driver should doubt there
>>>>> is anything sane going on with the USB connection and bail out somehow.
>>>>>
>>>>> Since we try to tackle case (1) to avoid transmit errors and also avoid
>>>>> creating late enqueued requests in the running isoc transfer, the over
>>>>> all chance to trigger missed transfers should be minimal.
>>>>
>>>> Gotcha. It seems like the UVC gadget driver implicitly assumes that EOF
>>>> flag will be used although the userspace application can technically
>>>> make it optional.
>>>
>>> That is not all. The additional UVC_STREAM_ERR tag on the sentinel
>>> request can be set optional by the host driver. But by spec the
>>> userspace application has to drop the frame when the flag was set.
>>
>> Looking at the UVC specs, the ERR bit doesn't seem to refer to actual
>> transmission error, only errors in frame generation (Section 4.3.1.7
>> of UVC 1.5 Class Specification). Maybe "data discontinuity" can be
>> used but the examples given are bad media, and encoder issues, which
>> suggests errors at higher level than the wire.
> 
> Oh! That is a new perspective I did not consider.
> 
> With the definition of UVC_STREAM_ERR by spec, the uvc_video driver
> would in no case set this header bit for the current frame on its own?
> Is that correct?

It would indeed seem so. The way gadget driver is architected makes 
is impossible for the userspace application to notify the host of 
any errors.

> 
>>> With my proposal this flag will be set, whenever we find out that
>>> the currently transferred frame was erroneous.
>>>
>>>> Summarizing some of the discussions above:
>>>> 1. UVC gadget driver should _not_ rely on the usb controller to
>>>>   enqueue 0-length requests on UVC gadget drivers behalf;
>>>> 2. However keeping up the backpressure to the controller means the
>>>>   EOF request will be delayed behind all the zero-length requests.
>>>
>>> Exactly, this is why we have to somehow finetune the timedelay between
>>> requests that trigger interrupts. And also monitor the amount of
>>> requests currently enqueued in the hw ringbuffer. So that our drivers
>>> enqueue dequeue mechanism is virtually adding only the minimum amount
>>> of necessary zero-length requests in the hardware. This should be
>>> possible.
>>>
>>> I am currently thinking through the remaining steps the pump worker has
>>> to do on each wakeup to maintain the minimum threshold while waiting
>>> with submitting requests that contain actual image payload.
>>>
>>>> Out of curiosity: What is wrong with letting the host rely on
>>>> FID alone? Decoding the jpeg payload _should_ fail if any of the
>>>> usb_requests containing the payload failed to transmit.
>>>
>>> This is not totally true. We saw partially rendered jpeg frames on the
>>> host stream. How the host behaves with broken data is totally undefined
>>> if the typical uvc flags EOF/ERR are not used as specified. Then think
>>> about uncompressed formats. So relying on the transferred image format
>>> to solve our problems is just as wrong as relying on the gadgets
>>> hardware behavior.
>>
>> Do you know if the partially rendered frames were valid JPEGs, or
>> if the host was simply making a best effort at displaying a broken
>> JPEG? Perhaps the fix should go to the host instead?
> 
> I can fully reproduce this with linux and windows hosts. For linux
> machines I saw that the host was taking the FID change as a marker
> to see the previous frame as ready and just rendered what got through.
> This did not lead to garbage but only to partially displayed frames
> with jpeg macroblock alignment.

I was aware of linux doing so, but I only ever saw this behavior on 
Windows if there were a lot of invalid frames back to back.

I am not super familiar with the guarantees of JPEG, but I suppose 
it is possible to have a "valid" JPEG with some middle blocks
missing as long the EOI bits make it through? I am not sure how we 
go about solving that.

> 
>> Following is my opinion, feel free to disagree (and correct me if
>> something is factually incorrect):
>>
>> The fundamental issue here is that ISOC doesn't guarantee
>> delivery of usb_requests or even basic data consistency upon delivery.
>> So the gadget driver has no way to know the state of transmitted data.
>> The gadget driver is notified of underruns but not of any other issues,
>> and ideally we should never have an underrun if the zero-length
>> backpressure is working as intended.
>>
>> So, UVC gadget driver can reduce the number of errors, but it'll never be
>> able to guarantee that the data transmitted to the host isn't somehow
>> corrupted or missing unless a more reliable mode of transmission
>> (bulk, for example) is used.
>>
>> All of this to say: The host absolutely needs to be able to handle
>> all sorts of invalid and broken payloads. How the host handles it
>> might be undefined, but the host can never rely on perfect knowledge
>> about the transmission state. In cases like these, where the underlying
>> transport is unreliable, the burden of enforcing consistency moves up
>> a layer, i.e. to the encoded payload in this case. So it is perfectly
>> fine for the host to rely on the encoding to determine if the payload
>> is corrupt and handle it accordingly.
> 
> Right.
> 
>> As for uncompressed format, you're correct that subtle corruptions
>> may not be caught, but outright missing usb_requests can be easily
>> checked by simply looking at the number of bytes in the payload. YUV
>> frames are all of the same (predetermined) size for a given resolution.
> 
> That was also my thought about five minutes after I did send you the
> previous mail. So sure, this is no real issue for the host.
> 
>> So my recommendation is the following:
>> 1. Fix the bandwidth problem by splitting the encoded video frame
>>   into more usb_requests (as your patch already does) making sure
>>   there are enough free usb_request to encode the video frame in
>>   one burst so we don't accidentally inflate the transmission
>>   duration of a video frame by sneaking in zero-length requests in
>>   the middle.
> 
> Ack. This should already solve a lot of issues.
> 
> For this I would still suggest to move the usb_ep_queue to be done in
> the pump worker again. Its a bit back and forth, but IMHO its worth the
> extra mile since only this way we would respect the dwc3 interrupt
> threads assumption to run *very* short.

The main reason for queuing the requests from the complete handler
was to have a single point of usb_ep_queue call, which made reasoning 
through the locking simpler. But if you find a way to do so from 
the video_pump thread without making the locking a nightmare, then go
for it!

> 
>> 2. Unless there is an unusually high rate of transmission failures
>>   when using the UVC gadget driver, it might be worth fixing the
>>   host side driver to handle broken frames better instead (assuming
>>   host is linux as well).
> 
> Agreed, but this needs a separate scoped undestanding of the host side
> behaviour over all layers.

Agreed!

> 
>> 2. Tighten up the error checking in UVC gadget driver -- We drop the
>>   current frame whenever an EXDEV happens which is wrong. We should
>>   only be dropping the current frame if the EXDEV corresponds to the
>>   frame currently being encoded.
> 
> What do you mean by drop?
> 
> I would suggest to immediatly switch the uvc_buffer that is being
> enqueued and start queueing prepared requests from the next buffers prep
> list. As suggested, the idea is to have per uvc_buffer prep_list
> requests which would make this task easy.

Currently, if uvc gadget driver receives an EXDEV complete callback
all it does is set the UVC_QUEUE_DROP_INCOMPLETE flag.

So let's say that we receive an EXDEV for a usb_request containing data
for video frame N. With how video_pump is currently configured, chances 
are that all usb_requests containing data for video frame N has already 
been queued to the controller. 

When the next video frame (N+1) comes in, video_pump's encode methods 
will look at the UVC_QUEUE_DROP_INCOMPLETE flag and incorrectly 
determine that "current" frame needs to be dropped, and stop encoding
video frame N+1 even though the error was for video frame N. So the
encode methods incorrectly drop video frame N+1 which isn't needed. 

The encode methods should only be dropping the video frame if we 
received an EXDEV for a usb_request for the video frame currently 
being encoded. 

I hope that makes sense!


- Avi.

