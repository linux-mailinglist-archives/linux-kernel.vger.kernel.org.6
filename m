Return-Path: <linux-kernel+bounces-176028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E828C28EA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 18:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FCB9282D89
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 16:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE941798C;
	Fri, 10 May 2024 16:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WxUwDIpQ"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602E710957
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 16:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715359553; cv=none; b=MNSMqGGcEWm2o2LZjDkAnVujp49TWxutC4y+l/jhZW18BUVbycUZGhBGhsBrNR4yse9MRTQkeXFIF6+svmS5+S/evrisjxN3RGIhObfFb36k09herr+OqDLqAeqHdlKMF3ST20wq5Vvy2dGoakk+b6en+y479BfurenGQ7rOF/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715359553; c=relaxed/simple;
	bh=IO/tJZ68RvBtGtUdjhyK/eRCWJdPd5uxAzWx2KRBods=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDxVma6+AZDmfvtEyJR0Z5VBTLNR63oZm7PZDIbxrrwPA2Ju9THWrTYZT42P5Hk+wT6qeAK7zrU+tXVHO8oIXhE6qA3J+cPc+nTTticct50mfpoRIzSxHg4tp8mQc3asFAwe7MTUdoBMGDr6wSiHfgz7uENTz/KzzPN8/Ixjs4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WxUwDIpQ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34f7d8bfaa0so1644835f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 09:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715359550; x=1715964350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IaxtUnOJmP45P1JGNrV/UVX05M43+pCoWlRSHcvYUFs=;
        b=WxUwDIpQVxw83ailAoc9QvC3yFHVEJo33CGc3+zLoSftPQ50uS1/NjwiEI6Hy24SMy
         voxUq5Vqhay0Pa2zSozgAIexhI4zuok2/bOcxfKG9u972pmYCXefBYkhm4XOUCPOm+cp
         wX85s2pRZ5s2wUeTkTghkh+bTRAUFhleAk9KNDJbItALLG1ME2Qq/m+NvjkWQNJoMzZ8
         ttMl3ktrSpcpOa/SkQtbTMhm90Wr+DIVbE4nLq0epAa6lFns0+K/XxNe0KsciOlyfvq2
         EOm1DT7ENAaIu0FM8esOVvS2gKgOx650XNsYymz2WFf5ZCYdNmAAZ3aN4H7jyF3vFab9
         x/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715359550; x=1715964350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IaxtUnOJmP45P1JGNrV/UVX05M43+pCoWlRSHcvYUFs=;
        b=ISD/2EBuPpF2zHhu8ahkHrQk26o82FwTK3qWRR2Qrwk7gk1I9WlwyubyQuJuUKJQT2
         GYXecLNIdn09tmNIOydDk0rVIP0DopG2E16PtWS+jLaRMTlZWe3RUm5YpmoA4XcOn5li
         b9ZpaPAslYOVwCmqLS8nBwjJxPaH8Pf4Np48RIzUDwPjoVVXlWgTolf1uf0MlQUCkPG2
         UyY/mU6QrkzZwT0aSZWZulDuhVYK8saeKqJKsyxtd2C1RLSd2gZXGWQINxxpBuM1AH7b
         utgnS4RwWx5YIye5RWDhxj9+l5RKccj0A+7DmRl/B94y8jye8xTGFbcPsyfWMgl1u4fB
         agCA==
X-Forwarded-Encrypted: i=1; AJvYcCW7Ku1e0MVjLqozbQo/iz/k/DBBfZQ6zWrZff9/+svki/+xeWYUPo9F9D3G9SM+gDLpzOPPrtDdPV6IVL/P9O9UE1+qGhrXuFcCBpze
X-Gm-Message-State: AOJu0YwIEfbWpBykevKlySjZYZzoQiGZjr9xr5u+e5nwrtSaK+m5j0O+
	eqrZ+xtePgyBi+EQ+43D0UEgv5M1bEUbIyT9BrgFnh80phnGHOnCPFk2SuowMb7Dpfo/s2XKk2Z
	0YiBERF2yeiwUWh4FsG+tKTXrhm1Ajcdb7dPq
X-Google-Smtp-Source: AGHT+IEDr+l7KFhftKmNc/alZdq8t4AOx+lDWsT4CH9fPSrDCOWD9OWtX2TXZbJvbsHhfIg3qWFVvcOGyd+MvQBNtPs=
X-Received: by 2002:a05:6000:12d0:b0:34d:b284:9c65 with SMTP id
 ffacd0b85a97d-3504a969198mr2248659f8f.45.1715359549525; Fri, 10 May 2024
 09:45:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502211047.2240237-1-maheshb@google.com> <ZjsDJ-adNCBQIbG1@hoboy.vegasvil.org>
 <87cypwpxbh.ffs@tglx> <Zj2dZJAfOdag-M1H@hoboy.vegasvil.org> <878r0inm1c.ffs@tglx>
In-Reply-To: <878r0inm1c.ffs@tglx>
From: =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= <maheshb@google.com>
Date: Fri, 10 May 2024 09:45:23 -0700
Message-ID: <CAF2d9jjnB7hkjzAdynSMOWwiy9OZEbTrfSQxsVxhF8wwatW9_g@mail.gmail.com>
Subject: Re: [PATCHv4 net-next] ptp/ioctl: support MONOTONIC_RAW timestamps
 for PTP_SYS_OFFSET_EXTENDED
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Richard Cochran <richardcochran@gmail.com>, Netdev <netdev@vger.kernel.org>, 
	Linux <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Arnd Bergmann <arnd@arndb.de>, Sagi Maimon <maimon.sagi@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	John Stultz <jstultz@google.com>, Mahesh Bandewar <mahesh@bandewar.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 12:50=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> On Thu, May 09 2024 at 21:07, Richard Cochran wrote:
>
> > Thomas,
> >
> > On Wed, May 08, 2024 at 09:38:58AM +0200, Thomas Gleixner wrote:
> >> On Tue, May 07 2024 at 21:44, Richard Cochran wrote:
> >> > On Thu, May 02, 2024 at 02:10:47PM -0700, Mahesh Bandewar wrote:
> >> >> + * History:
> >> >> + * v1: Initial implementation.
> >> >> + *
> >> >> + * v2: Use the first word of the reserved-field for @clockid. That=
's
> >> >> + *     backward compatible since v1 expects all three reserved wor=
ds
> >> >> + *     (@rsv[3]) to be 0 while the clockid (first word in v2) for
> >> >> + *     CLOCK_REALTIME is '0'.
> >
> > ..
> >
> >> I agree that it wants to be in the commit message, but having the
> >> version information in the kernel-doc which describes the UAPI is
> >> sensible and useful. That's where I'd look first and asking a user to
> >> dig up this information on lore is not really helpful.
> >
> > But writing "v1, v2" doesn't make sense for this code.  There never
> > was a "v1" for this ioctl.  At the very least, the change should be
> > identified by kernel version (or git SHA).
>
> Adding the git SHA before committing the change is going to be
> challenging :)

Instead of v1/v2, how about I can make it 'prior to kernel 6.10' and
'from 6.10 onwards' etc. (as Richard proposed)?

