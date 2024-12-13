Return-Path: <linux-kernel+bounces-445323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EEF9F14A6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36EF5188F1FD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03381EB9F3;
	Fri, 13 Dec 2024 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GX6C+roD"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919FB1E4937
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 18:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734112878; cv=none; b=EjBONZ3vWCLkfjf+ZnmR34EaI7Yc8l912Bx+87s6Ye+YVXruaxjV5slLwi4Tc7d7ZRTGlngm/pJkLzFhX1IEjyEkTehxPWntuBnIO89iPBFoTZyrOpeerboHQOsrTpG38UU/M0e7o3A1TCq1LBlaLFx1QaJV6P6VF6DSYY70r64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734112878; c=relaxed/simple;
	bh=eGq8X2cQn5Avkj8xSv4CjUXuHP5mxbeSDOJ4KzyQ+Tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A1KKabvMB+sVlBfTc5/onRCLI7k0bMg57CVp57qUyWW3lTjoJm4Lm4jksx85BenrQUs8fSmMAKxoTe4qqX6QpUz4G44EiZQEZoByykDLZ/p5vMvPP43r/QKHf/AGAre94DVOzxzRpZn1W8SlnI9/gY9h6tgyw3KS2dwtUaiFd4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GX6C+roD; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e3984b1db09so1532623276.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 10:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734112875; x=1734717675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPeH+betN1f6uv0SwXfZrHgC9aEQIrrjFSKIB2w0wUQ=;
        b=GX6C+roDAVEnvRyVEfpaeIfGvOfmY+lEzEmlAum3erHbz+eKBn2amCiXePxEllNzrO
         OAf+Mj8clqqzEuzTIWNh5AVNhThvOP/8UEKESx7ez7N+pwQuIjljQHSShh1gWVRlA1Mf
         /kMrR9f4voU89hJrMvKINvgkap7aEqOxqwIHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734112875; x=1734717675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPeH+betN1f6uv0SwXfZrHgC9aEQIrrjFSKIB2w0wUQ=;
        b=lmtWzfXXLJWRl16KsScwNUJNQD2iRTJskJdFwZK2q+/Mh7HNXUxxOWszvlxF4k1R75
         FVJlyJghLSNNH7Qrs3hssfalNGUJ2hccnWKAUdJY2awctGj61ZK0PUhhYOWmQ0QFHBbJ
         gsu4bJ7ILPoqUEDT3Lj0YpyNaRr0wMpKiAsjkFSr/RpbBtW2ZRHGRyEo+WnJiNeKJNtK
         aNwtv+itk9YpslrkHoaY8QiDfumU9TH8UyojwJTy3f7uTSF4j6KFsG055xDgCY420RSv
         e4HIG7wvHqCmib7RHhqKdogLzb1BXeTbh8hOTVcd88j4M71BkvMAUIHF1P9G4HLjgX9N
         CVCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwQkD/e0uAPwKE8MqeWsAT6iXzSu5B4MmzR9v0CJL1isPCho2d2wBA+EuA5OYl1rbM6hNUjbs+SY0r/3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+5+5kcY68RLbj2jN3DqtJN2o09XlgCpqFN9FdEfDbX82fw8Yj
	Nhr8iGtmVqhfDwVMnD7Q4xjmAqxhyGMIUioj6MbQfdp9BXwfCG4gIzjzBPiTcJyW6/FXxV+wQK9
	dk5I/rvTmgvhwo2vBmjwUPWnvbdrQut92l50P
X-Gm-Gg: ASbGncugwDsXXHSXMyLJBUX9keTZ64N8SuqryuVd6reZVpriSDtNrUuFz3Zq67j/Q0K
	xJqOKNdlK78S1/AjDwlF0xWPmCxtIq+EHP69FXQ==
X-Google-Smtp-Source: AGHT+IESL/tWUgNpSAQzrl87j2eCkOc09/+to8cMqhW7uI835WQ1LUGaxeGORtfqmEOGd/ePuPsgZvrU3N3ocWweWvc=
X-Received: by 2002:a05:6902:2292:b0:e30:b98e:b111 with SMTP id
 3f1490d57ef6-e434aa0e976mr2988627276.17.1734112875416; Fri, 13 Dec 2024
 10:01:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206233830.2401638-1-abhishekpandit@chromium.org>
 <20241206153813.v4.4.I083bf9188947be8cb7460211cfdf3233370a28f6@changeid> <CAE-0n52AG8henLkzAyO112pBmNAskcC0SXKFNCyQQ3MG01xkGg@mail.gmail.com>
In-Reply-To: <CAE-0n52AG8henLkzAyO112pBmNAskcC0SXKFNCyQQ3MG01xkGg@mail.gmail.com>
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date: Fri, 13 Dec 2024 10:01:04 -0800
Message-ID: <CANFp7mXCChVFaQHiW_RCu_97BnPHc5qHs=E6WcGRGLUEniZieA@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] platform/chrome: cros_ec_typec: Update partner
 altmode active
To: Stephen Boyd <swboyd@chromium.org>
Cc: chrome-platform@lists.linux.dev, heikki.krogerus@linux.intel.com, 
	linux-usb@vger.kernel.org, tzungbi@kernel.org, akuchynski@google.com, 
	pmalani@chromium.org, jthies@google.com, dmitry.baryshkov@linaro.org, 
	badhri@google.com, rdbabiera@google.com, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 3:32=E2=80=AFPM Stephen Boyd <swboyd@chromium.org> =
wrote:
>
> Quoting Abhishek Pandit-Subedi (2024-12-06 15:38:15)
> > diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform=
/chrome/cros_ec_typec.c
> > index c7781aea0b88..e3eabe5e42ac 100644
> > --- a/drivers/platform/chrome/cros_ec_typec.c
> > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > @@ -676,6 +677,16 @@ static int cros_typec_configure_mux(struct cros_ty=
pec_data *typec, int port_num,
> >                         port->mux_flags);
> >         }
> >
> > +       /* Iterate all partner alt-modes and set the active alternate m=
ode. */
> > +       list_for_each_entry_safe(node, n, &port->partner_mode_list, lis=
t) {
>
> This can just be list_for_each_entry() because the list isn't changing
> during iteration.
Done

>
> > +               if (port->state.alt !=3D NULL &&
> > +                   node->amode->svid =3D=3D port->state.alt->svid) {
> > +                       typec_altmode_update_active(node->amode, true);
> > +               } else {
> > +                       typec_altmode_update_active(node->amode, false)=
;
> > +               }
>
> It could also be shorter:
>
>         list_for_each_entry(node, &port->partner_mode_list, list) {
>                 typec_altmode_update_active(node->amode,
>                         port->state.alt && node->amode->svid =3D=3D port-=
>state.alt->svid);
>         }
Done

>
> As far as I can tell, cros_typec_configure_mux() is called when the HPD
> state changes. We'll iterate through here unnecessarily in that case.
> Can that be avoided somehow?
Writing the same value to `typec_altmode_update_active` is a no-op.
I'd prefer to leave this code as-is since it's quite simple (having to
determine HPD vs non-HPD, whether DP is currently active, etc. is
going to be more work than it saves from not calling this loop).

>
> > +
> >  mux_ack:
> >         if (!typec->needs_mux_ack)
> >                 return ret;

