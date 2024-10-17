Return-Path: <linux-kernel+bounces-369326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E426A9A1BD5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48436282FF2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 07:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085FF18784A;
	Thu, 17 Oct 2024 07:39:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8D51D0149
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 07:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729150778; cv=none; b=minHIZaaBsAoIOislnsnQLW2x92UaCqe7N9l/XQfkDRMuAwZOT6LephVEcc3p/+t+rl9bKmKYytYS8zXv8KKSHLPBrAroa2C4IuyvgKr/xHb2TeQZdpyB5RlX1lPfVi7++yXIAWNZxgjnx68KfDrmMVG1GAgnI3WkBqur57zNUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729150778; c=relaxed/simple;
	bh=L+C4Bds5aLEIoEIqYhxfeIvi49PTsh/+yEo1O4hrRw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JfvRotd0ObFD7j3uX5N56wz8arOQW/+bLDyD8hhtLg1zHpTcBXwtlDcM4UfVUPBQ+ddgZzwd+JZ1CQXoWPjLdbeVVN+/2o++VIP7nr+4fDl8AX9Mlx1qSVz7Ws5i/FGbMXDzjJbC4M2vYtd/wFEDYf8i7MP2pf0qnCmVNi6xyk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B25BBFEC;
	Thu, 17 Oct 2024 00:40:04 -0700 (PDT)
Received: from [10.163.39.37] (unknown [10.163.39.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A0773F528;
	Thu, 17 Oct 2024 00:39:31 -0700 (PDT)
Message-ID: <3bf1390c-3823-43cd-8b5c-9b0848450628@arm.com>
Date: Thu, 17 Oct 2024 13:09:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: arm64: Fix shift-out-of-bounds bug
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
 Gavin Shan <gshan@redhat.com>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20241017025701.67936-1-ilkka@os.amperecomputing.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20241017025701.67936-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/17/24 08:27, Ilkka Koskinen wrote:
> Fix a shift-out-of-bounds bug reported by UBSAN when running
> VM with MTE enabled host kernel.
> 
> UBSAN: shift-out-of-bounds in arch/arm64/kvm/sys_regs.c:1988:14
> shift exponent 33 is too large for 32-bit type 'int'
> CPU: 26 UID: 0 PID: 7629 Comm: qemu-kvm Not tainted 6.12.0-rc2 #34
> Hardware name: IEI NF5280R7/Mitchell MB, BIOS 00.00. 2024-10-12 09:28:54 10/14/2024
> Call trace:
>  dump_backtrace+0xa0/0x128
>  show_stack+0x20/0x38
>  dump_stack_lvl+0x74/0x90
>  dump_stack+0x18/0x28
>  __ubsan_handle_shift_out_of_bounds+0xf8/0x1e0
>  reset_clidr+0x10c/0x1c8
>  kvm_reset_sys_regs+0x50/0x1c8
>  kvm_reset_vcpu+0xec/0x2b0
>  __kvm_vcpu_set_target+0x84/0x158
>  kvm_vcpu_set_target+0x138/0x168
>  kvm_arch_vcpu_ioctl_vcpu_init+0x40/0x2b0
>  kvm_arch_vcpu_ioctl+0x28c/0x4b8
>  kvm_vcpu_ioctl+0x4bc/0x7a8
>  __arm64_sys_ioctl+0xb4/0x100
>  invoke_syscall+0x70/0x100
>  el0_svc_common.constprop.0+0x48/0xf0
>  do_el0_svc+0x24/0x38
>  el0_svc+0x3c/0x158
>  el0t_64_sync_handler+0x120/0x130
>  el0t_64_sync+0x194/0x198
> 
> Fixes: 7af0c2534f4c ("KVM: arm64: Normalize cache configuration")
> Cc: stable@vger.kernel.org
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>  arch/arm64/kvm/sys_regs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 375052d8cd22..ff8c4e1b847e 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1994,7 +1994,7 @@ static u64 reset_clidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
>  	 * one cache line.
>  	 */
>  	if (kvm_has_mte(vcpu->kvm))
> -		clidr |= 2 << CLIDR_TTYPE_SHIFT(loc);
> +		clidr |= 2ULL << CLIDR_TTYPE_SHIFT(loc);
>  
>  	__vcpu_sys_reg(vcpu, r->reg) = clidr;
>  

clidr being u64, 2ULL is preferred over 2UL.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

