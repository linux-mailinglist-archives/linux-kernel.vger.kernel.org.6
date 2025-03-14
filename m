Return-Path: <linux-kernel+bounces-561192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F091BA60E9A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6CEC3B2828
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C761F418E;
	Fri, 14 Mar 2025 10:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QoWRGuZy"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DE81F30CC
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947458; cv=none; b=H24s7qBzzaqWCJFj62e1kntfA3ud1EHLtuUWi7TvTSLXy7ukOjBpLz65zTuzeKwzJAECYSbxM5z3jV8YbrmXqj1b6/ucK2qh7gZXsVPsb0fKM71WvFA3ey+JZQRJpi5IkpevL/W1FNHKWss6mUOpm6LrV/pPE8DnM+uyKF5swpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947458; c=relaxed/simple;
	bh=SHvxG4U/t4MAKWu3QBRXuQRdvpbSKp4HtfYs/YjTz54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NXf0Zkn+IsYvy30kNvMde1MUUCgGc8DTwwRt1wUA+oF74gnNEvVLk1Q0njKIyEZt1eiQ8yXfcFmfH9zMDz9TGDHReW6iJyqDo3i1qIC9DZa4fl1svj84kg+vTGm0Nqev09I4yE/PtpmuZPy8qGBlCoP1JSG0bAW9e6oGYQq9VWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QoWRGuZy; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-543d8badc30so2218781e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741947454; x=1742552254; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BPOkp6EW8yihrul0VeKT4eelAXrH0oyo+XW5bxSEhIQ=;
        b=QoWRGuZy7M3tgMQnUu/qr3vF/1p3yf2YH1NgKe+KIe9RGNgCrD33uluK9XUvlK9m5Y
         f2ez9k89ORPfxOCCHhuHqzTJLuPsCMoLuksTpwICrK4kl+sKaONKwDG8FG0AusXrDvyO
         0Sy62SvF8SOjg8VWaKxhM/sgF0t3MamhgpsKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741947454; x=1742552254;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BPOkp6EW8yihrul0VeKT4eelAXrH0oyo+XW5bxSEhIQ=;
        b=HbAWW4Fm5Vj9NAys3HJ55lMEmMUdgibKAcsUuzZe7qbS1qAexpoYLZ8piTVl38xNi6
         V+Ln+Qd0Ge92pjLOpHg5/b76alIR7kujR4pKRfkOskLWiROS0YUWpO5/p4GWxn1l6JHC
         X3K+yB8F7GCraMjq5aV4dFsNqPeOE5v9N65xRn6/sclD64d3F44pOF5Nk1b8H6Dm9YLu
         EZIXksX6BBXisphRobyuY4ffPqL8JL4fyXrKOurewFYRVR9B8qudxzL8RSzd4bxS0ybG
         DM9DyrmWbtNJaV2Yrs6s32eSQqFisgeOpRU7Yl6Ap9z7uu/gAG1g6SI/WhpA7x2Fwg0N
         y7FA==
X-Forwarded-Encrypted: i=1; AJvYcCWg4KtGYAzpph0OgJnWK5Qr76ICYq2RaJ/ajcd/LDyHb65botpXOiYWCk8OHYxsTWadyte0zRGHI1daWp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtR3QzV+qjpQU0IGfJ7y1VZMF1/6s2NwWheOfgg7IXljfUb9th
	po6ccja3q6IJyEQhoDWpxNJIjo3q/O5+m6eWjBx7t31MOm/HIJX2mF60ngoVbDwtCquMw/zBXh6
	58Q==
X-Gm-Gg: ASbGnctKtiVxbxoyUzb3jfgCaTrfqaQTEvQPfybPfLa9XxZ28zOY/xEPY2H8+R8SW2F
	xcc2R6BY3pCsTimw/T6teWFlAOyhAVIIbZspRdk8B51n5UkL6dwWHm2rzBuPrf74os2qn0nAa9c
	/E5hFd4MEg9UB5xTN+EDgz1jibrkaU5Yl8l/YIQ6ntgF1Ic4rPeFv1owLG3Y6wy68947rKYK/Jl
	69lDvMuZJKiKjKhSHGJYsh2teSBGpGWG12R8ON+TbbCtL9bc7Fd6yAKLyyNQ17FVX9HwteVO6h2
	w6RHenUMajtLtZbLZNfVHd9XFLutGL9k18fINEmlIZaIW8IDu1/dX8tcrsudfFK2lIj1a5Z2Uge
	0L+bkhXo=
