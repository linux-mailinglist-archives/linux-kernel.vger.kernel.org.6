Return-Path: <linux-kernel+bounces-410362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E1F9CDA63
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 09:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 575E8282B83
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 08:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FE7188714;
	Fri, 15 Nov 2024 08:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RsX9rCIl"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CEF2B9B7
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 08:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731658949; cv=none; b=HCcf5wuTTTuyBJLRyleK6RQzO2mpUu/CJ2dX5wIiuH2Xnr5IQdDHK2wejJCJdPK4FMXMTDBnKPtEh2DL4VoeQNdSEPP8EEAzAwE9EbNlmkawJPLI83aKNMijfwLgNDmNtZ8MicXrF5XI9xNnFOETyMSgVSavYZi0fCti4WWBWG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731658949; c=relaxed/simple;
	bh=XrYcG7CkZQFQ6ItjoZVP6vkcDAjf0xymGHuaxaV44cY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DSB5gQ42cBjq/zD9cPTB1xA9dV9Sy4034NU4ry3nIPH6+SjPHbSLkmcrt2im6jJ9Ck0MZge+HHoaS61l8yMupRxG2BjjfTfygGqnemA/nhbiyoTo57U7NM/aM+aCgM6s2EuxSSVhwAmnSnXcL2CcJ0CfKpUXj4j+wBjj8Hi0nPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RsX9rCIl; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7242f559a9fso1500360b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 00:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731658947; x=1732263747; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TV7adEbpnn1somxbEqgtIIMz6UdxFY1Td/kW9+T6GWo=;
        b=RsX9rCIlBPHl7h5rSafrOFaqR6efltIR/HTCSOFOKvvqPbZl9TPOZdtb49R+W8sgTn
         HiBdVMz5hLciQQmV1USZIoHqQS4azxJzulXdoLcOYP7QoDG9EBEv/EQhOrWjwUXtw0TK
         /bhy5Qzb7/2+1spfPGC8OY1A1yGXBRNje17TA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731658947; x=1732263747;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TV7adEbpnn1somxbEqgtIIMz6UdxFY1Td/kW9+T6GWo=;
        b=wQXOntUgSn5rAvPCWN9NkAUi0RqNCy+g5t/n76CgN3SXf7KxQCgMqa8RdSf6fPu+uI
         5gUjq1XeXEgHfEpnp2MhT6hou+jNZ5WZVTJA5oXKDDa1/O3/4IpCwESgtFDO2hTrO6I3
         raZnYG9dcKq062GeIENxj8ZZYLQMEsFeWDNN13Ygaac+6SYwhAHGk2FfwXWh5mnPYrWU
         2zNbgGybz7OqpKR6vg9l1hPVgg9IbGTveJzHbsHPRKwTrBmPXbRpaxgLJKGpxdJM+P36
         6BQePI93g7/9OoW+uf/gPGBraWC75dRquvEbxgpCbjS7wWD1i84wsf9RADVXpaUAIMw7
         sQQA==
X-Forwarded-Encrypted: i=1; AJvYcCUrga8J29sX+SHZ8f7aRNACSTaNdvI7NmSE9wa9oC8KcHtRG7nCqSFJd9CIMMqQsdNHKNPoZzf755+tzQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd5zhJZFZ9NkZuL40fNfmB7RWBahvnppH9MIHNu+hDzTzig2D3
	HY+3m8pse9c1Vb6ldfLVZ0+wFkPR5lR/T9ezAC+SOeaahQxmsOnA6q9JDPFhf8vfccg6HxLUk7k
	=
