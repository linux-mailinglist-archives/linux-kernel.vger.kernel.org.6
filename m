Return-Path: <linux-kernel+bounces-321728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4034971E9E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F78AB23156
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D070B13A240;
	Mon,  9 Sep 2024 16:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w/T+xZWK"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010561BC40
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 16:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725897794; cv=none; b=aD680qDYY96NyJS3c0v+u3do5bqsRuJFSuyZyP8++V5+fYsC4f2+1uraSRWMjKiB5icmjtxRxvBVTYopeR/zbIAyTDIJJvdVuS+XEYHHWsF1MBTRjO92AYwXaiDLg29YV4yQKngq4G89tPjGRbULURbWK+vtDGSE++ioAhXLkXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725897794; c=relaxed/simple;
	bh=88lo47xg3yelIsFsDGWArcwQDElF+OmnZMG5ZVOeu2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLG3C46peqJT92ae2PH64xjIL4n+42dQ9yzP+YcWcfcmhNYRnkCVALyfA/oJCW2qI7H7gw5vCXXBjh7KRow+Kp5eRRnKe6naD6NaFJO/jCQdF5c3qMskDhE+0Ny/ZthaMPaCLHdv4/C0AjzrhzlntsfUaVONaQb3IcP1JQ1n8UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w/T+xZWK; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5356a2460ceso14520e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 09:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725897790; x=1726502590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fracQuYtQaObjYrVhxRAFzJFryVoL/0p6ZImg0NJDKk=;
        b=w/T+xZWK45KulBBr21jmSwcD2qs/sixkI+rFyT1Q2C2okedKp5Xsk/wqRFLndeRh2w
         uAIUfNF+viGL0AjT4aamTBfc1UhbVR7E60bB9D+4C+rbxNbUT8rBxrDdWdXCF6fftxoT
         a1/k0Id0QEEUqS/ED6F5GZziqhWoKN9QLHwHiQklXgwgfFwV6YMzx22H4POr9ErS/4Jn
         ea2pLxq0ih6YKW3oVGglp4nz/YR425KUzyvHQVvGhsj2M0YCS9JXeRu6LRX/xN4Ku/6Q
         kgOjqcDayAb3XfHKizaAJOrOUhlnUPNelczJXZHiPKsX8NIPrBW1SGq+8rIi121lLo5z
         E8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725897790; x=1726502590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fracQuYtQaObjYrVhxRAFzJFryVoL/0p6ZImg0NJDKk=;
        b=WxnGrZZovS9D484k3IsQKEncl6Jz3qK+M07FWy+GyBSdzVjVXgyfENUYrz6fpn9jf1
         9hmd0QJ4lqMHwP2C+QFW4ygeZdaZOQUbZJ1gRFXzgeHc5qviiFsvIeNy+Hsw7bZ/U4P+
         dAD2zAUZx/8IdRANDbbuF7uwyn5R3DLxzUV23tLzrcg9sf5q3flnsCJsOlg9tHZDDyz4
         9ehqAdBihs8ZKnNW72a0vYXXnYLm06qVkgCyCbipU4ivzpQbds+LOn/LBTKe0zGDXX5d
         j2a6OXJCSfC+Zm1NeuCniNB0RWqh4gpF9wbYbmaOvzah7YPv7qMm6hkY3tYH2cjU4WCD
         clXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPanhj+LfnLJBkR8LtL525yXNhpo6rHJ9ldavjA7htBS4c3yyVp5fl8TGSORmVNR3MzbLiCMmK6dkUCnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcJ8IyfcKwVbRhv5J/0/vHNsB20KPR65Sor41pTzQzh6k9ZCM5
	SI/c2jnqD1mhby42Ty8ZJmIsiKzOVDa9alUpHGFjpiTPBn4qTKJs8Ql/hsIigg==
X-Google-Smtp-Source: AGHT+IFWWF4zQGbIYhYU4tYtK4Cq/myRRd+dsd+RU2EiYcad8RSM6sP31Dr6sN0cwJxGzs0Gz5dgqQ==
X-Received: by 2002:a05:6512:3a95:b0:533:4620:ebe6 with SMTP id 2adb3069b0e04-5365debfedamr337407e87.4.1725897789707;
        Mon, 09 Sep 2024 09:03:09 -0700 (PDT)
Received: from google.com (93.20.140.34.bc.googleusercontent.com. [34.140.20.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956dbf42sm6355955f8f.102.2024.09.09.09.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 09:03:09 -0700 (PDT)
Date: Mon, 9 Sep 2024 16:03:07 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Snehal Koukuntla <snehalreddy@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: arm64: Add memory length checks and remove
 inline in do_ffa_mem_xfer
Message-ID: <Zt8cO8aKS64_FW1W@google.com>
References: <20240909130832.1203849-1-snehalreddy@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909130832.1203849-1-snehalreddy@google.com>

On Mon, Sep 09, 2024 at 01:08:32PM +0000, Snehal Koukuntla wrote:

Hi,

A couple of nits which weren't addressed in the first version.

> Check size during allocation to fix discrepancy in memory reclaim path.
> Currently only happens during memory reclaim, inconsistent with mem_xfer
> Also  do_ffa_mem_xfer() does not need __always_inline
> 

Please enhance the description in the commit message as Mark suggested
previously. Something like this should work:

"""
When we share memory through FF-A and the description of the buffers
exceeds the size of the mapped buffer, the fragmentation API is used.
The fragmentation API allows specifying chunks of descriptors in
subsequent FF-A fragment calls and no upper limit has been established
for this. The entire memory region transferred is
identified by a handle which can be used to reclaim the transferred
memory. To be able to reclaim the memory, the description of the buffers
has to fit in the ffa_desc_buf.
Add a bounds check on the FF-A sharing path to prevent the memory reclaim
from failing.

Fixes: 43609000177625
Cc: stable@vger.kernel.org
Signed-off-by: Snehal Koukuntla <snehalreddy@google.com>
"""

Otherwise, Reviewed-by: Sebastian Ene <sebastianene@google.com>

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
> 2.46.0.469.g59c65b2a67-goog
> 

Thanks,
Seb


