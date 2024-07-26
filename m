Return-Path: <linux-kernel+bounces-263744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F74293DA0C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F42121F24854
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5961149DFC;
	Fri, 26 Jul 2024 20:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkv7vhP8"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A3E748A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 20:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722027287; cv=none; b=bJtp6z/8874XsLlwDYqeliaKUyG7T6kreCubviWdaTGKBPeyBAaMUX/+vEPYVzKDCJZN8wtuuIViJEy7p27ekODXltKNy2SLyVM6S8jJcLwT4B7GMz2vX1suWWxe8SvfHBIf4/dAppn3zuFNcAx+0FwbMv1jkm01UjFT7+knYEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722027287; c=relaxed/simple;
	bh=QGksjBrXmpCF+sSWYkAxCa6a9sYQa74LfO9VC6liCDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyubkBh7X6qzgmo3aB9Lm2KM055u1rKItBcYqMdseGucYagxhA1MZD21xJ6eYDE/pVpI32r5w+QylxYGmOH7XILpxMqUVOTFod4AUBZNvBmJN6igD0A2o9uk+OhaXurHKLGpjix88A2IDkLMWjmoP4pc/K+uiZK3qMd/FWXF40Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkv7vhP8; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52efc60a6e6so2538043e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722027283; x=1722632083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/umb5p8uceFZojoo6zVCGf/yT2zapO6zsUwGbxfWhv0=;
        b=kkv7vhP8js0Mt4TiekbE0mo6EJU2K2LYqFP/PilGgcbDemPT2t1AURzAq2VjTOL0Yy
         F0VX/SpA2CfCwA3FxqwxST5bD37vMiE31FWCd7ICwi9EZKdDvYvKWafuvz0fhI+Pi0oF
         0GffKKjRDQnEGMSmg++FIr9wGm4YaAboxRAjpgRQyELqIANnnuSVsjiTP41MjL4eIX58
         Dt74O2QKEU7VTTUpnPzU6jtpih3bDxYUJGhncieSIBVpjJFrSoxKBHHKBlgckwh/H5ZZ
         caK7xVykK5mq4MpOR8L8aqMso009ZRswcNRSqZ3CLE/spFr/a8U2AojV73a2joh8i869
         Kt6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722027283; x=1722632083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/umb5p8uceFZojoo6zVCGf/yT2zapO6zsUwGbxfWhv0=;
        b=GOrxHu9cl/2JWMggG7QzLlV5MjyKYSb9q0cvwJU+omANr4XJD+dCTaIBffE2kmVL4n
         prEv4drhMysItTjfh/NSIVElfJVIKqtPzYOw3uObHFUNoiAphm0QR91kjA/TL0BFkRoy
         tP2Hh68qx5PTfLmSCrlFYCWwCqXRvuqyU0+8Yv2h7je2eBxtddkED0VoX2CbusRkDxyW
         dH/9YSNtVqbCnmtiaYHJbzGRsA8dSBrGRzt5CPPnSueDnAl5EPgK6Kl7KycAPtqNxUj9
         WMH02oML8DGPbogVzOFETsQn1hBgM+3tidg0XqODwUtWKDhvdUhclAVyJ3dMj574NC1w
         ZfGA==
X-Forwarded-Encrypted: i=1; AJvYcCVO+m+UfU2rraWP1PZNtqo2gLxiuT5IW2uPbCNb2uBkvzEMw7Tm2VTAihlJfWeBJMokbRCPB6y0a7fmrHJJFOKKXpS5cbajEgmyc2on
X-Gm-Message-State: AOJu0YwmGv9AHcCSvs1wa9hTAC73MrPZfwmgFiL5i6c2DKp5f/Qjfy+B
	s8bGXphkWCXkTraNARRAnGGD0tAlf3eCGfy6/OcZcpOQK1o4163tP1/hpFE3aEsvHL8UiKvsIAg
	Rb7EtIUmPjCNxFn3bPIBJWGDuu50=
X-Google-Smtp-Source: AGHT+IG/Eqo7sYQDXqVhmKW8MeQHY0AIxM8Ope/iq/CuCmXxPZadGXK4CldxL6ak4VGYyt6m60485bPHvsG1D2jswVE=
X-Received: by 2002:a05:6512:ea4:b0:52e:9fd3:f0ca with SMTP id
 2adb3069b0e04-5309b287143mr563700e87.33.1722027283138; Fri, 26 Jul 2024
 13:54:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726195044.18004-1-sedat.dilek@gmail.com> <CAHk-=wgEhoxDM7T+Ko-NgAC5X8etF0aL3fGsUXFeqnwggNXgCA@mail.gmail.com>
In-Reply-To: <CAHk-=wgEhoxDM7T+Ko-NgAC5X8etF0aL3fGsUXFeqnwggNXgCA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Fri, 26 Jul 2024 22:54:06 +0200
Message-ID: <CA+icZUWUdq-xR9nOB_c_8=pfwn8J062hiurFXcrF7zvmaNg8PA@mail.gmail.com>
Subject: Re: [v2] arm64: Rename to KERNEL_IMAGE_COMPRESSED_INSTALL kconfig for
 compressed kernel image
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 10:42=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 26 Jul 2024 at 12:51, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > The COMPRESSED_INSTALL does not sound very meaningful.
>
> Why do you care? The question looks like this:
>
>    Install compressed image by default (COMPRESSED_INSTALL) [N/y/?] (NEW)
>
> which actually fits on a line and makes perfect sense.
>
> Your patch seems to only make things worse for no real gain.
>

Yes, the new kconfig is longer - not ideal.

And when you check a diff of two of your ARM64 .config?
What says COMPRESSED_INSTALL to other than the author w/o context :-)?

You are right, why should I care - I have no ARM54 hardware.

-Sedat.



-Sedat-

