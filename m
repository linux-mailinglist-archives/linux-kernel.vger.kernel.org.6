Return-Path: <linux-kernel+bounces-561197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF443A60EA2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 315474610D9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7538D1EEA54;
	Fri, 14 Mar 2025 10:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sX0bQETV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D455B1EEA4E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947718; cv=none; b=MsHVhzUtNL8xeM/LJvPfb3Rkl0UtSmzJrNtfapcIuIy3NLkTxnypvu5/bdI1ORtNYgUTofV8R7KX8zOAjQ/QQQazNRjrjCqnxzT891Ut1A7uDJJ9vI1qSvoIO7hPtu0wJSuqPGxXHBvZc+Sx8i9CKWWf0qXKj0Zhx3P5dyhVIFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947718; c=relaxed/simple;
	bh=qsAR7IGLyouVJD2CjKZ6DJZIqEb+ylyHnejR69obERw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9WPkR0II2nKfZqVSug2A8tYn9JEAzWuYto5XVcrcQtExrPd1QqFYKny7KzWloQId/HWjE1IiaOjYPrYCfSm6D64e2g9V9qclwpdvyHKlSAsJqs/Qf7qmsg3Qbf+WxMbDOtrNoVAXr7YcXktQBRfcyT4S8+Ld0bIGWH/P9TPKcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sX0bQETV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EECBC4CEE3;
	Fri, 14 Mar 2025 10:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741947718;
	bh=qsAR7IGLyouVJD2CjKZ6DJZIqEb+ylyHnejR69obERw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sX0bQETV51qG6OQTUObd4PbwaAVsaNvjy85cBJM2BSXtcjas5CRTIh+e9UglawTOO
	 mVqGznot5zNaYJrD6vzXCoL8D8tSBWncc5QkqG4TlChx251E96L5DpOoycoEysmVU6
	 elrem52VxdPA7n1gP92M6NvxlAVvPY/OvEoy6vUFUJxd+CZXi+LDP7lWcRDDNXNfyI
	 1dn2FbJ/ITQjKQ+fNjP0HqK6m8knQpXIjwY30Nyy7couTJjvP4bmS9SEGywl2OFI75
	 euTMKShuh2cP/KBCmIIyaHLmvY+YPC5pWAgIGrRlD9Oqf/o6YvWbYG5rwcMhPaw5Wj
	 JrP16erpInW7w==
Date: Fri, 14 Mar 2025 11:21:51 +0100
From: Ingo Molnar <mingo@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, jpoimboe@kernel.org,
	bsz@amazon.de
Subject: Re: [PATCH v7 0/8] x86/kexec: Add exception handling for
 relocate_kernel
Message-ID: <Z9QDP5NHp-5VupUS@gmail.com>
References: <20250312144257.2348250-1-dwmw2@infradead.org>
 <Z9K3dcMAgu3cot85@gmail.com>
 <Z9K5TGMvmS1ApBCW@gmail.com>
 <7f36d90ada07281dd0efa4339c991cb2ecec4da2.camel@infradead.org>
 <48dc1e006cbbf1f8af4c9120795a840c601ed172.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48dc1e006cbbf1f8af4c9120795a840c601ed172.camel@infradead.org>


* David Woodhouse <dwmw2@infradead.org> wrote:

> On Thu, 2025-03-13 at 19:58 +0000, David Woodhouse wrote:
> > 
> > Reproduced that by going back to x86-64 defconfig. 
> 
> Turns out the unret check doesn't even run unless CONFIG_DEBUG_ENTRY is
> enabled (which enables CONFIG_NOINSTR_VALIDATION and thus runs objtool
> on vmlinux.o). Which is why I didn't see it.
> 
> > vmlinux.o: warning: objtool: exc_handler+0xe: early indirect call
> 
> With Peter's help (thanks), this is fixed by adding VALIDATE_UNRET_END.
> I'll squash this into the next posting:
> 
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -481,6 +481,9 @@ SYM_CODE_START_NOALIGN(kexec_debug_exc_vectors)
>  SYM_CODE_END(kexec_debug_exc_vectors)
>  
>  SYM_CODE_START_LOCAL_NOALIGN(exc_handler)
> +       /* No need for ret mitigations during kexec */
> +       VALIDATE_UNRET_END
> +
>         pushq   %rax
>         pushq   %rbx
>         pushq   %rcx

Great!

I've applied patch #1 back to tip:x86/boot.

I've skipped the -v7 versions of patch #2 and #3 because AFAICS you've 
changed exc_handler already, so a backmerge of this annotation fix 
wouldn't be enough.

Thanks,

	Ingo