X-Google-Smtp-Source: AGHT+IGmADKxHKuPKC4KeCOzesWm4ChDMLtEw/qIY5lMDdY/koJF8S0KOSFW9hocyCj+irUt+kqn/A==
X-Received: by 2002:a05:6512:2823:b0:545:5a5:b69f with SMTP id 2adb3069b0e04-549c38f542bmr545291e87.9.1741947453853;
        Fri, 14 Mar 2025 03:17:33 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba88577csm471952e87.205.2025.03.14.03.17.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 03:17:33 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-543d8badc30so2218757e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:17:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXkKNcP1zEHMiGBOCIzcCtp/kyS/1DMExdAI1JxL7uovjQ21XaoxECOjRKkvv+1wZX2u3UMwo1HpXSmeA=@vger.kernel.org
X-Received: by 2002:a05:6512:2250:b0:545:2fa9:8cf5 with SMTP id
 2adb3069b0e04-549c39aebb7mr722856e87.49.1741947452607; Fri, 14 Mar 2025
 03:17:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313-uvc-metadata-v3-0-c467af869c60@chromium.org>
 <20250313-uvc-metadata-v3-3-c467af869c60@chromium.org> <20250314073456.25817a3d@foz.lan>
 <CANiDSCuNzwqhYOORqY+PGUbK8=tqxm6stpzQC3BFYF7pxgRG6w@mail.gmail.com> <20250314090919.GE19612@pendragon.ideasonboard.com>
In-Reply-To: <20250314090919.GE19612@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 14 Mar 2025 11:17:19 +0100
X-Gmail-Original-Message-ID: <CANiDSCtxNwTrQrx6naDUYJOg3S4Osr7CbN6pbJ53HO_3AdpN3g@mail.gmail.com>
X-Gm-Features: AQ5f1Jowa8v-a-YSWeZV9kM_kjV-xZvNmmBT51ULGBfXtvwUWk2GiqsWtYFwj5E
Message-ID: <CANiDSCtxNwTrQrx6naDUYJOg3S4Osr7CbN6pbJ53HO_3AdpN3g@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] media: uvcvideo: Introduce V4L2_META_FMT_UVC_CUSTOM
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hans de Goede <hdegoede@redhat.com>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Mar 2025 at 10:09, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> On Fri, Mar 14, 2025 at 09:28:34AM +0100, Ricardo Ribalda wrote:
> > On Fri, 14 Mar 2025 at 07:35, Mauro Carvalho Chehab wrote:
> > > Em Thu, 13 Mar 2025 12:06:27 +0000 Ricardo Ribalda escreveu:
> > >
> > > > The UVC driver provides two metadata types V4L2_META_FMT_UVC, and
> > > > V4L2_META_FMT_D4XX. The only difference between the two of them is that
> > > > V4L2_META_FMT_UVC only copies PTS, SCR, size and flags, and
> > > > V4L2_META_FMT_D4XX copies the whole metadata section.
> > > >
> > > > Now we only enable V4L2_META_FMT_D4XX for the Intel D4xx family of
> > > > devices, but it is useful to have the whole metadata section for any
> > > > device where vendors include other metadata, such as the one described by
> > > > Microsoft:
> > > > https://learn.microsoft.com/en-us/windows-hardware/drivers/stream/mf-capture-metadata
> > > >
> > > > This patch introduces a new format V4L2_META_FMT_UVC_CUSTOM, that is
> > > > identical to V4L2_META_FMT_D4XX but it is available to all the UVC
> > > > devices.
> > > >
> > > > Suggested-by: Hans de Goede <hdegoede@redhat.com>
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > ---
> > > >  .../userspace-api/media/v4l/meta-formats.rst       |  1 +
> > > >  .../userspace-api/media/v4l/metafmt-uvc-custom.rst | 31 +++++++++++++++++
> > > >  MAINTAINERS                                        |  1 +
> > > >  drivers/media/usb/uvc/uvc_metadata.c               | 40 ++++++++++++++++++----
> > > >  drivers/media/v4l2-core/v4l2-ioctl.c               |  1 +
> > > >  include/uapi/linux/videodev2.h                     |  1 +
> > > >  6 files changed, 69 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/Documentation/userspace-api/media/v4l/meta-formats.rst b/Documentation/userspace-api/media/v4l/meta-formats.rst
> > > > index 86ffb3bc8ade2e0c563dd84441572ecea1a571a6..9fd83f4a3cc8509702a2a9f032fdc04bf6c6d1bc 100644
> > > > --- a/Documentation/userspace-api/media/v4l/meta-formats.rst
> > > > +++ b/Documentation/userspace-api/media/v4l/meta-formats.rst
> > > > @@ -19,6 +19,7 @@ These formats are used for the :ref:`metadata` interface only.
> > > >      metafmt-pisp-fe
> > > >      metafmt-rkisp1
> > > >      metafmt-uvc
> > > > +    metafmt-uvc-custom
> > > >      metafmt-vivid
> > > >      metafmt-vsp1-hgo
> > > >      metafmt-vsp1-hgt
> > > > diff --git a/Documentation/userspace-api/media/v4l/metafmt-uvc-custom.rst b/Documentation/userspace-api/media/v4l/metafmt-uvc-custom.rst
> > > > new file mode 100644
> > > > index 0000000000000000000000000000000000000000..9f150fc2b6f379cc4707ff45041dd014956ae11a
> > > > --- /dev/null
> > > > +++ b/Documentation/userspace-api/media/v4l/metafmt-uvc-custom.rst
> > > > @@ -0,0 +1,31 @@
> > > > +.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
> > > > +
> > > > +.. _v4l2-meta-fmt-uvc-custom:
> > > > +
> > > > +*********************************
> > > > +V4L2_META_FMT_UVC_CUSTOM ('UVCC')
> > > > +*********************************
> > > > +
> > > > +UVC Custom Payload Metadata.
> > > > +
> > > > +
> > > > +Description
> > > > +===========
> > > > +
> > > > +V4L2_META_FMT_UVC_CUSTOM buffers follow the metadata buffer layout of
> > > > +V4L2_META_FMT_UVC with the only difference that it includes all the UVC
> > > > +metadata, not just the first 2-12 bytes.
> > > > +
> > > > +The most common metadata format is the one proposed by Microsoft(R)'s UVC
> > > > +extension [1_], but other vendors might have different formats.
> > > > +
> > > > +Applications might use information from the Hardware Database (hwdb)[2_] to
> > > > +process the camera's metadata accordingly.
> > >
> > > Having something like that at the userspace API shouldn't be handled
> > > lightly. This sounds to me that passing a blank check for vendors to stream
> > > whatever they want without any requirements to provide and sort of
> > > documentation for the usersace to decode it.
> >
> > As HdG previously mentioned, all the processing is done in the camera
> > so the metadata is not going to hide highly secret required for
> > processing:
> > https://lore.kernel.org/linux-media/67c1a857-7656-421f-994c-751709b6ae01@redhat.com/
>
> Without judging whether or not such an undocumented format should be
> supported by the driver, a correction is needed here: the issue is not
> "secrets required for processing", but giving closed-source application
> an unfair advantage.

