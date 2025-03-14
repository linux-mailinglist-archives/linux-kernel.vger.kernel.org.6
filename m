Return-Path: <linux-kernel+bounces-562137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8239EA61D25
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FBAD19C6611
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D1D1A23B7;
	Fri, 14 Mar 2025 20:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C4/B6PUD"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA16A32
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 20:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741985412; cv=none; b=AGWtMiDdQ9zDWSVB93HscqpbLZeZmYGgNYd2PKvMmUCTxsp8D14CuBmWMQhkyu1KVBKzpnwHF41qsb+iU/rNj+wS/euudHU67y4E2Dd5tyUkpLES8YmEz2n7G0MoDFBGMW7QFrZoN1d+5UlEc10A03HXmuWQhxMzD7i33LQCYl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741985412; c=relaxed/simple;
	bh=vIru7H1hP1FQA8IKmmhv+bwpncxCOSretzkl7D+50uI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MOqIdQyKHZgcY1gpohurzJZpqPuOvgujMuB0lBW+3z5dNaYQu4NK2jZxbouP6huc0rzx3Z7S0xcYznaFkb4RMnTPMKt13WP1hRbbNjOOLaOmnFnKE97oSPsjFj/+KjbVtXc6eN0A6+RhO1Tj/GkHoC72hTegz7wfMJuaGg4Ujeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C4/B6PUD; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5499da759e8so3954056e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 13:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741985409; x=1742590209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iA6XtNdlySX5JQDvW/SznpZemPYfjOfhDA5u/GSi5jY=;
        b=C4/B6PUDjPzhBBCogcVx0jtQ8iPdyGXnmLq44Pzl1zCqSPRhQ7dmYBg44bemdbU1Cz
         wRVsZDVFCKUwy6URuKsdNiAu4ngRCkqfWNXdMZiNLfTvex0Hqx4XcBN+P9o2+b4AyjiP
         W+HIUuVHI27+OH4+IsovgYtzXQO48Lu/ry3h+R/YvThOK3QF/OJOSZwMsgO+SnC0JqmY
         qKcGQvTlKqH1KKgDAojn3ouEfHUBBE5A61HmScafs1L10iTshQwNWJwab80RmsAqsz/w
         9yjMvjpF4xbuiL5jZPW+outOXnyoGgmo52dK5q5X76jK22KqyW5KQSre7hoQA/nPvAj1
         IRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741985409; x=1742590209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iA6XtNdlySX5JQDvW/SznpZemPYfjOfhDA5u/GSi5jY=;
        b=A/25doKDzdNLnPQbH7zis5ID839ivb6tIX703pbii//Vs6Gnx4QxRgN7TuDkJsRLTH
         c5pHKyzKb/qC3/CkgyxCTAFTDWpnYtUCyRdKj7/TCuGw+rMk6gBxATMO1TF3K/ZVYLOp
         ftZEfM33OiWGn/ZXvhFrUsjblyqT5qiHAhTMd90/X20KHvn10z1geOjeAB4fwq6FHKtc
         jj8XFHz/trLaRHNX9Bw6GRnhDrgGhI8/w3VaHj8cAf6EW5r631n8W9UOT4rKQ3QSSA6w
         fTlsXKKIijlsCF4WJEvvpCT8Kqt6CUhvcy8ypH5MVvBZz5CGvh9TzqTQmPHFkLiCKdsa
         uBgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx6brFAlHlG84m+HVHHC8gBVVaCHHzU9D2IisaDDvP6g+Qbms7xDAOZuXn6Mzq6iLLE5rCdDlZbeJfSUw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5FAaR9gkaxF8yeY+jmUVfSWrzF60LvQEEpOISDAxe4FRwrG6m
	w5ePb9O0iuF00qunF5dYePL4EbcxZMdeevNjW9lCW0WYRmyVKE30j2niE7UV4RyvZrGFNlQDGTt
	zHLW9Gj2HYW7kK2mtQROQ8C8J+oj02NOznBSQ
X-Gm-Gg: ASbGncuKQK48GF98Cbrx0ip4rlJhJ3cSA90vwj0SQ/k5TnMJboydYeoTYII3T2JOYNR
	ya4ftEsGbePS7wOz6x9ft13pKIuTR5HAMv/wSHS+ASYdS7VFu2rBmNtF13WggoDu72xcvAI3KmC
	xK/4s4rCJZqN++yaOITqpx7/fD
X-Google-Smtp-Source: AGHT+IFAg45SjFKHBOIoXpo4chfZtm9U2OeL3IcUvUP+6gtmvyLqt5LeuQNKcwZ0eOIH9ytw8Uq6cwDf5anxg4ISE7I=
X-Received: by 2002:a05:6512:2811:b0:549:9643:68d0 with SMTP id
 2adb3069b0e04-549ba44006cmr2970552e87.17.1741985408470; Fri, 14 Mar 2025
 13:50:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114220921.2529905-1-saravanak@google.com>
 <20241114220921.2529905-2-saravanak@google.com> <Z9SV5UymVcuUkSE1@duo.ucw.cz>
In-Reply-To: <Z9SV5UymVcuUkSE1@duo.ucw.cz>
From: Saravana Kannan <saravanak@google.com>
Date: Fri, 14 Mar 2025 13:49:31 -0700
X-Gm-Features: AQ5f1JpkxQoNFJkeqXxhobd44dP2b6V9Y2pHPuZ1QzilqhDClN1TfxI2FZLcsLQ
Message-ID: <CAGETcx_bSOAYwvc=M4nTJF-OAb-nNCQ5bCfQcrHMhyLmv3rd3w@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] PM: sleep: Fix runtime PM issue in dpm_resume()
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Marek Vasut <marex@denx.de>, 
	Bird@google.com, Tim <Tim.Bird@sony.com>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 1:47=E2=80=AFPM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > Some devices might have their is_suspended flag set to false. In these
> > cases, dpm_resume() should skip doing anything for those devices.
> > However, runtime PM enable and a few others steps are done before
> > checking for this flag. Fix it so that we do things in the right order.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/base/power/main.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > index 4a67e83300e1..86e51b9fefab 100644
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -913,6 +913,9 @@ static void device_resume(struct device *dev, pm_me=
ssage_t state, bool async)
> >       if (dev->power.syscore)
> >               goto Complete;
> >
> > +     if (!dev->power.is_suspended)
> > +             goto Unlock;
> > +
>
> This needs to be goto Complete, right?

Yeah, it's a bug even I pointed out in another email. But Rafael send
a new proper fixed up patch that I Reviewed-by.

-Saravana

>                                                                 Pavel
> --
> People of Russia, stop Putin before his war on Ukraine escalates.

