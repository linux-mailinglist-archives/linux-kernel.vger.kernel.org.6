Return-Path: <linux-kernel+bounces-307639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D334A9650A8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 22:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D8011F22EE7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47731BAEDC;
	Thu, 29 Aug 2024 20:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KFvgWyfG"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7525A1BA88F
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 20:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724962712; cv=none; b=WTm3Po9GbSmHrCI+Px4ULen5F8YxkZbRWvFysNPhgRbakT2WSGnRmwglOQMgt0JO6HjUf5GQRiS9YqD6/Lv+XDQUONabhPHOl6lw5gNgMKUiPq+z1r+Lr+qGdMAdgwmq/ioH13ptzLAe+G0D/TsNKpWTe3Yp9XwejVrKpdrRqG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724962712; c=relaxed/simple;
	bh=gWZDX2yB/LRVevbJYJAmyipmeTu7Crz6O/4RZ1n2yNw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NrXqw2xey4Wdk0TFo64HL6XV4T68tIazsuGx5Dv08xzywZjv1hmSYAeBf2K3aBN0JEvHqmT9zfvbfAdBPJGkb0H3oIq6OvDD/jmXyoR567ITWzgRj+ssqgyM1LTO4bgT6x/5uwhPl+bHIX+CY16PmwCMO5FNlncwpxRfgt3m9W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KFvgWyfG; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e13c3dee397so1727200276.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 13:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724962709; x=1725567509; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xp+nUWa7e3H9z7YXgjztwQOeCXL6SgtH037N9HE8+a8=;
        b=KFvgWyfG8c3iIGnKl/6UaxSTFyKWkqoO/nzaYxTmYl0uHrrDRRZKN4XNuQmfxWwsgw
         IB9xeOVFHUFzsOhmD6ASIBJ5w+X4GXPb6cLjxxSkVktJYDZPW2Ce48uL2wD2TkQ36wmM
         s3S5mU8JEk0WtPhRp0du4o1AkykFDLFKXPaqp+pt6X6gxaR9/w5UaqPjClfSHbEq4v15
         2xibPl78GP+UI2j+UP5v5M81YHVxxhzfvkkEJz1V1ajcfcyxSMEuiM3wjECSlpnA6vSb
         rDaofpM0Y4Vabq8eFofQA8aLob5/VRAni09bKilQL68FHPTNTEGOn6qtIuIB3+ADEUvJ
         hKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724962709; x=1725567509;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xp+nUWa7e3H9z7YXgjztwQOeCXL6SgtH037N9HE8+a8=;
        b=V8lNlnISgvoq2GY8XRbhYxLOdTOUevfBkM77A84Ajeg6QbE042eFUTPlI24B0xeWDQ
         mZvx0azyqdoOaA3+leeAlWvAqkGG4h+WWWdvPLUWdF3f5hSRL8eINkjr+miEBxJWPDWj
         5Ir6NkJbB+86Xi2lD9d5gleswGxMZ1ff2XQ5lFkppq8aIlOWEh+kHsvUBbNwFZcEHkAO
         TGFd/kCAFFMf//mXRXBxoU9aQRNjE/kBBurGJS+Zrirzb5FVveYEspl0V9t9VTePCzjM
         XO2Sme9cKBxnrJuqS0cRsJGRr4YMIsA9teOFG7Cy+0QzU7lGBu4u674vAHxkH0b2+nfK
         DCqw==
X-Forwarded-Encrypted: i=1; AJvYcCWifpgrRG1gjlvSI4IGXn1KsHnNBxjceewTZAliDt8jQfysSPenJAy1RhGOhCpfEXzBM4+yt9fYYJPLUw4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8czcQgdAieQ4s9N5KoxDyxcWNukN3cJe4Y6LvsVXJJ4Xexswa
	JtKGcvESZad2BN7tde7KhoEChDj+D4zMOxwt2m40QbM9nWze2n5XFGh+RGagse1OZr9W5qtEF3s
	bTw==
X-Google-Smtp-Source: AGHT+IGxLbIhfuqYDQioPCPEOkolNsROz1Gi6Rdvmdjoei6tLD1VnRlcfB7/z+Ib5bQ9Ont+AQs+mc72u2w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:4986:0:b0:e16:6d88:b8c2 with SMTP id
 3f1490d57ef6-e1a7a00db26mr7276.4.1724962709044; Thu, 29 Aug 2024 13:18:29
 -0700 (PDT)
Date: Thu, 29 Aug 2024 13:18:27 -0700
In-Reply-To: <20240829191135.2041489-2-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240829191135.2041489-1-vipinsh@google.com> <20240829191135.2041489-2-vipinsh@google.com>
Message-ID: <ZtDXQ6oeQrb8LxkX@google.com>
Subject: Re: [PATCH v2 1/4] KVM: x86/mmu: Track TDP MMU NX huge pages separately
From: Sean Christopherson <seanjc@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: pbonzini@redhat.com, dmatlack@google.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 29, 2024, Vipin Sharma wrote:
> @@ -871,8 +871,17 @@ void track_possible_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp)
>  		return;
>  
>  	++kvm->stat.nx_lpage_splits;
> -	list_add_tail(&sp->possible_nx_huge_page_link,
> -		      &kvm->arch.possible_nx_huge_pages);
> +	if (is_tdp_mmu_page(sp)) {
> +#ifdef CONFIG_X86_64
> +		++kvm->arch.tdp_mmu_possible_nx_huge_pages_count;
> +		list_add_tail(&sp->possible_nx_huge_page_link,
> +			      &kvm->arch.tdp_mmu_possible_nx_huge_pages);
> +#endif

Pass in the count+list, that way there's no #ifdef and no weird questions for
what happens if the impossible happens (is_tdp_mmu_page() on 32-bit KVM).

void track_possible_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp,
				 u64 *nr_pages, struct list_head *pages)
{
	/*
	 * If it's possible to replace the shadow page with an NX huge page,
	 * i.e. if the shadow page is the only thing currently preventing KVM
	 * from using a huge page, add the shadow page to the list of "to be
	 * zapped for NX recovery" pages.  Note, the shadow page can already be
	 * on the list if KVM is reusing an existing shadow page, i.e. if KVM
	 * links a shadow page at multiple points.
	 */
	if (!list_empty(&sp->possible_nx_huge_page_link))
		return;

	++kvm->stat.nx_lpage_splits;
	++(*nr_pages);
	list_add_tail(&sp->possible_nx_huge_page_link, pages);
}

> +	} else {
> +		++kvm->arch.possible_nx_huge_pages_count;
> +		list_add_tail(&sp->possible_nx_huge_page_link,
> +			      &kvm->arch.possible_nx_huge_pages);
> +	}
>  }
>  
>  static void account_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp,
> @@ -906,6 +915,13 @@ void untrack_possible_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp)
>  		return;
>  
>  	--kvm->stat.nx_lpage_splits;
> +	if (is_tdp_mmu_page(sp)) {
> +#ifdef CONFIG_X86_64
> +		--kvm->arch.tdp_mmu_possible_nx_huge_pages_count;
> +#endif
> +	} else {
> +		--kvm->arch.possible_nx_huge_pages_count;
> +	}

Same thing here.  Only tweak to my proposed API in patch 4 is that it needs to
take nr_pages as a pointer.  Then it can simply pass those along to this helper.

>  	list_del_init(&sp->possible_nx_huge_page_link);
>  }

