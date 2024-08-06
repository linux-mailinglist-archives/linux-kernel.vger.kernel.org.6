Return-Path: <linux-kernel+bounces-276668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E7B9496C9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 610AB1F25084
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A47A757EB;
	Tue,  6 Aug 2024 17:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezpgRUU+"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166D73C08A;
	Tue,  6 Aug 2024 17:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722965353; cv=none; b=I4LAzrgIvMj/97PTqNYHpl8Vd7o54BbjPPfmdNTId70i0zfQi6cW0XWldc5FkEzncU+V4d8XRabMRYxresKmtHQwymDku7b4QmTjo2PLm8hEY4YI+wOPnm+YsNaZ2uOUNqe6Bci1kl99qD2EKoK5edznItkbLyxcxtsyoh+YNgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722965353; c=relaxed/simple;
	bh=/mO63XZtQ2CoGPEq/ODUwo/fxXZWPxcKmKWOXs8cOm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cvh3PxoQAjtWXkVR9cZ4ZdAEmXuZrSCXqpyj/wb4UfpI0oZqZ3HJb5xuRvUmyneXGcnuHSnAh1LapxDmZzmv6BVbE3sezi+DWwmxO+Z+Jdmf3J1pkjMZB/hVkD9xaXZtQ5hbxpfupp4AAMwmNn0EtyiCCgKjqvwIQCdqYg59/CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezpgRUU+; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52f024f468bso1102951e87.1;
        Tue, 06 Aug 2024 10:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722965350; x=1723570150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mO63XZtQ2CoGPEq/ODUwo/fxXZWPxcKmKWOXs8cOm0=;
        b=ezpgRUU+mf+ErtsqBrPovkRj3rLlhaL/c6DpIkjQo69FZRVzNIXCMBKkGRqh+ccDsd
         qBY1HHMwJdWQBW2sSnnH3SInLvW9req/9NeNoQlGUBbQ38G3SZW9IJGt6yfAf0o3y1jp
         gbTu/atoce22ONtxTWouSuOph4ikB9u5RMKhly87pLVCY6x4aQx+HD1z0pi9M64DMK/J
         xLYntlHH28/v4Ysm2U4Q97LGvijHd63foIbWCLi9p4Ly9LQgzbC02lY1/IEwrnu2qorW
         do8uN/RS+DuY7lqRNEFGEJD7KarvxvhViP6HN+9Zr0nc4mPmC5gRV7U4/v60tmrfGnYA
         1i8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722965350; x=1723570150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mO63XZtQ2CoGPEq/ODUwo/fxXZWPxcKmKWOXs8cOm0=;
        b=oy4FfRJ4flFpo9tACoR4Y3NM1djNydM/zIb5u8Bh2rH9gscTiuc0cu43MTJ54+Bn28
         HF1NR7XxmAA7tLzM9LvetOTnXBD72bS0h8NMx8XpGU1VbMhwFfpDnXc5wIq1z8GHd5NV
         ztDorjXyLDy4zdtH6fAeydLVLJykC5itMT5tKRlbwYPpKm4sko/hFfXIO86AxuENwWAm
         868/zUVfmP5jh57HDf0slG3URtzt89fbe4G8q+1xLuz0Uc+izhAwEOm6azN2V7deD4hL
         91dEwKQm2BH7IZPJRdIl+9U0dgod/kG/JoTuqViTHYR5LR1U0vZB91q2yalVidARYR5Z
         5jiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9kZ4sFcjqIJa5fgsx01m5JwCi08knrEX2sj+Ta/GLm9kREX2BOngcWfVkSgjItoBjfx/BY+wbhqTgW+EpTLPzhayZRM4QfYWaElWYLXn/wJMLbbmdyPTBuADSzY3uOdpmC+C53PToocyk7LU=
X-Gm-Message-State: AOJu0YzPJZbrUfWNIKjVJGTvlFIIkGdPRebRZ258EGuo+plATiWFfGZh
	+oGh/gjVhlvmOPAAKPwFBVSVNfJ9RMh0PQCg65XkfKvPgIiFkoIQApPeLABVVCGyMS9/sLDKvlC
	B28rx/uUyLqcBPVNtDBNEyG3vRSU=
X-Google-Smtp-Source: AGHT+IGYt/OpjuDDi43vI2YwA2xxXdzqCAz8yML/mvLo/u1NkhQQ/OOWsFbMbG4SHDGcl1X3esj/CbpXNT1ftTqRNqA=
X-Received: by 2002:a05:6512:131e:b0:52c:88d7:ae31 with SMTP id
 2adb3069b0e04-530bb4d75e1mr9571643e87.48.1722965349637; Tue, 06 Aug 2024
 10:29:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-9-dakr@kernel.org>
 <ff0826af-9430-4653-abe8-25fb80cd0e97@proton.me>
In-Reply-To: <ff0826af-9430-4653-abe8-25fb80cd0e97@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 6 Aug 2024 19:28:45 +0200
Message-ID: <CANiq72mbrxFqqRMpdbuuOCy+mKtjFbLaSd-OVd_ntOeqaYRyzg@mail.gmail.com>
Subject: Re: [PATCH v4 08/28] rust: types: implement `Unique<T>`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, 
	wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, 
	akpm@linux-foundation.org, daniel.almeida@collabora.com, 
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com, 
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, 
	cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, 
	lyude@redhat.com, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 7:22=E2=80=AFPM Benno Lossin <benno.lossin@proton.me=
> wrote:
>
> I think I already asked this, but the code until this point is copied
> from the rust stdlib and nowhere cited, does that work with the
> licensing?

No, it doesn't. They should be put into its own file with the right
license and a paragraph about it, e.g. the other `std_vendor.rs` files
we have (if it is just about `Unique`, it could go in the existing one
at the `kernel` level).

Cheers,
Miguel

