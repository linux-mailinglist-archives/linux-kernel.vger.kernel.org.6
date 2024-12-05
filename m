Return-Path: <linux-kernel+bounces-432916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FDA9E51CF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 140C12840A0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0809A2144D7;
	Thu,  5 Dec 2024 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="da1Yl04S"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ABB2144D0
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733392978; cv=none; b=s2TOvCDZyBsXbutpEprat/qQr6Q+Lj/7b8McILrHh4M60v3mdDcbCh0p99aD5e0GlPCr/DsUtOLs8Ar8tx9BYow3C09fK54OmlqG6fFT10/9Lr+MzHRhPFdTeuYcAovWf0Lyh1R3TWT76J9MSqCIYAFq6WZzz8mfEF7iZ+jyiI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733392978; c=relaxed/simple;
	bh=LvkMfRbMkc3UJedkuhSesFiMUtwIfWIIsDgAKT96qtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9kaLvNx0M4sWnZD03aekhsQf1l4TqaWEVf2BVtBsRXoJhyV6WySxVZCoUSV4zGCOHkUrINEowswtYQYZL34xXmpHo4wdtVflcEHTQpQFKgzPK/c8Ynvkxof+YAb36ucA6O5v0fLGrAw+IVn9uXlAKU6wDuGE+ECSy4xF81iiFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=da1Yl04S; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa62f5cbcffso17130066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 02:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733392974; x=1733997774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9IYXa/40G7joZADcNJXVHtQr7MJC/A4r2U/Fvo3+xRw=;
        b=da1Yl04SLmyLLcIowSCTB3f8SuNzfRLwDs3PGLKiArV8gsJLWAW3Cp+xeaa/B6AbRl
         lu3dfZamHC/o/JSjuprH4GvQQ9pJUWiRckjLMBVCQYseW+9fJyjgVWKjk4fkx9CiWZKx
         aJAU2K4iqfY8Y9RAo/GY1PIwFiaY7VArgE5/paxC6KFkpDmK1Mzfj7n7UsJrEknp02R1
         e54nAZigApRFuBZhSDItwp0YXTmHFxYv4P6H8ChNNjs876JZqD9Y7yV1iVYWgoaqwZDq
         cBckiiDPBfqXxag/v3fOApM/nVsT2icPQ79N32adDHNTWUInL9Yf3xKa97Wi7G2G4QIr
         sLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733392974; x=1733997774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IYXa/40G7joZADcNJXVHtQr7MJC/A4r2U/Fvo3+xRw=;
        b=vd5BH0dMnzVgdG97rMwY0w4urMjH5yQvNHu9GM24zPKvahS7vHHKNWJibwfMamsObp
         gl89W7V/lA4gis+9fcp9919r8GVwxoYPthIGw+74ExhRt3bGlAZLP9VlOPBxhy/ltomH
         7AtwfMRIBNbmN1KLxEfStYpRA3dipdK7S0d2nCNH1340SrrgMQtYujYtYi7N55zhh8Ks
         +NYvXM+9bv/EyaAWwl+EWmJeiQs4CGx2F+juXZA3MXhq2/6D3iOsDhT4x6Igrls6RBiM
         pxXzhOop8lrrAn9T8R6YaPeuqbQZmhZrLZVbCbEfEoDKy4vTakiLpQAdrtdFDeymtL2n
         3aUA==
X-Forwarded-Encrypted: i=1; AJvYcCWYT/o0JWGGX5uo5pc4YrtB0eDcMqzQRRuPOUEV5wlJjLFshSP8tBrG3r+PbqbS1rcOqMpVnjm4DZ+vSQg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8+UkCGCx3JXjyHtKMjaPrb6ZF0calIzWCzM/h86gSZZatmKEe
	G955DpQHoV3m+LeBz5oXFfVbK8D1WsuzJrgvdVJjkjUPWRUVQKWIggaduvDd/A==
X-Gm-Gg: ASbGncsUqeg4L8SKLoI50SJKv8+KWZiAH30/Dm27orNt/mxQunk2cVHIh1+gY4GXkxC
	W0wZVUHUrBhNSsu+0z+qEtcWPk2qzYTCnvxhVHcIEOewvBmb64Xqq5ch5hztJ5ck0EunoBfdp3K
	tZQI0Yn51OpsfRFjRB6TDtCQc+kehYczjNZIOpo5qOnyvvRieXMU4JaPqjdNqREYz6FyKGY3fT+
	s6Opo6SgCLKNg9vvztywwWyawujc9sOg6uAlUL95NHODrMwLq6kvKj4XQzmhqBpDLOrgsApHRde
	EXOGKSSO
X-Google-Smtp-Source: AGHT+IEbhaHnvcO/xjmAgQQ/5FSK25YVud/dNBmZ9dieMMOF7KaYUX8uT/6vgqqWi0UM3CwOtDPrag==
X-Received: by 2002:a17:907:d86:b0:aa5:340a:fb48 with SMTP id a640c23a62f3a-aa6202e0911mr233913266b.6.1733392973962;
        Thu, 05 Dec 2024 02:02:53 -0800 (PST)
Received: from google.com (61.134.90.34.bc.googleusercontent.com. [34.90.134.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e4db84sm70268866b.41.2024.12.05.02.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 02:02:53 -0800 (PST)
Date: Thu, 5 Dec 2024 10:02:50 +0000
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Always check the state from hyp_ack_unshare()
Message-ID: <Z1F6SpUQVPdjllUG@google.com>
References: <20241128154406.602875-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128154406.602875-1-qperret@google.com>

On Thursday 28 Nov 2024 at 15:44:06 (+0000), Quentin Perret wrote:
> There are multiple pKVM memory transitions where the state of a page is
> not cross-checked from the completer's PoV for performance reasons.
> For example, if a page is PKVM_PAGE_OWNED from the initiator's PoV,
> we should be guaranteed by construction that it is PKVM_NOPAGE for
> everybody else, hence allowing us to save a page-table lookup.
> 
> When it was introduced, hyp_ack_unshare() followed that logic and bailed
> out without checking the PKVM_PAGE_SHARED_BORROWED state in the
> hypervisor's stage-1. This was correct as we could safely assume that
> all host-initiated shares were directed at the hypervisor at the time.
> But with the introduction of other types of shares (e.g. for FF-A or
> non-protected guests), it is now very much required to cross check this
> state to prevent the host from running __pkvm_host_unshare_hyp() on a
> page shared with TZ or a non-protected guest.
> 
> Thankfully, if an attacker were to try this, the hyp_unmap() call from
> hyp_complete_unshare() would fail, hence causing to WARN() from
> __do_unshare() with the host lock held, which is fatal. But this is
> fragile at best, and can hardly be considered a security measure.
> 
> Let's just do the right thing and always check the state from
> hyp_ack_unshare().
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index caba3e4bd09e..e75374d682f4 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -783,9 +783,6 @@ static int hyp_ack_unshare(u64 addr, const struct pkvm_mem_transition *tx)
>  	if (tx->initiator.id == PKVM_ID_HOST && hyp_page_count((void *)addr))
>  		return -EBUSY;
>  
> -	if (__hyp_ack_skip_pgtable_check(tx))
> -		return 0;
> -
>  	return __hyp_check_page_state_range(addr, size,
>  					    PKVM_PAGE_SHARED_BORROWED);
>  }
> -- 
> 2.47.0.338.g60cca15819-goog

Shameless inbox bump for this one :-)

It should hopefully be a fairly straightforward fix.

Thanks,
Quentin

