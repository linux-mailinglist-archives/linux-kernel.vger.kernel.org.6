Return-Path: <linux-kernel+bounces-389103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077329B688E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C09EF28634F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0294213EFF;
	Wed, 30 Oct 2024 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmrzRW6U"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C431F426F;
	Wed, 30 Oct 2024 15:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730303814; cv=none; b=ToaGNqCFdZo+cfy7h+UxCP82o9UirSh/qYqn8BeU8N+kdoUZEbRzR1rsn4zoPv9d+sdU4xg+StGQrhDSbZYopM7u/JuoOBQBOrQSPspXB1OnEJT0qjfkZr1+c3LxCCPym3gmbN/0vHt/x2kVo8M9K9TYS8OuiGtF55G28D4NHgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730303814; c=relaxed/simple;
	bh=ZW0Z1z7fi26fexxaXReqhSHLQ43mwuMIaY7MnZ61pik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M22n6KYdZmR2i1aXPbbHk1EzLySNcYHrYg6/Yh5w5WH5KU1cUq7WM7CDD0NPd1P6Z0WFoFRiv8heG9dRY5CwXZn9KXePIJlDNqbPyI3UmgWQZXOUYkKlb/UQOGSMTPm3XOXveFvE77NmXzrkgq6LfUrUYRPeJVkemEIsXcV9boU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmrzRW6U; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53c779ef19cso665097e87.3;
        Wed, 30 Oct 2024 08:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730303810; x=1730908610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X19iDqW1ijGPcxXUtAuGO1cTtZVQCyFCKfwI4nkw5YA=;
        b=gmrzRW6Ug5zXkpRaqxqBEpiJOXzOmuf/bIh8UL94Q9zbGtMZbSblBqGtSEOGWwAuH7
         bd81okNLK650FwZFLCNEv5khVdbF7ngj89Pf6fSUows5PBPoqg6fGf/9/Fu5n1rC2Atl
         yIqx45AMbRuU/avq34gDp1tnCD+bilTUTls91fZ3q/AA+cyOB6ts0hy3Wg+Ly/z4uAZN
         1CpmMdsun5vAUXbH/nzb8+Fu24Eovw/sSQm/bPcK/kBVguq9ix5cZGOGSAdwgusrmBvs
         LCtubW/p495S6vuYvvPAXt2YeF9mtIeDVL4giQqxiRBqsECLmOCqc0Z9YmpQYPfpETt/
         p2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730303810; x=1730908610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X19iDqW1ijGPcxXUtAuGO1cTtZVQCyFCKfwI4nkw5YA=;
        b=b3nml+84HRXRl3uRrBcaBAbQNa/Zy2C2AVZS4R9AFSiv1cEsV7a7TNEi6CIftwQ9XW
         CscJm3Ujo9SrWACMXhDxciL6D/c7u9yek0L7nDmlPwfDKxFSH99QA1QzIhdaDdhKP7fx
         vBM3uIDW70tJYKHghwAYcZ2to5fYqIn2TpVEx8OY6EfC7rBLIoN7evL+YhHhJKZvkp1x
         soQp+79pUD4EQ/jPbjf5ws7ygYjNxnF0ka5WV3cUB7npC9jOCgbrvDyvCJz8LLtBl5yU
         Ttdt8iDaMdN8fhbN+BVWwRJtLoQvTo70CF9BjgfQtrWN9Q33Bg7Xr+tW/m3GMGupYoCF
         Xasg==
X-Forwarded-Encrypted: i=1; AJvYcCUFP6+dk2QyUjV1ZU1PTLB1AeuxUYvCWAIexNboMp5ct6nGsNVnR9dHYjnFZYzaXIsOtCjVkYfiyIdw+SI=@vger.kernel.org, AJvYcCVeTh9W1RXbZloR5nlhVOyEMQShnTqTuazId/V05ljnXn+fAPKv2S1bf47iVUl3X7r+9GgGumLwuUk=@vger.kernel.org, AJvYcCW7Qcc6ErCU1jrs0zzRIeiRiz0gdIJD/VVBcDVjz1Yf3SyCyoJslsKJBKv09A6wJl02syWrdX/jtDbEmvJX@vger.kernel.org
X-Gm-Message-State: AOJu0YzwTKCQr383uB9I+8ArJoY6896Y5jOGrD3ewaW23Lu4RBdmT+Gw
	L67LvC4CMwLMoktrOTnXXTOBYHv5YXY6EXmATOFicWOCXPVODUEI/JdE/+YvYjcwj73JZ0SHcwp
	/7lYpOk6wSLEnGIuTYCUZRek2uBQ=
X-Google-Smtp-Source: AGHT+IEPw1okBb/c/0xvqxjoMMoRPkojlfdjVo8vl+dA3NIQOsFPcFkztD+nmGma6tMichypEWLCEFlyX/R2GgBCYgY=
X-Received: by 2002:a05:6512:2399:b0:539:e9f8:d45d with SMTP id
 2adb3069b0e04-53b34a1b10fmr9358314e87.52.1730303810143; Wed, 30 Oct 2024
 08:56:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029235623.46990-1-yesanishhere@gmail.com> <fceef9c9-f928-47fe-a6e7-cdb28af62f71@sirena.org.uk>
In-Reply-To: <fceef9c9-f928-47fe-a6e7-cdb28af62f71@sirena.org.uk>
From: anish kumar <yesanishhere@gmail.com>
Date: Wed, 30 Oct 2024 08:56:38 -0700
Message-ID: <CABCoZhAgnkDReqdMTgEjKYX4b9y0XqocEheQR1DhsBCtp7zpHg@mail.gmail.com>
Subject: Re: [PATCH V2] ASoC: doc: update clocking
To: Jonathan Corbet <corbet@lwn.net>, broonie@kernel.org
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 6:08=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Tue, Oct 29, 2024 at 04:56:23PM -0700, anish kumar wrote:
>
> > Add ASoC clock api details to this document.
>
> > +ASoC provided clock APIs
> > +------------------------
> > +
> > +.. function:: int snd_soc_dai_set_sysclk(struct snd_soc_dai *dai,
> > +                                          int clk_id, unsigned int fre=
q,
> > +                                          int dir)
> > +
> > +   This function is generally called in the machine driver to set the
> > +   sysclk or MCLK. This function in turn calls the codec or platform
> > +   callbacks to set the sysclk/MCLK. If the call ends up in the codec
> > +   driver and MCLK is provided by the codec, the direction should be
> > +   :c:macro:`SND_SOC_CLOCK_IN`. If the processor is providing the cloc=
k,
> > +   it should be set to :c:macro:`SND_SOC_CLOCK_OUT`. If the callback
> > +   ends up in the platform/cpu driver, it can set up any clocks that a=
re
> > +   required for platform hardware.
>
> This feels like it is (or should be) duplicating the kerneldoc generated
> documentation - I'm not sure that we can cross reference the two
> sensibly through?

Jonathan, wondering if you know a way to link the clock functions defined
in https://github.com/torvalds/linux/blob/master/sound/soc/soc-dai.c here?

