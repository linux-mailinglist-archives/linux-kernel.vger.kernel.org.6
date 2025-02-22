Return-Path: <linux-kernel+bounces-527185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFEBA40835
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 13:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23DA470537F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 12:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3446120AF6D;
	Sat, 22 Feb 2025 12:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeoKiIU7"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A22B20A5D1;
	Sat, 22 Feb 2025 12:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740226253; cv=none; b=mWnl987ERA2DffuEZIKHmQE4p9OXsZ0yICO1VJnM3xZefcNsFgsishlXNXl4wV8QUjL6Jw64lay32mAH4B/VPrbGvWNSGihPXxBl+jdRgwB6zuciYncOQsilwvtm/1N3KFvBPcJ41fb/5qiPmmHhpy6utRqaEj2Iq0tidqQiVzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740226253; c=relaxed/simple;
	bh=MgvWp2fU8cRSYuXc3PLqXYyNhfOEr9R2ZsHvwZiMKxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KyHgSfXKaobfMMAa+AaIUwwnKCYSI5V+IutQMpj0IzrNjPAMJGlLPsZsBncvtfYRF3jGwMlNZJ5LWk65nRLd91ide7nMwaD8NWl+BU2VolavWGuh61LEkF2xQ7aYIJKgWjgZbfTxJkWulyXviqx5W3K4esF05s+7DVGZft/lVLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MeoKiIU7; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fbfa7100b0so719086a91.0;
        Sat, 22 Feb 2025 04:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740226251; x=1740831051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgvWp2fU8cRSYuXc3PLqXYyNhfOEr9R2ZsHvwZiMKxM=;
        b=MeoKiIU7nFQSQhTM8atBXbEnhqaD8K9XEXLIMEIq80ZOGy6+SY9aN+2CnkgLYYDv/w
         w6KYOULFCtjs1Hnxochu4mw1BtaAGWfKVPNR5tSq9tqnxtsjV/1fE8Llh/7pwvop96sR
         WCWQ0EfsvjTq8Lg1ktILK50nwUrtmPOzEJ45GcFASgXH46aFwsSkFxo/1GUf6mGOs5gf
         z2HCjEu6RKlJegCO4T0Gm5oGuRgGvEwW2JcjETdFkXjA7ttFQd3vpVqVm8F3LXnkbQIv
         QGiCJ/X3hrLKb9AK2T6gPzXD0GMxeoiFm7jxt62Goq5SJrAfp4e6NBBytu2omT/E9utZ
         cW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740226251; x=1740831051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgvWp2fU8cRSYuXc3PLqXYyNhfOEr9R2ZsHvwZiMKxM=;
        b=YHF+meQ1UMsgIn0eHjc+YSREEODsEV+tQbyLtYJdgm65hpaalmlXEiej2R+NUxRXUz
         iQtyeuP9fnA5Gi+X2Jaa/BkaLXv/R+xI8McCKSHJXqr2s5BmcQmJML+KBcBKCUdwpBwo
         1doT2/PMpT9pOYmHkeL1B/C7gQnUviRQ0myf3Zs32kNpCFIRugxHlbFXb7OzksUGGRWg
         h7yRBfxypBvvnxiWQ7NgyJHfFFnBObdKOVk7XqD5JPs0vwYUxPenYPJGBZF5lMjU54JX
         MNdrOxS2Gk0/9Fm4jWnDDDh05j2n3lL+MbBWcKU6JTp245piTnh8JKmS2jNLcSKtru2c
         GUhg==
X-Forwarded-Encrypted: i=1; AJvYcCUgml3XfNTuUqkBRO6txxuQU/7o5d2w2hztZyu1B+Jxbus2e5gr9u+BHLY0NxV5TXlxPYWZo/z2dm3z7Ds=@vger.kernel.org, AJvYcCX5lW8LBlBZUnQRL391FMQJ8nTmd5MiATcseyaepy9uzgGx20v+0hL3DYob8TvdQ4ef+koO77x09lAmIwVy5uU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynaxc4rlgoHH/hUtESczsbmXKD+IIF0rLWl2jcecXdi73CdQez
	lVmjSbkehqBzArg6byXqMrykFj/VNGltGZXtwcv+uplo1Jog0VobzEAe1NvO+PhscDonOkpDyxH
	LXI+YJNo4sU5vCd7uga7WLYvvT7PnGu9EZ8Y=
X-Gm-Gg: ASbGncsKCclR+S/dLWmwBL7zmwQZrsQkwoXubaIDyfKwX2WbnktYx1onhoN8B05Gsgw
	bfUIWMqk98p4jB3+8uaTceSoKSTijbYMsoSMpT4g0uPRSeW9H1wXQt9vVhiEuT9Wiocg9g0eG4w
	SnQAFcIwA=
X-Google-Smtp-Source: AGHT+IF0pyohXYCjYhyyxWf9CDhgHe5H/cXs7TEy1INGL4P3qixwcQboYbY0lqUxFL9jjIUW/3DYIbAIk5t8CWKtqk4=
X-Received: by 2002:a17:90b:164e:b0:2ea:c2d3:a079 with SMTP id
 98e67ed59e1d1-2fce7b3e1e6mr4177023a91.3.1740226251391; Sat, 22 Feb 2025
 04:10:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <202502191026.8B6FD47A1@keescook> <20250219140821.27fa1e8a@gandalf.local.home>
 <202502191117.8E1BCD4615@keescook> <20250219202751.GA42073@nvidia.com>
 <20250219154610.30dc6223@gandalf.local.home> <97841173-1de8-4221-8bf3-3470a5ac98a7@acm.org>
 <89f2547edcaaba53d9965cab9133d809607330ac.camel@kernel.org>
 <87pljc6d7s.fsf@kloenk.dev> <Z7c3PguDn-sEl3gm@kernel.org> <Z7hTLsaqNU0rlpwV@kernel.org>
In-Reply-To: <Z7hTLsaqNU0rlpwV@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 22 Feb 2025 13:10:38 +0100
X-Gm-Features: AWEUYZnFMbcXcM_cmwCNu3bqG_ZObq6D9dYTD1hB0D8fCjGqpA9knVhUl4gNSrg
Message-ID: <CANiq72=p436WBxwebWsEb2Quq0=V4NLMdxRDopM1zrcykk-uzg@mail.gmail.com>
Subject: Re: Rust kernel policy
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Fiona Behrens <me@kloenk.dev>, Bart Van Assche <bvanassche@acm.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Jason Gunthorpe <jgg@nvidia.com>, Kees Cook <kees@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, rust-for-linux <rust-for-linux@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>, 
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 9:14=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> The reality of actual kernel development is that you almost never
> compile/run host-to-host, rendering that part of the documentation
> in the battlefield next to useless.
>
> Instead it should have instructions for BuildRoot, Yocto and
> perhaps NixOS (via podman). It should really explain this instead
> of dnf/apt-get etc.

We need to keep the package manager instructions -- there are
developers that use them, and we were explicitly told to add them. So
we cannot remove them.

And, anyway, that documentation is useful to know how to install the
toolchain in other systems/runners/... that use those
packages/containers/binaries.

As for projects like Buildroot, I think it would be ideal to get the
support (or the docs) into them, rather than in the kernel side (plus
I don't see them mentioned in Doc/).

Cheers,
Miguel

