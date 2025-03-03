Return-Path: <linux-kernel+bounces-544681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 671D1A4E3E8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49D76189F7E0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A35A27E1CD;
	Tue,  4 Mar 2025 15:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRMT3DoX"
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6C32862AD
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101886; cv=pass; b=a3WuykRAfUA7BPuUJI2wdLAViEAgnZgVMenV3U3WM5+/B/o9wQ9zcJ4YkW3jFqUv1u2NEXc2WAUfa3QG5fgTQB3NpyQTCzzsHjDXQ4kmg42pJE1yWE8TKt2Zv5wxow0nMPhi6ywdpNXUvuVGvLIYN1w7+Nrod2cKYOJ9a9d2k8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101886; c=relaxed/simple;
	bh=PBniF7tJAvnfYFLkyJoohJ3zXJ6fnWiQdrYLzNNExSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lcDreqnnfW0Sef+x4Lz7+Carzma1r3zqD1ofrcOnEz+6QrravlmwOZPtWicDyHMplWcHd5G6+m8mL1tvfvvxnTbB+nW9Mt6rWu04y63jZffswNUw+ywFOFUcALTTdIZf2vwtodi2uU1v6BIgtK0CROSfiFJ58oOJb8nJ4KNVW48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRMT3DoX; arc=none smtp.client-ip=209.85.208.177; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id F216F40D4DFE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:24:42 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MRMT3DoX
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fZH26SmzG04w
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:22:47 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 4E75B42729; Tue,  4 Mar 2025 18:22:38 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRMT3DoX
X-Envelope-From: <linux-kernel+bounces-541698-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRMT3DoX
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 6B6104242F
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:24:07 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 48669305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:24:07 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C180018957E8
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FE820FAB7;
	Mon,  3 Mar 2025 12:23:52 +0000 (UTC)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607EB1EF0AE
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 12:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741004629; cv=none; b=CAuEBYeSMM5z+Xe6PG+bJwrZxof2I//SGBF4bg6xBiij17uG253NeknK8izWYqV0wUKyU1WWnEeBSSW1QoOzzBjygxh9UEGbFTRi+N3FeuFksAOrUu3Xw6bNVoPfjnjFFiUXk39IousuxZ82P8O0CXhOGO0sDT+IH8Z0Vvk4dWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741004629; c=relaxed/simple;
	bh=PBniF7tJAvnfYFLkyJoohJ3zXJ6fnWiQdrYLzNNExSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jOrnmzo5MmSeQJ6+wBZRlQ+oUtFI5mTUYfFjraUGnCacPzDngdMOGcMBXsTjsG4Hp2yQ7imiYN+O4oEMWB2rQABDDaZKpRJOwEXKysjen7Kp1IF/VWKYojDgI4TQGQtl1cBRwUMnFJliz+XYxzIW1ST6P/lyZZ2iWyaUV0/7Ek4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRMT3DoX; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30bb2fdbb09so12440201fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 04:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741004625; x=1741609425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3b8n/e/obQPdbwaKTdE8cviup54gD9KZn9hHTv3J5k=;
        b=MRMT3DoXTT4QU0T1zlhkiIVeQjOCtE/XQ212wve4AAmdEL0eq3D+/AIAVNCgwlvFVU
         i7QuZG45iL5QBeBYowTDXlNMhyHfoTybT73uR5RF04LOKBUiqXxu7U10zHJvdDIdXfZh
         0aEciMZROqj8vg0RjJxexW/ZGaGQ2Lj2GZcJy1P+Uqs13PaRwrb6NeCekM0dWJZ8VQNY
         PcFYs4F+Bmhe3Y5PkOKan1TCrzQhYeW+bTu2R69KSKHXzngNNXIRASs5d3IdxKnaJnAO
         YUB0L4GeGGWZdxOdaxF04zUW1FuiPmy5RZoJQnaozrdqNUwE9NTUKOe7tjCtfiVRqadO
         mOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741004625; x=1741609425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3b8n/e/obQPdbwaKTdE8cviup54gD9KZn9hHTv3J5k=;
        b=Bn2ai+u5yCU6//9Ikd1lgF7lZHYmj+ngD/ow3NY6bgv4+7lc/Jc8lpNxdouYwBbk7w
         yNcr96DHmOvV2vW/YiZaS24rTta7UxB0WCoTYraWFJrZm7DW8Srhe+rBzaQI8u2Cgoia
         JdtzxXQp0mZ/9q7fxrXoIkCzkU5Q38C8uwJ/NlbggeT2KyQKpY63Ysx8fRu0XOnCFCYe
         HFEos91qnU8zgc4tPihSm+ucVflrYUrJvE7ZZXsAOG/OlxKdhgyA4D7PkilmNNu8mIKK
         7RCCbmbJhV24kDIobOBtS8P8KMXkiHq374/CaaDQEBFRnRo47j3RcvlWsVo5ft5+icEl
         nl2g==
X-Forwarded-Encrypted: i=1; AJvYcCWnaV95iZusVd24KuXVljRMfRpcdbbAEwVYdowNBmA9mZWSUklCwU3bc6340DLhYKabqRmTxXj5OF3twxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0eh0S9EQg2//OaMoiHhLRYLFc5/JQUdxp06Xoxp76nfUY6nN2
	X9ThE71MnaKb9M6aHSBPzsh/3OYgKP9Rs4RVjdi8o7AHeIamwiU+6LCLxgw/kIAS1JJTSsIKn8A
	yw+IcN1cKta2/ybRXTO5rgkZ5XIc=
