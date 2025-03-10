Return-Path: <linux-kernel+bounces-555057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA0CA5A500
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E636216D928
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5701DEFEC;
	Mon, 10 Mar 2025 20:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2H2jIIy4"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B6A1DEFEE
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741638712; cv=none; b=C9IhM7qjM4K7tDziB5DLKYpFDCDYmK6rQz4AJPW9ijtFj8Yb3J32/hE8x2rd47oi2oKqlSMVsv6KCwPFWvqz2SqBbiBQI24Ou41FyArxTCcRWeZlAmj09mDinEFwSlq9UN15WxqkUkPbqMsnW4OsvavR/lnVLGCr0WFpYl51yfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741638712; c=relaxed/simple;
	bh=vPI2vdFz6faudexW5pLqxAk1let8kmq4hkQftQKYf+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IShFXcS3d6l4boyazgN+cu8Cm5lPY/7x8i/IXCafb4xwTUihnTWomghKruUCVJf3cpkA/WtYOGCjcTdmNtQKtJbCOuzqalQr2Pa2MnEFWgfGO+Mnubgt0zaK0uIvXRbt70qa/Mouhe5bYT6PNp93A9+iqTjqdj07cnhp/lC/DKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2H2jIIy4; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5499da759e8so2320620e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741638708; x=1742243508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iU9Zr9AdDxObefou97uhuyBrBosAUFAYDvZeeNLaZkQ=;
        b=2H2jIIy4XVsuZ1NFVWtqZazFeEqZ1nnrO/wA7wGdmZOrRKqJWtQcTa4eieG6S54TJn
         GWifWRnQ9ortzxwlrHqJiF+fB1b7Xt8jM2tRk65JDfkM93km35gc9aNc6ouNgUT08ewz
         IiLcMlv8c9orFbn/0FlA/+YrgUgbpO6Mmq4Y/HYAXD3L/7mHvYqaehGZThC5435YmVOA
         jt1bJq/M7ogy/9GZmWCatZG+gsZX9Gz6w70P/TIXGPo6llXvA6k4bwDaS2GjILW4v5UD
         Z7wuETSzUYzamVWBV0bpeD8XhVApoyyqaE1sfXNJJx6nU2oCPaI4GHNGvYh+utyuovq7
         tFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741638708; x=1742243508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iU9Zr9AdDxObefou97uhuyBrBosAUFAYDvZeeNLaZkQ=;
        b=gwDHDRYgKs/Lz1UeHkTmbs0tfTwvQA2Ky5ce0/e6L/hyEzUpG9LiOLJPar4X9OFgOZ
         XS4k/nWBAPVZev2VadfcRs+I67fQpiMK1qwN7aYkejJk0ogfx+HVg25RupnOBtA3Srkl
         QSQDW1EHNASVXqr8Ip7SJhOqTYJw2ATrVG1HlwtUMFNijm860JJFEihu1rnbDYNmKcx1
         LSX6u7DwlGV0c7UtBSAHsyUT8mbVCQRgz9GIh1fio3XctNIYqWP1/4BMwrD78p3BIgKw
         m5iDwGUHiaaKk8MAMgp+/+mo3HRvkuVa1mQIe9G9/nyay23xIPnixxS9kSdD/TG6+fqW
         15kg==
X-Forwarded-Encrypted: i=1; AJvYcCWdTZAJpFEyA/bldknHFfy/m0bQMsxoXeThbQnmbU+WBJS7y+Lmb+i7NK3u6dv3F9P7YkS6+aco5k+FXsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKDqdJig1HvMzCFsSb6bA1YHX9cD8CeZfq3VQrzZi+hLS41Sjd
	MwW3i1N6zhpdmE//DO1LY5D9hi4gyzrv5cw2tIG3tsddj3ObjpYD5PZ9G38EVPgCFTQusp/HJGd
	YjqSMXmHWX0ti6Z4USE3pojRETyLOXAAsSSle
X-Gm-Gg: ASbGncuGfZhXEp+5o7y/dFS02Ba23Q+/37yYUrSfaOxw2ei/kG1SUZK2Xt0EnPpQwKG
	KgOaMdqiPyc6ZzviEKi2lXJ16jhzIOewSFWxMp886JhStVwUrkO+BFfzX63GjoWa80M/aekhjcC
	3wcm7ATOFWJz5WTzUoE2Z6PovD1oq118PERAU=
