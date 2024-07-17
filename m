Return-Path: <linux-kernel+bounces-255605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B00C9342D6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 21:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A832C1C20E22
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 19:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A096C1836F3;
	Wed, 17 Jul 2024 19:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wz2fiBgM"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A1928DD1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 19:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721245977; cv=none; b=HUwwNcmKXZ17KOVoi9QkyDC0n+MzR8VAj6edKbehnAFtYAzYqDQd6q0Kql5bVWvQpYa0D54Vl/4dyxWhjG4FTl0remxiHdOR7XLZQ3DyDunk2SNuimb8HDhV0lEgrkA/+zJRHwD5dpR5dJ4kCS0ufIBx1vgvEGD3pU+OIMwZiSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721245977; c=relaxed/simple;
	bh=ZauPFTwig0lAM8GH3yDgtA99zKZJdt45erSe5eINhJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=okiboz6rWmhCpBIMgu8KU6onYvysIrSEzvnO1ASjpiZL0bptrA+uVueWcpAkt/35xRE8CPdD3WYMQQIJaoLa6k+LJLi5Jr5qyzoBWznH2Q1DICht0hggSM94IjHW905f+/lpv6yMtEXPIOjA/7A2r5H4FJt2SLnD/2AezTcbDIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Wz2fiBgM; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-79f16c85da0so484433485a.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 12:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721245975; x=1721850775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCt2qgFBTENxzYjWiHSzIwJ4sPIWdAkJsmJNvcaX3wg=;
        b=Wz2fiBgMjX7OiBJGcgG+C+hR59laBNh8GcrgpR6ZKuuwf9/rbtwO/GFEgvhpYY2LOQ
         yhhAKS8JBKvZn2lRjhcCfAHgrn/coZK6R97q0LDzYeR30h0F0G4c2ctlEVoVUSk3CpX+
         BJtQrs8yG2pBQysH+qZcQsPeqZEz2cTcplFUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721245975; x=1721850775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dCt2qgFBTENxzYjWiHSzIwJ4sPIWdAkJsmJNvcaX3wg=;
        b=DzfSyZ5003Q8vYD1LM7HUe5KHQ2Am5uHycU/Vr3spO6xXmlsBo6QnXWwEXiyT7WFx5
         f18tcnFEERRxQFZxrg4snBeMsgCZ1ZRQhuyfSgD4M/7Cb39ckuKw/0xn7T2WlSElGCnG
         kiqjYRgJl9TDG+HWkkPDpDdOON3ceF4+cJGbpUeyO0G1Y6lyJLWxgNpE1hSlRAg43/qv
         yPViy3f9mP1AnRqAq9wrtFkkMhGYT/l5rgvyZe2PzjaYc2xFF6zKPjuBZW1oh4UVvHNt
         1vYpMzybCN2a/3ZJaxkdbyx46pRotJr/oKRYY9kFMl/3H+ZsffHneZ3WjNYYGef1BLbu
         NvKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbFAMdGBUCtlUP5Cx/DZpkpemyJu8I7aGGI8/V2c6btdE31mI6Cu1yiPeFZLFroiOv+jM8IDMY6TrYOMZe6pgcp2q8VBG0Tg5iVORu
X-Gm-Message-State: AOJu0YxszrtpS5rGI2Ud73gc0X1SESsataxsT46lPOmeHOr9/vV7miF6
	6wDcRrfVbSfREsuYzYkIChcl9SbLrasXx64pQvv0ki3vbV7NShaIlFZHDMTMW74S8mFd3jb4hAA
	=
X-Google-Smtp-Source: AGHT+IG039YdV1Hj/HF1WY9qfVZsh2J64Q/0FI3jnC3ZLDwf2Msg3K0O6xjprCCywxPtg0MPZPTLXA==
X-Received: by 2002:a05:620a:4089:b0:79e:f80a:2ab8 with SMTP id af79cd13be357-7a187448ccemr360202085a.25.1721245974643;
        Wed, 17 Jul 2024 12:52:54 -0700 (PDT)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160ba82cdsm440069985a.4.2024.07.17.12.52.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 12:52:54 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-447f8aa87bfso85301cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 12:52:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUSAjIAa3ruQxlHCBrgUhUe7BbTxxj8jIaucIsfSt3+WdRm2BULaFPk8ExQfIu10f+uaNkRo8Lochh7EbuQE9vEBN6XcXvPtwH7BKh4
