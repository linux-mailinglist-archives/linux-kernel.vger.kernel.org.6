Return-Path: <linux-kernel+bounces-443966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B66D9EFE51
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 22:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAAA91887191
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB7F1D63F9;
	Thu, 12 Dec 2024 21:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DdcKcQ7c"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D171AAE28
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 21:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734039171; cv=none; b=u2niJ1nSV4L9W/XtlDqS5ULP9rCWyX/t/TgC0b0NMYhYslsX2Sg00xe6f1UUUZeBe95rh9Aq7Od139iJggkVeQFIqMMMGkmr0ZOSLWDMM655kx2sEayxvQ2hxn7UsyROd8MWzRQR5h9h/0WKw0S8Gs3NAF455SYRgtlsSOKd9IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734039171; c=relaxed/simple;
	bh=JmfQNUZ2LCwMnUkxKUZMmgL4OCDGyj92NHxNeKZuec0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=oQufK8vZSRc7g+GZ+2gswuI756RE+KJMMLl00aGk7aR1vIOqQ/4ZtVtME3QSbME27q32HUyHuXnD3795mDhA2rd2sV9gstgh5CPyOEMALvn23tDB3NcweP481ea3nSoyBCi01wcN1/SzMVcDn8UEo/XZZfB/rc299F0jy/vsntU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DdcKcQ7c; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=JmfQNUZ2LCwMnUkxKUZMmgL4OCDGyj92NHxNeKZuec0=; b=DdcKcQ7cuNHF2354+sU3PRjUsg
	ATEX7o9UqzN3p3yW2GfQllE5gCmfCMatRHNfSW55LlsOUN+Ys8O18dRBpBfUNQWYonuDHnwDmP52c
	QNbJ13HwBMMfpg4jFWcqJuBvfCI/iXlQXXz88OThbuy+8wsk/0f6Sew+oo1ud0BG49hXbfNLiZnau
	PQ2gFmHQiNgkgC0PjGSogcw8QvKAyUN3YOLoJU6GxQNoRzj0Fl4JEhJpmBZ1s3ie0QO7dS+tp+C8V
	zFTaTGxBmqjZyT0cHb29MudNw4hGzAC5d1ymWgskKDzS+0IA4aem5orF9eAQ8qnmi7TBFo0UyiDJL
	T7UWNeAg==;
Received: from [2001:8b0:10b:5:fc92:5b26:d347:4188] (helo=[IPv6:::1])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tLqnL-000000048D0-3ttP;
	Thu, 12 Dec 2024 21:32:30 +0000
Date: Thu, 12 Dec 2024 21:32:27 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Dave Hansen <dave.hansen@intel.com>, Nathan Chancellor <nathan@kernel.org>
CC: "Ning, Hongyu" <hongyu.ning@linux.intel.com>, kexec@lists.infradead.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Nikolay Borisov <nik.borisov@suse.com>,
 linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Dave Young <dyoung@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 jpoimboe@kernel.org, bsz@amazon.de
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_x86/kexec=3A_Only_write_thr?=
 =?US-ASCII?Q?ough_identity_mapping_of_control_page?=
User-Agent: K-9 Mail for Android
In-Reply-To: <4517cb69-3c5c-4e75-8a14-dab136b29c19@intel.com>
References: <20241205153343.3275139-1-dwmw2@infradead.org> <20241205153343.3275139-14-dwmw2@infradead.org> <20241212014418.GA532802@ax162> <10a4058d9a667ca7aef7e1862375c2da84ef53a3.camel@infradead.org> <20241212150408.GA542727@ax162> <38aaf87162d10c79b3d3ecae38df99e89ad16fce.camel@infradead.org> <20241212174243.GA2149156@ax162> <9c68688625f409104b16164da30aa6d3eb494e5d.camel@infradead.org> <4517cb69-3c5c-4e75-8a14-dab136b29c19@intel.com>
Message-ID: <212CBB8E-CC94-4A56-8399-1419D8F2FA5C@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

On 12 December 2024 21:18:10 GMT, Dave Hansen <dave=2Ehansen@intel=2Ecom> w=
rote:
>On 12/12/24 12:11, David Woodhouse wrote:
>> From: David Woodhouse <dwmw@amazon=2Eco=2Euk>
>>=20
>> The virtual mapping of the control page may have been _PAGE_GLOBAL and
>> thus its PTE might not have been flushed on the %cr3 switch and it migh=
t
>> effectively still be read-only=2E Move the writes to it down into the
>> identity_mapped() function where the same %rip-relative addressing will
>> get the new mapping=2E
>>=20
>> The stack is fine, as that's using the identity mapped address anyway=
=2E
>
>Shouldn't we also ensure that Global entries don't bite anyone else?
>Something like the completely untested attached patch?
Doesn't hurt, but this is an identity mapping so absolutely everything oth=
er than this one page is going to be in the low (positive) part of the cano=
nical address space, so won't have had global pages in the first place will=
 they?

Probably a kind thing to do for whatever we're passing control to though :=
)

I'll round it up into the tree and send it out with the next batch of debu=
g support=2E Care to give me a SoB for it? You can s/CR0_PGE/CR4_PGE/ too i=
f you like but I can do that myself as well=2E

