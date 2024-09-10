Return-Path: <linux-kernel+bounces-323451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C071D973D63
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4281C1F26D2D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE24D1AAE25;
	Tue, 10 Sep 2024 16:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csie.ntu.edu.tw header.i=@csie.ntu.edu.tw header.b="QeyiS+5A"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36441A0B10
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725985960; cv=none; b=sM1uG56Qy+zAmGvRLo8Buz9yBiHQXFyOh236618hgjqvRBI5tfFa1r7taWdokyDhYEAETE7LMj1o2YtGTfjlknj4TXc6liUD+YEJrrl+r+B3AFH99tDjPTeRLa2ZzRduduiVgzgCxUIBLQkU/HVbqQKFfYEQA53BcFivlnxArmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725985960; c=relaxed/simple;
	bh=4iPN/fsCe14wfGYSYCjynyR282sYt9ED2Ow9xIF9vkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTeyRpax5ME9soRdGcGpVbQ5jTEV3J5zf1SvM/nWmH1ExmjFYfSv5frK95ApkiIkUeIqgzv6N5TAf4kL+DFZyvCZxyvEAC3j4XTbgENiX6thfJ9hD2ajDksW1u5p+PXnTkuMJKBsjqfGhgo2dC0Yv9RfnvlPIiQlRQIO4EJhWxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.ntu.edu.tw; spf=pass smtp.mailfrom=csie.ntu.edu.tw; dkim=pass (2048-bit key) header.d=csie.ntu.edu.tw header.i=@csie.ntu.edu.tw header.b=QeyiS+5A; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.ntu.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csie.ntu.edu.tw
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso4739350a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=csie.ntu.edu.tw; s=google; t=1725985956; x=1726590756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ELTwotHVw2kePUAUYWtO4H0shRoEHF3K5HxUF2BgZ5g=;
        b=QeyiS+5ACmGi+c4mTvU9kta+d+9EcD2aNX72XkVinadbAVJWQS2idKdhIFUtxYaTDn
         oNLrYRcYpdx2DWOrK8StpFlO5FLuI3J8mrReP/g5MK0HPU/bEPAsy5Kuq1QcS/d0uw/p
         NZVmYt/1Z/hF3S+3mI77HxuL8bQ7Ud2C8YnXZy0gE2U4zTg9ufiijimmmFtqpnywQ1Ud
         9dp+Nf37eYlbU63UYkipmttPpHigJKpJjB3SIqEE/y4rkhNq3cOZd6w7l/eeL2LP8atG
         NkplvAsSe5sjg6JUNeQfC65dLcUfv/UWa2UmY64dA9WZzsBqNc+gfSgxcf7CNU6tuPhy
         /2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725985956; x=1726590756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELTwotHVw2kePUAUYWtO4H0shRoEHF3K5HxUF2BgZ5g=;
        b=iJ9xeo5XVQ8V0M8NN/LjaarK20OZUOkRm4f/bKzLU1kz+vo+Lcb/tppzXM2rjnkKQ4
         YYLQ/EWWOgSHrjmDTA5XHIJl0YXd/oGEO5U0dtuUrgBE6bP6EbgwhAQycXI887MZZ4I4
         bim5MWJeoEaaRytlPuzeSn1ENVSQGzy0LlqKzGu3oRKaRPKfPU5pZAHcOMx/tLJDqf42
         mg9p6X12oeluH2cU2cid1z/Ic+AO3QpTjiatIllmxYdRiCqygm1yXayBQ5Zq7/p9RaSA
         1eokS8UzZvLIOnvW1xJV08DKBKpoISUYGLElQYiBxtEdk9YHdRqnR5GfWrqeMR0D0WSq
         CRHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJPnmzjFvd2UNV3cy9uq7P9s9iJuFuMj0tx5Hb9ol4cxH3NN8B7XGDuQACBzpqkM6og4jIl98UpQY8KlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDGu4hRgRw/Y1gtR+9TYGiOjrlDpjrMciYhc3P6I1U+RiLBGEy
	As768kth+whpMgToGTMzXzxCNML8zDNhXuGNQDnht63Xg6lV0nhCX+Pj+CM3yZlG0ztxVAm75en
	ThPzfriRf2AfKtJYD9vsrDoqfME+n1T/oSD918G9+WYcT8UCey0dMXz8=
X-Google-Smtp-Source: AGHT+IGsiPCMyX4DWKfV2C1n/j0UcYNxDwTcJHn00avqUPc5NDXLo/1FuFWLrpMOciYip064UpmfsA==
X-Received: by 2002:a17:90a:ee8f:b0:2d3:c892:9607 with SMTP id 98e67ed59e1d1-2dad4ef4a6amr16294517a91.12.1725985955738;
        Tue, 10 Sep 2024 09:32:35 -0700 (PDT)
