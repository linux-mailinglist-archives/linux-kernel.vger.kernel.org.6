Return-Path: <linux-kernel+bounces-181969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 255D78C8469
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 12:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E2E2854CD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 10:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177612C1B6;
	Fri, 17 May 2024 10:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HUTsqVsm"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5722BD0D
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 10:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715940096; cv=none; b=jesDr2qwvRk0iMXWVINU6ZXe010tFKFWyDzYOdezOMkx7pCLU9kb1HFh8ADRx8ygJ2peF8BvGNwLqeb2Tr9vRUzm82Ixzanwy0zVWGnT8lnatBFNRrneZR79R40zlqgg9G7KjmcxuH2OH3KGFWG8VK16J7CRfv0pr4HYS3+axKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715940096; c=relaxed/simple;
	bh=PWrHcj6HzEkQvCE4ut2qDtva3893i1h4KvwxXKEnsyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gdKbkuI+PC07FEzP7IeVIkMphHSwpqbVP2iaHlJ9ZIR3kYlmfoK4HALffylgbGomrzbkriM/NrjQE4DBDFcJchX+wolLcy3w0DZMt2i+cqYlc8GsS9JiNtYzHGxOO13KPVnaXqRB4d60L+H9pgAomqQ1TAIUUWaTvsxxGsQ7Z6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HUTsqVsm; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-de6074a464aso9097189276.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 03:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715940094; x=1716544894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWrHcj6HzEkQvCE4ut2qDtva3893i1h4KvwxXKEnsyQ=;
        b=HUTsqVsmufgkyquQRPqNWGNbxm6Mt1JXEb46HVd1MZhmJuPBSSVzo7L5VQeIf4fyq4
         TcDnmPzrlxlTmc3D7RzQbUf3SP6sqOjRcfcXL1C4nXxUDQjGEOxyo3jmsVdhpHhvFtLN
         VvttUTLLhjy/8Fep3nLqL2m9RioUx/HsyOLiyun000b6lwNf098I+jJWrG7bTMYKl1aM
         NnESZqxVKtw/xhF8PKNdNoDRGJIKovHVDeVtNyX7W4bL3UMDwKWjRxwmBqbcOLIV6Kbw
         WKypVpMIhd2P4k2rcEMp94wd+X3xLH4JMZmgVDYdtTHogRkCy4Riyhl0v3FpsEiJLLXt
         7mOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715940094; x=1716544894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWrHcj6HzEkQvCE4ut2qDtva3893i1h4KvwxXKEnsyQ=;
        b=BMWj1b/phxs+U2gdHPUrUJ9JRzyqnEdFL/3fo+K7L9x8FGYCCSBnMceqDDeut5LGHt
         0fDj1zhCv9nQICR7kuxSGsmSDglxCAs8FkdMi0row4WvOsUHTKtFdyMY7PVwWxx5I67w
         cIXHu/5Hry6ayPX96eK0rD0ielGJggTK+YEB+47llk99b2ccet5FnodtAtHEjFtwkfdV
         txGixtNPjiIpBXVVr9ZOGefvHJrf47YzgwEa+ZT1ThUtvY9xcGiTwTROQRPX2LM85ZsI
         SCul5o8Z1v5a2KiAJzIL4sK1KtOKyEJuKOC4ixts89l8c92DnP0OAJUQ4rkuJuPnRzQu
         acDw==
X-Forwarded-Encrypted: i=1; AJvYcCWKmvolVPaVeGJ+9ZGcU1ZV+oybzecJ4ITwpQ0hadnp+b2qen/cRIxONYTDuQAngVDy+Yd+UDP9JksFzXn/yJgKzWEbXoRKAQH/DoiO
X-Gm-Message-State: AOJu0YznSRyLhnSBsEZtXImZcL6rMHvzRa/zvxq8jO9xz4mUSbmIwD18
	6fbpPZgGIrPJzbYl2ODA18vsu4wG2FeblnzDxPZJNQTiYrEpEW1GyoxoBGPbQizboetIMEps+2d
	XGcKNrhSwAwkCVsv3dBqieQa8IGbZ3NC7qjaLLA==
X-Google-Smtp-Source: AGHT+IFWtvkjHx1cRApkWmP+4gW7HWytdCwPBOFtAteNB80YOe4v7R7d8sV+ukCkw3UrBiJsw320m7Xbh0v/iFu2xWI=
X-Received: by 2002:a25:844b:0:b0:de6:17eb:3cb5 with SMTP id
 3f1490d57ef6-dee4f1b77c1mr20119979276.10.1715940093906; Fri, 17 May 2024
 03:01:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508101703.830066-1-andriy.shevchenko@linux.intel.com>
 <ZkYQHnF76WLIf8-r@smile.fi.intel.com> <CAMRc=MePRxKumCTQ+2W3Q=UgSetAkAROGRWZApdTcn3dRj79WA@mail.gmail.com>
In-Reply-To: <CAMRc=MePRxKumCTQ+2W3Q=UgSetAkAROGRWZApdTcn3dRj79WA@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 17 May 2024 12:01:21 +0200
Message-ID: <CACRpkdbLQKKp1z+1CUqxGFbLETPw0AY_+d+hNxe3R6Voc7pOWg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: Remove legacy API documentation
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Vegard Nossum <vegard.nossum@oracle.com>, Kent Gibson <warthog618@gmail.com>, 
	Hu Haowen <2023002089@link.tyut.edu.cn>, linux-gpio@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 11:47=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
> On Thu, 16 May 2024 15:54:38 +0200, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> said:
> > On Wed, May 08, 2024 at 01:17:01PM +0300, Andy Shevchenko wrote:
> >> In order to discourage people to use old and legacy GPIO APIs
> >> remove the respective documentation completely. It also helps
> >> further cleanups of the legacy GPIO API leftovers, which is
> >> ongoing task.
> >
> > Bart, Linus, Kent, what do you think about this?
> >
> > If there is a positive consensus, I would even dare to go for v6.10-rc2
> > with it.
> >
>
> I don't have a problem with this change but I will not send it before the
> v6.11 merge window. Why would I? I'll have it go the normal route, it's n=
ot
> a fix.

That's reasonable, then people get some time to think about it
and protest if they like.

I am in favor of the change, better delete the docs too early than
too late, we must do what we can to stop the old API from gaining
brainshare.

Yours,
Linus Walleij