X-Google-Smtp-Source: AGHT+IETcMB/EDUKuwSjhEKgOD8QSDgezd4L0BKnH2itWPvryMuAEQhkFuUcHpESZ1TPSXotvm9cKQ==
X-Received: by 2002:a05:6a20:394d:b0:1d9:c78f:4207 with SMTP id adf61e73a8af0-1dc90b1c34amr2185218637.11.1731658947560;
        Fri, 15 Nov 2024 00:22:27 -0800 (PST)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com. [209.85.210.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0ec937esm7539405ad.91.2024.11.15.00.22.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 00:22:25 -0800 (PST)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7242f559a9fso1500325b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 00:22:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWPr3RMmRlQ0o8I8Db8RZZeQvJNA7NItLj+D5d/xN9n6z9taTBYA+6jfGWLk1//QlK8nfZ9CKeTpgjWk8c=@vger.kernel.org
X-Received: by 2002:a05:6a00:3a1f:b0:71e:692e:7afb with SMTP id
 d2e1a72fcca58-72476b72b62mr2596445b3a.5.1731658944813; Fri, 15 Nov 2024
 00:22:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org>
 <20241114-uvc-roi-v15-18-64cfeb56b6f8@chromium.org> <ac8ea4ed606cbc7dfb15057babc29e49a152ef01.camel@irl.hu>
 <CANiDSCuZTYDsQ3yCpFV_rhbQ+vFGJnsuU-jXwOacxZVbbzEPfw@mail.gmail.com>
 <5ffafb0d059f09c814692e7c33a7ce35ce9b0169.camel@irl.hu> <CANiDSCvP5eVuSGMi3R4eAkY2-ou=nqrTS1dnAv0Odbcq5UHa+w@mail.gmail.com>
 <c4c6e3a2e5313a9bafec31343407e60b2ea9ff44.camel@irl.hu>
In-Reply-To: <c4c6e3a2e5313a9bafec31343407e60b2ea9ff44.camel@irl.hu>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 15 Nov 2024 09:22:12 +0100
X-Gmail-Original-Message-ID: <CANiDSCvGeCHaw2xfZg__UU=fVCWADSQiMw8od5ofBesWjF-7tA@mail.gmail.com>
Message-ID: <CANiDSCvGeCHaw2xfZg__UU=fVCWADSQiMw8od5ofBesWjF-7tA@mail.gmail.com>
Subject: Re: [PATCH v15 18/19] media: uvcvideo: implement UVC v1.5 ROI
To: Gergo Koteles <soyer@irl.hu>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
	Ricardo Ribalda <ribalda@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Yunke Cao <yunkec@chromium.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yunke Cao <yunkec@google.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Nov 2024 at 01:04, Gergo Koteles <soyer@irl.hu> wrote:
>
> Hi Ricardo,
>
> On Thu, 2024-11-14 at 21:28 +0100, Ricardo Ribalda wrote:
> > Hi
> >
> > On Thu, 14 Nov 2024 at 21:16, Gergo Koteles <soyer@irl.hu> wrote:
> > >
> > > Hi Ricardo,
> > >
> > > On Thu, 2024-11-14 at 21:03 +0100, Ricardo Ribalda wrote:
> > > > Hi Gergo
> > > >
> > > > Sorry, I forgot to reply to your comment in v14.
> > > >
> > > > On Thu, 14 Nov 2024 at 20:53, Gergo Koteles <soyer@irl.hu> wrote:
> > > > >
> > > > > Hi Ricardo,
> > > > >
> > > > > On Thu, 2024-11-14 at 19:10 +0000, Ricardo Ribalda wrote:
> > > > > >
> > > > > > +     },
> > > > > > +     {
> > > > > > +             .id             = V4L2_CID_UVC_REGION_OF_INTEREST_AUTO,
> > > > > > +             .entity         = UVC_GUID_UVC_CAMERA,
> > > > > > +             .selector       = UVC_CT_REGION_OF_INTEREST_CONTROL,
> > > > > > +             .size           = 16,
> > > > > > +             .offset         = 64,
> > > > > > +             .v4l2_type      = V4L2_CTRL_TYPE_BITMASK,
> > > > > > +             .data_type      = UVC_CTRL_DATA_TYPE_BITMASK,
> > > > > > +             .name           = "Region Of Interest Auto Controls",
> > > > > > +     },
> > > > > >  };
> > > > > >
> > > > >
> > > > > Wouldn't be better to use 8 V4L2_CTRL_TYPE_BOOLEAN controls for this?
> > > >
> > > > If I create 8 Booleans, they will always be shown in the device. And
> > > > the user will not have a way to know which values are available and
> > > > which are not.
> > > >
> > > > We will also fail the v4l2-compliance test, because there will be up
> > > > to 7 boolean controls that will not be able to be set to 1, eventhough
> > > > they are writable.
> > > >
> > >
> > > And can't it be that only those returned by GET_MAX be added?
> > >
> > > ```
> > > The bmAutoControls bitmask determines which, if any, on board features
> > > should track to the region of interest. To detect if a device supports
> > > a particular Auto Control, use GET_MAX which returns a mask indicating
> > > all supported Auto Controls.
> > > ```
> > >
> > > Sorry for the misunderstanding, I just don't quite understand.
> >
> > I guess we could, but we would have to make a big change in the way
> > the controls are probed today. uvc does not use the control framework.
> >
> > What will be the benefit of using 8 controls?
> > - Applications still have to know what those controls do, they should
> > not rely on the control name.
>
> Applications like v4l2-ctl are not aware of every controls, work by
> control type, and let the user decide what to do, based on the name.
>
> To avoid having to know each bitmask type control, they need to be able
> to query which bit means what and what to display to the user.
>
> Could VIDIOC_QUERYMENU be supplemented with this?

I believe that violates compliance. VIDIOC_QUERYMENU should only be
used on menus.
https://git.linuxtv.org/v4l-utils.git/tree/utils/v4l2-compliance/v4l2-test-controls.cpp?h=v4l-utils-1.28.1#n143

>
>
> > - Changing from lets say AUTO_EXPOSURE to AUTO_FOCUS, will require to
> > send at least 2 controls via v4l2_s_ext_control... I think it is more
> > practical and less prone to errrors to send just one control
> >
>
> Yes, that could be a good reason.
>
> Thanks,
> Gergo
>
>


-- 
Ricardo Ribalda

