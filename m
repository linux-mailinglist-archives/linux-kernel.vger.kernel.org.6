Return-Path: <linux-kernel+bounces-446231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDEE9F2180
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 00:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 308777A0FF8
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 23:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C459B1B87C8;
	Sat, 14 Dec 2024 23:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdJbRokL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0346A2940D
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 23:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734217705; cv=none; b=ClxVtPDzk+sSA8DRQL0ngLn+biRIY/tDALk+2tOUr8ZIWaKIsAvc7v4Qltx6zaMpndUi9cFTQTrrM1lIqPubGWESlrQaOkWspPXT6TnJz9Pn+VxyIEYeNpRQqq20MUz6KKklGCbllaoCQE+hdhs1Nz3d2gAQfpaCsVNlHLYdqrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734217705; c=relaxed/simple;
	bh=DCMAcL7xDPXNdRkO1BP6RdRGqW8I674U+TFd6LbBtHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GC/dEhz6n6xvjIymFHQSdvcSCPR17uuplq+mzV4Gak7jOEVSQVYUiyqDd4BeVM9DcFej1OagsP9Cw4ZXyDAq2QQDVcxPlags7lImOl8Ka2uXV0MSBZTRjyBOVBCCLKC4TwiUJ8edWpLfR03ZkDZQFDX7qCYJCdk4OmYa0E5FNIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdJbRokL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12482C4CED1;
	Sat, 14 Dec 2024 23:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734217704;
	bh=DCMAcL7xDPXNdRkO1BP6RdRGqW8I674U+TFd6LbBtHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WdJbRokLLiebkYAty5HRFTuNoEBFv+zchY6xmNb93rcz04AttZm3DiARt36gLktBv
	 xYcjHs7nDk4qTXLZ80HCjQwaSrzPikxnqp9ZlX6ZWqnKqiW2sJHIX9v0qyvQWFuuw4
	 +0cNkOaCY+dSwI086aqpJ86yyOcQIIggsnCZCO2TZgV5q6i+BVcOeJOfoxGrdn+OIZ
	 86R+xZ7IDKYaJnsUzawbFI8AmNGf7mIqyKL2dPtXZivzciEAHSXb35xVIZHF1hZyXZ
	 bTAp1GSIvEai88GAFhqVsWeNjeTaGalWcF7VrFVQ+IV/zG7JarRVQOJJT5kjn2zTtB
	 TzPXM97dt/JJQ==
Date: Sat, 14 Dec 2024 16:08:18 -0700
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
Subject: Re: [PATCH v5 07/20] x86/kexec: Invoke copy of relocate_kernel()
 instead of the original
Message-ID: <20241214230818.GA677337@ax162>
References: <20241205153343.3275139-1-dwmw2@infradead.org>
 <20241205153343.3275139-8-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205153343.3275139-8-dwmw2@infradead.org>

Hi David,

