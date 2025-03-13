Return-Path: <linux-kernel+bounces-560416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58726A603C8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20B377A906E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 21:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898451F709E;
	Thu, 13 Mar 2025 21:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCiqFnpC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47DF1F63C1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 21:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741902989; cv=none; b=cQR268d0M6GmH7oVa7C9nqGUHZQd5mL9uxfgGZeTvwxSqCr0hbG+cF5aUhCwRrYcHaRLjj9PK0n3HjnBK8vpvFVOMNeCQTAyP8Tegb5fqfAc7CldGlf9dzZr+3zFeJkP0GC7W8H0sspduqqhqTa2t9If0pJ0lGZTAZrhgIAuq+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741902989; c=relaxed/simple;
	bh=TKbcK7oZnLUUFbewILYOfqu9OkRqcOXwMXKVHin0yq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYFwjCLvMbThyZQy/J6cL6X+XA6lSDEuD0qXcbNteqJ8+tf1cK894x7k8N+VsUw+rZmgUoe6FX+VD51CC+bTH+Hbjxt9FGkb2zzJRZzXhsQMrh+Bhuuy9dihFKCvQWLpTqc1e44Sndp+l+TijTkZMPNQfW6YihK6i2/gshcpJ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCiqFnpC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658C2C4CEDD;
	Thu, 13 Mar 2025 21:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741902988;
	bh=TKbcK7oZnLUUFbewILYOfqu9OkRqcOXwMXKVHin0yq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XCiqFnpCEhmcNzdl5VjMdUP4t7FYJuXbcBM4C7NMRZE9AaR+m0pEsDTdD7vMsnUNb
	 8oqi41wh1aMVJCjG3bAZuUTpqyIhDpJj/0yiwMXpGj5mwhtKWa88vhSCUtJPdsrdOB
	 zZthIx+NCpjVKdJ3msZjys79AOyGfIPK+YS/R67+V3j/18TXu2133YLcVbedYvfRmx
	 msFlCbC7wqmzncu8uVMGRPQ5vzBN18HjBi2mQNPv1OLKL9JvQlyV1EISclMd6PjQnu
	 /GTW/AczLkojfdfl7bK5NZBTayXpIWKmQ93DeP9J57qUnnhYTqUpNz5c3qfIFLtvf4
	 /VTpnGzBmL0ew==
Date: Thu, 13 Mar 2025 21:56:23 +0000
From: Will Deacon <will@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, robh@kernel.org,
	broonie@kernel.org, maz@kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] arm64/sysreg: Enforce whole word match for
 open/close tokens
Message-ID: <20250313215622.GA8101@willie-the-truck>
References: <20250115162600.2153226-1-james.clark@linaro.org>
 <20250115162600.2153226-3-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115162600.2153226-3-james.clark@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Jan 15, 2025 at 04:25:56PM +0000, James Clark wrote:
> Opening and closing tokens can also match on words with common prefixes
> like "Endsysreg" vs "EndsysregFields". This could potentially make the
> script go wrong in weird ways so make it fall through to the fatal
> unhandled statement catcher if it doesn't fully match the current
> block.
> 
> Closing ones also get expect_fields(1) to ensure nothing other than
> whitespace follows.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  arch/arm64/tools/gen-sysreg.awk | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/tools/gen-sysreg.awk b/arch/arm64/tools/gen-sysreg.awk
> index 1a2afc9fdd42..f2a1732cb1f6 100755
> --- a/arch/arm64/tools/gen-sysreg.awk
> +++ b/arch/arm64/tools/gen-sysreg.awk
> @@ -111,7 +111,7 @@ END {
>  /^$/ { next }
>  /^[\t ]*#/ { next }
>  
> -/^SysregFields/ && block_current() == "Root" {
> +$1 == "SysregFields" && block_current() == "Root" {

Stylistic nit, but could you just do:

	/^SysregFields$/ && block_current() == "Root" {

instead? That way the diff is smaller (well, same number of lines) and
you avoid the ugly $1.

But I'm not an Orc, so who knows...

Will

