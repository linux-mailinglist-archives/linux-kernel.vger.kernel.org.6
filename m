Return-Path: <linux-kernel+bounces-545068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5A3A4E89F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C70219C46A2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184AC280A39;
	Tue,  4 Mar 2025 16:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIfEcwmt"
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B0B26460F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107503; cv=pass; b=ch2ip2KD+J9d0Tc9Xu80+eJg1TanEcpOd/5iOTSmqFKQNc7id82ItWv1ghsW0in1SsYJM0MCgjut21bjQhHLwlSieP+oD/VNV8BVDwtcBDoi03l+Fz/OyaJGeODG7tb1mu/i4XVtrDVMpjOu6k1IecOKQQTynDfk5MQfsgsAXh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107503; c=relaxed/simple;
	bh=FcZ1QaEWtyTndqxE0LHILSs0Kyeh6C+jJB4Mj+rNv+w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=laK1WdTzmZHO0cnrLrfO/tLuVeGpym7Y5Lkl6DpPZYtgD/rGAT3HgVOD8QdsLzPZFH45Zn3kLWelyMiJKG6hL0A58eHXV8TxVhnfi9+77w78j+x+7dkFjCyaDlDtxxFSbRTr2VyeYq8yUm+eMyYaq12pHElbD1czMQlp/6jtxnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIfEcwmt; arc=none smtp.client-ip=209.85.221.43; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id E1A5640D9766
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:58:19 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=mIfEcwmt
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6drs0L1DzFxgY
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:50:21 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 3F7D642724; Tue,  4 Mar 2025 17:50:03 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIfEcwmt
X-Envelope-From: <linux-kernel+bounces-541774-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIfEcwmt
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 3764C41A3D
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:13:09 +0300 (+03)
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 76D462DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:13:08 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42B417A47FD
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1F021148E;
	Mon,  3 Mar 2025 13:12:43 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A851CAA71
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 13:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007560; cv=none; b=srYBSkez4jjBfxAtXjBTs0d75ekW3mLiMcTGb4b7CyWWfarCh4VefAKTAEz1gMVnqprY5U+NuvPlnpZEcDBs3RjFH+EIwZLVANd2X1xFDNByhj1j+7LoZ/dUNGhBkLYoeREm9FKeDCfuEgtHlvdViOBAGfvAXiJPKqueNtW0bMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007560; c=relaxed/simple;
	bh=FcZ1QaEWtyTndqxE0LHILSs0Kyeh6C+jJB4Mj+rNv+w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XGRYB8xPmTcSPquBTEyv/7X2TxeTJzs/Gl0uLjuC7sxjQAAmDvnKT98SlXmDDjn3uEb4YWd2s89O7s5Xa5kvX1gcm/H8iSTqPs7p5KxZvYzChL1qobvkOOyeDsaPPIewO+GyVp3ZJmTiq+/fBtobUYUB9se+iSFuR8CN00O10X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIfEcwmt; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-390dd3403fdso3847550f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 05:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741007557; x=1741612357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiYRzF/fWDQOKl7jciF5ykDGkkm+nONe0hq5xgHmuZQ=;
        b=mIfEcwmtiSPKiRKNCmc/qAKSf5AdcBUjmjp9DFyp+cbSMThATluSeQfQ3EIuZBlmhn
         ahiHVSNjGnMFL2tnanoBmOrWTxq7YLo7S19aUqNOegiU20xDCfSWFzsH0xBwwErOW0q3
         nXMpqazUnj5mhrrodc2xgruHJlEbVB5kVV+OSZVvvQ1TzqPaDsrS/W5ZvN8chqyF0PJQ
         +t2MMh74juIEXAfLMw9kwoJq7R7UdsU03CTXhT9uUlJqfobK22LuJCCUbaL/EqNIpysL
         Y378w3lVbQPbE9XOQ+HeIopu+14JnxIWl6U6VJCNDa0uSnmNqprTFWjn2LYaf0SBXz6X
         zFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741007557; x=1741612357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiYRzF/fWDQOKl7jciF5ykDGkkm+nONe0hq5xgHmuZQ=;
        b=LJMZBOjVJ2z8zpIpC17dzN+rjWtCZhhqsY5V2I5ouKF3Ou1P8dFHE/NvTWzNLX48tE
         hPHYvB8Iw9Yhvta4LccmzetuUu+VkANWtguUwkJuo8M71IiknuwFPo/szN10o2gy9kVi
         JBc3kkppK7GZor1lk/Xf4yWnYSTn2EOQf5Py6ioamzfxzNZN0dBFj06GNxm71/SfL6wj
         X9wgPv74G8TaVX1KTbLabworlPrMDQq9CqaqO5r3e1sg8NmfIhgzUlQAIQVjjXRQCCSI
         rw2NdkLT1CUJUi3d/4RKLBkcWKHHtNrr0mkq8FX9G8ukjdqcEwsMztziFGqrcfoGGEwE
         TLmg==
