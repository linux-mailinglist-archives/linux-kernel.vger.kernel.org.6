Return-Path: <linux-kernel+bounces-569655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE37A6A5A9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE050166A52
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3FA21D581;
	Thu, 20 Mar 2025 11:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZX3rt8d"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E271F4C87
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742471918; cv=none; b=J+IsyrJv8+YcGwVX/C8uuwK8D5aDsPgCe9ftMCnZLnTLLBg87exV+jG/S+uUvwL1QpMs9R7w7DXH+Ic8eMmAjvbpW8U6hUxT6WWV6j5LfTIXgMLODwxHLT5FoowkVfVONWlhIFZX01lCWfW+jfpic/EcOEFMumgla19E5yDQqgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742471918; c=relaxed/simple;
	bh=mwlF3B/nLOyLIkcW2MlX2r6IQeH3QSoZS9UaHknKT7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BRzSf/0H4eRPvEa9iqu8AwDJUNCDQXQ38R2JOyFJX2n2Yj+REy5y0K8U3QFO1e81PBX42VqlCT6Dgl/oLG5EbV1u/TiWjKlW2HEQoQ08gj7stKFYOp4kRZX2zVbr848a6skUTp7Z7cVeJbkXAVQBiATKJPe2CG2zM61fFYm453s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZX3rt8d; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30bef9b04adso8289931fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 04:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742471915; x=1743076715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwlF3B/nLOyLIkcW2MlX2r6IQeH3QSoZS9UaHknKT7w=;
        b=fZX3rt8dKtT1Yk8hlwaKaeQDgfv1AN1eZWyURi5o/b9Ra7WQBncbelJYMzUxdF86bb
         AXPUzfmgHTAPOkLfl3AoDHu/kuGch769+2LIcpWW3kUUuPdKQXdKBxR3unMnlh9eCFqW
         23AO/e9u0w40bAeJOjfFFrzYMpWowImlRIANjyzesXleD6K5FXHja5mNTPaxjqcyvukP
         j/8FPJXfAT5HJnD5HAqr5JccbmEBRsMywYbr+DFo0laOzH2J71U2MaS71N4hjyHdPq2n
         gQs/ipHks38y50QNI6QQM911KqkV08a7r5P8Da18ZqDkcBquFOLudX9l0aGZZ6BaermK
         AZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742471915; x=1743076715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwlF3B/nLOyLIkcW2MlX2r6IQeH3QSoZS9UaHknKT7w=;
        b=UzAThsgk3vmcT2dPCc69YdiVP66MeHTQ1lwgdJKzrDJXf9wxITKhftOy6r4OQa6Aty
         kaOFeBnUuCfh4SqNX+n8uYBC32FhsbniU5Tzb52ZRdinJ8T6/Q8oqnA7klvVupmbcbHe
         d2t/UeDrnLi9SbaQWb8APOruaXNvYr+DsvdGWbHy5fwUdW+fMusHgs+aHGKubrKy/nwp
         OZzuntoDbec+AhmkhP72K3oB3qwPCX1JTn9EbqKyWs+INeQxP2sHIGNfSaVvLPYOYrPo
         yh1nPlvYjyMIURpaY/9usI7+TDMlb7U/2OkesKl4yjIgLxQDM80j3PDI0qcGg1wUEZgv
         JLXA==
X-Forwarded-Encrypted: i=1; AJvYcCWUUKDQPBo7vZs9is+yBpxHBUvend4Rqd/I+AgrP5dc3s7CTtMbx+ktv+4L9OHcHXXY09egyX4QUhkvkzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUdzMIHNPr7LRIB9T1iQvO4UXlHKYbpm7D2gl/3usegrcaDALF
	EZhmvFJWTSlz9KP94iJ9QOGBhW3MrhlWCiv8G7jVZG/J4JCQX1MuNUIIlH9GXr7WAs1uaZ9O0Rb
	5ybiakXecU8ZLdlpV9Zfsb4EOtnE=