X-Gm-Gg: ASbGnctvPhxeTn+J6R+wlCj1H6+qJHA+5CSmZLYaFl5WGbJbdaiEeha7KAW36jEVkjR
	TW7Uv2DxPDKuxjxwFGG0YpPWjR54RAcRROWxzdrFOGhGVjt9Edq/Zz+/9EsUfS2x3j6ovl8J+Do
	q0c9VPM6Nh/1XKNSPTbJKDGxAb5g==
X-Google-Smtp-Source: AGHT+IFt3JVX/BisMG+/G1UID86/v92wdQg/oLatNZbzfg/rW8LDwl6VvBkenwA3C/SgERotoaPeY6+G4NPus3fHn9M=
X-Received: by 2002:a2e:895a:0:b0:30b:963e:9b1a with SMTP id
 38308e7fff4ca-30b963e9c3amr42491791fa.23.1741004623478; Mon, 03 Mar 2025
 04:23:43 -0800 (PST)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228123825.2729925-1-ubizjak@gmail.com> <20f1af22-71dc-4d62-9615-03030012222e@intel.com>
 <CAFULd4YBcG45bigHBox2pu+To+Y5BzbRxG+pUr42AVOWSnfKsg@mail.gmail.com>
In-Reply-To: <CAFULd4YBcG45bigHBox2pu+To+Y5BzbRxG+pUr42AVOWSnfKsg@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 3 Mar 2025 13:23:39 +0100
X-Gm-Features: AQ5f1JooaXyxsRyuA9byoZjx70TZThfklw3GcoJ1BIxTpBYPovCe2HhtAnddnWg
Message-ID: <CAFULd4ZsSKwJ4Dz3cCAgaVsa4ypbb0e2savO-3_Ltbs=1wzgKQ@mail.gmail.com>
Subject: Re: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic
 locking insns
To: Dave Hansen <dave.hansen@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fZH26SmzG04w
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741706580.1798@I8P7iNGF3CWbNkkr7jRSOg
X-ITU-MailScanner-SpamCheck: not spam

On Sun, Mar 2, 2025 at 9:56=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wrot=
e:
>
> On Fri, Feb 28, 2025 at 5:48=E2=80=AFPM Dave Hansen <dave.hansen@intel.co=
m> wrote:
> >
> > On 2/28/25 04:35, Uros Bizjak wrote:
> > > The code size of the resulting x86_64 defconfig object file increases
> > > for 33.264 kbytes, representing 1.2% code size increase:
> > >
> > >    text    data     bss     dec     hex filename
> > > 27450107        4633332  814148 32897587        1f5fa33 vmlinux-old.o
> > > 27483371        4633784  814148 32931303        1f67de7 vmlinux-new.o
> >
> > So, first of all, thank you for including some objective measurement of
> > the impact if your patches. It's much appreciated.
> >
> > But I think the patches need to come with a solid theory of why they're
> > good. The minimum bar for that, I think, is *some* kind of actual
> > real-world performance test. I'm not picky. Just *something* that spend=
s
> > a lot of time in the kernel and ideally where a profile points at some
> > of the code you're poking here.
> >
> > I'm seriously not picky: will-it-scale, lmbench, dbench, kernel
> > compiles. *ANYTHING*. *ANY* hardware. Run it on your laptop.
> >
> > But performance patches need to come with performance *numbers*.
>
> Please find lmbench results from unpatched (fedora.0) and patched
> (fedora.1) fedora-41 6.13.5 kernels.
>
> lmbench is from [1]
>
> [1] https://fedora.pkgs.org/41/rpm-sphere-x86_64/lmbench-3.0-0.a9.3.x86_6=
4.rpm.html
>
> Some tests show quite different results, but I'd appreciate some help
> in interpreting the results. Maybe they show that the price of 33
> kbytes is worth the improvement, or they will motivate someone
> experienced in kernel benchmarks to benchmark the patch in a more
> scientific way.

These go from:

Process fork+exit: 270.0952 microseconds
Process fork+execve: 2620.3333 microseconds
Process fork+/bin/sh -c: 6781.0000 microseconds
File /usr/tmp/XXX write bandwidth: 1780350 KB/sec
Pagefaults on /usr/tmp/XXX: 0.3875 microseconds

to:

Process fork+exit: 298.6842 microseconds
Process fork+execve: 1662.7500 microseconds
Process fork+/bin/sh -c: 2127.6667 microseconds
File /usr/tmp/XXX write bandwidth: 1950077 KB/sec
Pagefaults on /usr/tmp/XXX: 0.1958 microseconds

and from:

Socket bandwidth using localhost
0.000001 2.52 MB/sec
0.000064 163.02 MB/sec
0.000128 321.70 MB/sec
0.000256 630.06 MB/sec
0.000512 1207.07 MB/sec
0.001024 2004.06 MB/sec
0.001437 2475.43 MB/sec
10.000000 5817.34 MB/sec

Avg xfer: 3.2KB, 41.8KB in 1.2230 millisecs, 34.15 MB/sec
AF_UNIX sock stream bandwidth: 9850.01 MB/sec
Pipe bandwidth: 4631.28 MB/sec

to:

Socket bandwidth using localhost
0.000001 3.13 MB/sec
0.000064 187.08 MB/sec
0.000128 324.12 MB/sec
0.000256 618.51 MB/sec
0.000512 1137.13 MB/sec
0.001024 1962.95 MB/sec
0.001437 2458.27 MB/sec
10.000000 6168.08 MB/sec

Avg xfer: 3.2KB, 41.8KB in 1.0060 millisecs, 41.52 MB/sec
AF_UNIX sock stream bandwidth: 9921.68 MB/sec
Pipe bandwidth: 4649.96 MB/sec

Uros.


