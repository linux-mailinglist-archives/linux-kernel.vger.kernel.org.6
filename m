Return-Path: <linux-kernel+bounces-437396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F36DB9E92B9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2EB016085A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035952206A0;
	Mon,  9 Dec 2024 11:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ha7hgykx"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74421F931;
	Mon,  9 Dec 2024 11:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733744881; cv=none; b=RXwz3MyhVWf/915xqKniDY44XFs9HoGZsIzqYJcHU1IwR0csVeQ3CfqKoXYWzcpZK4E9SpsFeegZLro+ndnRxhh6woHJyHxhufxkxQp4Ao3Q/OMFBwMui+Qp3lQroSJR6Sw8gVJllveFtY13eivtg+Z7UgH2iQK4FOSYqOzTE0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733744881; c=relaxed/simple;
	bh=sGAse8iE4lO8igztrgki0CsNHhYhXN7gLNtCUgD7z+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpI6y2citfU61jaSUeBdBOZW4UDWYbU3D8bHg0wD6JAbGiKSCzxAKFhF5vD+xrageufnWVDBtvJgyZQgZvx5nLD4HcO3YDu7v0Az2JzVfRik2KvXdFtb/H6n/oOqdYnvkrZ8CK+8k5lbU+AJENP6oNAW5gQzbvi3r39+v+R59VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ha7hgykx; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ee4b72d4d8so652440a91.3;
        Mon, 09 Dec 2024 03:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733744879; x=1734349679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHnRfRL33JY+SgOza+omObtcVl8TYmseJZ6d8dTduFc=;
        b=Ha7hgykxe5+K/5ac22P14/6Dmsci4xTbop5sjKpZfjMTX7NcOLwcrEl0mHwa1W6vC8
         IQnXLYGxfjysbGXjW4d1MzQfjZUK5S9gMMLvWNVkavHUHTSWBi6xjSX8+2cpQYF8lAJM
         4kvjkw3GrQ3mSwjQfG76Vqb8GyZyInvEd9/Bwq+0Rodl4trOZD/iHoIc0ZISon9jj04t
         jMYZlT18UoztBEJjfK+qCbJ9QrZOa4rjeFOdFVn0pvfirQi3Ue0nn+t7iTWYLih3GFBj
         qsVnbvQhJZXDN6/feb6AVxrIYRpVVatHRnKt56k7hKnMZK+sidYYbjUWkQua+rUaMn2h
         Stvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733744879; x=1734349679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHnRfRL33JY+SgOza+omObtcVl8TYmseJZ6d8dTduFc=;
        b=dHQmGkLtfT/bEIHs+kGKjNUOLLIkhaXpX6M86K/mI+TbYtLqCNAepjk/712vX5XW6S
         wOH8eedwpwQOp0AuZ5OR/8wzQJwmakxA3b1tpdcEVX1QvtQUAMokYqVQsK9YzSK7VqQL
         FOjibzGKgF/f25qT2ZFdPf0NX2EncXYjc269NjimBfSvGCHhWcbiO978dktMpNbQlS+N
         ECCtmnFXFU6t0qxcv8ESMqxiwk+QdoCWzkui32EQ/GGT5+tAYHZxIzsPFGd+x/82SVRn
         xNjJ+irAm7wnBP1Qlyt4J/INrae8/ZAv2zc4BBaAY6A/fkAKdlYhEiyhLC5JKO0YCasR
         92kg==
X-Forwarded-Encrypted: i=1; AJvYcCUCQox7bHPsoe/wBehY7FX+9TrPNJAVS8jSvmFdzAYB3F1K5O9FkREq5STS8wMjn7PHhV+LT6H0zL7NYvo=@vger.kernel.org, AJvYcCVvVEsvnNcqt6FTY1wnV2Z0mj5H1GLA6phvXndliLqxQkPhpG0W6bnNGzcyiwooXkMkCxzDmfJUKLSI4jxmpfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBqBklUSu9WgGorlx5lwtrSUv0iloK+NnSuBQZ10eqF52B1vNi
	72Wc0pb5QwGHC2jelC6/1WNAfw3LrzWdFmWRpJiK9FDFiGkT5O7Ef73DBCGwboSPHaFU++h90DW
	WpPO+RajtdQSEGN5sJsIwpPRVqPo=
X-Gm-Gg: ASbGncvOr40s8ZwX3X6OoFS1KpnVRY8d0iV1GwCjmesXDOt773b20JvKdzGEmyhLJ3H
	uY6DVcqKgcEyUwMFUEQMi9GC+4yRUY/A=
X-Google-Smtp-Source: AGHT+IH5C5Rb0zbqHMVD4gazrlgtxXrtT8gxWz3ZbGytElL6YCPuhtwuZYmAVcaff3/PeqBswyUvShra1yLUzDEv0J0=
X-Received: by 2002:a17:90b:4f8c:b0:2ee:d9f2:2acd with SMTP id
 98e67ed59e1d1-2ef6ab273a8mr7147109a91.6.1733744879050; Mon, 09 Dec 2024
 03:47:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206192244.443486-1-trintaeoitogc@gmail.com>
 <CANiq72neo_RtANWJu_GW5LxsR5KWxriS1L8nsXkNn7ioiaEQKQ@mail.gmail.com> <30ddfc7f-4b13-4caf-8859-2cd2e72ef878@sedlak.dev>
In-Reply-To: <30ddfc7f-4b13-4caf-8859-2cd2e72ef878@sedlak.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 9 Dec 2024 12:47:46 +0100
Message-ID: <CANiq72mh2_QhHcE65-t+6UEEqe+9XwGQ3gJ1CCQpZ6r3HOcokQ@mail.gmail.com>
Subject: Re: [PATCH] [PATCH] rust: macros: add authors
To: Daniel Sedlak <daniel@sedlak.dev>
Cc: guilherme giacomo simoes <trintaeoitogc@gmail.com>, Wayne Campbell <wcampbell1995@gmail.com>, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, walmeida@microsoft.com, 
	fujita.tomonori@gmail.com, tahbertschinger@gmail.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 7, 2024 at 11:15=E2=80=AFAM Daniel Sedlak <daniel@sedlak.dev> w=
rote:
>
> I think we could fight with the code formatting, because when it comes
> to the rust macros, rustfmt is often very confused and we could end up
> with variations like:
>
>         authors: ["author1", "author2",
>                         "author3"]
>
> or
>
>         authors: [
>                    "author1",
>                    "author2",
>                   ]
>
> and rustfmt would be totally ok with both of them.

Yeah, that is a good point. There are hundreds of drivers with 2+
authors, so this could indeed be an issue eventually.

Having said that, we already have e.g. the `alias` and `firmware` keys
that take a list, so I think we already have the potential issue, thus
being consistent in our use of lists sounds simpler (unless we are
discussing migrating those away too).

We could also try to mitigate the formatting issue via e.g.
`checkpatch.pl` if needed.

Thanks!

Cheers,
Miguel

