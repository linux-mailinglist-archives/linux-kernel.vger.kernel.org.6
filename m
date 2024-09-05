Return-Path: <linux-kernel+bounces-317338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC41196DCAF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF0491C217BF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8045719F487;
	Thu,  5 Sep 2024 14:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZsoqf4y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D644619F469;
	Thu,  5 Sep 2024 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548061; cv=none; b=Tm0yVFf+anp8B9WjDSLtlZovMJnaKI2AAZa3p47T7HHUQBFPapSriVmekUJ78TD1673YVrxTeNUm3/TuXJE7uc4KpvJvyR6c0cynI7p9AbR4KhFIC+qYsD080ULJtH5aCV50Zsw4PgHXp07xP5D53Jrv6Q1ylvk5+YWaxZC82Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548061; c=relaxed/simple;
	bh=UUHnewB4h6BjmuvU1iEeBkQiipuPVS6T5jBbdXQDBYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cuQZP2Vr+PKOioJ3BW+eAdWsJdmTQ9FYDHWZ8IHjzx+xeE1g8TRxL/hIakqNCzi4u51lOKAvYRoMQBemm01KgNtb3x5Q/kMaG5Rt8QLAnh7xcPuuh8ZhRtXTvb1JWZTZAcKlwjmHe6jtRfFcGyAjI/eHYk8H1onRDc5ahzvHT14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZsoqf4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78527C4CEC9;
	Thu,  5 Sep 2024 14:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725548061;
	bh=UUHnewB4h6BjmuvU1iEeBkQiipuPVS6T5jBbdXQDBYo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GZsoqf4yr7M8DNN/H/mRUifQnEWOrUoFXE5sat8Gtxp5sqKHS4aR9ERPuXdjUhCNt
	 BwDF9YI7241GkzPCLKSSA5OFTXPlrUYxmEEH0JPAe05kbZ7Lt+uB2ATRdThvINa4tT
	 TIf6GibIdS3azAhohptf2Jd/itIzz6jMDuNWzniOQcVcrH9YMbJWbPlr+o3oYgSdi6
	 SMpn6ZyzhKlAkQA3hDvspANz9QyYu522oUYZqZ052YAcdr/S7znaaNyp2/mNfAhPYO
	 b0i0jizyrxIaWfpGj5+X1Ju2DaxzFjrLo3iyczRTTvqg3qX5qHjII7leXn3OEAejJu
	 /NsCRG0FH2GJQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5356bb55224so1106513e87.0;
        Thu, 05 Sep 2024 07:54:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUn5PlQMt9HByYYGZPqrIbxADcpGlCIbtnU3CzPubhjjo+n25YDPV7F5wvs/79gpqkDwj/anEl69+LjraDa@vger.kernel.org, AJvYcCX58aon35Bd5GgaVYJma1z5jvtDheE15XlAY/J6wQDcYu8CsLQ6fQPXp7SMIdjjHWOI0PmMDc+3dNns@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8EFE0HqFV1ZzNlpzi92NE1nrDoijdy4Nm1um+i2MZitJkZ4uM
	3ga2K43tAy7DDsYqsuj5OBNVR3k6xr1RUEx7OIUeGvIfx+qsP0dvTJgZEmNFqZWaZ4hpB/f/J+0
	0dg8UE53urC+UV7ub9LzsWT+nww==
X-Google-Smtp-Source: AGHT+IFlSeFYMNSm1QKxRra9izZe4ohmwyETHeZy0yKrKZnqSLZ2jfK2gIAtZdWXH8SqtlzBvOVv3uuWe3uVZdR03Ts=
X-Received: by 2002:a05:6512:3d27:b0:52f:288:5664 with SMTP id
 2adb3069b0e04-53546bc399cmr14867395e87.51.1725548059816; Thu, 05 Sep 2024
 07:54:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905-of-resource-overflow-v1-1-0cd8bb92cc1f@linutronix.de>
 <CAL_JsqJ=7kX6DL_HBJMrWuhjZEmPUL++BvJ9tg3BDD9-e+b6Xw@mail.gmail.com> <20240905153318-ef305b5f-7987-410b-8256-aa6d01574fc9@linutronix.de>
In-Reply-To: <20240905153318-ef305b5f-7987-410b-8256-aa6d01574fc9@linutronix.de>
From: Rob Herring <robh@kernel.org>
Date: Thu, 5 Sep 2024 09:54:07 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKu2yC_xaq6SY472XRxJr-pMp8msFQ2HeqppZ-16yhRzw@mail.gmail.com>
Message-ID: <CAL_JsqKu2yC_xaq6SY472XRxJr-pMp8msFQ2HeqppZ-16yhRzw@mail.gmail.com>
Subject: Re: [PATCH] of: address: Report error on resource bounds overflow
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 8:41=E2=80=AFAM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> On Thu, Sep 05, 2024 at 08:15:40AM GMT, Rob Herring wrote:
> > On Thu, Sep 5, 2024 at 2:46=E2=80=AFAM Thomas Wei=C3=9Fschuh
> > <thomas.weissschuh@linutronix.de> wrote:
> > >
> > > The members "start" and "end" of struct resource are of type
> > > "resource_size_t" which can be 32bit wide.
> > > Values read from OF however are always 64bit wide.
> > > Avoid silently truncating the value and instead return an error value=
.
> > >
> > > This can happen on real systems when the DT was created for a
> > > PAE-enabled kernel and a non-PAE kernel is actually running.
> > > For example with an arm defconfig and "qemu-system-arm -M virt".
> >
> > A nice follow-up would be to make of_pci_range_to_resource() use
> > overflows_type() as well instead of open coding it.
>
> Good catch.
>
> There are some differences though, it
> * returns -EINVAL on overflow instead of -EOVERFLOW

I think that is safe to change. I don't see any cases looking at the
specific errno. Note that of_range_to_resource() kerneldoc would need
updating too.

> * sets ->start and ->end to OF_BAD_ADDR on overflow

Don't need to do that. No user accesses the resource on error.

> * does not check ->end for overflow

Obviously we want to do that.

Rob

