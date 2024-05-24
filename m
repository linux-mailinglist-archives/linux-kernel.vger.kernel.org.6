Return-Path: <linux-kernel+bounces-188197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1838CDF14
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 03:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFDEEB22113
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 01:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096AF63CB;
	Fri, 24 May 2024 01:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="20MK3HZS"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513C136D
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 01:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716512945; cv=none; b=mTCsz5yjns9jW/SUVASAVNO3ftQYaFFztXnFguP8tejKGtI6oWZOU2j1NyjmYawlFoITlpCYsIkkf88JwGhbAk/3K7yn5mz4TG+w14XlQH7KGS1Jvp5kC2jfHwMcOPD2IzbMNho/5WvmVaxwgpiNkIn1lbeWlOFCrz7S00vaAsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716512945; c=relaxed/simple;
	bh=8XQWHJJcnaWQIBpyYzCHxp7AnnNYM9fdzlKNZ1TPWgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8JnF1yJ+hO5xZJ+sfH4x2yhGOmczi1KJiS9u+txTjg4PGpBIosHwDRVrgblIvoITvzNgGHUzS5SsFnFfO/00mPyB3fG8IaTLExBgXiz7b+hQgnZDhKNxuUetirGTEp+R1eStWCoqsjGygZIatLQafbEooiznBPE1nA4DU38PRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=20MK3HZS; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6267778b3aso17663566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 18:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716512940; x=1717117740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5hsurXO4+PTmTC7t5rP+UCCiN2KRr+N0eUl4vfw5Qc=;
        b=20MK3HZSy+YIlZd/bhTnx1+hm7PuAQRmtjxEUN3Kb0dVHLsQwDmuMQ9v7jxD9GDii3
         9bdvlQt7S2vFrPXOFb7MTdnfe/ASwd1SZ1FeWs/DAFrDIzLaI08byIixqvcMllT5x3/E
         BPdHNcUOKWYOUFHvDBI5vPyroC+E8+bmK1U+W4pDeXN9Cb37+1bAXWWmAzG+LZK6OwDT
         IGXi031G8W58bknM+vZanomHLYL/dY7YCh7Ww46ljKREOJCH7tj012naZSntF1i96W7u
         +epeQpIJbXmhEtuKWFM+Ojql+qpgEAl2TDfgbwX0k8ka+XrFG54g5RM6KqldbmWkYYJ9
         ZfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716512940; x=1717117740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5hsurXO4+PTmTC7t5rP+UCCiN2KRr+N0eUl4vfw5Qc=;
        b=IxQ4YaCkUfTEOGIbqBi1AFr3ZzGl0hU00yXnFLcdJpi8ikFZwUsRJLFDPnW5YqCOTg
         lcsA1fYyyv69n/Eap2EgxQHX/dEKvqaB240sycY6l/kCijI1euBemHOmevfT30gwyrI4
         ixxzK9mu/kngiJJSYk7zTo3dKDwqdXoZ9nEA3qlQDnfrHIsbVvpINUVKBPhwBJ4s96fv
         P6YdfbSZ/EypD9kFYrSk0Ne6WmUEcwB1EqYVImQew7Bg2Wn1tc6CwgskbbmIa0oqgR7P
         LqUvnW/adiota/vLoWND3d6QwcPqgPHQGE8DhKMFkk+yZjuT0z5odDA8SMJKVXkhCEiI
         vqhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV32XTi6/ByEw4is8v2OkbVKGUKprtgXr9cbQAtDmcapbD9wvwlE605rCyIpWwHenXuY6wOf9B9qM6NZm0Dzs3actjrJkcf/okFBcUF
X-Gm-Message-State: AOJu0Yxv47skCc8x+47IOxdf3Nrb4HbWbmUKsth+LCEpQ4kHQwi428i1
	KFduflhMgN4OvEVe3PKuMl0tChZ13AiVoI0/2RvfOYO1bAuVf6aOk2pT9+tbSkpvT8RnLS9E2aU
	vTv6F1QrkCsGneXXPdW+gS5NxiuCWP8zS0405RA==
X-Google-Smtp-Source: AGHT+IG3s/PxfkzALAwXOhQ3ekAOVPLqk+Nn0xM/k7lUsK1tJ7QFxgisyucTWB05LPZ17KPqpgslqJYxANclXkKxTGo=
X-Received: by 2002:a17:907:3ac2:b0:a5a:2d30:b8c1 with SMTP id
 a640c23a62f3a-a62641c78c3mr40064366b.14.1716512940597; Thu, 23 May 2024
 18:09:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_9D721BDDF88C04DBB5151D57711D62524209@qq.com>
 <tencent_338DF690631BAE788C4CC858233E9FBAE006@qq.com> <CALs-HssGcNso6vTfbcsiWX1h_46jgDDRcEWcfZCTpxXYnubcng@mail.gmail.com>
 <20240522-d110bb16f54eebb725e943c2@orel> <Zk+ygkJXUcW+H7Rl@ghost>
