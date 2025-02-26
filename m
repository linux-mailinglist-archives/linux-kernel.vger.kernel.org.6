Return-Path: <linux-kernel+bounces-533136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1FBA45608
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC1763AD6FC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CEF269AED;
	Wed, 26 Feb 2025 06:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fg4jsyjZ"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA1F267B77
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740552707; cv=none; b=Tv9+B1LCwRSKEws0ncszTPMSmcoQxpQodq9cqlJcAGjnzrJIAc5xc7CmIiLzq6jsKXE6oelIx/O4knE1L8CqRGV466yvcDOIqJngaPVfyrCArtmd2sJNgPeTfTOE2iXdmV+GqsLGkYJ4f/n4jFDpc5TH1/J+jAZKhxEVDpBdyYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740552707; c=relaxed/simple;
	bh=gQt4uvwzi+yI/Ho/qaGi9ScgX+6wrk0tZ04EZq4q7G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3TyQ64bekwkWXcKLKkh2mNwMAbNdtilTobOuOCk2NRpb7/jRvKHMR//BB4qUO5kaGQNBVM9HUYLovb7yz0Fmrhd7J+RgvHpGKKovbszqfUTq7VSSfWsi6dnbKukRU67UxZbQbcpxqLsi8PbVeL9AKBoM2tNEWfukLPiMzu1j/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fg4jsyjZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22113560c57so45222035ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740552705; x=1741157505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H9Y6UOLHlk2ecsYC6FP7mpwrb5S7apuCvRXbHLnzqAY=;
        b=Fg4jsyjZY/zPenvlkU+Md8WQGFJJwqxaTUaUz55V5Y+MceIhh0IH0dKMEmvmt4e84q
         BFmjrjiqBu9TsxH7RwJCdZoc+tasCRqD+jNrppOfkPBJcglpBt4fJeXpJJwjtw+LMh2Q
         8myfizvgx+LIBE3MyJx7HqUCNfvZhx7KLnXNikOYcWUIgqtfHZthg8KYrvz0nZuFXdVw
         1obCK1nX15o9m0kRZTPIl+kY915AyLVqixeioZXvhv1mMCnnPL67cf07xIWP3TKeEdMd
         MkoyoAaqbDwW7k6ZFU11USLV2MkDxbtfr7jBdr7N0xwyKN7+AU78Rb8axFKuqcNiwI3Y
         Nm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740552705; x=1741157505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9Y6UOLHlk2ecsYC6FP7mpwrb5S7apuCvRXbHLnzqAY=;
        b=Rt9eTwxi1UtO/a9ylANq2hQvVQLgb66hNvXqY1Djtes4Yk5JCPQ28qlvWq9RFBlp6z
         3vFkf3HZ9IDitVe+bYVM7BjRxK3djJe0q3vu0YwsrmBhWtA93L1od8zJulFLMQZDGCMN
         yRhOTNQSrjWv2CtH7q/qjKLI2tHZBslkh5xSqV4giPJdzGfqq5TD3OTs/hspJ4W5kC4S
         JZ1q4G0G9U8ShlV7qFqrRL5djscEuECEmTaqs3KsR/MO1zsbtDkQNSWTiq+BMnRSSRx3
         651gRymnV/CtRVJk0N1bI5pTVSWZtZPHXzr231CrLszyHjFkVruxzcKlo3eenI2TT1bt
         82Dg==
X-Forwarded-Encrypted: i=1; AJvYcCU3x8Q7sUejA4avvIX1itZGgMsxBEuJJ2/Qp9jUKYeaKJFTt3GTD86PLG149qcDxE9roeriqDFcAypOHio=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaxSJxmh2oP+EokVIGQxcoBe5/J88+OsclgBSPEGWPFpg7gk6W
	whaD1ggSx28vKJ44QpL7mQv2e1QRiWuhQSndvtfAxqvsXXaYaNLT
X-Gm-Gg: ASbGncsD+1N/IA9mwbXO9uV2S5z/XKk7sebibI+j0rLlgfPtIWbZAG0cS8UPidAD4Sr
	nTsxoLzru6ma66HdKCmL07Nfsz/QwgMKzueHojmBDLJmUGKd2NMumvADU/9VPfgIlPqEWjrdRkT
	VHq1b3nk2mCnTdjI2VkOJ8tlAMu1FzBreo9GWj6uR2dcSX/7j2miFDVDqi03LyjeaoMcCY+zrFG
	uEDTQr7BHpaWF60d/oTfdsZiLMQm5gcSoosxGR2Bv9EFWR4Rvyhz5qbLTa7OpISSjqAo3Or/WgJ
	rKin29o3wrwuXYJzMmcHxA3qyDjl7O0WMB90mirkCA==
