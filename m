Return-Path: <linux-kernel+bounces-524922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 509D4A3E8BB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277C4188FC0F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BB5267B06;
	Thu, 20 Feb 2025 23:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJbJ+9dj"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B151266EF8;
	Thu, 20 Feb 2025 23:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740095087; cv=none; b=Rb2RwEt2g7q5hSPw65cSD+Ipkqa7/QRYNaxKRosJ3ibtdYlXblvythUtB8TWHk7AOMceKv/Mt1Ouk6kkfmPi5ctMhREd8V+iwT4AWsYVwgbuHtZt3gr/baRR063mwuZjJOmsVX74SiSuhZdJgQQv/iOHk9tgvmoIEVXItFnBSEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740095087; c=relaxed/simple;
	bh=p00AG8bb1yVHeSE4ONGqOFF7r1nxk9J2l+7gvdoptGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G7Zp/cjSr5H5moBLxhPNrKQjddvCpWQ3hkPkdtHj4ZezSpowDUJaNdw5t59h3dfTTanAb8fj6EoWHXBp3uCSGVP3YUsaYh/p1GgGY4CmZkOFDjS3siNEMczp10FJHoj771KP7x3//DA3S1mctlbr/Zs0N7J+s4vo6WgTQOMoRAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJbJ+9dj; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f8f3bd828so3262895ad.2;
        Thu, 20 Feb 2025 15:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740095084; x=1740699884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hn5iQRJJBpnIS5VFzOOZKeekFoHGdGnyvULucCmT0Ik=;
        b=gJbJ+9djxh15Trqi2tbPo7gt7kw7FKC+F5+q8CBjkP/IQ9keFu0la7f9l+ueyV89qX
         Dr/NdVjop8OtX5CzAYny3Igo0gXeC4GlhHqbpwYwQg+NPzCrE1cLYP+AHc3JXzI7hGXA
         3zhvjcgdak2xOoX0C5GTUXEC5Ovr6ELoFEuz0jH8Bf9Rjxv0d+DZujDorT7DE7KyUy8N
         lVcQMoJDPs2YlR0hEUNhIYamZBtWXaitj65nZT1JNmCuYkcJMq+zuZ4/vTHEEUafKK5U
         RV+xx7i4TqtqCvt+UquyDpuIfAq+4cGmmXPsoMPjGHmCU5CfgHFK4b1DvNdRc3RBZl0c
         tupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740095084; x=1740699884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hn5iQRJJBpnIS5VFzOOZKeekFoHGdGnyvULucCmT0Ik=;
        b=RvCCSOFmsXhj/4w6J2YIYjHoOpGz71qpVfuPrgte6gPwG0gDkoJbd0k3E87KvmIEmF
         l/a3IErtazvquUj54TrHov8eyIXWIYWolRGfBee3S7MeE/o1jKwSNq3sIGciznCy+pBW
         v6SNg9fudWZ4F06jLo1pnWKOFXxKzqAGxdeTAP/D56rGZA8tswESufi3g9aDAlL6Rs4x
         dXsTi5n03UoHN93ixvCnqXRKP0A2TSbslc0Bpkb9zd3fIeMiVHzs7qZGSdQq3Ij0IHsQ
         sAf+HH+kW3fYi83FGnwus7Pj2/+sQsSIzSLvuS7Sp2d+HZzR9MAjxA8b+GTcNQRBEJKX
         eWcw==
X-Forwarded-Encrypted: i=1; AJvYcCUk7SgKH6vS6uGoYWhL+skjHN0ovHV3OymfQbSgQr1Cr5ziRJwN3bBw64DZ5dpLbZVTBc/RdRVXo5IAurk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbmK6tJCXXuCWdjQmGlg7NYz+0T7beFzE3tJbOg8aAqElpqa/u
	93PhwJU1DI3nMcrSMYyD3nFz2Vy6y5ZO1rJU0mlsdwcI+/V0FDgZ4TsQDgBG3LT+NwlDLUkD+M1
	+yZYQuUbyJjgkoeQ/RVhlnz9M55q1pQ==