In-Reply-To: <Zk+ygkJXUcW+H7Rl@ghost>
From: Evan Green <evan@rivosinc.com>
Date: Thu, 23 May 2024 18:08:24 -0700
Message-ID: <CALs-HssY+UOEcM=LhahK1Ngs+=oEocLTFYZ65-Kn7=bH3qYPOg@mail.gmail.com>
Subject: Re: [PATCH 2/2] docs: riscv: hwprobe: Clarify misaligned keys are
 values not bitmasks
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Andrew Jones <ajones@ventanamicro.com>, Yangyu Chen <cyy@cyyself.name>, 
	linux-riscv@lists.infradead.org, Elliott Hughes <enh@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Conor Dooley <conor.dooley@microchip.com>, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 2:17=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> On Wed, May 22, 2024 at 09:26:08AM +0200, Andrew Jones wrote:
> > On Tue, May 21, 2024 at 11:36:06AM GMT, Evan Green wrote:
> > > On Sat, May 18, 2024 at 9:00=E2=80=AFAM Yangyu Chen <cyy@cyyself.name=
> wrote:
> > > >
> > > > The original documentation says hwprobe keys are bitmasks, but actu=
ally,
> > > > they are values. This patch clarifies this to avoid confusion.
> > > >
> > > > Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> > >
> > > Hm, we also have this problem in the code, since
> > > hwprobe_key_is_bitmask() returns true for KEY_CPUPERF_0. This results
> > > in wrong information being returned for queries using the WHICH_CPU
> > > flag. If usermode asked for the set of CPUs that was specifically SLO=
W
> > > or EMULATED, the returned cpuset would also include cpus that were
> > > FAST. I believe all other queries are okay.
> > >
> > > The one-liner fix is to just not return true for that key in
> > > hwprobe_key_is_bitmask(). But that's technically user-visible: if som=
e
> > > software relied on the buggy behavior of FAST cpus being swept up in
> > > the query for SLOW or EMULATED cpus, this change would expose that.
> > > The grownups-eat-their-vegetables thing to do would be to define a ne=
w
> > > key that returns this same value, but doesn't return true in
> > > hwprobe_key_is_bitmask(). What do people think?
> >
> > Even though I actually enjoy eating vegetables, I think it's unlikely
> > that we need to be so cautious for this. I feel like kernel updates
> > provide a bit of freedom to change results of hardware query syscalls,
> > even when run on the same hardware. Particularly the EMULATED query,
> > which I guess could change with a firmware update. And, even the SLOW
> > query could change if the probing was modified directly or indirectly.
> > IOW, applications that use the which-cpus syscall shouldn't freak out
> > if they don't get the same cpuset after a kernel update, which means
> > we can drop the FAST cpus from the result.
>
> Dropping FAST does not really address the problem here. These keys are
> being treated as a bitmap when they are in fact just values. Because
> they are currently treated as bitmaps, it is semantically acceptable to
> "or" two of the keys together and pass them into hwprobe. Dropping FAST
> from the input of EMULATED | SLOW will make it appear to work, but it is
> not reasonable to try to support or'ing of values that are not bitmaps. I=
f a
> key that maps to a value of 5 is ever introduced, then the input of
> UNSUPPORTED | EMULATED will also return cpus that map to the new key.
> If hwprobe recieves a value of 3 for CPUPERF_0 and or'ing is supported,
> that could either be interpreted that the user is asking for cpus that ar=
e
> EMULATED or SLOW or FAST, or just FAST, or just EMULATED or SLOW. The
> current implementation defines that only FAST will be returned because
> or'ing values like this is nonsense.

You're right that if usermode had taken the bitmask aspect to heart,
they might try to ask for cpus that were SLOW | EMULATED, and expect
to get the set of both. None of the other combinations make sense, so
I think this is the only one worth worrying about. That case is super
broken today as they'd get SLOW | EMULATED | FAST (basically all CPUs
always). We have no way to distinguish whether they actually passed
SLOW | EMULATED or FAST. I'm tempted to not worry about this case and
assume anyone who passed 3 meant FAST, but you're right it's there.

