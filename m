Return-Path: <linux-kernel+bounces-409914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DA09C933D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 890B0B244BE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9313A1ABEB1;
	Thu, 14 Nov 2024 20:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gUT7Kpb4"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CF519D88B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 20:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731616120; cv=none; b=cnyZwSg2SQakz9HtK4lONlxXwUfET9HAhEw/IO0R3RaqbeAHx3pjc9AkAv6hVrKvsej8LrSeR9aH8sp+PA8404wx3AmmwDVQuFfJTKw3+66VO+boDNNZvRUU+leF9HGOo38sBv1eu6lTalvbHhiSXZOgnolrMUkftfuab6A+H1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731616120; c=relaxed/simple;
	bh=w1u4Uyb/SQOcpw1mSQ6P4Uwc6enMvc/XYLFFajv2k1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SWb2YgLHAOHDSLqM1Iw4z1rbwNa+7J8ZFwYfXrIOZnrZvmZi478MumwE4BlN5YFr1YYozLxQZEhiVTsc/aBZtSXNcHIyHw53h0+L4mF7Y1b2YrJi4hkBURAK+hPqhNipG9ifiSv/LBAHeh2hu3ybWT79WfnpbwBytHn0SqGip9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gUT7Kpb4; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2113da91b53so8327325ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731616118; x=1732220918; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AkkLbiFPwWQ3xXOH74J4v3WAHG7SRFPdjEarBusMciQ=;
        b=gUT7Kpb4+mdy+rvn95xqSUkydp3CCyt2ZIBzu6fZQ9RjDa5c9wB+gRCcLk9lVEcqHA
         L+wxp5Sh4UZjs51XX89zDx1jP66sZzqNFpe90DHpBHe+c8unO622eRInf8V3Faf8lyWz
         DRV04a0c2M3QsreNtjxH1cpEeCzJdHEZjm3uM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731616118; x=1732220918;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AkkLbiFPwWQ3xXOH74J4v3WAHG7SRFPdjEarBusMciQ=;
        b=fNUNSBt7QAJnkHyObUR26kn25i0zO+UV+EHbp1VPqNG3EJpoi2y04Y4FU4zMRuJbJe
         NJ68F/y4lymMnx1ZuHKHaRO1nI8jzPE+2ufxOLU1yvUE50Pid9QxI3KFBsJPYOl3u6A4
         0sCX5zSa8pCYl+utA7b0P3ETkgFMDIjmmKtoHjUZ2vSINLdhQGhlykk27jfB++nzdUfR
         QyQlh5gAUemAx595yU7mYmkbgPnX1E6MmI6VWuL8t2wo/jierhtQfBJ3F+lUjIH9B8nR
         FYwb4YWUvrpFEP8LGEhTYPCp/srNh3mD0TIXo3RkJZMmjaEs4JQOivhtnQcKhOkh36t1
         T3QA==
X-Forwarded-Encrypted: i=1; AJvYcCVRJ2x8SC7za8jl/AoWaNCgUy1s2ZDUIik6uGHziIzEk2bTnNd2ZZkNaJBPbw215xyOgrVXC7O8Mr9oVEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv1j1Fdhn2VbxnxASDEP4EzDGODKwj2KFWwnP+a1sGEsHpAzJT
	Aa+WkY8gyjbU5WXKBgRgTZJKRIk5MfxbzfWhuKjAvLHSwe1OmgtVcs6UzxjBFaaEk/2gV+/ibp8
	=
