Return-Path: <linux-kernel+bounces-421000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 494A19D858F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5677AB2CF56
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8810C19F49E;
	Mon, 25 Nov 2024 12:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K99XEfgh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A57118AFC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 12:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732537916; cv=none; b=U1/mvEWiEkxgMfAhhh06y/+vEUMHf2Ala+zZ7qRoMgGlsRjkDgWWyZZ3Z1Gx8vFboV95mD59xhSckAMrJmYm7ewp78kzcIXbJLFmx9a204LzCyAPQm1+xAxbDm/93sQcw9SUtLZ07fcxMv2s4mxXs8qkFC0Lwn0CHUQ2O2E7LGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732537916; c=relaxed/simple;
	bh=MlGWKYH7laub5cwr4a1POZ/i0TJA7EJBnNcK4lHuA8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sOr/qOAB3gzHp5bmJyOOGogQNBhtFhqJmKVLNx72Fw4O5iJ0t/9dysCjsi4uDpy8PMadMp9tNida2g1bjtfPCW+6fVks0Ee75T2bv9UcRWFHKWjq646dQjgT8QKUHOLq07eXyfNz0g1yRjrppgKdw1YNOT524i0QJZM9uHJJLX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K99XEfgh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732537914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MlGWKYH7laub5cwr4a1POZ/i0TJA7EJBnNcK4lHuA8A=;
	b=K99XEfghatWZRqbvF8O8MfF3pvsHj9hxkLHv2JjShfVapIHTOcw/Jbs6IdbYRwcKrpZX8a
	7at0TdLh5iQpjSYgEPMhGrDMr/w1y4GLNyBIaiYuO2oO+lnm9p7lVhZN8JYuE9jZAwyp7o
	JVEmfwmzMW4I8SY8ulCZEBtHrDAE8qA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-5iEn8061MMmRvEovh9CafA-1; Mon, 25 Nov 2024 07:31:52 -0500
X-MC-Unique: 5iEn8061MMmRvEovh9CafA-1
X-Mimecast-MFC-AGG-ID: 5iEn8061MMmRvEovh9CafA
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa54d1c790cso105425366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 04:31:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732537911; x=1733142711;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MlGWKYH7laub5cwr4a1POZ/i0TJA7EJBnNcK4lHuA8A=;
        b=GfKi7tk3ShH/fArNArsChpniXyKeerbQoqflnetL38jIjHuGM/tJAgtMMCUOJAo4wT
         Cq7OJdLZAncrR7JwRpjsrbMoTAc0G0ZMRX2UYuBi3Qh9VnKN0UEd2J6nXxgTgAMfQiGa
         vLzcmBBFcsviAF7CvyiRaGLKaito3bZ8iI/OntBvq0DnAR/XAo8FuqjhbJbOTPQHn7dT
         m/H/FASisJw2X8uWp435lVItq1ZO4fdI0fPUZ/Z6s3DCC75XYrd2YoVvAwhRRHhvMcth
         WFCEdsBO2L0m1+RL5ZeQH/b5QDrXcvCPJlodArKx6Q2a34NNkNuoAttZndjT5WGLJZ75
         PdCw==
X-Forwarded-Encrypted: i=1; AJvYcCX5zXI0s/kUUm5pvHpfF9f8QbVQgOqwG1uj3l79oKC5zHTbC6n+0JmHVnXnDm74ueq2AVf2eWNrQ1bdL9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ1NHwxHjOxkwpCPybvWufIWkyD2YnRsJuEdZhPqnfB23hZ7Qz
	QoGofZawvPPdQkI5NO5bD6Gb0R5i7iddBJ7+/V4bIIvZNlxpfrYvZSRr+KeaYaQGudkEEGL1lUB
	X4WiT5b4VZ3XZdjtc4ogftcxtQniKjxTzPHoGhHw6lklYKYliUldQQsIB5c+clA==
