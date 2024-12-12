Return-Path: <linux-kernel+bounces-442466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 527E09EDD2C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 02:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84C7C1889894
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 01:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AC957CBE;
	Thu, 12 Dec 2024 01:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dL8TQ+GG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19C0EADC
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 01:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733967865; cv=none; b=iod+C5yJHhdKVioBDZwoAgXAhrg9wwU4UPf6nf4AIqtqGCw6ROJiLf0vDJh1sWkhQ5LOrBF9MXUzQGPRiQLUyZiNeUqUrJhxcOIhiCH7UAf+aI30/fGxZ+eJCeKRtGIL76myYeNsr0DvHiSajXc3WRgiVAd8zID+rQ4DnNVE0vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733967865; c=relaxed/simple;
	bh=34vk6AEt+sQ+WlXMU2daDueKQ3iZvBQUNASg9c9mZCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROcvFqe5zY8ZD1qRdwevrCEOPrYWmIj9VxgXzIi560I/0/XK57hEorUTXMCl4b7Uk3GGSFYBkFsGBryf/zc1GZ9To4VvBVujfVp+1B4wAcpNGqTP3AzuUNwYDHMiLQ5Sv+Q7Jx/5zf+dwGDMUqHAa/7KM8zgbpDrFyPVJM5veaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dL8TQ+GG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5EEC4CED2;
	Thu, 12 Dec 2024 01:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733967864;
	bh=34vk6AEt+sQ+WlXMU2daDueKQ3iZvBQUNASg9c9mZCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dL8TQ+GGYSGiOYTO3ti9GFhqBl6GdZSyHfRMQxVaI4S9arYXMR5OlJxcNLJHpd8c9
	 cmwUoWG0B1V5MHJNEfbzhnmRZ6EfSrnV3DIHGwtBLaLyNXPfbTpL+QfvCvuP70tiAQ
	 Wyq3KGygkjL5pAHn7suGi/F1PvYCjeg1rx9VCja/h+NzOP2rxhRjvh1/6o40CZw9q/
	 CMXwFf1/gwKHwbX8xEhYRFJRzRH+5PEe0P7OnL0uPYUptWC7PBVW8/V7dLMf0YQV2S
	 F5pW3wCIpltmF9FBCbFzDQZbsFW8dvpAI2qNCn3VRWPEFLXarBYqV9ZTks/yZ+qK0G
	 GiPYvr0PDNtvQ==
Date: Wed, 11 Dec 2024 18:44:18 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, jpoimboe@kernel.org,
	bsz@amazon.de
Subject: Re: [PATCH v5 13/20] x86/kexec: Mark relocate_kernel page as ROX
 instead of RWX
Message-ID: <20241212014418.GA532802@ax162>
References: <20241205153343.3275139-1-dwmw2@infradead.org>
 <20241205153343.3275139-14-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205153343.3275139-14-dwmw2@infradead.org>

Hi David,

On Thu, Dec 05, 2024 at 03:05:19PM +0000, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> All writes to the page now happen before it gets marked as executable
> (or after it's already switched to the identmap page tables where it's
> OK to be RWX).
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  arch/x86/kernel/machine_kexec_64.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index c9fd60f8f806..9232ad1562c8 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -323,7 +323,7 @@ int machine_kexec_prepare(struct kimage *image)
>  
>  	__memcpy(control_page, __relocate_kernel_start, reloc_end - reloc_start);
>  
> -	set_memory_x((unsigned long)control_page, 1);
> +	set_memory_rox((unsigned long)control_page, 1);
>  
>  	return 0;
>  }
> @@ -333,6 +333,7 @@ void machine_kexec_cleanup(struct kimage *image)
>  	void *control_page = page_address(image->control_code_page);
>  
>  	set_memory_nx((unsigned long)control_page, 1);
> +	set_memory_rw((unsigned long)control_page, 1);
>  
>  	free_transition_pgtable(image);
>  }
> -- 
> 2.47.0
> 