X-Forwarded-Encrypted: i=1; AJvYcCVn9MfAnGUh28yuuDg5zbzci1uo8JSHL80j5NA+cmKIwgUrB7X1QO44F8t4c3wUg0QEwII8xlyznlnkL7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN282kqNzTuieYIj5gNlD0c5EfuoLl3kYTuDaMyNzSBiLth9gL
	WfchQqF8QpgSnsm1Glck5WlUlL6iSzHa8pEEGlRy8Sdd5F/EEjRH
X-Gm-Gg: ASbGncv/4+XFY8Y9RYp5bB/gmy5Z6ZuSY+xBvt+iAbEY4AzDspio6eIx3xMnB4NJ5/9
	AilkWD0oMTDbwsQy1EIyry6Z7FjBGs6mq+lRRKpQNTg6VD5CEcamGPvsKWlhVinm0eOjtVMIN/r
	N9Pr5Ta2vYGI0G65Harh8Ee0YVt51nI+uI8YxXFpIkcUTkSP7CTjcSGeJNLE8UhbTikHXi+ZtkY
	wByoZuUZdtm90cgOhQcBTmJ6uX+NXXzxTBrzSp+8NXD7EIWRN51D8iCcqb3Hxil8uH7ZVbgk95I
	0MJBhjqR10EoZJ+wzub4Usv0FLRNhco/jQu2PIvnQKlFAseI0CMAc0Pl04XL9AkHGYexQGtJEhb
	f6VMZLNU=
X-Google-Smtp-Source: AGHT+IG+3HK80cjS08v6+YP5br2EDbuB4ZN2d7EFt+zxJkRoPG+7fWt39kUBWPrj/oCKzTQ6fqsIMw==
X-Received: by 2002:a05:6000:402a:b0:38f:2efb:b829 with SMTP id ffacd0b85a97d-390eca815a6mr10788175f8f.50.1741007556492;
        Mon, 03 Mar 2025 05:12:36 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485d6cdsm14391389f8f.84.2025.03.03.05.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:12:35 -0800 (PST)
Date: Mon, 3 Mar 2025 13:12:34 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>
Subject: Re: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic
 locking insns
Message-ID: <20250303131234.0a2e20e4@pumpkin>
In-Reply-To: <c4aca08a-95c1-48ee-b4da-55a69b74101c@intel.com>
References: <20250228123825.2729925-1-ubizjak@gmail.com>
	<20f1af22-71dc-4d62-9615-03030012222e@intel.com>
	<CAFULd4bpHGE83qc37sbh=rpGj+SFqQrsNDLzL_-NQpo6pQH3jw@mail.gmail.com>
	<c4aca08a-95c1-48ee-b4da-55a69b74101c@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6drs0L1DzFxgY
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741712174.49899@ewFu2emnEnR9CASgOFvfeQ
X-ITU-MailScanner-SpamCheck: not spam

On Fri, 28 Feb 2025 14:58:47 -0800
Dave Hansen <dave.hansen@intel.com> wrote:

> On 2/28/25 14:31, Uros Bizjak wrote:
> > On Fri, Feb 28, 2025 at 5:48=E2=80=AFPM Dave Hansen <dave.hansen@intel.=
com> wrote: =20
> >>
> >> On 2/28/25 04:35, Uros Bizjak wrote: =20
> >>> The code size of the resulting x86_64 defconfig object file increases
> >>> for 33.264 kbytes, representing 1.2% code size increase:
> >>>
> >>>    text    data     bss     dec     hex filename
> >>> 27450107        4633332  814148 32897587        1f5fa33 vmlinux-old.o
> >>> 27483371        4633784  814148 32931303        1f67de7 vmlinux-new.o=
 =20
> >>
> >> So, first of all, thank you for including some objective measurement of
> >> the impact if your patches. It's much appreciated.
> >>
> >> But I think the patches need to come with a solid theory of why they're
> >> good. The minimum bar for that, I think, is *some* kind of actual
> >> real-world performance test. I'm not picky. Just *something* that spen=
ds
> >> a lot of time in the kernel and ideally where a profile points at some
> >> of the code you're poking here.
> >>
> >> I'm seriously not picky: will-it-scale, lmbench, dbench, kernel
> >> compiles. *ANYTHING*. *ANY* hardware. Run it on your laptop.
> >>
> >> But performance patches need to come with performance *numbers*. =20
> >=20
> > I don't consider this patch a performance patch, it is more a patch
> > that fixes a correctness issue. The compiler estimates the number of
> > instructions in the asm template wrong, so the patch instructs the
> > compiler that everything in the template in fact results in a single
> > instruction, no matter the pseudos there. The correct estimation then
> > allows the compiler to do its job better (e.g. better scheduling,
> > better inlining decisions, etc...). =20
>=20
> Why does it matter if the compiler does its job better?
>=20
> I'll let the other folks who maintain this code chime in if they think
> I'm off my rocker. But, *I* consider this -- and all of these, frankly
> -- performance patches.

I was looking at some size changes related to a different 'trivial'
code change.
It caused gcc to make apparently unrelated inlining decisions that caused
some functions to grow/shrink by +/-100+ bytes even though the actual
change would mostly only add/remove a single instruction.

I've lost the patch for this one, but if the asm block does expand to a
single instruction it is likely to making gcc decide to inline one of the
functions that uses it - so increasing overall code size.
Whether that helps or hinders performance is difficult to say.

	David




