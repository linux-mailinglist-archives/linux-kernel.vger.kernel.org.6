Return-Path: <linux-kernel+bounces-350852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 445DB990A84
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1772281668
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDC31DAC8B;
	Fri,  4 Oct 2024 17:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="T40dcfB8"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4997D1E3786
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728064797; cv=none; b=HyWKrNGhMWPQnJdRN5ljtokdVtVdlF337qDicwt6oGQSk03nmdzUgE0i/qqw0kg73LBNaEAInctVytGYKX+aUsh9O/H2nYKI89Qa+AcCbjSnSfK4A4Xlygry5KamUki2wRa/6xO/MWkgBROjFDI+O2Ym4oh6CzJX6MP0d3qKRng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728064797; c=relaxed/simple;
	bh=inuFU3NXMCe9t8sJPID56GbyaIR3FjwYuD3KDJW0AyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HM8CXe/J5BIITyTXxAw8bglveNYRArWFDTOA5bR9pSYGIBlOoKfzcxAaQJVBkJBF18jUnWpSMNiJfhYV7fvcq4hxeF2BZiDMmyZ9XNVvaiKg0TyIUJIAkHfd990jIK2QXEjYjvQlTEk3NVnqZQiF+FwF8SYCCpqzpepUcDv2Om8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=T40dcfB8; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5389917ef34so2881135e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 10:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728064793; x=1728669593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIc2Q/g7SzIUf5LcQlTpJjF6kt6YPBe5J0bTkqMkNrs=;
        b=T40dcfB8p+1OQXYcJBLq1LnKRinIm1xPRCxHOd0bvQ7vuKOKp17ZYqUPjAc41efDNQ
         WONMm4DGQoVnjumLkuiZAEMumFCIm/xIKs1mP6O/YABc3hv1XSeOovpPJFx3x6HqxcfC
         ySS1Mus6NsHzR4DU/2DBfScjNNj6VxZFs6fvyqo0E3NO3KlQFUzMNiTBcVgHbY+Zr5oL
         injtWkYhdQINmHsAHPNAd7jeOstdpe+dUHZHmgQm6OG0Db8vJ77rk2IKQ0eKzwUXeSja
         PBofJzYmhcTe8FkFW3JVuMQHJkd+WpM4eJg6JfNatf56gQX1K5prly10DYZKr+l+EjUX
         Fg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728064793; x=1728669593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZIc2Q/g7SzIUf5LcQlTpJjF6kt6YPBe5J0bTkqMkNrs=;
        b=RiNyEG9iTOo5PV5VEcHAFKjez7CffipkIczWE/Bp204PzKp58CzGlwW27iLExRIkW3
         2IVOIUmbW4blF7cz50X5sX6lgrjQOzrdmstqLYBJDMy0joxmwEMDgX/sjZKA2wOJhCNY
         0sZDqwAL+N9Ae5XWXudryEtu5a53WrSvwBoCQoFryFkCvdh6A2lb84FlTy+dbc86JsC+
         e991DJwItMrtLoDkesuB4sQ0T9n/UT1vwUAR4rkFIeBcvbx1ZTvSNiX+a4o9djFdArgZ
         tHeWrsXpmTmR8kqamMwsq60Iq3NcXIAduqKS9cKAHgtaw68N+I2Lr36t0IGDLGO7tuCs
         /Y5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqg+A6dxCy0NOR76NyZebRBdbaCCZqJNf3EX+2Eb2ZcrIlppcbvRs66ponJ69ogyF9e6XzZtKF4HmWM1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkIVXh+YpLw01IE/1apPf2SxLMCYuh+TtZJdfcl2kqLMQfEVuO
	Izun50V2xReK8vCGC7/oqUqarRq75ARRhUfaqfqMLtaB81EIlF3GBROU+YNKsgp2vYiBO70G77e
	MvPOelZyj7W/CuYmswsU0FTjuzZOfjTWLzjyRKA==
