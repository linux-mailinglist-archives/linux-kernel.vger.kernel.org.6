Return-Path: <linux-kernel+bounces-267830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBDE94168A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B1BD286E0E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967D2200109;
	Tue, 30 Jul 2024 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9vUOZDb"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0261D47D6;
	Tue, 30 Jul 2024 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355269; cv=none; b=MQzmSBDOXxGrwHQddVJMgpPrWtOc/PyM5R5498te9I5u6J5PY+jHzrCw/0TSguADIIsxO+pMcHin+Z7l1e4uEkhNrTS/SYCE0Q1PFxoSWIlhm9Ym7ukejM8MdSbrAb80aJR9ewaHwzE9TMXCFfnMHjH7YbPIvWx157Ucfw5nXyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355269; c=relaxed/simple;
	bh=5mJ+Fa4YzBMtPcYUMnapDzZwmYYhDCSsbLcmmj09iAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GOtyYa0/jAPmdR5pv7AZNhj4htO2LrKUQ63e7iI5xksdGhm7avvj3qMAxgWn6TdEa7eH34+BFa267abLcTV3AONXGWN8+XiO+5n3U1hmdpWyMtlIM2W63iFokPU5yC6Isw9XERB0VMKmcaCNoATc5ezdou/ZErbwDOuCBFkrLms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9vUOZDb; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-6e7b121be30so2923635a12.1;
        Tue, 30 Jul 2024 09:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722355267; x=1722960067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+azbU4dkx1METlOrhJvWgMM3asJHtz8a8gQtdOLtu74=;
        b=l9vUOZDbhXYMs9bDmERxoFT8icZB+k2Aah+e0aJyrvSr/kROVStRBzMLoKaNsbHzT8
         8y2ZogF+1HoTg0HUssfzrOLMYkqDeYe/msVJKhXZxFA0wLr9O8CNZZgTe7anS30ihao6
         AHJK0ooe929oA8x3Nz4f+P/dUJJSwUHBLUFHd+FrJn4hddikTgm7ZPM8wYV69aG+Zpcr
         u/GYwxQg01fpbDi+6s3BZVOELIOdMnLFit0Lj/G/xQ9k0ksb8AwZiE21vXRD/5R/sHxR
         /m8+Lj4Mm+obAnkQcs/mV6vwlfTSjXosc4asQadjGQ+/ggKnSaR1tlNmR1N8bv6KsEj8
         xjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722355267; x=1722960067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+azbU4dkx1METlOrhJvWgMM3asJHtz8a8gQtdOLtu74=;
        b=U7YcdxcNShVC3kklyL9LOFOJlr6qo4HQCJzeHFVXC6wAllWTg4UzsT4lGDl4R7F9Y5
         CFTWtVwDI6rbJQuoCroeCEqse1VyOze0rEyCaVHoPOlSs5TOMH3QTCeDPi5/BAZ4UycF
         6+MmOhWXSXaBZYsboS0fLpAskkxgieS3zAH1Y8/8AhIS+geUjarqprtE8DiMaEgiIcvd
         tKjWMlBDwgMZk9GOeLqhLdtoqRqVt4tFk1BzYfWeezT3IpuObeGjNovvDRt1VNRXV7IL
         ntQrH/+prymr043YgL8se/9twsEUw6xwNoTSOjq9XxuvdRZ3+UePclymg2CrBqsHW31w
         a5OA==
X-Forwarded-Encrypted: i=1; AJvYcCV+L3V2Gj0Y2iuTzh4uDJz9Q3QQIsmn4SB7T/l1hbhZ/HyEUHtLpKgHwA/JYZhi/vJBMUIDMPXQi6cdddtLApBPbbKy8PRfcvQPXhjZMl0=
X-Gm-Message-State: AOJu0YyjmTorCzgAoY89uKr2paXNlgbibQ5diqTlR7+o4AqY3qOL6PyR
	pWzDtkQk3amA3RsIrR7we1+rFt9i84jO2/mSZdxqXx2r2z5nSHd+xKVSfx/3jmfGbE4LOudX1W5
	Th/QVfc8f2Noi7csE1YOvd0/f+cE=
X-Google-Smtp-Source: AGHT+IEFkkxI26oFpF2A/eB9RELT4Cn3JAhTHtGTdkglvcvwJ5R83ZvoSfW36RRhg9WxfaGu/Milpi+Ybd4r2dfj9YI=
X-Received: by 2002:a17:90a:17ea:b0:2c9:860c:7802 with SMTP id
 98e67ed59e1d1-2cf7e5b6b64mr9186733a91.28.1722355267277; Tue, 30 Jul 2024
 09:01:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2dbd1491-149d-443c-9802-75786a6a3b73@gmail.com> <fc3e956c-4f0d-4705-8429-2b7c50e335ce@gmail.com>
In-Reply-To: <fc3e956c-4f0d-4705-8429-2b7c50e335ce@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 30 Jul 2024 18:00:55 +0200
Message-ID: <CANiq72=kAdq4TsCPvMWBwdzngeOst8g2cGzkk1DxM2yW=V4emQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm: rust: Enable Rust support for ARMv7
To: Christian Schrefl <chrisi.schrefl@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Jamie Cunliffe <Jamie.Cunliffe@arm.com>, Sven Van Asbroeck <thesven73@gmail.com>, 
	Geert Stappers <stappers@stappers.nl>, Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 11:58=E2=80=AFAM Christian Schrefl
<chrisi.schrefl@gmail.com> wrote:
>
> This has been on the mailing list for quite some time with only a few res=
ponses.

Up to arm to take it -- if it helps, I tried the patch, including
building, booting in QEMU, running the KUnit tests and loading the
sample modules. Thus:

Acked-by: Miguel Ojeda <ojeda@kernel.org>
Tested-by: Miguel Ojeda <ojeda@kernel.org>

However, to keep our build Clippy-clean, it requires a a patch like:

    https://lore.kernel.org/rust-for-linux/20240730155702.1110144-1-ojeda@k=
ernel.org/

which should ideally be applied together.

I hope that helps!

(Nit: please avoid top-posting, see https://subspace.kernel.org/etiquette.h=
tml)

Cheers,
Miguel