X-Google-Smtp-Source: AGHT+IEytS7db6bI6tnqshbz/jWJQrj+o7rLH7DXq+K4BvYgA1Ttvm6InCBmaNkugrgzQ3VqR4OEKg==
X-Received: by 2002:a17:903:22cc:b0:21f:35fd:1b7b with SMTP id d9443c01a7336-221a1195022mr296711565ad.50.1740552704682;
        Tue, 25 Feb 2025 22:51:44 -0800 (PST)
Received: from vaxr-BM6660-BM6360 ([2001:288:7001:2703:553c:b91:ab91:e34a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a09c716sm25065745ad.159.2025.02.25.22.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 22:51:43 -0800 (PST)
Date: Wed, 26 Feb 2025 14:51:38 +0800
From: I Hsin Cheng <richard120310@gmail.com>
To: yury.norov@gmail.com
Cc: anshuman.khandual@arm.com, arnd@arndb.de, linux-kernel@vger.kernel.org,
	jserv@ccns.ncku.edu.tw, skhan@linuxfoundation.org, mka@chromium.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH v3] uapi: Revert "bitops: avoid integer overflow in
 GENMASK(_ULL)"
Message-ID: <Z765-uSYQb986RTZ@vaxr-BM6660-BM6360>
References: <20250225165437.1554395-1-richard120310@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225165437.1554395-1-richard120310@gmail.com>

On Wed, Feb 26, 2025 at 12:54:37AM +0800, I Hsin Cheng wrote:
> This patch reverts 'commit c32ee3d9abd2("bitops: avoid integer overflow in
>  GENMASK(_ULL)")'.
> 
> The code generation can be shrink by over 1KB by reverting this commit.
> Originally the commit claimed that clang would emit warnings using the
> implementation at that time.
> 
> The patch was applied and tested against numerous compilers, inclduing
> gcc-13, gcc-12, gcc-11 cross-compiler, clang-17, clang-18 and clang-19.
> Various warning levels were set (-W=0, -W=1, -W=2) and CONFIG_WERROR
> disabled to complete the compilation. The results show that no compilation
> errors or warnings were generated due to the patch.
> 
> The results of code size reduction are summarized in the following table.
> The code size changes for clang are all zero across different versions,
> so they're not listed in the table.
> 
> For NR_CPUS=64 on x86_64.
> ----------------------------------------------
> |	        |   gcc-13 |   gcc-12 |   gcc-11 |
> ----------------------------------------------
> |       old | 22438085 | 22453915 | 22302033 |
> ----------------------------------------------
> |       new | 22436816 | 22452913 | 22300826 |
> ----------------------------------------------
> | new - old |    -1269 |    -1002 |    -1207 |
> ----------------------------------------------
> 
> For NR_CPUS=1024 on x86_64.
> ----------------------------------------------
> |	        |   gcc-13 |   gcc-12 |   gcc-11 |
> ----------------------------------------------
> |       old | 22493682 | 22509812 | 22357661 |
> ----------------------------------------------
> |       new | 22493230 | 22509487 | 22357250 |
> ----------------------------------------------
> | new - old |     -452 |     -325 |     -411 |
> ----------------------------------------------
> 
> For arm64 architecture, gcc cross-compiler was used and QEMU was
> utilized to execute a VM for a CPU-heavy workload to ensure no
> side effects and that functionalities remained correct. The test
> even demonstrated a positive result in terms of code size reduction:
> * Before: 31660668
> * After: 31658724
> * Difference (After - Before): -1944
> 
> An analysis of multiple functions compiled with gcc-13 on x86_64 was
> performed. In summary, the patch elimates one negation in almost
> every use case. However, negative effects may occur in some cases,
> such as the generation of additional "mov" instruction or increased
> register usage> The use of "~_UL(0) << (l)" may even result in the
> allocations of "%r*" registers instead of "%e*" registers (which are
> 32-bit registers) because the compiler cannot assume that the higher
> bits are zero.
> 
> Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
> ---
> Changelog:
> 
> v1 -> v2:
> 	- Refer the patch explicitly as a revert of commit c32ee3d
> 	- Squash commits into 1 commit
> 	- Perform compilation for numerous compilers, architectures and
> 	  compare code size shrink for each of them
> 	- Perform cpu-heavy workload test inside x86_64 VM and ARM64 VM
> 	- Analyze the result of disassembly of several small use cases
> 
> v2 -> v3:
> 	- Refactor code to single line
> 	- Disabled CONFIG_WERROR to ensure no additional compilation errors or warnings
> 	- Remove description for unrelated compilation errors and warnings
> 	- Summarize the result into a better looking table
> 	- Rephrase the patch and fix typos
> 
> 
> Hi Yury,
> 
> Sorry about the last iteration that I included everything, making
> the email too large and difficult to read. However, you still reviewed
> it and gave me feedbacks, really big thanks for your patience and those
> feedbacks. Running these tests also gave me a great opportunity to learn
> a lot.
> 
> If there's anything else needed to be test or modified, please let
> me know, I'll ammend them as soon as possible.
> 
> Hi David,
> 
> Thanks for your advise on alternative ideas for this code. I ran some
> simple test (basically check the result of code size reduction) based
> on your suggestions.
> 
> For gcc-13 on x86_64 + defconfig.
> * "(_UL(2) << (h)) - (_UL(1) << (l))"
> 	Before=22438085, After=22438193, Difference ( After - Before ) = 108
> * "((_UL(1) + _UL(1)) << (h)) - (_UL(1) << (l))"
> 	Before=22438085, After=22438209, Difference ( After - Before ) = 124
> 
> I tried to do an analysis on "intel_arch_events_quirk()", it only +2 in
> code size change, I think it would be a nice example to see the differences
> in generated code.
> 
> So the result shows that your proposal can save 1 negation and 1 "and".
> -ffffffff83278ad2:	48 f7 d8             	neg    %rax
> -ffffffff83278adc:	83 e0 7f             	and    $0x7f,%eax
> 
> However, one more "mov" and one more "sub" are generated.
> +ffffffff83278acf:	b8 80 00 00 00       	mov    $0x80,%eax
> +ffffffff83278ad7:	48 29 d0             	sub    %rdx,%rax
> 
> No change in total number of instructions, but negation only requires
> one register, and the "mov" generated is more expensive then usual.
> (Usually "mov" of the following form are generated,
> "48 89 ea             	mov    %rbp,%rdx",
> "89 c3                	mov    %eax,%ebx" ).
> 
> Thanks for your advise again, in some scenario it does have positive
> effect, but unfortunately, the overall impact is not beneficial.
> 
> Best regards,
> I Hsin Cheng.
> 
> Tests performed on ubuntu 24.04 with AMD Ryzen 7 5700X3D 8-Core
> Processor on x86_64 with kernel version v6.14.0-rc1.
> ---
>  include/uapi/linux/bits.h | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/include/uapi/linux/bits.h b/include/uapi/linux/bits.h
> index 5ee30f882736..682b406e1067 100644
> --- a/include/uapi/linux/bits.h
> +++ b/include/uapi/linux/bits.h
> @@ -4,13 +4,9 @@
>  #ifndef _UAPI_LINUX_BITS_H
>  #define _UAPI_LINUX_BITS_H
>  
> -#define __GENMASK(h, l) \
> -        (((~_UL(0)) - (_UL(1) << (l)) + 1) & \
> -         (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
> +#define __GENMASK(h, l) (((~_UL(0)) << (l)) & (~_UL(0) >> (BITS_PER_LONG - 1 - (h))))
>  
> -#define __GENMASK_ULL(h, l) \
> -        (((~_ULL(0)) - (_ULL(1) << (l)) + 1) & \
> -         (~_ULL(0) >> (__BITS_PER_LONG_LONG - 1 - (h))))
> +#define __GENMASK_ULL(h, l) (((~_ULL(0)) << (l)) & (~_ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
>  
>  #define __GENMASK_U128(h, l) \
>  	((_BIT128((h)) << 1) - (_BIT128(l)))
> -- 
> 2.43.0
>

Please ignore this one, I missed to cc to David.
I'll resend again later.

Beset regards,
I Hsin Cheng

