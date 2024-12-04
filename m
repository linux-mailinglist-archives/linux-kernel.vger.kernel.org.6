Return-Path: <linux-kernel+bounces-431933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 978B39E42DB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63D0316978E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF72C2391B9;
	Wed,  4 Dec 2024 17:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bPH6Na9t"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F4223919F
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733335001; cv=none; b=SKj0N0GfarsOeFC1F2JPG/vVAKjGIxSx3KKhCfeTL98FYi6Tf9XBWBtmhPkQP3Dk+yuNrJFAbrq8fvzPFMf9k22ijnJX/zZVlq6cbKNKqgUKg+I8uY/0/iqWruCL0qC5l2IQKxHxP9oQpdfWPjjzimLB9hJzeuTzL45pXLLtyIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733335001; c=relaxed/simple;
	bh=s/MHza7MJXkG1nFdbn0QPB47+YtSmoXdrGZrnxOt8A8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TYA+7lcWT4ujp4LjDyIwEWvA/2qkYw9aX9ig56ylzNWUlyXRA4Vy2WAZMyT5O6q1CrU+3JE2tYKe1fDVEmpy8Ji7UJ2zxO8PG4LyaVwTbbBUoru0lU+imoz7ReFT1qB5/6KL8CuV2lQLS5mRR0y0dQQwJPOsdjjd1FuXQj49pWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bPH6Na9t; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53de8ecafeeso85096e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 09:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733334997; x=1733939797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHj3vJrbaX31W8+69i1XvzHVe+zVu7K9ouv5A/K5k60=;
        b=bPH6Na9t9yMwKrFxmnR6RCCxrkqS4LAkw+b6Hyr/V8CPX5SLSNoJCfl3XuQnrdNZT2
         CGtCvneWyX2c0pOCrDJ4qbCNILJ4korLnI3zE5sphNG2yYfCxx+8koq6D7bKawraJocN
         sTHKacKjSYiogEkTc011VBbkmLMwitrsuoU5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733334997; x=1733939797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHj3vJrbaX31W8+69i1XvzHVe+zVu7K9ouv5A/K5k60=;
        b=G3+mt1nzUafiMgt7wMJAvmUFU4l2ruN3NzwMivaxOzpco9J6Bu4oBXQqQSiffbKANz
         lxabtUWOOJiOkJykYyYX1S71Uet/7IK9h6DMDRThf/iHS9dWVfjBZfRwf/q/tWEVBAqz
         DsNhJJG/zm8SJhX7gcXRp6SXEt+JeC3nbwlCkvktvhCpEevtbLyQDSiBsPv/t7r8TQzl
         j9XTOcyaa38FjsdVnm1UVKE+l9+XC5DgANP3wKBu8L4yXLVq3t6w7SBzAMZyMUwCXqPS
         Le/nJFOy960FOxHOaA/WPDH954muWo5Om65QxESo/HPVDpS4v6alWCisYFnj4ZEAhOY6
         vr8g==
X-Forwarded-Encrypted: i=1; AJvYcCXKUO5kXhwk8VSSLerWMJJo1DgTxYbsZrp7Sykc3JH4x7n7LTT9twIhQEct5jdnntYwhWDgpNp7y4UjuJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+HacCMhIGsGOTUpxlisznFuObXF8qVJk3X5NJKamg2gpX/ezc
	kcLVFynTTbSVeEGOwHAA22XdEWcDjJBIgHn8RxDlkZgpKTvbmbSXpLcHVpoCF2q5x1LOk3Qb74P
	yFDpT
X-Gm-Gg: ASbGncsir5CG10BWuw1RT9UT/5GXSq4JTSGj67I8HZLUd/+Tl/Ym5feqMqzwJdrYTgZ
	TQbYHJYx54FUCk0INApxMvc9zLWSTn5ih94J4pZ926LDG/u33Xzq/gU8PmrtwX7bDrklxBg7WsZ
	EcCcpHegpVtNhLtv12u+a50XQmbXGb0Bku2PbmeGNjfMw1ZmCR3AfvsNkPG7jzcZJt+be7TvBah
	yrjrLrmwtCSxOZs286bahV71Vt/t5p9OBefJZO1ygAlw9MFBKDnzWTy++L+X8BEXX3+FkbBcnwG
	wTYNvRjZdeFnyE18bg==
