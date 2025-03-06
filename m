Return-Path: <linux-kernel+bounces-549343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 557B3A55187
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F4F8189992B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458E922CBF3;
	Thu,  6 Mar 2025 16:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwV/6auN"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AA9213E72;
	Thu,  6 Mar 2025 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278850; cv=none; b=Y7xYzYWCkkBN888ZtQQ8nAxuZKk8ftk5Bte2DBY0/JqtxvZ12ZWEUFbhZ3TouO/oUZhEsnGjdI659d49QTfHcfusjVyQycvoLhwftwxFinKjDCfpqwt911KLix2OzYyIBCh70g7p7pKhADpyyFgP4YU0kGo0JKf+t4KFenwsQxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278850; c=relaxed/simple;
	bh=JPfTPYNPSGx2W+d2hiMjJ6fantkgTQSUHeM2eii9EB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ee00LWy0TR+5MHdx8YRmNb2t2mb6fiNSYue4lWV/qs6aIfJk/6YmS+brCQitNWyK/Zp1aopZjFMnUjLF3aSApdpUc4Ph133Nk1hOHD8Tb336bfIY9jyiYFMBNHgS/UHhrwAkHvj3cZD90gvSCxpfUvGX3JUzB2ASn5uHHH3nqg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwV/6auN; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ff5544af03so242173a91.1;
        Thu, 06 Mar 2025 08:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741278849; x=1741883649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPfTPYNPSGx2W+d2hiMjJ6fantkgTQSUHeM2eii9EB0=;
        b=LwV/6auNoxz4QYUQYwPryDsjHXgkJwvosVmonIAGVJTfxy50YfAqLruEcbcKrPRx2C
         Bk33lc0nnFBznF5UFr85B7lUXxKCUufoM71Mh6SmKNN2yPyg3aWrgOmUGfps2KYYKCov
         /txmDkcAG9FFDSxaM9zV9j+7W3hoKURDkwZtWcjGrdOzyREjWNUaI26frltlwo99gKGu
         X4h1ci6MPvoT0+bB87U5O12SnOUegJsQgUyHXmKN1IeFXmM/eUC9E1QlEA+B+cXmHI6W
         i1PrueJPYoTnkfc1m8puF8OAbiqKQ4ryGiZ561S7ohK1HXHetcjLH5M28Tf2+FuLeg13
         16pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741278849; x=1741883649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPfTPYNPSGx2W+d2hiMjJ6fantkgTQSUHeM2eii9EB0=;
        b=L5t5Tm69o1q3ikBnDqh/jySLRSTjRsmUGw9/6Ln7rdosTLXIatDza569CkMKBuOG5T
         NX1YWVxR/OZeZZJgoJ0hg60i5mR3NF7WTDg6YT2qoQ4WGd/6aU+bR97BV9Qmg9oLQKl8
         N6QFt/mi5J2BjaLKFG7N05weI6QtUlbJKli9SJB39Fu7j8WKI93I+Yjf9/27bfePF8Ah
         DyV2md0lfEalcoP70jPsmge9m74z+txkdT+DkXQYoaHvC/zmUAeFX+Pn8Uf1/v1A+sRl
         iIxf/TcIVm9HTvb1Gob2kutD2pvDYkaqSKwVLOe+PZGNFboa2iqPM3hBZPOljWqXqS1t
         at9g==
X-Forwarded-Encrypted: i=1; AJvYcCVY/6nHp5CrhwBlTWbIPDbQ7oL/v3fztaCJ+F/n1fntAhlAPw+zuZSflkrhIhfaidJdLI5JMl2fsRNvk0U=@vger.kernel.org, AJvYcCVm40fFmgZurwjJE2qIrxUJ8gdGtsCzCI3uJxa8eUbz1tsm8wbC/dy9//DOI/phVzHtDi6hharDaTzNywghZdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFkmG7lsfRRHJcjLSHo7pvSKcysIIMFIZn51511FTCaHqmmgL0
	v0tnTo/8Z4SqSZ/FSnmVsd2RE8TX4/fT3mLCt5/ZR1DjU5nj4XmY6WjxB7eZrf8jvZGUS3U0GiQ
	ewVa6ImbHF0eRjj7PLREf2fmVZ7c=
X-Gm-Gg: ASbGncuG0jt+enYdAiafVKzK0WM6gVmGAve6YZxdGaV13HYRVHUGF6JhwTgLdfckAA9
	UzI+uY9Oi+IQEonGtGY7o8s3B6kSuwE039ZjdJ7smFwnsSjR0Rbm2AOE8JG+x1+qVGVllJvohtF
	ABapxaEG1jAgX2frKnEJcN4m6pjg==
X-Google-Smtp-Source: AGHT+IEO4uA0Nffhk4ga9vpFjHLRTgwLtTvkQSDk8h9yqOVYnnyJP6sILkQjgFhBeKzggcQxL1N0OtABh2yfMMhwJds=
X-Received: by 2002:a17:90b:3ec3:b0:2ff:7b41:c3cf with SMTP id
 98e67ed59e1d1-2ff7b41c484mr111353a91.4.1741278848686; Thu, 06 Mar 2025
 08:34:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72md_orajH_TREr=ng8Y=o3Xkgw-V5oxbX8vYXOE2UDNaQ@mail.gmail.com>
 <20250306163206.301564-1-trintaeoitogc@gmail.com>
In-Reply-To: <20250306163206.301564-1-trintaeoitogc@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 6 Mar 2025 17:33:56 +0100
X-Gm-Features: AQ5f1Jqtx_zvYa1ZPedTpXgTGcjeC46bCJfv1p3V8MvSBM2y-JmKXYbNwu4Wv-s
Message-ID: <CANiq72kGXY4gOCC9kqbUht8e23bsQwddk47jE+wzGO8FidJvqA@mail.gmail.com>
Subject: Re: [PATCH V6 2/2] checkpatch: check format of Vec<String> in modules
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, aliceryhl@google.com, 
	apw@canonical.com, arnd@arndb.de, aswinunni01@gmail.com, axboe@kernel.dk, 
	benno.lossin@proton.me, bhelgaas@google.com, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, dakr@kernel.org, dwaipayanray1@gmail.com, 
	ethan.twardy@gmail.com, fujita.tomonori@gmail.com, gary@garyguo.net, 
	gregkh@linuxfoundation.org, joe@perches.com, linux-kernel@vger.kernel.org, 
	lukas.bulwahn@gmail.com, ojeda@kernel.org, pbonzini@redhat.com, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu, walmeida@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 5:32=E2=80=AFPM Guilherme Giacomo Simoes
<trintaeoitogc@gmail.com> wrote:
>
> the checkpatch don't will throw a warning message, because, he don't can
> perceive that he is within of array of author, firmware or alias of modul=
e!.

I wouldn't worry about that case -- it is unlikely we even have the
case, and even if we do, just manually checking it is fine. :)

Cheers,
Miguel