I just bisected a change in behavior that I see in to this change in
-next as commit 5a82223e0743 ("x86/kexec: Mark relocate_kernel page as
ROX instead of RWX"). I usually kexec my machines by running:

  # kexec --load /boot/vmlinuz-linux --initrd /boot/initramfs-linux.img --reuse-cmdline

  # systemctl kexec

to cleanly shutdown userspace then kexec into the new kernel after
installing it via the package manager. After this change, I get sent to
systemd-boot after running 'systemctl kexec', which selects the default
entry, my distribution kernel.

I just see:

  [  OK  ] Reached target Reboot via kexec.
  BdsDxe: loading Boot0007 "Linux Boot Manager" from HD(1,GPT,4B5AFD80-5EC7-47FC-83EA-7EC88ACB15A7,0x800,0x200000)/\EFI\systemd\systemd-bootx64.efi
  BdsDxe: starting Boot0007 "Linux Boot Manager" from HD(1,GPT,4B5AFD80-5EC7-47FC-83EA-7EC88ACB15A7,0x800,0x200000)/\EFI\systemd\systemd-bootx64.efi

then the systemd-boot menu in QEMU when reproducing this there.

Is this expected? If not, I am happy to provide any information or test
patches as necessary.

Cheers,
Nathan

# bad: [91e71d606356e50f238d7a87aacdee4abc427f07] Add linux-next specific files for 20241211
# good: [7cb1b466315004af98f6ba6c2546bb713ca3c237] Merge tag 'locking_urgent_for_v6.13_rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect start '91e71d606356e50f238d7a87aacdee4abc427f07' '7cb1b466315004af98f6ba6c2546bb713ca3c237'
# good: [9bad64b10df19351b07b2b93048635b5f8ead706] Merge branch 'main' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect good 9bad64b10df19351b07b2b93048635b5f8ead706
# good: [bbc8183219f75fe643d317bd335742adf512e7e1] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git
git bisect good bbc8183219f75fe643d317bd335742adf512e7e1
# bad: [0628a859f2df1bda9b05393f4eb931fa41c81296] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git
git bisect bad 0628a859f2df1bda9b05393f4eb931fa41c81296
# good: [c768ae7d664f116d55257647d7c60e4980b3f740] Merge branch 'next' of git://github.com/cschaufler/smack-next
git bisect good c768ae7d664f116d55257647d7c60e4980b3f740
# bad: [93a9ff8f5de55d40ab01b36227307b9e1aa61f16] Merge branch into tip/master: 'x86/boot'
git bisect bad 93a9ff8f5de55d40ab01b36227307b9e1aa61f16
# good: [72f64caa52d11b73c0b886aafaa3f549b49a3b84] Merge branch into tip/master: 'perf/core'
git bisect good 72f64caa52d11b73c0b886aafaa3f549b49a3b84
# good: [2a77e4be12cb58bbf774e7c717c8bb80e128b7a4] sched/fair: Untangle NEXT_BUDDY and pick_next_task()
git bisect good 2a77e4be12cb58bbf774e7c717c8bb80e128b7a4
# good: [4b5bc2ec9a239bce261ffeafdd63571134102323] x86/kexec: Allocate PGD for x86_64 transition page tables separately
git bisect good 4b5bc2ec9a239bce261ffeafdd63571134102323
# good: [b7155dfd4999211247cce40be2665c71235ab094] x86/kexec: Eliminate writes through kernel mapping of relocate_kernel page
git bisect good b7155dfd4999211247cce40be2665c71235ab094
# bad: [a3eaa2be7004ed7ce5cf8939c660e44a15fc3665] x86/sysfs: Constify 'struct bin_attribute'
git bisect bad a3eaa2be7004ed7ce5cf8939c660e44a15fc3665
# bad: [5a82223e0743fb36bcb99657772513739d1a9936] x86/kexec: Mark relocate_kernel page as ROX instead of RWX
git bisect bad 5a82223e0743fb36bcb99657772513739d1a9936
# good: [93e489ad7a4694bb2fe8110f5012f85bd3eee65a] x86/kexec: Clean up register usage in relocate_kernel()
git bisect good 93e489ad7a4694bb2fe8110f5012f85bd3eee65a
# first bad commit: [5a82223e0743fb36bcb99657772513739d1a9936] x86/kexec: Mark relocate_kernel page as ROX instead of RWX