X-Gm-Gg: ASbGncsSn1wVt9m4J7xiXLbZ7R2OeY0nH41qA2WdKR7c+qfDS82NtorkLaFb14IUJ7N
	GjkFlRU53XdJZcyTKLvHlik3N8L8SqMl8QUYzVjoSWtnF3n/sm7Xdq7KhVTEpztBpAm1cRhzKTE
	YLEBWVHUgW6mzE1c6+DPNheJ5JomJ5MLqDqCQL3rveHUAyo+fcx6O+MpB4FBNZNjxEfKiQecoS1
	Xj1hFiSxxEh2TwOeSy+ga4axQnDRR38YGMLh8Vr4BN0naDiioHhoU6mO39ALBxUBTITouvxt/DF
	fryWbZEJ3PwweVNK9du3HBX7yQhCx8ZmrlSZwRkatNkQP+ctnkLc8D3bPQZAfOFjBXb8MIHqF8o
	M0Hs617omsVkEXZnwomlrWIEz
X-Received: by 2002:a17:906:2181:b0:aa5:4434:2b27 with SMTP id a640c23a62f3a-aa544344282mr438526066b.40.1732537911680;
        Mon, 25 Nov 2024 04:31:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFgxo1eKpgUwSsnZNHO8CxH1zA9cD+M1XPuRg1H1qniBSzQEE/fXCmI8/VjhUzJWJ1udNrAA==
X-Received: by 2002:a17:906:2181:b0:aa5:4434:2b27 with SMTP id a640c23a62f3a-aa544344282mr438523866b.40.1732537911331;
        Mon, 25 Nov 2024 04:31:51 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa53683eafbsm302481366b.189.2024.11.25.04.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 04:31:50 -0800 (PST)
Message-ID: <f2638853-6c0a-49ee-9a80-28fb774cc678@redhat.com>
Date: Mon, 25 Nov 2024 13:31:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] media: uvcvideo: Implement the Privacy GPIO as a
 subdevice
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, Yunke Cao <yunkec@chromium.org>,
 Hans Verkuil <hverkuil@xs4all.nl>
References: <20241108-uvc-subdev-v2-0-85d8a051a3d3@chromium.org>
 <5b5f3bb7-7933-4861-be81-30345e333395@redhat.com>
 <CANiDSCta62P5+1aR9Ks8c6sd3_grCV3C+Le=UjKGkiohyf0R2g@mail.gmail.com>
 <20241110151426.GD6002@pendragon.ideasonboard.com>
 <CANiDSCuRbOEhWi8WtJpJSm5SOjzTRzpk=OTOV_jwbhUQMoXszw@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CANiDSCuRbOEhWi8WtJpJSm5SOjzTRzpk=OTOV_jwbhUQMoXszw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ricardo,

On 10-Nov-24 5:04 PM, Ricardo Ribalda wrote:
> On Sun, 10 Nov 2024 at 16:14, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:

<snip>

>>> Can we start powering up the device during try/set fmt and then
>>> implement the format caching as an improvement?
>>
>> This sounds worth trying. We'll need to test it on a wide range of
>> devices though, both internal and external.

Ack, as mentioned in the other mail which I just send I think
this is worth trying.

> We still need a plan for asynchronous controls.

As I mentioned in that other email I think we can do the same there.

So basically delay powering up the camera from /dev/video# open till
the first moment we actually need to communicate to the camera and
track per file-handle if we did a usb_autopm_get_interface() for
that file-handle and if yes, then do the put-interface on file-handle
close.

> And we have to decide if we stop supporting the uvc button (maybe we
> can start by moving USB_VIDEO_CLASS_INPUT_EVDEV to staging and see
> what happens?)

As I mentioned in other threads I do not think that the button
only working changing from:

"only works when /dev/video# is open"

to:

"only works when streaming from /dev/video#"

(or actually only works when some action on the camera which
requires it to be powered-on has been done).

is a big deal, since most apps which open /dev/video# for
a longer time will almost always do so to actually do something
with the camera, at which point the button will work just as
before.

And for apps which only do a short-lived open of /dev/video#
the button does not work with the current code either.

TL;DR: IMHO it is fine if the button only works when streaming.

Regards,

Hans





