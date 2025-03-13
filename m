Return-Path: <linux-kernel+bounces-560417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CC7A603C9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E37727A9BD3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 21:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6491F755E;
	Thu, 13 Mar 2025 21:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdB5fPEK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E91C1F560E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 21:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741903019; cv=none; b=MUuSE2h+BcNbi/Mqtl8Rf//hpvmdSVQKv4Yk0IZMFwKL3OpDQFJ50JSIYAUoguzDW1iXMGyFZOdLqu+uvLq9IqYPGNgCNGHE0Kaj07jRZ/hBcKR+L0fBW8oJ/UImhuTBJXZ1TuM7wa8iTQ5yAOmiQxGvonnfX37VugRuvLurp2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741903019; c=relaxed/simple;
	bh=yrnuKSIDcUeOE2Ia1gcmbVXvf0a2OSMKLH8MMZOfz70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bALbNYHJjMJXNLFlcynZTObrdl+nGn9GMQSEaWLujIgQSw4B82h+FOlRUNoQya+D5DZdFU9dQgTLftAbRkdTsRwigZt69Ub9QhQuSjD7hQVDb6YYzGPppwrdghnRcMOb+9CmxrkAYUvxb6QDjdncmkWnEEDyv7M/UcM2VAaepbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdB5fPEK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E558C4CEDD;
	Thu, 13 Mar 2025 21:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741903019;
	bh=yrnuKSIDcUeOE2Ia1gcmbVXvf0a2OSMKLH8MMZOfz70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MdB5fPEKxtsJL0sOPHXAWUnzKZaCP3AAuMkuhxF/x3L4yspa+52lC+7dbyzFDmqVH
	 LbngK8rmVBIRjaRuK9ZCUWnSWBzCBREL02+NcqEZAzaNBinzPV9y6xJzu6IoJPgp7k
	 wLz5OO3J+ykcR6eEQ6nMyByPniqbD7GEGw4vyFTh7/mgfhppBuLuuMp34xtSSrWSFs
	 ddMikFcQrLI/HNS16/lDkRXZonCR7m+66KW5eIdxkKYvjNMsu185RBa5wK7x/xmpVh
	 J/Cg/ixquLhIQZjqI5NqQfN16ie0pY57IyRvSeOu9yZt3cJ2l39LRLXx9d/e76oeZY
	 p1FsEjlDwelUg==
Date: Thu, 13 Mar 2025 21:56:54 +0000
From: Will Deacon <will@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, robh@kernel.org,
	broonie@kernel.org, maz@kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] arm64/sysreg: Fix unbalanced closing block
Message-ID: <20250313215652.GB8101@willie-the-truck>
References: <20250115162600.2153226-1-james.clark@linaro.org>
 <20250115162600.2153226-2-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115162600.2153226-2-james.clark@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Jan 15, 2025 at 04:25:55PM +0000, James Clark wrote:
> This is a sysreg block so close it with one. This doesn't make a
> difference to the output because the script only matches on the
> beginning of the word to close blocks which is correct by coincidence
> here.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  arch/arm64/tools/sysreg | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> index 762ee084b37c..bbe7df69da9c 100644
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -2074,7 +2074,7 @@ EndEnum
>  Res0	4:2
>  Field	1	ExTRE
>  Field	0	E0TRE
> -EndSysregFields
> +EndSysreg
>  
>  Sysreg	SMPRI_EL1	3	0	1	2	4
>  Res0	63:4
> -- 
> 2.34.1

Acked-by: Will Deacon <will@kernel.org>

Will

