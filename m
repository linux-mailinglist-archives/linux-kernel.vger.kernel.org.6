Return-Path: <linux-kernel+bounces-570398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77284A6AFDA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 22:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 108C69837FB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 21:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568C52063E3;
	Thu, 20 Mar 2025 21:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hd1G1Z8x"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0034133E7
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 21:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742506311; cv=none; b=LTniI2l9uvYQ7DvzplRcMoiP5JYkyCkJBOWUMF6ZAR2r5cUfiyqbYKXzMotreoYyAiybtksz+mDLoVe8daSQtXaRdxzrpeqpKin8RZiYAvhVTPATVvYQfn/PFVvKQxZNoN72lAqPUL+docyTiQnByUXTblHs6otpDB52xzt1vIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742506311; c=relaxed/simple;
	bh=4jvKj8a9fKMF7pwxi5LmPBbXgZ3JZ2kDMyB5nl6jWug=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eXN7BfM316Jb6I7E0o3fdkYtKlOJrcbBOsjWTlSOFIG323IDGG23ovax6jX+ym1zklrAW+RtnytOqDq0Fvf5TTpP2XtB7n4l8BszDJT+2NTm7uLJoAza4iKdF87pyIEu8AUCFDcu/gYg/7/OakbtFV8YEPftGNZ/7+7jZ3MjcOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hd1G1Z8x; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cfb6e9031so12089585e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742506308; x=1743111108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9aMADM4ydSghIO8HYQaCwwPe7fPOWJSM+ByuEXGP7w=;
        b=Hd1G1Z8xNLIfwqjZlXYEdFYRrYnCGl1k+PyQluN882CoEe9Pkb0B0Q8Xe/bAKSsiop
         Qk4dLQPLrN42eLT9kyrGSWKnAme/g0fi44Jidr8jRnZAxwv9SAmkMt8xdv2jQC9Wwfgs
         1nKXbkC5BNpoC+84FpOGSibcyUahATI0fFuHZVTWuPA7c73EsEmsjmKmKsbIY2KdRGO4
         uBsC/Dk/UvPmlKLPMIbzOijfbj4GmNIL72jVKlJUU8+hcYdW83pR0hIekCMdXYc2+qBC
         9LsLkzZ6Lb34A8N2OeSCrKgk/dx2RXzp+JCdpUDUzz/4O67g2tFqsBaUo4jJbRrTwpfQ
         bzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742506308; x=1743111108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9aMADM4ydSghIO8HYQaCwwPe7fPOWJSM+ByuEXGP7w=;
        b=suo9tULlWu13eVffDZQjzgvMlC5m/3EV+McAxjj+utBB33DUJBOZytE4xfFKzcu10M
         fAYaaHpSI5t7cE40+FmpHyt7quSnRq4cdnHpaP6DpjdUaDPdbZeH7+kimstzvlW3KcZ8
         qDik9B1irKwl8wnUK7tRC2UT33r0I0alndpJjDk0WO1TG6MVTfGjFmCn9YjFyle/aHqH
         OWoF94uaqN56prS2u8x8SsH7rcrL+IhnwLoY5dDqTpC3TXj4uk9u5m8nzug1AW+fuYho
         n8+m6wdh0zD89p75HNyxnf9V9N8xRuS1fZdHfHl7BshBOVosSfxx00FQZO2nJOfDNLEE
         qOKw==
X-Forwarded-Encrypted: i=1; AJvYcCVHAlWc4bsgOCFdFFo3wRhqegWxTKIZcog6YqG3Xnj5fJcJn5pGwTVsNlJFA3FoL+vjaDkBmJTWNUUS86E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+MMEeVjANzYrXFV9FluFVqj6B89fb+8L/XwhcXWvslTe73Qtp
	LyUMSyZDQMrkPcAufEbFG83fYyc4ZMW5ec3gSmEyNBIY3aJy1F3E
X-Gm-Gg: ASbGncvtEPljrKM21Kigymp2orWUPXNLZ8goqatuGiUa3ZVbxkWa5+GL04dTb93zz+a
	vkG+XpXhSG7KiiKvH9KrYDGjxJP60KNdNEG+rbi5+dY/Ycdin3ZJ4D/Y8UP/JrQzxDM5jcYhHBe
	XipCAI9jznTIBvSobldUqYp1nIWl6alzrdlahcx+BNV+n3uOYNh73cpMSPqorI/HDTPv+HGgvI1
	J7XQIvbJhqyj2Hc9Ams5vLJzcqyEOWombUgqDSnZaeVE5g6k7nGFwv7+UMJ6xQ9SWUKWUpGR5Js
	uw7uyUnf+QsfGxnk+WsetP5yB7jV3i6wfmdIl4V3tnGfYdLaeoqwo6QFfxePhE3DAQjQ+0BHxbc
	ToHASyy10gOqXV//9eg==
