Return-Path: <linux-kernel+bounces-514498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F39A357BD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E12D7A3A45
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44FE20ADFB;
	Fri, 14 Feb 2025 07:19:01 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8980315854F;
	Fri, 14 Feb 2025 07:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739517541; cv=none; b=F5OzNLEcQLEb2Z2jOJ6/eAw5K9r+14FuuWq4ZL2F6YL5HS5pXWTSWQc212Lk1nGoCDtGeEduFdTYL9g0xAH6GwDrMjM61VCePdHIAbwO5dKw5nRaatnm48Sa5KnXh+XEGqH2NPkjZRLgU9485Gaf1yE5ZLs7ccR+cdZwrbT5yrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739517541; c=relaxed/simple;
	bh=qW5K0tff0Kwu/5nGT44PYcGWfbsMK2Z152X5t4YLm+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qtw2RaRDHiv/z4LOY6Pu8gJRFgElfiFrpbU+bteBHsNnDGv/Fjd0CsElTJ5dqbSf6VjNyjlgZr9+7si1lgk8w3hZ5Mxt9X/0yoAyf6J9BPQfKkJ5II+s2FmlL1mvPplvgYWF6SNoCfX5WRfzSSl6RMMTHu6oVmxepFvQQbN/OIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab7d58aa674so258755666b.0;
        Thu, 13 Feb 2025 23:18:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739517538; x=1740122338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBZbTGwwpOGkfmC2S2B/ns3VS+A0GE9103R09GlmDb0=;
        b=YIKBfwDwr+taVJ43TBQIxjziYwyI2sPm75wIdb9KGfFNUZ9zmfdBHDU7zSWXwFzgy1
         0BO/lwjoS3XH2Su/Ztaq3SznH8tKI1L16r7o7bFT8xxZD3a9rHCMjXiCkrVGnTsL3TpX
         CvXUAohBPwhWGDaNnQQtNtWsA1+lkcQ394YqnksjhGpXZVV9R8bivE+H2geqYVKuXVsG
         jvpiC6gu2Z8BuKfEvJ1ZsPZVALECKnsIKMi0d0q5KsC1SbUr+7cGx2l0VIm95DicRR4V
         16d1JJAK2wa+f7cVidfd+77ToQp+7Kd5nzGQVjyaFjWdWNpSgQ+O6bBNsuxdiM13GcoT
         NTSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVECdH6viG2eOopkKyj1pn9/E9vwOLODSh7PP+F/V8SyZi5VK5NSLxyoxTrz+kjm9TxpKKCMdq++MSdQGAvOaA=@vger.kernel.org, AJvYcCVMhVn9qhX3t6tEFL+ILGDanrmMXNjdphsLbPUwNqupDdFwVrpasD3Z3mLPCvKGhrfdWLC8e0Jmd8cRWD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOYXS4JTMtBLViMtNCs9OYksBPK/9toxtNOK4syDP1ZqPIW/bM
	Iuqz+AboSyk2anxbFoV7TkqgTRT+y14RgU+bQNeUiAjJiE9oW4+BV3XBqfQyKhY=
X-Gm-Gg: ASbGncttWQd77XUPAdLTl0XskZqvonvsLDNfb+DMwlU0bJp8a8lcfgzf03SY1H45nTc
	xvNnOfLEwPFVI1goMhtcNr2/rjAdu3YdwLPKd5XMjYwmzy7l8mZUHMHCTg4vcbxcJNbAe+oVQNz
	ymtRXRhJofxFqy6yUs3DPFNIb7KPD6VJ983i0tHDEOATv5nXP8UpSZsBu9vltDJkvUwp3ImiDtz
	YoaoDhWwbX8MHCmWO7WTIs0rOgbSWeHjV/+Z+ZhnyAPqsUzXw6gmf2FQ2LCxqYFp7OShIKeQlpq
	rD79Pl4sZBojV/INF/dYCOMGE1vEJbb5Piel/wLACFtZ7Q==
