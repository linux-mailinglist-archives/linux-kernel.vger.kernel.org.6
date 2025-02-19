Return-Path: <linux-kernel+bounces-522715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0730A3CDB9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 415027A8B17
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E8B25B676;
	Wed, 19 Feb 2025 23:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Y+QfTe1o"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D3D1DE4EF
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 23:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740008423; cv=none; b=cOsaO1KGsPiTyxlQxYv6DYntVod/EjF0RbWHRV3rVrQdIysakBPtLnr8kNFqXCxguhTXwNlYDUBBtQ7x5+V1ScyeTnx/oKCe+9IjFSoSLNKQnxVPcdsIxcajUkPLY/5RME+39hV1Uchuy5ezojV6UhQTKVz0BkZvGQ/4UOM7YaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740008423; c=relaxed/simple;
	bh=JCK9xNuRknwFfTkdP0lbQ2c0ipKv2AhKmDDseX8W7Gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Up3mpggmiQaDIAL/IHLRKElVFEu52UedVg5t4KDipHwDKOy4Io/2nXJoRgpexi00VR/q/Y7kKmC+0E2WQmi8iOJOAI8re5WH3Ej54Jb99N4lLKURFHoPA8TlS5oKBIyZZQNJzwNg55I2jC/FrGEaMa1DRbpApRmdufHkkcqt0GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Y+QfTe1o; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abb7f539c35so81309566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 15:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740008419; x=1740613219; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vaT53iqlM6xreF7+X5o+R/5LiH0zGrtyGxtGEFrke/0=;
        b=Y+QfTe1oJcgabi7xHmMgvmk2wbnHVD7SSlR1E0Za/0nPECdtL+ZtLwN/Go7Hmyo/9i
         mM98OLz9bwc5Wx5AoAnhBJFb7JgB6GODy0j8ME1QvkA23y1c14HaLxh8UQQSUo4leN1R
         3wPhywbHeH9/pNkd85lwJim5KDbXhp4S6DuJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740008419; x=1740613219;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vaT53iqlM6xreF7+X5o+R/5LiH0zGrtyGxtGEFrke/0=;
        b=tyzngcnMkaHLTRuxKhSx2jdCt+CkX+E7nOfrbo+wCHdjiOF7mNkYmKkBozqMt/2cvk
         thqXUPBwSzxOmpUcoV+YbzOZAAMYZxm8d8CGrIE9iHE0WAvUfAe//76Y0/vayTtT+4Hx
         hW98K2XY2e4FCi77Jn0fKmBs1TeHwqnpWN/ChF4Uj6dU4/z2+C15damvs6rLmsFmUOlk
         LuvUSqMJe+cYrXxMpsBVZMs/JHn4aDrEYRF2MjBlh+iiP0tbf6nlntS2iZFvgq1L4avx
         oPqw01ZRB7X7GFvo7xn6F6gsyYUTEYwAJXOY7xLe4HTVD5ZBCyvtASfAjzPLjpa0IRk4
         4qLg==
X-Forwarded-Encrypted: i=1; AJvYcCUZIoGhYPpSsoxPvp6QfPIIG9Zg5q9/G58QtmmS2FQXEVM8VUMa9BGwBzf24dPqEriemIiaZamwVNxVN1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhady7fw2iv254+FpzQ/Ne5R/veHvixwo13Om04hA6BTftsUyT
	U1T8303mfjhhzgsH5M/RFOvrBg2XP5oDUULraRnxl4ttWj5dISUz2d/F4ziT4Z2XVQkXkRFeTrU
	bNA8=
X-Gm-Gg: ASbGncsvJYFfjFMr0h/hHEIqEeIgUBDe7WIolP3Ezp9Hp7w9cEnB0nJ/ZuVe0RWnq0T
	w2NcDaWkRBoFCgvihPNYZCEJnq/aG5mFVSqpmgVaqTUO/uYUMUS1B81E1c/ktqsYq9aoDpmHLJR
	XoUOVlDknW+4hhPlSylV0XLFK4Az4o/4rgD9uO1QN3HfShrTJMSYLgxLahNO1CqKAlNs8FYWZY4
	nPEzg0IkIHFaU8LRHd+OqoweQjMLs0Jiq6rQRohARI1OZkwGAkj0MCftuxVPVxiQuc1i3jZntIF
	7UiHPAG2QiptfYQznfxxSPuZJqHqsTm7GRF6dLOFeBYmj7qaPyYh7t94eeB8XV/TEg==
