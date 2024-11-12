Return-Path: <linux-kernel+bounces-405559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503A49C52E2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16FCF280D9F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C91120EA32;
	Tue, 12 Nov 2024 10:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lz8wX3hh"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89491EE02B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731406476; cv=none; b=dOBO/B9pJcJqtgK8dBNA1z86SgMUfmo3VLG9Am2zU4Xqowipn7R2jSkzqDOP3aqjl5XlECiqAPKfzP3aTcKKRlPesY1clUkCWf9WBTT2n4mE+qHEGM/pPHfhFRMOqvEtluJhRMWncM6vdkRn7DObzQraOiMaetJ1OJ65dfq3JSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731406476; c=relaxed/simple;
	bh=NI2FSn6wR9NllQpa1yQiYOWhZtDJAgUAJVvJXNP2daY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RY5GHkBu17u81aXrI3SgwaIsRsRcz3uYdy+qw5vrQIWDzNAbD88IyoKTWsKqUtSgFZFsC2xAHaCg2GFSKcd9fQszoK1om1AE6t7m+CnXWrmvJRTPiZunVTNB2Vksi2c6588y5Xrl2kw1754Tmp63ILo3UO4596wpdEk9Rsnlkpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Lz8wX3hh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=NI2FSn6wR9NllQpa1yQiYOWhZtDJAgUAJVvJXNP2daY=; b=Lz8wX3hh3vIxhltmyWPz1aRlQn
	kWu59NA/aM1/3WjpsFfFE3ZgkPK8u9TMSbPtwr3mEzLidEio5ah/99Y7tmc/L7Ptfp/RwQ90hxljZ
	81C3LnCjpVBNCclD1/BWuQOqwMchTzPgMG10fSvD9OPaU6Mfg9JXHpqW2Zst8tqOPfrPu4OIpnrvl
	SEOButaG95BZKrqdY7Ui/yna2q4m+WpHri4Z/ma18p3GpODoZ1lpRpHqsQOmoPFg7t7lHk+Sox0fB
	XFQ3iqjB2LKTE8MGIO/lNohTEnJ/uG3nPEcACbfKTZ01p/nENMqyFn+L1zIAhgntrvLuaWE5zy+yH
	RpZAfrRw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tAnui-0000000EDfU-1WT0;
	Tue, 12 Nov 2024 10:14:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F4081300478; Tue, 12 Nov 2024 11:14:23 +0100 (CET)
Date: Tue, 12 Nov 2024 11:14:23 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, kexec@lists.infradead.org,
	jpoimboe <jpoimboe@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>
Subject: Re: [RFC PATCH 2/2] x86/kexec: Add data section to relocate_kernel
Message-ID: <20241112101423.GO22801@noisy.programming.kicks-ass.net>
References: <1983c62c02b863f6d70198730dbb55a1ef7ceb9f.camel@infradead.org>
 <20241108052241.3972433-1-dwmw2@infradead.org>
 <20241108052241.3972433-2-dwmw2@infradead.org>
 <B26FDB75-D8F3-4D9C-9078-C536C461A7CF@zytor.com>
 <1e8f11982ad0754d8123c143a514969fa2a07c05.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1e8f11982ad0754d8123c143a514969fa2a07c05.camel@infradead.org>

On Tue, Nov 12, 2024 at 08:44:33AM +0000, David Woodhouse wrote:
> On Fri, 2024-11-08 at 12:26 +0100, H. Peter Anvin wrote:
> >=20
> > > --- a/arch/x86/kernel/vmlinux.lds.S
> > > +++ b/arch/x86/kernel/vmlinux.lds.S
> > > @@ -100,7 +100,7 @@ const_pcpu_hot =3D pcpu_hot;
> > > =A0=A0=A0=A0=A0=A0=A0=A0. =3D ALIGN(PAGE_SIZE);=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0\
> > > =A0=A0=A0=A0=A0=A0=A0=A0__relocate_kernel_start =3D .;=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0\
> > > =A0=A0=A0=A0=A0=A0=A0=A0*(.text.relocate_kernel);=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0\
> > > -=A0=A0=A0=A0=A0=A0=A0*(.rodata.relocate_kernel);=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0\
> > > +=A0=A0=A0=A0=A0=A0=A0*(.data.relocate_kernel);=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0\

Why are we having data in the middle of the text section?

> > > =A0=A0=A0=A0=A0=A0=A0=A0__relocate_kernel_end =3D .;
> > > #else
> > > #define KEXEC_RELOCATE_KERNEL_TEXT
> >=20
> > Looks good at first glance. I'm currently traveling so I haven't
> > fully reviewed it though.
>=20
> Turns out it doesn't help much. It's neater, obviously, but objtool
> still wants to disassemble the .data.relocate_kernel section after it
> gets included in the overall kernel text section.

Objtool only decodes stuff that has SHF_EXECINSTR set. Why would your
data sections have that on?


