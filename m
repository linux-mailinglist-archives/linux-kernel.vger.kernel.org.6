Return-Path: <linux-kernel+bounces-260237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E6393A4D0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 430F11C226F9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B39D15820C;
	Tue, 23 Jul 2024 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nqj1TLaN"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C1015444F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 17:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721755066; cv=none; b=HwPU0O/ZsVuNdLeqc2qB/3mdIT/lA0hjrXNlLvl6Lluye8B0Q1vtaKuObspnMuvqyqqcptZYm9tkQINikXmK588GGs86O6MSrD+ze0OpO7/QOPSMp/0B3lQtg/asdmpT0C4HrvvAXtGSGwCCYNBLM745dGwaB6qb4EpVaynK4dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721755066; c=relaxed/simple;
	bh=wsp9KB8SuHg/ClNGOBJifz2KS20QsmLx/86VcT0FNUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dgpNxAHuzraBHB/tOPg6bpWe44mDmglxQAhsk8WXfa/L79nd5RW06RHLrQFnyDw3pnV+pUZpkAvKznGAMskgjDv94eFSYlZi9arOY/BAik5zPqq4FTTFf0/GbhfvOCDYXw8XE9/mU+VBSlA4VrQufTU3alor9wa6qiKIZ5H2Hy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nqj1TLaN; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6b5d42758a7so33234436d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 10:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721755063; x=1722359863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqpmdY8tkUX7S7RHI1j3eoWbLgmNFz+Dl9nwWGk07rE=;
        b=nqj1TLaNlUvYP3pn0LChvZgEH08F1wyyCBVwLNS0/m/dKbPN/riV6zfZ8GBh9QQM3X
         +UFYVZ4svdE+akVJZCMhwerOXWRfQ7RtKzYskVItdyDGdG88ylu4gjwdlaYDHexs5SFV
         YkcSzcOaUZoJ64zQkRWUx4YJO11foPYX6RpDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721755063; x=1722359863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqpmdY8tkUX7S7RHI1j3eoWbLgmNFz+Dl9nwWGk07rE=;
        b=qoApFVApZkGFe1vRvXcZa6vPqfEDAZNwkASyrfJTtlObSasebK4EnL/43Sd4NzgXor
         plHKlPWwr0Ki/T57ZJvi9eOdm8Drbb4hgJOLPbXrzOhRg9gAwM87XgIBYrj6tOGddpWK
         JUQ3e8IJ18+EAiIx0nlf5WnTQrYrQkWexqS5Zn2Tv1+OtvITZPBhkgqSnnriPF1SOutm
         ydfCqrnNnUsXGLb9if2UJ3634MN2TcHn0ofuWwjiYG0/Rk6fgiYz5xf35XQiM3P3rBXq
         NC0Jhe9AlCB9dAYutJQygvGhwyq2QyKTf9vlmsXQzi6FIAKF3kgBrrhfoO2hnaJghvtV
         38qg==
X-Forwarded-Encrypted: i=1; AJvYcCVKMCF0K5397Epminm8e2cT4dCbrIOzazXo3tS9mkUTAkEX4el6SWN4gpTcgBBdvIODqjOea9akW9QOmY4qlx9ToWTwYQoiowdUfeXm
X-Gm-Message-State: AOJu0YxrUxcTzAUwV/FFHBYG5j5mKa6+M84w7/gak1FGYCLisu3Gkx/F
	83hCefrDQMLUnUOORC+w3/aOWhgqbfA0ZU69m5R5uMvy+dx/DW86pxdlADE9DDIrYCq3/OJKQGQ
	=
X-Google-Smtp-Source: AGHT+IH0HhrDjkYabC151YCXYKYpDORLZuSqOHMfrTrqqQRet2BHsWg6hY1stNL1gPtqnncFrxj4gQ==
X-Received: by 2002:ad4:5b88:0:b0:6b7:9b2c:98d3 with SMTP id 6a1803df08f44-6b9610846femr113355076d6.26.1721755063120;
        Tue, 23 Jul 2024 10:17:43 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7ac9c36easm49329766d6.95.2024.07.23.10.17.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 10:17:42 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-447f8aa87bfso26601cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 10:17:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX7vpsAmvsO9OohMJiSpVaGVN9x2hX/lPZcZm6+r2gPjhbQbBCFgJIjwiQw+Bp9BByMu52YJy5ULMVMMfulVeWe1wwZ8fSsMUbOdj5Y
