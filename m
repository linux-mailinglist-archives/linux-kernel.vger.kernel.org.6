Return-Path: <linux-kernel+bounces-368871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D1D9A15E3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 00:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58B92B215BA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 22:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038D91D356E;
	Wed, 16 Oct 2024 22:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PMJqT3iQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07AAF9C1
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 22:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729118794; cv=none; b=p0UzIHju1mvilipcolFMYGT+/LVBxDjnNgnq8suCdCQLCy29PtB3Ahz9+70xKLWOM9cFNv5IuprMFWiQ4E8pjgaX+Qo//YNdhGPslB7J6D8iEWx8l0ldgn6z+6UAppJ1HfUJbCgqHQCOTNMFXo9bl61dB8OeMLaajmo00mPUnfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729118794; c=relaxed/simple;
	bh=ztmegEb3EEcizz6/8dXBMKusdLBhWK6RZw83Ngk6tSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hT+osskITgRxg1A1xVrvk2EqzF9reWWShhTu/ZmkeYk9ec3NcQQ+JazJaZt/i3wp8gPD52XucB8x9h8+YK8N8/H4Yh9tPlX3gd4wL1wBzkLK8yuAy6ByKP8Ob7qFUZZGGhfR8biykcxVNbhukyoQU+2AvjwUZzEjkAiBUScg+bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PMJqT3iQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729118791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2n4YLZH5evJQHW3hSdWhW4CiiDzca3Xqq+ma5LbFOR8=;
	b=PMJqT3iQMX53l+ffQwIsso1j9RpQfOloUyPe+/RB8lYGXqBj4r/n4lGtEFifKDfAvOhsEX
	2vdnDjokJgoyo4RFJB1K0wvWkzhGmb+7TiXMZhbJKwy1laqL2ExCIaeBmODd2zq+5HowTw
	YqEnSRx+x15hSqpnrUMaRq6tTjfYvT0=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-mTR9NuxkN-2Zzzw74zyVyQ-1; Wed, 16 Oct 2024 18:46:30 -0400
X-MC-Unique: mTR9NuxkN-2Zzzw74zyVyQ-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-20c77c8352dso2448325ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729118789; x=1729723589;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2n4YLZH5evJQHW3hSdWhW4CiiDzca3Xqq+ma5LbFOR8=;
        b=L5AH4rMiqtDCdu9N7n6xmYR/CqYnN032enrx21fNFejPt2QWv07onXiD2K7EM/O0vY
         /yFYriivik1BzhkhtdhnL7Kkh64GTe9TeOryAnsE1YFwNmcyKgl0VswwKPXGVkPPwRBv
         Uhd/FfMRNFCZLULZX2SsC6zqp35cob0PRYjs/LqbL0LXroBYJtra+nstr7YDgOJnv/We
         FdRV4Q6xpiWY+BlAHIyYV6zHOUZ93gr0dOo8jHiVmrXgwi/pntHgWSqtyrteswgGJLLY
         nHJ77GWZrwSrtTLNau/27roNjkUGmMufpIER3Owmk4CapvLWWzHO77a8gggSj9Vy21bQ
         d2Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUZsZhMA4F0dvmEwIARixdW/v8NTRsvoM79fs//CLSBY5GDjNHiPbdDS9v+5sxAVRfkn0rBSY3z6KCa8g8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/SKHNJXTFbkTlDSIDsAbaPZQNo3QkRIEheNOQcPeexRfWFFPR
	hQGR3DHcStJJZ247SCO2FaRtrsVTbbp8lWkRT+hnmcJBcnKjfgU0wSONRxvc3eqz8EB4TQfo5JI
	nRlc1MhOV/88csA54nU76zjjjK4IPXuWA4PkHdszsI0woHTcPqOj9WwPXSAEGbQ==
X-Received: by 2002:a17:902:f60c:b0:20c:b0c7:7f0d with SMTP id d9443c01a7336-20d27ecadd6mr64931605ad.25.1729118789547;
        Wed, 16 Oct 2024 15:46:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNLfX6rSgoFc/nbuaGHQPrn0ecbjygXBRhQu+9TrQF1OxT+t5t5C1LLK9R/zRxgCCHB6hMLA==
X-Received: by 2002:a17:902:f60c:b0:20c:b0c7:7f0d with SMTP id d9443c01a7336-20d27ecadd6mr64931425ad.25.1729118789152;
        Wed, 16 Oct 2024 15:46:29 -0700 (PDT)
Received: from [192.168.68.54] ([180.233.125.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f84e22sm33227695ad.52.2024.10.16.15.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 15:46:28 -0700 (PDT)
Message-ID: <ab5ef80d-0e74-4a39-ba76-536b7d095b40@redhat.com>
Date: Thu, 17 Oct 2024 08:46:22 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: arm64: Fix shift-out-of-bounds bug
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20241016195755.65011-1-ilkka@os.amperecomputing.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20241016195755.65011-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/24 5:57 AM, Ilkka Koskinen wrote:
> Fix a shift-out-of-bounds bug reported by UBSAN when running
> VM with MTE enabled host kernel.
> 
> UBSAN: shift-out-of-bounds in arch/arm64/kvm/sys_regs.c:1988:14
> shift exponent 33 is too large for 32-bit type 'int'
> CPU: 26 UID: 0 PID: 7629 Comm: qemu-kvm Not tainted 6.12.0-rc2 #34
> Hardware name: IEI NF5280R7/Mitchell MB, BIOS 00.00. 2024-10-12 09:28:54 10/14/2024
> Call trace:
>   dump_backtrace+0xa0/0x128
>   show_stack+0x20/0x38
>   dump_stack_lvl+0x74/0x90
>   dump_stack+0x18/0x28
>   __ubsan_handle_shift_out_of_bounds+0xf8/0x1e0
>   reset_clidr+0x10c/0x1c8
>   kvm_reset_sys_regs+0x50/0x1c8
>   kvm_reset_vcpu+0xec/0x2b0
>   __kvm_vcpu_set_target+0x84/0x158
>   kvm_vcpu_set_target+0x138/0x168
>   kvm_arch_vcpu_ioctl_vcpu_init+0x40/0x2b0
>   kvm_arch_vcpu_ioctl+0x28c/0x4b8
>   kvm_vcpu_ioctl+0x4bc/0x7a8
>   __arm64_sys_ioctl+0xb4/0x100
>   invoke_syscall+0x70/0x100
>   el0_svc_common.constprop.0+0x48/0xf0
>   do_el0_svc+0x24/0x38
>   el0_svc+0x3c/0x158
>   el0t_64_sync_handler+0x120/0x130
>   el0t_64_sync+0x194/0x198
> 
> Fixes: 7af0c2534f4c ("KVM: arm64: Normalize cache configuration")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>   arch/arm64/kvm/sys_regs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 375052d8cd22..665c576faba3 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1994,7 +1994,7 @@ static u64 reset_clidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
>   	 * one cache line.
>   	 */
>   	if (kvm_has_mte(vcpu->kvm))
> -		clidr |= 2 << CLIDR_TTYPE_SHIFT(loc);
> +		clidr |= 2UL << CLIDR_TTYPE_SHIFT(loc);
>   

Nit: It's more precise to have 2ULL since the type of @clidr is u64,
equivalent to 'unsigned long long' on arm64. The pattern ULL has been
used in reset_mpidr().

>   	__vcpu_sys_reg(vcpu, r->reg) = clidr;
>   

Thanks,
Gavin


