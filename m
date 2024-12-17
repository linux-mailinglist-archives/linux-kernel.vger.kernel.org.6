Return-Path: <linux-kernel+bounces-448841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAFC9F464E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6A23167C4C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBED1DDA37;
	Tue, 17 Dec 2024 08:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HJtB8A1X"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA901DD0E1
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734425052; cv=none; b=mr8OMx0b8w9oOPyzmgbefzVMzLBjiaEpcQtBqGCysCq1uACxZnKac5Bg0g9ng/of2X3+KNd/4qr15t582VpE6kVxI0yF9RGN0FDXQB9MxWJyKkWEimYCEYUWHEY7zYe1w5+s4y11ZsHeZmea09bFip7M50Np0c6G8KtdehlLW38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734425052; c=relaxed/simple;
	bh=CzNcFF88uddDnzy+LRXi6AvU0SQB03wFYGhto7aKcH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KkBGMVhn9SbEY5MqXO0zthFqEARUTim4YVOFUPv0OtvxLWAVa4/yIpPF+LCcWSkwG9/CCh47KO5XPf0IgybjX7wAncOt/tL3WCS/am2RFk+Ip/P81xsQSmzrPZh0QCUvr8domgAEwQVhw0a67gS6Su15s4GzW6hCzCqvww7VjR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HJtB8A1X; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4361d5730caso26935e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 00:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734425049; x=1735029849; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9aOMhauyNEGMb+lCk/+Fik0KUFbDUblO2f0wjbG5sGk=;
        b=HJtB8A1XYMpWKLK502qa6BYYIV7Kh1iUFn9zjrjOLUMzPJvjOEJzXSUI84QM5fm0Oz
         ue/Y2SKSgUuiYZ1ifZ1cNszn5W3euNIqExyE37nsZxImuVAV56lAALj5Nn31PgJn3FTH
         xbmKtX+kttWPL7kdpYLoGil3HuvyHFiQti2fFzjZN00DKIJ+A5JwoDG4NAs4Xq+WjHJy
         u0B6PGsNc5OeoH5zX/2aSTvvNHP1joEENrzPKP03VU3pEdzL5GsfNm7frGBHET3VAYyb
         0rG22ape5T8caoOP7vI0BPT/wfkpLXRLXJGZw4BnZBzlJCzn/8zPyLSRjWSBbnoc3PjO
         CV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734425049; x=1735029849;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9aOMhauyNEGMb+lCk/+Fik0KUFbDUblO2f0wjbG5sGk=;
        b=VcwAb+9DczEr/HJE/O5H/qePVwKscK9rcqEEKgunig6IQECVkXzxz4DHLlK5FcyN5Q
         o0nzE/kkeTzKydxTA+5L/u11dGUUhnFIUTZi4DZMWUKhl83m78LRTKcMYh6VLuZaoRqR
         L3XsHhpq/3WjhTnD0CZUKILj3fSYGilgyhNu1V8QKIsdXJU2ZwnG1/eIFt754l4cYXN0
         OhFMGa61o3SgaQ9KEEgpVV1PgtH/8mvuArX9TGgId80Q/lPm74XgEMXdO3XkbnSIp0PT
         3W95MQ0WVL9ofaqSd/PefVCh6n1wQPMtMS0DmFoEmnP/8RRlzz2yw9uIIdycyXsm7Joe
         DvWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEm7IOERycjmY1MtpZMncUca55+46vkppkBg6MiKQAqAsg4kMgv2dtDPwQnXNQbdyPW7544V8YXWNT1jI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcyKCS35EUBqP4AVDLHIDSmgPNqFlBm4Vie+iuHlfpIPb2EhUb
	zOmIImh3kMMgjXbIZW7WX4uS6QnF6ZnvpHY3wQgPw1DJ+CYr9k/Sz+BSwPg1v1rryxHSEeJ4l1T
	HCcfv/Gku/zYnhWoNC0w2T2/Pjj8RIY5OAkqq
X-Gm-Gg: ASbGncsEt2uYFVmFCYGcbgE2yFuL7CW0p3HacG1N9RH1PKHgkymlwBclEOfgy0MTQWN
	yxoJDqU1HBCcJ8NKxHD1FQ/Phaj9egs2HeFOvyThDGuy7Vp3ZWJ25lvSr91/8Xc0f7Wg=
X-Google-Smtp-Source: AGHT+IF4JRtgEWyFkNnA7Okyum1zxkryf5hfSceNzF5pRsh6nPxBddG8vtt5SAlgqybP5Y0TnQhiQk19Bz3LqCTEjLo=
X-Received: by 2002:a05:600c:4d21:b0:436:1aa8:d05d with SMTP id
 5b1f17b1804b1-43648c98e30mr922405e9.0.1734425049163; Tue, 17 Dec 2024
 00:44:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216175803.2716565-1-qperret@google.com> <20241216175803.2716565-3-qperret@google.com>
