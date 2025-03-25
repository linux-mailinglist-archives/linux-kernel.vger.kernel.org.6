Return-Path: <linux-kernel+bounces-575743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF66A706AB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F47618907BA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F618256C89;
	Tue, 25 Mar 2025 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M4LypvG3"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00E81FAC4E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919675; cv=none; b=mqDguQRCXJQEJ1NFrjuWd+I8BfcBpT8GWMdO4IaW2HEGcmod8MGy7LMSWdYMrcaOLhDD8/ZjpwzJLbnQnFUQlvU7n34ysR2PNybHj7AUExL638XORe5nf3EEK2im68/dB+f1xwt+2zQXLVZzAfBJ3j/OtbrGrSFAyynb4QSvLvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919675; c=relaxed/simple;
	bh=1qXbnHV2qk8Y71BXOizilDEhNN/aAPZZl8nOTeF6WC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ucp/zTgwYiBElOHxLdJt96bX6thPXETjtNq8cDPUKNBOUpc25ypqas3hbEdwD3QTgGitlfCzSD19GgQ6HDJQFaD12MH9ZiE3EeOycB2Cc+Eq2y6qFnDsUmXQmfr/pMPPTKgiibsKIA4MMzXKhvynZjuCGiRN5jW4YTH9dk+K2Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M4LypvG3; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 25 Mar 2025 09:20:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742919661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kH82AWI1DJslhjV0Iug+U9xXkzn8ELqhzK9jzJCrPWc=;
	b=M4LypvG3T8toQIUrvERxsZVnUA5+eQ36UPuhS1X6f5JNdlprDLSjniBaiyNKYW/UgQNwIX
	eaeymRtM4z2Z91mNNqyzNY04RHsh9LpwE+ReNtxrxuPKxKUb8drKWRY5bUZFMHYeAGsQU/
	yf4+4dAga4Sy8JusJswBXqZ5pWyO6y8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Jinqian Yang <yangjinqian1@huawei.com>
Cc: maz@kernel.org, yuzenghui@huawei.com,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, wangzhou1@hisilicon.com,
	shameerali.kolothum.thodi@huawei.com, liuyonglong@huawei.com,
	jiangkunkun@huawei.com
Subject: Re: [PATCH] KVM: arm64: Make HCX writable from userspace
Message-ID: <Z-LX5H5mjGyTQ9N4@linux.dev>
References: <20250325121126.1380681-1-yangjinqian1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325121126.1380681-1-yangjinqian1@huawei.com>
X-Migadu-Flow: FLOW_OUT

Hi Jinqian,

On Tue, Mar 25, 2025 at 08:11:26PM +0800, Jinqian Yang wrote:
> Allow userspace to modify guest visible value for HCX in
> ID_AA64MMFR1_EL1.
> 
> Signed-off-by: Jinqian Yang <yangjinqian1@huawei.com>

This is fine, but I would rather we handle all the features like FEAT_HCX
instead of a trickle of one-off patches.

So, could you please:

 - Identify all of the features that describe an *EL2* feature which
   we've exposed to non-nested VMs
 
 - Implement patch(es) to make those fields writable (i.e. allow them to
   be downgraded)

 - Add corresponding test cases to the set_id_regs selftest

Thanks,
Oliver

> ---
>  arch/arm64/kvm/sys_regs.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 82430c1e1dd0..b105f156bdf6 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -2666,7 +2666,6 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>  					ID_AA64MMFR0_EL1_TGRAN16_2 |
>  					ID_AA64MMFR0_EL1_ASIDBITS)),
>  	ID_WRITABLE(ID_AA64MMFR1_EL1, ~(ID_AA64MMFR1_EL1_RES0 |
> -					ID_AA64MMFR1_EL1_HCX |
>  					ID_AA64MMFR1_EL1_TWED |
>  					ID_AA64MMFR1_EL1_XNX |
>  					ID_AA64MMFR1_EL1_VH |
> -- 
> 2.33.0
> 

