Return-Path: <linux-kernel+bounces-420974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 266C89D84FE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B89163D9B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3F519CC3C;
	Mon, 25 Nov 2024 12:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WI0s+ISo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA29A194147
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 12:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732536083; cv=none; b=VZnx60SW4mp3l4/jTDihTsBiUxiKDF34YghIvU/GPzToITrbUNJMZVb3Z9bHVTHuS3mmcvLAXY0SJ4YGQeEBq8OyM/IjjBL8JxyM0o+dl1vsfLF0b23X7ie9ahwxnGdrQqfIVoiedaHKvrKK0PKdeWC7fTZAy/J8qrW4uTs22TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732536083; c=relaxed/simple;
	bh=rq/QlzFDIGffkw0Gc9yZwZeU9yXV7YcmkA9nouffMKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qo0iUlLWafwwrmgpREwU2AK6sgUosWlnW2iGSj6U+ODVCwZowM0LXudUNLSMMKrr9IENjBtlwz9KxVA+i01zZeL0BjEZ4YigV4FODBw+Iz8Vne3ywVZS6iXQPL4bWioStKR/f8R8ZvSYRa+rwyoGkyzUdkwo/va2tzmNEyUHBE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WI0s+ISo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732536080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZbMHM28le5Gro1fRhwOYLLQOzozUBhSWnlpT3fY81Uw=;
	b=WI0s+ISo1gKyjIWsLLAQ3P2yWFvNqYAUl9vw6FItok7c3c6EYD73J9+Wx3sZClkyB4Rcnj
	rlLpeA9mvzqbwyowfvplNwtyQfP0v2yg6PRTUVXahI1i+cbQ17cPHETGosohZ66fN436Uq
	bBQbcLJGXIrVGeONvEZ54Ej/TJcs2wQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-ZbIm4nmJMG-zHJ5TFKOrmA-1; Mon, 25 Nov 2024 07:01:18 -0500
X-MC-Unique: ZbIm4nmJMG-zHJ5TFKOrmA-1
X-Mimecast-MFC-AGG-ID: ZbIm4nmJMG-zHJ5TFKOrmA
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aa52b4b6962so181578566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 04:01:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732536077; x=1733140877;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbMHM28le5Gro1fRhwOYLLQOzozUBhSWnlpT3fY81Uw=;
        b=hjkSqayZ3nDFsU3iq4Gnk1NRzx7GIX0DhS/qQL8KfVjXXbv86EL448Q44eEGQeZdyZ
         YHR3a2TQwVb2PyzOzYreXHgI8L0mDd1bu61wOVpGag+WLzTeEy3hN8nBJMpXqhfNCKpM
         3VaXxlpV7XNpJX8VZfrXLp2N7fJEDpzGJykgqrDXB7iumo+kYFkGZFTR1v6KoiLjafLw
         YhNGFT+9+yU4EKdnKurGZauMpbDowgprDv7gkKGSd3jFSJll3cxP2cPlu1gWlS9sKBdT
         GucOrLYqr2ChzCR7uaKoXkfY0f8FdkE1/nqRnsDKJhb66o5tktxAkxmhk1YR3FAnY+eS
         QtaA==
X-Forwarded-Encrypted: i=1; AJvYcCX7BBTH95ivOfYQ6eTgLODGn/3hUrSyjKTtzAdzRm2pjHqSBm2G+MXOKOs+uqoKiEsnnbZKJNocNUrwNCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+c/1r1yG5bGBqbhCJTFDFEX+6G3lMQl/veU1xdcJdek559+SQ
	D3phmygJ08W2L2wk9+rr4y+MFDq+m4F0UAyr4dr8RBIJSw6eVyArauuQXBHO4NZrUT2YbOtm4IC
	OIGYOBQpB107hin+pC75cbvs1jk8czZBteFlhBQbMfLKXkM1ckdVdQ/S12bN2tQ==
