Return-Path: <linux-kernel+bounces-395303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 334049BBBFD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 519031C21E0F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DC81C3027;
	Mon,  4 Nov 2024 17:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UHmFsBqP"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B301BD4FD
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 17:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730741517; cv=none; b=gwmDoweT/m6XG+coLzjLS9SF7XQqk+d2Dtr7x65x1fXWBrsZJ3r/XyNEqrLaO/7rhc4cOk46K5X5Krg0xjMkFGceobKwfP1odPRk+jfp7c7JE9ZkXe/mgsM7tyL9Q2OELHTwUw/S7ixhhov5AmPfX4L5hud7q1y7Hh9Pt7JsrfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730741517; c=relaxed/simple;
	bh=bnVxizLxpO8STPwMmkuIRHUe7oPgu5FuCiJviNm+udY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gjoo07FdtWMws0/dY+Zu7NsjyHyUtLLGHPL9YSb3U8/4iFnIDmobehvFeuz1L3doPriOJTUDIGw6RVfSiesIOrDFU6je+F0yAwoLVaPJqKxlX1u3ELoD8qFphLraCdjqbrEKiqAExOLiephRZfoQXBvNrE9Ky3cJexS72mnqYZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UHmFsBqP; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539e681ba70so31547e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 09:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730741514; x=1731346314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m+gWQBW59oA/smxkvbCMiuP+EZcz3YoEze7WyvjSzCI=;
        b=UHmFsBqPlBsW8zFfpHxv/La1Wb65B9cRUEKwBaBYaF9wwTtybeLviq7vT/I5zaP0Oi
         BMkKMhId3aWiS+kQxBlxLlRFY0TTXI/2cOcva6SXAPSC3iXYE5UXqpKufQPC9qaktGRD
         EDzbPcSJam+3hflCF3tz2UDjhRXUlX5PWsvrP8YS46Wr0LtechhNw6jRc1z4fThXvKfQ
         TPHtgsc4ordaij2+f7rskzI0BRlWXPdsHrQyTSuy86ZHFkYq0Jx6TA8KgU6lYhwHqx6I
         oxelWQQoio2qF7tMs8ruMpFUqGN0a2Q9vzNlnwaILkR+UQJijpbqFzj47fPAqQfc20Oh
         /i4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730741514; x=1731346314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+gWQBW59oA/smxkvbCMiuP+EZcz3YoEze7WyvjSzCI=;
        b=h5gfJTIIKZuq8gZhpog5fVh4vRzep8z0RnVuRU5udslKscDVfYiG0e/vcOvBoJrs++
         ENOzrtww24RqcsGkkaKSX1ZUCh431NDGhVocI7hJwWv5llca/3rQpFIT4/dINql7KbO7
         Q2YA5+RwHiVvMeOmfe6EabIZSuFWalgg75ugl6TJKS7t8ReJJbOH4sIvQYNNDD4cRH1W
         fIJbj2ZsYgum3NUV+njUFD0hAfEpfXplpLkLkB6OC6BXYn9rH3y39XYFCpswOytuXggA
         Xnm0YjUbmH6QC1EsotAsHx3uQYa8eJClYZRxZ4UtbJ7FzIoW+DON0nlRJ6rBPVeJcINM
         E4pg==
X-Forwarded-Encrypted: i=1; AJvYcCUy/bjhyO1S3Cj8aQhOG9pY3dcCc00dYpj7yDtB1g4Y/Npbovb95UzzkmLd8f3ZCcZvkQsdhAl45PymJPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGf58DIRVN9XIdWnSAqlO6avnBowt7BP7PCnDlAl+Fwb15peWT
	9Pw7Y6jnc9/bWnmwE84DV4HscgTEBc20oDZv+W6Phl4VDLovFSfcf1ObiCCFgA==
X-Gm-Gg: ASbGncuS6ZnZDIuuRBTq+DPJ0t02ELg1tDffuaYwYhOFF/CE3vsIADjL8uPdXTu40Ml
	28XZEU/iLOv3m9hbvIBTuz3wIB8Vu19432Qd5KHs+aE+10PsRCiQ3UGIq6IzDRnXYWBM033jvGO
	glr+8idqYbVxTiKYbIN60hQpsM38s9n1GLQkh0qU0rQkiEp4P2gyPKVhq8XqeQ2mLNfjnQcawKy
	/mLX8ImjZqg5YNeI1YI+pYD4nGRn2IdlrUKeJ+og+jzsjQnLM2vUInmtqIeai4HaQGtGdAQbo0G
	bP3Sjrulqh4aGDQ=
