Return-Path: <linux-kernel+bounces-449010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB9B9F486F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92B5188488F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873541DF27F;
	Tue, 17 Dec 2024 10:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lOt6DQ8/"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570FF1DC747
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 10:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734430044; cv=none; b=S5XQGil7p8AvLDte4YAxjnG7Ohs6PmWeffMZAHzZJOLd1IdHrRmCb3GkHVvKHH5QECfL+aHcsfR5B6sJpOaf4JetTAx8aITw/F5MVHryQSLcdBnVhn2oyUSUfxqFkrJE8HfherJxnEHFo2uPb+neivi4R1GOuZExpZ+Cf1SGwMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734430044; c=relaxed/simple;
	bh=tTG8if1cFBa0UkHbhql2MRB0dk3EhU3EspWmWIt2AA8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=jHfIDeSr54l1yq6OAldpgDQXt+fAPVl3ce15DiDeyqhYUVu6qyJRNTFB2pnIUsxY7hVSG7EMTi57fGKbxy53C9kDt6CEQJOswRdySmxYfcC/Z2Mc/yRnhxwbPKUdyQPgjS3NNstI+pOGKvc/psPTzaW6/l/h4oTkMavxN84uYhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lOt6DQ8/; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=tTG8if1cFBa0UkHbhql2MRB0dk3EhU3EspWmWIt2AA8=; b=lOt6DQ8/oiDGkuAx/pS2y6mgpp
	HdzQa/TlKplkcTVzXwSRZtlGyE02UXHszw1CLqDIP0Ph1yhVsl7s5Y/xKbR83Pe2uG8gZIt1D2vNl
	nTLK/0v59xqZsM0N9+GalRk9pr+MSCPaKubc3K8nt2hVQXDW1bM7Xdm11XMpttL2iIT4jv1OdCcEP
	u7Le2Z6NBwApeICy6gVArHWMo4VuKNvCL902jpSztVkA7Uorq/4Yheh+mjdopk8znPQcyDgFrK16U
	4qgtXmtfLTsWCclvOKDifpSs+k2ZV2J8Ws1Btaub/dT5VrRW4lYwbuADo5uXWyRLX2zYeWmoyPYu7
	oINnL49w==;
Received: from [89.27.170.32] (helo=[127.0.0.1])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNUTh-000000053dm-2E3G;
	Tue, 17 Dec 2024 10:06:57 +0000
Date: Tue, 17 Dec 2024 11:06:57 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Ard Biesheuvel <ardb@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Eric Biederman <ebiederm@xmission.com>, David Woodhouse <dwmw@amazon.co.uk>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
 Yuntao Wang <ytcoode@gmail.com>, David Kaplan <david.kaplan@amd.com>,
 Tao Liu <ltao@redhat.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Breno Leitao <leitao@debian.org>, Wei Yang <richard.weiyang@gmail.com>,
 Rong Xu <xur@google.com>,
 =?ISO-8859-1?Q?Thomas_Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 Simon Horman <horms@kernel.org>, Dave Young <dyoung@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, bsz@amazon.de, nathan@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_9/9=5D_x86/kexec=3A_Use_typedef_f?=
 =?US-ASCII?Q?or_relocate=5Fkernel=5Ffn_function_prototype?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMj1kXE-60BqLx4VH6Cw_s0nt=bkx=oFQuts+m6sZFeziH1sqg@mail.gmail.com>
References: <20241216233704.3208607-1-dwmw2@infradead.org> <20241216233704.3208607-10-dwmw2@infradead.org> <CAMj1kXE2abZ8v83vSr5sDZ1QNF-WMr4XCMRhZoc9EW=JAwvdCA@mail.gmail.com> <A18A8675-B1FB-496E-9D8F-FAD412A3FF65@infradead.org> <CAMj1kXFiZvT1joU5gOhZTC18aYi4dPOnFbX1nsHgmnXNy6c6Wg@mail.gmail.com> <27388506-9BE8-4540-A444-166C49133295@infradead.org> <CAMj1kXE-60BqLx4VH6Cw_s0nt=bkx=oFQuts+m6sZFeziH1sqg@mail.gmail.com>
Message-ID: <111B7BEE-FDA0-4085-8A97-89EC9DE7A51B@infradead.org>
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

On 17 December 2024 10:54:19 CET, Ard Biesheuvel <ardb@kernel=2Eorg> wrote:
>On Tue, 17 Dec 2024 at 10:42, David Woodhouse <dwmw2@infradead=2Eorg> wro=
te:
>> Hm, I am perfectly happy to believe that my memory is failing me, espec=
ially when it comes to specifics of i386 assembler code=2E But are you also=
 telling me that
>> <https://kernelnewbies=2Eorg/FAQ/asmlinkage> is a lie?
>>
>
>It seems wildly out of date, at least=2E
>
>Commit 96a388de5dc53a8b2 from 2007 removed the asmlinkage definition
>containing regparm(0) from include/asm-i386/linkage=2Eh, and I'm not
>convinced it was ever sound to conflate linkage with calling
>convention like that=2E Today, asmlinkage evaluates to 'extern "C"' when
>using a C++ compiler, which is also not part of the type=2E
>
>However, I failed to notice that this just moves code around, and only
>applies to 32-bit in the first place=2E So I won't waste any more of
>your time obsessing over this=2E

Too late :)

You've already made me concerned about what the calling convention *is* fo=
r relocate_kernel() on i386=2E Because if asmlinkage doesn't mean regparm(0=
) any more and the i386 kernel is still built with -mregparm=3D3, then how =
does the asm code (which seems to believe all its arguments are on the stac=
k) actually work?

It seems slightly unlikely that kexec on i386 has just been broken since 2=
007 but I'm not sure I'd completely rule it out=2E

So now I guess I have to actually build a 32-bit userspace test case and *=
test* it=2E

And that means I no longer have any excuse for not doing all the same clea=
nups in the i386 version of the code that I've done for x86_64=2E=2E=2E

Thanks for that :)