X-Gm-Gg: ASbGncuBn5jbOM2bykx7cMWVjpkQ9wIoyY/Xjiwi1mB0UHTiQFRAIfeRKeIRiEZJUD7
	ZZsUp6AKKGwHnE9+w7K1y+yhBL+w478bdwdAiXbFBpNzgM8VvF/jhWWIRv/yn174o9YOEpq9Tic
	9IkX5x85Mwe2TM9fBTcA8N3k2N4bUbjOlD0SHTtVfUQ/BJV1budEB2oEq1JYy9/mBbR46PhTuIj
	54JmzgIx2ke19+CZC/TiecwqRAzQkYqPPdpr3C0aMAe6bTiVBtdQc9EcBpc7cFKCjCWK3jDGQgo
	S8eHxess34HVL7qBwxLujhQBGdHTlB1qzSXbXLd3wOS5ADXnkQaxN0uQFsll75mnb4IPi/4gE5O
	QtQPPnQc0RtQXxWsSm1ATphpQ
X-Received: by 2002:a17:907:7711:b0:aa5:2ef2:58bb with SMTP id a640c23a62f3a-aa52ef259acmr782847766b.0.1732536076490;
        Mon, 25 Nov 2024 04:01:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENaOquYvMBq9Yn3uAZYbeCNhSkN6l6RqHbHKRagSZZ9ac48TpmkIt30DiREmHNS8W2KRtokA==
X-Received: by 2002:a17:907:7711:b0:aa5:2ef2:58bb with SMTP id a640c23a62f3a-aa52ef259acmr782845066b.0.1732536076017;
        Mon, 25 Nov 2024 04:01:16 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b5b764asm454083966b.175.2024.11.25.04.01.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 04:01:15 -0800 (PST)
Message-ID: <5a199058-edab-4f9d-9e09-52305824f3bf@redhat.com>
Date: Mon, 25 Nov 2024 13:01:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] media: uvcvideo: Implement the Privacy GPIO as a
 evdev
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Armin Wolf <W_Armin@gmx.de>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 Yunke Cao <yunkec@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 stable@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>
References: <20241112-uvc-subdev-v3-0-0ea573d41a18@chromium.org>
 <bd68178f-1de9-491f-8209-f67065d29283@redhat.com>
 <CANiDSCtjpPG3XzaEOEeczZWO5gL-V_sj_Fv5=w82D6zKC9hnpw@mail.gmail.com>
 <20241114230630.GE31681@pendragon.ideasonboard.com>
 <CANiDSCt_bQ=E1fkpH1SAft1UXiHc2WYZgKDa8sr5fggrd7aiJg@mail.gmail.com>
 <d0dd293e-550b-4377-8a73-90bcfe8c2386@redhat.com>
 <CANiDSCvS1qEfS9oY=R05YhdRQJZmAjDCxVXxfVO4-=v4W1jTDg@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CANiDSCvS1qEfS9oY=R05YhdRQJZmAjDCxVXxfVO4-=v4W1jTDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ricardo,

On 18-Nov-24 5:47 PM, Ricardo Ribalda wrote:
> Hi Hans
> 
> On Mon, 18 Nov 2024 at 16:43, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi All,
>>
>> On 15-Nov-24 9:20 AM, Ricardo Ribalda wrote:
>>> On Fri, 15 Nov 2024 at 00:06, Laurent Pinchart
>>> <laurent.pinchart@ideasonboard.com> wrote:

<snip>

