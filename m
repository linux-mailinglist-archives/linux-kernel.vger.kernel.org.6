Return-Path: <linux-kernel+bounces-235833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2863891DA45
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 878A9B230C5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD8683CDB;
	Mon,  1 Jul 2024 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tD8l+UUV"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B751183CC7
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823371; cv=none; b=KfQ7cjynt0mvhgKuahEE3+D+qIqhM7qkWxCrTXZrZjIxZPWjBe+uWMqfob8BIcZnhItgc5Xe/inJt+DqK+nzKGgdKiF2jZLAwFsmeAernhUlUnZXSycUHhMwuN0x7lvSR2FZUMcs1Obs23JRnG/S0MAlJL0JbDrDGVZXdNwc1uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823371; c=relaxed/simple;
	bh=cHDjUygFlHEkZ3a+qAPDtVYOmwRuT3EA86PTUwtLgpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLlCPsUi4DJ2QRj0eZt2rSBJ9n5omOOtvt2K54koTiGqlr2xSAMO6kf2ZB8MOFTyfRZar1X3v2Zd9kmxtAhihbcZzSczpc5i37i/z/GuLY1IlgR4ydYrfn37DMAUgDahsOENon4xtRQ5r6YgdOihWD/nvc4U3wz2wD7MoO4S7A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tD8l+UUV; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4257d5fc9b7so8540365e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 01:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719823368; x=1720428168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yEsoWTLxyHIlDQCb/ASp+ooXvx9TSwnTA36CC8StcRU=;
        b=tD8l+UUVxgcxkczABVOVXX1U9WK3K/jF0QRFwIl+llePzZ33OPziDqUsQDnt4mpVS9
         rNNpxTnL6PWso0hBw2SgBTm/ZklxDTp2yfRTdMh+2bwWwRuKNuxtwW2+ev9JFEnI8zy4
         KjqkbciqLNyrWAo5sKOcvWOv8AWRXQZQY52163Nqgh03XH5clzc4NJenDwZZp0WSlNdt
         Lu84Mp0ojU1puCd6rtFLZa3rVw/hEWR2ZpbstrEbWeUqQRxCGswvdYTMxXl8toLZk4BG
         GTZagFBPOINTajZFcH10XBw0pZQiHub/CZAuY9AD17gQ29mb7rb0shF+a3i0iv34bxh/
         bD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719823368; x=1720428168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEsoWTLxyHIlDQCb/ASp+ooXvx9TSwnTA36CC8StcRU=;
        b=pBfLZSvPwBcBZ2e2390ta+nTFDJJHG2m1eTS533uvDnp+pSJ6XkKhJ+JhyHogzC9Oo
         r+gD+XAB48uLnmey0LdSXurKErXPdlHfvlFkRw/2gDRJyi9i7rCF5UKAMAyS8xLxlCQr
         BR/W8YAiB4inXCCar7dIQd0PAU7KelnMq1rFX6sb6riCX+SNlEXTfiBwl20swC93NGU3
         oYH3LCedhJvBUOGn3poqg0wZKoB0f25+bqHq//LiYeqNsUyj+ypwNtbym3nPvhDZhq+r
         fJiSiBog3UL5eMNPdRWBVjG7ZW5o2aX5jBFfC/NA47BFjjaGNfcebCke048/3PKM9mIt
         g8eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjHO8N+/snHH9zb1qihf81Oeaq1Ik7LHDXYdiMlKHz+Hce2ISppFJtoSGqF0IdaoSqDs6n4ifzmy+gJiCUCYlchJJgJyz300D2UU4N
X-Gm-Message-State: AOJu0Ywk/YCoDB5mae25mtqRe6Cj+P3TbqUJJ97l090MM9FV0IT9QVxx
	a72VoDY5wKhySjtGPShlI5NKHqHeNC8l6etq8jklFgN9GqaC6ibBiyBc0LICXA==
X-Google-Smtp-Source: AGHT+IGawId0kUmiFiVE/6VBOwuMv0FSUu1ZKqIQ07gLRwDyzzNe0v1kfMUd7cCTWmMSeLhyZCJCRQ==
X-Received: by 2002:a05:6000:18a7:b0:367:4d9d:56a1 with SMTP id ffacd0b85a97d-3677572496bmr3944444f8f.45.1719823367880;
        Mon, 01 Jul 2024 01:42:47 -0700 (PDT)
