Return-Path: <linux-kernel+bounces-568045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C58BA68D62
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78139170E0A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA3D2512EF;
	Wed, 19 Mar 2025 13:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QdsrnKnf"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D0654F8C
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 13:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742389478; cv=none; b=T1FMCHnl2o/eivOufZ1zDpuyHE/yw2zCrNFPfJyUW4WqNi5RLXiO55zZgtQ0wMibXlaJY7I/bJlSUxCzyNYLhPv1jVgJrfY5dxPvJXf6CSJM5WBJaO+5ptN2EzwuNUx2uBHquGWaebnfNHpumk3gvNFM29Zm/CJ21WLvAoB9U94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742389478; c=relaxed/simple;
	bh=0S4BZB+xQEGALpPVbgTW4s7zJ7oCcB8Ue3WKffODqhQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=THNVzAFUB42dFyw5ZfiKgvW8Uh4VH5vQUqGZIGSicUVjucy20YcAJpvjnK6L81bGwlREJZ/JzdEOs7ooZmFy9PXOJOPPcoeUtGu3De8eBVeLpnPC3b31jBWux+86VHnxpIlt90A1ArmrHQOHLdUgVVuOGq374JCqVHL7ZUXDWSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QdsrnKnf; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ewqf9+grSmpFEbh21C/yVk01rtLR2PLzAxGZJjplfd4=; b=QdsrnKnf/WhbDzETUnkmiQ2e0B
	LlWSpcbbVp6YIXgDbhdhMIB9kepeMA0l7s+RIu8qzHrWFge3jRcUrrIoOLz1iws6/xepEmw0LVx4q
	w7WS+nGDiqmoEIfmESD7dzwjpU5MmNb/bz7eywfAzVSYDvkxbQv5dDUIMe+cMhaMlfWPmMSd9lDfw
	h8g+jPl4xeoHBapsMuRdyZ9ixaiMUBaY8zSi1LgyLuis4hE6ssKcn5c/REEQHbNquM9IUwI7gsGER
	k4+qVlTuoYwhIL0N5chJ1uiSCpKNa3dZvAsUajxPQOP3U9xZ7YWPDziOZ38MhM031kxcFooYn1c31
	+/ECdUhA==;
Received: from [2a00:23ee:2938:208a:ce64:7b9e:6eae:d0dc] (helo=[IPv6:::1])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tut5p-00000003xtA-3jDH;
	Wed, 19 Mar 2025 13:04:22 +0000
Date: Wed, 19 Mar 2025 13:04:20 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
CC: kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Nikolay Borisov <nik.borisov@suse.com>,
 linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Dave Young <dyoung@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 bsz@amazon.de
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v7_8/8=5D_=5BDO_NOT_MERGE=5D_x86/kexec=3A_?=
 =?US-ASCII?Q?Add_CFI_type_information_to_relocate=5Fkernel=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <orpk67p2yolcb4gi462wqwphaaio6ivny2gcfcw4jna3uyaak5@oty7arlxxykl>
References: <20250312144257.2348250-9-dwmw2@infradead.org> <ra6zlx2iz7eks3y4ymoi6mn7o6rvnjc3lnjoaadf3szaocbkae@yg2lyjzlnqdn> <c2471b0a81ebd183d32e76f995a70b7912c1d4a1.camel@infradead.org> <7tq4tti5pv7fjboiapuglkcsodl4nsk53rj36skg4xb2bkysei@ncoz2ztiddm7> <970a4932cb95bc8934dc2ad15e8e84a2a51d2232.camel@infradead.org> <wzc2owczflbhfho6xcgnl3mnrutdvmqz46xgo54g2ahorhpo5l@rykdsdkjw4fd> <6swzz4732x5kfeg3qsif2r5s5ado3nbweznm6alsxvniy4xq6a@z6foorhlhelj> <9c41ab61efc573e3ab5a75b6e4031f81db84a846.camel@infradead.org> <awucsfjn475mvwg7xhihexln2hfbtvrie2uv333u7awtkz4mrf@t57pi7jibytc> <e48391c54a4ba27795919099f8ea25c29d868000.camel@infradead.org> <orpk67p2yolcb4gi462wqwphaaio6ivny2gcfcw4jna3uyaak5@oty7arlxxykl>
Message-ID: <8BD39200-583E-4835-BA0B-90409E0E55C4@infradead.org>
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

On 18 March 2025 22:41:43 GMT, Josh Poimboeuf <jpoimboe@kernel=2Eorg> wrote=
:
>On Tue, Mar 18, 2025 at 09:06:58PM +0000, David Woodhouse wrote:
>> On Tue, 2025-03-18 at 10:14 -0700, Josh Poimboeuf wrote:
>> > On Tue, Mar 18, 2025 at 03:56:36PM +0000, David Woodhouse wrote:
>> > > For the relocate_kernel() case I don't think we care much about the
>> > > first=2E Without a CFI prologue, no *other* code can be tricked int=
o
>> > > calling relocate_kernel()
>> >=20
>> > But for FineIBT the hash is checked on the callee side=2E=C2=A0 So it=
 loses
>> > FineIBT protection=2E
>>=20
>> Right now the relocate_kernel() code doesn't even have an endbr, does
>> it? So it isn't a useful gadget?
>
>In that case wouldn't IBT explode when you indirect call it?  Or is IBT
>getting disabled beforehand?

Not sure of the details=2E The machine_kexec() function which is the *call=
er* is currently marked with the __nocfi tag which stops any software check=
s=2E I guess any hardware feature which requires an endbr to be the target =
of an indirect branch has to already disabled on the way down? What specifi=
cally am I looking for, to check that? Or the hardware support has just nev=
er worked with kexec, perhaps?

>> > > =E2=80=94 and besides, it's in the kernel's data
>> > > section and isn't executable anyway until the kexec code copies it =
to a
>> > > page that *is*=2E
>> >=20
>> > Does the code get copied immediately before getting called, or can it=
 be
>> > initialized earlier during boot when kdump does its initial setup?
>>=20
>> It's initialized earlier, in machine_kexec_prepare(), and then the page
>> is set ROX=2E
>
>If that happens during boot (like for kdump init) then it'll be in text
>the whole time after boot, right?

In an executable page, yes=2E



