Return-Path: <linux-kernel+bounces-196374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866278D5AE8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7F7C1C22ED1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 06:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF36980C09;
	Fri, 31 May 2024 06:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ns1sVLA7"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D63A7FBAE
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 06:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717138573; cv=none; b=RPzF+mj38dCbe0+Btb7NUF10LcwPB+CFlipbQpOpt0bIgTRhjoz3e+V520vidTpiGW3WzDJnrkn8RkaiuYeL6nEIg8GIM4YJ7QkgdUNlT6zGpb2F3EovDcrVmZl+DrYeTOZURJFYqdFpBPMliwTYZxCQ4cA05znU82THrANqI+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717138573; c=relaxed/simple;
	bh=rDjU5whvSyy64bLjX3EGuXwyqnk2V2gqwwhRXFsUETA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJOA1nKgePWY4UzLJIBMGgvRfuh01SLB3NaS0amtX7oFmDBezJNrOjxpT2mKItjwV1PgWVqUxKjvNVA7gwEgEFjesOFg20Yh5hAI37heGe9xN/1Ho7tc92k1xCQhqLX45eybwrmdoeLGMdTqClb9ZjeiY+Nuz2mxDBtyQId5oZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ns1sVLA7; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-24c10207d15so825616fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717138570; x=1717743370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmmGEIEiP+RXWcqXsFf6qa0SBKaXKreUvEwc8aJmwc8=;
        b=Ns1sVLA757IUcl5uaoIapMZII//mkRPvI9si+oftZ5cqQhEdRb8KCsMf/icAldqiDr
         2TSmL2pUDulhSniM05awV2sjYWePoRfOFk7aFxBt0aGFWH5otyCbXMRJzvl9hltli6h+
         OseHAtScgKbhAAmS6NqoR3S9Ok4u9/4ldjK8zgVr0Dp962ZVd6d6GRhHVfYkDKgy8AUR
         mxfL94Kfr+tQEbhdXjmdVemWlAxCJ2eM7n1Lfjy94X2nhn80pTRCqYUbnAP6U6xeoaud
         QPCEYBIeomwn3S1jvKA82JOUPBbJs2q9zjHrOcjfW5ejBD7ImuPasYrTtTQAUA57TGGC
         l1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717138570; x=1717743370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmmGEIEiP+RXWcqXsFf6qa0SBKaXKreUvEwc8aJmwc8=;
        b=nSw0nBX3YArhM3PSQmsttFr/uPZIlV0OD9x9e9NrkjbfiYCGuz5cPbsBRZVNdqET5U
         7MifxdvBsvS/WcKlVIR/1x5chKbmyLB8aYnvnnnXVCeygZxBPjQT9i7d3kjshQaR8RXi
         Ln9SzZejAEI9RNLaT9T2sGT3SnNK/HlsdZj10lLmmQRfOv5mujXsh2kYvBfVj6hBk6w1
         ymn943X8K1cub/kxY2LnzHUPYXO9HLp/GmO+R6U/s2sEMydgyE7zUj6VsnjE2yqhSgBn
         Twsn5jo+ms6i41dZpgDwPfCWHexC93iI+vymwRZU4eOHjbll6Hr3vZcIXNM8rjf9FTKK
         lMtw==
X-Forwarded-Encrypted: i=1; AJvYcCWVTYNjFpxKkWWvepCy2IOby5SWp9+0Ee7HtypDne/Owt/cCazllb/ijCUURrKbqEoEc7N2sWOfA0MufvGQ1nGEAf1MC8LlJgez4SjU
X-Gm-Message-State: AOJu0YzgGe98vD2Kww+m4OI3a93jZOvlKvxV/kNKWtljzDwDG01DZBq9
	Oa3jGfQchaILYKaTaY8wIIZ1I6R8e9DOI4CGiMsfqOg+zIFNe1C7U8Svyt0VXQxD9XxXpGHBjur
	aDj4JjTSLXZiEPkT5vJYxc98T0g/NbeNVu8zKHl+Xe4khG88PP28=
X-Google-Smtp-Source: AGHT+IEtLc8q750EW+lhfvstjGAuhAQBsRVsWSDNxtmSoDQYn3O6DHfwpdwQD3UPV6TyURClBWGTjrlbf6AI7cLNbeU=
X-Received: by 2002:a05:6870:724a:b0:250:8255:e793 with SMTP id
 586e51a60fabf-2508b993d50mr1295191fac.23.1717138570065; Thu, 30 May 2024
 23:56:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507020037.14009-1-gavin.liu@mediatek.com>
 <CAFA6WYN79E8Hyxsaxu20hkyNebMqBWV7az5ByekTuii7Y7qjng@mail.gmail.com>
 <929512b561536d4ddfaeda518f2ce306b899f3a9.camel@mediatek.com> <CAFA6WYNRVa_oem2TdyjoaUOTmW+vED-7LOC4wFjqG+puptg8tQ@mail.gmail.com>
In-Reply-To: <CAFA6WYNRVa_oem2TdyjoaUOTmW+vED-7LOC4wFjqG+puptg8tQ@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Fri, 31 May 2024 08:55:58 +0200
Message-ID: <CAHUa44Hpfq+6qsuZ9NYUB55br=5H0Bi1p7ALoAY3Cad5egOcdg@mail.gmail.com>
Subject: Re: [PATCH v3] optee: add timeout value to optee_notif_wait() to
 support timeout
To: Sumit Garg <sumit.garg@linaro.org>
Cc: =?UTF-8?B?R2F2aW4gTGl1ICjlionlk7Llu7cp?= <Gavin.Liu@mediatek.com>, 
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	"op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 9:35=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> On Tue, 21 May 2024 at 14:16, Gavin Liu (=E5=8A=89=E5=93=B2=E5=BB=B7) <Ga=
vin.Liu@mediatek.com> wrote:
> >
> > Hi, Sumit,
> >
> > The corresponding OPTEE-OS pull request and change is here.
> >
> > https://github.com/OP-TEE/optee_os/pull/6641
>
> As this is an ABI change where I see backwards compatibility is
> maintained. However, the forwards compatibility requires this change
> to be backported to stable releases. So for the next version please CC
> stable ML.
>
> >
> > On Mon, 2024-05-20 at 16:16 +0530, Sumit Garg wrote:
> > >
> > > External email : Please do not click links or open attachments until
> > > you have verified the sender or the content.
> > >  Hi,
> > >
> > > On Tue, 7 May 2024 at 07:31, gavin.liu <gavin.liu@mediatek.com>
> > > wrote:
> > > >
> > > > From: Gavin Liu <gavin.liu@mediatek.com>
> > > >
> > > > Add timeout value to support self waking when timeout to avoid
> > > waiting
> > > > indefinitely.
> > > >
> > > > Signed-off-by: Gavin Liu <gavin.liu@mediatek.com>
> > > > ---
> > > > change in v3:
> > > > 1. change the comment in optee_rpc_cmd.h
> > > > 2. add macro for "TEE_ERROR_TIMEOUT"
> > > > 3. change from "TEEC_ERROR_BUSY" to "TEE_ERROR_TIMEOUT"
> > > > ---
> > > >  drivers/tee/optee/notif.c         |  9 +++++++--
> > > >  drivers/tee/optee/optee_private.h |  5 ++++-
> > > >  drivers/tee/optee/optee_rpc_cmd.h |  1 +
> > > >  drivers/tee/optee/rpc.c           | 10 ++++++++--
> > > >  4 files changed, 20 insertions(+), 5 deletions(-)
> > > >
>
> FWIW:
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

I'm picking up this.

Thanks,
Jens

