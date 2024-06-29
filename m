Return-Path: <linux-kernel+bounces-234837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0034491CB4B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 07:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 829B92849BC
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 05:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE68127451;
	Sat, 29 Jun 2024 05:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIdZ4tFu"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65591EA8D
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 05:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719639708; cv=none; b=Ia+YR5NPnIGZ7sAK9DKwHuECV/WuH+J/wNYH5gOo8eg70rR5hbkfawT834XsCLIBBBYQcMN++49zZqrGx9uuB76vO5lVzzNgI3u/39B6OBM9DSKXdV6lQpMq2PvvFSP4V/nLDPBMm1B4/NRUqQhvrne9zdoyEBkQgA5Hsd+AF6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719639708; c=relaxed/simple;
	bh=J7CU6oAbQI/8TIhR7X/EwNpsvd05QNWxa28dGhofYO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DqF7Acj1MtlZY4kO4IgT0Ts8SWsFJvk/KVapiVruadSw1hvGubAJBp2t06OjXfGmXp+MaQ4MxVZj0NcJ9obCUG/czVtWyVMk5iytF9Vv2CpJf4SXe1BwQuZMbyvx0RTgciVzn8MU2wDERLZd8idVF/HLR+JRG8sx9Z+JI5HcGv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIdZ4tFu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42565697036so14271705e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 22:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719639705; x=1720244505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wZGy4XJFZVqMjehkmGr0BII/jxOHjo4pxHFFa9VOi0=;
        b=QIdZ4tFu7JQf889VsR+cyvyPQMNQsR54IEppnk9NWQOtsfwX2wsjdLpsV+Al/C/74H
         gkdbxm5BZJiAJujX+TIXKGsBeyCNpwv9Zn/HwC07ScpAU73chJhZ1lTvYRndlT2mCWHf
         bln14RF9kIUSl82EviLerqPe3MbGmsUPmkeZzgmHAWRpBIsLMTEGgtYHN2O4sJOLeFOm
         5cwcuJXz6hEfS3nUHNEcEPOjlejrmUdfbVH9vbtIxLNc2BBsGxaoy9vnbmgnUL617wnF
         u5c55cZk9C1vmHgPvGrNxwj57tH52Ux07KsUVfZBh5Sfk6nNmwf3qKfnJK20OIfxqZ34
         8aqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719639705; x=1720244505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wZGy4XJFZVqMjehkmGr0BII/jxOHjo4pxHFFa9VOi0=;
        b=VuFgsCjzfB4IixQkDWFGB9sA5kvGmwnVh8JPWvI0m6LcOD+dCq83zJsWvL7wEbk8iu
         3FKx/tOgW3Dvt8Kgv+TjP8m0r4C5gxGYUXgcPBlx6mkzGb8TPwxmQtMYalX/vmYoJ2e2
         O0wMxGMSULnLC3maUxMgzg03/9WHRKaRyQDpGVpaPKVoZCf6KkBtjzn/RRVo4V7dKmDy
         c1314ACthbHM8RkAFM+h36aPeEkQ6ykmR4In4k+6ldYBNunPGiivEHk5KAWegm6kPhK/
         OP/DgocLimTLoacHBI1prOgeqkQb9Hubw0W3p1BHUYSMxwT3IRU8P9JR0XrKNp7EeHfu
         nE0w==
X-Forwarded-Encrypted: i=1; AJvYcCUHTuBWeT1e9y8jZxOdf7GbnNTL7hmhjCp0UsqgN3xBPF3fIODOfjpnmaF23nl8n8mG3qL1iTA6Yhw4KzRaamALRJL1b4NZHk9alM+t
X-Gm-Message-State: AOJu0YwvkS9hwZZhgVohQHHZRQxs66sE8K5TH852tRg6hcUkb57wUVPc
	1ih1XhtFNW21jYWqpZcj+t+25JbRpughSNhJDlbfeEgiknBEbJT7esyGE9ASzTpMmBKaodsfkRX
	RX2tCsS3GkQqLSalUEnvrlaOFaSI=
X-Google-Smtp-Source: AGHT+IFcJNFllWffRgCcsOAWcnN3V+41dce2GQ/a5WpexWfICgiHLv7iDIcZIoCr4e0ESaPxJmoP7QydqpcBBhKUhQs=
X-Received: by 2002:a05:600c:4686:b0:424:aa83:ef27 with SMTP id
 5b1f17b1804b1-4256d4c1cc0mr36504175e9.1.1719639705131; Fri, 28 Jun 2024
 22:41:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJNi4rMfRmWoYdsyH6ibNKN8DSCL_DO8Wa08mWbe8t7vH21Dpw@mail.gmail.com>
 <86pls2isal.wl-maz@kernel.org> <20240627101207.0bbbead0@rorschach.local.home>
 <CAJNi4rMeDgDJbN0jjPguU_v5uoscJJN=5bZaShXpu7Q8X60hcg@mail.gmail.com> <20240628084137.3338ab75@gandalf.local.home>
In-Reply-To: <20240628084137.3338ab75@gandalf.local.home>
From: richard clark <richard.xnu.clark@gmail.com>
Date: Sat, 29 Jun 2024 13:41:38 +0800
Message-ID: <CAJNi4rOSnymWATKnDJ_pj-1LZTctZuF6bqWdfjn2Q4Cc7PyeMA@mail.gmail.com>
Subject: Re: Will smp_call_function_single(cpu, ...) broadcast IPI to all
 other cpus?
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>, will@kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	"Russell King (Oracle)" <linux@armlinux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 8:40=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Fri, 28 Jun 2024 18:21:25 +0800
> richard clark <richard.xnu.clark@gmail.com> wrote:
>
>  trace-cmd reset
>
> will put everything back. But yeah, I need to fix it so that it's easier =
to
> reset triggers.

works! Thanks steve.

>
> -- Steve