X-Google-Smtp-Source: AGHT+IFc73WHmq28oHdSqWWpoEF13ZYLfVxQJx4DtTn+o/2WXc3mBD6E31ywpog2tbhTmsfecIac8A==
X-Received: by 2002:a17:907:1c9e:b0:ab7:a274:d3df with SMTP id a640c23a62f3a-ab7f33c13a7mr1007825466b.20.1739517537446;
        Thu, 13 Feb 2025 23:18:57 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53376ac6sm282180966b.111.2025.02.13.23.18.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 23:18:57 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab7c07e8b9bso300332266b.1;
        Thu, 13 Feb 2025 23:18:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU85KTbgD854zvHeLJvnuFozP0otDHiX6Md58U6MyVXaOWI2ZWofnsxYOGP0534hvPFD3gKkSSPFa2HACMj4+w=@vger.kernel.org, AJvYcCW2kTaxu1/1VdO4Wyyw17ZaDeGWBqv/aiPz5eT0m4rDN5ee8rZf1wFFMgNr3+35X43u4pvYJj8z1spwJlM=@vger.kernel.org
X-Received: by 2002:a17:907:c22:b0:ab7:c94f:af87 with SMTP id
 a640c23a62f3a-ab7f33c0897mr1109151066b.16.1739517094400; Thu, 13 Feb 2025
 23:11:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025013148-reversal-pessimism-1515@gregkh> <1bbdf8b7-a70b-4994-865e-7fcb8d53ebef@marcan.st>
 <20250207-prehistoric-married-dormouse-3e1aa7@lemur> <7742420.9J7NaK4W3v@skuld-framework>
 <d6cae188-28e5-409f-86ed-7ddf374fd354@sirena.org.uk>
In-Reply-To: <d6cae188-28e5-409f-86ed-7ddf374fd354@sirena.org.uk>
From: Neal Gompa <neal@gompa.dev>
Date: Fri, 14 Feb 2025 02:10:57 -0500
X-Gmail-Original-Message-ID: <CAEg-Je9BiTsTmaadVz7S0=Mj3PgKZSu4EnFixf+65bcbuu7+WA@mail.gmail.com>
X-Gm-Features: AWEUYZkDpaaCrtdHfh-vNgOgzQjACZNx_DnEFz8ZiojUP1KiLrlWIyNShKVYrqs
Message-ID: <CAEg-Je9BiTsTmaadVz7S0=Mj3PgKZSu4EnFixf+65bcbuu7+WA@mail.gmail.com>
Subject: Re: On community influencing (was Re: [PATCH v8 2/2] rust: add dma
 coherent allocator abstraction.)
To: Mark Brown <broonie@kernel.org>
Cc: Hector Martin <marcan@marcan.st>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@gmail.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Greg KH <gregkh@linuxfoundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	phasta@kernel.org, Christoph Hellwig <hch@lst.de>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, daniel.almeida@collabora.com, 
	aliceryhl@google.com, robin.murphy@arm.com, rust-for-linux@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>, 
	open list <linux-kernel@vger.kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	David Airlie <airlied@redhat.com>, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>, DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 12:28=E2=80=AFPM Mark Brown <broonie@kernel.org> wr=
ote:
>
> On Sun, Feb 09, 2025 at 03:25:26AM -0500, Neal Gompa wrote:
> > On Friday, February 7, 2025 1:16:11=E2=80=AFPM Eastern Standard Time Ko=
nstantin
> > Ryabitsev wrote:
>
> > > It is my goal to be able to give subsystems a way to use forges witho=
ut it
> > > impacting how they interact with upstream or handle tree-wide changes=
. That
> > > is, once I'm done moving things from one Benevolent Company to anothe=
r.
>
> > Honestly, this is probably not possible. If a subsystem moves to a forg=
e
> > workflow, it pretty much means tree-wide changes need to work partially=
 that
> > way too.
>
> We do actually have some people using forges already, for example the
> SOF people do a bunch of their review on github and then turn that into
> patch serieses which they send via the normal email route when they're
> happy with them.  I think tree wide stuff flows in via back merges or
> rebases, one of the benefits of delegation is that it's not my problem.
> This all works perfectly well from my side, as far as I know it's fine
> for the SOF people too.  It certainly doesn't seem insurmountable.

It might be working as long as a subsystem continues to allow
receiving patches via email. As soon as a subsystem decides to stop
doing that (which is absolutely their right given the model of
subsystem maintenance that the Linux project has), I think this will
break down very quickly.

I wonder which team will be the first one to do it. It's not a
question of if, but when.


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

