Return-Path: <linux-kernel+bounces-542120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EB4A4C5DE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1B287A045A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0941C2C181;
	Mon,  3 Mar 2025 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fxF3UJMk"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE6E3C00
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017416; cv=none; b=pYYyrxe2n3oFD1A/Jm7KzxbAWVSxMv45gK0C7brnDYhUYQl+vlhlOaLXkEluvMKZQYmr5NaIYIoFiQf9TRrfIali/HHH8J6132zRs+6dlUgvY4hB7U5Rwakk4yGbNIqo0xNrpoc0626y9Owdh5jDDfsn+3s4ICx9JWMOERMk0NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017416; c=relaxed/simple;
	bh=9qmtvFryEe/ChfH0AvxH1kt0jg9xeu0JTLgLhy2M7IE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=slWXKuWstTmVPaug6qI7y3hUA3MuXpgMY4A4p3OO41PEQugQ+yG4A9OruB+zscpcr8PkqPmtUsNB8b4PlMni4YhoqaCHRSd8Pe//hqnFSnff0zmHqwtAGg4xO8E5K2MlztfvZBetUAKPlR2cDm2uAIB+szQ/LG2joYwYOM5Z2/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fxF3UJMk; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5496301c6afso1477661e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 07:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741017412; x=1741622212; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YGCynV2yWUEC6QIoDPAZAo2E73n5HQeexWCm9jKiqQw=;
        b=fxF3UJMkQUeNg6BllYIJ40UXpOh1khz3YTwoxqNXMd4lYr/cUlGiig3FdXtr/pjIJ/
         6tiOKXBOnysWrBDb4pXnrpMF3IBEDr+m9/80wZNZrK6FA8vXceSQjrlFc8OiCg47u9t0
         ubeR9ziZ3wFaGCV/HZ4+RiVpl/G+qxAP0TGBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741017412; x=1741622212;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGCynV2yWUEC6QIoDPAZAo2E73n5HQeexWCm9jKiqQw=;
        b=SBvyqLZl4WRNxvxuiZhbL0h7SSgNiXaL9pMLB0dWzy4hRzB7jb+C1Ngt0ZtA1Xl8hw
         JEo4N9JbnJm+taP8+r8HwiSqEMtiOXRmqKLyaguqLsUL3tfYxFMUp/SwyiT+DKhbHLf4
         l/mQ4RuhCK2uc5lgjihdMC0j/Vn27OoZxtY0kLli31rsHDZhtOCoLgORIutR8uKqcSeV
         P5UMVIkQYLuvs+W77lIZX5v4Yj1dLhEd9qNvY4Zi8ZovFg8qUzVAWoEaq+UyGAEyYQfu
         ZvpaSfYHClEo5++iUhTcfOWMFNgHrv5a993NbV/C/R8BA4izfkjmb+04EbZr9Hj/vhQL
         HV8w==
X-Forwarded-Encrypted: i=1; AJvYcCXbQreX7EI3j1SgJRls4SpOtxeHJRQfbgRAnGxUAkBWSgPZ3tSdmeU689hHUT/2LN0qH0+N45dq51L2UMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVREmYnfwxSwz/Xx1wpcJfpmrTYT9m6tPM/i13y62lqCc15LRQ
	FgbbqF5RBu0RSvhMDlPGzgEnsSD85UfxOgjgIs1Xtahc7HaoT584GgOfSJNoA0G62z6Ldt1T4+4
	=
