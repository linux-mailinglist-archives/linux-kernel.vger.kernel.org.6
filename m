Return-Path: <linux-kernel+bounces-309988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8F19672C6
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 19:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4041C2127A
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 17:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC6155E48;
	Sat, 31 Aug 2024 17:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNGpOoaN"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B21200AF
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 17:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725124769; cv=none; b=izMrCJZwFf99BfURYYtQCMcO8DUd+RUgjXI1ths1HGcD4xo2oYrezMLBjrGy1j6Khi2JIHwuTukPACmcin4D0H7aVmxAk21sqXs0xSI+HvzKgaojSawCFJjqHGF7OE+T1VzZtxvNe54up6UpfnDTM4aJwS9gKo/AXaqLjKo9dtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725124769; c=relaxed/simple;
	bh=ZwmuV/pOEVo053mZttbOFHhS9B5972/J/WOxpEJ/3QU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ugj1ZBl80rVAktWA62TI71flF19MEu0gp5jwidlVgAiQjgdfSXHCHXaYqXEWWTYPItlKStKN2ztJkVimMzQIadjoBw2099qUBBuKKxalSJCteJmbEoTEpaowNHneFASOI7YjQlduB/i5ebpon866iIvkCdaCPIOlayo3yjArDRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNGpOoaN; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7cb3db0932cso2106942a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 10:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725124767; x=1725729567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2i+VxibeCjbEKt8s0QvfC/FQysemfkJorYwpG2Vczw=;
        b=kNGpOoaNx32uiO2PZes/P52xV0+A3Co6Z8TvbhhkTx4VSwrpEqszbgbwVM40SqPOiO
         ge9LkoQHnJ19jEZihdNZI69MwkgPf01+60mvoyRZkXDMUVxykcdgX+FyD2k5pwLGFJ3y
         1b5EbEyIKxPlNErarZ5KO+BDqxfua35+4RoIVHQAlxVL2/rEY2jhnmRrs2aqPU1WrqZe
         P1qZbOR0jNfzP8ynI6OfvVkcsWFjyAO72hdFqgIuTbcR9+EN9Bt107l/Lr0aR8MccNTF
         z6yGJFDCAXK4Ngx9TDleKpYi/fBHBzmvO+XciQ1Crl9yqjRh6MsC/bJQqgO3poLp20Kq
         k7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725124767; x=1725729567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/2i+VxibeCjbEKt8s0QvfC/FQysemfkJorYwpG2Vczw=;
        b=Q1j9bIjCm/FwjVLYYzkgd/YyvxF+Io4jmJ19TSCDWCM7AkX0AYMaumnYMYRzCg52W0
         ddRrPLskZ5WauxolEU8aTJnaJqGd20wfU6cF3uyT3GWAUe+q6K5gy4i1tRCrQIREd8rY
         k+C/yakfOjvGDVEyRkk7kZGRPM23tMzi7qefht/maOp2ZJWz5tTlkVbVFYjX3wUg+uKW
         18Xi4EFxeBgS2LaECwINR8hYugKJj9HLuuurIMtG+5DOWYj2NuA9hELjWnNJ3GPPWnHK
         UpxZPmyE4b0PvwFaE34a5QZ0Tqvu2LFjtlPLdkpRSxkKMDtoB/NETTmrDDSgaSe65Zwc
         n9Ow==
X-Forwarded-Encrypted: i=1; AJvYcCU+5FgPbdKjOBNduf80D2i4j0TXiVh8xdy+AKjAfHISIGj4KvUYp0JWBVVcnH6SKrSQB17j1yvbJVJx7mY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIpj6oypxE1FOnCGWln7dOPlyAc8koeQpYRIeooJP+T+pZ05rS
	XCkeVv+BoyCFQoYvvAVdkv97X/HcSEEac9TLbSxVpZapXPFZvZOkxxmhsZVaa9DiVMClW92wA18
	7k3FNCdk9qRjZC4V6itpPfBpAkwr3+G71
X-Google-Smtp-Source: AGHT+IHTnRu9XlDWp2DJVqWFQq5g1KaEFOkwIlBZvSMLiqQna8laP9Ga0yQI0anwDwPezmnwrwderAX849mbnWm/EcQ=
X-Received: by 2002:a17:90b:4b41:b0:2d8:b43b:6ecc with SMTP id
 98e67ed59e1d1-2d8b43b72b1mr797687a91.4.1725124767304; Sat, 31 Aug 2024
 10:19:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHhAz+hjhZQnTWX088EmMDbszAJrrBQBqkhvfiMjxQPNtWbkqw@mail.gmail.com>
 <212937.1724701599@turing-police>
