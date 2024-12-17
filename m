Return-Path: <linux-kernel+bounces-449041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6685A9F48E5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32FC37A53E0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069D41DF992;
	Tue, 17 Dec 2024 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xzz/dgxy"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436071E3771
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 10:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734431422; cv=none; b=YdBCmH4kfT6eHKFMaV/11/NhzNX9u69LgqjZtkjNAIL3zgjnELuebquHk1hLVQyRJzMYKOMfaAgYTOtaiRxGm02Jlrx4uMhhL8B6UXBxQWOkXqCgQvIOOftOo2GET0lFgILnKU9Z7lJudjzxlRyk5nXHi4YzKFj6HKitjc7nIIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734431422; c=relaxed/simple;
	bh=fc4wn50i60mq+Dm0Qh6J/tmpBTHkS57i6cRyHCynELE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=bHYrOn8em49AeOjXdbNIfvvzw/pmCrHuwE6z9+eHwvy5IniqsqRcNTVkfhIxYGInRDN2eLSP0yNepYXsPgqpuKhTvttlXtDuuRMH4um99rXebsvoJQqaMpn2jFeAnPQ9lBZSmoUK2FIkoQH7Qmt6W5MNjjGta+k0Q0CCQdWi4bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Xzz/dgxy; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=fc4wn50i60mq+Dm0Qh6J/tmpBTHkS57i6cRyHCynELE=; b=Xzz/dgxylPHf8RPZ5bh9svZ0Le
	5cFy2EKzJsc9D9VEO86o3bs4MNTQSUdEtSHCy7QeUw4N/IlUoE8aXqdbYv/owP149oV6I8HJwUu7E
	9HWThw//PWRvlMNFOtpEaUtJKbGs6v58dg0bt1kntfZ0WF4p20R7ovFKSFkTws3VYZBmAtpX7o/pb
	8lGxxOZV+P+ikiVn7oDJVxU6oBDHZsqaSh5de0u8VQ/9t4CenjKiD+LXvYnvDUUFqLFKKCiHt2mRw
	fAWdfISPSiH/qYCBMaiTRYB+nwzS0GBrEoPfX5nE4qmuIkVwp5kts5fqIUVF6wnKYaKGuGfei9cML
	TQmIyi+g==;
Received: from [89.27.170.32] (helo=[127.0.0.1])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNUpw-000000053l0-3r0J;
	Tue, 17 Dec 2024 10:29:57 +0000
Date: Tue, 17 Dec 2024 11:29:56 +0100
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
Message-ID: <74A36EA6-D0C8-4CF3-A00B-77C852AC6527@infradead.org>
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
>containing regparm(0) from include/asm-i386/linkage=2Eh,=20

No, it's still there in arch/x86/include/asm/linkage=2Eh:
<https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/torvalds/linux=2Egit/=
tree/arch/x86/include/asm/linkage=2Eh#n20>

And maybe you're right that it's a poorly named macro and we shouldn't con=
flate calling convention with linkage=2E But I think it *should* be part of=
 the typedef=2E


