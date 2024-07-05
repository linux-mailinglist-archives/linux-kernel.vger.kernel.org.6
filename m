Return-Path: <linux-kernel+bounces-242358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0823E928711
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C729B25A1D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B98D14882A;
	Fri,  5 Jul 2024 10:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlezHObB"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4691442F6;
	Fri,  5 Jul 2024 10:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720176649; cv=none; b=lEC3qBdWXn4Xkw8QEZ9Ig3Trut8bLpE2YgHhrBxJDEB3rgGMcCoCkA2H5IkXqIQVcHHRd9Y41Hw8K2yDk1g27iARREy9Z3LUPGVWraDq8v1VDhFQCtP254lYvdIFB1RCX97OXXDELy5tM4lmsqMcyrXRdX4xAiKA76XLFNIyLg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720176649; c=relaxed/simple;
	bh=mazd6SlQGoT23PxSsQCYr3vhjvCyYL5J03ptC8NDxKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d6/rxFoMcekKt/W8REf4ooWpCyoh+Bi2gi154izXPpy4wEJCGyAed+xb6FM/SACzFe3SAqgUHmFyZ+ngXsMDnP/3CCrSFznjUUnpR3CDTL7jZRuT5QmYAugMl9fwn/En7D7AnmdSQzDDJ5Y7GyjAhZPAIOM3WsBjGRFxbzBHJfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlezHObB; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2c967e21888so1031505a91.1;
        Fri, 05 Jul 2024 03:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720176647; x=1720781447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mazd6SlQGoT23PxSsQCYr3vhjvCyYL5J03ptC8NDxKc=;
        b=RlezHObBXV3tRrKtR6sZAg+CxfCtPDcCJYtm1Dym6EB/qdnU0ftgEs7TdjyD23QpNe
         7E6YwcXfpiYydCCoeWynT1tg0gYZl7gR+WRw9sRnk7lUcMGDat07tuMYzOoMBKKdGT9q
         vrfy+T4Q3jz19oXK3BnTH3DutOJYPBO1HJWgRxgV5MYQ5iX+I4ZPcsOKTWnEeK5vptX3
         OhCErv8bMaNVF6Rg0G9RrlkdhZJGWeAII7TowypfSyaEBt6h5nkagYnS58ANij3VW2HV
         3RQKQ0CfKd0JmyL4fCDVT23Gncuk2NjlDD9NS4ISzizCo5vokinRqzFiSEnrZ7G4N3Vq
         Wbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720176647; x=1720781447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mazd6SlQGoT23PxSsQCYr3vhjvCyYL5J03ptC8NDxKc=;
        b=FmaqsZF8ynpAdyq3JUlOgJMictrtD7GdtKU4jdtedpd/5UjnGmQyhtNVwm0uK2VgHg
         CNvHk9FLkLofBIaPjPHcLXBSU0DvatS9ulTzM0+bNK3jKqU0yhHSv6hMg+EEGKgvBptj
         CXXOY/uLMEH2dJDgk32qf22C4Jh3wDBO0FcbL59khy7vtvLUf67SDbZbZMEwq7bhiE08
         3o4aJC4OoPRXblM4XiTNAc+dcqsHGjBBdtp6V1Twu+Fq6RVsMOA+cp3cndq6Igd33X8X
         ylhkF6WaGpiV8jY6bPgSAN1Dy+B+b85MQBsb1ucqc6qH3u3PRWxtndfoEwrTqJSHbLzR
         HzUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmNxUkcpDYLWuM3zhmH6Y1v3lFE9+7k34sHnHDYj5vETlL9O/OKfSJX2mNsmpyl27Vn81z15KWXkYSCM7dgz2Q/x7LlEWSv3seE/9zcTazsnJwt5OBB2OWQuqnqXzCBMP7z5g3LU89guvzfGdTPloJqRw9aGQh5wr+nS8iAq/bTvoR1ofJ2KH9Madvlhi6ezgUcmZrcbgfajQLwdk4eJhj7Go=
