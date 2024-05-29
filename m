Return-Path: <linux-kernel+bounces-194204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAB58D3859
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0505EB25963
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA43A1BDDB;
	Wed, 29 May 2024 13:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UXiBfzT8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A07C1BC43
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716990577; cv=none; b=rpoUNELFc0COT3D9LO3LhrVTlvt3mewSdNk1165vv2r+dAFjnxXKx153OEbPa5Y0svBUECGDUFM2Hjx10ZZtvWPnQ/kEUPNTc6Kkpv/UOV2XRf0q0dGxF8dkDYAPhfAcBd5Vk/v/+bhnT55h/pVdxWkqm0obC9fkdIPw72D3avo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716990577; c=relaxed/simple;
	bh=99FqLTNYvbbq89Ah4H9OpzmZV2JtCTkw7gxfM/d8V44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gqCBCDje7XM/jpgudS7HKfxZ1mpA+swfQGCuAt0b/cTnx2WPn5hvdAJjB0LzdVVo3CLBASh6+Y7oadzWXcHWY1anCD7V9GXc8xl+muj/mUS0XfsG+zUbgmkUbzv5TSHbXCAoiVN5a+Sk2MEOQ9ECZJBRDiXrwHo3fBca4GPQNK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UXiBfzT8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716990574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QRV3+tH1wAxqOXSuvjuNmBXhPCtgpPsBKQx4qXuEunY=;
	b=UXiBfzT8ZDnvwXNFg1aJnhv8gY+pYE8vtukmkg505NUet7cleSG0g1v0LJLhSxp8uB4gSU
	CCfnisxWaUuilOd3iaPn4ZA02w9rNywSAyDQ6xv+neDb2obe9cL23lMOfJ6VQrD4ZDarB+
	iuW0wv5IwzXu42XdV9wMDBdXfXtIH4M=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-pB2gTeHMOPqSWARtDWcetg-1; Wed, 29 May 2024 09:49:32 -0400
X-MC-Unique: pB2gTeHMOPqSWARtDWcetg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6ada58d2d50so6041956d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 06:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716990572; x=1717595372;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QRV3+tH1wAxqOXSuvjuNmBXhPCtgpPsBKQx4qXuEunY=;
        b=TA87peYP00IYYCp0/hWLDng3piOd55nkr9EgWtzy0KL5wCZeJLNxAU/QjOKW+go1OD
         TJy0V8VKfbktBO8MeHJVJtChT7SYAG/1fUusHvkT46sZ75Nbs0AujsO2HPhboXKfFHfo
         HuoWKEV7BH4uiIjMzCzmNcwjapjc48c6+R9maGZOmZRkSFxBpuRUKaaoi9cycY422xOe
         PgOiI9ip4bZiXQkDB7MNGE4iYYvzQqQFTDyQt/c6nTYkyIv8mLUr10ULJKJTGuu3C79D
         VfRA/00byaC9UkILE2u8OzLnEqUKglelAlQFfnoIL7WXndBwKBymB241xNa61UII+vBg
         fH8w==
X-Forwarded-Encrypted: i=1; AJvYcCUtgXAYNDFqzhljA2fzRQZFYrMYxz0NuoCXicgtgihFWXGOeTQFV3ewZNfLipPWQnbIhHTRDXN5w9+g5UTB3BtADhZWLFuOH7gM3z/D
X-Gm-Message-State: AOJu0Yzl52CyFynTEHO8url8h9FvGD+lmNOGFXSf9m03aNpVAf7GcYuk
	4/0qUHUg21wEHQm+o8+7KsnegPmbjt/okpljNbsZhhrlAk6IXHoPEQsfIFSf1QWN0et1rzsz7If
	y0ixFrGFfw28QVtjkH/1581D3vOUQ6sTFdvn9qeygwGuRIJMbfPL0Vxs+FGSMAw==
X-Received: by 2002:a05:6214:4a86:b0:6aa:1e22:6c7b with SMTP id 6a1803df08f44-6abcd0b49d7mr196373226d6.25.1716990572350;
        Wed, 29 May 2024 06:49:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEk4VCNntSzG+qoXnos2+vChx4ufljIX3WREdFxolPCgJlMDh4sRm/2lcc7Y7hfqXDE+Zek8w==
X-Received: by 2002:a05:6214:4a86:b0:6aa:1e22:6c7b with SMTP id 6a1803df08f44-6abcd0b49d7mr196372986d6.25.1716990571952;
        Wed, 29 May 2024 06:49:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ad742b3663sm38929456d6.60.2024.05.29.06.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 06:49:31 -0700 (PDT)
Message-ID: <6b452b94-e03a-4d99-b196-65d775c1e5ce@redhat.com>
Date: Wed, 29 May 2024 15:49:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] KVM: arm64: show writable masks for feature
 registers
Content-Language: en-US
To: Sebastian Ott <sebott@redhat.com>, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 James Morse <james.morse@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
References: <20240514072252.5657-1-sebott@redhat.com>
 <20240514072252.5657-5-sebott@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20240514072252.5657-5-sebott@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sebastian,

On 5/14/24 09:22, Sebastian Ott wrote:
> Instead of using ~0UL provide the actual writable mask for
> non-id feature registers in the output of the
> KVM_ARM_GET_REG_WRITABLE_MASKS ioctl.
> 
> This changes the mask for the CTR_EL0 and CLIDR_EL1 registers.
> 
> Signed-off-by: Sebastian Ott <sebott@redhat.com>
> ---
>  arch/arm64/kvm/sys_regs.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 8e8acf3dd9bd..1b6ab483e21e 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -2562,7 +2562,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>  
>  	{ SYS_DESC(SYS_CCSIDR_EL1), access_ccsidr },
>  	{ SYS_DESC(SYS_CLIDR_EL1), access_clidr, reset_clidr, CLIDR_EL1,
> -	  .set_user = set_clidr },
> +	  .set_user = set_clidr, .val = ~CLIDR_EL1_RES0 },
>  	{ SYS_DESC(SYS_CCSIDR2_EL1), undef_access },
>  	{ SYS_DESC(SYS_SMIDR_EL1), undef_access },
>  	{ SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
> @@ -4121,20 +4121,11 @@ int kvm_vm_ioctl_get_reg_writable_masks(struct kvm *kvm, struct reg_mask_range *
>  		if (!is_feature_id_reg(encoding) || !reg->set_user)
>  			continue;
>  
> -		/*
> -		 * For ID registers, we return the writable mask. Other feature
> -		 * registers return a full 64bit mask. That's not necessary
> -		 * compliant with a given revision of the architecture, but the
> -		 * RES0/RES1 definitions allow us to do that.
> -		 */
> -		if (is_vm_ftr_id_reg(encoding)) {
> -			if (!reg->val ||
> -			    (is_aa32_id_reg(encoding) && !kvm_supports_32bit_el0()))
> -				continue;
> -			val = reg->val;
> -		} else {
> -			val = ~0UL;
> +		if (!reg->val ||
> +		    (is_aa32_id_reg(encoding) && !kvm_supports_32bit_el0())) {
> +			continue;
>  		}
> +		val = reg->val;
>  
>  		if (put_user(val, (masks + KVM_ARM_FEATURE_ID_RANGE_INDEX(encoding))))
>  			return -EFAULT;
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


