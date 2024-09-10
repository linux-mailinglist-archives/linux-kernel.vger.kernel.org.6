Return-Path: <linux-kernel+bounces-323244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAEF9739F4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D0481F256F8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D1E19309C;
	Tue, 10 Sep 2024 14:34:57 +0000 (UTC)
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCAC44C61
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725978897; cv=none; b=n/xhusqHsbPTbwga0gP0gRgAZ2JL5ojFC+zYFsixRVpxpNJ5bZ7kLMz3macsQEZ5fO5EupqXsX7v6TZW7c5uJz20n0VUgf08qXQkVl0qS0uRMYie6UBC64itsOM0Oz6C7IZtoeHa58kELgCIjilqX4/UQRe4M0gEoKGP4+RlSLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725978897; c=relaxed/simple;
	bh=4k2ec8VACAoqg+An/GOPdPVKJ8vCZO9vhZhup3QewKs=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=OUaE28DbSBRceJdUypVziINrudLnJ72fgH244ufVS4NDEfRkpuHY9xFJOYNBc3nrBLw0NUPk+wz6PV7ERFJIDizz9QJtTabGVdwlhqSMbsuZb2bwiqJe3Z58gYNEebJtcfh/Z8OWld3yTAsgDpUL8mdKvMrQXZyopGmJ1SmEWu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:42914)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1so1xG-00FsQo-5h; Tue, 10 Sep 2024 08:34:54 -0600
Received: from ip68-227-165-127.om.om.cox.net ([68.227.165.127]:40992 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1so1xF-009ILd-83; Tue, 10 Sep 2024 08:34:53 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>,  Ingo Molnar <mingo@redhat.com>,
  Borislav Petkov <bp@alien8.de>,  Dave Hansen
 <dave.hansen@linux.intel.com>,  x86@kernel.org,  "H. Peter Anvin"
 <hpa@zytor.com>,  Kees Cook <kees@kernel.org>,  Thomas Gleixner
 <tglx@linutronix.de>,  linux-kernel@vger.kernel.org,  linux-mm@kvack.org
References: <20240910-x86-vdso-ifdef-v1-0-877c9df9b081@linutronix.de>
	<20240910-x86-vdso-ifdef-v1-2-877c9df9b081@linutronix.de>
Date: Tue, 10 Sep 2024 09:34:46 -0500
In-Reply-To: <20240910-x86-vdso-ifdef-v1-2-877c9df9b081@linutronix.de>
	("Thomas =?utf-8?Q?Wei=C3=9Fschuh=22's?= message of "Tue, 10 Sep 2024
 12:11:36 +0200")
Message-ID: <8734m7d1bt.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-XM-SPF: eid=1so1xF-009ILd-83;;;mid=<8734m7d1bt.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.165.127;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/5nJlFCi/KfV2IZRNiDXTTg5WDWy0TuzA=
X-Spam-Level: **
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4779]
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.7 XMSubLong Long Subject
	*  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: =?ISO-8859-1?Q?**;Thomas Wei=c3=9fschuh <thomas.weissschuh@linutronix.de>?=
X-Spam-Relay-Country: 
X-Spam-Timing: total 369 ms - load_scoreonly_sql: 0.07 (0.0%),
	signal_user_changed: 12 (3.2%), b_tie_ro: 10 (2.7%), parse: 1.55
	(0.4%), extract_message_metadata: 15 (3.9%), get_uri_detail_list: 1.72
	(0.5%), tests_pri_-2000: 8 (2.1%), tests_pri_-1000: 3.7 (1.0%),
	tests_pri_-950: 1.42 (0.4%), tests_pri_-900: 1.29 (0.3%),
	tests_pri_-90: 82 (22.2%), check_bayes: 80 (21.8%), b_tokenize: 9
	(2.4%), b_tok_get_all: 7 (1.9%), b_comp_prob: 2.3 (0.6%),
	b_tok_touch_all: 58 (15.8%), b_finish: 1.02 (0.3%), tests_pri_0: 228
	(61.8%), check_dkim_signature: 0.63 (0.2%), check_dkim_adsp: 2.7
	(0.7%), poll_dns_idle: 0.86 (0.2%), tests_pri_10: 1.74 (0.5%),
	tests_pri_500: 10 (2.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/2] x86: vdso: Remove redundant ifdeffery around
 in_ia32_syscall()
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, kees@kernel.org, hpa@zytor.com, x86@kernel.org, dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com, luto@kernel.org, thomas.weissschuh@linutronix.de
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out02.mta.xmission.com); SAEximRunCond expanded to false

Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de> writes:

> The ifdefs only guard code that is also guarded by in_ia32_syscall(),
> which already contains the same ifdefs itself.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
>  arch/x86/entry/vdso/vma.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
> index 9059b9d96393..ab2b011471e0 100644
> --- a/arch/x86/entry/vdso/vma.c
> +++ b/arch/x86/entry/vdso/vma.c
> @@ -75,7 +75,6 @@ static vm_fault_t vdso_fault(const struct vm_special_ma=
pping *sm,
>  static void vdso_fix_landing(const struct vdso_image *image,
>  		struct vm_area_struct *new_vma)
>  {
> -#if defined CONFIG_X86_32 || defined CONFIG_IA32_EMULATION
>  	if (in_ia32_syscall() && image =3D=3D &vdso_image_32) {
>  		struct pt_regs *regs =3D current_pt_regs();
>  		unsigned long vdso_land =3D image->sym_int80_landing_pad;
> @@ -86,7 +85,6 @@ static void vdso_fix_landing(const struct vdso_image *i=
mage,
>  		if (regs->ip =3D=3D old_land_addr)
>  			regs->ip =3D new_vma->vm_start + vdso_land;
>  	}
> -#endif
>  }
>=20=20
>  static int vdso_mremap(const struct vm_special_mapping *sm,
> @@ -339,7 +337,6 @@ int compat_arch_setup_additional_pages(struct linux_b=
inprm *bprm,
>=20=20
>  bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
>  {
> -#if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
>  	const struct vdso_image *image =3D current->mm->context.vdso_image;
>  	unsigned long vdso =3D (unsigned long) current->mm->context.vdso;
>=20=20
> @@ -348,7 +345,6 @@ bool arch_syscall_is_vdso_sigreturn(struct pt_regs *r=
egs)
>  		    regs->ip =3D=3D vdso + image->sym_vdso32_rt_sigreturn_landing_pad)
>  			return true;
>  	}
> -#endif
>  	return false;
>  }

Have you tested to verify that after this change
arch_syscall_is_vdso_signature compiles out the "image" and "vdso"
variables?

If the compilers don't it might be worth it rearrange the code as:
	if (in_ia32_syscall()) {
		const struct vdso_image *image =3D current->mm->context.vdso_image;
		unsigned long vdso =3D (unsigned long) current->mm->context.vdso;

		if (image =3D=3D &vdso_image_32) {
                	....
                        return true;
                }
	}
        return false.

Making the variables depend upon in_ia32_syscall() so you can be certain
they are compiles out.

Eric


