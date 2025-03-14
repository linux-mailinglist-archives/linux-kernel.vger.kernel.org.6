Return-Path: <linux-kernel+bounces-561371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67814A61090
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F9E462C90
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0891FE470;
	Fri, 14 Mar 2025 12:01:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426171FE467
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 12:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741953680; cv=none; b=sI0QEfTlO+49SIwg9YXm7icj1KmtmMmujUEDvYT2FJDydBkf0+meScOT5yR6yvihxQ7yPslUXjLAoRidWqGmHGKxF/2bnr9INMQdVaK4e5Zyfbyrfk1Rvf/5wqGtBlGwXhSGIhstBUUhIr3OB0kQwrIjpsBGZLMrVtOps43CAxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741953680; c=relaxed/simple;
	bh=GNMEGQbbSIyAAMRC3iRZX+xOl4U42GttIMpvJWCzPhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9Q5XlIs3xjqZZbCnGd9WYw0V4DhmDkxKHUnZWqtxwDlUn84z5dX22mZAOw+l5ajkjMHAN7SbsLp0U4TFF3V4lamNKd6gk2gF0zbG+q9LpSpLsHO4s5VP9EkrJ/TMFxfcVu53QU8wRgLRB4J0cnOelg9U8okOLwIbYMmLTGcmE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BF131424;
	Fri, 14 Mar 2025 05:01:28 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98BEB3F792;
	Fri, 14 Mar 2025 05:01:16 -0700 (PDT)
Date: Fri, 14 Mar 2025 12:01:11 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, robh@kernel.org,
	broonie@kernel.org, maz@kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] arm64/sysreg: Enforce whole word match for
 open/close tokens
Message-ID: <Z9Qah4N93Mhqr3-V@J2N7QTR9R3.cambridge.arm.com>
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

In retrospect, this is what I should have wirrten originally. Thanks for
the fix!

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

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
>  	block_push("SysregFields")
>  
>  	expect_fields(2)
> @@ -127,7 +127,8 @@ END {
>  	next
>  }
>  
> -/^EndSysregFields/ && block_current() == "SysregFields" {
> +$1 == "EndSysregFields" && block_current() == "SysregFields" {
> +	expect_fields(1)
>  	if (next_bit > 0)
>  		fatal("Unspecified bits in " reg)
>  
> @@ -145,7 +146,7 @@ END {
>  	next
>  }
>  
> -/^Sysreg/ && block_current() == "Root" {
> +$1 == "Sysreg" && block_current() == "Root" {
>  	block_push("Sysreg")
>  
>  	expect_fields(7)
> @@ -177,7 +178,8 @@ END {
>  	next
>  }
>  
> -/^EndSysreg/ && block_current() == "Sysreg" {
> +$1 == "EndSysreg" && block_current() == "Sysreg" {
> +	expect_fields(1)
>  	if (next_bit > 0)
>  		fatal("Unspecified bits in " reg)
>  
> @@ -206,7 +208,7 @@ END {
>  
>  # Currently this is effectivey a comment, in future we may want to emit
>  # defines for the fields.
> -(/^Fields/ || /^Mapping/) && block_current() == "Sysreg" {
> +($1 == "Fields" || $1 == "Mapping") && block_current() == "Sysreg" {
>  	expect_fields(2)
>  
>  	if (next_bit != 63)
> @@ -224,7 +226,7 @@ END {
>  }
>  
>  
> -/^Res0/ && (block_current() == "Sysreg" || block_current() == "SysregFields") {
> +$1 == "Res0" && (block_current() == "Sysreg" || block_current() == "SysregFields") {
>  	expect_fields(2)
>  	parse_bitdef(reg, "RES0", $2)
>  	field = "RES0_" msb "_" lsb
> @@ -234,7 +236,7 @@ END {
>  	next
>  }
>  
> -/^Res1/ && (block_current() == "Sysreg" || block_current() == "SysregFields") {
> +$1 == "Res1" && (block_current() == "Sysreg" || block_current() == "SysregFields") {
>  	expect_fields(2)
>  	parse_bitdef(reg, "RES1", $2)
>  	field = "RES1_" msb "_" lsb
> @@ -244,7 +246,7 @@ END {
>  	next
>  }
>  
> -/^Unkn/ && (block_current() == "Sysreg" || block_current() == "SysregFields") {
> +$1 == "Unkn" && (block_current() == "Sysreg" || block_current() == "SysregFields") {
>  	expect_fields(2)
>  	parse_bitdef(reg, "UNKN", $2)
>  	field = "UNKN_" msb "_" lsb
> @@ -254,7 +256,7 @@ END {
>  	next
>  }
>  
> -/^Field/ && (block_current() == "Sysreg" || block_current() == "SysregFields") {
> +$1 == "Field" && (block_current() == "Sysreg" || block_current() == "SysregFields") {
>  	expect_fields(3)
>  	field = $3
>  	parse_bitdef(reg, field, $2)
> @@ -265,14 +267,14 @@ END {
>  	next
>  }
>  
> -/^Raz/ && (block_current() == "Sysreg" || block_current() == "SysregFields") {
> +$1 == "Raz" && (block_current() == "Sysreg" || block_current() == "SysregFields") {
>  	expect_fields(2)
>  	parse_bitdef(reg, field, $2)
>  
>  	next
>  }
>  
> -/^SignedEnum/ && (block_current() == "Sysreg" || block_current() == "SysregFields") {
> +$1 == "SignedEnum" && (block_current() == "Sysreg" || block_current() == "SysregFields") {
>  	block_push("Enum")
>  
>  	expect_fields(3)
> @@ -285,7 +287,7 @@ END {
>  	next
>  }
>  
> -/^UnsignedEnum/ && (block_current() == "Sysreg" || block_current() == "SysregFields") {
> +$1 == "UnsignedEnum" && (block_current() == "Sysreg" || block_current() == "SysregFields") {
>  	block_push("Enum")
>  
>  	expect_fields(3)
> @@ -298,7 +300,7 @@ END {
>  	next
>  }
>  
> -/^Enum/ && (block_current() == "Sysreg" || block_current() == "SysregFields") {
> +$1 == "Enum" && (block_current() == "Sysreg" || block_current() == "SysregFields") {
>  	block_push("Enum")
>  
>  	expect_fields(3)
> @@ -310,7 +312,8 @@ END {
>  	next
>  }
>  
> -/^EndEnum/ && block_current() == "Enum" {
> +$1 == "EndEnum" && block_current() == "Enum" {
> +	expect_fields(1)
>  
>  	field = null
>  	msb = null
> -- 
> 2.34.1
> 