Received: from zenbook (2001-b011-3808-5e10-d66e-1c97-ed92-266b.dynamic-ip6.hinet.net. [2001:b011:3808:5e10:d66e:1c97:ed92:266b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db04966b6asm6636022a91.39.2024.09.10.09.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 09:32:35 -0700 (PDT)
Date: Wed, 11 Sep 2024 00:32:29 +0800
From: Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
To: Snehal Koukuntla <snehalreddy@google.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Cc: James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Sebastian Ene <sebastianene@google.com>, 
	Vincent Donnefort <vdonnefort@google.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, r09922117@csie.ntu.edu.tw
Subject: Re: [PATCH v3] KVM: arm64: Add memory length checks and remove
 inline in do_ffa_mem_xfer
Message-ID: <rm2pihr27elmdf4zcgrv5khs7qluhn77tkivkr6xkvqcybtl4m@7hesctcacm4h>
References: <20240909180154.3267939-1-snehalreddy@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909180154.3267939-1-snehalreddy@google.com>
X-Gm-Spam: 0
X-Gm-Phishy: 0

Hi everyone,

On Mon, Sep 09, 2024 at 06:01:54PM GMT, Snehal Koukuntla wrote:
> When we share memory through FF-A and the description of the buffers
> exceeds the size of the mapped buffer, the fragmentation API is used.
> The fragmentation API allows specifying chunks of descriptors in subsequent
> FF-A fragment calls and no upper limit has been established for this.
> The entire memory region transferred is identified by a handle which can be
> used to reclaim the transferred memory.
> To be able to reclaim the memory, the description of the buffers has to fit
> in the ffa_desc_buf.
> Add a bounds check on the FF-A sharing path to prevent the memory reclaim
> from failing.
> 
> Also do_ffa_mem_xfer() does not need __always_inline
> 
> Fixes: 634d90cf0ac65 ("KVM: arm64: Handle FFA_MEM_LEND calls from the host")
> Cc: stable@vger.kernel.org
> Reviewed-by: Sebastian Ene <sebastianene@google.com>
> Signed-off-by: Snehal Koukuntla <snehalreddy@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/ffa.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
> index e715c157c2c4..637425f63fd1 100644
> --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
> +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
> @@ -426,7 +426,7 @@ static void do_ffa_mem_frag_tx(struct arm_smccc_res *res,
>  	return;
>  }
>  
> -static __always_inline void do_ffa_mem_xfer(const u64 func_id,
> +static void do_ffa_mem_xfer(const u64 func_id,

I am seeing a compilation error because of this.

----- LOG START -----
$ clang --version 
clang version 18.1.8
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/bin
$ make LLVM=1 ARCH=arm64 defconfig
$ make LLVM=1 ARCH=arm64 Image
...
arch/arm64/kvm/hyp/nvhe/ffa.c:443:2: error: call to '__compiletime_assert_776' declared with 'error' attribute: BUILD_BUG_ON failed: func_id != FFA_FN64_MEM_SHARE && func_id != FFA_FN64_MEM_LEND
  443 |         BUILD_BUG_ON(func_id != FFA_FN64_MEM_SHARE &&
      |         ^
./include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
   50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
      |         ^
./include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^
././include/linux/compiler_types.h:510:2: note: expanded from macro 'compiletime_assert'
  510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |         ^
././include/linux/compiler_types.h:498:2: note: expanded from macro '_compiletime_assert'
  498 |         __compiletime_assert(condition, msg, prefix, suffix)
      |         ^
././include/linux/compiler_types.h:491:4: note: expanded from macro '__compiletime_assert'
  491 |                         prefix ## suffix();                             \
      |                         ^
<scratch space>:66:1: note: expanded from here
   66 | __compiletime_assert_776
      | ^
1 error generated.
make[6]: *** [arch/arm64/kvm/hyp/nvhe/Makefile:46: arch/arm64/kvm/hyp/nvhe/ffa.nvhe.o] Error 1
make[5]: *** [scripts/Makefile.build:485: arch/arm64/kvm/hyp/nvhe] Error 2
make[4]: *** [scripts/Makefile.build:485: arch/arm64/kvm/hyp] Error 2
make[3]: *** [scripts/Makefile.build:485: arch/arm64/kvm] Error 2
make[3]: *** Waiting for unfinished jobs....
----- LOG END -----

Is this expected? Because when I add back the __always_inline, or change the
BUILD_BUG_ON to BUG_ON, it compiles successfully.

Thanks,
Wei-Lin Chang

>  					    struct arm_smccc_res *res,
>  					    struct kvm_cpu_context *ctxt)
>  {
> @@ -461,6 +461,11 @@ static __always_inline void do_ffa_mem_xfer(const u64 func_id,
>  		goto out_unlock;
>  	}
>  
> +	if (len > ffa_desc_buf.len) {
> +		ret = FFA_RET_NO_MEMORY;
> +		goto out_unlock;
> +	}
> +
>  	buf = hyp_buffers.tx;
>  	memcpy(buf, host_buffers.tx, fraglen);
>  
> -- 
> 2.46.0.598.g6f2099f65c-goog
> 

