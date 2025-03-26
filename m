Return-Path: <linux-kernel+bounces-577369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF543A71C2A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D57B3B62CF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCEE1F5845;
	Wed, 26 Mar 2025 16:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mUP/DVgm"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566B91F30C0
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 16:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743007721; cv=none; b=tqgEQf6eGb+sotp7xxU2pt2O00nHByUL5HxvgzqnRx5sVTCsgftYvU77f9VdIpmjE2P/o4Q8+Ai495cgeJ1QCe7BvhGOqgHUDMneW6OrKlX6hadoUy9brgyZu03FabTGrg6l4fJ+u9eDGoh/6158xvJ2wlmXtg1gmr1iDWE9p9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743007721; c=relaxed/simple;
	bh=v+AmZUmpN4LDUzxm3w5ft1I/+r4feJlmYE8bhA3zNfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppp3jnE5DpPD2PKs3skM2fpQmguqsD8AZKCSdAYrDTrqdhZBPLdIL7hEgk0iiHeuWhRt3vXfKXxy8XwA1/jFt0HwCdTfCWxmlnFV+pU7dMRcnSO9KYU0mvwNhtiE7ZpgDY4pYV5l4NIH9MhOYmNo0Oq7r7ONT7dlMZ8ATztwj7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mUP/DVgm; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e5cd420781so5850a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743007717; x=1743612517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xIONhgKygIJfrRbEsZfUKmIHxiah0KpnWCpr3sd5zNk=;
        b=mUP/DVgm+gU6G0fk+R7hdL9Dt/I8ahmOMfat54qqRwGQ/W1EV3nxTWNH0BQ5i/US0P
         dvTdbofnWXCHI14e/ztzohVx+8cN7/vF3LhWtMidmZCrRjfcKMlycbt1HRx+rdy2isnm
         KhIXVxQw1nYW2QECs9U7v3vOtgOO6Zd6A6kdnaM9Ta0PhfLanY6y1eMOhkgFtvgoqUTN
         MSKIYOoJrhPpsysj7Se2b9FpxrcgKZbyjFmVw9/1dWK/FTA7bq0sDr7+zjI+NkVGJUXy
         2OBbVIoLVTEOuz3u9CI8Di0pAG6MnYn11DSUwZOLUfMFHSCQFbMngzEj7PE8gB1Lv1Fg
         XrwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743007717; x=1743612517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIONhgKygIJfrRbEsZfUKmIHxiah0KpnWCpr3sd5zNk=;
        b=UOPeaHTq/Aiih3kZppkA/gQLPOATGU3A/XLpmlX3cybJQRXs287FJwP8yVGUjBIf5g
         aK213EPQCT+fQeKYTI4Ag/6suemBQ+MMYTDGUKeaJqJYiouv+P21rJdGHOIH2TL9tJYm
         TcEAzc8cdUpzW8yVOJxvkGwb3hC0I/a0Xutp/nSHi62z4KZrbmHMVX05++0w0m3LGUed
         o/N7M6gN1GTIVNhu4EBnWOt+2dR/WtFdZIfBF+DSMHBO0R5D4SBf/L3amXj6QYmB2k/B
         eGmmq886UTPqIIUzX3nMPfC3u/kK0i2v+0FkxstJvy12JhU/adxcopYXOZQjoQPGY4uQ
         cyMw==
X-Forwarded-Encrypted: i=1; AJvYcCUuqqZsVduc6f9udHpPofWgMXTPjNOxEbJa1w8Ae4ONDC1/yw4wtCRyTffIrGB47bUBLZP+gRfjrhui9R0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjxQFFGXTNIYp3brWe92gT/Z+lomu3ZqZvE/TQiBRrvdnsjwrG
	Aqulwq3x/2YOKatre/4o6+WZ+wTxG5KjbGLCUH+Tha9Rx33BO0xzV9pKGmPjBQ==
X-Gm-Gg: ASbGnctni10S9e3YoW5AsXjnJYdOd5+MfpeQ1CU8O2+esLw3Sqz4DZZeJ79pw6qJ15z
	zBXKR3nZ11OkjV8SrRRzdvIvyxUE10avGOLHmcgRuvQ4Opm1KZazvEoYzXtnO/lLCn/HGQomn8i
	saNhHoo6g9XrLR3KE11ccY+xaD8BgBB4QQ9FZgw0sNV97TDdAIovNSFPVWWCsdzNvpNTYnctngD
	NJjo0ko5P51bAYH8wsnepTG9PbOF0bAFFa5J/p7qiVVZAfw4c2c9qi5G7g9QKN2bhaGx8qMIcGX
	dLoyE/x0Dw/PsNrd78XIDpJvc6yhfRSF/G8kCFIzCPwV0F5KTRE187NwSCBrVwlw3PT2xm5iqSo
	rV8w=
