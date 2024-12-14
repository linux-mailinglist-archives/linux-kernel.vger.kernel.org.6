Return-Path: <linux-kernel+bounces-446225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B679F2155
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 23:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84FA9165FE0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 22:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B55D1B4F24;
	Sat, 14 Dec 2024 22:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RVuRxEp7"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D5D374FF
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 22:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734216510; cv=none; b=esus7CTsI5D2raZnl9O/l/Nq/NvpcXbYm0N6peaLVhGHZWEDmX5F1e7c8HwzCaUAlUUZnqjqVbNo0DRKOK848iALB2cHFPyKAoNTfS2s43pFYzaJ85dfOsJMLQkJ9SRszDknNd7oyfPc1cLbS9zY7qEDgYLOFOZ8Em+ngofkV2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734216510; c=relaxed/simple;
	bh=mN/QbefYvgqpNikuORpa9UwnpfDph9udgK3kqfaxc6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1j5H5kHScKm9DeFgGyvpSyI1+YLEPJffarwPOPv8Z1ipH+AjLd6u0q+qprS3VGpO9DFrf9ySH/sKirjRWT76MvNnkGt39F8KjfPvzAqmdD3W0fVACr4AxidqSGbZLBK9DZSfrVPB847+EnwOQqXSilcSDWvZFLtxpLHOlJCShM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RVuRxEp7; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e4419a47887so1354765276.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 14:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734216507; x=1734821307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZJ4scXTRmS7RPf8oo625k7m0SKrT5j5fYdKEOC7Hfo=;
        b=RVuRxEp7sx65p/D2b82jDjFD3msPydiwOlQUQQ5RDh7qpf/fUhldaANB6nhdZSOuXi
         +bHbdcEmbD71g1bZXcV86PhNBx6KIp2RrCkDPVImcpZ5qIsm8kpaLPKPG42BMviKFcwY
         xu/JpYA89UfkX3Vw/FqP275O5tqDoEIL1ITtXvmIhWMfSfr6Mi8TQ/BJGp3FEOBKRr44
         v4HU6PW4hQNmkPtjaDX7KktRcRwQYgATrnt3JVsfgrD45a3OMHvWLnjktgqHkTAJJw3L
         i+kg7mgZX5Hd3BfKGpqgWUvgndQucCu1W4xbBh2a0Zq4e8gQgm3bV9YT4iyDqenOUBVu
         YN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734216507; x=1734821307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZJ4scXTRmS7RPf8oo625k7m0SKrT5j5fYdKEOC7Hfo=;
        b=avn6/jDzPvyTQSM9K6imGKIk+I8gJj6FRL3oY0pEJeK1qA/NySZEl84zbiFMuXzT21
         8LqCi2R6Y0m1Gl0J9OKmX8klGfq6cRUKoiahrc5sFZAJMzhagR0cQzmrK8H51IvGDwMW
         M5fxTK5p2R1nZ3DzJYNBM4QSYtQ4qYMqKwZRV0YP9HPep02gwgtcNP3ai+FqSxc1lYdQ
         bVg31i3b1j+HjI3oyLZSqHgGxYJ56rSaAQfjfIp87NpqcLzCA2fgYFHRdthh0tiO7VRq
         roNWLQ2FYT0D2p1gR1C0j9PKJdkN1+jl4kfk+4Sf4hLq09dFC28/0gqsq93H/bsfrHQV
         xaKw==
X-Forwarded-Encrypted: i=1; AJvYcCUfRiueXSNo+0FGMj9TDlr2TgaBSjIeDaXAnfUQjmlJctPj12DcnNe+QDsH6x92zd/d9j/BEWrADF9Ubfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVDh4iKZecsHD3MHpHyUsD/tsgtdHZ+5oN+12VoRT58hH7xkx2
	/fOrAddpCIfbygEkJBCxAgKSIRD9D1/KlDmqmPMaEcrCD/C2Lb35jU9107SuwC0vQiwzthO3gn3
	a8pvS/2wVUtEm1U7+CQI2uAHTs3RFPIZA+096
X-Gm-Gg: ASbGnct4NVwjDHpX6FviKMAey+aqP7jMBPtpTc3wVppg4MC2A0u5TVvP5qnEPGi2RGB
	8zNXkO7DRpetc69p0KQ5R1GWSFR+8nn36pexD
X-Google-Smtp-Source: AGHT+IFbiM++nNw75ntI6RZMI+YfteGrryJVeEm71wShEK1qQgsUqDOT4fhaa7MESeCYL+h3/swZ5JktuRR/PL7IRDs=
X-Received: by 2002:a05:690c:6388:b0:6ee:a70c:8727 with SMTP id
 00721157ae682-6f279b9df88mr69827557b3.41.1734216506880; Sat, 14 Dec 2024
 14:48:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125110646.50799-1-cgoettsche@seltendoof.de>
 <e43da8418fc54a5eba7cdbb594b24bb9@paul-moore.com> <f7bfbf89d2ac4b929637bbb25f749c96@AcuMS.aculab.com>
 <CAHk-=wgraNfcOCZ4n_C+ircQkD_AhsPM-=z7snt+eLgE-6otkg@mail.gmail.com>
In-Reply-To: <CAHk-=wgraNfcOCZ4n_C+ircQkD_AhsPM-=z7snt+eLgE-6otkg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 14 Dec 2024 17:48:16 -0500
Message-ID: <CAHC9VhSDfn5QgQsF9qq6-k67bQB_M6UZoLODDYs4qkwHcr4-gw@mail.gmail.com>
Subject: Re: [PATCH] selinux: use native iterator types
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	"selinux@vger.kernel.org" <selinux@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 14, 2024 at 4:10=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sat, 14 Dec 2024 at 13:08, David Laight <David.Laight@aculab.com> wrot=
e:
> >
> > Isn't this an example of why -Wsign-compare is entirely stupid and isn'=
t enabled
> > in the normal kernel build?
>
> Yes. Please don't try to "fix" the warnings pointed out by that
> completely broken warning.
>
> I don't understand why some people seem to think "more warnings good".
>
> -Wsign-compare is actively detrimental, and causes people to write
> worse code (and often causes mindless type conversions that then
> result in actual real bugs).

I'm not going to argue the usefulness of '-Wsign-compare' in a general
sense, but I will say that in my opinion the changes proposed by
Christian in this patch are correct and an improvement which is why I
merged the code.  If anyone has an objection to this particular path,
especially if you believe this introduces a bug, please let us know.

--=20
paul-moore.com

