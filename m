Return-Path: <linux-kernel+bounces-420682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0245B9D821D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93ED9162AFD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D9819047A;
	Mon, 25 Nov 2024 09:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L/QApVvC"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A915118C92F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732526527; cv=none; b=ZV/Gr3ievdFDUV9MbcdGdp70quRhNFiIjiM/bocChvKN4ZllZgrzk0I2E+VWoGYhnlNLckQSStarTjaZx67K+zgAwTxsGToeyxCfPE1V7fCqHcw04wDd3C1rIfVq+0TvpttzUPJI13acFrcl4r/tdWG9f9fOnFILq8sT/CvGPOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732526527; c=relaxed/simple;
	bh=FCYlpekwLX29y1babPtkl5hhwfzqAWLF9A3oe2+5id0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NlZlykeWxF14QFBIRpqoePFimmE0i6gNBEhuANHwuMGF10v7Bxb2VAUVktxfg0+GA50YmxSzWJQNtuzLk0tDwffNJXVEYP9M4atr8GWAsCu9IDrRXKdWvNR5S9woIEipYi+rH4HUyONY6lnSGEsJ4kGNHX/Sh42Xc/kkLR0n9Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L/QApVvC; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5cfc264b8b6so8224a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 01:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732526524; x=1733131324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCYlpekwLX29y1babPtkl5hhwfzqAWLF9A3oe2+5id0=;
        b=L/QApVvCl2TEfZGYYEfTC3A1hQNfZH2vjBTq86eD/zjHUJ54iRzh51xj3aYuIKBuUv
         YHUejdIuGeK4KTPZ4p4MVGpV9KX1wfCemqd0ciGNreYL8at1hJVYiDvamxYmz96qz0GL
         sDXHtdhWoEK/iGnani5i3vzGP+qpSQVXE6HxYedijsvrLlstYYhLxPxNPvUlaFkPfqmt
         zEhRnIwbUXq43jiXU2o+hdZBEAueRG1pjOSQoLf3R5bNjJVU4MGLhUzse2juThQKgsiC
         mkXMThFP1UqRsiIJmzr8IvZFvEYXtfvSqLgPWNGY/dclfQbUKAf/SBjZlglyKAYLSE4c
         wdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732526524; x=1733131324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCYlpekwLX29y1babPtkl5hhwfzqAWLF9A3oe2+5id0=;
        b=FxTm8TPad8YNA99q66u8/YSu14zTdDUlR/dw8yvxl6RMA+MIyUv0b1cJT8N9hJvbi8
         TwOLthxb+wJi7YNnlZadtOwDvQOtTIJ6qkkWz5XTeoTeXMv+KKuEz8KIeJG9LKVNnvsg
         Fxubtzoa7ASV8HF/DS1F2WC7IUO3E7vpUzqotKOXTdHHr4LYZvr3M72Z6Ni/IpwyRyKw
         aSY3kK7fV8pbfyY0KPwWuqIyH7SrxIpyIZ7V4xlITGNN7qXM5OIVfk11WR+1bsQGbgQv
         Msc+vBFb8VYfJw8FYI4ClDTV8PqPiKTngbbKbos1jMQVeFBnWtcG0pcpIwGdPrAMJIug
         F1MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl5nSc8rngFfp7Rwa3CYQqBI1d4GrGhkOy+ONbnvpfZMk+Q5KR7ugFh504hTUYBVdMS5wvMSCNVpaZsL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGlk8lx4wpdxyxJVW98He4ZA+aVLQrrwxXJEe6fNS71uqVxywK
	w+/qhqQPZ48m3+xaHWMwGhLAajyt6nuHk4/zorZyuvkC7iLwJ8CVkLLnMoNzi1oIoyz22japQLY
	YG/OfCBDuA+l7V+PvowhONZTYWQSQsZVG/0zf
X-Gm-Gg: ASbGncuPBZruyXxwmK+t2daeq7gMfXnJ6eFdmYj1HT34e9rzToL9VjlVUwzttWVB7gB
	B0Eml6kKcZOxGnT6q/AM2Z++XoMkuF1J6
X-Google-Smtp-Source: AGHT+IEyjVc+w4xYMWK45ReBVdh5zSSYk8/svaq/gH5CeUai6F225gz3gVyn1zbIlnkBPYmtw02u4vkN3IF6RImReBs=
X-Received: by 2002:a05:6402:1ca2:b0:5d0:3807:bcbd with SMTP id
 4fb4d7f45d1cf-5d03807bf0amr89021a12.6.1732526523672; Mon, 25 Nov 2024
 01:22:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121204220.2378181-20-samitolvanen@google.com> <CA+icZUX-gf8624z8u+h-W8KeddCruYDng-4vTggNGwC61NzfNA@mail.gmail.com>
In-Reply-To: <CA+icZUX-gf8624z8u+h-W8KeddCruYDng-4vTggNGwC61NzfNA@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Mon, 25 Nov 2024 11:21:26 +0200
Message-ID: <CABCJKufb7SLY3j7EqRwFkNbrp22moJ51rDJm8madpUQdOhV9kQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/18] Implement DWARF modversions
To: sedat.dilek@gmail.com
Cc: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@samsung.com>, Neal Gompa <neal@gompa.dev>, 
	Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, Miroslav Benes <mbenes@suse.cz>, 
	Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sedat,

On Fri, Nov 22, 2024 at 3:51=E2=80=AFAM Sedat Dilek <sedat.dilek@gmail.com>=
 wrote:
>
> Thanks for the update, Sami.
>
> What are your plans to get this upstream?

Once everything has been reviewed, I'm suspect it would be up to
Masahiro to decide if he wants to pick this up.

> Is Linux 6.13 the new development base?
>
> Personally, I would like to see a Linux v6.12 LTS version offered.

This version is based on linux-kbuild/for-next, which at the time was
based on 6.12-rc6, I think. It should apply cleanly to 6.12.

> LTO is not supported - might be worth mentioning this in the
> documentation patch with some explanations?

Sure, it's probably worthwhile to add a note.

Sami

