Return-Path: <linux-kernel+bounces-346598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEE398C687
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 22:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96C9A1F2512F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9021A1CEAB4;
	Tue,  1 Oct 2024 20:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHCaeVgY"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232821CDFBE;
	Tue,  1 Oct 2024 20:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727813440; cv=none; b=aGq5C/dFeAoZl65G/aDgZzcLKSNryIA1aB51NN4MQbiaTq/sMnYDWmnN70YZa/wGOpTo6LeEAxlrbzHWiHqV9ock2zVCqbOuaWuy+VZ7b6/BwOMH8VHDs9JKP2bWUO1uuGFQAlZNfaCCWYxjLj0bC7dPVQcdyqDussWVSl5mazA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727813440; c=relaxed/simple;
	bh=kYoy/bMd8xJK/HDyrM7sBCBrw1B9vPKyP8cEGp8fmI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcwF0yDNSQXjQ+egASUJ3uUg25x+X+54MoTjOAi+C/KHSNM/fzqzCmptpgtPSgeq8nDnWV6xlJFxrlupVTFnjbh2i7TJAUvHiUtL3vh6TYjt1cazAQHwrUGds2lWtmqLnkg6q3J2K1YsHEjCNBUwT/2eimt+osUKhbTFcaFcj0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHCaeVgY; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71797e61d43so284454b3a.2;
        Tue, 01 Oct 2024 13:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727813437; x=1728418237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGVulOrDpVkAQcbZN4VP65YN6nxFMIm3dGc0Up0BqtM=;
        b=iHCaeVgYQupMJxnHh7ug9MM7h2J35MOWc9ET6SJ9vwhiolDET0SIwjM1mtL8j7dhBQ
         AUJOM4HQqpwY4Oxlms52s7s8AFaLAcIKxME25jK1wZAs6WT2+sodWut2vhLGzymYPe4/
         lg5dPGwlqENAhHiJFoBq0MJjVJzv6TrYu6YiQQNHBEpZDAWiEko/La7bjnNkBgQ8ZpNZ
         U7I+w+c/K3gTKdawsZ22/cV8JoB8lQyrTS/JhQ72y/r9Zfhv2PY8BW5oAd6tR8blW8NH
         durErRYC1i/tZLOMT8Dq6aQT1+vnfl8dlpecAaxGIXyuVHx3GApIiLS9/Y5Ghg/7IwFk
         NQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727813437; x=1728418237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGVulOrDpVkAQcbZN4VP65YN6nxFMIm3dGc0Up0BqtM=;
        b=PYnRsSQjBkpNy9gEWSsA4ElGlLjsHO/1dFQyxagHYF/i9hiQuL5UMGDykLHpXZc9YU
         KXKUbxfj3G5adNWBN7UW0w7Nsd11qMpFVhSK0qxyMG6TJZbaTMEdYYiubdGkTYStjiRP
         +Q93cMhQ/tqR2JEqN3xafFZJrkubapRDDcSCYkXf9Sxbi6OtyINSuwfV/zVhCKfp4oAh
         RBE/I/pWKK+ptOwNN3I6vPbsJhqC9+DEmUY3FhU5ggm4lc5iCDWwgpMQjw0i5BZdITbD
         g5Ccxj49Al5BJxB1mOwnqExRAsDkT/852V5pVWMjsidFxf8ZFE3bI4dLdA/oPEtSh4S3
         KYIg==
X-Forwarded-Encrypted: i=1; AJvYcCUX3/ELl1qS/RSuJP29MTykJDKZuTNxCFglkHi3lUeLBrfwg3SWkYiD7K6LLUnm7KnD0Fdlpc+8F+d6hk98@vger.kernel.org, AJvYcCUXASWaQ/ez2w7FVM/IFNDwntvnzAqU9wo6GfSeXF06nkx3LDYUrj7pE5CKlC+9PRz2k6t3hs6ZRrk=@vger.kernel.org, AJvYcCXGuwyHOJ9HSFHT53OPTyrkDwXXd9E5SaeqsIxXtJpOHsLn2936QzB/B5GToSi+mmhRKCOBeV8uoDSXzee+lDw=@vger.kernel.org, AJvYcCXvBk8wVFmht94svDNQvZc0BfNNM1dHF1yQgY8eGpMpVRJbAMSW+9QTtud6cJqP45AVkvJkYQZnuaoP@vger.kernel.org
X-Gm-Message-State: AOJu0YySda31UVHswO+LZasiAJFn79SYt8EsxQ+RbgBSMqs+k3P4ev0J
	1yYQZtC2Et5jq66KK7u2nN/yltgsTF7CRxCUbtp7fOdn95vNTAeVVbsqSBEur4YUB8LzEP7AmRr
	ZZmr/d4AT+3c7SbRxaGApTMEWiSo=
X-Google-Smtp-Source: AGHT+IHe4cKDdHANdRNDm2TbpCihzt1NUCN01E7a+72PsxqWx9wAfuXjuHQOo7cfvTqVtYQhjg9c3FrJ6b7M6dZiStE=
X-Received: by 2002:a05:6a20:7483:b0:1cf:4dc7:e4fc with SMTP id
 adf61e73a8af0-1d5db121f1amr761477637.2.1727813437289; Tue, 01 Oct 2024
 13:10:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922160411.274949-1-carlos.bilbao.osdev@gmail.com>
In-Reply-To: <20240922160411.274949-1-carlos.bilbao.osdev@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 1 Oct 2024 22:10:24 +0200
Message-ID: <CANiq72=MnCfj_y_dSPZ4Mwyxq1WnuPmw-FQ0H8THLS6kZ8fNOA@mail.gmail.com>
Subject: Re: [PATCH v3] kernel-docs: Add new section for Rust learning materials
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Cc: corbet@lwn.net, ojeda@kernel.org, dirk.behme@de.bosch.com, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, bilbao@vt.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 22, 2024 at 6:04=E2=80=AFPM Carlos Bilbao
<carlos.bilbao.osdev@gmail.com> wrote:
>
> +   * Title: **Experiment: Improving the Rust Book**
> +
> +      :Author: Cognitive Engineering Lab at Brown University
> +      :URL: https://rust-book.cs.brown.edu/
> +      :Date: Accessed Sep 22 2024
> +      :Keywords: rust, blog.
> +      :Description: From the website: "The goal of this experiment is to
> +        evaluate and improve the content of the Rust Book to help people
> +        learn Rust more effectively.".

Perhaps this could go closer to the Rust book entry since it is a variant o=
f it.

Or are these sorted in a particular way?

> +   * Title: **Opsem-team** (repository)
> +
> +      :Author: Operational semantics team
> +      :URL: https://github.com/rust-lang/opsem-team/tree/main

Nit: I think you can remove the `/tree/main` part of the URL to simplify.

> +      :Date: Accessed Sep 22 2024

Since these are repositories, and elsewhere you say "rolling version",
should that one have a concrete date, or should some of these ones
have a rolling date too?

One more that I remembered and that we could have here if we have
other videos/podcasts/... is Crust of Rust (and probably the book from
the same author).

In any case, I think it looks good, thanks!

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel

