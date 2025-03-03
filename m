Return-Path: <linux-kernel+bounces-541219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E42F9A4BA2D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CA031885EBE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8E21EF376;
	Mon,  3 Mar 2025 09:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rQmUB2lr"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0602E1EF096
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740992597; cv=none; b=OFPlEhKq/XJwyFwTX/WjJ89XIvccoa8W5Hy21Dj/LzESwVpYIduil6N+XNpvvlTFbPxNU+U6L5PRBaSw7VF06UzqZGMUiUaGB81BVimuyDYVk1FU5ZKz44A+0okaC2SxeLrSq9l0jpKLBImb+bRA+fsmzmfgMLAZjw1cFTPyM90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740992597; c=relaxed/simple;
	bh=idc8/NACOix78GnnSHuzlC9mQg3lcaqnvWb9GYuGSuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UorEGdrEg/8dONsKmKZhzpg65Hfeac8PhPuBtWJG31YJ5Q7mfqr3S5I01XnsoI5rTZ5lb16g/PHd15b8WnGANNBVXr2nd+U/K6eFDO7IN67+N/vJdBbPvCl/HO38SAxKwmTh/hnbw4hn90thndcygViRa+NgBQhfqc6VJPiZL8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rQmUB2lr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43998deed24so39411655e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 01:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740992594; x=1741597394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fnE1WKL8B2Bxfl1xiklk44H12/SEhBZrUiboyYR/TqM=;
        b=rQmUB2lrKQVVYFNovRN9Ld+5NbJ4fAYCmrH+b9kvG4tRVjMewmDD5Se4xvNJB0R6OK
         PPU3g6yj8MN4Wy4ayLM2ZyDSlx0hBZKmb9E2Ln2ynkceZzU/j8HqnnBqJgOzy8IE8Cl7
         wgb+EIQYNWMxjFsvM6wOQzbavJ3ohrXSAsue0DMa9cLCJr9Wpxdij7Gr8Kbz3WfKly3u
         TVv6fAoPwVwPsNwW11oYiUZ1IBSTFujkSouU0Dl0mxz2R0xloNdJ90UY8OBPdYkpiefm
         06b68isuSKpFBl+C+VZegnVSwZ8xUTv2joENOtaDMLCzWsyjWYdIiIf7ZylTmtsmarOJ
         bpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740992594; x=1741597394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnE1WKL8B2Bxfl1xiklk44H12/SEhBZrUiboyYR/TqM=;
        b=nno5BbGQnZB3bpzc3Kyc7jRcY8oGoePUKtiGSAxvSbwmnDUIVXLs+uHrfT4clJuX59
         PIZg7y9WL1MNC9/eJz8BPmPXfeXTfAtnMXSDVfb86gojsXMauvUcvnWGGakDTFdPsW5u
         uDkGD961BVqbRnp2/p4ThSbRES3Xho7of87Iyl3MTGzD6osZEc69b7a4joyyyXiD2SM5
         Z98kAbk168KQpCWQfhkyg3nuf1a51cEuetqVSRWYkfxpLBj9kbrgmvvJuKdInnmfyjQW
         b0A0zGK4K9VFVq0GxTDgc1fjgTLqu+7prM9FmDxJ8ZvCNy0+8Y+Zfrq3olpAlMcwRD3Q
         ck1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVnZzQQ590TdnMITa2uURk9qETq7wMd0H4mRI7l3ihGdwLHPfGNYCT+7YDcQNV4BJRkDv3Ws743YdnR51Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzX8bi2UAseskpaoKXdPEjX5jVCnTw4oVq4FwH40WJoqp2OopY
	RRvgYMtXGqWxmUWtR/l36qVaeMFTmdpvwICoEQUjvqyglJqdT5o+pbQeemVBJw==
