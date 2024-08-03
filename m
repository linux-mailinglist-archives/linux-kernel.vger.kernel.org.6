Return-Path: <linux-kernel+bounces-273448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8597946968
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 13:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5327D1F216F2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 11:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DCD14D44F;
	Sat,  3 Aug 2024 11:13:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E704A2F
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 11:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722683583; cv=none; b=Y4l07PEaCJ840Q037v9N3Z8CrdV7xTTrMptyb9HvkOgcFMHs6pADyn6JIpuSUxXQKCMctgnyk9xgoAj5hjIgLlGtnSPvleVAE69ng8G93txMp/fjAEt4gBDR2j7V6W6CUz4Nz7rZKcEERGWh1TQ42puX9O8Fw0UvDfkjUQAYWUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722683583; c=relaxed/simple;
	bh=EplbM1C3MWvVrXzQLtc3gcaGlQbxJoW/FJay2pRAN+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYeAMDrjrqwdQqSLGTVz6hz7OAqe6b8hTCKc+i0LEit/ftaYRHX2LQwR7yeq6QFeoLBFq0/CD4CdLJ1L9CuqUxi0MyIxKks9CfZgutamCPkjGNTmpD511eBv3kmNUIfH6OXZX2IgPRsLBJTG1IzV1WzWII8BAAdFvEL6l0T3+b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1947DA7;
	Sat,  3 Aug 2024 04:13:25 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 388743F64C;
	Sat,  3 Aug 2024 04:12:59 -0700 (PDT)
Date: Sat, 3 Aug 2024 12:12:56 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64/tools/sysreg: Add Sysreg128/SysregFields128
Message-ID: <Zq4QuLbGkXQvhbB0@J2N7QTR9R3>
References: <20240801054436.612024-1-anshuman.khandual@arm.com>
 <20240801054436.612024-2-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801054436.612024-2-anshuman.khandual@arm.com>

On Thu, Aug 01, 2024 at 11:14:36AM +0530, Anshuman Khandual wrote:
> FEAT_SYSREG128 enables 128 bit wide system registers which also need to be
> defined in (arch/arm64/toos/sysreg) for auto mask generation. This adds two
> new field types i.e Sysreg128 and SysregFields128 for that same purpose. It
> utilizes recently added macro GENMASK_U128() while also adding some helpers
> such as define_field_128() and parse_bitdef_128().
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/tools/gen-sysreg.awk | 231 ++++++++++++++++++++++++++++++++
>  1 file changed, 231 insertions(+)

Having Sysreg128 and SysregFields128 sounds reasonable, though I suspect
we can share more code with Sysreg and SysregFields (e.g. by always
using GENMASK128() even for regular SYsreg and SysregFIilds).

Regardless of this patch in particular, I think we want to see some
end-to-end usage (i.e. some actual bit definitions, along with asm and C
code that uses these definitions) so that we're confident this is the
right way to capture these definitions.

Sending this piecemeal, separate to those elements and sepate to
GENMASK_U128() makes this very painful to review effectively. Please
combine those elements into a single series so that reviewers can see
the entire picture.

Mark.

