Return-Path: <linux-kernel+bounces-425091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DC19DBD58
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 22:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27A87164A3A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 21:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47762158553;
	Thu, 28 Nov 2024 21:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k0EiMnuV"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359711F92A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 21:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732829695; cv=none; b=AE0E2ZxOqo3p2K6PW46C4m7El/Jii1eARF2IhaGvw6PPHFz6mcNKO886Avq2grzauyzVnsiSD9J3XBLgaqfkiNA315ExbMTY3uUHf1Kvygd1OtDBLe3FGPb8sbcy86JTYL7lM5Q2PDgDahybbJpMKMfNdx4I7xSs1vZ+bHCgpHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732829695; c=relaxed/simple;
	bh=zG32356MJsh3JnWSmMLcSv/tq2Qpt12J6lc5ueIzQ3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SzTF1W9WrdDJ9ILXVkoyMX4OpXca9CTwlN9lkTs9eXIjdrKRIKfLR45r7RTTr6Dc43KvlPsAi+0cD8WTXZzy4hOuGD3pCEp1QgHvpF8x0L3Q1RbIqEYp+TM04Z9isXXcv78lLWxrhoIEhCDeBXrP8fb94ln8RqcFug0ClY374VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k0EiMnuV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2120f9ec28eso9525775ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 13:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732829693; x=1733434493; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VZ3B52zWQdNOd8F/nW1HrBtSmyEx9e8pcGYpxy7g/fg=;
        b=k0EiMnuVsoE6FRy1p2mGD3YLr9runvfH51AE/ypkv0xITwLS7Wk4hghEq7ryGvCZq3
         mzrnQ2WAiZ72KP2cImMz0e257kl/H+d01SU0t7897FE+G/zYHsfo8dfSDObBQmveWuKS
         Sn9ynXf54rx6l8W4usfGpDErq+u6iyy1A8Iek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732829693; x=1733434493;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VZ3B52zWQdNOd8F/nW1HrBtSmyEx9e8pcGYpxy7g/fg=;
        b=fcO54vLk64qanZj7lMTg/9L+WOP8TreM98Xp8t6pXTQ3YFIfxIRwZFEElQFbJ4uFu0
         sxRAVg88rp2WQVNDF42B0PqSetS8fsFb/m+Rf5ohzVyJT9nQmQLma+3HyfDgDbwG8Mau
         hUodaF7RMm20Ri5MScS0sPj2FMUrKaQqmVsH5ecfybdypbNSD4IjL5TCSIBI0BTjBiCe
         vsUH/mgzY3oyVa7WMOxc826UoAMNfwddOpoJulrulZrlNlnxi2C6UnqWlJtz+RD4yDZG
         p/82ARygYgeCzDkMUWvGTvmYdQKpe1c+U/i5AOCR3HMx8S57cSguDsWOuzZTiSfcKm/v
         lR8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQt8I/rBs+VgpvYWI6gSZKRteABAEmRsPCs9rGT/wMuXu91BR3uJc3f4fvVlOkfR/g1bbXrrdXW00U8nQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqaCXp+Bdobhn2x83rEmWjNn0QsKEKIn7h0kYH3GbtfXqDseaI
	s88M7SYHmiodexkQ3eYUJPIxrveXBerMffQ9yntbcBCwao/RIzJo2rt1eNRDPyVG6KZK4KqrOWc
	=
X-Gm-Gg: ASbGncuDP7v0D3wYkvzHfFudyUzKIwmPGBGJtSOwvK+Y1pIyjutfFsooRFuxKGwpYyy
	wdfPAN67XsLU62FHcu92YnhKltg1PNZ4yatm+SD0rc1n4jy6bBxlOAqVe/Hq57mJcwv1DJdD++s
	92hwQuimj77Fo1cUCjCKp7kdM6tRUJk30Q0mj06RV5Yub51FXo7NYedEPQ8egI6ClUpJeNqPTsT
	V1ics3JeNhaWbT2IdCOVXAFwk07kKfaH7yvbovRTsyIE3FJ/5DTpnGWrKjN1FVK8U/0vsrmaoKw
	UYrJvyRNZ6xY
X-Google-Smtp-Source: AGHT+IEVfHcdRCYRFuwjhhZPjTX/zzbCmxbHdK0ain5tEGqefYMyUgjeZ+QBxS3KQzbhknlhPkzygg==
X-Received: by 2002:a17:902:f541:b0:20c:f6c5:7f6c with SMTP id d9443c01a7336-2151d33e1e0mr82057435ad.16.1732829693217;
        Thu, 28 Nov 2024 13:34:53 -0800 (PST)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com. [209.85.216.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254176150dsm2115974b3a.23.2024.11.28.13.34.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 13:34:52 -0800 (PST)
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e9ff7a778cso1715923a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 13:34:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVIcLYCV/P04WPDOCNgtNEMNWQTJANFT7UNlmUF3DvJK2icvXd6e43SYJf1oCGXqi7N/5/r24A5NKGYUMk=@vger.kernel.org
X-Received: by 2002:a17:90b:3902:b0:2ea:49a8:9169 with SMTP id
 98e67ed59e1d1-2ee25ae1094mr8025818a91.7.1732829691639; Thu, 28 Nov 2024
 13:34:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127-uvc-fix-async-v2-0-510aab9570dd@chromium.org>
 <20241127-uvc-fix-async-v2-4-510aab9570dd@chromium.org> <20241128212628.GD25731@pendragon.ideasonboard.com>
In-Reply-To: <20241128212628.GD25731@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 28 Nov 2024 22:34:38 +0100
X-Gmail-Original-Message-ID: <CANiDSCvb8OCGJjggermRPeD6R2Rt79hMuwF6xc6YQvvSqUNObA@mail.gmail.com>
Message-ID: <CANiDSCvb8OCGJjggermRPeD6R2Rt79hMuwF6xc6YQvvSqUNObA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] media: uvcvideo: Remove redundant NULL assignment
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, 
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi

On Thu, 28 Nov 2024 at 22:26, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Wed, Nov 27, 2024 at 12:14:52PM +0000, Ricardo Ribalda wrote:
> > ctrl->handle will only be different than NULL for controls that have
> > mappings. This is because that assignment is only done inside
> > uvc_ctrl_set() for mapped controls.
>
> That seems right. I checked the unplug paths, and the mappings are
> destroyed from uvc_delete(), after all file handles get closed.
>
> I think this patch should go first in the series, as otherwise there's a
> temporary state where you rely on handle never being touched without
> holding the proper lock, and this code path violates that requirement.
> Is there anything I may be missing that would cause issues with
> bisection if I move this patch at the beginning of the series ?
>

You probably want to add the Cc: stable and Fixes: tags if you make
this patch the first one.

> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> > ---
> >  drivers/media/usb/uvc/uvc_ctrl.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > index 99ddc5e9dff8..b9c9ff629ab6 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -1645,10 +1645,8 @@ bool uvc_ctrl_status_event_async(struct urb *urb, struct uvc_video_chain *chain,
> >       struct uvc_device *dev = chain->dev;
> >       struct uvc_ctrl_work *w = &dev->async_ctrl;
> >
> > -     if (list_empty(&ctrl->info.mappings)) {
> > -             ctrl->handle = NULL;
> > +     if (list_empty(&ctrl->info.mappings))
> >               return false;
> > -     }
> >
> >       w->data = data;
> >       w->urb = urb;
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

