Return-Path: <linux-kernel+bounces-281404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E49394D6A9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 20:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C197C1C2234C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469CA15F301;
	Fri,  9 Aug 2024 18:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3CE75mH"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2631415CD42
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 18:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723229130; cv=none; b=LqgT7Jrfvi0cRypKXFvkUOs9hMS0rHUx5BGrOMttCX2UhaokEDp6/vIxP3FHZLxEu/x5d8hyG48tRZxfifUJdDLjVJrP/vGMf/FWXHo3fD3rUkZmkfwqwqpXJooe2lyOMPUNaodwTGVEdPh/HJmOdOmJ9Qasw5tlMGyYT7bqltQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723229130; c=relaxed/simple;
	bh=9/p3SylQpex58YQMjwfSJg89oiO/p4Q8CMC4t6aIxTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=dOukEKNMxR4RFg9o8SsOwuG1w250M5FJvA/xv4vHPjuSR8TUOY+QEfnSMAlHeOM29jiGT1old8w80190/t3O+sOxASJ+4BFsvshKAU4Q6tmWfb+fNEAS59z8cqn1hVD+gq0Qbc31xnr6m4GrKj7s/Ge11gHKtRJFqHx9OvIknps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3CE75mH; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4f6ac1628dfso869335e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 11:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723229128; x=1723833928; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/p3SylQpex58YQMjwfSJg89oiO/p4Q8CMC4t6aIxTw=;
        b=V3CE75mHz9XVnpmOtSTFpq4WvUmkKRnA1tfJ9tB4Cd/2atebGt+AbiEWPokLypkz/5
         4n7Vm1Rpj6kx6lpNQML4LWXLM3Z1vQylaHWPwWeM0piSR8l3qHniDQjXTlXI9Zo6Uaha
         2jozjTqE2kn4zB65v45MxBQWPz3w9dkPTlfZAWFEc+NgkkTYfDJbLUwiDeu4YPCtOdvT
         iVLORfH+05pW/UrX3gENMEaxakKzpDBl69lrP/lbzW1XkPdCWX5MeZWrgnZux0lTlo6J
         4Gos6ecFiEkTgHEVN6ZHh+OX7Fx0iR/znaaSC4lmFXua7ry8rW4HdRipLCkv7KH99ep3
         Obxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723229128; x=1723833928;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/p3SylQpex58YQMjwfSJg89oiO/p4Q8CMC4t6aIxTw=;
        b=bUzn8mC2AYxEXP2Ze53m5OPY7PkrCgyUPPa+UX44FfkuTcwJe6QxfLn2dcjl0kQAa9
         M2it3kYxoUOLSB1wf+JbvpZTeADns3sX1XshKxpGNv5A41kjiAHZ0Dm57ExJHNp981Ts
         fSdkpn2lmiWEyVG8MeiRZZ3DLMwJL0fDoVFSSpEnyqQLM3EAgsbHTAOf1vk6H4lr2Eol
         sNc5Wj4Exeq2f/8Hg9WWOXKXsUwdkl/uoUvIEYtyO8AAcDeu7LfuHr8c/IPQUyINHM1z
         OXqwzAwuDhSN0K+APHFLp4kVnlM7jb7oS10WwWhV/h0e/JwLz4SImJMEFYst6LUO+B1U
         rdXA==
X-Forwarded-Encrypted: i=1; AJvYcCUtwOia5SOw8VhIZ2IoLvD1sb5fXBwl2qGR+c+DMRT84BhPpbyLP1CZswhTavo8H90tf0viTYFo7uKhWoAu4y3Ay79EbXHlhG0kB+IX
X-Gm-Message-State: AOJu0YwWOYHwd4fBozsiwHgUus2RjbEerr1fbZT6T8/Q0nsMSwez8/PP
	8sJ6q4GiqqJOo4J1LLEVMO5kODJ/YKxzvmrUh2OB9SQXXVPEKUZFYmBINaUvljODo8I2YKSIWAB
	fiN19maH/gSyNM0CnFGr/QkhJleQ=
X-Google-Smtp-Source: AGHT+IGO1JCPOBeO85kZqWEF9K7sRPfiwZEmC5y22fviesmzsajPdFAWbt4mXA17JwJ6hPn+zWBwbY5hOwUA9ilsVcU=
X-Received: by 2002:a05:6122:134e:b0:4ed:52b:dd29 with SMTP id
 71dfb90a1353d-4f912eecd0dmr2917204e0c.3.1723229128034; Fri, 09 Aug 2024
 11:45:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807211309.2729719-1-pedro.falcato@gmail.com>
 <20240807211309.2729719-5-pedro.falcato@gmail.com> <52wapi4gdnh3i2oiyk44utrco4ck5zph5mikoejfjrlfz2pwhe@eyiaozi4q23x>
In-Reply-To: <52wapi4gdnh3i2oiyk44utrco4ck5zph5mikoejfjrlfz2pwhe@eyiaozi4q23x>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Fri, 9 Aug 2024 19:45:16 +0100
Message-ID: <CAKbZUD102gMDJeryA600LJ--GpKOm8q_18i-zhqWYXKvHNU1yQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] mm/mremap: Replace can_modify_mm with can_modify_vma
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Pedro Falcato <pedro.falcato@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, jeffxu@google.com, 
	Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 5:06=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracle=
.com> wrote:
>
> * Pedro Falcato <pedro.falcato@gmail.com> [240807 17:13]:
> > Delegate all can_modify checks to the proper places. Unmap checks are
> > done in do_unmap (et al).
> >
> > This patch allows for mremap partial failure in certain cases (for
> > instance, when destination VMAs aren't sealed, but the source VMA is).
> > It shouldn't be too troublesome, as you'd need to go out of your way to
> > do illegal operations on a VMA.
>
> As mseal() is supposed to be a security thing, is the illegal operation
> not a concern?

My 3 cents (note: I'm not a security guy):

- Linux m*() operations have been allowed to partially fail for ages.
POSIX only disallows this in the munmap case (which is why we need all
that detached VMA logic), but not in any other case. We have a lot of
other failure points in these syscalls, and would require extensive
refactoring to patch this up (very likely with an inevitable
performance regression, as we saw in this case).

- Despite allowing for partial failure, this patch set always keeps
the sealed VMAs untouched (so that invariant isn't broken). The munmap
semantics remain untouched (and POSIXly correct) due to the detached
VMA logic.

- I personally have not heard of a single attack making use of this,
and the performance hit is very measurable and exists _for every
user_, despite mseal being a very niche feature (I cannot find a
single user of mseal upstream, both in debian code search, github,
chromium, v8, glibc, and what have you).

I remember SIGKILL on a bad operation being a possibility during the
mseal patch set talks, and if people are really scared of this partial
stuff, I would guess that's still a possibility. There are no users
after all...

--=20
Pedro