X-Gm-Message-State: AOJu0Yw1AkMS6WmTRFJNpUXrPX7aG4XjgrPKPbAmMAY/RdFXkdWS+1S1
	3lVnkUeTRGqYjz9MapNxR3zM1L5Wv23rdWpXqDVKB+GAbsxIgBhhGRf2RqkhSbs7Vn0OBgLFIa2
	0f9JIlpLXL0wKUaK9khnJgBTC8sI=
X-Google-Smtp-Source: AGHT+IHrLSGcmR0Qvqbpf7FgUVqM+8MTahzuf5TtCI/rZDagwTn9kJDSpqaExb+OjYYeAL9Q9cwiQ0mvi6kNes3PHWU=
X-Received: by 2002:a17:90a:e005:b0:2c7:e24d:f695 with SMTP id
 98e67ed59e1d1-2c99c53b396mr3069966a91.12.1720176647373; Fri, 05 Jul 2024
 03:50:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701183625.665574-1-ojeda@kernel.org> <20240701183625.665574-14-ojeda@kernel.org>
 <ZoeQVYda-AZN6PYy@gpd>
In-Reply-To: <ZoeQVYda-AZN6PYy@gpd>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 5 Jul 2024 12:50:35 +0200
Message-ID: <CANiq72==+YBoQDBwEVuncY+ygeTkQPEbK00yBCPN3YWVk1L9XA@mail.gmail.com>
Subject: Re: [PATCH 13/13] docs: rust: quick-start: add section on Linux distributions
To: Andrea Righi <righi.andrea@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	Jan Alexander Steffens <heftig@archlinux.org>, =?UTF-8?Q?Johannes_L=C3=B6thberg?= <johannes@kyriasis.com>, 
	=?UTF-8?Q?Fabian_Gr=C3=BCnbichler?= <debian@fabian.gruenbichler.email>, 
	Josh Stone <jistone@redhat.com>, Randy Barlow <randy@electronsweatshop.com>, 
	Anna Figueiredo Gomes <navi@vlhl.dev>, Matoro Mahri <matoro_gentoo@matoro.tk>, 
	Ryan Scheel <ryan.havvy@gmail.com>, figsoda <figsoda@pm.me>, 
	=?UTF-8?Q?J=C3=B6rg_Thalheim?= <joerg@thalheim.io>, 
	Theodore Ni <43ngvg@masqt.com>, Winter <nixos@winter.cafe>, William Brown <wbrown@suse.de>, 
	Xiaoguang Wang <xiaoguang.wang@suse.com>, Zixing Liu <zixing.liu@canonical.com>, 
	Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 8:19=E2=80=AFAM Andrea Righi <righi.andrea@gmail.com=
> wrote:
>
> This implicitly covers Ubuntu, since packages are sync'ed with Debian.

Do you mean the names (i.e. command) is the same, or that the newer
versions from e.g. Sid can be used in Ubuntu? If the latter, that
would be definitely worth adding, yeah -- is that supported / expected
to work?

> In addition to that Ubuntu also provides versioned packages (such as
> rustc-1.74, bindgen-0.65, etc.), so in case of special requirements
> (e.g., older kernels) users should be able to install the required
> version(s) using the packages provided by the distro.
>
> Maybe it's worth mentioning as a little note, so that users are aware of
> these extra packages.

I thought about adding a section for Ubuntu to mention those -- so far
I only added the distributions/commands that were likely to work with
the versions supported by the kernel, with the idea of expand later as
time passes. So I didn't add the versioned ones since the latest is
1.76, so it wouldn't work for the current kernel.

But it may be useful to state it nevertheless, since some people may
only look at the latest docs. (Or perhaps Ubuntu can add Rust 1.79? :)

Thanks!

Cheers,
Miguel

