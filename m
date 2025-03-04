Return-Path: <linux-kernel+bounces-545666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA1FA4EFD8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76F213AC34C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B06F266B77;
	Tue,  4 Mar 2025 22:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FIz0gpB1"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538711FBC98
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 22:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741125893; cv=none; b=H+j0WWty3JqRuJ1/QrXT/cO2F50NAhIVqap6wrhP/upHBjbErdxo1jRpLFM3BBQTj0ElDu+D/VpjrZCRvH4qjW5um4dCCYQwgx+L2sMW+sGOGDaQcZz20JiZa+2cC23fld/3gGGrXXJwdMHvZvU4+Ur/2aJaQDCFpcmAy8OMLyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741125893; c=relaxed/simple;
	bh=TC4cgMsPXlqLN0bRWCQ3mDHh/XYPnoGk/mZglndqOTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FcN+0dzaVH8OjVk8WhiOuRaWRvJtW1tVyn6ANrIavMotnrUA8G5lFmNOPlcvXyvYDRGyjVEJICf6Cc4DzrUUfq1ZlVgVEWi5UUaNNf4k4dvDr06/K5FXpj8zvuVjMHE3gK8Y7erVuBwhIoR1+2xOu/cECX/JpFLBjIBS6ZyAUNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FIz0gpB1; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e5372a2fbddso4338465276.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 14:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741125891; x=1741730691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGYM825COeY4cDgaQz2uYAo42uyksoN4eaWbp06R+Lo=;
        b=FIz0gpB1VZEdS8WwBOjNdMMyr0ra1gVjdJLaGGLOJOqK1P54HykCPrGPnazZTfv+I6
         jY98UEd6KcBBuyHQZ/V7fvyAiUz6HNla7zGGt3rKRv5I9zlHTRklHJatYL0XNQbgF6D1
         2zOqB+c6QfOOa4gkKfxy2hjAign/DIZxKBrlG0qNWodth8N8M17xzaRYjsQZ7YqaqJPU
         IuVPT2JMaZqIY1+egY38z1vgv1rK2u5MXM7og7YaveiSODMZp87JksFk+eWVVLvH+MBP
         i4cTmhM6bjqmh7yHQBfafWu3p/dkanoAhn9r5u4T1RzZLMiyRrILdCGtMZ6FLsjjuAhT
         sVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741125891; x=1741730691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGYM825COeY4cDgaQz2uYAo42uyksoN4eaWbp06R+Lo=;
        b=GBAVKnuRRTK32RxXd04+8efqB/RcqQte408RHlghxGmMM74zAmW14go5VIMtLQN4Xu
         qpYFvQr/rlA3vbegioL1xnd7XqRRBJzZ61SV1oAMbrguKYQRsHovDv+2g/mbFLOzuAd1
         sv2TMQpTCGCjagRM9UajKdNEn2EcHfvMDdmfBiUUyTCVKHjPSJVYDFXtkgqloiD4So0c
         x5lH44qtkqFbe897V2GQZsfnbYqJ5z0bbznieVsbZD7JTyQfcsYfUCo3yXWrXUVX/0/9
         GJk0BgTmTeRU4wRJtNh2MffYOzbm2HLhnIcFQS1o3NajyVCN5iVwReFfZEAowFpPqWWK
         pKLg==
X-Forwarded-Encrypted: i=1; AJvYcCXyd9xx7E0lM53ju1EPBabNXORceXS9dDG77jOHOtbaQ5RqHMiVp1FyYDjtwvzzxy1uICgH8HV3lSyjEGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfxEUJj66h4sae7xN79pP9KEyRLZVVJU9K3hUYxtf4B8uliR3b
	OeTGgxNzZ22/h7fZgzTd1snUKLu6ATGBNkBqghrU3OW8PQt1LU8DFMnDJEON+RtiqADNA2bXpkw
	DgRKs4iLl5eVz6IEiJf9YuGE9cPcAvie2GjNx
X-Gm-Gg: ASbGncvFAqXXwCEzuu/Ymg6Dl7o+uVVeZPutkF7hZmd1c8I9NXpQjp4rjSH6JDY39Me
	4ZyPjK42AdMBte8ceg/Lga/hlUoLPbZdAM3ftkiU6KspLYTR7vKhMD84d4JMXvwKjtAt3JZvPeP
	gysTpa1qOnNmo68Msv5M6JD0/S9A==
X-Google-Smtp-Source: AGHT+IFulQ7LgzvyFb3/gdh8eB9ie1deJisxgjmyOD1UvKi+UT64a2qzLysIF+yMVnVpF5MLVUeEs4rDh0zS9aY9ju4=
X-Received: by 2002:a05:6902:2407:b0:e60:87a0:6216 with SMTP id
 3f1490d57ef6-e611e1cf5fcmr1341862276.5.1741125891325; Tue, 04 Mar 2025
 14:04:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303-inline-securityctx-v1-1-fb7b9b641fdf@google.com>
 <CAHC9VhSo3aGsJVd=a3MTeakgU66oTN86oh5sZE8P4ghSk8Rx2g@mail.gmail.com> <CAH5fLgi6ZFBqtyUuGPbdST-tEzHJ=Wp1khDxQhO_h+bZiFVj8g@mail.gmail.com>
In-Reply-To: <CAH5fLgi6ZFBqtyUuGPbdST-tEzHJ=Wp1khDxQhO_h+bZiFVj8g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 4 Mar 2025 17:04:40 -0500
X-Gm-Features: AQ5f1JqWP2T9LLdIaTLM2jPEYtQYSDndqPtWBU1S0MWmqJHMHH9IUg70OKKJ0Vo
Message-ID: <CAHC9VhTOug3WGh3MdMQs4VxDW=-q6aP7DF5raDXv40S3iP6euQ@mail.gmail.com>
Subject: Re: [PATCH] lsm: rust: mark SecurityCtx methods inline
To: Alice Ryhl <aliceryhl@google.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 5:37=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> Regarding the other patch for "Credential", is your tree also the
> correct place for that? It's a bit unclear to me which tree maintains
> credentials.

Unfortunately, the cred code seems to be a bit of an orphan with no
clear mailing list or maintainer listed in the MAINTAINERS file.  I've
merged cred related patches in the past that have been rotting on the
mailing lists, and Linus has accepted them; I can do the same here.

I'll probably also toss out a RFC patch to volunteer for the cred
maintainer job, if nothing else having an explicit cred mainainter
entry should help clarify things for people who want to submit code
and don't know where.

--=20
paul-moore.com

