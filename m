Return-Path: <linux-kernel+bounces-430207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE43A9E2DD9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A720C1660C0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C005208978;
	Tue,  3 Dec 2024 21:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MGzwxPOF"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403A4208997
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 21:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733260267; cv=none; b=jseP2ciKupfF/p0qzF812+mq5c8gIHRk5Hw263mhip2It2yekvW1rZSZ0OxZK4H4ZNIqaKABdwFZ/FmzZRkb3oIlAw4ciFKPSu+j6GfQ5jrpzc9+FbcwJJbfvPH5pt8WVAYaMCNqD/LEz04swp0vjEu9joWu7/SBMICl0HXLSE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733260267; c=relaxed/simple;
	bh=mldf0Wu7ZhdNc39LmyRnpOOAa3Bd2fL7/nfxKBLLYZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hFNqfCPJ0KT6aZA2vTlcXUWxWKAxZaVBn0wBfXjcIXUgnq8BY31YN2izTh8o7QVtOqDR5dDJ08Aa1TWLrH9SugQ8kxbmIXEQOg/x3jl56Uk5zTtTrrGkCjFd4jlIxEu6BawbvMUgOLO8CN7NkDUTrCdbP6QIDsmVpJv4Fn8Gklo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MGzwxPOF; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-724f41d520cso3609998b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 13:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733260265; x=1733865065; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/i3jPBDipLqisE7gTwvhfw99QUxA4cWmIpareouCiQ=;
        b=MGzwxPOFJnhu3jthE4LNhYXZHh/Te7V87r44JQnR8/jQnbQxTxUiek+B44iQGDsclH
         iWZdJnWnBmrb2TlYB17MOuEXY73+ehXz6lvdvRfhyZXc22VE8pSFSBJJLmdMiyy+cI6b
         vdUiwvX7Lv5edDpIKCDj9ZQWgly7mtRt5uZIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733260265; x=1733865065;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q/i3jPBDipLqisE7gTwvhfw99QUxA4cWmIpareouCiQ=;
        b=GUokeeRmL9jjP9rNOR2i+Tiq4r8IyATf7uHaEaPARUWD0l/5mFwO7IhNQNwcQfwV1z
         6ZF5eQzEr009xoaK/F1HnbccuGsfoDQSGfqvTVqU/FXgG1xHW2prISNFuXZBcMbLopmq
         DpjjIS402EvLTF+LvxewAE9VZyWoBUac4EwjRrI2gOagPysGBbY+e5DYJs8mMauSRIdO
         hiPti2JVp+2jxwrOjI3tdlc1XKovsOWudm/aZq+PD0T8it0Rgi8o/xsgzzRmVfIfFii4
         lT48xdk8Cz/IiVmyr4BhefBzC7rMxFySNQoR6//jnMUmpExKOjF3M/G+N7NfxTLe8WBE
         1akg==
X-Forwarded-Encrypted: i=1; AJvYcCVmaTN93GNTktwcVqJRA2PvUh3jxW1DRZWNDH6zBEoOdwU0P/bNm5RT1fv1fTmmEz3o7wMwkKim7xsddHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXgofRA4OIsCUewxHihYnkg9fAsjEwd9zSfd8RARrms6FHXELr
	o+wfSp9amSeqHKvSfp9J+HgS+kjxuRJOSdCyBRbYGO993sRE19yx6DITq7RBXhlWhccIp5oXbRA
	=
X-Gm-Gg: ASbGncvG27YiqxVSCwAUhCf2zLZD3yMWzH64g9BC/107qkNpJKasAUJ1+VkxZYQ4bKX
	9PUB64uS/iKrG9ydm0NMuZbrdmr/h7ziTYhk6OsEIM3zmGC3qlYu0Z0AzREbm8Qs40PsbXQHgcf
	8g1HieKyIOa1bDQhAG1nULPNwPGg1fTb0tsayZsgv9cGxXTHuERYgrdZDAmUx7ulGE+b/c1ZEBa
	H1aoWk2MQFNhogyXJNzHxZ9IukP7Hg12NCTmlEp7TgadyNDcmDC1dYCDlIBJupWrT4IjydOL55X
	+Y3bjuDQsiggJQI3