X-Received: by 2002:a05:622a:17ce:b0:447:d81a:9320 with SMTP id
 d75a77b69052e-44f9058d2bdmr608721cf.20.1721245973459; Wed, 17 Jul 2024
 12:52:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717185640.1026114-1-khazhy@google.com> <43954d4-6130-f36a-384c-9f18eda892@redhat.com>
In-Reply-To: <43954d4-6130-f36a-384c-9f18eda892@redhat.com>
From: Khazhy Kumykov <khazhy@chromium.org>
Date: Wed, 17 Jul 2024 12:52:40 -0700
X-Gmail-Original-Message-ID: <CACGdZYKbdyALADEMDV+Vg+eog+UjjgGigEpmJTSKw_64RM8rbA@mail.gmail.com>
Message-ID: <CACGdZYKbdyALADEMDV+Vg+eog+UjjgGigEpmJTSKw_64RM8rbA@mail.gmail.com>
Subject: Re: [RFC PATCH] dm ioctl: fix erroneous EINVAL when signaled
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
	Zdenek Kabelac <zkabelac@redhat.com>, Joe Thornber <thornber@redhat.com>, 
	Heinz Mauelshagen <heinzm@redhat.com>, dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 12:45=E2=80=AFPM Mikulas Patocka <mpatocka@redhat.c=
om> wrote:
>
> Hi
>
> I am wondering why does do_resume need to call dm_suspend at all. Does
> anyone here remember why is this code path needed?

In our case, we have a sequence with load_table followed by a resume,
with no suspend first. The resume path suspends if needed, swaps
tables, then resumes. Removing the suspend here would break existing
userspace, I'd imagine. It seems like minimizing the suspended time
would also be a nice benefit.

>
> Mikulas
>
>
>
> On Wed, 17 Jul 2024, Khazhismel Kumykov wrote:
>
> > do_resume when loading a new map first calls dm_suspend, which could
> > silently fail. When we proceeded to dm_swap_table, we would bail out
> > with EINVAL. Instead, restore new_map and return ERESTARTSYS when
> > signaled.
> >
> > Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
> > ---
> >  drivers/md/dm-ioctl.c | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> >
> >
> > RFC as I am rather unfamiliar with the locking semantics here - whether
> > we do need to re-grab hash_lock to write to an hc we previously grabbed=
,
> > and whether the device becoming unhashed while we're in this function i=
s
> > really something that needs to be checked. However, this patch does fix
> > the issue we were seeing - we'd get EINVAL when thread in ioctl was
> > signaled.
> >
> >
> > diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
> > index c2c07bfa6471..b81650c6d096 100644
> > --- a/drivers/md/dm-ioctl.c
> > +++ b/drivers/md/dm-ioctl.c
> > @@ -1181,8 +1181,22 @@ static int do_resume(struct dm_ioctl *param)
> >                       suspend_flags &=3D ~DM_SUSPEND_LOCKFS_FLAG;
> >               if (param->flags & DM_NOFLUSH_FLAG)
> >                       suspend_flags |=3D DM_SUSPEND_NOFLUSH_FLAG;
> > -             if (!dm_suspended_md(md))
> > -                     dm_suspend(md, suspend_flags);
> > +             if (!dm_suspended_md(md)) {
> > +                     r =3D dm_suspend(md, suspend_flags);
> > +                     if (r =3D=3D -EINTR)
> > +                             r =3D -ERESTARTSYS;
> > +                     if (r) {
> > +                             down_write(&_hash_lock);
> > +                             hc =3D dm_get_mdptr(md);
> > +                             if (!hc)
> > +                                     r =3D -ENXIO;
> > +                             else
> > +                                     hc->new_map =3D new_map;
Oh - I probably want to check if hc->new_map has become non-null in
the meantime and if so... pick a winner then put the loser? Presumably
the newest map should win if that happens / is possible. although the
concept seems suspect to me.
> > +                             up_write(&_hash_lock);
> > +                             dm_put(md);
> > +                             return r;
> > +                     }
> > +             }
> >
> >               old_size =3D dm_get_size(md);
> >               old_map =3D dm_swap_table(md, new_map);
> > --
> > 2.45.2.993.g49e7a77208-goog
> >
>

