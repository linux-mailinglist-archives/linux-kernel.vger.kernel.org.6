Return-Path: <linux-kernel+bounces-449184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F4E9F4B16
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54F4C1888AA3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2031F37C9;
	Tue, 17 Dec 2024 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KoYWFBPN"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8547B1F2C23
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 12:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734439169; cv=none; b=Uq1DvO697MTNPIrnWVIFihyA26QcPNqaLE6Dn6vmbDjAVIYyN4C2BzRpHBCdaWIZeCFCeqg2AI7CTYN+vjxymR7hAGmX2GghOnn9erM4TXVdadi/HNwOzuG/4JAA4J86e/sswEBbVUlr9R/9z3dvstagIU16EeTbJonvBGmxyF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734439169; c=relaxed/simple;
	bh=Hmju1iOLKKopVgXqpmGGz1rnfVBjAnp4yWxkW52/q7A=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=iLqEYVO6EVX6CR5cB3SOAMIqkzf48J07eQBlFNuoviCncI4thvUpnc3c5NQB/xsY3ANp+ZefYszQI4S2Ts3sisSpFGFmZZNwk6jFBQmPBveA/pZdlbDRqHCkIM//7fRAXJnDDWF8Q7depm+s7nJMOwesnJpayEPyUqfbJ95ii8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KoYWFBPN; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Hmju1iOLKKopVgXqpmGGz1rnfVBjAnp4yWxkW52/q7A=; b=KoYWFBPNKhf9S+KxTOkzRGkST2
	KfkIqDW5feg+r6JZDH7KRqzjKyOpLD6o+kKPCiRjQZgLkW7NKessOFMr4OmNg3zHW01CGwnAEzjBT
	F0OzBqcvKVMAh8CFxrWzB8S+W+HVtaAkV7kEw3yP9l3TvXtZxPO4X0eiaxLmCynuG0ePVrfj++hgB
	t3aDmtY2RvOOywtH0ocUupjUoNTt1pApDfD1GbQw5pY/O4jKFIWpUDTu4OGuY37/fGg9UGaATNJWV
	HC6FtZCWf8E9mH+D4KQMqli6rhdfzoPTgXMPW7kmg9X/l3cSHA5Tu4HjzhSOScqQybHRm6Pn1eycF
	dHHBiQng==;
Received: from [89.27.170.32] (helo=[127.0.0.1])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNWqr-000000054da-32wx;
	Tue, 17 Dec 2024 12:39:01 +0000
Date: Tue, 17 Dec 2024 13:39:01 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Eric Biederman <ebiederm@xmission.com>, David Woodhouse <dwmw@amazon.co.uk>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
 Yuntao Wang <ytcoode@gmail.com>, David Kaplan <david.kaplan@amd.com>,
 Tao Liu <ltao@redhat.com>, Kai Huang <kai.huang@intel.com>,
 Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Breno Leitao <leitao@debian.org>, Wei Yang <richard.weiyang@gmail.com>,
 Rong Xu <xur@google.com>,
 =?ISO-8859-1?Q?Thomas_Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 Simon Horman <horms@kernel.org>, Dave Young <dyoung@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, bsz@amazon.de, nathan@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/9=5D_x86/kexec=3A_Disable_glob?=
 =?US-ASCII?Q?al_pages_before_writing_to_control_page?=
User-Agent: K-9 Mail for Android
In-Reply-To: <tksesvqt266x6a6mnoi5aqa3fhsoyo7mbp277elrrft5eieoba@7ospdizq22y6>
References: <20241216233704.3208607-1-dwmw2@infradead.org> <20241216233704.3208607-2-dwmw2@infradead.org> <tksesvqt266x6a6mnoi5aqa3fhsoyo7mbp277elrrft5eieoba@7ospdizq22y6>
Message-ID: <D5246E62-F850-4869-8365-0399E0C1C82A@infradead.org>
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

On 17 December 2024 13:25:48 CET, "Kirill A=2E Shutemov" <kirill=2Eshutemov=
@linux=2Eintel=2Ecom> wrote:
>On Mon, Dec 16, 2024 at 11:24:08PM +0000, David Woodhouse wrote:
>> From: David Woodhouse <dwmw@amazon=2Eco=2Euk>
>>=20
>> The kernel switches to a new set of page tables during kexec=2E The glo=
bal
>> mappings (_PAGE_GLOBAL=3D=3D1) can remain in the TLB after this switch=
=2E This
>> is generally not a problem because the new page tables use a different
>> portion of the virtual address space than the normal kernel mappings=2E
>>=20
>> The critical exception to that generalisation (and the only mapping
>> which isn't an identity mapping) is the kexec control page itself =E2=
=80=94
>> which was ROX in the original kernel mapping, but should be RWX in the
>> new page tables=2E If there is a global TLB entry for that in its prior
>> read-only state, it definitely needs to be flushed before attempting to
>> write through that virtual mapping=2E
>>=20
>> It would be possible to just avoid writing to the virtual address of th=
e
>> page and defer all writes until they can be done through the identity
>> mapping=2E But there's no good reason to keep the old TLB entries aroun=
d,
>> as they can cause nothing but trouble=2E
>>=20
>> Clear the PGE bit in %cr4 early, before storing data in the control pag=
e=2E
>
>It worth noting that flipping CR4=2EPGE triggers TLB flush=2E I was not s=
ure
>if CR3 write is required to make it happen=2E


Well, until we flip to the new CR3 the read-only PTE can just get reloaded=
=2E But after CR4=2EPGE is cleared, of course they won't be global any more=
=2E So they will get flushed (again) when CR3 is reloaded=2E

Maybe it could run a tiny bit faster if we change CR3 before CR4? I don't =
know that we care about microbenchmarking kexec to that degree, but I may t=
ake a look=2E=2E=2E


