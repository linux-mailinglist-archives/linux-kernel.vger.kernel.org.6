Return-Path: <linux-kernel+bounces-425977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAEB9DED35
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 23:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EB48B21B00
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 22:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176331A08CA;
	Fri, 29 Nov 2024 22:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a7Ao8aBD"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6823156F2B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 22:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732918751; cv=none; b=lYD/a8ZXfrOF7Xb55lMjzV4Rucsxx1ZWER01COvjy1/9ACpUJLXOBnVPb5Ujgpz5rtYBtG+4jMjBA1oyfjzS84JCtxJBlouhFRAOy8CU9kkUntkYGek04QxjJ1y2HKrQnIWOXO0/4lWQKGK2FoLYba/RfKPGAijGQOYvAIVsovI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732918751; c=relaxed/simple;
	bh=vEKjGTkYVhfnz5owgv3+b9nsmE+0qOZCKZ0+m2kHulE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OmkG2FaA8P4k7iXkIOkepYgH4PiDrYUazIlJbAXJoKomJ8u+VV8MYK12CVNZ6lFywOra9kzy8MN5wdIjBHwttsmJKWoyoNhM/QNiZB67e6OdsgSg7VWTvEakuiIpAEX/BZdu4TcAOgLOLRftJooQeyCYV3Sxi+js1EpQqJl0bag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=a7Ao8aBD; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-724e5fb3f9dso2069485b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 14:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732918748; x=1733523548; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x/UwWvzboXwaTQVa3UMHS8RQfD6Akh8wwGfMsFYt7QM=;
        b=a7Ao8aBDaeEfQlLI3o8qviUbkQBiPLKFDMvtnx5RunUyx0lGWg/piqBvlIopxEchy4
         sfoERPV+MUnSQMTVAfQBhHimh/LY8U3dFqm2w6J5ZmetC7Tc4WgSRi9p8pe6cmj6xK7B
         cobcBgvh7WXuGXcUCkzIklkAIkmVfN1bykvoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732918748; x=1733523548;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x/UwWvzboXwaTQVa3UMHS8RQfD6Akh8wwGfMsFYt7QM=;
        b=k3P+gegSf+mcF6XDQgGOxLqu+Ys6fE63p8VnBcwK5+Xqg7lG/A3VO1xro/4iMoz2eF
         7fGWNuGdLHJTDB1h7vleRDDDWsS7XUG7xvz4fn19xrtHw4Z4+BwD2+HEcEwq39ZxklQc
         u43vCPsNiFu7ryU3X0ju+NpAuOTS1RDr5FUkShW+tkNdokZRgmWXpARLTSn5joyGcVaT
         PodHiDfchwbSny7GXlb/J2oxh3RAaBwR0TTIho9lu0k/TNS6TBj9Mlos0A6sgQudjbuS
         6Kz+bE9j+nkWi81+d+IpkXGjobPYv7ovJhWQNy0YOFQmiscV6dJ4jnABf9RmpKQrrzFB
         B/fQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvnlW9qehb8Kz5u9itXDN+hr3uKMjgnOW4LaxiqSGklKVcdeppr7nNVSM+DjzyX83/ztVCL1M61i8DBdk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx7FzBE2jXm2ndMVQFynfBIHmToM+swj7u4XNbPPe3OnARZKbG
	LAZtIrL/sSQD/+wLBnWvZAaTYjWeV37fqk+Js4/BgCIBd5oYgdKNOHJ2VMPsexiJiNwwZp+eh20
	=
X-Gm-Gg: ASbGncv93JMCzVxOcBsNM1Ew/eVYViXN+G33xRguc5YnU4J/Qugl/CMlx+YVrHwPwB/
	JzWZwcXb+iXkP+NCNjA73UxZi9jo/NdmuKNWdK83DkjFm+EwmOevA2UEoaUkRUOd71b6mVsFdi7
	FgzQVMxRXnGIvrgSnaVsQSAs6Dr5liL/5MdDLneivovoi3Pqlroq8f8VZgcezp4GDCZ3aoKqh59
	Euj6uoB24S0C+9FeanQlD9PRwveiLi4qdjETUb7ovYKi+/mdqEEtFXcmBYHMEiQT/fimcqq1ZnV
	jE/bH8xvSRUlvUjy