In-Reply-To: <20241216175803.2716565-3-qperret@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 17 Dec 2024 08:43:32 +0000
Message-ID: <CA+EHjTxmt4QdmiqCCJh9kf9aGL36hVXRXCr+EgdT1TDk_arJ=w@mail.gmail.com>
Subject: Re: [PATCH v3 02/18] KVM: arm64: Move enum pkvm_page_state to memory.h
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
> In order to prepare the way for storing page-tracking information in
> pKVM's vmemmap, move the enum pkvm_page_state definition to
> nvhe/memory.h.
>
> No functional changes intended.
>
> Signed-off-by: Quentin Perret <qperret@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h | 34 +------------------
>  arch/arm64/kvm/hyp/include/nvhe/memory.h      | 33 ++++++++++++++++++
>  2 files changed, 34 insertions(+), 33 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> index 8c30362af2b9..25038ac705d8 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> @@ -11,42 +11,10 @@
>  #include <asm/kvm_mmu.h>
>  #include <asm/kvm_pgtable.h>
>  #include <asm/virt.h>
> +#include <nvhe/memory.h>
>  #include <nvhe/pkvm.h>
>  #include <nvhe/spinlock.h>
>
> -/*
> - * SW bits 0-1 are reserved to track the memory ownership state of each page:
> - *   00: The page is owned exclusively by the page-table owner.
> - *   01: The page is owned by the page-table owner, but is shared
> - *       with another entity.
> - *   10: The page is shared with, but not owned by the page-table owner.
> - *   11: Reserved for future use (lending).
> - */
> -enum pkvm_page_state {
> -       PKVM_PAGE_OWNED                 = 0ULL,
> -       PKVM_PAGE_SHARED_OWNED          = BIT(0),
> -       PKVM_PAGE_SHARED_BORROWED       = BIT(1),
> -       __PKVM_PAGE_RESERVED            = BIT(0) | BIT(1),
> -
> -       /* Meta-states which aren't encoded directly in the PTE's SW bits */
> -       PKVM_NOPAGE                     = BIT(2),
> -};
> -#define PKVM_PAGE_META_STATES_MASK     (~(BIT(0) | BIT(1)))
> -
> -#define PKVM_PAGE_STATE_PROT_MASK      (KVM_PGTABLE_PROT_SW0 | KVM_PGTABLE_PROT_SW1)
> -static inline enum kvm_pgtable_prot pkvm_mkstate(enum kvm_pgtable_prot prot,
> -                                                enum pkvm_page_state state)
> -{
> -       prot &= ~PKVM_PAGE_STATE_PROT_MASK;
> -       prot |= FIELD_PREP(PKVM_PAGE_STATE_PROT_MASK, state);
> -       return prot;
> -}
> -
> -static inline enum pkvm_page_state pkvm_getstate(enum kvm_pgtable_prot prot)
> -{
> -       return FIELD_GET(PKVM_PAGE_STATE_PROT_MASK, prot);
> -}
> -
>  struct host_mmu {
>         struct kvm_arch arch;
>         struct kvm_pgtable pgt;
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> index ab205c4d6774..c84b24234ac7 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> @@ -7,6 +7,39 @@
>
>  #include <linux/types.h>
>
> +/*
> + * SW bits 0-1 are reserved to track the memory ownership state of each page:
> + *   00: The page is owned exclusively by the page-table owner.
> + *   01: The page is owned by the page-table owner, but is shared
> + *       with another entity.
> + *   10: The page is shared with, but not owned by the page-table owner.
> + *   11: Reserved for future use (lending).
> + */
> +enum pkvm_page_state {
> +       PKVM_PAGE_OWNED                 = 0ULL,
> +       PKVM_PAGE_SHARED_OWNED          = BIT(0),
> +       PKVM_PAGE_SHARED_BORROWED       = BIT(1),
> +       __PKVM_PAGE_RESERVED            = BIT(0) | BIT(1),
> +
> +       /* Meta-states which aren't encoded directly in the PTE's SW bits */
> +       PKVM_NOPAGE                     = BIT(2),
> +};
> +#define PKVM_PAGE_META_STATES_MASK     (~(BIT(0) | BIT(1)))
> +
> +#define PKVM_PAGE_STATE_PROT_MASK      (KVM_PGTABLE_PROT_SW0 | KVM_PGTABLE_PROT_SW1)
> +static inline enum kvm_pgtable_prot pkvm_mkstate(enum kvm_pgtable_prot prot,
> +                                                enum pkvm_page_state state)
> +{
> +       prot &= ~PKVM_PAGE_STATE_PROT_MASK;
> +       prot |= FIELD_PREP(PKVM_PAGE_STATE_PROT_MASK, state);
> +       return prot;
> +}
> +
> +static inline enum pkvm_page_state pkvm_getstate(enum kvm_pgtable_prot prot)
> +{
> +       return FIELD_GET(PKVM_PAGE_STATE_PROT_MASK, prot);
> +}
> +
>  struct hyp_page {
>         unsigned short refcount;
>         unsigned short order;
> --
> 2.47.1.613.gc27f4b7a9f-goog
>