X-Google-Smtp-Source: AGHT+IFu4wEmCQyyWZ5pO3csaLyKJk5VuFAshs7kRbtPDo0yIDza9lI5luqOKzxlrgqJipvrSQlcFA==
X-Received: by 2002:a17:903:2452:b0:20e:5997:c107 with SMTP id d9443c01a7336-211d0ec2dbfmr1847285ad.39.1731616118325;
        Thu, 14 Nov 2024 12:28:38 -0800 (PST)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com. [209.85.215.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f34809sm322165ad.124.2024.11.14.12.28.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 12:28:37 -0800 (PST)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ea9739647bso800961a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:28:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV0qh3w6W/6BKzci6BO6REqaDN37H4T1KEIy5QsSw11JtrlCTTov/u2Gyd7+8HgB4iyLYo07e/+gSIGGkM=@vger.kernel.org
X-Received: by 2002:a05:6a21:6d9c:b0:1cf:3677:1c4a with SMTP id
 adf61e73a8af0-1dc90b308ffmr73503637.16.1731616117054; Thu, 14 Nov 2024
 12:28:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org>
 <20241114-uvc-roi-v15-18-64cfeb56b6f8@chromium.org> <ac8ea4ed606cbc7dfb15057babc29e49a152ef01.camel@irl.hu>
 <CANiDSCuZTYDsQ3yCpFV_rhbQ+vFGJnsuU-jXwOacxZVbbzEPfw@mail.gmail.com> <5ffafb0d059f09c814692e7c33a7ce35ce9b0169.camel@irl.hu>
In-Reply-To: <5ffafb0d059f09c814692e7c33a7ce35ce9b0169.camel@irl.hu>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 14 Nov 2024 21:28:24 +0100
X-Gmail-Original-Message-ID: <CANiDSCvP5eVuSGMi3R4eAkY2-ou=nqrTS1dnAv0Odbcq5UHa+w@mail.gmail.com>
Message-ID: <CANiDSCvP5eVuSGMi3R4eAkY2-ou=nqrTS1dnAv0Odbcq5UHa+w@mail.gmail.com>
Subject: Re: [PATCH v15 18/19] media: uvcvideo: implement UVC v1.5 ROI
To: Gergo Koteles <soyer@irl.hu>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
	Ricardo Ribalda <ribalda@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Yunke Cao <yunkec@chromium.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yunke Cao <yunkec@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi

On Thu, 14 Nov 2024 at 21:16, Gergo Koteles <soyer@irl.hu> wrote:
>
> Hi Ricardo,
>
> On Thu, 2024-11-14 at 21:03 +0100, Ricardo Ribalda wrote:
> > Hi Gergo
> >
> > Sorry, I forgot to reply to your comment in v14.
> >
> > On Thu, 14 Nov 2024 at 20:53, Gergo Koteles <soyer@irl.hu> wrote:
> > >
> > > Hi Ricardo,
> > >
> > > On Thu, 2024-11-14 at 19:10 +0000, Ricardo Ribalda wrote:
> > > >
> > > > +     },
> > > > +     {
> > > > +             .id             = V4L2_CID_UVC_REGION_OF_INTEREST_AUTO,
> > > > +             .entity         = UVC_GUID_UVC_CAMERA,
> > > > +             .selector       = UVC_CT_REGION_OF_INTEREST_CONTROL,
> > > > +             .size           = 16,
> > > > +             .offset         = 64,
> > > > +             .v4l2_type      = V4L2_CTRL_TYPE_BITMASK,
> > > > +             .data_type      = UVC_CTRL_DATA_TYPE_BITMASK,
> > > > +             .name           = "Region Of Interest Auto Controls",
> > > > +     },
> > > >  };
> > > >
> > >
> > > Wouldn't be better to use 8 V4L2_CTRL_TYPE_BOOLEAN controls for this?
> >
> > If I create 8 Booleans, they will always be shown in the device. And
> > the user will not have a way to know which values are available and
> > which are not.
> >
> > We will also fail the v4l2-compliance test, because there will be up
> > to 7 boolean controls that will not be able to be set to 1, eventhough
> > they are writable.
> >
>
> And can't it be that only those returned by GET_MAX be added?
>
> ```
> The bmAutoControls bitmask determines which, if any, on board features
> should track to the region of interest. To detect if a device supports
> a particular Auto Control, use GET_MAX which returns a mask indicating
> all supported Auto Controls.
> ```
>
> Sorry for the misunderstanding, I just don't quite understand.

I guess we could, but we would have to make a big change in the way
the controls are probed today. uvc does not use the control framework.

What will be the benefit of using 8 controls?
- Applications still have to know what those controls do, they should
not rely on the control name.
- Changing from lets say AUTO_EXPOSURE to AUTO_FOCUS, will require to
send at least 2 controls via v4l2_s_ext_control... I think it is more
practical and less prone to errrors to send just one control

If the number of autos were unknown, then having multiple controls
could be a good idea, but they are part of the uvc standard and
unlikely to be changed.


Thanks!
>
> Thanks,
>
> Gergo



-- 
Ricardo Ribalda