X-Google-Smtp-Source: AGHT+IEFzR5K452HH5vqMM377aknN6V/3WvRGaWelqf2PQHhiSRldASVdDARr7JWsAF1t8ICdL9ygQ==
X-Received: by 2002:a05:6512:3985:b0:530:ae18:810e with SMTP id 2adb3069b0e04-53d6b1b3362mr519219e87.5.1730741514166;
        Mon, 04 Nov 2024 09:31:54 -0800 (PST)
Received: from google.com (145.16.38.34.bc.googleusercontent.com. [34.38.16.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9ca704sm189791515e9.41.2024.11.04.09.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 09:31:52 -0800 (PST)
Date: Mon, 4 Nov 2024 17:31:50 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Quentin Perret <qperret@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/18] KVM: arm64: Change the layout of enum
 pkvm_page_state
Message-ID: <ZykFBhlzrUQtjEjy@google.com>
References: <20241104133204.85208-1-qperret@google.com>
 <20241104133204.85208-2-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104133204.85208-2-qperret@google.com>

On Mon, Nov 04, 2024 at 01:31:47PM +0000, Quentin Perret wrote:

Hi Quentin,

> The 'concrete' (a.k.a non-meta) page states are currently encoded using
> software bits in PTEs. For performance reasons, the abstract
> pkvm_page_state enum uses the same bits to encode these states as that
> makes conversions from and to PTEs easy.
> 
> In order to prepare the ground for moving the 'concrete' state storage
> to the hyp vmemmap, re-arrange the enum to use bits 0 and 1 for this
> purpose.
> 
> No functional changes intended.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> index 0972faccc2af..ca3177481b78 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> @@ -24,25 +24,28 @@
>   */
>  enum pkvm_page_state {
>  	PKVM_PAGE_OWNED			= 0ULL,
> -	PKVM_PAGE_SHARED_OWNED		= KVM_PGTABLE_PROT_SW0,
> -	PKVM_PAGE_SHARED_BORROWED	= KVM_PGTABLE_PROT_SW1,
> -	__PKVM_PAGE_RESERVED		= KVM_PGTABLE_PROT_SW0 |
> -					  KVM_PGTABLE_PROT_SW1,
> +	PKVM_PAGE_SHARED_OWNED		= BIT(0),
> +	PKVM_PAGE_SHARED_BORROWED	= BIT(1),
> +	__PKVM_PAGE_RESERVED		= BIT(0) | BIT(1),
>  
>  	/* Meta-states which aren't encoded directly in the PTE's SW bits */
> -	PKVM_NOPAGE,
> +	PKVM_NOPAGE			= BIT(2),
>  };

I guess we will still have to keep around the software bit annotation
for sharing MMIO regions from the host. This would not be tracked by the
vmemmap but it will still be in the s2 pagetable. As this is tagged with no
functional changes intended, are we safe because we are not supporting
MMIO sharing currently ?

> +#define PKVM_PAGE_META_STATES_MASK	(~(BIT(0) | BIT(1)))
>  
>  #define PKVM_PAGE_STATE_PROT_MASK	(KVM_PGTABLE_PROT_SW0 | KVM_PGTABLE_PROT_SW1)
>  static inline enum kvm_pgtable_prot pkvm_mkstate(enum kvm_pgtable_prot prot,
>  						 enum pkvm_page_state state)
>  {
> -	return (prot & ~PKVM_PAGE_STATE_PROT_MASK) | state;
> +	BUG_ON(state & PKVM_PAGE_META_STATES_MASK);
> +	prot &= ~PKVM_PAGE_STATE_PROT_MASK;
> +	prot |= FIELD_PREP(PKVM_PAGE_STATE_PROT_MASK, state);
> +	return prot;
>  }
>  
>  static inline enum pkvm_page_state pkvm_getstate(enum kvm_pgtable_prot prot)
>  {
> -	return prot & PKVM_PAGE_STATE_PROT_MASK;
> +	return FIELD_GET(PKVM_PAGE_STATE_PROT_MASK, prot);
>  }
>

Thanks,
Sebastian

>  struct host_mmu {
> --
> 2.47.0.163.g1226f6d8fa-goog
> 

