Return-Path: <linux-kernel+bounces-448839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C5B9F464B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A020A168ED7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66B11DDA10;
	Tue, 17 Dec 2024 08:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FpUaVQak"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0432B18B46E
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734425027; cv=none; b=kwhrLvm7jI2ke4CzyH/eGb1RYW8IUIHXPWdmQiAj24nfJH2XkSWQB/eaRZs298XJeAbPglpZ70tqyA0k31PG9IkPNZ9PUshPjwLb99d9ki5nvCdBBeucevlnfWWPqF2EB02btevHfiie5RaG05/U0MunLUamfUJ67nP/6SUsOlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734425027; c=relaxed/simple;
	bh=Dh0Ctz2vowSmtTs36YbhCWvch6CdaR0SnXYuH2Kk708=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qaHM6LQ4/CycKEelWuvH3YkqTq9eMpNiJHiRa+4IWstfNUqp3JqE4kJF44TkmcaQQXX6XvckVWyHUf1y2lvVhAvrS9zEuI04494F+Isr6dRTYFHz5j5Q1Rpq42hiUVRDSwZFxY2xruN8Qgm0ONkGiOeOVj/T3psFqppkOrAFiS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FpUaVQak; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43622893c3cso26325e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 00:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734425022; x=1735029822; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d00JPz9uD5IVTXLbqjCoJE43ltdbYjCzx2p8kqI3aJM=;
        b=FpUaVQakbRm8mLYAEuqWiEXlAK4g9dTy+xJX9RIZaAksJ2NHRC2CP7SdAM1/RW0r5P
         7/LvqnOjOr9EL14ptKVNZmZtj+ZZhGViNSlM6x7grvQJxvZS6AUCniCiTxvybfeNgHWx
         DnA9n38Xq20zer1ZWLFvYqVgqjh6wrOJGj5pMSpYCWTHTTHUwJCC1ownvRsLFbjDRPs6
         AQeDQ/6GS0/v0LC2/D14UDeg8DDzVHrK11m99WsbT+SnIX6EGBwDdrbtC9BBU06eeRzJ
         h5gqHcai1Q7AGldsPLBtbU6UTxfkMuPQGkOQaexzVKWTYOQsVg/jAaRKOUh26VHplvJY
         JfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734425022; x=1735029822;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d00JPz9uD5IVTXLbqjCoJE43ltdbYjCzx2p8kqI3aJM=;
        b=W7i5PR5K+D4n2msi+UKMXHOEHBa+SC5+Z34jggaHRO/O8gWdQozNhmG1B6PTqmcgpw
         qNF5LWv+aCcCVnkd4jtQMLI8LzsMXPxZf993Ed+syCdA1yeb98jkcV3K1GM+W9gAy739
         9jZzqB7C/X2EoP2eyjQjNQbKyJUciwDI6hnOEZNpJ0qYrpOWxRYjSuSeUIxxRQJ0QPg2
         aB/DM841s8C8F4KelFMBKNze0A5gFc2A8a9TdexayN3tq+uENjlQkYy3t/dSpC+rZG5X
         hV3sFS7JmwTESrtRZDxIcp6DW6p4uqkTolfl2osheJpP78FuYMCFE7hEXmtJQXeixU9Z
         OjzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUv+CNHMyuEZU3MPO3G6XQPZ5nEZXfZwaH3T39Z82WjzfvdQ+9YE214CoSq4nec2iSVlGdDt70IqTxq2t8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpDoJU6cID9JlEJkfJGzH7BUYkHR9B47ZXEkuVbMtYF7yBYbuy
	gLjQy0K/uhZGvoaHIZnqV4z9wYOUYaME+6EaWlSADiwyGZ+s9o7wCuzACTQ9Fp8b+u9MgyJE8b9
	9pwmGEtNCjAolhWzjdnAXAjQu1Hlq2Da7ceER5py4ayJGkWsbKZt1
X-Gm-Gg: ASbGncvGORJYZIDtFn0T1eyZNyJw0fPLGN2mVQ3n48aZns/DdPkLfeMYJWHrGM5he1z
	0dADRxoSafxkuZvIPPhgJKFdkMzBu1jRvvmRRvUUXNWkqsITm2I4WIDnnRjLncYFCIzA=
X-Google-Smtp-Source: AGHT+IEsm2ztvlxRIl5e4zdw11F91muRBnmV6gL9hKtcRS9F1Dhy25XfzClb2ijrhja7+oQZG9pObyx3mcUaDBXuJjA=
X-Received: by 2002:a05:600c:5690:b0:434:9e1d:44ef with SMTP id
 5b1f17b1804b1-4364ad4d797mr740325e9.7.1734425022162; Tue, 17 Dec 2024
 00:43:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216175803.2716565-1-qperret@google.com> <20241216175803.2716565-2-qperret@google.com>
In-Reply-To: <20241216175803.2716565-2-qperret@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 17 Dec 2024 08:43:05 +0000
Message-ID: <CA+EHjTzYA5tFSR8YUfuEGzPjDYnp1a+T=K6AfwjGUVmxcQudjA@mail.gmail.com>
Subject: Re: [PATCH v3 01/18] KVM: arm64: Change the layout of enum pkvm_page_state
To: Quentin Perret <qperret@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Dec 2024 at 17:58, Quentin Perret <qperret@google.com> wrote:
>
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

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> index 0972faccc2af..8c30362af2b9 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> @@ -24,25 +24,27 @@
>   */
>  enum pkvm_page_state {
>         PKVM_PAGE_OWNED                 = 0ULL,
> -       PKVM_PAGE_SHARED_OWNED          = KVM_PGTABLE_PROT_SW0,
> -       PKVM_PAGE_SHARED_BORROWED       = KVM_PGTABLE_PROT_SW1,
> -       __PKVM_PAGE_RESERVED            = KVM_PGTABLE_PROT_SW0 |
> -                                         KVM_PGTABLE_PROT_SW1,
> +       PKVM_PAGE_SHARED_OWNED          = BIT(0),
> +       PKVM_PAGE_SHARED_BORROWED       = BIT(1),
> +       __PKVM_PAGE_RESERVED            = BIT(0) | BIT(1),
>
>         /* Meta-states which aren't encoded directly in the PTE's SW bits */
> -       PKVM_NOPAGE,
> +       PKVM_NOPAGE                     = BIT(2),
>  };
> +#define PKVM_PAGE_META_STATES_MASK     (~(BIT(0) | BIT(1)))
>
>  #define PKVM_PAGE_STATE_PROT_MASK      (KVM_PGTABLE_PROT_SW0 | KVM_PGTABLE_PROT_SW1)
>  static inline enum kvm_pgtable_prot pkvm_mkstate(enum kvm_pgtable_prot prot,
>                                                  enum pkvm_page_state state)
>  {
> -       return (prot & ~PKVM_PAGE_STATE_PROT_MASK) | state;
> +       prot &= ~PKVM_PAGE_STATE_PROT_MASK;
> +       prot |= FIELD_PREP(PKVM_PAGE_STATE_PROT_MASK, state);
> +       return prot;
>  }
>
>  static inline enum pkvm_page_state pkvm_getstate(enum kvm_pgtable_prot prot)
>  {
> -       return prot & PKVM_PAGE_STATE_PROT_MASK;
> +       return FIELD_GET(PKVM_PAGE_STATE_PROT_MASK, prot);
>  }
>
>  struct host_mmu {
> --
> 2.47.1.613.gc27f4b7a9f-goog
>

