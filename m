Return-Path: <linux-kernel+bounces-271480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C48B2944ECE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A96E1F2142C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6EB13BC0C;
	Thu,  1 Aug 2024 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fjKfuEoV"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E404F3A1DA
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 15:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525038; cv=none; b=f3O+7DN+3Opc9JGWenb/2vmrYUmwJ+QedjRDNHt/bUWASmwQtsSUzhLQJ39yXzWlNRncL5efXR677ImLInnK93vH0QnRmW60fzivYKhPTNmO3biYaEwmZZZxz0fPRPsezQ8APUjZ/nc/11PIaEHtdZXQQTuU48x5ysB14owSFuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525038; c=relaxed/simple;
	bh=GXlkgk+EdujUWxeiY1QMQJoMmtLa0K94NMdTgUaGOi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EwJBhtYH56F+qBr8vi4zOzoOKKYfYYhI/GCZrONrTv2giV4ORmQDceIoKl/7BpGjQAFgC0nECd4O7FcPTttdoyhGIoG9PRWlAA7aI8SGzj7FXoeFakowzshFf0xsmguQ1xLKPIofnv87Zw2SDFLu3PxbjJT5MqnX0d26dGuRyA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fjKfuEoV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-427b1d4da32so13252465e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 08:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722525035; x=1723129835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bk9wanyFW6m5LYofC0MsD2q5eoNVdvtlWBG2yEhfFuI=;
        b=fjKfuEoVxqkVjBZPL7npbaFSwR14IVOEUkRoqz0YuKIUcOP7SaCxS3K6tB+cvCfOPr
         rRGSwZCk/zh1wyqe9FanRwrA9q3gswpH+I4LXZDf5tQRx3D/0Bia06370KMorALDr4QQ
         DmlkHNIKrnxLbjWTAhiVuPfYwKu72k9R9VNMbInRqrU2xxtkxslxUVTQFGTkfMJqlNnw
         1SyepNB7kK/FtYeTlhbzbnrOr4abfsTbwEdmczi0AkzSHGF1MqqI92E2LX6lVtprf9V1
         xSfCpJEU5wZA4oicy6ECTE31yOdK3YBXjnhnwnRmBjTw7/ZLOndO62+oj9cZaFjAFODa
         KoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722525035; x=1723129835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bk9wanyFW6m5LYofC0MsD2q5eoNVdvtlWBG2yEhfFuI=;
        b=eRTX5Sck/9b1pAWzFLH4GrqcjPlarbt9dN6cE0rouoTG3SDP18u+4UnsRsLb3HsjZt
         +pe5pjHM4m4/Fe+iTHdGRusBcJa5eS7+Ry/1l9qmojnVvdydtx1LDz50YzsLIPLyp51z
         F5/xRc36njDb1gvWzYfAl2wIXqSz8U+KvZtvyf+X6SNuhVYX9Q3KqLi2j136rI125bJC
         ZI5yIWEnZmIwi/kViWK9Y7VvtwDGlqokIJZLaRLHX2WW0p/EoyGCmXIw+V6IOAMFyapB
         YVz858QsKr9wamEZN25wfBURptldWHIPvKraetHTfQODvX56xzdjf/2R+GXnC6gqrgAu
         QNxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYmmF4yPdKBOg2zJTg065wnVrdcG3Fm0FCV6os2d6nCodsUJOP3IJzXrqHQufUGuUGbUcxGL62Y3J5JeWh8LFhuMKWwKiiDQQIRrZ8
X-Gm-Message-State: AOJu0YysjEAZH9xv0xa9XUBhn4TFsGi+8CLKfEs8ob9Aph7K/o9IpMK9
	3BdxKWXjz6hpGa2OYYpLvrQ9E4QT2A5llmhT90Yu+0UcBSqJ5sZZGSITaVvPSGEAoXqf4xbJCwo
	Sx6fF6tpUAty0/u7bpNy+5jbLXdeTkSRB5yjt
X-Google-Smtp-Source: AGHT+IFN96aiSBpAtqABX5F3iL9KKBgYmIL3XJxYe62cmvYa3fdTiF80iFcVk3Xk8eu/mwQVgGj9rLLKcnXJyGe9m1g=
X-Received: by 2002:a05:600c:45cb:b0:426:526f:4a1f with SMTP id
 5b1f17b1804b1-428e69f4c64mr2877745e9.16.1722525034889; Thu, 01 Aug 2024
 08:10:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801000641.1882-1-dakr@kernel.org> <20240801000641.1882-18-dakr@kernel.org>
In-Reply-To: <20240801000641.1882-18-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 1 Aug 2024 17:10:22 +0200
Message-ID: <CAH5fLghO8v0wn-uCx1u_zojPLdDH_RMn4BXxLB1ZMJjfpTkbAw@mail.gmail.com>
Subject: Re: [PATCH v3 17/25] rust: alloc: implement `collect` for `IntoIter`
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, akpm@linux-foundation.org, 
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com, 
	boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, 
	zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, 
	airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 2:08=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> Currently, we can't implement `FromIterator`. There are a couple of
> issues with this trait in the kernel, namely:
>
>   - Rust's specialization feature is unstable. This prevents us to
>     optimze for the special case where `I::IntoIter` equals `Vec`'s
>     `IntoIter` type.
>   - We also can't use `I::IntoIter`'s type ID either to work around this,
>     since `FromIterator` doesn't require this type to be `'static`.
>   - `FromIterator::from_iter` does return `Self` instead of
>     `Result<Self, AllocError>`, hence we can't properly handle allocation
>     failures.
>   - Neither `Iterator::collect` nor `FromIterator::from_iter` can handle
>     additional allocation flags.
>
> Instead, provide `IntoIter::collect`, such that we can at least convert
> `IntoIter` into a `Vec` again.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

I'm not convinced a collect implementation specific to IntoIter is necessar=
y?

> +
> +        // SAFETY: `buf` points to the start of the backing buffer and `=
len` is guaranteed to be
> +        // smaller than `cap`. Depending on `alloc` this operation may s=
hrink the buffer or leaves
> +        // it as it is.
> +        ptr =3D match unsafe { A::realloc(Some(buf.cast()), layout, flag=
s) } {

Why would you shrink it? You can just keep the capacity.

Alice