X-Google-Smtp-Source: AGHT+IHHz8Cr6VTmIusVTwt1IY2wWXjjxXJuyGY5S7lxceFUPPBU36GfG5fFHG9WIFrL0iFdylF/a642abnf9QcKd5c=
X-Received: by 2002:a05:6512:b9c:b0:530:aeea:27e1 with SMTP id
 2adb3069b0e04-539ab9e6cfcmr2638044e87.50.1728064792965; Fri, 04 Oct 2024
 10:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004125227.46514-1-brgl@bgdev.pl> <rog6wbda7rdk6rebjyprnofgz4twzpg6kt4pnmeap4m4hga532@3ffxora5yutf>
In-Reply-To: <rog6wbda7rdk6rebjyprnofgz4twzpg6kt4pnmeap4m4hga532@3ffxora5yutf>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 4 Oct 2024 19:59:41 +0200
Message-ID: <CAMRc=MekMuV6ULeX_x8mgQiL=XoHuH3PrJLihqucWqowN-YRLQ@mail.gmail.com>
Subject: Re: [PATCH] PCI/pwrctl: pwrseq: abandon probe on pre-pwrseq device-trees
To: Bjorn Andersson <andersson@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Johan Hovold <johan@kernel.org>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 7:31=E2=80=AFPM Bjorn Andersson <andersson@kernel.or=
g> wrote:
>
> >
> > +     /*
> > +      * Old device trees for some platforms already define wifi nodes =
for
> > +      * the WCN family of chips since before power sequencing was adde=
d
> > +      * upstream.
> > +      *
> > +      * These nodes don't consume the regulator outputs from the PMU a=
nd
> > +      * if we allow this driver to bind to one of such "incomplete" no=
des,
> > +      * we'll see a kernel log error about the indefinite probe deferr=
al.
> > +      *
> > +      * Let's check the existence of the regulator supply that exists =
on all
> > +      * WCN models before moving forward.
> > +      *
> > +      * NOTE: If this driver is ever used to support a device other th=
an
> > +      * a WCN chip, the following lines should become conditional and =
depend
> > +      * on the compatible string.
>
> What do you mean "is ever used ... other than WCN chip"?
>

This driver was released as part of v6.11 and so far (until v6.12) is
only used to support the WCN chips. That's not to say that it cannot
be extended to support more hardware. I don't know how to put it in
simpler words.

> This driver and the power sequence framework was presented as a
> completely generic solution to solve all kinds of PCI power sequence
> problems - upon which the WCN case was built.
>

I never presented anything as "completely generic". You demanded that
I make it into a miraculous catch-all solution. I argued that there's
no such thing and this kind of attitude is precisely why it's so hard
to get anything done in the kernel. I made it *generic enough* and we
can cross any bridge requiring new features when we get to it. This is
why we have no stable APIs in the kernel! And why every long-lived
user-space library is at major API version 2 or 3. You can never
possibly get *everything* right.

Also: there's a big difference between the framework and this driver.
A driver is just a consumer of the larger framework. We could possibly
make it WCN-specific and create a new one for QPS615 (even if it was
to use pwrseq as well) instead of cramming a solution for every
possible corner case into a single compilation unit.

> In fact, if I read this correctly, the second user of the power sequence
> implementation (the QPS615, proposed in [1]), would break if this check
> is added.
>

Is it queued for v6.13 yet? If not, then we make no guarantees. A
regression is when something upstream stops working, not when
yet-unmerged patches from the list do. Have you really never had to
modify existing code to accommodate new one?

This is a fix that needs to go into v6.12 and be backported to v6.11.
Hence a simple patch. For v6.13 we can easily extend the match data to
become a structure indicating whether we should do the check or not.
That's a really simple change too. But it would grow the fix
needlessly.

> Add to this that your colleagues are pushing people to implement simple
> power supplies for M.2-connected devices into this framework - which I
> can only assume would trip on this as well (the one supply pin in a M.2.
> connector isn't named "vddaon").
>
> [1] https://lore.kernel.org/all/20240803-qps615-v2-3-9560b7c71369@quicinc=
.com/
>

I'm not sure what exactly you're referring to here.

Bart