X-Google-Smtp-Source: AGHT+IEsZ6uJO+vrYN9mbbb0A/YfK3zQ5pXajRJlHgZXEzUFH6U9iDlISvSqMMUtwyPp2NS6YMenlA==
X-Received: by 2002:a05:6a00:14d5:b0:724:63f1:a522 with SMTP id d2e1a72fcca58-7253017551amr18613443b3a.22.1732918748649;
        Fri, 29 Nov 2024 14:19:08 -0800 (PST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com. [209.85.210.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417612fesm3983876b3a.14.2024.11.29.14.19.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 14:19:07 -0800 (PST)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-724e5fb3f9dso2069468b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 14:19:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqKkhQD24lmcwQY4sujeO6rxjjDg/RHuo8K4lPNvPBoq6dQBVQuu3hZKIl/bGHYi/gH+/pCR6uQAY/89c=@vger.kernel.org
X-Received: by 2002:a17:90b:3e86:b0:2ea:9ce1:d143 with SMTP id
 98e67ed59e1d1-2ee08eb0640mr16580627a91.11.1732918746928; Fri, 29 Nov 2024
 14:19:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128222232.GF25731@pendragon.ideasonboard.com>
 <CANiDSCvyMbAffdyi7_TrA0tpjbHe3V_D_VkTKiW-fNDnwQfpGA@mail.gmail.com>
 <20241128223343.GH25731@pendragon.ideasonboard.com> <7eeab6bd-ce02-41a6-bcc1-7c2750ce0359@xs4all.nl>
 <CANiDSCseF3fsufMc-Ovoy-bQH85PqfKDM+zmfoisLw+Kq1biAw@mail.gmail.com>
 <20241129110640.GB4108@pendragon.ideasonboard.com> <CANiDSCvdjioy-OgC+dHde2zHAAbyfN2+MAY+YsLNdUSawjQFHw@mail.gmail.com>
 <e95b7d74-2c56-4f5a-a2f2-9c460d52fdb4@xs4all.nl> <CANiDSCvj4VVAcQOpR-u-BcnKA+2ifcuq_8ZML=BNOHT_55fBog@mail.gmail.com>
 <CANiDSCvwzY3DJ+U3EyzA7TCQu2qMUL6L1eTmZYbM+_Tk6DsPaA@mail.gmail.com> <20241129220339.GD2652@pendragon.ideasonboard.com>
In-Reply-To: <20241129220339.GD2652@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 29 Nov 2024 23:18:54 +0100
X-Gmail-Original-Message-ID: <CANiDSCsXi-WQLpbeXMat5FoM8AnYoJ0nVeCkTDMvEus8pXCC3w@mail.gmail.com>
Message-ID: <CANiDSCsXi-WQLpbeXMat5FoM8AnYoJ0nVeCkTDMvEus8pXCC3w@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] media: uvcvideo: Do not set an async control owned
 by other fh
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, Hans de Goede <hdegoede@redhat.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, 
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Nov 2024 at 23:03, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Fri, Nov 29, 2024 at 07:47:31PM +0100, Ricardo Ribalda wrote:
> > Before we all go on a well deserved weekend, let me recap what we
> > know. If I did not get something correctly, let me know.
> >
> > 1) Well behaved devices do not allow to set or get an incomplete async
> > control. They will stall instead (ref: Figure 2-21 in UVC 1.5 )
> > 2) Both Laurent and Ricardo consider that there is a big chance that
> > some camera modules do not implement this properly. (ref: years of
> > crying over broken module firmware :) )
> >
> > 3) ctrl->handle is designed to point to the fh that originated the
> > control. So the logic can decide if the originator needs to be
> > notified or not. (ref: uvc_ctrl_send_event() )
> > 4) Right now we replace the originator in ctrl->handle for unfinished
> > async controls.  (ref:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/media/usb/uvc/uvc_ctrl.c#n2050)
> >
> > My interpretation is that:
> > A) We need to change 4). We shall not change the originator of
> > unfinished ctrl->handle.
> > B) Well behaved cameras do not need the patch "Do not set an async
> > control owned by another fh"
> > C) For badly behaved cameras, it is fine if we slightly break the
> > v4l2-compliance in corner cases, if we do not break any internal data
> > structure.
>
> The fact that some devices may not implement the documented behaviour
> correctly may not be a problem. Well-behaved devices will stall, which
> means we shouldn't query the device while as async update is in
> progress. Badly-behaved devices, whatever they do when queried, should
> not cause any issue if we don't query them.

I thought we could detect the stall and return safely. Isn't that the case?
Why we have not seen issues with this?


>
> We should not send GET_CUR and SET_CUR requests to the device while an
> async update is in progress, and use cached values instead. When we
> receive the async update event, we should clear the cache. This will be
> the same for both well-behaved and badly-behaved devices, so we can
> expose the same behaviour towards userspace.

seting ctrl->loaded = 0 when we get an event sounds like a good idea
and something we can implement right away.
If I have to resend the set I will add it to the end.

>
> We possibly also need some kind of timeout mechanism to cope with the
> async update event not being delivered by the device.

This is the part that worries me the most:
- timeouts make the code fragile
- What is a good value for timeout? 1 second, 30, 300? I do not think
that we can find a value.


>
> Regarding the userspace behaviour during an auto-update, we have
> multiple options:
>
> For control get,
>
> - We can return -EBUSY
> - We can return the old value from the cache
> - We can return the new value fromt he cache
>
> Returning -EBUSY would be simpler to implement.
Not only easy, I think it is the most correct,

>
> I don't think the behaviour should depend on whether the control is read
> on the file handle that initiated the async operation or on a different
> file handle.
>
> For control set, I don't think we can do much else than returning
> -EBUSY, regardless of which file handle the control is set on.

ACK.

>
> > I will send a new version with my interpretation.
> >
> > Thanks for a great discussion
>
> --
> Regards,
>
> Laurent Pinchart

Looking with some perspective... I believe that we should look into
the "userspace behaviour for auto controls" in a different patchset.
It is slightly unrelated to this discussion.


-- 
Ricardo Ribalda