X-Received: by 2002:a05:622a:5c7:b0:447:d225:6e3a with SMTP id
 d75a77b69052e-44fd4a74a99mr188261cf.4.1721755061784; Tue, 23 Jul 2024
 10:17:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACGdZYKbdyALADEMDV+Vg+eog+UjjgGigEpmJTSKw_64RM8rbA@mail.gmail.com>
 <20240717231833.2090430-1-khazhy@google.com> <34139e33-3e7-4895-bd4-2d9f7727e9fb@redhat.com>
 <99266e5d-de9d-4d31-a1f2-d003bddb7b44@gmail.com>
In-Reply-To: <99266e5d-de9d-4d31-a1f2-d003bddb7b44@gmail.com>
From: Khazhy Kumykov <khazhy@chromium.org>
Date: Tue, 23 Jul 2024 10:17:28 -0700
X-Gmail-Original-Message-ID: <CACGdZY+bY+i=pbe9MXJQFVRVXehTsHT60ew_QxS7z4xXXvyvbw@mail.gmail.com>
Message-ID: <CACGdZY+bY+i=pbe9MXJQFVRVXehTsHT60ew_QxS7z4xXXvyvbw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] dm ioctl: fix erroneous EINVAL when signaled
To: Zdenek Kabelac <zdenek.kabelac@gmail.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>, Alasdair Kergon <agk@redhat.com>, 
	Mike Snitzer <snitzer@kernel.org>, Zdenek Kabelac <zkabelac@redhat.com>, 
	Joe Thornber <thornber@redhat.com>, Heinz Mauelshagen <heinzm@redhat.com>, dm-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 6:11=E2=80=AFAM Zdenek Kabelac <zdenek.kabelac@gmai=
l.com> wrote:
>
> Dne 23. 07. 24 v 14:51 Mikulas Patocka napsal(a):
> >
> >
> > On Wed, 17 Jul 2024, Khazhismel Kumykov wrote:
> >
> >> do_resume when loading a new map first calls dm_suspend, which could
> >> silently fail. When we proceeded to dm_swap_table, we would bail out
> >> with EINVAL. Instead, attempt to restore new_map and return ERESTARTSY=
S
> >> when signaled.
> >>
> >> Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
> >> ---
> >>   drivers/md/dm-ioctl.c | 23 +++++++++++++++++++++--
> >>   1 file changed, 21 insertions(+), 2 deletions(-)
> >>
> >> v2: don't leak new_map if we can't assign it back to hc.
> >>
> >> diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
> >> index c2c07bfa6471..0591455ad63c 100644
> >> --- a/drivers/md/dm-ioctl.c
> >> +++ b/drivers/md/dm-ioctl.c
> >> @@ -1181,8 +1181,27 @@ static int do_resume(struct dm_ioctl *param)
> >>                      suspend_flags &=3D ~DM_SUSPEND_LOCKFS_FLAG;
> >>              if (param->flags & DM_NOFLUSH_FLAG)
> >>                      suspend_flags |=3D DM_SUSPEND_NOFLUSH_FLAG;
> >> -            if (!dm_suspended_md(md))
> >> -                    dm_suspend(md, suspend_flags);
> >> +            if (!dm_suspended_md(md)) {
> >> +                    r =3D dm_suspend(md, suspend_flags);
> >> +                    if (r =3D=3D -EINTR)
> >> +                            r =3D -ERESTARTSYS;
> >
> > I'd like to ask why the "EINTR -> ERESTARTSYS" conversion is here and w=
hy
> > it isn't in dm_suspend?
I proposed ERESTARTSYS here since the act of waiting for the device to
suspend successfully seems "restartable" - I think the same reasoning
would apply to do_suspend.
> >
> > What do libdevmapper+lvm maintainers think about it? Does lvm hadle EIN=
TR
> > by restarting the ioctl syscall? Should we return ERESTARTSYS when susp=
end
> > is interrupted?
>
> In general - with suspend failures - we are just stopping whole operation=
 -
> and restoring previous state - so user can run operation again.
>
> There is no special check for exact reason of ioctl failure.
>
> Regards
>
> Zdenek
>

