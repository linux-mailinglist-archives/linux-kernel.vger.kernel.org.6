Return-Path: <linux-kernel+bounces-291291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6AB95607E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 02:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47C721C20D3E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 00:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F10912E7E;
	Mon, 19 Aug 2024 00:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5dFYzE9"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B87D512;
	Mon, 19 Aug 2024 00:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724026644; cv=none; b=aWUapMUl3MVHiS0ei5YG4jV9zbDr69zttAYVlrsYgQEIks5db+zU+7IR008GvxJmrhOXDMjJP87szMP6PxEYq+mwvFmJTrZo37J+fLa68EyYXnCCNKwHnTNF6UP4lIWwixEQFdYcbOM9JcTXQCn4np5+/+Qvj9TDiSlDMnDUoOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724026644; c=relaxed/simple;
	bh=DvITub9vf7BDb7rAZqKY59MExun/BEU5f/3tliK3zQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wh8NgqcH71IUUG+sQf2SAmIY5NTHRq+/jdQN2BacLbU+s9+kEEdtEH9gtA0MRVD1FOsWey/gO9HKs3xqwmGBVPrCrWAadH+08e2Z88pXBSIcRckvK4kAtYg5FRk+Byxtjt4izaBSNylKxLvkNIOtXCHcdARNAVleqjbaov7UIzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5dFYzE9; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-713edc53429so377076b3a.2;
        Sun, 18 Aug 2024 17:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724026642; x=1724631442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvITub9vf7BDb7rAZqKY59MExun/BEU5f/3tliK3zQo=;
        b=A5dFYzE9umfOlsfKo7+SFqQCrK9jvD28KcL0zeQ75Har7uJ41M3VenpvjGXxgomnIr
         Fr3kWFf8NCmw22ISVY06X/v6ZGuQ6A74Qw9OVFQfB3sj5WfoDfUEkf0dWVuAZQlbP+ct
         29OwwW5owFrTFxPCoUbe+bxVIjcSHwldeJZg3zl6ivWEJNqGD1ERCn0idmsWWQIs+cD7
         RiLTTJJScsHEUWNBCjvgOE4ey+PSAOuC+ettyHVYf9VY5/be3SJulcb6k44Gjkm2NU7T
         ZzgtEK9jKpPdHbqZcCgbZwvw2hEOEZhycgUYBQYVae23Gbl3ZIzfMrO1sbndgHNUYww6
         VHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724026642; x=1724631442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DvITub9vf7BDb7rAZqKY59MExun/BEU5f/3tliK3zQo=;
        b=qy4j8Z86obHU1W+A6l1pfIHtMgOXSFHuZ7pq9cYKYPDgllbXen5vuBZbdo/wv1CqJX
         GnexrWovAo+C87qg3lecKA9+tyVo1KgIMRS2oh+pNSh7kzKKVNDcgEztWKM1DewcCglf
         L7oxQKUjoBa26H/W8gc0T/z9eLmvjxUz6rI4WPKzGKKhD7go0rUjCQU1iu0gVFBPfVif
         0D/ZpoBdOl0S4IHHwbtB6M5nfwuLPsL22eueSbqiKeOnh5AxGaIGoKsAEmCBd31ENb4/
         ESfr51kspSFPtvPju9tIpHFptxAepH1jtGRDFP09oATEFFMaSxOOkN45Do2+kW0JrKTU
         UJrg==
X-Forwarded-Encrypted: i=1; AJvYcCVsu6SsTG+PLLS45IfGr+OBpojITHpPBhRKDtdXFdtDEGbuQP2EvWyfmQvRGioPgofGglUQnnk+xaJwwfIpUEdfivNxQoq8zuDsR7hd9tos3vbCU9fJyaXe79EGGJqajrIubwDatjonUmI5N54=
X-Gm-Message-State: AOJu0Yw9kNrZQA+qdnJ3WgxZ5B4VqpU2KN6jjZVMYNwYEYjkWWHiVFoa
	qjUcsEZkyRJGsI1a/1MbFxR89zWgtgloybqvjhUGROXqVYT4CqcKvtnUk4UgVl1bo+duihAv226
	SEjPzOwvP/ogHfCqOiM1zeAufVFY=
X-Google-Smtp-Source: AGHT+IEGSGsh3Or9iR0XrfJeGk8bLn0rbToR0F5erUw9pWSVmYRClJovKPpJtRQXtFlylrOY3a98XBPcZAZw6CL4S+o=
X-Received: by 2002:a05:6a00:178c:b0:710:5825:5ba0 with SMTP id
 d2e1a72fcca58-713c4d89219mr9331298b3a.3.1724026641815; Sun, 18 Aug 2024
 17:17:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817165302.3852499-1-gary@garyguo.net> <ZsFEpjvE9osKDb3b@boqun-archlinux>
 <CANiq72k81VrS+3Skh7gfYzkcxTsGscUJOhroV4MXH-LZgroZFg@mail.gmail.com> <20240819005637.47e7045f.gary@garyguo.net>
In-Reply-To: <20240819005637.47e7045f.gary@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 19 Aug 2024 02:17:08 +0200
Message-ID: <CANiq72kGyuhthMQA7bLaVduUS08AuVf-805_e0w9_vwBp0JcGA@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: rust: auto generate rust helper exports
To: Gary Guo <gary@garyguo.net>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Dirk Behme <dirk.behme@de.bosch.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 1:56=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> It's the mistake on my patch. I noticed the exact issue while I was
> trying to rebase my helper-lto patch :)
>
> I believe that reason that it builds fine for me previously and for
> Boqun was that we didn't delete the helpers.o generated prior to
> applying the helper split patch, and we know that kbuild is not
> hermetic.

Yeah, probably it was that -- as you say, it would require a stale
`rust/helpers.o` from a build before Andreas' patch (and not just
before this patch).

> Your rebase and the fix is identical to the one I got locally, and I
> can confirm that it compiles fine for a clean build.

Thanks a lot for taking a look!

Cheers,
Miguel