X-Gm-Gg: ASbGnctntEKS/jhs+uSYsrvlkr6dFXpdbeY+EXTac1DUJf3GGsSpfINFWpauhIRmL7g
	IoUUDfgKwnGHwPEYbKNhUGF6/23uuUeECpzxU8vd+YBWEeyRW6yktO40W09VX+26Bht7zeX5mak
	lF+UTRhOIVO3p7fJ3I+8wDHFmrhTU2a6W8I7iwPfd4MjmH+DhJ8kmoviWZP30L9m4SLEyWZqUzj
	sqZr4G/a7mizZI+NkpEyruLtDPeOQIPcsglaBQqBzOm+qULmmMPp3gI7mj5DNLccvLt2kJfH59c
	kPDpItjSvOoaWzx+PpsA+irqYIg0jXNf1aT36GsXW4dfMhPgXOGI0gKZvomn+xHHnsRYYzBxP/e
	40e8tCXg=
X-Google-Smtp-Source: AGHT+IG4/wfkQpn03gbmWIeggIiBeuyotmn1Hlz0YY4qWz15d9jth5zGrsMEjJgqTj1VT7sk9ZZl9A==
X-Received: by 2002:a05:6512:3041:b0:545:6a2:e59 with SMTP id 2adb3069b0e04-5494c3339f1mr5181868e87.18.1741017412334;
        Mon, 03 Mar 2025 07:56:52 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5495637407esm987868e87.134.2025.03.03.07.56.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 07:56:52 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54959d1a856so2135616e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 07:56:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWom0rezEtrnHg7TUjHW7hbdiuHbtIhb3053o7UTbU/4Z1ACgSvy95jBHYCf/X14qkLRPYzbOU20Dnmxvk=@vger.kernel.org
X-Received: by 2002:a05:6512:3083:b0:549:6ae7:e679 with SMTP id
 2adb3069b0e04-5496ae7e8a0mr1635835e87.3.1741017411440; Mon, 03 Mar 2025
 07:56:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226-uvc-metadata-v1-1-6cd6fe5ec2cb@chromium.org>
 <c6ab8640-d96c-4a71-929a-a4ad6bb2647d@redhat.com> <20250303151346.GC32048@pendragon.ideasonboard.com>
 <1436dc95-68a6-456d-ab5d-117c7791ec48@redhat.com>
In-Reply-To: <1436dc95-68a6-456d-ab5d-117c7791ec48@redhat.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 3 Mar 2025 16:56:37 +0100
X-Gmail-Original-Message-ID: <CANiDSCtTeNhJ3u7hkmSgcUmKp+N5ThsAkSo2_JOz9QWALi=RTg@mail.gmail.com>
X-Gm-Features: AQ5f1JpxtSVd51UXd0agw5Uq4bRc8DMlReSJ_fhm3xRHEfQ7pu0K2rYHPmWz858
Message-ID: <CANiDSCtTeNhJ3u7hkmSgcUmKp+N5ThsAkSo2_JOz9QWALi=RTg@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Enable full UVC metadata for all devices
To: Hans de Goede <hdegoede@redhat.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi

On Mon, 3 Mar 2025 at 16:44, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 3-Mar-25 16:13, Laurent Pinchart wrote:
> > On Mon, Mar 03, 2025 at 03:47:51PM +0100, Hans de Goede wrote:
> >> On 26-Feb-25 14:00, Ricardo Ribalda wrote:
> >>> The UVC driver provides two metadata types V4L2_META_FMT_UVC, and
> >>> V4L2_META_FMT_D4XX. The only difference between the two of them is that
> >>> V4L2_META_FMT_UVC only copies PTS, SCR, size and flags, and
> >>> V4L2_META_FMT_D4XX copies the whole metadata section.
> >>>
> >>> Now we only enable V4L2_META_FMT_D4XX for the Intel D4xx family of
> >>> devices, but it is useful for any device where vendors include other
> >>> metadata, such as the one described by Microsoft:
> >>> - https://learn.microsoft.com/en-us/windows-hardware/drivers/stream/mf-capture-metadata
> >>>
> >>> This patch removes the UVC_INFO_META macro and enables
> >>> V4L2_META_FMT_D4XX for every device. It also updates the documentation
> >>> to reflect the change.
> >>>
> >>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> >>
> >> Thanks, patch looks good to me:
> >>
> >> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> >
> > I don't quite agree, sorry.
> >
> > The reason why the current mechanism has been implemented this way is to
> > ensure we have documentation for the metadata format of devices that
> > expose metadata to userspace.
> >
> > If you want to expose the MS metadata, you can create a new metadata
> > format for that, and enable it on devices that implement it.
>
> Looking at the long list of quirks this removes just for the D4xx
> cameras I do not believe that having quirked based relaying of
> which metadata fmt is used to userspace is something which scales
> on the long term. Given the large amount of different UVC cameras
> I really think we should move the USB VID:PID -> metadata format
> mapping out of the kernel.