X-Google-Smtp-Source: AGHT+IELoh1UdGLEoChuBbrPrSJlW3iazs22Tqnm/p66h/kdfAKvlGAngZOzasm3FVG0orud4x07LQ==
X-Received: by 2002:a17:907:7f86:b0:ac1:e881:89a7 with SMTP id a640c23a62f3a-ac6fae48539mr15547466b.6.1743007717280;
        Wed, 26 Mar 2025 09:48:37 -0700 (PDT)
Received: from google.com (140.20.91.34.bc.googleusercontent.com. [34.91.20.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac404959f47sm907950666b.170.2025.03.26.09.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 09:48:36 -0700 (PDT)
Date: Wed, 26 Mar 2025 16:48:33 +0000
From: Quentin Perret <qperret@google.com>
To: Sebastian Ene <sebastianene@google.com>
Cc: catalin.marinas@arm.com, joey.gouly@arm.com, maz@kernel.org,
	oliver.upton@linux.dev, snehalreddy@google.com,
	sudeep.holla@arm.com, suzuki.poulose@arm.com, vdonnefort@google.com,
	will@kernel.org, yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-team@android.com, Andrei Homescu <ahomescu@google.com>
Subject: Re: [PATCH v4 3/3] KVM: arm64: Release the ownership of the hyp rx
 buffer to Trustzone
Message-ID: <Z-Qv4b0vgVql2yOb@google.com>
References: <20250326113901.3308804-1-sebastianene@google.com>
 <20250326113901.3308804-4-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326113901.3308804-4-sebastianene@google.com>

On Wednesday 26 Mar 2025 at 11:39:01 (+0000), Sebastian Ene wrote:
> Introduce the release FF-A call to notify Trustzone that the hypervisor
> has finished copying the data from the buffer shared with Trustzone to
> the non-secure partition.
>
> Reported-by: Andrei Homescu <ahomescu@google.com>
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/ffa.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
> index 6df6131f1107..ac898ea6274a 100644
> --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
> +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
> @@ -749,6 +749,7 @@ static void do_ffa_part_get(struct arm_smccc_res *res,
>  	DECLARE_REG(u32, uuid3, ctxt, 4);
>  	DECLARE_REG(u32, flags, ctxt, 5);
>  	u32 count, partition_sz, copy_sz;
> +	struct arm_smccc_res _res;
>  
>  	hyp_spin_lock(&host_buffers.lock);
>  	if (!host_buffers.rx) {
> @@ -765,11 +766,11 @@ static void do_ffa_part_get(struct arm_smccc_res *res,
>  
>  	count = res->a2;
>  	if (!count)
> -		goto out_unlock;
> +		goto release_rx;
>  
>  	if (hyp_ffa_version > FFA_VERSION_1_0) {
>  		/* Get the number of partitions deployed in the system */
> -		if (flags & 0x1)
> +		if (flags & PARTITION_INFO_GET_RETURN_COUNT_ONLY)
>  			goto out_unlock;
>  
>  		partition_sz  = res->a3;
> @@ -781,10 +782,12 @@ static void do_ffa_part_get(struct arm_smccc_res *res,
>  	copy_sz = partition_sz * count;
>  	if (copy_sz > KVM_FFA_MBOX_NR_PAGES * PAGE_SIZE) {
>  		ffa_to_smccc_res(res, FFA_RET_ABORTED);
> -		goto out_unlock;
> +		goto release_rx;
>  	}
>  
>  	memcpy(host_buffers.rx, hyp_buffers.rx, copy_sz);
> +release_rx:
> +	ffa_rx_release(&_res);

I'm a bit confused about this release call here. In the pKVM FF-A proxy
model, the hypervisor is essentially 'transparent', so do we not expect
EL1 to issue that instead? How is EL1 supposed to know that the
hypervisor has already sent the release call? And isn't EL1 going to be
confused if the content of the buffer is overridden before is has issued
the release call itself? What would otherwise prevent that from
happening?

Thanks,
Quentin

>  out_unlock:
>  	hyp_spin_unlock(&host_buffers.lock);
>  }
> -- 
> 2.49.0.395.g12beb8f557-goog
> 