X-Gm-Gg: ASbGncsuTVbGfTLXyc5bFVeWUbzxhTPHgl88hNdCJ9k+JXM7OpUY3/SPGAQAtD2+4LQ
	jB+KDu6zOLIp9KFICxzPjyaH466NYDBSs07bjcWhz1jS3WdPL6C2WEbDdkxUKtiFhDTgOwc8X
X-Google-Smtp-Source: AGHT+IFi42zHhjoXqgp2VJV5UD9ZMLdptjHa6YtswidMLbIEzZlA8M5+VHRc79Edc/ZpLIQv1bBz3S+cowB7tCn8awk=
X-Received: by 2002:a17:902:f685:b0:21f:dd1:8353 with SMTP id
 d9443c01a7336-2219ff393b1mr6017295ad.1.1740095084241; Thu, 20 Feb 2025
 15:44:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org> <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <Z7bO1jT2onZFZwgH@infradead.org>
In-Reply-To: <Z7bO1jT2onZFZwgH@infradead.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 21 Feb 2025 00:44:31 +0100
X-Gm-Features: AWEUYZmw8_u4Q_PaeJFgOsKd1yASO000wE_QBM8X9fEXhJh2_2pG9D73gOtuC4U
Message-ID: <CANiq72mM3tVmT6MQZqpzGEW4hJABVHRiODL0SnP2u+0ES4=pjw@mail.gmail.com>
Subject: Re: Rust kernel policy
To: Christoph Hellwig <hch@infradead.org>
Cc: rust-for-linux <rust-for-linux@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>, 
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 7:42=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> The document claims no subsystem is forced to take Rust.  That's proven
> to be wrong by Linus.  And while you might not have known that when
> writing the document, you absolutely did when posting it to the list.
>
> That is a very dishonest way of communication.
>
> And while you might not have known that when
> writing the document, you absolutely did when posting it to the list.

I did know -- Linus told both of us in the private thread. I am not
sure what that has to do with anything.

As I told you in the previous reply, please read the next paragraph of
the document:

    Now, in the Kernel Maintainers Summit 2022, we asked for flexibility
    when the time comes that a major user of Rust in the kernel requires
    key APIs for which the maintainer may not be able to maintain Rust
    abstractions for it. This is the needed counterpart to the ability
    of maintainers to decide whether they want to allow Rust or not.

The point is that maintainers decide how to handle Rust (and some have
indeed rejected Rust), but that flexibility is needed if a maintainer
that owns a core API does not want Rust, because otherwise it blocks
everything, as is your case.

In summary: you were in that meeting, you own a core API, you do not
want Rust, you are blocking everything. So flexibility is needed. Thus
we asked you what can be done, how we can help, etc. You did not
accept other maintainers, did not want to have the code anywhere in
the tree, nor wanted to work on a compromise at all. You, in fact,
said "I will do everything I can do to stop this.". So that is not
providing flexibility, quite the opposite of it. So Linus eventually
had to make a decision to provide that flexibility.

I am not sure how that contradicts the document -- the document is
precisely talking about this situation.

By the way, I do not take lightly that you accuse me of dishonesty.

> Which given the binding creep means every single non-leaf subsystem
> eventually.

If Rust keeps growing in the kernel, then obviously more and more
non-leaf maintainers get affected.

But that just means more people is getting involved and more
subsystems are accepting Rust for their use cases. So that would just
mean it was, indeed, a good idea in the end.

> I'm not sure how that matters.  Of course your Rust testimonials are
> going to like it, otherwise you would not have quoted it.  They

Not at all. As I say in the talk, I included every single quote I got,
even up to the night before the keynote.

It is nevertheless very biased, because I asked people we interacted
with, which were mostly positive or neutral. I acknowledged this bias
in the talk too.

However, just so that others are aware, I did email others that are
negative about it too, such as you. And you did not reply.

> Well, obviously you do.  But as in many other things I would usually
> not count corporate pressure as a good thing.

Corporate pressure is not good. Corporate support is.

And we need that support to accomplish something like this.

Cheers,
Miguel

