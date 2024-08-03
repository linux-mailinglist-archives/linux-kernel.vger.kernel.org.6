Return-Path: <linux-kernel+bounces-273467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF8D94699B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 14:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95622B211F3
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 12:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5501B14F11D;
	Sat,  3 Aug 2024 12:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agarotjn"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4922C847B;
	Sat,  3 Aug 2024 12:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722687875; cv=none; b=iEITb7W/LxY7PsDTo2OUdU6x/FTicmmubL920ACOYxeoZpaTtTKHoC3+qN9QmapLF31kbtjgNBOuLzxR0SwLE1nQLDQyf4SN+rMHPiU9aB8KbDthsVKzF6K4qTFRnL8Jn8la/TvFxuJkT/7OLe4feCGzn1mnBOnZJrZlLYhpcu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722687875; c=relaxed/simple;
	bh=O0msGMJ7PYF8d1H0sIT6opYv3wNUCSuOtn1nql9khwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHfO/TcqyP82u3HtgIDpig4ZxYaguCjdmZIV3BW1+q6c8wkbKZW6b1dmLHVO77v9qf58u+ZYkNLZJ4inAMtKgRLNxCRPrJY+dNwDzeLEj+9OuDtQJ4QhW0yJq4tmTIMKq2VdGKxllLZurde9VSQ8a9zA/gTZa+RiVcONaKwMHMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agarotjn; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2cdadce1a57so6179587a91.2;
        Sat, 03 Aug 2024 05:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722687873; x=1723292673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0msGMJ7PYF8d1H0sIT6opYv3wNUCSuOtn1nql9khwo=;
        b=agarotjnYsdA7N9QnKbMwfK236q83Z5qR8kpGOH1SNhna2tlEhwbNdx3UKMLIYrdU7
         mDk2HPQJ+Dl3xG07xs9UVZSf438N1k/Mc7U3kZjSorsQcWcmY7N/NIrsOA19qObEJbgi
         4+eXYK9nVnfX0wcVXkADxfnsM+Vh1flq+bZHaevy0gffKEgFxfYAbrzYnGG9Yo5lsvQu
         eQ4I3Ha0A/85ZmtHa6vd51QTTMgfRJgyhShHLr1km5WvZBxLvXtk1o0jFZzs2BDs4J1F
         yRu+c/VkEJRsHun9iUQa65kx5HIPx5Zj3ch5QjcFsvguX/SeIOhetif9kuQK/XEDrVJl
         nGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722687873; x=1723292673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0msGMJ7PYF8d1H0sIT6opYv3wNUCSuOtn1nql9khwo=;
        b=S37U4tbQUee07UTPLfgQdJMSKj6pmCg+WLjNjvtusg1Khch9RtpyjVmr4nOj9Z6BsE
         SLU0LdXDWKblERBzgpbw08AuHk1DBQiuYYq84f5aOxPL86sZ9El6TPpdPc1SYEMl1+Gj
         zlu5++NFP+iYJTIus6rzQCzzJ/9r0Uk2xg/v/wZe5mLq9s1fTVu7u6syczsv94trrUX2
         1SJ/KpIP/jOUjT1rXrxMynONguC5kixPBVE4gcm/S7b4GM+uyQ6CK09ABOSRTw93mt5p
         QFJ/jNyEOyfT9uRWu/+L1OvUvX9tSW3zzKKAymyA4mj2DtB53UHgK1C2bZVeLUYZi6hq
         1SOA==
X-Forwarded-Encrypted: i=1; AJvYcCXaHbSOH9ugVh8YwiPyH/foFoJ0gx8TFxe1JSXmPlCh7aQrmpOKWEJYBDl+LJ3PIG3Z+cIS9CJREHRIMW1egFxp6NUpjFXTW8zP/gJOKdMVM2mfG0sFLITfHTQxwipUE9a1FnWnjkxMsmgXM58=
X-Gm-Message-State: AOJu0YykzGXpW6qV7pjEYXwJlQW9HaoFefP1dWLTe2nhhn9mHE66QytL
	eQw25w+FQe/tiCHhwMICLBwKh5gQBZjHATxAN/lj2NAvmNx4wt+Xqi0yedg1g2M9KRT8njnBicA
	cohRz8BAujFQPFiTUbuz0S/PFNug=
X-Google-Smtp-Source: AGHT+IHCgvjwsL2HXZmMiQhYso+tTERYAcqux3qOuPROp0PNIGsCeN+l2cn5VCWAER4aUeqSIQ3qLoQNV2g6p7obY8o=
X-Received: by 2002:a17:90a:fa11:b0:2c8:538d:95b7 with SMTP id
 98e67ed59e1d1-2cff9547cb3mr6767194a91.32.1722687873458; Sat, 03 Aug 2024
 05:24:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711-b4-rbtree-v6-0-14bef1a8cdba@google.com>
 <20240711-b4-rbtree-v6-1-14bef1a8cdba@google.com> <20240731210206.2b56b432.gary@garyguo.net>
 <52cc1987-ec62-46dd-9d81-4afc155fe88f@proton.me>
In-Reply-To: <52cc1987-ec62-46dd-9d81-4afc155fe88f@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 3 Aug 2024 14:24:21 +0200
Message-ID: <CANiq72n_v76yMFJwy8S+Akf6T8hOM-JGwP_WUKEdiNvo371NfQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] rust: kernel: add `drop_contents` to `BoxExt`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Gary Guo <gary@garyguo.net>, Matt Gilbride <mattgilbride@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>, Rob Landley <rob@landley.net>, 
	Davidlohr Bueso <dave@stgolabs.net>, Michel Lespinasse <michel@lespinasse.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 10:47=E2=80=AFPM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> Note that the newest version of this patch can be found at [1]. I agree,
> it should probably take `this: Self` instead of a `self` receiver.
>
> @Miguel, do you think I should send a new version with that change?

You mean with `this` + Boqun's feedback there fixed? Yeah, if you have
a moment, that would be nice. Thanks!

Cheers,
Miguel