We could argue that vendors already have the possibility to pass
secrets to userspace:
- A camera could add proprietary information inside the frame, only
parseable by a closed-source application
- They can use undocumented UVC controls
- They can exploit documented controls to do something else that they
are designed for.
Given these existing possibilities, I question whether "evil metadata"
 offers any fundamentally new capabilities that cannot be achieved
through these established methods.

If we have to talk about unfair advantage, Linux is at an unfair
advantage right now: there is no way to use the *documented*
information provided by the metadata. Other OSs can use it.
The way I see it, with this artificial limitation we are not blocking
evil vendors but punishing good users.

if it makes you feel more comfortable we can start enabling only
V4L2_META_FMT_UVC_CUSTOM (or V4L2_META_FMT_MSXU_UVC_1_5 as proposed by
Mauro) to devices that support MSXU_CONTROL_METADATA, the future
ChromeOS XU, or quirks. But that artificial limitation will hurt a lot
of current cameras for no real reason.

>
> > > Also, it would be hard for userspace to distinguish what metatata
> > > is contained for a random UVC camera. Please let's not do that.
> >
> > Userspace will use hwdb info to properly parse the metadata.
>
> I don't have experience with that, so I would like to see the effort
> being started on hwdb support to see how it will look like before we
> merge this patch. A few cameras should be added as examples, and a
> stategy to ensure the hwdb will be properly populated should be
> proposed.

We can start by mapping the D4XX cameras. D4XX format follows
Microsoft standard.

Would that work for you?

>
> > > As the specific issue here is to support an already known extension,
> > > which is already documented, Just add an specific format for it, e.g.
> > > you could add something like that at the documentation:
> >
> > The problem here is how do we know from the driver if a device
> > supports V4L2_META_FMT_MSXU_UVC_1_5 or not.
> >
> > In Windows it seems that vendors add that information to the device
> > .inf file. That is equivalent to the hwdb proposal.
> > In ChromeOS we are trying to push vendors to use an extension saying
> > if there is metadata or not. But that will take some time to land and
> > there are thousands of modules out there not ChromeOS compliant.
> >
> > >
> > >         V4L2_META_FMT_MSXU_UVC_1_5
> > >            Microsoft extensions to USB Video Class 1.5 specification.
> > >
> > >            For more details, see: https://learn.microsoft.com/en-us/windows-hardware/drivers/stream/uvc-extensions-1-5
> > >
> > > And then add the corresponding format to V4L2 API.
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

