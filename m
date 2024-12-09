Return-Path: <linux-kernel+bounces-437831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EB19E994D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 015011888BEE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DD41B0430;
	Mon,  9 Dec 2024 14:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FQya7AoT"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8761B0420
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733755615; cv=none; b=aDtiZrLCk9t9Rk4Q3VeP/jtx2AaFcw91nviOx9jBwJBLYjJkNMP8hXYyVw4LeQ6A/f8cSHUj9hSwSEw4J/4dgDk8pz47Lk+30EkJ7JjcIls+/+uw1v/YEBoYID0X7yYA+UQP/7GElPm7Begd5dseXlYIJx5l9+GW6aOYdBDA+fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733755615; c=relaxed/simple;
	bh=wfaCW9PKJNfdJARFyfPcnNW1uOaAzyBt79sDMe4ggF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gkxMmmhYBplzMVgQkUF/EAongMHNnb8q8nmmApfTzCSCymfDyg1p/+RyjGXWu5WfWKhvzAc61XcuNaQRd2lj8sSSPbLjllXGh0tpG2YKHe2+0PbgQfTpLXzDinD7NWva5EtCzGqau7KayypSnN651F1wqQLFn2Ciqt7hYmVigkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FQya7AoT; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2165cb60719so6547005ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 06:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733755613; x=1734360413; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/BY5bcYoYikTyU3Vh1QbYSB3lerrS5OmyaNA6i7z+50=;
        b=FQya7AoTbhIXIcuh6OqbRCrOCe6/7HAMZvCh31AzkAs40ChaZHhVVt5JqR8fXjzVVF
         5Mj1FwbY9aNTpSkdzzsjdDOy9Nqu2rNfFFuLLFan+hL6z4NTwUD+q7ckhCbQU069R4qB
         9tQcj2Ya6o+WBvoZsoajSoOTTz6CWwpIfthtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733755613; x=1734360413;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/BY5bcYoYikTyU3Vh1QbYSB3lerrS5OmyaNA6i7z+50=;
        b=o+v8n1yaT7VQggnzXZwX0KuKUiknhlvq5Ta9INxxPvDNPjgcRy+viFFkn2mdGlIHo0
         2SALG52ab3zzFqYXfp0Ya+oj3T+1YfJtxGe9HoDWgv/ZfLL1FvS510hqHroEKX6kIaEb
         MJNRBDBrIbDX27hhNCe/JReniFnqy5UBJbbrzoAn/LGxfMDJkvDfPDc191RUTfpp1jXl
         8Mt6R80clw02/wmcncGJT9reeA1MSpLoGczAQzwzVUcoew3n6jSE6yAk/4EfcCGr5Ac/
         rPmrVlbtsFxopUKROzp8P89rZzwT6BErHDbyEOhkHPWszoFQpAD4AhTiN0J1gXC4oC3B
         8GfA==
X-Forwarded-Encrypted: i=1; AJvYcCWbAE8HpdvU0FJgfI/tgvAzFC9xci3ZBVxhwvjhg3OeLiyL8f3/+edgipMH6In8maQsPvPCVZUaI6tNRd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzblefNBJzE85iQyH76nxHW3iDD0ZqFYWKCZ7rU71fiMIbYQ+J7
	mGp9ALu1v1cA1aLzDZrAbUYbBsMGB0mF5yXTt9m+HVISAP6Cm22ODwKSmJNk/f72B7VJgd8h6nA
	=
X-Gm-Gg: ASbGncvjtrAxS4Aa1ala4iQLmwyhoM3h4+7vt+cYuvuK1Ie37Ck0Oozd2xoFwMplI/M
	zehJgXLyCdL3HNsIUGlEtdpLyXmcnmCx4aQCcqgvesZ6Or1HeSrfFdMhq3wQJBfT8qHXM/npjWz
	fmsuWsFaDFX2ECe+MkTlZeF6hkjrz3FuyNlbHCAO8cUVTQrlVDpafwfthpt6OMU25pbPVRzxWyE
	cky3C6HIcZn3zrsfUCFaqK4MFAPAaWc3zNY+HbVIerPA1dTmNgs4/zsbGI08iUOmbyCUFyDL/B2
	UIhQK/CS8cMIBVwD