X-Gm-Gg: ASbGncsHRTtItVJbdq113bLOpW4ZvlkT5KevHYsSCGls1t0GHlJqvhQbGiooavhjD+q
	GvQq0YElmkP7fx8i5ZB8xFMny4uvvSgoL7DXAuCU5t5ukta0z3a0sgL3bSqlmrFxDZLamYPpevX
	D9lhFZkAMYARQSGZmlj9B7z3pft12P1bs8H77Q/PkhkrBIFVgPu6LJDPj78/Jz0WENNXuDw34oR
	jP7R37l0jXzrwHpBB9emnko8gTcFk6jLYX3RtaV0b9BWXFWk2tOaSagOleN1+I4dpHds/bhmKi0
	LSLwgIvNxkcXWeidAk6ey59BzCCoNO0GX/ZlQS7W5MThDAF7cNINWVFJSsuPPOorXU19Ib9B/Mc
	sTSwu/3svI292
X-Google-Smtp-Source: AGHT+IGmAnvr5WwwGoSHGFphkhVZV6m70wz82I4YVRSVF548RcAtlCMZxGhqjzzDdhfLipt7qPEkPw==
X-Received: by 2002:a05:600c:a45:b0:439:9537:e96b with SMTP id 5b1f17b1804b1-43bb60464acmr37468755e9.14.1740992593951;
        Mon, 03 Mar 2025 01:03:13 -0800 (PST)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba58713bsm186635635e9.34.2025.03.03.01.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 01:03:13 -0800 (PST)
Date: Mon, 3 Mar 2025 09:03:09 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Quentin Perret <qperret@google.com>
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 2/9] KVM: arm64: Add a range to __pkvm_host_share_guest()
Message-ID: <Z8VwTf8nMvRNjgU_@google.com>
References: <20250228102530.1229089-1-vdonnefort@google.com>
 <20250228102530.1229089-3-vdonnefort@google.com>
 <Z8IJRpoQUoGazLku@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8IJRpoQUoGazLku@google.com>

On Fri, Feb 28, 2025 at 07:06:46PM +0000, Quentin Perret wrote:
> On Friday 28 Feb 2025 at 10:25:18 (+0000), Vincent Donnefort wrote:
> > +int __pkvm_host_share_guest(u64 pfn, u64 gfn, u64 nr_pages, struct pkvm_hyp_vcpu *vcpu,
> >  			    enum kvm_pgtable_prot prot)
> >  {
> >  	struct pkvm_hyp_vm *vm = pkvm_hyp_vcpu_to_hyp_vm(vcpu);
> >  	u64 phys = hyp_pfn_to_phys(pfn);
> >  	u64 ipa = hyp_pfn_to_phys(gfn);
> >  	struct hyp_page *page;
> > +	u64 size;
> >  	int ret;
> >  
> >  	if (prot & ~KVM_PGTABLE_PROT_RWX)
> >  		return -EINVAL;
> >  
> > -	ret = check_range_allowed_memory(phys, phys + PAGE_SIZE);
> 
> I'm not sure it is safe to drop this check here, see below.
> 
> > +	ret = __guest_check_transition_size(phys, ipa, nr_pages, &size);
> >  	if (ret)
> >  		return ret;
> >  
> >  	host_lock_component();
> >  	guest_lock_component(vm);
> >  
> > -	ret = __guest_check_page_state_range(vcpu, ipa, PAGE_SIZE, PKVM_NOPAGE);
> > +	ret = __guest_check_page_state_range(vm, ipa, size, PKVM_NOPAGE);
> >  	if (ret)
> >  		goto unlock;
> >  
> >  	page = hyp_phys_to_page(phys);
> 
> Phys really needs to be a valid memory address here for 'page' to be
> present in the vmemma -- dereference right below. So we can't rely on
> the check in __host_check_page_state_range() sadly ...

Haaa you're right. Sad to have this double check. Perhaps I won't use
__host_check_page_state_range() then.

> 
> > +	ret = __host_check_page_state_range(phys, size, page->host_state);
> > +	if (ret)
> > +		goto unlock;
> > +

[...]