>
> Allowing an input where keys are or'd together should not be supported
> in CPUPERF_0 since it is what is causing this issue. However, the
> original intent seems to be to allow an or'ing of keys. The verbosity of
> using CPUPERF_0 will be greatly increased without the ability to or keys
> together. If an application wants to know if misaligned accesses are
> supported, it currently needs 3 separate hwprobe calls, one for each
> EMULATED, SLOW, and FAST. Changing CPUPERF_0 to be a true bitmap would
> require changing the values of each of the existing keys which is not an
> acceptable API change.

Specifying CPUPERF_0 as a bitmask was a mistake (mine) in the
documentation that got translated to code when the WHICH_CPUS flag was
introduced and hwprobe_key_is_bitmask() showed up. It was always
supposed to be an enum, with EMULATED being a (significant) step worse
than SLOW.

My expectation is that most software will just ask "which cpus are
FAST" and nothing else. It's not easy to write software that somehow
takes advantage of the difference between EMULATED and SLOW, though it
is nice to know for reporting/telemetry purposes.

>
> In my previous email I proposed a new key, which could be something like
> RISCV_HWPROBE_KEY_CPUPERF_1, that is actually a bitmap. That way a query
> of EMULATED | SLOW | FAST would be possible in a single hwprobe call,
> which seems to be the original intent of CPUPERF_0.

Agreed, it makes sense to me to have HWPROBE_MISALIGNED_* be the only
value in CPUPERF_0, and add a new CPUPERF_1 key for true bitmap
features. I currently don't have any bits to stuff into the newly
proposed key, but when they do I agree it makes sense to put them in a
new key.

-Evan

>
> - Charlie
>
>
> >
> > Thanks,
> > drew
> >
> > >
> > > -Evan
> > >
> > > > ---
> > > >  Documentation/arch/riscv/hwprobe.rst | 31 ++++++++++++++++--------=
----
> > > >  1 file changed, 18 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/a=
rch/riscv/hwprobe.rst
> > > > index 239be63f5089..4abfa3f9fe44 100644
> > > > --- a/Documentation/arch/riscv/hwprobe.rst
> > > > +++ b/Documentation/arch/riscv/hwprobe.rst
> > > > @@ -188,25 +188,30 @@ The following keys are defined:
> > > >         manual starting from commit 95cf1f9 ("Add changes requested=
 by Ved
> > > >         during signoff")
> > > >
> > > > -* :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains =
performance
> > > > +* :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A value that contains pe=
rformance
> > > >    information about the selected set of processors.
> > > >
> > > > -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNKNOWN`: The performance o=
f misaligned
> > > > -    scalar accesses is unknown.
> > > > +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_MASK`: The bitmask of the m=
isaligned
> > > > +    access performance field in the value of key `RISCV_HWPROBE_KE=
Y_CPUPERF_0`.
> > > >
> > > > -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_EMULATED`: Misaligned scala=
r accesses are
> > > > -    emulated via software, either in or below the kernel.  These a=
ccesses are
> > > > -    always extremely slow.
> > > > +    The following values (not bitmasks) in this field are defined:
> > > >
> > > > -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SLOW`: Misaligned scalar ac=
cesses are
> > > > -    slower than equivalent byte accesses.  Misaligned accesses may=
 be supported
> > > > -    directly in hardware, or trapped and emulated by software.
> > > > +    * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNKNOWN`: The performance=
 of misaligned
> > > > +      scalar accesses is unknown.
> > > >
> > > > -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_FAST`: Misaligned scalar ac=
cesses are
> > > > -    faster than equivalent byte accesses.
> > > > +    * :c:macro:`RISCV_HWPROBE_MISALIGNED_EMULATED`: Misaligned sca=
lar accesses are
> > > > +      emulated via software, either in or below the kernel.  These=
 accesses are
> > > > +      always extremely slow.
> > > >
> > > > -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNSUPPORTED`: Misaligned sc=
alar accesses
> > > > -    are not supported at all and will generate a misaligned addres=
s fault.
> > > > +    * :c:macro:`RISCV_HWPROBE_MISALIGNED_SLOW`: Misaligned scalar =
accesses are
> > > > +      slower than equivalent byte accesses.  Misaligned accesses m=
ay be supported
> > > > +      directly in hardware, or trapped and emulated by software.
> > > > +
> > > > +    * :c:macro:`RISCV_HWPROBE_MISALIGNED_FAST`: Misaligned scalar =
accesses are
> > > > +      faster than equivalent byte accesses.
> > > > +
> > > > +    * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNSUPPORTED`: Misaligned =
scalar accesses
> > > > +      are not supported at all and will generate a misaligned addr=
ess fault.
> > > >
> > > >  * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int =
which
> > > >    represents the size of the Zicboz block in bytes.
> > > > --
> > > > 2.43.0
> > > >