In-Reply-To: <212937.1724701599@turing-police>
From: Muni Sekhar <munisekharrms@gmail.com>
Date: Sat, 31 Aug 2024 22:49:15 +0530
Message-ID: <CAHhAz+gML+kENh_5AgxZJxNn5iA2dD4CWbVO05nYi0eoY3vPhQ@mail.gmail.com>
Subject: Re: Query Regarding Stack-Out-of-Bounds Error
To: =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc: kernelnewbies <kernelnewbies@kernelnewbies.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 1:16=E2=80=AFAM Valdis Kl=C4=93tnieks
<valdis.kletnieks@vt.edu> wrote:
>
> On Mon, 26 Aug 2024 18:04:39 +0530, Muni Sekhar said:
>
> > static struct cmd_info *find_cmd_entry_any_ring(struct intel_gvt *gvt,
> >                unsigned int opcode, int rings)
> > {
> >         struct cmd_info *info =3D NULL;
> >         unsigned int ring;
> >         ...
> >         for_each_set_bit(ring, (unsigned long *)&rings, I915_NUM_ENGINE=
S) {
> >
> > In the above code, a 32-bit integer pointer (rings) is being cast to a
> > 64-bit unsigned long pointer, which leads to an extra 4 bytes being
> > accessed. This raises a concern regarding a stack-out-of-bounds bug.
> >
> > My specific query is: While it is logically understandable that a
> > write operation involving these extra 4 bytes could cause a kernel
> > crash, in this case, it is a read operation that is occurring.
>
> Note that 'ring' is located in the stack frame for the current function. =
So to
> complete the analysis - is there any way that the stack frame can be loca=
ted in
> such a way that 'ring' is the *very last* 4 bytes on a page, and the next=
 page
> *isn't* allocated, *and* I915_NUM_ENGINES is big enough to cause the loop=
 to walk
> off the end?
>
> For bonus points, part 1:  Does the answer depend on whether the architec=
ture
> has stacks that grow up, or grow down in address?

Here=E2=80=99s an example stack frame for context:

|---------------------------|
| Return Address |
|---------------------------|
| Saved Frame Pointer |
|---------------------------|
| Parameter: gvt |
|---------------------------|
| Parameter: opcode |
|---------------------------|
| Parameter: rings |
|---------------------------|
| Local Variable: info |
|---------------------------|
| Local Variable: ring |
|---------------------------|

Stack Growth Downwards:
If the stack grows downward in address space, is there any scenario
where the stack frame could be positioned such that the return address
is located at the very last 4 bytes of a page, the next page isn't
allocated, and I915_NUM_ENGINES is large enough to cause the loop to
walk off the end? If this happens, would it result in a
stack-out-of-bounds error leading to a kernel crash?

Stack Growth Upwards:
Conversely, if the stack grows upward, could the stack frame be
positioned in such a way that the 'ring' variable is at the very last
4 bytes of a page, and the next page isn=E2=80=99t allocated, with
I915_NUM_ENGINES being large enough to cause the loop to walk off the
end? Would this also result in a stack-out-of-bounds error causing a
kernel crash?

I'm curious as to why the likelihood of this error seems to depend on
whether the architecture has stacks that grow up or down in address
space. In both scenarios stack-out-of-bounds error behaves the same,
right?

>
> For bonus points, part 2: can this function be called quickly enough, and
> enough times, that it can be abused to do something interesting to L1/L2 =
cache
> and speculative execution, because some systems will fetch not only the b=
ytes
> needed, but as much as 64 or 128 bytes of cache line?  Can you name 3 sec=
urity
> bugs that abused this sort of thing?
Where should I look to find more details about these security bugs?
I appreciate your insights on these questions.
>
> Free hint:  There's a bit of interesting code in kernel/exit.c that tells=
 you if
> your system has gotten close to running out of kernel stack.
>
> [/usr/src/linux-next] dmesg | grep 'greatest stack'
> [    1.093400] [     T40] pgdatinit0 (40) used greatest stack depth: 1392=
0 bytes left
> [    3.832907] [     T82] modprobe (82) used greatest stack depth: 8 byte=
s left
>
> Hmm... wonder how that modprobe managed *that* :)
>
>
>


--=20
Thanks,
Sekhar

