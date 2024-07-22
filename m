Return-Path: <linux-kernel+bounces-258997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6604938FC5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A611B20FEE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 13:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626C816D9AE;
	Mon, 22 Jul 2024 13:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pja5Vc10"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1073016938C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 13:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721654261; cv=none; b=sWgzs+/r8qJduTKyEqkM9eYhxaxfymR/dzUEFGHsHoqRyTR/sr6N3vOlEhNRMhVu9ojxwtRigHmHwK7ccSj3JWb++5S9uBtENvjJxkhrsxBWQ0Ojh5ycBbJflWLiAx/9hvW+lz3U6ApcyOMQgVNZBAsarfzQju4YDrTOFlXbqW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721654261; c=relaxed/simple;
	bh=X8Og4cRRjTFTAVcy3iYNTI7NPvrU8WWaBElWujRSza8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LCLl1H6RwPWrwvGSXlv7ptAFI0vMTtdDBjFecU6aF+ION8H5UoZKHYCPFaqUYFlpnyBkbSYWIO+DfYXVJ9pBMGm9vlPxfjNq8ZPm2qVRG5aP4GG8VK14AGWcJBNqgzfeADjjDYZjG1SLuLQTxi81jfVIeTcwgZ0Yxnju0UXfiBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Pja5Vc10; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a20de39cfbso3433148a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 06:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721654258; x=1722259058; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wTbGlt1EcdcYHcKZI4SFSpYHzZQnoTGlIL/NjhJzDtA=;
        b=Pja5Vc10zkUyiGI0B3G3dUQ8l405GPQNA1hSuwhBVjiGHUoZmNlnMMu4DlVdZWdMex
         gbTl+cK5CuXrPDolfs8dUlm4c18uC8+LqAtWhQuQd7bpdVjka/m4G2frURhftmz12bC3
         ZlU36VJWQTAxVp2OyV/LnTUiS7QNn9wzlvbRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721654258; x=1722259058;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wTbGlt1EcdcYHcKZI4SFSpYHzZQnoTGlIL/NjhJzDtA=;
        b=HMPM4IdRMEkfjSwYnbmuNLO4xYlKoeydWjP4zjoStmMiBHGluHezUwzaC7UJO1X/BD
         msuDA5kgKiPi68BnzTsGamBU1N5FasjEFzYU4YGPYcNOdSdr+F/2+5BzDaZAbFdazXkg
         i3yu1UP/REeIEV5vArLpK9+dHdObQAQo2oZr637qUmuOauBFAg+H8ByvPGY3LmS5D3K2
         ABkWs7gsNJpIDkj+apABPagBUedR6gxujW1X8EARredKQ8zlxg5T4OgilHTtHyv0IxoH
         QGcNshY7AwkKEYYrXlNqH36iGNkTI8M5aGklkF6wfXlE17JVtwyqxa2qRoHCxXoBBevP
         QpSA==
X-Forwarded-Encrypted: i=1; AJvYcCXrNX/OSJHAuZTg4OpwWlFPoJJYL3RfpZc6i1yztc+O7s6AHkpbNnRQaYje9qs0cCav1jfyDWGssMECU1WYg6nWZD8ww3Rp1BXTt2Ph
X-Gm-Message-State: AOJu0YzJBthZo59A1Nc5igPZbKXS3mF0yx2c8tX108ycTVvsk1vQCNfJ
	611Ps+26PdNWBurYWfKBVcNw7fMy8gmb+2OrLiWKqwQ8uje4n6zuVVvUko18l4nimmEdfOT5Vo+
	9TQ==
X-Google-Smtp-Source: AGHT+IHfLqX3zNlBZAs0UvSLoRI6XlTWh50UKdTLS60yjsBTQkB7bM2OSEDZMD1CFVZ0mzuOomv7sQ==
X-Received: by 2002:a05:6402:2553:b0:5a3:c00c:eafe with SMTP id 4fb4d7f45d1cf-5a3f089da5fmr5170527a12.23.1721654254598;
        Mon, 22 Jul 2024 06:17:34 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30c7d30a0sm6168309a12.83.2024.07.22.06.17.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 06:17:33 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6fd513f18bso383133066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 06:17:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXwaNo22p4391ZFXwMlic5deTnHmoFYrGIJqNSXQl3Y8+5MG7oTGVhRaUTSFP2kVNADkbNQBUTggusDZQyaERRnqXQaHAWrY9VfJlTu
