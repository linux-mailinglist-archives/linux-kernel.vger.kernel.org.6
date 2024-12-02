Return-Path: <linux-kernel+bounces-426969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2F59DFAB9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 07:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BB8BB213CB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 06:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA181F8AE2;
	Mon,  2 Dec 2024 06:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VP3gPdTn"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1A3273FE;
	Mon,  2 Dec 2024 06:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733121034; cv=none; b=FX2uwk5t135Ag7udcr31+RbE8jSzpHrMev/03enFm2jdhX7yfMNHDQEQY5EY0AoI3Rnx74IpcENoMjIpv9LuTHKKcYC1bvR2yo8SsvV3A/CQk25s27S8VIbVG8rsDkWjRVpS/skPJG9Xs9N3PPh1b62Efxb3wNxz+aLgq1ZKU78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733121034; c=relaxed/simple;
	bh=2unuQnbensKcvHHm1uuRXpJwo0u5dXGS4FesNjDHOaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CDMCumIxu0pSgNohKSGpWL8dHTr9itUraEF+HrsZEIztPb2a0kedruTzh9Yy3WD5NVftZ0detzH5FUgKHrNTLuw2Oc3TiwNHTM2FQBzxbWudA2TQmVlpKzQ45mcrErq1LMTIZ0ZnROVbWqGTAiGygxjwdhPXgnGGA9t6KJbPmss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VP3gPdTn; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa549f2f9d2so492155466b.3;
        Sun, 01 Dec 2024 22:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733121031; x=1733725831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqMzcrh3CKT+VLE24HgpwTA5z8Zh0yIAaQygSzldLMY=;
        b=VP3gPdTn1c9nUe1ZNuPIKnEkrih04+fvzpNVgwO8Gieg+F7TPO/9kjGk5ADNsPjrTT
         T1+bfgm7dc7ZX+C63KWuO+3W2yVpfYTKSCEuUm4koCuWZNguvdvM3BZF5PBVtgdpnE8I
         uDyBlRRZYtyzjqe4otREqcbT/GM3VNzmcBZuoa+3GdfAYNA4P3rQBjnJcYVIXKHc3AfN
         3fDNm+4hF4sT2chDUr4dTvXOs2XAtpdQzKST3444ebL63Z1y4pvwsFbj48KF2cdYfd4K
         73oZEmi7zcsieWATgdbg6hRnZp1pc03jxkt8Wxzlxse4cohwrYlwJjNLAp/CPHTT6NTO
         rLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733121031; x=1733725831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqMzcrh3CKT+VLE24HgpwTA5z8Zh0yIAaQygSzldLMY=;
        b=NQpAlcxRLafQW2wn42oAJ8TyssOylymzxpOoCbeS/nrEf2jzjm5qERh0cvDIb3Zr9T
         Mtn0N0Ik7wTvOrKtGKddYuoxyz+uZa+42lDKq7VpOXUEEl4O5pMtOJ5sL6iIolUxasJ7
         fqjBvRYJAEzkexwvRkRfQkiXwFoQR6eSMVUkDa4r5+5IJnh4D6EmRh4+vhXVJjKAYn6H
         8ZczAEB2pS+34naYII5u49SDzWH3tdCUnIVcbWVfMAZZn6B5pwLiGZMouY1kSSzQ+KD+
         gdq2vLIqWWIJr99CjnvXrXPQ+RCjFcc1ZEf1rAoXHEuKB0nYe7669jewGGQZbgQgoK+i
         skhw==
X-Forwarded-Encrypted: i=1; AJvYcCUq/GkdB5lok254UllnrYGD1L4C6SL2J0AuKNYIw0/XnEkR+xHL0vpBnmj6iT1CGjWuPmg70qOPaJ+0BnM=@vger.kernel.org, AJvYcCVoT+ADzDBY9ku7Q+6NnosRLN8zHKRNXOQ89esTekO58oePdki8Ks63Z7x8nibyPKRFCRL3AbbIyICOzWQU@vger.kernel.org
X-Gm-Message-State: AOJu0YyAB+YFIEpveC6wNVp6FeGlHMOJzUFzaw/78ZFhYXLfw5q7jvW8
	WbhggsJ9kJ7ZyYNs37C/hmAvzc1le8v+UWEDtZOT8Fs0kGrNDcvODMjl/pocIUMHrFJDeuBvxtQ
	d5VmENWMkYU89Oa+7TWGMqH9p2lk=
X-Gm-Gg: ASbGncvi8qjTKXnCvhRHo1LVpORyWLhNFUdEQjJTQVtdCOYxN5GzylSm3n5UZS0sTYR
	UIvWKuic9UHOWM9Rz4Dbke5FPilRG6fAF
X-Google-Smtp-Source: AGHT+IGmotf4O8eEpyKRtAM5rzihVwBbme7GA0mJL4GVz5NuMjc55LvT3st+pRnsvyz0ZeWPk2Ry6nOzFjhLURhXn/M=
X-Received: by 2002:a17:907:7787:b0:a9a:835b:fc77 with SMTP id
 a640c23a62f3a-aa580ecbf6cmr1746451166b.8.1733121030791; Sun, 01 Dec 2024
 22:30:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <84d7b3e1053b2a8397bcc7fc8eee8106@matoro.tk> <31c884b9-77c8-48dc-b84c-20e52cdc4d44@bell.net>
 <71fae3d3a9bd816ea268eb73c152b564@matoro.tk>
In-Reply-To: <71fae3d3a9bd816ea268eb73c152b564@matoro.tk>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 2 Dec 2024 07:30:19 +0100
Message-ID: <CA+=Fv5Qy0818xS3uW2bh2nVpy-3COUzbq5X0JPY6=YzbfYgNOA@mail.gmail.com>
Subject: Re: [bisected] ext4 corruption on parisc since 6.12
To: matoro <matoro_mailinglist_kernel@matoro.tk>
Cc: John David Anglin <dave.anglin@bell.net>, Linux Parisc <linux-parisc@vger.kernel.org>, 
	deller@kernel.org, Deller <deller@gmx.de>, Sam James <sam@gentoo.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 5:55=E2=80=AFAM matoro
<matoro_mailinglist_kernel@matoro.tk> wrote:
>
> Hmm, this is my config, also on an rp3440:
>
> #
> # Timers subsystem
> #
> CONFIG_HZ_PERIODIC=3Dy
> # CONFIG_NO_HZ_IDLE is not set
> # CONFIG_NO_HZ is not set
> # CONFIG_HIGH_RES_TIMERS is not set
> # end of Timers subsystem
>
> lindholm can confirm on their hardware/config.  Maybe you can try that an=
d
> see if you can reproduce?  I will try your config as well.

Hi, I'm on a HPC8000 "parisc64 PA8800 (Mako) 9000/785/C8000". I can confirm
that building a kernel CONFIG_SMP=3Dn will mitigate this problem.
I haven't messed around with the config in the Timer subsystem so in my cas=
e the
parameters suggested are unset. (my config looks like matoros)

Magnus Lindholm