X-Google-Smtp-Source: AGHT+IHGxaIaImXPSt9cy3qvNR33WHi7S6/hUXckmHWc1vCppNor7bKXREbX0WxEYxrey2Wgv+Z2rQ==
X-Received: by 2002:a05:6512:3ba2:b0:53d:ed5c:4bd3 with SMTP id 2adb3069b0e04-53e12a38888mr2439559e87.53.1733334997063;
        Wed, 04 Dec 2024 09:56:37 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e1c90a959sm338017e87.259.2024.12.04.09.56.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 09:56:36 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso65172791fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 09:56:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXELJl5Z1Ez2Lx/BeC9Jg+WXJASjy7PInxz22spFs7m0pKBSPPtEqvj3+p1Er3WqpznW7nnwquPYr7/DcI=@vger.kernel.org
X-Received: by 2002:a05:651c:892:b0:2ff:d3c6:9cf4 with SMTP id
 38308e7fff4ca-30009c0f677mr35650171fa.1.1733334995614; Wed, 04 Dec 2024
 09:56:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127105709.4014302-1-treapking@chromium.org>
 <CAD=FV=XhDdBJXfC72PZAbgaSpVx4ubtKSRFptock0SMRg=+Miw@mail.gmail.com>
 <CA+ASDXPXiyga6mKLBacupCXa0wsBbXCrmq20RFo7T2eSF8kbzQ@mail.gmail.com>
 <CAD=FV=XuResyZK1ke1NtaGREfwm_3MB-u5t6vw459kYPt0LZwQ@mail.gmail.com> <Z0-4umP9TnNAbJXO@google.com>
In-Reply-To: <Z0-4umP9TnNAbJXO@google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 4 Dec 2024 09:56:24 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XnFuerG3VG6DRtPZzPSBObxP4T4vBcTb5DAA1CaAPgRw@mail.gmail.com>
Message-ID: <CAD=FV=XnFuerG3VG6DRtPZzPSBObxP4T4vBcTb5DAA1CaAPgRw@mail.gmail.com>
Subject: Re: [PATCH] wifi: mwifiex: decrease timeout waiting for host sleep
 from 10s to 5s
To: Brian Norris <briannorris@chromium.org>
Cc: Pin-yen Lin <treapking@chromium.org>, Francesco Dolcini <francesco@dolcini.it>, 
	Kalle Valo <kvalo@kernel.org>, David Lin <yu-hao.lin@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 3, 2024 at 6:04=E2=80=AFPM Brian Norris <briannorris@chromium.o=
rg> wrote:
>
> 10 seconds is likely that *something* is wrong (or at least suboptimal),
> but IMO, it's not quite at unreasonable levels. But yes, my point was
> mainly that it's squishy, and I personally wouldn't want to be the one
> running with the lowest CONFIG_DPM_WATCHDOG_TIMEOUT out there, given the
> known behavior of multiple drivers and the timeout-means-panic behavior.
>
> > Maybe the ChromeOS should change to 15 seconds for the DPM Watchdog
> > timer and that's a better solution and leave the WiFi driver how it
> > is?
>
> That seems reasonable.

FWIW, I created a public feature request for this:

https://issuetracker.google.com/382269699

...we'll see if we can get anyone to bite on it. ...and then see if
upstream folks like the idea too.


> To be clear, I'm OK with this patch, if we can get a little more
> confidence in it (like the timing data and HW info). I *think* 5 vs 10
> isn't a big deal here, but I don't have much other than my guess at the
> moment.
>
> > Another thought: I wonder if it's possible to be dynamic and somehow
> > set the timeout as "max(10, dpm_watchdog_timeout / 2)". Not that I've
>
> You probably meant min()?

Yeah, I always screw that up. Sigh.


> > >  Can you try testing (and gather timing numbers) when
> > > suspending soon after initiating scans? It's hard to judge what the
> > > lower limit of this timeout should really be without any numbers, jus=
t
> > > like it's hard to judge whether your 10 second watchdog is reasonable=
.
> >
> > Pin-yen: is this something you could gather?
> >
> >
> > > Also, for the record, since we might have to field regression reports
> > > for other systems: what hardware (chip variant, FW version) are you
> > > seeing problems on?
> >
> > Pin-yen: I'm assuming you'll provide this.
>
> I'll leave it up to y'all (Doug and Pin-Yen) whether you want to provide
> the above to provide a little more confidence, or if you want to
> reconsider your use of CONFIG_DPM_WATCHDOG_TIMEOUT.

Possibly the answer could be both?

