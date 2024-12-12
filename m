Return-Path: <linux-kernel+bounces-442482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6D99EDD55
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 03:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B71BD16272C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 02:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B80513AD11;
	Thu, 12 Dec 2024 02:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oekh452w"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF7613633F;
	Thu, 12 Dec 2024 02:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733969239; cv=none; b=XbVw4aecpEYya/YZIU/Gf8lwxnNnntN8FE13s6V+Ayfr1DGMpaL+t2+FjncslieoWS8D1+/FUE0laJbDuYEfivs77EJ815XK+wixqVbhoagelC7xB7mtTnNfMnffMKZAmmEYAsx4vtqoGS+ndZqJofjpvslT4p7afNXDBdNBTmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733969239; c=relaxed/simple;
	bh=zsEQWcKkwE2tUR4EtqQ/7dt4QrY1pJqjE2F4WHaD4wk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LKNJPzTkks42YcbNSc4VZUGPndF+GfrqBkKRaCw8IZ3fL0kWbXoH0cr6bWyx/QW77WbbenxnmxjeSIT2GtEDRlas51P89jh0kZZVpTGUWGkqc1a1JOHb2eQsZHeddJ/aOmCiE3HIBpCpn0qpa3qAYn2x74c3Px+RMPs0a9GnGks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oekh452w; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a78b39034dso439585ab.3;
        Wed, 11 Dec 2024 18:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733969237; x=1734574037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsEQWcKkwE2tUR4EtqQ/7dt4QrY1pJqjE2F4WHaD4wk=;
        b=Oekh452wHlf4gyzQ46KavuIyNs/oSHYdyOHWh3hx6mg3qap3z3PQamUSxC7xKFLhvB
         trRLdZQVlmRBQ7WhyMlOfVoja26Nt8P/grOwqaRLEjG01nkDBmlGFf2X97EuU1h0r43c
         nurXWKiruJyKmtV3QzsplSF0dX4vEzQEyjJLBLrJe1b8hebjHnOrhoEt6CeQd4AaWyjX
         +sElrm60yB6keVwep+E/OaNbeJqE3TriyTa/Qzup+AjI8Mo2d+tdZq4CEdjhqhOeJaaM
         /FZvjOXDX/y1OB7YTn3TIZ2sd+flUHWb/PkfDvISuxWIn93CJyGIT/G70Uq4/UcJ+/ys
         Q1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733969237; x=1734574037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zsEQWcKkwE2tUR4EtqQ/7dt4QrY1pJqjE2F4WHaD4wk=;
        b=ls8m6S6VE3aEVbvWEDxTzGK1wfRisPmKvTQGu0j/cqVT5vS8SC80k+WJtKTt/77hKt
         0hL3XMn18QSLunY/DE9Cj6XScSLP9Imx9huSB5wYiveQiDT8f4+COvM3ZYfRnooDbmGH
         9PN3GAqFmk3XYMn2//Ba0w6dqg2IXm0HB1joNzui6TP7sFdzqs2An/HPi+DxnHM9E/He
         wHFZrw+M9RCEReX6M8l0YgkcT1YiSinky5C4bu18GVrd1alJl4paCKYJhuviIDWymr4u
         m1lwwdNn0WnFwzoV8B1dknbtLcuc5bZzxAhiK79bAIVFR0OR3EyaQaLXEHMTZ7fpimhb
         M03Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvXlySdUmShH4dR7IsO1ECZrxlPbKxUk4c4xuGH8nWDza0dtiNmS13gfsO3YUbLkFnCsDGUH9Hk1+sT+o=@vger.kernel.org, AJvYcCXYzQSunLfTvyuqhX2e3pw2zbr7ojKO5dw1shyz9NplCG1wXZ0aUC8BE+a7vckWUSHTDoxQqoJHp6U2NHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwciWT1Rd+PcTtlQvuqtUmsM78vO9SJBQh+orfqFzC/N5VEUg2i
	jFPGDSsPhv1DOHc7/U5cFF8ILxAjAnn4/Blb5Wm6Yeudsx6/W4sX4LIWaeElfQQ4Edmqzt9L5So
	O/sztZpy+oQxTMnlp8rsl9CydNwk=
X-Gm-Gg: ASbGncsbYMAG6uD200ynCiCqAa7CqjnhBCvUuZnDUG36Xpznq8z4ANM+LXJlsTGP0Sc
	vM+okV/BrL56BHHZAqOP8ihym9SJjw52MLh+TqA==
X-Google-Smtp-Source: AGHT+IFgbF3rpxFbC9uUWYHJ8NsiDEgvcpbD8m2ahheY6thhWrFNrML3gGOs0Uohbe0DWv40CeetB1K5Pc+PD5GSQGg=
X-Received: by 2002:a05:6e02:1b05:b0:3a7:fe47:6228 with SMTP id
 e9e14a558f8ab-3ac483ff34emr18454135ab.6.1733969237518; Wed, 11 Dec 2024
 18:07:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211030849.1834450-1-shengjiu.wang@nxp.com>
 <20241211030849.1834450-5-shengjiu.wang@nxp.com> <dc52c945-b292-4cd8-97ae-369a45f5a4ad@sirena.org.uk>
In-Reply-To: <dc52c945-b292-4cd8-97ae-369a45f5a4ad@sirena.org.uk>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 12 Dec 2024 10:07:04 +0800
Message-ID: <CAA+D8ANG6enRKp7msjBs3Hxn8QozjT2tEvAmHDZjO7xtQYB4Jw@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] ASoC: fsl_asrc_m2m: Add memory to memory function
To: Mark Brown <broonie@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, vkoul@kernel.org, perex@perex.cz, tiwai@suse.com, 
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 11:28=E2=80=AFPM Mark Brown <broonie@kernel.org> wr=
ote:
>
> On Wed, Dec 11, 2024 at 11:08:47AM +0800, Shengjiu Wang wrote:
> > Implement the ASRC memory to memory function using
> > the compress framework, user can use this function with
> > compress ioctl interface.
> >
> > This feature can be shared by ASRC and EASRC drivers
>
> This breaks an imx_v6_v7_defconfig build:
>
> arm-linux-gnueabihf-ld: sound/soc/fsl/fsl_asrc_m2m.o: in function `fsl_as=
rc_m2m_
> init':
> fsl_asrc_m2m.c:(.text+0x7ac): undefined reference to `snd_compress_new'
>
> Looks like we're missing some select statements.

Thanks for noticing this issue.
Sorry about that, I will fix it.

Best regards
Shengjiu Wang

