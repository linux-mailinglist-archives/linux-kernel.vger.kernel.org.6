Return-Path: <linux-kernel+bounces-559294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D12A5F20E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26EEE7A962F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA910266591;
	Thu, 13 Mar 2025 11:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oXW1dn1U"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328A426656F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741864043; cv=none; b=YdKfJKnGp5tvB2I+Lur4bsRNpxJb7zKhREgYCiqnK4etXEIAwX8LI0ZvBANoGdmPOKe/YFRECumMSchzuY4PdH8XoiO/bMLCF7LWMjIm3tnPuyxGCaXLSpIJdgZWNSPNcJHwGbzD1lTsZp9b1YrZovWPIPuD2Nl/6XJROJLNL9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741864043; c=relaxed/simple;
	bh=iIZBfLwd/+EVr7vdpUWWGrQpCbn7rfw0UCu2ooXu9MA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=IBAIU6HE6ObhMPFcGgRKNQSGjBQGIK6ZT7juf7IdIivJ39OMc5ytca/rNNrCCjpFJ47H/EUMaLMGohDn1Jjq9XtPKxgfsdYxkNWxutPkV5eUveTYSAWmZ5AKglii56Uim9DsEX2PaYTeEMtltnCp/O4dea27wOwOfvCTPKDYN0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oXW1dn1U; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=9nPndKlBGpH1HfaiZ5n3YxHPWhlkltTY0RUhZkucvjE=; b=oXW1dn1UyLafqicb66AvNufzZs
	zcDQWeFnkmPIj4gumX1oAL887APOCqgJZXn01jyKr6UCfy1dGxOA3e4QnIikmglbF7enPCDUJuD9r
	+r5tsD6GZQOYHeeOxSk4d5CVI6wK0bRwcgWIJPw1lkjA35cOIzbZYDirQdwZds3wT+935TROeFyji
	XpgiY3vQ6y4EoHpQ6fCrbzqy8QsIkX8gaH/KiN+mOtJGq4fUqDldK8B+VmGXx/P6bqaOAX7aYQRDT
	9hKHCiR+VcRkWpYwM5K0k3IB/2i7FWzlakI1WTsKayD0c9ycZUFofJr3bhAd9OVXcRwVxAxpuEw+9
	1SWHOP3Q==;
Received: from [31.94.26.103] (helo=[127.0.0.1])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tsgP0-00000002aGf-1kCR;
	Thu, 13 Mar 2025 11:07:03 +0000
Date: Thu, 13 Mar 2025 12:06:58 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
CC: kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw@amazon.co.uk>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Nikolay Borisov <nik.borisov@suse.com>,
 linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Dave Young <dyoung@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 jpoimboe@kernel.org, bsz@amazon.de
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v7_7/8=5D_=5BDO_NOT_MERGE=5D_x86/k?=
 =?US-ASCII?Q?exec=3A_Add_int3_in_kexec_path_for_testing?=
User-Agent: K-9 Mail for Android
In-Reply-To: <Z9K3GXSaZUcVr8cb@gmail.com>
References: <20250312144257.2348250-1-dwmw2@infradead.org> <20250312144257.2348250-8-dwmw2@infradead.org> <Z9K3GXSaZUcVr8cb@gmail.com>
Message-ID: <0CDE8ED7-D8D2-4053-AE4B-4CFF59DB56F7@infradead.org>
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

On 13 March 2025 11:44:41 CET, Ingo Molnar <mingo@kernel=2Eorg> wrote:
>
>* David Woodhouse <dwmw2@infradead=2Eorg> wrote:
>
>> From: David Woodhouse <dwmw@amazon=2Eco=2Euk>
>>=20
>> Signed-off-by: David Woodhouse <dwmw@amazon=2Eco=2Euk>
>> ---
>>  arch/x86/kernel/relocate_kernel_64=2ES | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/arch/x86/kernel/relocate_kernel_64=2ES b/arch/x86/kernel/r=
elocate_kernel_64=2ES
>> index 17d41e6e1a4b=2E=2E2b7fc59af373 100644
>> --- a/arch/x86/kernel/relocate_kernel_64=2ES
>> +++ b/arch/x86/kernel/relocate_kernel_64=2ES
>> @@ -158,7 +158,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>>  	lidt	(%rsp)
>>  	addq	$10, %rsp
>> =20
>> -	//int3
>> +	int3
>
>So this is all boot-serialized functionality with no SMP concerns=20
>whatsoever, right?
>
>If yes then we could use something like this:
>
>	static int exception_selftest =3D 1;
>
>and add the INT3 point:
>
>	int3
>=2Eglobl after_int3
>after_int3:
>
>And do this in the early exception handler:
>
>	=2E=2E=2E
>=09
>	if (exception_selftest) {
>		exception_selftest =3D 0;
>
>		print_something_warm_and_fuzzy();
>
>		IRET-to-after_int3;
>	}
>
>	=2E=2E=2E
>
>	=2E=2E=2E regular exception path =2E=2E=2E
>
>=2E=2E=2E but all in assembly or so ;-)
>
>This would make it reasonably certain that the most complex bits of=20
>this new debuging code are in working order, all the time=2E
>
>Thanks,
>
>	Ingo

The exception handler already returns if the exception was int3, but not f=
or anything else=2E Less so the "print something warm and fuzzy" part; it j=
ust does the same register dump=2E But we could change that=2E

I'm less keen on making it unconditional though=2E Kexec is a performance-=
critical path when every millisecond is perceived as guest steal time, and =
the serial output should only happen in production if something goes *wrong=
*=2E

And besides, most kexec users don't have early_printk enabled anyway so if=
 we break them, this idea doesn't help=2E