On Thu, Dec 05, 2024 at 03:05:13PM +0000, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> This currently calls set_memory_x() from machine_kexec_prepare() just
> like the 32-bit version does. That's actually a bit earlier than I'd
> like, as it leaves the page RWX all the time the image is even *loaded*.
> 
> Subsequent commits will eliminate all the writes to the page between the
> point it's marked executable in machine_kexec_prepare() the time that
> relocate_kernel() is running and has switched to the identmap %cr3, so
> that it can be ROX. But that can't happen until it's moved to the .data
> section of the kernel, and *that* can't happen until we start executing
> the copy instead of executing it in place in the kernel .text. So break
> the circular dependency in those commits by letting it be RWX for now.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  arch/x86/kernel/machine_kexec_64.c   | 30 ++++++++++++++++++++++------
>  arch/x86/kernel/relocate_kernel_64.S |  5 ++++-
>  2 files changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index 3a4cbac1a0c6..9567347f7a9b 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
...
>  void machine_kexec(struct kimage *image)
>  {
> +	unsigned long (*relocate_kernel_ptr)(unsigned long indirection_page,
> +					     unsigned long page_list,
> +					     unsigned long start_address,
> +					     unsigned int preserve_context,
> +					     unsigned int host_mem_enc_active);
>  	unsigned long page_list[PAGES_NR];
>  	unsigned int host_mem_enc_active;
>  	int save_ftrace_enabled;
> @@ -371,6 +387,8 @@ void machine_kexec(struct kimage *image)
>  		page_list[PA_SWAP_PAGE] = (page_to_pfn(image->swap_page)
>  						<< PAGE_SHIFT);
>  
> +	relocate_kernel_ptr = control_page;
> +

Because of this change...

>  	/*
>  	 * The segment registers are funny things, they have both a
>  	 * visible and an invisible part.  Whenever the visible part is
> @@ -390,11 +408,11 @@ void machine_kexec(struct kimage *image)
>  	native_gdt_invalidate();
>  
>  	/* now call it */
> -	image->start = relocate_kernel((unsigned long)image->head,
> -				       (unsigned long)page_list,
> -				       image->start,
> -				       image->preserve_context,
> -				       host_mem_enc_active);
> +	image->start = relocate_kernel_ptr((unsigned long)image->head,
> +					   (unsigned long)page_list,
> +					   image->start,
> +					   image->preserve_context,
> +					   host_mem_enc_active);

kexec-ing on a CONFIG_CFI_CLANG kernel crashes and burns:

RAX=0000000000000018 RBX=ff408cf982596000 RCX=0000000000000000 RDX=000000047fffb280
RSI=ff6c99a785943d20 RDI=000000011e145002 RBP=ff6c99a785943d70 RSP=ff6c99a785943d10
R8 =0000000000000000 R9 =0000000000000000 R10=00000000ab150dc6 R11=ff408cf99e139000
R12=0000000028121969 R13=00000000fee1dead R14=0000000000000000 R15=0000000000000001
RIP=ffffffff84c9c510 RFL=00010086 [--S--P-] CPL=0 II=0 A20=1 SMM=0 HLT=0
ES =0018 0000000000000000 ffffffff 00c09300 DPL=0 DS   [-WA]
CS =0010 0000000000000000 ffffffff 00a09b00 DPL=0 CS64 [-RA]
SS =0018 0000000000000000 ffffffff 00c09300 DPL=0 DS   [-WA]
DS =0018 0000000000000000 ffffffff 00c09300 DPL=0 DS   [-WA]
FS =0018 0000000000000000 ffffffff 00c09300 DPL=0 DS   [-WA]
GS =0018 0000000000000000 ffffffff 00c09300 DPL=0 DS   [-WA]
LDT=0000 0000000000000000 ffffffff 00c00000
TR =0040 fffffe441f360000 00004087 00008b00 DPL=0 TSS64-busy
GDT=     0000000000000000 00000000
IDT=     0000000000000000 00000000
CR0=80050033 CR2=00007ffde71dbfc0 CR3=00000001140b0002 CR4=00771ef0
DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000
DR6=00000000fffe0ff0 DR7=0000000000000400
EFER=0000000000000d01
Code=83 e1 01 48 8d 74 24 10 41 ba c6 0d 15 ab 45 03 53 f1 74 02 <0f> 0b 41 ff d3 0f 1f 00 48 89 43 18 f6 83 78 02 00 00 02 74 05 e8 16 06 da 00 44 89 3d 17

     a0c: 83 e1 01                      andl    $0x1, %ecx
     a0f: 48 8d 74 24 10                leaq    0x10(%rsp), %rsi
;   image->start = relocate_kernel_ptr((unsigned long)image->head,
     a14: 41 ba 67 a6 7c e6             movl    $0xe67ca667, %r10d      # imm = 0xE67CA667
     a1a: 45 03 53 f1                   addl    -0xf(%r11), %r10d
     a1e: 74 02                         je  0xa22 <machine_kexec+0x1c2>
     a20: 0f 0b                         ud2
     a22: 2e e8 00 00 00 00             callq   0xa28 <machine_kexec+0x1c8>
     a28: 48 89 43 18                   movq    %rax, 0x18(%rbx)

I guess this seems somewhat unavoidable because control_page is just a
'void *', perhaps machine_kexec() should just be marked as __nocfi? This
diff resolves that issue for me.

Cheers,
Nathan

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 9567347f7a9b..e77110c4bb91 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -334,7 +334,7 @@ void machine_kexec_cleanup(struct kimage *image)
  * Do not allocate memory (or fail in any way) in machine_kexec().
  * We are past the point of no return, committed to rebooting now.
  */
-void machine_kexec(struct kimage *image)
+void __nocfi machine_kexec(struct kimage *image)
 {
 	unsigned long (*relocate_kernel_ptr)(unsigned long indirection_page,
 					     unsigned long page_list,