Received: from google.com (247.165.79.34.bc.googleusercontent.com. [34.79.165.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0cd778sm9536657f8f.5.2024.07.01.01.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 01:42:47 -0700 (PDT)
Date: Mon, 1 Jul 2024 09:42:43 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Sebastian Ene <sebastianene@google.com>
Cc: akpm@linux-foundation.org, alexghiti@rivosinc.com, ankita@nvidia.com,
	ardb@kernel.org, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, james.morse@arm.com,
	mark.rutland@arm.com, maz@kernel.org, oliver.upton@linux.dev,
	rananta@google.com, ryan.roberts@arm.com, shahuang@redhat.com,
	suzuki.poulose@arm.com, will@kernel.org, yuzenghui@huawei.com,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v7 5/6] KVM: arm64: Initialize the ptdump parser with
 stage-2 attributes
Message-ID: <ZoJsAyrmtge4mXJY@google.com>
References: <20240621123230.1085265-1-sebastianene@google.com>
 <20240621123230.1085265-6-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621123230.1085265-6-sebastianene@google.com>

O Fri, Jun 21, 2024 at 12:32:29PM +0000, 'Sebastian Ene' via kernel-team wrote:
> Define a set of attributes used by the ptdump parser to display the
> properties of a guest memory region covered by a pagetable descriptor.
> Build a description of the pagetable levels and initialize the parser
> with this configuration.
> 
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> ---
>  arch/arm64/kvm/ptdump.c | 143 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 137 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
> index 36dc7662729f..cc1d4fdddc6e 100644
> --- a/arch/arm64/kvm/ptdump.c
> +++ b/arch/arm64/kvm/ptdump.c
> @@ -14,6 +14,61 @@
>  #include <kvm_ptdump.h>
>  
>  
> +#define MARKERS_LEN		(2)
> +#define KVM_PGTABLE_MAX_LEVELS	(KVM_PGTABLE_LAST_LEVEL + 1)
> +
> +struct kvm_ptdump_guest_state {
> +	struct kvm		*kvm;
> +	struct pg_state		parser_state;
> +	struct addr_marker	ipa_marker[MARKERS_LEN];
> +	struct pg_level		level[KVM_PGTABLE_MAX_LEVELS];
> +	struct ptdump_range	range[MARKERS_LEN];
> +};
> +
> +static const struct prot_bits stage2_pte_bits[] = {
> +	{
> +		.mask	= PTE_VALID,
> +		.val	= PTE_VALID,
> +		.set	= " ",
> +		.clear	= "F",
> +	}, {
> +		.mask	= KVM_PTE_LEAF_ATTR_HI_S2_XN | PTE_VALID,
> +		.val	= KVM_PTE_LEAF_ATTR_HI_S2_XN | PTE_VALID,
> +		.set	= "XN",
> +		.clear	= "  ",
> +	}, {
> +		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R | PTE_VALID,
> +		.val	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R | PTE_VALID,
> +		.set	= "R",
> +		.clear	= " ",
> +	}, {
> +		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | PTE_VALID,
> +		.val	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | PTE_VALID,
> +		.set	= "W",
> +		.clear	= " ",
> +	}, {
> +		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_AF | PTE_VALID,
> +		.val	= KVM_PTE_LEAF_ATTR_LO_S2_AF | PTE_VALID,
> +		.set	= "AF",
> +		.clear	= "  ",
> +	}, {
> +		.mask	= PTE_NG,
> +		.val	= PTE_NG,
> +		.set	= "FnXS",
> +		.clear	= "  ",
> +	}, {
> +		.mask	= PTE_CONT | PTE_VALID,
> +		.val	= PTE_CONT | PTE_VALID,
> +		.set	= "CON",
> +		.clear	= "   ",
> +	}, {
> +		.mask	= PTE_TABLE_BIT,
>
> +		.val	= PTE_TABLE_BIT,
> +		.set	= "   ",
> +		.clear	= "BLK",
> +	},

When doing a kvm_pgtable_stage2_set_owner(), the walker will init a leaf which
has both the table-bit and the valid-bit unset. I believe this would lead to
spurious BLK annotations here.

The following should fix this problem:

  .mask		= PTE_TABLE_BIT | PTE_VALID,
  .val		= PTE_VALID,
  .set		= "BLK",
  .clear	= "   ",

> +};
> +
>  static int kvm_ptdump_visitor(const struct kvm_pgtable_visit_ctx *ctx,
>  			      enum kvm_pgtable_walk_flags visit)
>  {
> @@ -40,15 +95,79 @@ static int kvm_ptdump_show_common(struct seq_file *m,
>  	return kvm_pgtable_walk(pgtable, 0, BIT(pgtable->ia_bits), &walker);
>  }
>

[...]