X-Received: by 2002:a17:906:ce57:b0:a72:b055:3de0 with SMTP id
 a640c23a62f3a-a7a01116219mr1036992766b.6.1721654252644; Mon, 22 Jul 2024
 06:17:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722-fix-filter-mapping-v2-1-7ed5bb6c1185@chromium.org> <20240722122211.GF5732@pendragon.ideasonboard.com>
In-Reply-To: <20240722122211.GF5732@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 22 Jul 2024 15:17:17 +0200
X-Gmail-Original-Message-ID: <CANiDSCs1nuvG1XF1XUAJVvkrbe_bVnvqyTR7gvHDdQ8k0M4pLA@mail.gmail.com>
Message-ID: <CANiDSCs1nuvG1XF1XUAJVvkrbe_bVnvqyTR7gvHDdQ8k0M4pLA@mail.gmail.com>
Subject: Re: [PATCH v2] media: uvcvideo: Fix custom control mapping probing
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pmenzel@molgen.mpg.de, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jul 2024 at 14:22, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Mon, Jul 22, 2024 at 11:52:26AM +0000, Ricardo Ribalda wrote:
> > Custom control mapping introduced a bug, where the filter function was
> > applied to every single control.
> >
> > Fix it so it is only applied to the matching controls.
> >
> > The following dmesg errors during probe are now fixed:
> >
> > usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> > usb 1-5: Failed to query (GET_CUR) UVC control 2 on unit 2: -75 (exp. 1).
> > usb 1-5: Failed to query (GET_CUR) UVC control 3 on unit 2: -75 (exp. 1).
> > usb 1-5: Failed to query (GET_CUR) UVC control 6 on unit 2: -75 (exp. 1).
> > usb 1-5: Failed to query (GET_CUR) UVC control 7 on unit 2: -75 (exp. 1).
> > usb 1-5: Failed to query (GET_CUR) UVC control 8 on unit 2: -75 (exp. 1).
> > usb 1-5: Failed to query (GET_CUR) UVC control 9 on unit 2: -75 (exp. 1).
> > usb 1-5: Failed to query (GET_CUR) UVC control 10 on unit 2: -75 (exp. 1).
> >
> > Reported-by: Paul Menzen <pmenzel@molgen.mpg.de>
> > Closes: https://lore.kernel.org/linux-media/518cd6b4-68a8-4895-b8fc-97d4dae1ddc4@molgen.mpg.de/T/#t
> > Cc: stable@vger.kernel.org
> > Fixes: 8f4362a8d42b ("media: uvcvideo: Allow custom control mapping")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> I'll add
>
> Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
>
> from v1 and fix the reported-by tag.
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>

Thanks :)

> > ---
> > Paul, could you check if this fixes your issue, thanks!
> > ---
> > Changes in v2:
> > - Replace !(A && B) with (!A || !B)
> > - Add error message to commit message
> > - Link to v1: https://lore.kernel.org/r/20240722-fix-filter-mapping-v1-1-07cc9c6bf4e3@chromium.org
> > ---
> >  drivers/media/usb/uvc/uvc_ctrl.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > index 0136df5732ba..4fe26e82e3d1 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -2680,6 +2680,10 @@ static void uvc_ctrl_init_ctrl(struct uvc_video_chain *chain,
> >       for (i = 0; i < ARRAY_SIZE(uvc_ctrl_mappings); ++i) {
> >               const struct uvc_control_mapping *mapping = &uvc_ctrl_mappings[i];
> >
> > +             if (!uvc_entity_match_guid(ctrl->entity, mapping->entity) ||
> > +                 ctrl->info.selector != mapping->selector)
> > +                     continue;
> > +
> >               /* Let the device provide a custom mapping. */
> >               if (mapping->filter_mapping) {
> >                       mapping = mapping->filter_mapping(chain, ctrl);
> > @@ -2687,9 +2691,7 @@ static void uvc_ctrl_init_ctrl(struct uvc_video_chain *chain,
> >                               continue;
> >               }
> >
> > -             if (uvc_entity_match_guid(ctrl->entity, mapping->entity) &&
> > -                 ctrl->info.selector == mapping->selector)
> > -                     __uvc_ctrl_add_mapping(chain, ctrl, mapping);
> > +             __uvc_ctrl_add_mapping(chain, ctrl, mapping);
> >       }
> >  }
> >
> >
> > ---
> > base-commit: 68a72104cbcf38ad16500216e213fa4eb21c4be2
> > change-id: 20240722-fix-filter-mapping-18477dc69048
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

