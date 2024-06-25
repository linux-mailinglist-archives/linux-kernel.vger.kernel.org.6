Return-Path: <linux-kernel+bounces-228578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A78A9161D8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E553B1F22860
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0CF14901C;
	Tue, 25 Jun 2024 09:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LosvER7u"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596191494D7
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 09:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719306168; cv=none; b=d17WTkJBDsRvQ3aRQyiZ5iHrFBC14U9ulhAT4Skxb2IfK2m+4RibNiqvqs9ztGdqkiu8VAQ4X/gYqzsaw3c36DxvvHHXsKp9PD3VxKh+f45Zo6VUCZCP2VW1kwa8wWnsB60LsloL3Azf6uIBEKpwnASugm6Hw80JXtVjQ7IirF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719306168; c=relaxed/simple;
	bh=yT8QD2Zo4xkXl7H8UekyuXd6Q8sBG9tL1IiWvZvo0bI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d09MSeIkxMpevWtMcT5Sa9DQOtgfsbbHbsJLwEhKUXuM19JDC2Xd3Q3/CXIrNTWnklHJ4e2pkVfoU8C2TsiQmonEsEwrWVSVEENuJ8/J99Uo20gBScAviDe5JheA2XhQ9e5wis4sC0ZKbQoYFkdbRMCVjsPsPi5bxAtv7R65X7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LosvER7u; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-643423e914aso21161667b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 02:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719306165; x=1719910965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yT8QD2Zo4xkXl7H8UekyuXd6Q8sBG9tL1IiWvZvo0bI=;
        b=LosvER7uqM/jjzwWEjQR5+3mw4H9o4keTvYuFqSY9cl8up22TX/mumQ9DwNZWbpQGx
         rWjnGya812iqnv2HQ9COeKnYJaQi8UBGj1UeJe5QeQWO0batiGFqM74cRPWEu/qIq782
         isGpOGFNkKEf5kmVCtunPu+okJCKwpqCv2IrdUvQdsU9FYRiO0STFhK7QtOuhrvLvrdo
         JlwIph9+gwW7xMPM4qX+62BX3D1C5P/korJ4IrZCfu3AFFiBCAAoVepqMV5PGcVW0Zk4
         K6Co44/i7zd3W4XFlApSYlWrUpQBr7KJzjD1UlohMSQZxDWMLKr9yBsqhCeMYLhDvGQR
         klZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719306165; x=1719910965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yT8QD2Zo4xkXl7H8UekyuXd6Q8sBG9tL1IiWvZvo0bI=;
        b=d4Q3ytEvtuGcHlujZwqfG8+WO8Gj0IuDM4pnpWgl88vNQCv5j2Fy+RMBJGyAg1ywVn
         bG8DSvPbHC5OxlNa5e6aliKdJrH8hW68qc41/XUMtc2LkjIFQl3NG8lK8ubt9jIWZBQ1
         PtNHcXyLy6m/vNuHekhEDnf7Ci/YtIQya0Tn7qC8Bm95g0t+GcWoAFz2q0N84MziR2lp
         i4pVDjfsdlvbQgF7+jEdkEtxqVikV3WswlT7ZkQ6TSaWSXeuF068TXPdlZJxfL70BjGW
         bSM5LD21FAb4UlZzpxHgsIUhk5Q53H9ogMfpbibzvhPUs2swCYS2yXhm3WIKtxUQAaCv
         iTYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsssY8mHbcOTYM2Z4LQCEtr4s3rR1DKr0aGNV8CTWQpYvEfWgOYCwRl9xhpyiSGYdVF5EWlLCz4t433QBydafnqUm8E2xYGYLRKyRi
X-Gm-Message-State: AOJu0Ywca3kWHBgHUygzjERGbNLNG1oMbGhnZPOh3VKBBZV2bfP+pEAe
	amOX5SzhascGVBpRmbsaAITi/wR4ewfWvNCIZAuSh6abPcHTA5b6gSEx9IPgiWjIGXeqg3FCm7B
	W1eIEN5JASTksaovR07EVdXvT/BlpoulK7OE4Nw==
