Return-Path: <linux-kernel+bounces-291224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7340C955F54
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 23:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293C01F213A9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 21:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8805315530B;
	Sun, 18 Aug 2024 21:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axtImM1V"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5253DB67A;
	Sun, 18 Aug 2024 21:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724016711; cv=none; b=jvXdZF9SUbEzXNrc0n6Ksh3LR8a2tAEgO7pB2JiCGNowKvIl1WGjqDJhNHpsSqmZ3OjsqyHDZzZsDjWqxFfWiKjIvYM4IkzIGS7BxfCYHLig/A7lzxN5eY4HES2zn9osoqFcLJ7IwXrs77VR0YJa2jLk0N4paWLGHVnmEmxkPto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724016711; c=relaxed/simple;
	bh=XN5T61RDMAPTW3qjddxq7B0BsRlqJCkorxMKqXS/D6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TU02Hq65hzOcsIM4+AF6gDQbhk7OT2QW1D7BSi370njxjwA12AZvm94vkaYIvIWSPW3ebCx4u+dp3snyobPYn+ZebKfTcGnaIqC642TQQdn8P0UDYdRwEa1yMHXlfNO/LApdwZuscKRztJ48zSgtwDJ4V8ZQS+aku/Yd1xR2Iao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axtImM1V; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-70942ebcc29so2702529a34.0;
        Sun, 18 Aug 2024 14:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724016709; x=1724621509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3BVurL5/9PMXBlfEpBi+zKwV8az7i/+Wh4iZua+GhE=;
        b=axtImM1VYZ/XzbSnwSUjX+wHB8Ml0nrZnkfOTI6dqhg3b0CG6Dm4XrEMUwOR4UH0cy
         p3QUmeSANPxZqXia1WTM1BD1h+/2XUDwyrpRxUvHHfigz9akCmdh1HhKWlNw+bRP+Juu
         3jTX6+bhGqXPKk/kDYFUtMFpWoZoGLuPnrM6y9dxL64QHgmf/KTlt4wOErBEdK2iWCOF
         RnknYjQSZ9YUPr09GowjNbk/tStxorTTimzxYi00B+OhDTTub+53BfAqV1uYFE2vPaxg
         1X7pgAIOfkIAFll8PeUtdrTprcQjhQWXnHMdjDT5v2BnxkDN53OJbzTpSttP9bTHEIO+
         VAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724016709; x=1724621509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3BVurL5/9PMXBlfEpBi+zKwV8az7i/+Wh4iZua+GhE=;
        b=M4hqYea6fADvZrZoZkPEb2SDVy44JIeo/QSO0usb8ktqMMar/xJjiqSF38iZI1CWIg
         FmBAJUh7HkGJtEJgKGqCAcCgnGSHrqcQoNYPG+CrTvRIXAjqlTuVjoN1qpaLXxaIGCp3
         OVzJLBZbNVL9CPEwrVnwJJxiKWRd7x5xEgep/KXEigCJD/GapWxq6EAxtf7FRo56Tnpy
         nYPVfkipGpuqtXF31ZP8p7b0HkAeo35V5ZtGG8u6qaylkAXyUMPlXvZ4StyQo+xUvKT6
         Kleh10R9uPz+OxRYXOS1aye8+zNnI925KyEnZVipiCosjidjyHYM7AqeRbETz4tD1Krf
         PhBw==
X-Forwarded-Encrypted: i=1; AJvYcCVausYLTKPc3KPBcaTFh+VBo6nwtDYE68wVFhb+Feh6k7gJN6SGt/CI9i5YncyBBMBhEH9u4LL2x7XqILZ6UPVe12NUJBhvrwaUE0BZk3/Me8BMdvzVUTEtvYAtduJVMYeOIRNB9AkuT3bfGtU=
X-Gm-Message-State: AOJu0YwLQXIhH2dksdBevwB0F6aQtlIxh3N0GpRWxhszfnVt3U++FF44
	MGQMldy9tq3UfG+o9knsWitgN8fwsJzl6pQITp51FS/GWF404x6l5yX1P+lLKS6c7pCS+z9xN3o
	rFY2Nf38rrvOCN95s6V3iF1n+7Co=
X-Google-Smtp-Source: AGHT+IGYrImHtnMwwV8Zonww8P4XquS+0+b8hDSN8+MuYU0EVUkRULDO9az9c6DigMZ+PTh6q5c1oS9nKtojFhgQqes=
X-Received: by 2002:a05:6830:6189:b0:708:8c07:c646 with SMTP id
 46e09a7af769-70cac8ddf50mr11616606a34.33.1724016709374; Sun, 18 Aug 2024
 14:31:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727042442.682109-1-alexmantel93@mailbox.org>
In-Reply-To: <20240727042442.682109-1-alexmantel93@mailbox.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 18 Aug 2024 23:31:37 +0200
Message-ID: <CANiq72k=kh-waAy2q3JU9Uoi7j5YZFoEWoXnS_gPAsZn1=Fm7w@mail.gmail.com>
Subject: Re: [PATCH v3] rust: Implement the smart pointer `InPlaceInit` for `Arc`
To: Alex Mantel <alexmantel93@mailbox.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 27, 2024 at 6:25=E2=80=AFAM Alex Mantel <alexmantel93@mailbox.o=
rg> wrote:
>
> For pinned and unpinned initialization of structs, a trait named
> `InPlaceInit` exists for uniform access. `Arc` did not implement
> `InPlaceInit` yet, although the functions already existed. The main
> reason for that, was that the trait itself returned a `Pin<Self>`. The
> `Arc` implementation of the kernel is already implicitly pinned.
>
> To enable `Arc` to implement `InPlaceInit` and to have uniform access,
> for in-place and pinned in-place initialization, an associated type is
> introduced for `InPlaceInit`. The new implementation of `InPlaceInit`
> for `Arc` sets `Arc` as the associated type. Older implementations use
> an explicit `Pin<T>` as the associated type. The implemented methods for
> `Arc` are mostly moved from a direct implementation on `Arc`. There
> should be no user impact. The implementation for `ListArc` is omitted,
> because it is not merged yet.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1079
> Signed-off-by: Alex Mantel <alexmantel93@mailbox.org>

Applied to `rust-next` -- thanks everyone!

    [ Removed "Rusts" (Benno). - Miguel ]

Cheers,
Miguel

