Return-Path: <linux-kernel+bounces-204074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 603738FE3A8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 757271C21040
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF311802A0;
	Thu,  6 Jun 2024 09:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ly7SLx6x"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680DE17FAC5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717667893; cv=none; b=YW1ux4eEzt7fVA1G9XB3tKLGz8Zvulv3yLoIIZzpta99wHiEhP1bMqzUVnQ9068DM4wc4klRjlFRRV/ibnVBlyGnF+0HGv7CQomZVshWb13oT1cvXsAqBLdZd/HX/xbsRLnv577B6vUtt8J4ZsCK5632rA98rGq3ZTYPf7WWNu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717667893; c=relaxed/simple;
	bh=PK/Yr00ssDR4VQl+Nq6ESa54g10t7lTOOMbDa1l6uRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m7OkryzlN70cFuhlVj0ntnLDp2Sui9qzU+wRqgiP1qVhub3t1gisjfdgi4WY1qDJQ2h5Se8BQFtLTWcwMsDng0CZguClz9Yhez0lcozWqAdP65KDQYHVNVNoWaG4MzULpWoh+1LGxh498UZBa5PmU34AODHDGlEG/l2J72V4Qfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ly7SLx6x; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-62a08091c2bso7304287b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 02:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717667890; x=1718272690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWM8oINC8AeyIZo0cnk7DqiORcHA5KDENrV1ggbh44E=;
        b=Ly7SLx6xheph+G4IchYnlt3iItKRc0AQGU493g1cMoSEymH9s9OLSP7PPaliJCzwDK
         fYdXPHOfIjHk9x6j6mr3PrkayIh8d9cPVqGblsTC1+2UCGzJX5lqY79JHVbdWz8roiTo
         lepRn6Ml5OA93I9ManH8Es5WImME3uV82RcnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717667890; x=1718272690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWM8oINC8AeyIZo0cnk7DqiORcHA5KDENrV1ggbh44E=;
        b=Fs2xnZ3ANukYiNcKH94e9y6hxx9OVswxHncar/x2IkBLHHpW9VY9CV9NzWiKI3cjkm
         y++u1kSuFnJHvKIyuhYRypEFFaV57c5zQqxjdXEpPYgB3mJ7u54BuHK1OVAgNOIgAnVy
         CJMt0v0zqw7cs0e93bj1p+BI3G3nfeJP0TRL1Xx58q38VaKCUNzP6qqfdIvQTwdkHSpG
         qKnXVr/sH4UVfJrx54jymleU4TMhLMPM5tuMRQDIF4zilzQzzhZmV337TSRU1ze2AvS7
         /cqAoAzbsZDSrQxLd5hi5vWP2TFkappvmj0PiP8FW0rXcISAOcIhoRqzmuOE1F5ynRIn
         hPSw==
X-Forwarded-Encrypted: i=1; AJvYcCUyT8wr+VnzUqt4/0VRPXSyL85DtbkSE96gt0kgCnIFnLo3pe2bah7BdVgT2NViZ0Icbef9uhy3DeUhje07jcinkwC86S5u8W2BZ18G
X-Gm-Message-State: AOJu0YyKuoCZP/Uune4XQPUzJpfJ5eVdOhALrg+j3tcaK4FyzCn0PcHA
	UWWxg7mn1j8u/ctFcFFi8ZBsyCaqgY77LS/LqVZ6UEUmTo3lxbcUGXMt6qYqd5g8LRAuIAE8sk9
	Slg==
X-Google-Smtp-Source: AGHT+IFXBU+7Bc1YfaK+JGOSU4FTLmI1IXzSRVVsSvoQ+b/5JUE2qPKnS0vib9NOU+ZgILyt9j59qQ==
X-Received: by 2002:a0d:c082:0:b0:615:1527:aa2 with SMTP id 00721157ae682-62cbb4aa81fmr47692307b3.10.1717667889800;
        Thu, 06 Jun 2024 02:58:09 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62ccacadb63sm1897467b3.20.2024.06.06.02.58.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 02:58:09 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-62a2424ecdaso7754757b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 02:58:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjXKiWXIAqRMDlESnXB9YGQfzCw372ggTiVSoH52S5jwty3Jt9KyJxtoT303r7MEm8G0u3BEPlJGEex2oizEiNTY1JpItBnaUjAjiW
X-Received: by 2002:a81:f806:0:b0:61b:3484:316b with SMTP id
 00721157ae682-62cbb4d423dmr48382467b3.14.1717667887633; Thu, 06 Jun 2024
 02:58:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327-guenter-mini-v4-0-49955c198eae@chromium.org> <20240327-guenter-mini-v4-1-49955c198eae@chromium.org>
In-Reply-To: <20240327-guenter-mini-v4-1-49955c198eae@chromium.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 6 Jun 2024 18:57:50 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BhJExCEA7_Ck2skWR52baSDH63-+oEZnpo4UiMc0C7=A@mail.gmail.com>
Message-ID: <CAAFQd5BhJExCEA7_Ck2skWR52baSDH63-+oEZnpo4UiMc0C7=A@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] media: uvcvideo: stop stream during unregister
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
	Max Staudt <mstaudt@chromium.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Alan Stern <stern@rowland.harvard.edu>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Paul <seanpaul@chromium.org>, Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ricardo,

On Wed, Mar 27, 2024 at 5:24=E2=80=AFPM Ricardo Ribalda <ribalda@chromium.o=
rg> wrote:
>
> uvc_unregister_video() can be called asynchronously from
> uvc_disconnect(). If the device is still streaming when that happens, a
> plethora of race conditions can happen.
>
> Make sure that the device has stopped streaming before exiting this
> function.
>
> If the user still holds handles to the driver's file descriptors, any
> ioctl will return -ENODEV from the v4l2 core.
>
> This change make uvc more consistent with the rest of the v4l2 drivers
> using the vb2_fop_* and vb2_ioctl_* helpers.
>
> Suggested-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>

First of all, thanks for the patch. I have a question about the
problem being fixed here.

Could you point out a specific race condition example that could
happen without this change?
From what I see in __video_do_ioctl((), no ioctls would be executed
anymore after the video node is unregistered.
Since the device is not present either, what asynchronous code paths
could be still triggered?

[1] https://elixir.bootlin.com/linux/latest/source/drivers/media/v4l2-core/=
v4l2-ioctl.c#L3023

Best regards,
Tomasz

> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/u=
vc_driver.c
> index bbd90123a4e76..17fc945c8deb6 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -1911,8 +1911,19 @@ static void uvc_unregister_video(struct uvc_device=
 *dev)
>                 if (!video_is_registered(&stream->vdev))
>                         continue;
>
> +               /*
> +                * Serialize other access to the stream.
> +                */
> +               mutex_lock(&stream->mutex);
> +               uvc_queue_streamoff(&stream->queue, stream->type);
>                 video_unregister_device(&stream->vdev);
>                 video_unregister_device(&stream->meta.vdev);
> +               mutex_unlock(&stream->mutex);
> +
> +               /*
> +                * Now the vdev is not streaming and all the ioctls will
> +                * return -ENODEV
> +                */
>
>                 uvc_debugfs_cleanup_stream(stream);
>         }
>
> --
> 2.44.0.396.g6e790dbe36-goog
>