X-Gm-Gg: ASbGnctlzH0PZiGnlUAqFjYCFDzHqGroj59wi149Xct3KXNtHp+7XZabxFiWjxc2peQ
	kCPudE3EJWuZoFOWq/dQ89WXSF3wtC2J7YCsmN+MArVVP14oCANzBvWtTiws4PBw//PY2+W45p/
	dIgkzGIJ3m7EIUoARKDh7G97kN7hYCNfJzSHt8
X-Google-Smtp-Source: AGHT+IFMd8XYVT9oaVi2FJ2Wms47aZtFzdPsqP7afy29RCwL/Dbbx6vRb0MF3HY3z6hNb7HmSRBTs/GV07MFSjzh3Ew=
X-Received: by 2002:a2e:be8b:0:b0:30b:c91d:35cd with SMTP id
 38308e7fff4ca-30d6a3e446emr27020471fa.11.1742471914695; Thu, 20 Mar 2025
 04:58:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317221824.3738853-1-mingo@kernel.org> <5A417EE0-8DF3-4C6E-A7E9-9EE6705282F1@zytor.com>
 <Z9m1rtmlk1PxGIQA@gmail.com> <CAHk-=whAUHyXM29_9w_T26=15D1KZnuR3R+f4MT9f-C89oukvA@mail.gmail.com>
 <Z9m_kUqxqMPfU8Fl@gmail.com> <Z9nTfFiPv0-Lxm-_@gmail.com> <CAFULd4aFUun7+1izxbDM8nTEEta5PApysyTGsn1hjvQND=2UtQ@mail.gmail.com>
 <Z9tGh0Fa96gACmpQ@gmail.com> <CAFULd4bxUOiPLQ9aaZFx2jsLUwEPH0h=XiCOtxYn+Z8JEAeHUw@mail.gmail.com>
 <Z9vY8Bm1Wv1vkqNO@gmail.com> <CAFULd4ZZ6rjG=LTQX6hsrqp6BQ5XcRW7kQ_rzHKrOxKCu51=sw@mail.gmail.com>
In-Reply-To: <CAFULd4ZZ6rjG=LTQX6hsrqp6BQ5XcRW7kQ_rzHKrOxKCu51=sw@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 20 Mar 2025 12:58:22 +0100
X-Gm-Features: AQ5f1JrTsiLJrQOD9V8t8pWHAqIUyd4p3FWmnkQS7VdHpYgBnjfB7ESlPUlLnbo
Message-ID: <CAFULd4ZBvv+HeHwH_0br+_jdJ4sgpjdNGtqAxL4=c629kBaQbw@mail.gmail.com>
Subject: Re: [PATCH] compiler/gcc: Make asm() templates asm __inline__() by default
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, "Ahmed S . Darwish" <darwi@linutronix.de>, 
	Andrew Cooper <andrew.cooper3@citrix.com>, John Ogness <john.ogness@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 11:30=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wr=
ote:

> > > Interestingly, I got *many* more changes just from converting atomic
> > > locking functions to asm_inline, as reported in [1].
> > >
> > > [1] https://lore.kernel.org/lkml/CAFULd4YBcG45bigHBox2pu+To+Y5BzbRxG+=
pUr42AVOWSnfKsg@mail.gmail.com/
> >
> > Have you used a pristine x86-64 defconfig for your build tests?
>
> Yes, it was vanilla x86-64 defconfig, but in -tip tree.
>
> > Could you perhaps check my patch against your patch in your build
> > environment and figure out why there's such unexpected differences?
> >
> > As you noted my patch should be a blunt-instrument superset of your
> > changes so if then it should affect *more* functions, not fewer.
>
> Yes, I'll try this experiment.

So, trying your patch on vanilla mainline kernel with gcc-14.2.1
resulted in (approx) the list you reported. However, adding my patch
that converted locking instructions [1] over your patch resulted in
(expected) hundreds (~1700) of changed functions.

[1] https://lore.kernel.org/lkml/20250309170955.48919-1-ubizjak@gmail.com/

The takeout from the experiment is that your proposed change is not
enough to convert "everything" and misses many cases (at least locking
instructions, as confirmed by my experiment). We should use a more
precise instrument and use it case-by-case. This will be some more
work, but on the first look, there are relatively few interesting
cases remaining.

Uros.