>>>> How do you handle cameras that suffer from
>>>> UVC_QUIRK_PRIVACY_DURING_STREAM ?
>>>
>>> For those b) does not work.
>>
>> I already suspected as much, but it is good to have this
>> confirmed.
>>
>> I'm afraid that from a userspace API pov cameras with a GPIO
>> which only works when powered-on need to be treated the same as
>> cameras which only have UVC_CT_PRIVACY_CONTROL IOW in this case
>> keep exporting V4L2_CID_PRIVACY instead of switching to evdev
>> with SW_CAMERA_LENS_COVER.
>>
>> Unfortunately this will make the GPIO handling code in the UVC
>> driver somewhat more involved since now we have both uAPI-s for
>> GPIOs depending on UVC_QUIRK_PRIVACY_DURING_STREAM.
>>
>> But I think that this makes sense, this way we end up offering
>> 2 uAPIs depending on the hw capabilities:
>>
>> 1. evdev with SW_CAMERA_LENS_COVER which always reports a reliable
>> state + events on the state changing without needing to power-up
>> the camera.
>>
>> 2. V4L2_CID_PRIVACY for the case where the camera needs to be
>> powered-on (/dev/video opened) and where the ctrl possibly needs
>> to be polled.
>>
>> Assuming we can all agree on this split based on hw capabilities
>> I think that we must document this somewhere in the media subsystem
>> documentation. We can then also write down there that
>> SW_CAMERA_LENS_COVER only applies to internal cameras.
> 
> I do not think that it is worth it to keep UVC_CT_PRIVACY_CONTROL for
> the two devices that have connected the GPIO's pull up to the wrong
> power rail.
> Now that the GPIO can be used from userspace, I expect that those
> errors will be found early in the design process and never reach
> production stage.
> 
> 
> If we use UVC_CT_PRIVACY_CONTROL for thes two devices:
> - userspace will have to implement two different APIs
> - the driver will have to duplicate the code.
> - all that code will be very difficult to test: there are only 2
> devices affected and it requires manual intervention to properly test
> it.
> 
> I think that UVC_QUIRK_PRIVACY_DURING_STREAM is a good compromise and
> the main user handles it properly.

Ok, as you wish. Lets go with using SW_CAMERA_LENS_COVER for the 2 models with
UVC_QUIRK_PRIVACY_DURING_STREAM too.

<snip>

>>>> Is there any ACPI- or WMI-provided information that could assist with
>>>> associating a privacy GPIO with a camera ?

I just realized I did not answer this question from Laurent
in my previous reply.

No unfortunately there is no ACPI- or WMI-provided information that
could assist with associating ACPI/WMI camera privacy controls with
a specific camera. Note that these are typically not exposed as a GPIO,
but rather as some vendor firmware interface.

Thinking more about this I'm starting to believe more and more
that the privacy-control stuff should be handled by libcamera
and then specifically by the pipeline-handler, with some helper
code to share functionality where possible.

E.g. on IPU6 equipped Windows laptops there may be some ACPI/WMI
driver which provides a /dev/input/event# SW_CAMERA_LENS_COVER node.

