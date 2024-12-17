Return-Path: <linux-kernel+bounces-448855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CE99F4674
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5F191885855
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7F71DD54C;
	Tue, 17 Dec 2024 08:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yY0aVGXw"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A764C1DE2B3
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734425346; cv=none; b=s+t10AwxwBE1aGNt2fFX58nrRHmo8ReVFOTiExkdJSO2ZS/vRwdJDeQDYd0ieo4L3lj6k5PvqoCZUgug4my0l9LjiABXFv3fXCZsMNQ1sApYjITuH+nguDjixTWzpWqIkLYrPfeENL3U3s7a6WAUIQ8gX+z0SZ0phLiDU05sQD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734425346; c=relaxed/simple;
	bh=0VUvLaeI1jcSJGzPxHY0N25cfAWXw/BqQdLY1b0053U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I3mmNNX4gIh8TPXJ0YdcfLZAaG59oLPBr+0byINOnUHe+ssu6JDIg5NYyiodegO/8FI/1chxSSKodgGHb/JwC24fsrTMyLZGE8y/9jfSt+Qy/Gz7naeIwMAdX4ssSsPPjDyv+1vp751HQToaBwjaGsWJfg2Jrkq7Igo6pHDqQLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yY0aVGXw; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43621d2dd4cso38715e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 00:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734425343; x=1735030143; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4gjynL615gvuMEubyjzZgIcz73t6loj7FWYasvQLRBg=;
        b=yY0aVGXwPgY68opsfopP4tkRYFflUWD+zJaLpfPBbdxQsBUTcrH+kvoSvgIcXauiW6
         kHXamY7C0EFthzfT4ZvqTKfJYq71UQM6VIwpnq7Z761/g5pDCGwCjBozDF4wJyPlY8eI
         +1prPwIil3UKida0e9FqVCd1GQ9tzcNWJo47J18fiP/bEyiVRVy0wNEDfAQWQAeemMyM
         5YSHx6qx1lykqE05jIPYbKD1MTgNtpGSrfbcBgJeacyN1xRUclYm4ZQOEbId9sR3qmy5
         w0UECY8MoN4BibxW8VVKSPSzRXyH8NdNzNKBsWKgpf9XNKZjMeciowWhf1sXI1CYmk2w
         McFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734425343; x=1735030143;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4gjynL615gvuMEubyjzZgIcz73t6loj7FWYasvQLRBg=;
        b=SAo+GWNGyRiVcHNuaWHMkETJkL793ccc3+aH45uU2pfBB7ih1ToyJ0F86q0DLmumSh
         XCGkMqkKHys24pGsV29bxdtwqpoJpUUmyPzCll39cc8bn3DZ+cUiTRMgeknDyyFVXgxK
         3xrb00gSkY2pjwopdogAMMcteS5Y1dFJ9Y8hQvORAhezVwvdVtNTofpceJpLMqJMQDo8
         717JzlkiKhiAaSFU/HW5LmCrJbTxkEpd7yrNUZubuyCkisgDazJ5zxqTPJj1RHUJvLoj
         9hN1sGw9fmhvZ+/LsaaUxIOKOE873WgFz1m0s22ecFvoLh8Ul37PY7yg4uOCF1pDI0Nk
         osRg==
X-Forwarded-Encrypted: i=1; AJvYcCWSUudtfu4qOCVE1KynajTnf0DUH+QZLZBa8uhEVwAqL27gK69FHsAxYNdWFcKp0x33aAzEDRJJ0jYD4gs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfuh8lBZIaVIZurAbWcRMrHed81mQBfOgT4qHNZcAESSa7I7mS
	59iYKkreKtT/P4kXUP6QNtzFDsGWbaSQoaB1caG9BiUqrMHLphoeLscoZ/YPsmnHocm7yXcYwCi
	Lyq5frO1HWuSY2Tu2+gblVMj5GooMekMOoEpp
X-Gm-Gg: ASbGncvI5dt0kPX67U5EMM+9MnZwSodJozb539zhz8a6RKl/+1FI63PUP/1eizTJjUU
	cYEJfJs8kNpjhOtNusaoTs/KLDk1zyJLrq5fEmCvkkIiM1qc7x+iEGLNSg3N8GhhhgNo=
X-Google-Smtp-Source: AGHT+IGAI2rWVb4Uka3Gw6cExIudf/OJEn5z1n6O5hn8Pif2f/f8zmfBayaqT+8yKyhtBHAyACTgJA5pJBzp//b6lyU=
X-Received: by 2002:a05:600c:5741:b0:436:1811:a79c with SMTP id
 5b1f17b1804b1-4364ad4db33mr735715e9.5.1734425342932; Tue, 17 Dec 2024
 00:49:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216175803.2716565-1-qperret@google.com> <20241216175803.2716565-8-qperret@google.com>
In-Reply-To: <20241216175803.2716565-8-qperret@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 17 Dec 2024 08:48:26 +0000
Message-ID: <CA+EHjTyYy6JxL0EH2=_VQe8+Qz7iCndPaU0C8gH69UnSkKhgtQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/18] KVM: arm64: Make kvm_pgtable_stage2_init() a
 static inline function
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
> Turn kvm_pgtable_stage2_init() into a static inline function instead of
> a macro. This will allow the usage of typeof() on it later on.
>
> Signed-off-by: Quentin Perret <qperret@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  arch/arm64/include/asm/kvm_pgtable.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> index c2f4149283ef..04418b5e3004 100644
> --- a/arch/arm64/include/asm/kvm_pgtable.h
> +++ b/arch/arm64/include/asm/kvm_pgtable.h
> @@ -526,8 +526,11 @@ int __kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm_s2_mmu *mmu,
>                               enum kvm_pgtable_stage2_flags flags,
>                               kvm_pgtable_force_pte_cb_t force_pte_cb);
>
> -#define kvm_pgtable_stage2_init(pgt, mmu, mm_ops) \
> -       __kvm_pgtable_stage2_init(pgt, mmu, mm_ops, 0, NULL)
> +static inline int kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm_s2_mmu *mmu,
> +                                         struct kvm_pgtable_mm_ops *mm_ops)
> +{
> +       return __kvm_pgtable_stage2_init(pgt, mmu, mm_ops, 0, NULL);
> +}
>
>  /**
>   * kvm_pgtable_stage2_destroy() - Destroy an unused guest stage-2 page-table.
> --
> 2.47.1.613.gc27f4b7a9f-goog
>

