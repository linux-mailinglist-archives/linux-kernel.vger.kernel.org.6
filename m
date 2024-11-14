Return-Path: <linux-kernel+bounces-408535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 813A89C801E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 02:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0645B1F242AC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 01:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5E11E3DD8;
	Thu, 14 Nov 2024 01:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jKWAaCa6"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F921D9A5E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 01:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731548554; cv=none; b=S94VM9fHfb8wVn+8hHjpj9lw+uK57eEQTf/X7a+RpyAmbL9wyZNZFozsU3tYY8OsX+QEoAaIQ3cUlvkV97IpQR/4TZlwu91dztBXNjzWUPcIuHcWcCwMO2mhi4OcnTQTNmzL3/Cn7n4Dc1iNIwjfbmg77V7WGGhVAzmaPihThwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731548554; c=relaxed/simple;
	bh=GjmL5g4akX2ituoZie3WUq2xUa+O19AH1J1pqo99/B0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ihdbG9p3/jYH4wIaeH2SyQuYKRME+kUYXcMrbgZQFr1grgyjARoiEoy2ViPE6nVr9/Thz8MQc2JAAeeSrmZZUSWjyPI8Ohvwp3h95UvZSSmx/F47oeqyr0BG6FkRbxP/6a+mjeFIffnuUTqEstUS690w0CcZJSMXlscYGx0Knrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jKWAaCa6; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea8901dff1so3014307b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 17:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731548552; x=1732153352; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p/5asxpXToKp0cYaKePoO536CyADDMkF6nOVQLtmz6c=;
        b=jKWAaCa6u+wdAkzrS0ZAZtYHCI4alKCjY4BdaSK5p9Oqh/w/f+ciJWGEX/i9lkZwvF
         9HfwHFGC2CWpUCCw9YAeyM1sASi/BjRI8xk5jTn5Kyvfo3xaI2qvGEyGaVE7IO8QzEUN
         U52IKtBSa5eMIs/0OLI5nVSHUoAe1ydwWfzXftswH/v3Ay2K2QERchTtrZw0Ra6+uqm0
         wOvN2jvClo3+uPR8koXCh2O3yAXUPozoyh1hXR3ULQbhBpJQ2e2FDWKlrYJXtBpn6jKg
         3eeiGr6MDG4XMe7crWqlz+rZ4YY2pJ5paJYsWsgSxAP9Y0LsJDdWZbp2EYrg9Z2j+zFe
         VFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731548552; x=1732153352;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p/5asxpXToKp0cYaKePoO536CyADDMkF6nOVQLtmz6c=;
        b=j1dRVWGJkB+0e9bWZUcn6r9ONdlWesHa0QajwpdaP3slk/oHHy7dknG4q6fs07trMx
         /fn40KR1SFk6NC6hWw/ZV2KI7ghVm17Jdn9NYFRnb5p33OsWFl5ogF3Y4t+OUbaAhGdu
         qZ921ebf98xMGUrcdRm12MnGOJw05WZo4Ft5d6b0/57pbkBdmd+Ba+LBu5Ouedquv3yB
         XE+OkJODjnWV/FRzuNHt+iYUECjMILk9WJDA/8VqDM/vPbc9dxZRJp30SwXwufXLF9Lz
         z1OSRSF5G5Ka8ev2sheSjd7myOqtIUY44cdpBPTaY1fMOoHT0vvkoDvb5YjV6x6Kh/2k
         oBRA==
X-Gm-Message-State: AOJu0YxghPZ2ma2Qy7ix7c9qBxTCmP0ngpAYDQKAr3Md0F4DbFZy61L7
	uo2Dqe5w07zGnn3hV0VE9bwJL8rdBz6hAOOFIwylWE+ls51N2x53Fbs4slg+rZvY6SxcHEMIMOR
	mEw==
