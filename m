Return-Path: <linux-kernel+bounces-404011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B969C3DE8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34291F21481
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1C017C227;
	Mon, 11 Nov 2024 12:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kw9mM5Mt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DEC17C91
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 12:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731326619; cv=none; b=k2PtLrKEE4Xk9Va9AAYdBhCb7kIAkaYB3M0g60WFGz6fYyAqFASKqvpTKzvq6+akPC1G0ahVxmweD4llzofJmB9WHYD3juJaEwrtSQ2MGXUEUGtWxycZ99Ha/870yfiiVYCPAr3fYQA5a9HVLcWkF1nbJSTh0Q71yGW21ttc4KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731326619; c=relaxed/simple;
	bh=0hetY8uIMEqVRKNJElojeolvV3479Cxlp5RUjM0iE/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OCJo1H5Hc4uAeGzifaNx3SXxtCe5XITBo7c1GQ7aiF46bq860x43SNlh2MDUHiUGmoKHBeA5i6rIrq0Q011ZElO47wwBQkCvkZCUC1T6AGtVANsUDa9kl2BkKyAgDOim6Ivpp0RpZ3eqwYwjQdURUz4peelNyQviZ4yW2mICXDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kw9mM5Mt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731326617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mRpNVm2ysOu8vdoKpxHcBNsUyipR7w7qRAL2/gqNzEc=;
	b=Kw9mM5MtrmqHpjUXP+/I/iMORTzjl4ikJyZT6bRyj/NU++h/0LOlx1KFJWnPhRu4/Az7kM
	NnrSM5keZR0IAoJgCjg07DSSbEblxAVCRn4oPzu1yTC+C/Wq4/JpVWmJAtcwTbAWMSgc6s
	02oGt7P7NUgSOfgtIi96QxJaIDSsJIk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-iDpqqgvLPkecH0lCApyEAQ-1; Mon, 11 Nov 2024 07:03:35 -0500
X-MC-Unique: iDpqqgvLPkecH0lCApyEAQ-1
X-Mimecast-MFC-AGG-ID: iDpqqgvLPkecH0lCApyEAQ
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a99f43c4c7bso309553166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 04:03:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731326614; x=1731931414;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mRpNVm2ysOu8vdoKpxHcBNsUyipR7w7qRAL2/gqNzEc=;
        b=eDbW1yVJTuPqGLsP2tuXd8JZhvj48M5+vD3PtuMahucDspRrjOhr0beUuEcHTx0P23
         IVyh6BwcHNaya27FqQ29s/pn72Y+ezmrWuodATq/uyEm6rPX15TRmxYf1y64M6NziC3h
         jIyN4Wat68MKEuX6/zWSemy2VYx3YID1iKhk+XZWZ+3uNrjG+u2SjJOJxPIkjv1hdt6U
         eWDlFk8GRbCdeX6LsBQPdMSAXHnQwggJCv6LDP/HmQoh/QugpILJoLCaLZDKv5nU2X21
         mI4x3PVT/MxXh72tmHPocHu9kMQK8RDB5x3YnYdL8d1q1XAtfCNx0LWm86gwcINJBzS+
         SjAw==
X-Forwarded-Encrypted: i=1; AJvYcCWj1sZS6u1NWVblW4Zq79e56N01+MDe2xuZt8RLunykgsrIszVo4yRCWP80WTC0srQ2AZfX9mA7I8qAitY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0xyqI7zMAz8DC8jlFz2G3S/gBjWCGwKNDrZ8gJs9V3Thar7Lr
	31JUqrVQo8mxMqEdvJxFjTVzM7O5JxiLJ/K4VDAkuy6s0ZVNjm/dzJ46qC64Xah9fIaPvZUgP0k
	OB1wSE8cWcK08IPoy1eJGmcxuUnlvJTbF/bH+yZAkUL46YY4j0WT8NlFjVCM+rg==
X-Received: by 2002:a17:907:6d28:b0:a9a:2afc:e4cc with SMTP id a640c23a62f3a-a9ef0050e63mr1185216166b.58.1731326614248;
        Mon, 11 Nov 2024 04:03:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJWchcYStfBvYd+ipw3WE4m9baAoVo0YVLDMr8rJI2MTxP68VvWvEA+f6wkEfg1VCcKVP5+w==
X-Received: by 2002:a17:907:6d28:b0:a9a:2afc:e4cc with SMTP id a640c23a62f3a-a9ef0050e63mr1185213166b.58.1731326613786;
        Mon, 11 Nov 2024 04:03:33 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a450besm582118666b.43.2024.11.11.04.03.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 04:03:33 -0800 (PST)
Message-ID: <0786dee3-8605-408d-b05a-e1736c6481a3@redhat.com>
Date: Mon, 11 Nov 2024 13:03:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] media: uvcvideo: Implement the Privacy GPIO as a
 subdevice
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, Yunke Cao <yunkec@chromium.org>,
 Hans Verkuil <hverkuil@xs4all.nl>
References: <20241108-uvc-subdev-v2-0-85d8a051a3d3@chromium.org>
 <5b5f3bb7-7933-4861-be81-30345e333395@redhat.com>
 <CANiDSCta62P5+1aR9Ks8c6sd3_grCV3C+Le=UjKGkiohyf0R2g@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CANiDSCta62P5+1aR9Ks8c6sd3_grCV3C+Le=UjKGkiohyf0R2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ricardo,

On 9-Nov-24 5:29 PM, Ricardo Ribalda wrote:
> Hi Hans
> 
> On Sat, 9 Nov 2024 at 16:37, Hans de Goede <hdegoede@redhat.com> wrote:

<snip>

Note only replying to the button remark here, to try and disentangle
that from the general power-management discussions.

>> One downside is that this stops UVC button presses from working when
>> not streaming. But userspace will typically only open the /dev/video#
>> node if it plans to stream anyways so there should not be much of
>> a difference wrt button press behavior.
> 
> I do not personally use the button, but it is currently implemented as
> a standard HID device. Making it only work during streamon() might be
> a bit weird.
> I am afraid that if there is a button we should keep the current behaviour.

There are 2 sort of "snapshot" buttons on UVC cameras

1. Snapshot buttons handled through the UVC protocol / USB interface.
These require the UVC interface to be powered on and the status interrupt
URB to be submitted (uvc_status_start() called).

These will only work if the /dev/video# node is open, otherwise the UVC
interface is powered down and the status interrupt URB is not submitted.

IOW most of the time these already do not work, since most of the time
userspace will not have /dev/video# open (otherwise we would have
the power-consumption issues this patch-series tries to fix everywhere).

IMHO not having these working only when /dev/video# is open and instead
only having them working when streaming is a not a big deal since usually
userspace will only open /dev/video# to stream anyways (except for udev
probing, but that is very short lived and does not help with the button).

2. Snapshot buttons which use a separate standard USB HID interface

Since these use a separate USB interface, using the usb-hid driver.
These do always work and these are handled completely independent
of the UVC driver so it does not matter what we do in the UVC driver.

I hope this helps clarify the button situation.

Regards,

Hans



