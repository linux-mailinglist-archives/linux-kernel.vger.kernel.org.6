Return-Path: <linux-kernel+bounces-518050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C7AA38923
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410003AA5C1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57DE2253EC;
	Mon, 17 Feb 2025 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yg2EuD0O"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC9F2248B6
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739809800; cv=none; b=ZjVFY+rPXkXDk74xehdHsbPNeQWWZj9DincGYMOaim8gcXxd27JByeavl8I3lcBcc6lQFH+QuGYH6VdijeIW0RlsEywkGLPGMl1Wnm+k+iqn/er/AXtN1Alhd6IAfZZrXQKJmJUaJjrUcFKlItCXruELP73ZDqEoIPkqfnrQNi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739809800; c=relaxed/simple;
	bh=WlOHhv6YPlidRlQxUGabWB/Y8llYiGYvkGB43QXy6dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rIWSK9az06KLamBVUa0TBYd9tigp3F/W9gyW01mvfaBY2m1DPpEnvV1gGs4qErqLiGb2Y46YxkyjVPvavC4pgvlApXESjWdG80rqoLmU0oBzAXwYdkC/2FEW/b8eRcm9ksd+Lhhl9HZCRJhhu+4C73WTQktKSGxEws9ELD0Ur3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yg2EuD0O; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f29a1a93bso2811076f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739809797; x=1740414597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZQb2m4LI3eZ0whbBX38Hfb+TR1d3xUyfma8FbMenc8=;
        b=Yg2EuD0OfHiuyZrziAMcVEg6sRwrGKcERTgKT+rq5pTR3C0WSKwhHUwtU5/IuXgA/u
         pgGlt4CYp4/voN1WDdZndVE9ayGlLbEUqG2y4B0aQ8S32xShxjMd6oVRuVURKUb6kV5t
         Fb1KdMcJ77v+XoFAYkSzv2dX06oGS0/KlxGg0q9WfP9aE9akYsGwQtPuhdebErdNXJXK
         0gmT4YASNdSXFDeFDjV/cyBCeG+gXCgqvsouDIKa6brgJ9v1SgauMqKtY0W4mDE8CQKc
         JYmKlPIfBdYdcqSuYpOqedlaBLI+EEbdGQvj65VZcKfyCDv09hfTgNJND+vwnPuNOqIj
         263g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739809797; x=1740414597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZQb2m4LI3eZ0whbBX38Hfb+TR1d3xUyfma8FbMenc8=;
        b=eYJZBha5JZqP0F/Me7lh7Y92cKrHIiG0+/YbQ+ccBcI22TOr723yF/9o/yJVH5ngVG
         28n0/MilFOm8MgTq/HKJEggm9VYv48Rvjjr4J+FyWN4iSlY6SCP/sz6NFlWVq5oGBWHV
         /U0vlX2Ksp7Jro75zHGOIPr7RBq5fzLVKuopRy7wAxoEAjuj9v+Kx37xoKTl0cI5JVGr
         Z6B/9Jn9e8qEilbblG9jVg0lCkXBGZ5birb5Sjpsxl1lLToiEjYIWvF5P+8d+MbFZwh2
         x9ascb+AO/zJBsie4xCNDysBWDHmD3BxEcY5IJmFNEkKFB0dLDAVzHQm8ATKzD1l2Vdz
         9Y0g==
X-Forwarded-Encrypted: i=1; AJvYcCWn03eLcztoPRX6EM388QWEZFazM7wKIZF0kv9tNa1fNQd34gLTX6FLeG9ySY+UwloatH+cefiixXkeHuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwFongIl5xAE/LBIZ/J+NwaSXA65rAuR3qaZ5xYnr8mES6aXyO
	/52W13/REuyvuMh5CT4R1AEuMb+esqv723bfOSRHSpsTgNmppRooiljvjskcApyREaRQXnj0EMh
	ukWtOWZupZYBizWU5zZ234TwiY04=
X-Gm-Gg: ASbGnctXMcs4R1XcAkQp5amhRfAQRyDXBcJiERvyLGaC40+5HkfoHl+sTB70gHRI4bi
	IBx4dny3SXEBsBbi8dakM4YLpwq8dg7tsVWmHJfT2yWu4266770Dw4dFMrlDNS6ezb7vpkNYRFs
	E=
X-Google-Smtp-Source: AGHT+IFPGojklZ8rX6C2jIUVXuI7Nu18SntXvHS3iftVKfpo60nJI733DAqjbgFpNf/qFXWucoMCahPUZAaAlZWrVQs=
X-Received: by 2002:a05:6000:1fa4:b0:38f:3d10:6ab7 with SMTP id
 ffacd0b85a97d-38f3d1072b9mr4816691f8f.23.1739809796774; Mon, 17 Feb 2025
 08:29:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217042108.185932-1-longman@redhat.com> <20250217154309.C2CMqCjE@linutronix.de>
In-Reply-To: <20250217154309.C2CMqCjE@linutronix.de>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Mon, 17 Feb 2025 17:29:45 +0100
X-Gm-Features: AWEUYZlZbQRUYlLo8ZMq5M3z45K6gh8vpPysxswkL9MmuffmUF5lc2K91cMG2qk
Message-ID: <CA+fCnZekjO6ajX5YDE2VgL3pzyawdVNkJ0g6-w0Xq15zdDdLog@mail.gmail.com>
Subject: Re: [PATCH v3] kasan: Don't call find_vm_area() in RT kernel
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Waiman Long <longman@redhat.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Nico Pache <npache@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 4:43=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> > --- a/mm/kasan/report.c
> > +++ b/mm/kasan/report.c
> > @@ -370,6 +370,34 @@ static inline bool init_task_stack_addr(const void=
 *addr)
> >                       sizeof(init_thread_union.stack));
> >  }
> >
> > +/*
> > + * RT kernel cannot call find_vm_area() in atomic context. For !RT ker=
nel,
> > + * prevent spinlock_t inside raw_spinlock_t warning by raising wait-ty=
pe
> > + * to WAIT_SLEEP.
> > + */
>
> Do we need this comment? I lacks context of why it is atomic. And we
> have it in the commit description.

I would prefer to have this in the comment, but with a full
explanation of why this needs to be done.