X-Google-Smtp-Source: AGHT+IHg1D8UEfw5egbWh6K7jcsDx3TSENUA4mkd2p1bukzpPwxKtDZI2o6raUSNsZ8L/BGV/bOHC1+0QLsES/QXpRQ=
X-Received: by 2002:a05:6512:2398:b0:545:3035:f0bb with SMTP id
 2adb3069b0e04-549abd648c5mr332985e87.22.1741638708118; Mon, 10 Mar 2025
 13:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13709135.uLZWGnKmhe@rjwysocki.net> <CAGETcx-ow3T_R_Lj1s3sjp6nQz6Wv7T3dQdP3HJHd+E8nkh6rw@mail.gmail.com>
 <CAJZ5v0g3qOvESqvqiCnwVz2BYGHzrG8=nRQ8j36Qd_LC0io_Tw@mail.gmail.com>
 <CAGETcx82sLvG19eUN1ATrL5RzEKJjOeWP+kdYJdQX9O=ck7q2Q@mail.gmail.com> <CAJZ5v0guoA-xp-yyr7Fb7ikmE9rjt8xwDPcxU52sd0UP_u=2jA@mail.gmail.com>
In-Reply-To: <CAJZ5v0guoA-xp-yyr7Fb7ikmE9rjt8xwDPcxU52sd0UP_u=2jA@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 10 Mar 2025 13:31:09 -0700
X-Gm-Features: AQ5f1JqLC2c8Cn3c-TiaSuxoU5BT2DXhEgQgoiy3YZ_Nljp52pK0DcVf0QTG8m4
Message-ID: <CAGETcx9WZWiUd+YCQfoZEGGbewv2nrx2TiQJs55KEWbOUg9TCg@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] PM: sleep: Improvements of async suspend and
 resume of devices
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 9:01=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Sun, Mar 9, 2025 at 11:38=E2=80=AFPM Saravana Kannan <saravanak@google=
.com> wrote:
> >
> > On Thu, Feb 27, 2025 at 8:23=E2=80=AFAM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> > >
> > > On Thu, Feb 27, 2025 at 4:45=E2=80=AFPM Saravana Kannan <saravanak@go=
ogle.com> wrote:
> > > >
> > > > On Tue, Feb 25, 2025 at 8:46=E2=80=AFAM Rafael J. Wysocki <rjw@rjwy=
socki.net> wrote:
> > > > >
> > > > > Hi Everyone,
> > > > >
> > > > > Initially, this was an attempt to address the problems described =
by
> > > > > Saravana related to spawning async work for any async device upfr=
ont
> > > > > in the resume path:
> > > > >
> > > > > https://lore.kernel.org/linux-pm/20241114220921.2529905-1-saravan=
ak@google.com/
> > > > >
> > > > > but then I realized that it could be extended to the suspend path=
 and
> > > > > used for speeding it up, which it really does.
> > > >
> > > > Btw, maybe I didn't  word it correctly, but my patch series was mea=
nt
> > > > to speed up the non-async case too.
> > >
> > > If "the non-async case" means the case with "async" suspend/resume
> > > disabled entirely, I don't think that the ordering in which devices
> > > are processed can be changed just because there are no known
> > > dependencies.
> > >
> > > > I was going to get around sending a v2 of my series, but was caught=
 up
> > > > with some other work. But I'm okay if you want to finish up my effo=
rt
> > > > -- less work for me and I can focus on the other aspects of suspend=
 :)
> > > >
> > > > Maybe add a Suggested-by: to the patches?
> > >
> > > Yeah, I can do that.
> > >
> > > > I definitely want to review the series, but very busy this week wit=
h
> > > > some other work. I'll get to this next week for sure.
> > >
> > > That should be fine.
> >
> > Hi Rafael,
> >
> > I looked at the full series and it has at least one bug and a few gaps
> > that I address in mine.
>
> What bug?
>
> You need to tell me specifically because I'm not aware of any bugs in
> this series and unless you tell me what it is and I agree that it is a
> bug, I have no reason to believe that there are any.
>
> As for the gaps, there are obvious differences between this patch
> series and your work and it would be kind of nice to explain why they
> matter in practice, in your view.

Sure, I'll do this. But it just felt like an inefficient way to get to
close to where my series is. Instead of you just saying you don't like
about my series and giving me some feedback on how to fix it.

> > And those are what make my patches have a
> > higher diff. Can we just continue with my series instead?
>
> Of course you are free to send a new version of it, but it is unlikely
> to be a sufficient replacement for constructive feedback.

Ok, I'll point out the issues I see in this series and hopefully you
can point out the issues in my series and we can move forward with
mine if you agree with the additional issues my series is working
through.

Thanks,
Saravana

