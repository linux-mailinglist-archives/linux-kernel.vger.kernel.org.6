Return-Path: <linux-kernel+bounces-448957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3291D9F47AF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23999161F24
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155AF3D69;
	Tue, 17 Dec 2024 09:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DjhXm7HR"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23F11D2B11
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734428193; cv=none; b=Idp3/clUbE8vWlOsTCFgPoR5yHaFQYygvA1+uoZ7KJBkD/3RF5LoFSd4ZzBbaWczqsRvk7/dL03oFnRaXdmFB2ozd+ysta0L6M0SaHfHVxwNd6lXPhHXQNcx001nvG4601vW/cQvbs1ka4uq+J0PzaklZicTjzGFX8WQn1aSJ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734428193; c=relaxed/simple;
	bh=o1AQFg4Q0RBIe6E/X1scAomfzilS8F21ukJunQ9lOSk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=GMyM30riyv+crnTDK63LOGSrHaNsWxH2/MIiM7R7jx4ti4W0SoZuUAhwT/I7exAePp33cKa3h/juO9RnwRdbPRjNvQaaZuL9W9jiPvFCIixQh1PLqHE5dhQcK+twXHn+7+pA4Y1HXe0sCeyfVPtewj35IQmhznkbDqeyBO0w+gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DjhXm7HR; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=x4Kq1ApCTlotm3kGOsN5CuO5LU5x9azOwncXT/pe8tY=; b=DjhXm7HRsnmyAQ13PT8NE0U5hC
	5NeyC1gq0vPhkhGp//zZmyr/3s5zc3sIEj6nZlf/wmJQs54ukBUu0IOMi2kAmAFEjRbgPK6IdHP8u
	jBEAfvERHncEye0MG5Wtdx9To8HAgqer5pyJNJ8vCSdpqOITxYFP4Ja9LWtOJim1qTRJam00jzjqJ
	ccEP9T/IbHn9a9F6rKcIe/MocE0bJS53d8VL0ZZt+W22Gphe0XRx2plwGCUx2YPnN1WNVyb6ogDEt
	6pri9GfL52N0KngLGZYOGGGj6J0qauIyiYZCsdL7PNn95RMZ6s+sur8LlbDOI4mNgijv4sN18LYaH
	6T1YyMzw==;
Received: from [89.27.170.32] (helo=[127.0.0.1])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNTzp-000000053Ry-46wr;
	Tue, 17 Dec 2024 09:36:06 +0000
Date: Tue, 17 Dec 2024 10:36:05 +0100
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
In-Reply-To: <CAMj1kXF5C8TF02obuNrd6tZBZg0_Yz_VskGuNMnmoqyjLRAVRg@mail.gmail.com>
References: <20241216233704.3208607-1-dwmw2@infradead.org> <20241216233704.3208607-9-dwmw2@infradead.org> <CAMj1kXEvpPbkeUb-2nt28M0yCNzo6NqauCcCNpj2psoVRH+C=A@mail.gmail.com> <6C7C48A4-4BF6-435F-B40D-D667DDB6F8C1@infradead.org> <CAMj1kXF5C8TF02obuNrd6tZBZg0_Yz_VskGuNMnmoqyjLRAVRg@mail.gmail.com>
Message-ID: <FF6D6B84-58BC-4768-A112-C5B9A684F1A5@infradead.org>
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

On 17 December 2024 10:25:56 CET, Ard Biesheuvel <ardb@kernel=2Eorg> wrote:
>On Tue, 17 Dec 2024 at 10:17, David Woodhouse <dwmw2@infradead=2Eorg> wro=
te:
>>
>> On 17 December 2024 09:47:36 CET, Ard Biesheuvel <ardb@kernel=2Eorg> wr=
ote:
>> >On Tue, 17 Dec 2024 at 00:37, David Woodhouse <dwmw2@infradead=2Eorg> =
wrote:
>> >>
>> >> From: David Woodhouse <dwmw@amazon=2Eco=2Euk>
>> >>
>> >> A few places in the kexec control code page make the assumption that=
 the
>> >> first instruction of relocate_kernel is at the very start of the pag=
e=2E
>> >>
>> >> To allow for Clang CFI information to be added to relocate_kernel(),=
 as
>> >> well as the general principle of removing unwarranted assumptions, f=
ix
>> >> them to use the external __relocate_kernel_start symbol that the lin=
ker
>> >> adds=2E This means using a separate addq and subq for calculating of=
fsets,
>> >> as the assembler can no longer calculate the delta directly for itse=
lf
>> >> and relocations aren't that versatile=2E
>> >>
>> >
>> >You can still avoid the absolute relocations though, =2E=2E=2E
>> =2E=2E=2E
>> >> +       addq    $identity_mapped, %rsi
>> >> +       subq    $__relocate_kernel_start, %rsi
>> >
>> >=2E=2E=2E if you turn this into
>> >
>> >0:     addq    $identity_mapped - 0b, %rsi
>> >       subq    $__relocate_kernel_start - 0b, %rsi
>>
>> Is there any benefit to doing so? Are absolute relocations problematic?
>
>Every absolute relocation produces an entry in the relocation table
>that needs to be applied at every boot when KASLR is in effect=2E Beyond
>that, it doesn't matter=2E
>
>I've looked into PIC codegen/PIE linking for the core kernel, which is
>why this caught my eye=2E If that effort ever advances, I'll need to
>revisit this code as well and apply the change I suggested=2E

Ack, I'll roll it in to the next revision if Ingo hasn't rounded this set =
up of fixes up already=2E (On which topic, since I took the easy way out of=
 the CFO thing, this patch isn't strictly needed to fix a regression in tip=
/x86/boot so can be dropped for now too=2E)

Thanks=2E


