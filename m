Return-Path: <linux-kernel+bounces-524523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 024E3A3E419
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BBE21889A14
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2760724BD07;
	Thu, 20 Feb 2025 18:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlgLDOiI"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D47247DF0;
	Thu, 20 Feb 2025 18:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740076848; cv=none; b=DC0O/jTFZe1Qlqs5WaV4yo0A12DyIxvicwPTUvGxPYqdX2n6Lf4hOBaVknmKrvBTeifX1XGmcqb/EB42GiYvG/fzuVodO0EIUu1Tj347cNEoADD902q1qf9c3y/6vIor5beZ17xKopZnnCuAtiZmQVwZs/egu9JFNn6swKzE4Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740076848; c=relaxed/simple;
	bh=E2DR+BJJfXCSeI1cfeXIx9bKllVF0rrNynMBB0GIgg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mlR+OBExcUiECcGtGCQ5ojKxxY6Ce0F76tbGaOR8FUTtsnzOOF9mYeasEuzTaUrsGA3EFGb/kCgbp1fc1svS9AozEkB8rWBuCfKfbrmlksRDbcDgLSKmZvYObTh0OcXbEB7Nx0pZ3BtR6HymLPBHi+VSRNxuNDs0oDlNS1AAZrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SlgLDOiI; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38dd9b3419cso675304f8f.0;
        Thu, 20 Feb 2025 10:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740076845; x=1740681645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDpYiKzs73InvLQsXoENmuSiu34F9WT8BsmsAiGCuxQ=;
        b=SlgLDOiIHLaD88Koa2EGuQBDk+VokO/3IXgsXGNtPLki9hn0ql89e7yHlWJ7BTV5ea
         Ptiprus3iBJSAuV04Wefnp0wfmkxXInhshga/Qrs6OQuLjoHTvYqOiIQUycWgOTb7x4I
         qNM8GHuwvl7qQHtLG71Y84PVRqYSUuQDaV9EwEpLPYzsa8Xe5wwaFewsrE2c/sio4R+i
         fwjoWNP/lScZhmyr3rjURH9uPdygGapuN7iN6F50rBr6N7CvfD6wr/nEOIxuu6xADARW
         b8TCErVykQ+YB6BiCujaYK2+YTIX9mtnsVVLTKJ6nMHAdyRzbFi0Qhlau5lDs9+bm32m
         PBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740076845; x=1740681645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDpYiKzs73InvLQsXoENmuSiu34F9WT8BsmsAiGCuxQ=;
        b=jrV4jJ3eIwfscmVEjY40IndMvG+3yKTqyPGbLfg+YzFQjh+8ptTfok79igHwDINH0Z
         Cy+/kIbLz7j/b9VgQgo//yQtJKxUOIn16mpsYibQOMPiKnSIzdueLYbtBipvdAwcd88K
         nLMyYkz0rpo6vlFQewhhHYTA0Hz6M5UmGCK1jolTz1wmXmUXcbLpHXb90kQt+ZBQKRz3
         RaDQRme2uozsgcnRXenFMfO8JzJf2Pe1vSk8hr7boECpRqzh1pNK6pAdyZMA8zLB8IQy
         k67VH0dNZgVHGZq4OLqs3gMlhrfof2M0ldANh4T3afj8x3C79evDZULPRqdF7CmAq+2U
         cdUw==
X-Forwarded-Encrypted: i=1; AJvYcCUlx0L4swRv0beZLw0iexJeMkhf572bDHPUUfrVYN9upVswrjSz5MpoK9TpzsWahs1IqAMiCFuA2Lr99+MoVxc=@vger.kernel.org, AJvYcCVzQ09I4mcr6462Ki4YBjFuT6RyrTARLabPC3u4w5oLmzS4fxAKshUMS6g4qX9YY+JhOIMz3blgW7IFDMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt01uRyZUe1/ARHriSE0vY7sO3dAN2et6JRqv1Pjzd7/1CjN6b
	/KXAkWFBJDPy7ro2CU2yGFTFxpTdbXod7e+M4iT7EY10/vWzCNoRU2ce8/1Lpwad4qj8ClXB8Fn
	WvpVb+wjWfIsoxpz6cJlmOEew2+U=
X-Gm-Gg: ASbGncur/lWmnBo17GRROo5/KIGVIVf5kePd1TVmukvR80lLHMm2Z8qTrNJu0fpQOY9
	g3JEAugBcCOMXJYME47cR5a93vHLsk2PErBrNOqUNbKaYZXdORDbd+a1fngPLxEoPWEP4VW0C1N
	Z87vGomZddiuNf
X-Google-Smtp-Source: AGHT+IHkfgnrV+BJNL4baF5nekJSwGBo3ZopJ8YNhxStsP2Hf7g6+UzEp276HXeTQtpo/E5x2POhhtXsLL4/gCTqORA=
X-Received: by 2002:adf:f3c9:0:b0:38f:2b59:3f78 with SMTP id
 ffacd0b85a97d-38f6f0ac5a3mr257914f8f.45.1740076844972; Thu, 20 Feb 2025
 10:40:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z7SwcnUzjZYfuJ4-@infradead.org> <45rpsr92-4416-9no4-8o26-r0998nr77nr8@xreary.bet>
 <Z7bMnpq1cUezsNDl@infradead.org>
In-Reply-To: <Z7bMnpq1cUezsNDl@infradead.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 20 Feb 2025 10:40:32 -0800
X-Gm-Features: AWEUYZlQ2ngnBUpsPvZmt-IUjjrYChxu8xuPgnYSqjT2MUxJIeYsrj1qt7MyBZU
Message-ID: <CAADnVQ+cX_oH_0GcdYkixrMxyvwAKrvSnzx1uofD3BM2E+L6eg@mail.gmail.com>
Subject: Re: Rust kernel policy
To: Christoph Hellwig <hch@infradead.org>
Cc: Jiri Kosina <jikos@kernel.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	rust-for-linux <rust-for-linux@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>, 
	David Airlie <airlied@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
	ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 10:33=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Tue, Feb 18, 2025 at 06:36:55PM +0100, Jiri Kosina wrote:
> > > [2] The idea of drivers in eBPF as done by HID also really doesn't he=
lp
> > > with that as much as I like eBPF for some use cases
> >
> > I don't necessarily agree on this specific aspect, but what (at least t=
o
> > me personally) is the crucial point here -- if we at some point decide
> > that HID-eBPF is somehow potentially unhealthy for the project /
> > ecosystem, we can just drop it and convert the existing eBPF snippets t=
o a
> > proper simple HID bus drivers trivially (I'd even dare to say that to s=
ome
> > extent perhaps programatically).
>
> Well, Linus declared any bpf kfunc / helper program type change that
> breaks userspace as a no-go.  And such a change very much does.

Have to chime in into this rust thread to correct the facts.

See the doc:
https://github.com/torvalds/linux/blob/master/Documentation/bpf/kfuncs.rst#=
3-kfunc-lifecycle-expectations
TLDR:
"A kfunc will never have any hard stability guarantees. BPF APIs
cannot and will not ever hard-block a change in the kernel..."

git log proves the history of changing/removing kfuncs.

hid-bpf iself is another example of that policy.
It was redesigned from one way of hooking into hid core to
a completely different approach.
It may happen again, if necessary.