X-Google-Smtp-Source: AGHT+IH+/nZskQo8d7tD2lXfvku7HufPJnu1HNcgboBwlkuQQ8hw9MPcsoeKVkdsRdgcCCdRzKMpnQ==
X-Received: by 2002:a17:903:22cf:b0:215:742e:5d05 with SMTP id d9443c01a7336-215bd1cc3demr50214075ad.20.1733260263831;
        Tue, 03 Dec 2024 13:11:03 -0800 (PST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com. [209.85.215.181])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219c31a0sm99464305ad.249.2024.12.03.13.11.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 13:11:02 -0800 (PST)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7f71f2b136eso4342374a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 13:11:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXP4hpV050rFu3SNJAawMyv0OWmlBBzGhc7qNDQme+mIDw1eBC60NU4bOL5AP5Par8vjxGOhewFbayKwgo=@vger.kernel.org
X-Received: by 2002:a17:90b:1c10:b0:2ee:94d1:7a89 with SMTP id
 98e67ed59e1d1-2ef011dedcemr5013685a91.1.1733260262121; Tue, 03 Dec 2024
 13:11:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202-uvc-fix-async-v5-0-6658c1fe312b@chromium.org>
 <20241202-uvc-fix-async-v5-5-6658c1fe312b@chromium.org> <67f78128-dcc0-4253-a6f7-5905ca375b06@redhat.com>
 <20241203203748.GD5196@pendragon.ideasonboard.com>
In-Reply-To: <20241203203748.GD5196@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 3 Dec 2024 22:10:50 +0100
X-Gmail-Original-Message-ID: <CANiDSCs2VXdM5pekzEHTqddR=1G5U2wa+zdkRgDKvVhfxw73Mw@mail.gmail.com>
Message-ID: <CANiDSCs2VXdM5pekzEHTqddR=1G5U2wa+zdkRgDKvVhfxw73Mw@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] media: uvcvideo: Flush the control cache when we
 get an event
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Dec 2024 at 21:38, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Mon, Dec 02, 2024 at 03:45:57PM +0100, Hans de Goede wrote:
> > Hi,
> >
> > On 2-Dec-24 3:24 PM, Ricardo Ribalda wrote:
> > > Asynchronous controls trigger an event when they have completed their
> > > operation.
> > >
> > > This can make that the control cached value does not match the value in
> > > the device.
> > >
> > > Let's flush the cache to be on the safe side.



> > >
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> > >  drivers/media/usb/uvc/uvc_ctrl.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > > index e90bf2aeb5e4..75d534072f50 100644
> > > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > > @@ -1672,6 +1672,9 @@ bool uvc_ctrl_status_event_async(struct urb *urb, struct uvc_video_chain *chain,
> > >     struct uvc_device *dev = chain->dev;
> > >     struct uvc_ctrl_work *w = &dev->async_ctrl;
> > >
> > > +   /* Flush the control cache, the data might have changed. */
> > > +   ctrl->loaded = 0;
> > > +
> > >     if (list_empty(&ctrl->info.mappings))
> > >             return false;
> > >
> >
> > Thank you for the patch.
> >
> > I'm not familiar enough with UVC yet to really have an opinion on this one,
> > so I'll defer reviewing this one to Laurent.
>
> Conceptually this change looks fine, but the commit message needs to
> explain why this is safe to do without protecting ctrl->loaded with a
> lock.

Just realised that loaded is a bit field... and we shall not be
creative with lockless writes with those.

I am going to move it to uvc_ctrl_status_event(). It will not work
with controls without mappings... but I guess we do not care about the
cache for those.

Feel free to land the whole series without this patch if we need
further discussion or changes.

>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