X-Google-Smtp-Source: AGHT+IG+ahsw4FOe1H1EnaPSqbHtK4TRUph4DgvQOekbBJ8Kf1wkCUStXBwU8SSk0IwdSJGcxZ0diA==
X-Received: by 2002:a17:903:40c7:b0:215:a2e2:53ff with SMTP id d9443c01a7336-21669fcff97mr10539375ad.11.1733755612786;
        Mon, 09 Dec 2024 06:46:52 -0800 (PST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com. [209.85.215.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8efa2c4sm73634475ad.162.2024.12.09.06.46.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 06:46:51 -0800 (PST)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7f43259d220so2971546a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 06:46:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVpSiCeTFUHnr1c4/psW4ouki+VyNKQfb/lODbLNUZwtw0+JGqjlWyPZPz+iiVzgDsPa0ntxwqPDSJXZ08=@vger.kernel.org
X-Received: by 2002:a17:90b:53d0:b0:2ee:ed1c:e451 with SMTP id
 98e67ed59e1d1-2efcf1484b6mr1271828a91.15.1733755610316; Mon, 09 Dec 2024
 06:46:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org>
 <20241114-uvc-roi-v15-14-64cfeb56b6f8@chromium.org> <1cac4857-c261-461f-9749-8c8c68a0db07@redhat.com>
In-Reply-To: <1cac4857-c261-461f-9749-8c8c68a0db07@redhat.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 9 Dec 2024 15:46:38 +0100
X-Gmail-Original-Message-ID: <CANiDSCsN8UjxnCWmvuKzXnvSFY6YO02N24ha6W4PNTkUVZTzHg@mail.gmail.com>
X-Gm-Features: AZHOrDkJnrHyC4xzyb2bm7dfdIkKr36449JL3-XBxamAiy7PTjRYXhxOEG79O80
Message-ID: <CANiDSCsN8UjxnCWmvuKzXnvSFY6YO02N24ha6W4PNTkUVZTzHg@mail.gmail.com>
Subject: Re: [PATCH v15 14/19] media: uvcvideo: Use the camera to clamp
 compound controls
To: Hans de Goede <hdegoede@redhat.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Ricardo Ribalda <ribalda@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Yunke Cao <yunkec@chromium.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Dec 2024 at 15:05, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 14-Nov-24 8:10 PM, Ricardo Ribalda wrote:
> > Compound controls cannot e reliable clamped. There is plenty of space
> > for interpretation for the device manufacturer.
> >
> > When we write a compound control, let the camera do the clamping and
> > return back to the user the value used by the device.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_ctrl.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > index 0dae5e8c3ca0..72ed7dc9cfc1 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -2339,6 +2339,18 @@ int uvc_ctrl_set(struct uvc_fh *handle, struct v4l2_ext_control *xctrl)
> >
> >       ctrl->dirty = 1;
> >       ctrl->modified = 1;
> > +
> > +     /*
> > +      * Compound controls cannot reliable clamp the value when they are
> > +      * written to the device. Let the device do the clamping and read back
> > +      * the value that the device is using. We do not need to return an
> > +      * error if this fails.
> > +      */
> > +     if (uvc_ctrl_mapping_is_compound(mapping) &&
> > +         uvc_ctrl_is_readable(V4L2_CTRL_WHICH_CUR_VAL, ctrl, mapping))
> > +             uvc_mapping_get_xctrl_compound(chain, ctrl, mapping,
> > +                                            V4L2_CTRL_WHICH_CUR_VAL, xctrl);
> > +
>
> I do not believe that this actually works / does what you want it to do.
>
> At this point we have only updated in memory structures for the control
> and not send anything to camera.
>
> Querying the control to return the actual achieved values to userspace
> only makes sense after uvc_ctrl_commit() has succeeded, unless I am
> missing something ?

You are absolutely correct. Sorry about that.

Let's drop it for now.

Thanks!

>
> Regards,
>
> Hans
>
>


-- 
Ricardo Ribalda

