Return-Path: <linux-kernel+bounces-442215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E11E39ED968
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E44911886B4A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330CD1F0E30;
	Wed, 11 Dec 2024 22:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvgc3+yk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3EB195
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733955278; cv=none; b=ugxf5Vlpog+Tu047NNy8eMJpLLB93bNJ7f78SK9E/Ef+kJOYBR1Mz/fa0fri3B2dVy8YbeXqOBF66SjhrKw/mlCKtMdKWKRyM3jmO2TLDhqEXkZmU8SEWKPOr6/2g48xHLaPHSkZIyjjZgaKvgVXTYYgdIefbUc9M+ZIXSjziSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733955278; c=relaxed/simple;
	bh=ujediMw0TOstHDqQ4ofl4N4ln4S6/UT8wG3QPLJUwnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQ7u4J8u+k3U32grtVi8xDPesOtinZEDknJqKpOyNDNrejigtVh46zbTgk/FM0qYrirSUWqwEqqPRE6aP9ChALuIjXHBcsIZBFtBbceqkJujtIpTwGf7/qeGboJ3o9li04OUtLbXTm43lWSy1SG358CXVef6/6cikzPu3AA5kMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvgc3+yk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0556EC4CED2;
	Wed, 11 Dec 2024 22:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733955278;
	bh=ujediMw0TOstHDqQ4ofl4N4ln4S6/UT8wG3QPLJUwnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tvgc3+ykVPQJjeZiDDPCAOUUxdcVCqUGXxD1JCBw8OmFDY6LTvIDIQ2g2Hxunbvtu
	 T0QEPB5173T5k98uaK0WbHFInkcntyKlyr8JFTY3RiRzL9J4cdItxDTvzIqBJ78H9I
	 RSxqtdrVQRAJ4Y86PoFEf+Umjt9OqPPdtz73HTulR3FJeroFE6gRyJyx30Ogk/iz7M
	 StjJi86/QGxuucEJ1l2gcG4LbooKw5Zwb9+1uysOvE7TAVGuyFQVA/EEkvDYTVkU3y
	 6A3cekqTwwNWrzq0JIoZtD06iw8yLKOEJotWpjWdQbxmPof2s2E3NjachGtGX5CEPI
	 YeYl4v+eGLbWw==
Date: Wed, 11 Dec 2024 22:14:32 +0000
From: Will Deacon <will@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Kees Cook <keescook@chromium.org>,
	Quentin Perret <qperret@google.com>
Subject: Re: [PATCH v2 4/6] arm64/kvm: Avoid invalid physical addresses to
 signal owner updates
Message-ID: <20241211221431.GG17486@willie-the-truck>
References: <20241205150229.3510177-8-ardb+git@google.com>
 <20241205150229.3510177-12-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205150229.3510177-12-ardb+git@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Ard,

On Thu, Dec 05, 2024 at 04:02:34PM +0100, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The pKVM stage2 mapping code relies on an invalid physical address to
> signal to the internal API that only the owner_id fields of descriptors
> should be updated, and these are stored in the high bits of invalid
> descriptors covering memory that has been donated to protected guests,
> and is therefore unmapped from the host stage-2 page tables.
> 
> Given that these invalid PAs are never stored into the descriptors, it
> is better to rely on an explicit flag, to clarify the API and to avoid
> confusion regarding whether or not the output address of a descriptor
> can ever be invalid to begin with (which is not the case with LPA2).
> 
> That removes a dependency on the logic that reasons about the maximum PA
> range, which differs on LPA2 capable CPUs based on whether LPA2 is
> enabled or not, and will be further clarified in subsequent patches.
> 
> Cc: Quentin Perret <qperret@google.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/kvm/hyp/pgtable.c | 33 ++++++--------------
>  1 file changed, 10 insertions(+), 23 deletions(-)

Sorry that I didn't reply again on v1, but I have an annoying request
that would make this a little easier for me to follow (since I'm tainted
with the pKVM stack in Android that we're gradually landing upstream):

> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index 40bd55966540..0569e1d97c38 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -35,14 +35,6 @@ static bool kvm_pgtable_walk_skip_cmo(const struct kvm_pgtable_visit_ctx *ctx)
>  	return unlikely(ctx->flags & KVM_PGTABLE_WALK_SKIP_CMO);
>  }
>  
> -static bool kvm_phys_is_valid(u64 phys)
> -{
> -	u64 parange_max = kvm_get_parange_max();
> -	u8 shift = id_aa64mmfr0_parange_to_phys_shift(parange_max);
> -
> -	return phys < BIT(shift);
> -}
> -
>  static bool kvm_block_mapping_supported(const struct kvm_pgtable_visit_ctx *ctx, u64 phys)
>  {
>  	u64 granule = kvm_granule_size(ctx->level);
> @@ -53,7 +45,7 @@ static bool kvm_block_mapping_supported(const struct kvm_pgtable_visit_ctx *ctx,
>  	if (granule > (ctx->end - ctx->addr))
>  		return false;
>  
> -	if (kvm_phys_is_valid(phys) && !IS_ALIGNED(phys, granule))
> +	if (!IS_ALIGNED(phys, granule))
>  		return false;
>  
>  	return IS_ALIGNED(ctx->addr, granule);
> @@ -587,6 +579,9 @@ struct stage2_map_data {
>  
>  	/* Force mappings to page granularity */
>  	bool				force_pte;
> +
> +	/* Walk should update owner_id only */
> +	bool				owner_update;

Can you rename this to "annotation", please? We'll eventually land other
types of invalid pte than ownership (e.g. MMIO_GUARD) and, given that
the ownership walker is caught by the 'force_pte' flag, it's a little
more generic.

Again, apologies I didn't ask for this earlier.

Will

