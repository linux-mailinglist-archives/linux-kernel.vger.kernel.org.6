Return-Path: <linux-kernel+bounces-322983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3203397363E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 13:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B56BEB23E5A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B0D18C025;
	Tue, 10 Sep 2024 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="hhtl2JL7"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5842918C02E
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 11:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725967827; cv=none; b=q55qgQUSaQ/+qgnWUY3F75fPSXaESIH4v3kckldJer4VXmi+pOR/vztK1xinHswROywLOVul8lm4HHDmDfALFPK6pioxvtmzduSBeKohTbsT58zjsRs1xhirPHR8gXWzDqWL1nFgs2XgcDmBtpJjG3nrgrBS+fugWlEnpAZGiXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725967827; c=relaxed/simple;
	bh=OL8L8Me1zC15k939eEhgv7Aaj5qBTBEeGHgYyXDzbCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FNdHsIe4YuBydX1JStVmOAAasFQbTQZIOjjfXzUHDcdtYefgBQqPT9iN6UUrg2KL8jKRvRl1By/NCJk4IcQ4BzqrU21StsIz/boQS2JUCbEu8ZyWsyjBdTciex/JP7Qe4pSCXrP8uu6NAKd5es2M9W9TKitUZhKzg04xKQCtv1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=hhtl2JL7; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5356aa9a0afso9372116e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 04:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1725967823; x=1726572623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUjD1qXlr7sDXF6Pz2mpEF9dvaXJD/VmLWCG9uZrJWA=;
        b=hhtl2JL7fzkbaVrp5UB9GVL3j3zeT5AVtzleiBg4hjuWnPfeSrRSBCP6b3ZOIETxQr
         YV6gF+dZdtGe1J8/dPqW0zirhNZ7I2yz2QiRRcw1c+Bj3nrh1pk2WoxoSQV2Bsy/KUm2
         EY+JJa7XvAUenl22ExrPLE212XmplmQPzslLAUcp+/Dk+/WKPAFkwBvIAXQwGoz/S0m1
         u2iXxeCLwOwlROITj24F+7k6guI/YNcf4JpSnaFrIhqU+xe63UHsyXufVYkvTcvMtMj0
         CY8aInESuh9jHd23NHSL8SYlrYQgtVUroO96XU8Fsr09VWY74q5iyutYEr0Y7T62joQj
         FIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725967823; x=1726572623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUjD1qXlr7sDXF6Pz2mpEF9dvaXJD/VmLWCG9uZrJWA=;
        b=uoBQw2iksbNiIRUR/aVL1D2YrBimJuhiOXgV6zOUF8XIDsXb9w0XdyXovAIsESiuyJ
         eCNygZtQKb1EpY17jky2sKtw76cupVrV7IlHnnV+MAQtbAtvgx0+ovzRBijd3T6zeivy
         kyi4EK0/54OfKlhT3xCDk64IJvhMbEmFV9XlQV2V3BzgFqiSwYeJy9wnQgKZUSppI7pR
         6uSljS5K4Jq+EwBRYfYhfJ0/561AaUh9wcpU7bvgYfSQvFptPuxRknLNqz29Odx2A0D8
         XPaE29CU3U7cm9JzRieDr5gzY4/9Ke/Yx7BbyS1vuZsc0PamYwE4BULG1kaNgvzaJ9qW
         j++w==
X-Forwarded-Encrypted: i=1; AJvYcCWH1ZXZlXkEM/X1ElBSly9/n/WZj2K20t/UIpdlmiUeIaTfSGFcx7mV8HkEMJZj0A+c1oqr1F1LlKRhxeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ7+gklpAaJiFFIeULLfzZfXp44+7qwFWmOqbEzh35E5KR3d9C
	N1/0gcokUeuWL678PzyOprL9+8AsDqf15BH5AynU0penTleFM+xO9ZLtJfOqelprsjGf4/SgZFt
	dwnd35AMceWSpAMfN9k3Gkw2exgfOD/Y9FZQLzBsNeWCo3xtI1bM=
X-Google-Smtp-Source: AGHT+IHrlni+UNeiultZRq3v9U0+1z0gggaQueGwXZzkBD3HHF8mRaNy0AyLPtkFaiR/t3CDGpdPiVEjlEkJArOyyQc=
X-Received: by 2002:a05:6512:3d89:b0:52e:933f:f1fa with SMTP id
 2adb3069b0e04-53658818d02mr9921240e87.61.1725967822511; Tue, 10 Sep 2024
 04:30:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816065458.117986-1-iivanov@suse.de> <ZsU9SRlQgzQn8bDs@mail.minyard.net>
 <20240910102531.grjtn2rdmagcgphb@localhost.localdomain>
In-Reply-To: <20240910102531.grjtn2rdmagcgphb@localhost.localdomain>
From: Corey Minyard <corey@minyard.net>
Date: Tue, 10 Sep 2024 06:30:11 -0500
Message-ID: <CAB9gMfqnpu9hpS8U=umGFV6k+KSoG+Luw80KL10_Qdqo3mLU8g@mail.gmail.com>
Subject: Re: [PATCH] ipmi:ssif: Improve detecting during probing
To: "Ivan T. Ivanov" <iivanov@suse.de>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 5:19=E2=80=AFAM Ivan T. Ivanov <iivanov@suse.de> wr=
ote:
>
> Hi Corey,
>
> On 08-20 20:05, Corey Minyard wrote:
> >
> > If an IPMI SSIF device is probed and there is something there, but
> > probably not an actual BMC, the code would just issue a lot of errors
> > before it failed.  We kind of need these errors to help with certain
> > issues, and some of the failure reports are non-fatal.
> >
> > However, a get device id command should alway work.  If that fails,
> > nothing else is going to work and it's a pretty good indication that
> > there's no valid BMC there.  So issue and check that command and bail
> > if it fails.
> >
> > Reported-by: Ivan T. Ivanov <iivanov@suse.de>
> > Signed-off-by: Corey Minyard <corey@minyard.net>
> > ---
> >  drivers/char/ipmi/ipmi_ssif.c | 24 +++++++++++++++++++++++-
> >  1 file changed, 23 insertions(+), 1 deletion(-)
>
> Do you plan to merge this fix?

Yes, it's queued for the next release window.  I should have responded
with that.

-corey

>
> Regards,
> Ivan
>

