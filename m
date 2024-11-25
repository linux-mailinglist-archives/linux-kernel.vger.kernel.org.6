Return-Path: <linux-kernel+bounces-421322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9069D899D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BADA284EB7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD4942A92;
	Mon, 25 Nov 2024 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHD09CJ0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C671AD3F6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732549573; cv=none; b=tJvMDzOX0mP6Ez3L7SVA6dP1vFe6un5Io7v7SSwn7Gr51bzxC9EUzFmukVgxLh/Atj6AAQRO5xEGWnwpf6fFRjs3CgaaABuKCV0KFTBcLdYRuuEcGhDSBqvUXD9iRbN15APAXCbdUADKN33RmeSmPc0/awHRDvbvKPwRhGWDwtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732549573; c=relaxed/simple;
	bh=SupYXAlr0qFHFZ6JEA/DkVyN/nqKdB3rTEuf9oDUvHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1LKoAvLN8EabdQNZo01XAvp9PQ8MDLmQMR8LEFsmjjCXmtNN+y5B5QROxnto0Gi7tFbzHDXFSFvWhSQAKsTdgoVg5H0fDSPBFiFl5844tC7Ndlbxau+LE4DKPHOxk0+CQZrFcx0taOe0IByqkEo7fcuvdGyZ+OPi/pJQ8IkunY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bHD09CJ0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732549570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Moi/9kY3hsu3blYNKyKbP8MNPzPK4z7Gj96yIc153Ok=;
	b=bHD09CJ0yf43VSFWwQIfWRX4xHZDOaPzIegOSAHh99jQP2tbFmuI0Ocpl8Dv1pEkBJE53O
	JC4MOf8GyG9EM2HrU4UmjRS0YgjzD7BamcOHH5vuYTp3l8STCenvkBeWnAmRuHj+tiA6QL
	qNS1SYN0w53HX55z4/c1mgQU/hcexu8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-L-LSBV1mMUyVbiyiycYFOg-1; Mon, 25 Nov 2024 10:46:09 -0500
X-MC-Unique: L-LSBV1mMUyVbiyiycYFOg-1
X-Mimecast-MFC-AGG-ID: L-LSBV1mMUyVbiyiycYFOg
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aa515925dd7so212240766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 07:46:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732549568; x=1733154368;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Moi/9kY3hsu3blYNKyKbP8MNPzPK4z7Gj96yIc153Ok=;
        b=Gb09jmU8eMDjV3un/6seIM030gKblOpoUK8GnJLT22SHX3BxEs/ul8WTwX33QBkZiW
         zR5P4IAIqifvQ8CFFflBfccbNH0IlgcD8EDz87S+h5Svgb2nxkwvePL1wbQmHCWqvcHN
         V4VKMfVSVqYw8N6/CvuVcpqN5iTLqe8bqQc5UhmfTNnfbm0nBELHr6hpDJSOzrWSw41V
         NvhOW0K3K0PmqD1jrVZAoKBaRMgXReRutBLEjveqBKvwTstLHg8pi+IDkpPknUQDKBfZ
         TBAkR9jHILZTj0v+cAv4mFtUwTG2DoJdbFVX01tTq2SfnIkjPguKfvpSJjTEF+pTy0wq
         Fvmw==
X-Forwarded-Encrypted: i=1; AJvYcCWSyBqMYL0Ps2PQfb/0YENeQRr9s+cd3c+/7tpA5W2/uCPu6XXtuzld8fhQITHn1MzaNVIxmXsueZ2IM4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypxt1LBRpJx59/T9jv0ceze6xQdMSuTcJPU+ArF7v6TRrf5FZD
	f4+StS8DzQVu4CZPhU3yPL+85w7JOhwxPlC41dGF6gFky5aNMHVaEmna9ZfVxOmDKDVmOXs8mVm
	pgwOlArcWTeEFeVkF+dPN3MEznGbxN+N0NICXZP9aOFiZGajRtIMfc2JYIeNyhg==
