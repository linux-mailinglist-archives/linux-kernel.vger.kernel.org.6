Return-Path: <linux-kernel+bounces-413286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505A89D16E4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C613BB25555
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3211C1738;
	Mon, 18 Nov 2024 17:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MVX7hCDT"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0333C19F411
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 17:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731950208; cv=none; b=Nyoujy+bgIv/l9yqHja8vYdKJ1d4gqzsYWjiwC+1F8IYpI0N9ZGrofDfMCRZIR9mzqN0d9VYZJKLvy3bfmLx8LPUYIPZE5L9MEtsQqLt1004WjWLHvHoMeNj+SpW6NE5eEi/6HF5PJ9O3LHMDIiZRl3mAP0o+92D8dKk3HN+lqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731950208; c=relaxed/simple;
	bh=kV6pfRr3oUtEv+dKqYa+de7WCNOzSF51LX4T/fVCxt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UyJ6kLNxy6qx4jzEcnaNLQZWl46yDX/cNJhlhNT1TbwtmF47fvLWSAWMrmZVXIZxCYwsu0jwbImSV8trybUui7TVsh0P0h5mo1Kn1A1pn7AK6gvBe/fxF/AB/nZ4iLnkbvY5eRFv5ZoJTgT3Gjd3bT2xd1m1bB1MdgJwOYeQ2tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MVX7hCDT; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20cb47387ceso45596175ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 09:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731950206; x=1732555006; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ki1y1CRvVemx6jfa1qtaoOBkjZCgQXTP4f88zxjQDaw=;
        b=MVX7hCDT6XyQvEKZpPegLweANmd3i1V9moZ4cpP3R8FQcEM6WL0eTovtMe1mWJ6M52
         OrY3t9T9nvcohew0/qpYmK2361TUUaQWhpfl8ZOH7tbaApchRyUBydvlG4V1WTj9XJWf
         4wOza8SAlasi12m0v5X3UQLq7f404MrPhb/qA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731950206; x=1732555006;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ki1y1CRvVemx6jfa1qtaoOBkjZCgQXTP4f88zxjQDaw=;
        b=L0Li4hkn9RJ8bl7A7iIwzfQI9k+c2awwY6BNkh4QnKZOTfuJUvdi85Umx/rv2qWqPv
         ppjMMKRTrmP0VLiCaFSTZWZUpEm6WvNqAwJkMiAUI1sF8m5Nebw8WMIT6FsQ5y4b+hPt
         92orjubBDxAuBxll25brEZZw3ERMb9KQLPPyMcT3mBsyMbfe4e3FbtKgeIFI75FY4u9G
         Pp3J4nMGnH/sGS8vDV2TD4J2hs1iW/HrH5Nm2u8iKZ6U0rYWlj1S39bd/+iPHS2zv717
         6aCKw4BgtKVqc0YXsysqAgbVCjKCgGhJlqNNwna+l9w959x1SDEM0I/we+q6u0FSC31i
         3Oxg==
X-Forwarded-Encrypted: i=1; AJvYcCUKATxCiGfDLps8DtEuK/XV4kZhw1/Ut2KDQUijXKxODSLHeKDntNzbp5f/PhZgyvtiJGau/MrOXW3xqUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/v1+Tab0ictD+sLd+YjEt/EvewShit1Joqp7Gk/r3cXXupl4f
	lB3OzCoij7BzXetRJDi1eHRUJtcUyr0ny45dC10bS5iOqzUZlpVmMl/zJ4Q50TLFGjko0koWi6Q
	=
X-Google-Smtp-Source: AGHT+IELJwyK8viXARjSTG8YpCuKy0L7jHvM+cHKJFkkT67073Xp/ArSIuq5EN9fRNTvvYCA1F+xaA==
X-Received: by 2002:a17:903:2288:b0:212:f64:8d9f with SMTP id d9443c01a7336-2120f648ecbmr95743265ad.32.1731950206089;
        Mon, 18 Nov 2024 09:16:46 -0800 (PST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com. [209.85.216.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2120b2c7476sm28873145ad.209.2024.11.18.09.16.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 09:16:45 -0800 (PST)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e5a0177531so3439697a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 09:16:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUyDqtn73XVDb8edu3wIjSxKAImTDoELqND/Flz1YMj1bZti3/SMPTzeb3PvFsEKcLJQE1u5nR0KfyP4Q4=@vger.kernel.org
X-Received: by 2002:a17:90b:4b82:b0:2ea:853b:2761 with SMTP id
 98e67ed59e1d1-2ea853b2895mr3850305a91.37.1731950204454; Mon, 18 Nov 2024
 09:16:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-uvc-readless-v2-0-04d9d51aee56@chromium.org>
 <20241008-uvc-readless-v2-2-04d9d51aee56@chromium.org> <4ce7cac7-6e4a-45b8-8d0e-a8f16a77839f@redhat.com>
In-Reply-To: <4ce7cac7-6e4a-45b8-8d0e-a8f16a77839f@redhat.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 18 Nov 2024 18:16:31 +0100
X-Gmail-Original-Message-ID: <CANiDSCu_-sy1XyEAPmoGELbzamO01UdA5-Dj0PCkOBeFUS2hbg@mail.gmail.com>
Message-ID: <CANiDSCu_-sy1XyEAPmoGELbzamO01UdA5-Dj0PCkOBeFUS2hbg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] media: uvcvideo: Add more logging to uvc_query_ctrl()
To: Hans de Goede <hdegoede@redhat.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi Hans

On Mon, 18 Nov 2024 at 17:45, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Ricardo,
>
> Thank you for your patch.
>
> On 8-Oct-24 5:00 PM, Ricardo Ribalda wrote:
> > If we fail to query the ctrl error code there is no information on dmesg
> > or in uvc_dbg. This makes difficult to debug the issue.
> >
> > Print a proper error message when we cannot retrieve the error code from
> > the device.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_video.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > index f125b3ba50f2..6efbfa609059 100644
> > --- a/drivers/media/usb/uvc/uvc_video.c
> > +++ b/drivers/media/usb/uvc/uvc_video.c
> > @@ -111,8 +111,12 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
> >       error = *(u8 *)data;
> >       *(u8 *)data = tmp;
> >
> > -     if (ret != 1)
> > -             return ret < 0 ? ret : -EPIPE;
> > +     if (ret != 1) {
> > +             dev_err(&dev->udev->dev,
> > +                     "Failed to query (%s) UVC error code control %u on unit %u: %d (exp. 1).\n",
> > +                     uvc_query_name(query), cs, unit, ret);
> > +             return ret ? ret : -EPIPE;
>
> Adding error logging is always good, but again please drop the change
> to the return condition and stick with the:
>
>         return ret < 0 ? ret : -EPIPE;
>
> pattern used everywhere.
>
> Also in this case the return condition change really should have
> been in a separate patch since unlike before the success condition
> did not change, so it really is unrelated to adding the error
> logging.

It doesn't really change: __uvc_query_ctrl() in this case can return
1, 0 or a retval.
But I agree, the change does not provide anything (and I did not
mentioned it on the commit msg) let me restore the original return

Thanks

>
> Regards,
>
> Hans
>
>
>


-- 
Ricardo Ribalda