> diff --git a/arch/arm64/tools/gen-sysreg.awk b/arch/arm64/tools/gen-sysreg.awk
> index d1254a056114..a1571881d1c3 100755
> --- a/arch/arm64/tools/gen-sysreg.awk
> +++ b/arch/arm64/tools/gen-sysreg.awk
> @@ -56,6 +56,13 @@ function define_field(reg, field, msb, lsb) {
>  	define(reg "_" field "_WIDTH", msb - lsb + 1)
>  }
>  
> +function define_field_128(reg, field, msb, lsb) {
> +	define(reg "_" field, "GENMASK_U128(" msb ", " lsb ")")
> +	define(reg "_" field "_MASK", "GENMASK_U128(" msb ", " lsb ")")
> +	define(reg "_" field "_SHIFT", lsb)
> +	define(reg "_" field "_WIDTH", msb - lsb + 1)
> +}
> +
>  # Print a field _SIGNED definition for a field
>  function define_field_sign(reg, field, sign) {
>  	define(reg "_" field "_SIGNED", sign)
> @@ -89,6 +96,33 @@ function parse_bitdef(reg, field, bitdef, _bits)
>  	next_bit = lsb - 1
>  }
>  
> +function parse_bitdef_128(reg, field, bitdef, _bits)
> +{
> +	if (bitdef ~ /^[0-9]+$/) {
> +		msb = bitdef
> +		lsb = bitdef
> +	} else if (split(bitdef, _bits, ":") == 2) {
> +		msb = _bits[1]
> +		lsb = _bits[2]
> +	} else {
> +		fatal("invalid bit-range definition '" bitdef "'")
> +	}
> +
> +
> +	if (msb != next_bit)
> +		fatal(reg "." field " starts at " msb " not " next_bit)
> +	if (127 < msb || msb < 0)
> +		fatal(reg "." field " invalid high bit in '" bitdef "'")
> +	if (127 < lsb || lsb < 0)
> +		fatal(reg "." field " invalid low bit in '" bitdef "'")
> +	if (msb < lsb)
> +		fatal(reg "." field " invalid bit-range '" bitdef "'")
> +	if (low > high)
> +		fatal(reg "." field " has invalid range " high "-" low)
> +
> +	next_bit = lsb - 1
> +}
> +
>  BEGIN {
>  	print "#ifndef __ASM_SYSREG_DEFS_H"
>  	print "#define __ASM_SYSREG_DEFS_H"
> @@ -111,6 +145,99 @@ END {
>  /^$/ { next }
>  /^[\t ]*#/ { next }
>  
> +/^SysregFields128/ && block_current() == "Root" {
> +	block_push("SysregFields128")
> +
> +	expect_fields(2)
> +
> +	reg = $2
> +
> +	res0 = "UL(0)"
> +	res1 = "UL(0)"
> +	unkn = "UL(0)"
> +
> +	next_bit = 127
> +
> +	next
> +}
> +
> +/^EndSysregFields128/ && block_current() == "SysregFields128" {
> +	if (next_bit > 0)
> +		fatal("Unspecified bits in " reg)
> +
> +	define(reg "_RES0", "(" res0 ")")
> +	define(reg "_RES1", "(" res1 ")")
> +	define(reg "_UNKN", "(" unkn ")")
> +	print ""
> +
> +	reg = null
> +	res0 = null
> +	res1 = null
> +	unkn = null
> +
> +	block_pop()
> +	next
> +}
> +
> +/^Sysreg128/ && block_current() == "Root" {
> +	block_push("Sysreg128")
> +
> +	expect_fields(7)
> +
> +	reg = $2
> +	op0 = $3
> +	op1 = $4
> +	crn = $5
> +	crm = $6
> +	op2 = $7
> +
> +	res0 = "UL(0)"
> +	res1 = "UL(0)"
> +	unkn = "UL(0)"
> +
> +	define("REG_" reg, "S" op0 "_" op1 "_C" crn "_C" crm "_" op2)
> +	define("SYS_" reg, "sys_reg(" op0 ", " op1 ", " crn ", " crm ", " op2 ")")
> +
> +	define("SYS_" reg "_Op0", op0)
> +	define("SYS_" reg "_Op1", op1)
> +	define("SYS_" reg "_CRn", crn)
> +	define("SYS_" reg "_CRm", crm)
> +	define("SYS_" reg "_Op2", op2)
> +
> +	print ""
> +
> +	next_bit = 127
> +
> +	next
> +}
> +
> +/^EndSysreg128/ && block_current() == "Sysreg128" {
> +	if (next_bit > 0)
> +		fatal("Unspecified bits in " reg)
> +
> +	if (res0 != null)
> +		define(reg "_RES0", "(" res0 ")")
> +	if (res1 != null)
> +		define(reg "_RES1", "(" res1 ")")
> +	if (unkn != null)
> +		define(reg "_UNKN", "(" unkn ")")
> +	if (res0 != null || res1 != null || unkn != null)
> +		print ""
> +
> +	reg = null
> +	op0 = null
> +	op1 = null
> +	crn = null
> +	crm = null
> +	op2 = null
> +	res0 = null
> +	res1 = null
> +	unkn = null
> +
> +	block_pop()
> +	next
> +}
> +
>  /^SysregFields/ && block_current() == "Root" {
>  	block_push("SysregFields")
>  
> @@ -223,6 +350,22 @@ END {
>  	next
>  }
>  
> +/^Fields/ && block_current() == "Sysreg128" {
> +	expect_fields(2)
> +
> +	if (next_bit != 127)
> +		fatal("Some fields already defined for " reg)
> +
> +	print "/* For " reg " fields see " $2 " */"
> +	print ""
> +
> +        next_bit = 0
> +	res0 = null
> +	res1 = null
> +	unkn = null
> +
> +	next
> +}
>  
>  /^Res0/ && (block_current() == "Sysreg" || block_current() == "SysregFields") {
>  	expect_fields(2)
> @@ -234,6 +377,16 @@ END {
>  	next
>  }
>  
> +/^Res0/ && (block_current() == "Sysreg128" || block_current() == "SysregFields128") {
> +	expect_fields(2)
> +	parse_bitdef_128(reg, "RES0", $2)
> +	field = "RES0_" msb "_" lsb
> +
> +	res0 = res0 " | GENMASK_U128(" msb ", " lsb ")"
> +
> +	next
> +}
> +
>  /^Res1/ && (block_current() == "Sysreg" || block_current() == "SysregFields") {
>  	expect_fields(2)
>  	parse_bitdef(reg, "RES1", $2)
> @@ -244,6 +397,16 @@ END {
>  	next
>  }
>  
> +/^Res1/ && (block_current() == "Sysreg128" || block_current() == "SysregFields128") {
> +	expect_fields(2)
> +	parse_bitdef_128(reg, "RES1", $2)
> +	field = "RES1_" msb "_" lsb
> +
> +	res1 = res1 " | GENMASK_U128(" msb ", " lsb ")"
> +
> +	next
> +}
> +
>  /^Unkn/ && (block_current() == "Sysreg" || block_current() == "SysregFields") {
>  	expect_fields(2)
>  	parse_bitdef(reg, "UNKN", $2)
> @@ -254,6 +417,16 @@ END {
>  	next
>  }
>  
> +/^Unkn/ && (block_current() == "Sysreg128" || block_current() == "SysregFields128") {
> +	expect_fields(2)
> +	parse_bitdef_128(reg, "UNKN", $2)
> +	field = "UNKN_" msb "_" lsb
> +
> +	unkn = unkn " | GENMASK_U128(" msb ", " lsb ")"
> +
> +	next
> +}
> +
>  /^Field/ && (block_current() == "Sysreg" || block_current() == "SysregFields") {
>  	expect_fields(3)
>  	field = $3
> @@ -265,6 +438,17 @@ END {
>  	next
>  }
>  
> +/^Field/ && (block_current() == "Sysreg128" || block_current() == "SysregFields128") {
> +	expect_fields(3)
> +	field = $3
> +	parse_bitdef_128(reg, field, $2)
> +
> +	define_field_128(reg, field, msb, lsb)
> +	print ""
> +
> +	next
> +}
> +
>  /^Raz/ && (block_current() == "Sysreg" || block_current() == "SysregFields") {
>  	expect_fields(2)
>  	parse_bitdef(reg, field, $2)
> @@ -272,6 +456,14 @@ END {
>  	next
>  }
>  
> +/^Raz/ && (block_current() == "Sysreg128" || block_current() == "SysregFields128") {
> +	expect_fields(2)
> +	parse_bitdef_128(reg, field, $2)
> +
> +	next
> +}
> +
> +
>  /^SignedEnum/ && (block_current() == "Sysreg" || block_current() == "SysregFields") {
>  	block_push("Enum")
>  
> @@ -285,6 +477,19 @@ END {
>  	next
>  }
>  
> +/^SignedEnum/ && (block_current() == "Sysreg128" || block_current() == "SysregFields128") {
> +	block_push("Enum")
> +
> +	expect_fields(3)
> +	field = $3
> +	parse_bitdef_128(reg, field, $2)
> +
> +	define_field_128(reg, field, msb, lsb)
> +	define_field_sign(reg, field, "true")
> +
> +	next
> +}
> +
>  /^UnsignedEnum/ && (block_current() == "Sysreg" || block_current() == "SysregFields") {
>  	block_push("Enum")
>  
> @@ -298,6 +503,20 @@ END {
>  	next
>  }
>  
> +/^UnsignedEnum/ && (block_current() == "Sysreg128" || block_current() == "SysregFields128") {
> +	block_push("Enum")
> +
> +	expect_fields(3)
> +	field = $3
> +	parse_bitdef_128(reg, field, $2)
> +
> +	define_field_128(reg, field, msb, lsb)
> +	define_field_sign(reg, field, "false")
> +
> +	next
> +}
> +
> +
>  /^Enum/ && (block_current() == "Sysreg" || block_current() == "SysregFields") {
>  	block_push("Enum")
>  
> @@ -310,6 +529,18 @@ END {
>  	next
>  }
>  
> +/^Enum/ && (block_current() == "Sysreg128" || block_current() == "SysregFields128") {
> +	block_push("Enum")
> +
> +	expect_fields(3)
> +	field = $3
> +	parse_bitdef_128(reg, field, $2)
> +
> +	define_field_128(reg, field, msb, lsb)
> +
> +	next
> +}
> +
>  /^EndEnum/ && block_current() == "Enum" {
>  
>  	field = null
> -- 
> 2.30.2
> 
> 