X-Google-Smtp-Source: AGHT+IEbIHx1eEq/HCjREZzXVXYJ1qBo1McEUTBg5qk1xb84aVYdBlQckM0N5s2czPkdGYQEE24umQ==
X-Received: by 2002:a05:6000:1fa4:b0:391:952:c730 with SMTP id ffacd0b85a97d-3997f8f8c1fmr847331f8f.11.1742506307773;
        Thu, 20 Mar 2025 14:31:47 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d440eda26sm59357875e9.36.2025.03.20.14.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 14:31:47 -0700 (PDT)
Date: Thu, 20 Mar 2025 21:31:45 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Herton Krzesinski <hkrzesin@redhat.com>, x86@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, olichtne@redhat.com, atomasov@redhat.com,
 aokuliar@redhat.com
Subject: Re: [PATCH] x86: write aligned to 8 bytes in copy_user_generic
 (when without FSRM/ERMS)
Message-ID: <20250320213145.6d016e21@pumpkin>
In-Reply-To: <CAGudoHEDAzOrndyJeb7L95cMPmHHk0O5wk=tRCe35FE6GVYs1w@mail.gmail.com>
References: <20250320142213.2623518-1-herton@redhat.com>
	<CAGudoHGr6y-WQY9CZ7mppeX87cgN0dG07ivK+MaoUow3ymArDw@mail.gmail.com>
	<CAJmZWFFyvqivwSMGA-T2HnOTr1GtYAvvWVZ8YuASC+cfSsB42w@mail.gmail.com>
	<CAGudoHEDAzOrndyJeb7L95cMPmHHk0O5wk=tRCe35FE6GVYs1w@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Mar 2025 19:02:21 +0100
Mateusz Guzik <mjguzik@gmail.com> wrote:

> On Thu, Mar 20, 2025 at 6:51=E2=80=AFPM Herton Krzesinski <hkrzesin@redha=
t.com> wrote:
> >
> > On Thu, Mar 20, 2025 at 11:36=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.c=
om> wrote: =20
...
> > > That said, have you experimented with aligning the target to 16 bytes
> > > or more bytes? =20
> >
> > Yes I tried to do 32-byte write aligned on an old Xeon (Sandy Bridge ba=
sed)
> > and got no improvement at least in the specific benchmark I'm doing her=
e.
> > Also after your question here I tried 16-byte/32-byte on the AMD cpu as
> > well and got no difference from the 8-byte alignment, same bench as wel=
l.
> > I tried to do 8-byte alignment for the ERMS case on Intel and got no
> > difference on the systems I tested. I'm not saying it may not improve in
> > some other case, just that in my specific testing I couldn't tell/measu=
re
> > any improvement.
> > =20
>=20
> oof, I would not got as far back as Sandy Bridge. ;)

It is a boundary point.
Agner's tables (fairly reliable have):

Sandy Bridge
Page 222
MOVS 5 4
REP MOVS 2n 1.5 n  worst case
REP MOVS 3/16B 1/16B best case

which is the same as Ivy bridge - which you'd sort of expect since
Ivy bridge is a minor update, Agner's tables have the same values for it.
Haswell jumps to 1/32B.

I didn't test Sandy bridge (I've got one, powered off), but did test Ivy Br=
idge.
Neither the source nor destination alignment made any difference at all.

As I said earlier the only alignment that made any difference was 32byte
aligning the destination on Haswell (and later).
That is needed to get 32 bytes/clock rather than 16 bytes/clock.

>=20
> I think Skylake is the oldest yeller to worry about, if one insists on it.
>=20
> That said, if memory serves right these bufs like to be misaligned to
> weird extents, it very well may be in your tests aligning to 8 had a
> side effect of aligning it to 16 even.
>=20
> > >
> > > Moreover, I have some recollection that there were uarchs with ERMS
> > > which also liked the target to be aligned -- as in perhaps this should
> > > be done regardless of FSRM? =20

Dunno, the only report is some AMD cpu being slow with misaligned writes.
But that is the copy loop, not 'rep movsq'.
I don't have one to test.

> >
> > Where I tested I didn't see improvements but may be there is some case,
> > but I didn't have any.
> > =20
> > >
> > > And most importantly memset, memcpy and clear_user would all use a
> > > revamp and they are missing rep handling for bigger sizes (I verified
> > > they *do* show up). Not only that, but memcpy uses overlapping stores
> > > while memset just loops over stuff.
> > >
> > > I intended to sort it out long time ago and maybe will find some time
> > > now that I got reminded of it, but I would be deligthed if it got
> > > picked up.
> > >
> > > Hacking this up is just some screwing around, the real time consuming
> > > part is the benchmarking so I completely understand if you are not
> > > interested. =20
> >
> > Yes, the most time you spend is on benchmarking. May be later I could
> > try to take a look but will not put any promises on it.

I found I needed to use the performance counter to get a proper cycle count.
But then directly read the register to avoid all the 'library' overhead.
Then add lfence/mfence both sides of the cycle count read.
After subtracting the overhead of a 'null function' I could measure the
number of clocks each operation took.
So could tell when I was actually getting 32 bytes copied per clock.

(Or testing the ip checksum code the number of bytes/clock - can get to 12).

	David

> > =20
>=20
> Now I'm curious enough what's up here. If I don't run out of steam,
> I'm gonna cover memset and memcpy myself.
>=20


