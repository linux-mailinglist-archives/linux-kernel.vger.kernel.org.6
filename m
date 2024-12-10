Return-Path: <linux-kernel+bounces-439590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A28419EB174
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54AD3188123D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5001A9B5E;
	Tue, 10 Dec 2024 13:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NVX9X9wN"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326541A0B15
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835625; cv=none; b=beJJr3xasCInb9qStRhsvbMXmLlzFzxxNu1M0jt864irpISkBpl+IkaejIYwYEE/fvrNQ6m3RUjpDbmq//gne8q/xQ/mM3qOXIcSAB2zoY/uhwjwmC+NIY0PyxCw/aCpCsBE5IZk3OXEVYtnju5sV4kqEnSrT3JpRgX28zO9kq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835625; c=relaxed/simple;
	bh=c8cbwyGc6qrvJi5SHhLFBunv5BEzFDk3njGVg7z2Hvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j9NVmLoSe9ve60seUmyekrfpAfqaabO1J3l/tfakbm+3EjB7PxDlCbNpYjqkQ1r7VOA2tm7ZXONZWoerxZTOeI5dfWnLy7HGR9vjAJFJk9ZnuFnzmpCeF2vHLZJe39W2ohuXhDx1jxZz8tT3uQfczj7TOvOAecDW5B8+SYP9SaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NVX9X9wN; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434fa6bf6e4so33895e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 05:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733835621; x=1734440421; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hXgN7N+sfvyWYJUrx20Eam6+/moqssT/bJkQiBA9Rqc=;
        b=NVX9X9wNJRN6GNVxhLIVUAedQZBOzbW84B8g4Kx/oo/sxcitEmSGPmIXa/k0Rt6Yg5
         cTPDWJXHa7VD/9wD9vXtImuWsOFPPJAHSuuJBq1ie5Fqh1XoQpFlygBRw3z3eAKTS73r
         R3t1/a1qiVxmxf7ycwQbo4YP+vY3emE8dwo4YZ3aSKRaZOiXiGMKhesp6QCLgXjqXfsM
         sdjw7ipAiUmst/2U8AvUjHQet9Oiu2ilHdy70+wNe40oBNKPPASKX73TIti/1ys9YWTv
         v+Hs5/5kadclyBSkOny3JlFTQJv25x6EQVN5WlXj0J4vOiHrXN/XIkZodl9lICPK+q75
         eP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733835621; x=1734440421;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hXgN7N+sfvyWYJUrx20Eam6+/moqssT/bJkQiBA9Rqc=;
        b=xVDEaq8zLLLzeOUFl2WsnPdEb5otXfPh00tLZlY+wJLKDvsmnJPT4/RodjCGrqixAF
         neqQ2oAt+h1gYmrGEHOVk50vPO/dMyn78LOwofGllRneccSQ7OfHbZxaSGM8+xooLcty
         QfkMeIEo/rKw6KogC8jihkkGKNYaUhEOsEn7TgbiuBBsESrTHEn+IT99emlS9EhHMwsB
         +2O5CKEi/g6+gQbz/omAppY/F3/fSmh1t5anwkjSu/MCoGun6c0by4HdMwbRyUTJuK1e
         KVX5zBC+2nFfphun4YcmhVPcO04cUHWHHd5VrD8G7AXVOvkNK61eezed2+fukysm1eP3
         hBtg==
X-Forwarded-Encrypted: i=1; AJvYcCVSLX+uEs79ppBC+z8aUXSwnpW/LPFgJNY4cXF3iNnn97uHbokfsHNEqJd8nKGjmplCma15XkZ6nJV1Fj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeSrCSMj8yeO8M4LpliUKI3AUHJOJNTmmQzNVqJp2cEycOyoX1
	iXx/ZeRA0oi4y1SHRWglkVmJoZiNj1S9i5OCBog6KBGgjMkMl40bCSOkfZsdK+cFHud8NZgQB2D
	IHYfmkW8jT6fPOkoSjuiA09KFuLQNPJRb1KZ2
X-Gm-Gg: ASbGncvZ5NLG5zpLG/kJflZv80WS6BdCzao3zjT7BYV1zvwkM4Ld75BWKeQn3EFp5eE
	NwDos/dKSQ2yp3Da/SYePW6qN82k3uPkTKyffDBmRuttSJLm94SdMRnsdrRcwL+c3
X-Google-Smtp-Source: AGHT+IGaGhDWDnawra1F1/dbQTTbNMD9zXwWoIQ2OEhqZyNYqK9fVKTHmmaCrYxgr29shZgJAAHaKKezDZL8LZSStsI=
X-Received: by 2002:a05:600c:6b06:b0:434:9e1d:44ef with SMTP id
 5b1f17b1804b1-43539dd9773mr1029035e9.7.1733835621326; Tue, 10 Dec 2024
 05:00:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203103735.2267589-1-qperret@google.com> <20241203103735.2267589-2-qperret@google.com>
In-Reply-To: <20241203103735.2267589-2-qperret@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 10 Dec 2024 12:59:44 +0000
Message-ID: <CA+EHjTxfchr+ggO_z_zrrFTrFpS3oTJXt13t-854xWxYY=oSQQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/18] KVM: arm64: Change the layout of enum pkvm_page_state
To: Quentin Perret <qperret@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Quentin,

On Tue, 3 Dec 2024 at 10:37, Quentin Perret <qperret@google.com> wrote:
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
> +       BUG_ON(state & PKVM_PAGE_META_STATES_MASK);

This is a slight change in functionality, having a BUG_ON instead of
just masking out illegal states. Is it necessary?

Cheers,
/fuad


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
> 2.47.0.338.g60cca15819-goog
>