+1000 to this. ChromeOS alone, this will be 200+ quirks per year.

>
> I do agree that using V4L2_META_FMT_D4XX for every device is
> probably not the best idea. So my suggestion would be to add
> a new V4L2_META_FMT_CUSTOM metadata fmt and for index 1
> metadata fmt use V4L2_META_FMT_D4XX for the currently quirked
> cams and use V4L2_META_FMT_CUSTOM for other cameras.

That works for me. What I wanted to avoid was to add a new metadata
format that is identical to V4L2_META_FMT_D4XX.

V4L2_META_FMT_D4XX is just Microsoft metadata id 0x80000000


>
> This can then be combined with a udev-rule + hwdb to provide
> info of what V4L2_META_FMT_CUSTOM should be mapped to in userspace,
> moving further VID:PID -> extended-metadata fmt mappings out of
> the kernel.

I am not aware of cameras implementing other metadata types different
to Microsoft's.
The rule is basically going to be *:* -> Microsoft Metadata.

But yeah, having a way to support weird cameras is always good :)

>
> Regards,
>
> Hans
>
>
>
> >
> >>> ---
> >>>  .../userspace-api/media/v4l/metafmt-d4xx.rst       | 19 +++--
> >>>  .../userspace-api/media/v4l/metafmt-uvc.rst        |  6 +-
> >>>  drivers/media/usb/uvc/uvc_driver.c                 | 83 ----------------------
> >>>  drivers/media/usb/uvc/uvc_metadata.c               | 15 ++--
> >>>  drivers/media/usb/uvc/uvcvideo.h                   |  1 -
> >>>  5 files changed, 23 insertions(+), 101 deletions(-)
> >>>
> >>> diff --git a/Documentation/userspace-api/media/v4l/metafmt-d4xx.rst b/Documentation/userspace-api/media/v4l/metafmt-d4xx.rst
> >>> index 0686413b16b2..1b18ef056934 100644
> >>> --- a/Documentation/userspace-api/media/v4l/metafmt-d4xx.rst
> >>> +++ b/Documentation/userspace-api/media/v4l/metafmt-d4xx.rst
> >>> @@ -6,12 +6,23 @@
> >>>  V4L2_META_FMT_D4XX ('D4XX')
> >>>  *******************************
> >>>
> >>> -Intel D4xx UVC Cameras Metadata
> >>> +UVC Full Payload Header Data (formerly known as Intel D4xx UVC Cameras
> >>> +Metadata).
> >>>
> >>>
> >>>  Description
> >>>  ===========
> >>>
> >>> +V4L2_META_FMT_D4XX buffers follow the metadata buffer layout of
> >>> +V4L2_META_FMT_UVC with the only difference, that it also includes proprietary
> >>> +payload header data. It was originally implemented for Intel D4xx cameras, and
> >>> +thus the name, but now it can be used by any UVC device, when userspace wants
> >>> +full access to the UVC Metadata.
> >>> +
> >>> +
> >>> +Intel D4xx Metadata
> >>> +===================
> >>> +
> >>>  Intel D4xx (D435, D455 and others) cameras include per-frame metadata in their UVC
> >>>  payload headers, following the Microsoft(R) UVC extension proposal [1_]. That
> >>>  means, that the private D4XX metadata, following the standard UVC header, is
> >>> @@ -21,10 +32,8 @@ types are MetadataId_CaptureStats (ID 3), MetadataId_CameraExtrinsics (ID 4),
> >>>  and MetadataId_CameraIntrinsics (ID 5). For their description see [1_]. This
> >>>  document describes proprietary metadata types, used by D4xx cameras.
> >>>
> >>> -V4L2_META_FMT_D4XX buffers follow the metadata buffer layout of
> >>> -V4L2_META_FMT_UVC with the only difference, that it also includes proprietary
> >>> -payload header data. D4xx cameras use bulk transfers and only send one payload
> >>> -per frame, therefore their headers cannot be larger than 255 bytes.
> >>> +D4xx cameras use bulk transfers and only send one payload per frame, therefore
> >>> +their headers cannot be larger than 255 bytes.
> >>>
> >>>  This document implements Intel Configuration version 3 [9_].
> >>>
> >>> diff --git a/Documentation/userspace-api/media/v4l/metafmt-uvc.rst b/Documentation/userspace-api/media/v4l/metafmt-uvc.rst
> >>> index 784346d14bbd..a3aae580e89e 100644
> >>> --- a/Documentation/userspace-api/media/v4l/metafmt-uvc.rst
> >>> +++ b/Documentation/userspace-api/media/v4l/metafmt-uvc.rst
> >>> @@ -6,7 +6,7 @@
> >>>  V4L2_META_FMT_UVC ('UVCH')
> >>>  *******************************
> >>>
> >>> -UVC Payload Header Data
> >>> +UVC Partial Payload Header Data (formerly known as UVC Payload Header Data).
> >>>
> >>>
> >>>  Description
> >>> @@ -44,7 +44,9 @@ Each individual block contains the following fields:
> >>>          them
> >>>      * - :cspan:`1` *The rest is an exact copy of the UVC payload header:*
> >>>      * - __u8 length;
> >>> -      - length of the rest of the block, including this field
> >>> +      - length of the rest of the block, including this field (please note that
> >>> +        regardless of this value, the driver will never copy more than 12
> >>> +        bytes).
> >>>      * - __u8 flags;
> >>>        - Flags, indicating presence of other standard UVC fields
> >>>      * - __u8 buf[];
> >>> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> >>> index deadbcea5e22..f19dcd4a7ac6 100644
> >>> --- a/drivers/media/usb/uvc/uvc_driver.c
> >>> +++ b/drivers/media/usb/uvc/uvc_driver.c
> >>> @@ -2488,8 +2488,6 @@ static const struct uvc_device_info uvc_quirk_force_y8 = {
> >>>  };
> >>>
> >>>  #define UVC_INFO_QUIRK(q) (kernel_ulong_t)&(struct uvc_device_info){.quirks = q}
> >>> -#define UVC_INFO_META(m) (kernel_ulong_t)&(struct uvc_device_info) \
> >>> -   {.meta_format = m}
> >>>
> >>>  /*
> >>>   * The Logitech cameras listed below have their interface class set to
> >>> @@ -3107,87 +3105,6 @@ static const struct usb_device_id uvc_ids[] = {
> >>>       .bInterfaceSubClass   = 1,
> >>>       .bInterfaceProtocol   = 0,
> >>>       .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_DISABLE_AUTOSUSPEND) },
> >>> -   /* Intel D410/ASR depth camera */
> >>> -   { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> >>> -                           | USB_DEVICE_ID_MATCH_INT_INFO,
> >>> -     .idVendor             = 0x8086,
> >>> -     .idProduct            = 0x0ad2,
> >>> -     .bInterfaceClass      = USB_CLASS_VIDEO,
> >>> -     .bInterfaceSubClass   = 1,
> >>> -     .bInterfaceProtocol   = 0,
> >>> -     .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> >>> -   /* Intel D415/ASRC depth camera */
> >>> -   { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> >>> -                           | USB_DEVICE_ID_MATCH_INT_INFO,
> >>> -     .idVendor             = 0x8086,
> >>> -     .idProduct            = 0x0ad3,
> >>> -     .bInterfaceClass      = USB_CLASS_VIDEO,
> >>> -     .bInterfaceSubClass   = 1,
> >>> -     .bInterfaceProtocol   = 0,
> >>> -     .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> >>> -   /* Intel D430/AWG depth camera */
> >>> -   { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> >>> -                           | USB_DEVICE_ID_MATCH_INT_INFO,
> >>> -     .idVendor             = 0x8086,
> >>> -     .idProduct            = 0x0ad4,
> >>> -     .bInterfaceClass      = USB_CLASS_VIDEO,
> >>> -     .bInterfaceSubClass   = 1,
> >>> -     .bInterfaceProtocol   = 0,
> >>> -     .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> >>> -   /* Intel RealSense D4M */
> >>> -   { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> >>> -                           | USB_DEVICE_ID_MATCH_INT_INFO,
> >>> -     .idVendor             = 0x8086,
> >>> -     .idProduct            = 0x0b03,
> >>> -     .bInterfaceClass      = USB_CLASS_VIDEO,
> >>> -     .bInterfaceSubClass   = 1,
> >>> -     .bInterfaceProtocol   = 0,
> >>> -     .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> >>> -   /* Intel D435/AWGC depth camera */
> >>> -   { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> >>> -                           | USB_DEVICE_ID_MATCH_INT_INFO,
> >>> -     .idVendor             = 0x8086,
> >>> -     .idProduct            = 0x0b07,
> >>> -     .bInterfaceClass      = USB_CLASS_VIDEO,
> >>> -     .bInterfaceSubClass   = 1,
> >>> -     .bInterfaceProtocol   = 0,
> >>> -     .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> >>> -   /* Intel D435i depth camera */
> >>> -   { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> >>> -                           | USB_DEVICE_ID_MATCH_INT_INFO,
> >>> -     .idVendor             = 0x8086,
> >>> -     .idProduct            = 0x0b3a,
> >>> -     .bInterfaceClass      = USB_CLASS_VIDEO,
> >>> -     .bInterfaceSubClass   = 1,
> >>> -     .bInterfaceProtocol   = 0,
> >>> -     .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> >>> -   /* Intel D405 Depth Camera */
> >>> -   { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> >>> -                           | USB_DEVICE_ID_MATCH_INT_INFO,
> >>> -     .idVendor             = 0x8086,
> >>> -     .idProduct            = 0x0b5b,
> >>> -     .bInterfaceClass      = USB_CLASS_VIDEO,
> >>> -     .bInterfaceSubClass   = 1,
> >>> -     .bInterfaceProtocol   = 0,
> >>> -     .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> >>> -   /* Intel D455 Depth Camera */
> >>> -   { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> >>> -                           | USB_DEVICE_ID_MATCH_INT_INFO,
> >>> -     .idVendor             = 0x8086,
> >>> -     .idProduct            = 0x0b5c,
> >>> -     .bInterfaceClass      = USB_CLASS_VIDEO,
> >>> -     .bInterfaceSubClass   = 1,
> >>> -     .bInterfaceProtocol   = 0,
> >>> -     .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> >>> -   /* Intel D421 Depth Module */
> >>> -   { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> >>> -                           | USB_DEVICE_ID_MATCH_INT_INFO,
> >>> -     .idVendor             = 0x8086,
> >>> -     .idProduct            = 0x1155,
> >>> -     .bInterfaceClass      = USB_CLASS_VIDEO,
> >>> -     .bInterfaceSubClass   = 1,
> >>> -     .bInterfaceProtocol   = 0,
> >>> -     .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> >>>     /* Generic USB Video Class */
> >>>     { USB_INTERFACE_INFO(USB_CLASS_VIDEO, 1, UVC_PC_PROTOCOL_UNDEFINED) },
> >>>     { USB_INTERFACE_INFO(USB_CLASS_VIDEO, 1, UVC_PC_PROTOCOL_15) },
> >>> diff --git a/drivers/media/usb/uvc/uvc_metadata.c b/drivers/media/usb/uvc/uvc_metadata.c
> >>> index 82de7781f5b6..5c44e6cdb83c 100644
> >>> --- a/drivers/media/usb/uvc/uvc_metadata.c
> >>> +++ b/drivers/media/usb/uvc/uvc_metadata.c
> >>> @@ -60,18 +60,16 @@ static int uvc_meta_v4l2_try_format(struct file *file, void *fh,
> >>>                                 struct v4l2_format *format)
> >>>  {
> >>>     struct v4l2_fh *vfh = file->private_data;
> >>> -   struct uvc_streaming *stream = video_get_drvdata(vfh->vdev);
> >>> -   struct uvc_device *dev = stream->dev;
> >>>     struct v4l2_meta_format *fmt = &format->fmt.meta;
> >>> -   u32 fmeta = fmt->dataformat;
> >>> +   u32 fmeta = fmt->dataformat == V4L2_META_FMT_D4XX ?
> >>> +               V4L2_META_FMT_D4XX : V4L2_META_FMT_UVC;
> >>>
> >>>     if (format->type != vfh->vdev->queue->type)
> >>>             return -EINVAL;
> >>>
> >>>     memset(fmt, 0, sizeof(*fmt));
> >>>
> >>> -   fmt->dataformat = fmeta == dev->info->meta_format
> >>> -                   ? fmeta : V4L2_META_FMT_UVC;
> >>> +   fmt->dataformat = fmeta;
> >>>     fmt->buffersize = UVC_METADATA_BUF_SIZE;
> >>>
> >>>     return 0;
> >>> @@ -110,19 +108,16 @@ static int uvc_meta_v4l2_enum_formats(struct file *file, void *fh,
> >>>                                   struct v4l2_fmtdesc *fdesc)
> >>>  {
> >>>     struct v4l2_fh *vfh = file->private_data;
> >>> -   struct uvc_streaming *stream = video_get_drvdata(vfh->vdev);
> >>> -   struct uvc_device *dev = stream->dev;
> >>>     u32 index = fdesc->index;
> >>>
> >>> -   if (fdesc->type != vfh->vdev->queue->type ||
> >>> -       index > 1U || (index && !dev->info->meta_format))
> >>> +   if (fdesc->type != vfh->vdev->queue->type || index > 1U)
> >>>             return -EINVAL;
> >>>
> >>>     memset(fdesc, 0, sizeof(*fdesc));
> >>>
> >>>     fdesc->type = vfh->vdev->queue->type;
> >>>     fdesc->index = index;
> >>> -   fdesc->pixelformat = index ? dev->info->meta_format : V4L2_META_FMT_UVC;
> >>> +   fdesc->pixelformat = index ? V4L2_META_FMT_D4XX : V4L2_META_FMT_UVC;
> >>>
> >>>     return 0;
> >>>  }
> >>> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> >>> index 5e388f05f3fc..cc2092ae9987 100644
> >>> --- a/drivers/media/usb/uvc/uvcvideo.h
> >>> +++ b/drivers/media/usb/uvc/uvcvideo.h
> >>> @@ -534,7 +534,6 @@ static inline u32 uvc_urb_index(const struct uvc_urb *uvc_urb)
> >>>
> >>>  struct uvc_device_info {
> >>>     u32     quirks;
> >>> -   u32     meta_format;
> >>>     u16     uvc_version;
> >>>  };
> >>>
> >>>
> >>> ---
> >>> base-commit: d98e9213a768a3cc3a99f5e1abe09ad3baff2104
> >>> change-id: 20250226-uvc-metadata-2e7e445966de
> >
>


-- 
Ricardo Ribalda