So I would expect the IPU6 pipeline-handler to search for such a
/dev/input/event# node and then expose that to users of the camera
through a to-be-defined API (I'm thinking a read-only control).

The code to find the event node can be shared, because this would
e.g. likely also apply to some IPU3 designs as well as upcoming
IPU7 designs.

<snip>

>>>> We could include the evdev in the MC graph. That will of course only be
>>>> possible if the kernel knows about that association in the first place.
>>>> At least the 1st category of devices would benefit from this.
>>
>> Yes I was thinking about adding a link to the MC graph for this too.
>>
>> Ricardo I notice that in this v3 series you still create a v4l2-subdev
>> for the GPIO handling and then add an ancillary link for the GPIO subdev
>> to the mc-graph. But I'm not sure how that is helpful. Userspace would
>> still need to do parent matching, but then match the evdev parent to
>> the subdev after getting the subdev from the mc. In that case it might
>> as well look at the physical (USB-interface) parent of the MC/video
>> node and do parent matching on that avoiding the need to go through
>> the MC at all.
>>
>> I think using the MC could still be useful by adding a new type of
>> ancillary link to the MC API which provides a file-path as info to
>> userspace rather then a mc-link and then just directly provide
>> the /dev/input/event# path through this new API?
>>
>> I guess that extending the MC API like this might be a bit of
>> a discussion. But it would already make sense to have this for
>> the existing input device for the snapshot button.
> 
> The driver creates a v4l2-subdevice for every entity, and the gpio
> today is modeled as an entity.

Ok I see that explains why the subdevice is there, thank you.

> The patchset just adds an ancillary link as Sakari suggested.
> I am not against removing the gpio entity all together if it is not needed.

Right unlike other entities which are really part of the UVC
specification, the GPIO is not a "real" UVC entity.

So I wonder if, after switching to SW_CAMERA_LENS_COVER, having
this as a v4l2-subdevice buys us anything ? If not I think removing
it might be a good idea.

As for the ancillary link, that was useful to have when the API
was a v4l2-ctrl on the subdevice. Just like I doubt if having
the subdevice at all gives us any added value, I also doubt if
having the ancillary link gives us any added value.

> Now that we are brainstorming here... what about adding a control that
> contains the name of the input device (eventX)? Is that a horrible
> idea?

I don't know, my initial reaction is that does not feel right to me.

>>>>>> We can specify
>>>>>> that SW_CAMERA_LENS_COVER only applies to device internal
>>>>>> cameras, but then it is up to userspace to determine which
>>>>>> cameras that are.
>>>>>
>>>>> I am working on wiring up this to userspace right now.. I will report
>>>>> back if it cannot do it.
>>
>> Ricardo, great, thank you!

Ricardo, any status update on this ?

<snip>

>>>> Assuming the kernel could report the association between an evdev and
>>>> camera, we would need to report which evdev SW_CAMERA_LENS_COVER
>>>> originates from all the way from the evdev to the consumer of the event.
>>>> How well is that supported in standard Linux system architectures ? If
>>>> I'm not mistaken libinput will report the originating device, but how
>>>> far up the stack is it propagated ? And which component would we expect
>>>> to consume those events, should the camera evdev be managed by e.g.
>>>> libcamera ?
>>
>> Good questions. Looking back at our 2 primary use-cases:
>>
>> a) Having an app which is using (trying to use) the camera show
>> a notification to the user that the camera is turned-off by
>> a privacy switch .
>>
>> b) Showing on on-screen-display (OSD) with a camera /
>> crossed-out-camera icon when the switch is toggled, similar to how
>> muting speakers/mic show an OSD . Laptop vendor Windows add-on
>> software does this and I know that some users have been asking
>> for this.
>>
>> I think we have everything to do b) in current compositors
>> like gnome-shell. Using an evdev with SW_CAMERA_LENS_COVER
>> would even be a lot easier for b) then the current
>> V4L2_CID_PRIVACY API.
>>
>> a) though is a lot harder. We could open up access to
>> the relevant /dev/input/event# node using a udev uaccess
>> tag so that users who can access /dev/video# nodes also
>> get raw access to that /dev/input/event# node and then
>> libcamera could indeed provide this information that way.
>> I think that is probably the best option.
>>
>> At least for the cases where the camera on/off switch
>> does not simply make the camera completely disappear.
>>
>> That case is harder. atm that case is not handled at all
>> though. So even just getting b) to work for that case
>> would be nice / an improvement.
>>
>> Eventually if we give libcamera access to event#
>> nodes which advertise SW_CAMERA_LENS_COVER (and no other
>> privacy sensitive information) then libcamera could even
>> separately offer some API for apps to just get that value
>> if there is no camera to associate it with.
>>
>> Actually thinking more about it libcamera probably might
>> be the right place for some sort of "no cameras found
>> have you tried hitting your camera privacy-switch" API.
>> That is some API to query if such a message should be
>> shown to the user. But that is very much future work.
> 
> Are standard apps expected to use libcamera directly or they should
> use pipewire?
> Maybe a) Should be pipewire's task?

Standard apps are supposed to use pipewire, but IMHO this is
really too low-level for pipewire to handle itself.

Also see my remarks above about how I think this needs to
be part of the pipeline handler. Since e.g. associating
a /dev/input/event# SW_CAMERA_LENS_COVER node with a specific
UVC camera is going to be UVC specific solution.

For other pipeline-handlers combined with vendor fw-interfaces
offering SW_CAMERA_LENS_COVER support I do not think that there
is going to be a way to actually associate the 2. So we will
likely simply have the pipeline handler for e.g. IPU6 simply
associate any SW_CAMERA_LENS_COVER with the normal (non IR)
user facing camera.

Since we need this different ways to map a /dev/input/event#
SW_CAMERA_LENS_COVER node to a specific camera this really
needs to be done in libcamera IMHO.

And I think this also solves the question about needing
a kernel  API to associate the /dev/input/event# with
a specific /dev/video#. At least for now I think we don't
need an API and instead we can simply walk sysfs to find
the common USB-interface parent to associate the 2.

See how xawtv associates the alsa and /dev/video# parts
of tv-grabber cards for an example.

Regards,

Hans