X-Google-Smtp-Source: AGHT+IEvIOj8Qyt/HbzL/kVLii67/HuwcdEF/r7aoP0ES+v4i+S5o+ZjsfsP0Be86pNgtDFjK4u3YBSPE6s=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:508d:b0:6ea:8dad:c3b1 with SMTP id
 00721157ae682-6ee4341828dmr110157b3.3.1731548552042; Wed, 13 Nov 2024
 17:42:32 -0800 (PST)
Date: Wed, 13 Nov 2024 17:42:30 -0800
In-Reply-To: <20241108155056.332412-3-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108155056.332412-1-pbonzini@redhat.com> <20241108155056.332412-3-pbonzini@redhat.com>
Message-ID: <ZzVVhuqZqKxNXcuT@google.com>
Subject: Re: [PATCH 2/3] KVM: gmem: add a complete set of functions to query
 page preparedness
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, michael.roth@amd.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Nov 08, 2024, Paolo Bonzini wrote:
> In preparation for moving preparedness out of the folio flags, pass
> the struct file* or struct inode* down to kvm_gmem_mark_prepared,
> as well as the offset within the gmem file.  Introduce new functions
> to unprepare page on punch-hole, and to query the state.

...

> +static bool kvm_gmem_is_prepared(struct file *file, pgoff_t index, struct folio *folio)
> +{
> +	return folio_test_uptodate(folio);
> +}
> +
>  /*
>   * Process @folio, which contains @gfn, so that the guest can use it.
>   * The folio must be locked and the gfn must be contained in @slot.
>   * On successful return the guest sees a zero page so as to avoid
>   * leaking host data and the up-to-date flag is set.
>   */
> -static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
> +static int kvm_gmem_prepare_folio(struct kvm *kvm, struct file *file,
> +				  struct kvm_memory_slot *slot,
>  				  gfn_t gfn, struct folio *folio)
>  {
>  	unsigned long nr_pages, i;
> @@ -147,7 +157,7 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>  	index = ALIGN_DOWN(index, 1 << folio_order(folio));
>  	r = __kvm_gmem_prepare_folio(kvm, slot, index, folio);
>  	if (!r)
> -		kvm_gmem_mark_prepared(folio);
> +		kvm_gmem_mark_prepared(file, index, folio);
>  
>  	return r;
>  }
> @@ -231,6 +241,7 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
>  		kvm_gmem_invalidate_begin(gmem, start, end);
>  
>  	truncate_inode_pages_range(inode->i_mapping, offset, offset + len - 1);
> +	kvm_gmem_mark_range_unprepared(inode, start, end - start);
>  
>  	list_for_each_entry(gmem, gmem_list, entry)
>  		kvm_gmem_invalidate_end(gmem, start, end);
> @@ -682,7 +693,7 @@ __kvm_gmem_get_pfn(struct file *file, struct kvm_memory_slot *slot,
>  	if (max_order)
>  		*max_order = 0;
>  
> -	*is_prepared = folio_test_uptodate(folio);
> +	*is_prepared = kvm_gmem_is_prepared(file, index, folio);
>  	return folio;
>  }
>  
> @@ -704,7 +715,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>  	}
>  
>  	if (!is_prepared)
> -		r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
> +		r = kvm_gmem_prepare_folio(kvm, file, slot, gfn, folio);

This is broken when the next patch comes along.  If KVM encounters a partially
prepared folio, i.e. a folio with some prepared pages and some unprepared pages,
then KVM needs to zero only the unprepared pages.  But kvm_gmem_prepare_folio()
zeroes everything.

static int kvm_gmem_prepare_folio(struct kvm *kvm, struct file *file,
				  struct kvm_memory_slot *slot,
				  gfn_t gfn, struct folio *folio)
{
	unsigned long nr_pages, i;
	pgoff_t index;
	int r;

	nr_pages = folio_nr_pages(folio);
	for (i = 0; i < nr_pages; i++)
		clear_highpage(folio_page(folio, i));


