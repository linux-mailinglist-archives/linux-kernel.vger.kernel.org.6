Return-Path: <linux-kernel+bounces-525956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12153A3F7CE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71E7A18984BE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FDA20F09A;
	Fri, 21 Feb 2025 14:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgHhZWs8"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC83205514
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149807; cv=none; b=e12sKCZg3C3Vf6lfl59n8IzBW7wx6PfYGA/JeqdxkO1JNPbywN1seMCRJA6tfmZhrWv1/otGKXqJ1NsbwrahqNwPrwpN5pcT92K3TCPaeRWycH4fD+nagvcNGCyTQXp2SNGW95oOMJn1OFF3e0Zp/bPllXXymjQ0H4XhdBlz0Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149807; c=relaxed/simple;
	bh=VmO+XmL60S9Q7JkJf8wTvPR3ueb1NmOJ55nQM8bvcvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bF6lpfGpBODmxK1qEYzKyLgMiNt473v+IQYyauqnm5cfckzKLPtCXZ8L3hVXcgXMm8gD6N7xN2i4YecbeLcYS7GoCI0I/0deR2t6HZKRsOSxJSwo80xKL41yuLziv4VfwARHknVB1V6wv7WT7car5voRSVaobTVxX6V0bu7kZFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgHhZWs8; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2f2f5e91393so535658a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 06:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740149805; x=1740754605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPgbwZHEmXNjyA+TuIRw0Hx+4A8xMWXiEAgCqj5z3s0=;
        b=GgHhZWs8VPsZ2G7BhkzZ629fc4KGiAfzOGmrQQlynKvcP6jRtHYwbLkXLpP37P6YHd
         M+kQ9VRWkQq5ALlVPPsDuSt4L4uSt97ViKRByg8tF6Jf+KqH6tY7ZeYe/hUbxdjxB5Rz
         pchzQdBO/VKsmvqEvLMNpbw10C/XitqfZxbeJpaFFG0/yPAVDzfCUFqycg9hKRuROEsl
         1soB8rJWlAi3E3E6yNbCnlLdVbQpsRqs7WGxI1vAffW9SZGHgdkusJ8VWzRB1pNA7kyC
         edg/OKya58wK9a+No063Smsje0JMmyHsq91wgvkuDgCh+IBnaJi3kBJZPYRT7MNBfz0n
         PU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740149805; x=1740754605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EPgbwZHEmXNjyA+TuIRw0Hx+4A8xMWXiEAgCqj5z3s0=;
        b=OV2mJTOOHN7ufuz/RUcqw2cTVPiGyIppRWDiRjL1tJSTj1p8jBAmL5N2kJ1UCKd8Yw
         3wZSYJixlVsBq3xq3Lj8Yn+2WJToPrFh9R404XOjCS3RRAN/VrJhJ0aNXiqzNt3IYsak
         tpiuCEEWDWILL01FBjQ1LlyPwT2DyXMJ09x0Zv1NTpJ9OqqW9+dfx9zlQaeudafNEDXj
         mAZBpif0OeS64NNoXDTuND9vYtjzIcinc3QzEaMyil+O7IpCUHTcvkNfsVkdetPKSvOq
         HIvVasKtk2r3Ki81c+4O4fCZe2fd/skLQ4Jq08TayGF0J9yw0nMeAQi0u5do3AZSeGFe
         6YZg==
X-Forwarded-Encrypted: i=1; AJvYcCU+TkyasKlerGgIWo2ZYnw2Ot0+WJeSchO5oXJursJOyiUltYEoKyAJuKTzerbq5+pLcNnyRQ2xbvNWpfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBpTj7kEuT3wuH2hNo858GQNbqbdEJJkKDpa74yfDfknKMHQHE
	09WIbI4tL+gdO5/Qmrjq2JJLUQzTVrCtftHE1XPllLR18HXOm/2pJoMrOs8lAQtCNNLNVJdkd1c
	q3NwkQAKckGj5orm21T8AUw8r1Fs=
X-Gm-Gg: ASbGncu3c02L2Ui3V/T9k3jQ4idhxIivCBS5I4U3+eAMhyDsGzM7FnNgWPoSZfZqa1E
	Ds7uLTWm29VVayvuPlNVlKwaHW2OAQ+Fjm8kefl8jgmmPD2WhZI0h+G30+kEafQXuOGv9RXI5Ct
	KOYP2tpG8=
X-Google-Smtp-Source: AGHT+IEwilNWiw2rzaUZ7mvVLVzNUwRCp+viZaFmCC/tGTeKYvHtx5mKSQFFP2zhO3WfyIDe76qy54NQG0+KZunPd/4=
X-Received: by 2002:a17:90b:17c9:b0:2fc:1370:9c2f with SMTP id
 98e67ed59e1d1-2fce7af8ddcmr2239987a91.4.1740149804779; Fri, 21 Feb 2025
 06:56:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219184702.242924-1-siqueira@igalia.com> <20250219184702.242924-3-siqueira@igalia.com>
 <57df3cae-a70d-48c7-a623-fe8194f620cc@amd.com>
In-Reply-To: <57df3cae-a70d-48c7-a623-fe8194f620cc@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 Feb 2025 09:56:33 -0500
X-Gm-Features: AWEUYZnrfoIqcj5TyLN8B05XJ3z4t8QsUvng0Bqpd5gNos1PAihfNQfdPLPnbME
Message-ID: <CADnq5_P8=KRfUdk0C4tH=yvOPH2OEt1QexUCnQqBgkFWDnxSEA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mailmap: Add entry for Rodrigo Siqueira
To: Harry Wentland <harry.wentland@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>, Alex Deucher <alexander.deucher@amd.com>, 
	Leo Li <sunpeng.li@amd.com>, amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied the series.  Thanks!

Alex

On Wed, Feb 19, 2025 at 3:39=E2=80=AFPM Harry Wentland <harry.wentland@amd.=
com> wrote:
>
> On 2025-02-19 13:46, Rodrigo Siqueira wrote:
> > Map all of my previously used email addresses to my @igalia.com address=
.
> >
> > Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
>
> Acked-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  .mailmap | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/.mailmap b/.mailmap
> > index 5e829da09e7f..64413bbc286c 100644
> > --- a/.mailmap
> > +++ b/.mailmap
> > @@ -583,6 +583,8 @@ Richard Leitner <richard.leitner@linux.dev> <me@g0h=
l1n.net>
> >  Richard Leitner <richard.leitner@linux.dev> <richard.leitner@skidata.c=
om>
> >  Robert Foss <rfoss@kernel.org> <robert.foss@linaro.org>
> >  Rocky Liao <quic_rjliao@quicinc.com> <rjliao@codeaurora.org>
> > +Rodrigo Siqueira <siqueira@igalia.com> <rodrigosiqueiramelo@gmail.com>
> > +Rodrigo Siqueira <siqueira@igalia.com> <Rodrigo.Siqueira@amd.com>
> >  Roman Gushchin <roman.gushchin@linux.dev> <guro@fb.com>
> >  Roman Gushchin <roman.gushchin@linux.dev> <guroan@gmail.com>
> >  Roman Gushchin <roman.gushchin@linux.dev> <klamm@yandex-team.ru>
>