X-Google-Smtp-Source: AGHT+IGBJ9WiAcDlKvRHeo/mBYf+xHKC3OFRj10bmn2NSd+nSQ+atv08KVS/bXdPHTBdG99aNwIk4g==
X-Received: by 2002:a17:907:6ea7:b0:abb:ca31:8877 with SMTP id a640c23a62f3a-abbca318c12mr749673866b.0.1740008419384;
        Wed, 19 Feb 2025 15:40:19 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb836ee14dsm863397066b.47.2025.02.19.15.40.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 15:40:18 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e05717755bso427900a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 15:40:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU6orLh/ifXIz2Dc44/YNq4DRU7EQntArxaJ022tw+NuZ4NQyK+pT4lZ51V2bjrZvSSUn2QNWqHuDvmnxs=@vger.kernel.org
X-Received: by 2002:a17:906:2454:b0:abb:9c8a:fbcd with SMTP id
 a640c23a62f3a-abb9c8afde3mr1350883766b.53.1740008416535; Wed, 19 Feb 2025
 15:40:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <alpine.DEB.2.21.2502181912230.65342@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2502181912230.65342@angie.orcam.me.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 19 Feb 2025 15:40:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgBZk1FFOyiTKLnz4jNe-eZtYsrztcYRRXZZxF8evk1Rw@mail.gmail.com>
X-Gm-Features: AWEUYZnbHaeGe4UgKVl0jFJTuHOYkmEVJTWaHTc9-dFDkitydo52hFCkXVkszuI
Message-ID: <CAHk-=wgBZk1FFOyiTKLnz4jNe-eZtYsrztcYRRXZZxF8evk1Rw@mail.gmail.com>
Subject: Re: [PATCH] Alpha: Emulate unaligned LDx_L/STx_C for data consistency
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@unseen.parts>, 
	Matt Turner <mattst88@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Magnus Lindholm <linmag7@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Feb 2025 at 04:46, Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>
> 1. A trapping unaligned LDx_L operation results in the pair of adjacent
>    aligned whole data quantities spanned being read and stored for the
>    reference with a subsequent STx_C operation, along with the width of
>    the data accessed and its virtual address, and the task referring or
>    NULL if the kernel.  The validity marker is set.

So I have a couple of comments. I don't care deeply because I do think
alpha is dead, but for completeness:

 (a) I don't think the task checking is correct.

You're only checking the task pointer, so what can happen is that a
task exits and another starts up with the same task pointer value, and
it all matches across one task doing a ld_l and another doing a st_c.

Does this matter? No. You'd literally have to *try* to create that
situation with identical mis-aligned addresses and data contents, and
an exit after a 'ld_l', and doing a 'st_c' in the new task without the
matching ld_l.

So I suspect this works in practice, but it's still worth mentioning.

 (b) this is not truly atomic wrt concurrent aligned non-trapping
operations to the same words. Or in fact to current trapping ones,
since you end up inevitably releasing the spinlock before the final
stc emulation.

I think this is fundamental and non-fixable, because the stc is done
as two operations, and the first can succeed with the second failing
(or they can both succeed, just interleaved with other accesses).

Again, I don't think we care, and it works in practice, but it does
mean that I *really* think that:

 (c) you should not handle the kernel case at all.

If the kernel does an unaligned ld_l/st_c, that's a fundamental kernel
bug. Don't emulate it. Particularly when the emulation fundamentally
is not truly atomic wrt other accesses.

Finally:

 (d) I think you're doing a few too many inline asms by hand, and
you're masking the results too much.

On the read-side emulation, why do you do that

+               "1:     ldl %3,0(%5)\n"
+               "2:     ldl %4,4(%5)\n"
+               "       srl %3,%6,%1\n"
+               "       sll %4,%7,%2\n"
+               "       zapnot %1,15,%1\n"
+               "       zapnot %2,15,%2\n"

at all? Just do two aligned loads, and don't mask the bytes around
them. A *real* ldl/stc will fail not just when the exact bytes are
different, but when somebody has touched the same cacheline. So if the
aligned values have changed, you should fail the stc even if the
change was in other bytes.

And doing two aligned loads don't need any inline asm at all.

On the st_c side, I think you're repeating the same inline asm twice,
and should have a single helper.

Is this a NAK for the patch? No. But I do think it should be massaged a bit.

            Linus

