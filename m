Return-Path: <linux-kernel+bounces-524649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFA3A3E56A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B1E07AB50B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0896D214814;
	Thu, 20 Feb 2025 19:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXsvJpQR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641EC1DED7C;
	Thu, 20 Feb 2025 19:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740081584; cv=none; b=GM8J3Ubu39Vg1QikmcYJwdAWjtQy6CJYqdu1mDGsU0SGNavREo3kSSD8+gtVguQwz+1JGAxKvaDDyLUP52ZkBDadrgPiHDSHRGXX/GweJfetmgO91NiJ1SoHkHH5MX1ts/HEwUZgQvsV1xJS8mJN2qVTkOhubKkCO/mIH2adPKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740081584; c=relaxed/simple;
	bh=vbTftWsandQc7OcCjdvC6lWo4bRP8tGg5iJy8RM0ZFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WU+Fv1kYSJ8QFiNLqa4zGE9FdTGd3sGItJId6iBHWAuDtBSLThSd4Ab16+oapeyiBzZm95XeF6rKZ+0UeK07Z4zyXSz2WqbAf345bmpzzOyVX03n9Id4GwMb7Kwhu1hqgKILQBLw8PllJgaW2tuvAeWj0RVBN3ZMEhkAd1pCSHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXsvJpQR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8405DC4CED1;
	Thu, 20 Feb 2025 19:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740081582;
	bh=vbTftWsandQc7OcCjdvC6lWo4bRP8tGg5iJy8RM0ZFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GXsvJpQRWYxUzYNPalhxtohdI0AQWCuZrKMRe+zMsiOQU1NqkxGyTjkAJg7dgfF0j
	 H+NxkGor/y1JBg3WjGrp1BlXUk+j2axZX5spQg2SacrxeCOx6g7Sz90Trll76DUK83
	 Azeuwk2Kljsz8E83cxHVQ2j6Hf6vwB2mOnD1bnwGd9/tuA5laaLroqHqgMJY73pqFi
	 8mawiI6SMrl2dxX3DZ8eHPROef9AsHe3Ch9aOeT2/7dDdVTfZSzB12xjP6vTwKTxA+
	 67aCzncwDRT2ts/DRekiofNn/2sEZp18FuRR8tHxR0fgFwWkk7RJH9fo9hY8IYKLts
	 RrQBHHjtAc8Fg==
Date: Thu, 20 Feb 2025 11:59:40 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Sathvika Vasireddy <sv@linux.ibm.com>
Cc: peterz@infradead.org, christophe.leroy@csgroup.eu, npiggin@gmail.com,
	maddy@linux.ibm.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, llvm@lists.linux.dev
Subject: Re: [RFC PATCH] objtool: Skip unannotated intra-function call
 warning for bl+mflr pattern
Message-ID: <20250220195940.ely2l2fpsozd2tuv@jpoimboe>
References: <20250219162014.10334-1-sv@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250219162014.10334-1-sv@linux.ibm.com>

On Wed, Feb 19, 2025 at 09:50:14PM +0530, Sathvika Vasireddy wrote:
> Architectures like PowerPC use a pattern where the compiler generates a
> branch-and-link (bl) instruction that targets the very next instruction,
> followed by loading the link register (mflr) later. This pattern appears
> in the code like:
> 
>  bl .+4
>  li r5,0
>  mflr r30

If I understand correctly, this is basically a fake call which is used
to get the value of the program counter?

> Objtool currently warns about this as an "unannotated intra-function
> call" because find_call_destination() fails to find any symbol at the
> target offset. Add a check to skip the warning when a branch targets
> the immediate next instruction in the same function.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202502180818.XnFdv8I8-lkp@intel.com/
> Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>

This should have a Fixes tag as well.

>  static int add_call_destinations(struct objtool_file *file)
>  {
> +	struct instruction *next_insn;
>  	struct instruction *insn;
>  	unsigned long dest_off;
>  	struct symbol *dest;
> @@ -1625,6 +1626,11 @@ static int add_call_destinations(struct objtool_file *file)
>  		reloc = insn_reloc(file, insn);
>  		if (!reloc) {
>  			dest_off = arch_jump_destination(insn);
> +
> +			next_insn = next_insn_same_func(file, insn);
> +			if (next_insn && dest_off == next_insn->offset)
> +				continue;
> +

This won't work on x86, where an intra-function call is converted to a
stack-modifying JUMP.  So this should probably be checked in an
arch-specific function.

-- 
Josh