X-Gm-Gg: ASbGncvVbhxnHgkySX7j5FcWKWJ9AmNvWfwi7xSIxMDclQo8Gkp0goVEZb7+mSqYpg+
	oT4es4KzrpCQb6YiQOgrN+7+OSosX2PWQIN8JwfKi2IQxC4rwkqFx8UNLO+C4GRg520xu9YOBQE
	HZ1fmliVgkWLS5ho3Diivu7CjgsJmAwxqnTL7kQBm7/HWGVzGXZmK0rr2bQVAyxacKWsVW0j9v4
	Sbka4XLMELOtRy/nYn7myX1L85Y8xwwnzDybmwt12qAkESJyi+xh4xpWu/8HZaLuPZ8UA+cvf+W
	lh0TXpoKyrZnLV2ZtmD1ZzPHBA1RJKabWf0IkS/xHJutZ543WFE20fQJMkz+5+oLaAKNjpauDVV
	rSgdmzYRH8t3qoZqMczesx1Ja
X-Received: by 2002:a17:907:7759:b0:aa5:2ec5:369b with SMTP id a640c23a62f3a-aa52ec539cbmr773534266b.17.1732549567725;
        Mon, 25 Nov 2024 07:46:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERT7m6ex0sbMI2VYQrQaT68enathgE89C30stb6bdS0FUb0hAeSaQCJfW4oG02NtpvRI7uzQ==
X-Received: by 2002:a17:907:7759:b0:aa5:2ec5:369b with SMTP id a640c23a62f3a-aa52ec539cbmr773531766b.17.1732549567322;
        Mon, 25 Nov 2024 07:46:07 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa534ca196esm332102866b.193.2024.11.25.07.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 07:46:06 -0800 (PST)
Message-ID: <0dfb780b-f2dc-43ed-a67d-afd5f50bb88f@redhat.com>
Date: Mon, 25 Nov 2024 16:46:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] media: uvcvideo: Factor out gpio functions to its
 own file
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, Yunke Cao <yunkec@chromium.org>,
 Hans Verkuil <hverkuil@xs4all.nl>
References: <20241112-uvc-subdev-v3-0-0ea573d41a18@chromium.org>
 <20241112-uvc-subdev-v3-2-0ea573d41a18@chromium.org>
 <7da09249-f2ff-4a0c-8a06-1594b02ce87a@redhat.com>
 <CANiDSCsQ3Rp55+9WbporH37W_-XHaXCR0iww6n6kHXngKh67TQ@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CANiDSCsQ3Rp55+9WbporH37W_-XHaXCR0iww6n6kHXngKh67TQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 25-Nov-24 4:10 PM, Ricardo Ribalda wrote:
> On Mon, 25 Nov 2024 at 15:45, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Ricardo,
>>
>> On 12-Nov-24 6:30 PM, Ricardo Ribalda wrote:
>>> This is just a refactor patch, no new functionality is added.
>>>
>>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>>
>> I guess this patch may need to change depending on if we want
>> to keep the GPIO handling as a UVC entity or not.
> 
> I have a v4 that removes the virtual uvc entity. Still with that
> approach IMHO this patch makes sense.

Right I was not suggesting dropping it, but atm it is moving
the uvc entity creation around. I was wondering if that
moving around before removing it still makes sense ?

Note I have no preference either way if first moving it
and then dropping it is cleaner, or just easier because
of the history of this patch-set then IMHO either way
is fine.

> I was planning to send it today, I am testing it right now.
> 
>>
>> Laurent what is your take on this, should this stay as
>> a struct uvc_entity; or should the gpio_desc and input_device
>> be stored directly inside struct uvc_device as is done for
>> the snapshot-button input_device?
>>
>>
>> Also de we want a separate input_device for this or do
>> we re-use the snapshot button one ?
>>
>> Since my plan is to open-up the permission on the device with
>> the SW_CAMERA_LENS_COVER to be equal to the /dev/video#
>> permissions sharing has the downside of allowing keylogging
>> of the snapshot button.
> 
> A downside of having 2 devices is that userspace will have to either
> figure out what evdev they want to use or listen to both....

Right, so both would be picked up by the compositor and the
snapshot button is just another multimedia-key then, while
the compositor can use SW_CAMERA_LENS_COVER for its OSD.

The other would be of interest to libcamera.

I'm think we may need a naming convention for the evdev
with SW_CAMERA_LENS_COVER something like "* camera privacy"
or whatever then we can have a udev rule matching on that for
uaccess + libcamera can do a strstr on the name for
"camera privacy" and ignore other evdevs.

Regards,

Hans