X-Google-Smtp-Source: AGHT+IGvK0khc1MSipVybrvG4s+cHxUW3NeLtGzA5nPqp5KK3n2hM5TcfKFwBXOaaFVt5XBuyzRxRVgY9lyq86OIz3o=
X-Received: by 2002:a05:690c:d8a:b0:627:972f:baba with SMTP id
 00721157ae682-643aae70b44mr90173987b3.31.1719306165115; Tue, 25 Jun 2024
 02:02:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624194518.37458-1-brgl@bgdev.pl> <CAA8EJppMPeYrPH+ssDMnf6UwHRdKQetpY3PotGvR-cc2vE68AQ@mail.gmail.com>
 <CAMRc=MeYy8MgBVbwmrR1Rd9oQMz1tUb+uL4eFJWTL7EOsRXxjg@mail.gmail.com>
 <CAA8EJpqz7wPSyn0ybDWKwBKkp+rWVPbTgjbKuG6VHWm24MCusA@mail.gmail.com>
 <CAMRc=McZ+hrXyNESmf4pFX9+uDnc4AKsuO9X8AJsVgCfQVLd9Q@mail.gmail.com>
 <CAA8EJpo2_3zSYEfyQ0VwSs9AkeXUpcVRGB+LaRAhA=_SWjrhtQ@mail.gmail.com>
 <CAMRc=McPZKYoxWYJ3U35CXYbBdwYBuemBwBC-qA5hhpqqTYBjg@mail.gmail.com>
 <CAA8EJpoEUyBmi5_Zb0m0TVYi1BAMuqNfdDL7rdsTK6rxjsGpVQ@mail.gmail.com> <CAMRc=MdAek=vLqMzdYb1yk+BtbBW=Vd=s-Fw1mxPF+sMwzZ_kA@mail.gmail.com>
In-Reply-To: <CAMRc=MdAek=vLqMzdYb1yk+BtbBW=Vd=s-Fw1mxPF+sMwzZ_kA@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 25 Jun 2024 12:02:33 +0300
Message-ID: <CAA8EJpqXEAL-EzGJqJXbJv4z8w4M7Fr61mH_dcHqWgiPZHbNNg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: don't disable power management for QCA6390
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Jun 2024 at 12:01, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Tue, Jun 25, 2024 at 10:55=E2=80=AFAM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Tue, 25 Jun 2024 at 11:50, Bartosz Golaszewski <brgl@bgdev.pl> wrote=
:
> > >
> > > On Tue, Jun 25, 2024 at 9:47=E2=80=AFAM Dmitry Baryshkov
> > > <dmitry.baryshkov@linaro.org> wrote:
> > > >
> > > > On Tue, 25 Jun 2024 at 10:46, Bartosz Golaszewski <brgl@bgdev.pl> w=
rote:
> > > > >
> > > > > On Mon, Jun 24, 2024 at 11:20=E2=80=AFPM Dmitry Baryshkov
> > > > > <dmitry.baryshkov@linaro.org> wrote:
> > > > > >
> > > > > > >
> > > > > > > Neither of these has clocks that need to be driven by linux. =
The only
> > > > > > > user of QCA6390 Bluetooth in mainline is RB5. Bindings didn't=
 exist
> > > > > > > before so no commitment was ever made.
> > > > > >
> > > > > > This might make some laptop users unhappy.
> > > > >
> > > > > Like I said: without upstreamed DT bindings, we have never made a=
ny
> > > > > commitment about the device properties. I doubt anyone will compl=
ain
> > > > > though, I haven't seen any DT with QCA6390 with clock properties =
yet.
> > > > > I wouldn't stress it for now.
> > > >
> > > > I was thinking about x86 laptops / M.2 cards. I'll see if I can loc=
ate one.
> > > >
> > >
> > > I don't get it, how could they ever get the clocks property without i=
t
> > > being defined in firmware?
> >
> > The clock and bt_en are optional.
> >
>
> But you're worrying that the lack of this optional clock for QCA6390
> will break it on some M.2 card? That cannot happen, can it? If it's on
> an M.2 card then it would never be described in ACPI.
> clk_get_optional() will always return NULL.

Ack, thank you for the explanation.

--=20
With best wishes
Dmitry

