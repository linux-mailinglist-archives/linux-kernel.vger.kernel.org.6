Return-Path: <linux-kernel+bounces-448926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD71D9F4745
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22DE718917AF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4FF1E883A;
	Tue, 17 Dec 2024 09:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B0PU3uDO"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96001DE8AC
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734427104; cv=none; b=N9gtMYhS/x9/OhowDD2A4I4Gw14D7YX7OTlQdLnSIWsqAEACvGq0+5+oj4FCs601+pGi3dLKTWy4G62qJzfNhkgBManN4KiUtnnyC0TeEcFSnkJOzgW3QXVyxKxYIgZmCv0elnZ0gVuBaBvTN+v4d2fCKZVEMZ0tjn98QghgM9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734427104; c=relaxed/simple;
	bh=MKC708Gu2sQBSEArscQrvQuComBeE+q3/SivKMmKug0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=urucEx0UctaosWwaw+P29Pj7MFafJIZamD1rFm/tyIuPLL4JUk6NNkj+QuVP6RyQ4My5B+aeSYlW7PBwq9ZFPqoWg20pkVZJJNREMGyGjvq39f8BV6QyB/zPUzE4QrMV34iKRSVfk7z/vcxGPO7FXUqWcVA+6DnRkT0wafXydR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B0PU3uDO; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=dnOfrSXu0JD2nOetxwQoi6738KkFF17+szDt2emi6Bs=; b=B0PU3uDOutnr9aTA+vMh+yV+od
	Yt+eIzPugNj3vQGTAhbFuGZA2V/MPqlphrne1wVoZO6macsebeshtHbUoqObnKmB3RTsM8AY1kctC
	D9MMqg6fgsNkEACVPwRlfeZTE7jahAeBstnJNng0zeH7h8w21JE6FVLZZHCKfuXHxGfp3ZA3Gg0U8
	72ShrQxK2Ucob0ZySWqRHTATuqpMI1xJYgUaqaq+9oSrfaec6DMSbrr1+95MahVlDVX8regl7mZ8M
	UpDrxx4lFoLgG2aQz+Xa1ENBhJa6ECmW+EJ0VI9C7p4XOdXFoeu8+8HZkXgt6FRcXkH1jEH8oPWDW
	a0smCcSQ==;
Received: from [89.27.170.32] (helo=[127.0.0.1])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNTi7-0000000538i-2qU4;
	Tue, 17 Dec 2024 09:17:48 +0000
Date: Tue, 17 Dec 2024 10:17:47 +0100
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
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_8/9=5D_x86/kexec=3A_Cope_with_relocat?=
 =?US-ASCII?Q?e=5Fkernel=28=29_not_being_at_the_start_of_the_page?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMj1kXEvpPbkeUb-2nt28M0yCNzo6NqauCcCNpj2psoVRH+C=A@mail.gmail.com>
References: <20241216233704.3208607-1-dwmw2@infradead.org> <20241216233704.3208607-9-dwmw2@infradead.org> <CAMj1kXEvpPbkeUb-2nt28M0yCNzo6NqauCcCNpj2psoVRH+C=A@mail.gmail.com>
Message-ID: <6C7C48A4-4BF6-435F-B40D-D667DDB6F8C1@infradead.org>
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

On 17 December 2024 09:47:36 CET, Ard Biesheuvel <ardb@kernel=2Eorg> wrote:
>On Tue, 17 Dec 2024 at 00:37, David Woodhouse <dwmw2@infradead=2Eorg> wro=
te:
>>
>> From: David Woodhouse <dwmw@amazon=2Eco=2Euk>
>>
>> A few places in the kexec control code page make the assumption that th=
e
>> first instruction of relocate_kernel is at the very start of the page=
=2E
>>
>> To allow for Clang CFI information to be added to relocate_kernel(), as
>> well as the general principle of removing unwarranted assumptions, fix
>> them to use the external __relocate_kernel_start symbol that the linker
>> adds=2E This means using a separate addq and subq for calculating offse=
ts,
>> as the assembler can no longer calculate the delta directly for itself
>> and relocations aren't that versatile=2E
>>
>
>You can still avoid the absolute relocations though, =2E=2E=2E
=2E=2E=2E
>> +       addq    $identity_mapped, %rsi
>> +       subq    $__relocate_kernel_start, %rsi
>
>=2E=2E=2E if you turn this into
>
>0:     addq    $identity_mapped - 0b, %rsi
>       subq    $__relocate_kernel_start - 0b, %rsi

Is there any benefit to doing so? Are absolute relocations problematic?

