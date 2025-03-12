Return-Path: <linux-kernel+bounces-557679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BE5A5DC5B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6931A16C5AD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146552417FA;
	Wed, 12 Mar 2025 12:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZ7nsg0b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723D123F397
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741781389; cv=none; b=tuuEE4FSi8EF/6OEsyUAMKbm0B9q/8z9XXZUxNdyzd/2ekHilNA/nTpKpsiv/VoHtL4VWnWqZjsCZq2C1nHzRRhNeMRE6hgd4lbNNz1SksOEeySRul9pnsIObRztHOwbyUuayyJHKtbFNSP0y47QtJ0TFVD9ajNdynjrdgudtnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741781389; c=relaxed/simple;
	bh=ePKJzle6qyNnC71no5zgjP4DK1N096xHBSlrkVI8cHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nixPjJWZThIqLEOyQ8zNGF9jnIlxIr1BKGIdLitLvVjqSBvGDQtU/QLz7p+dlLgKE2bL6RpYlp519UhfayKu34Jubb1D7C/Ddv0sQxAFWrpuLIBZms4RA4sP+V92XPBucWYs/mECXA/bVhqIAs5tnGCFASyvKCRuQZBdlUZB3NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZ7nsg0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B87BC4CEE3;
	Wed, 12 Mar 2025 12:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741781388;
	bh=ePKJzle6qyNnC71no5zgjP4DK1N096xHBSlrkVI8cHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SZ7nsg0boQ0khdvllQIOmleIx2ZkEGCRb+FAdEJqox/GM1vvaqL5FkaWDUYjdTjdv
	 +MaEhPgF3ZOY7zyV8txzD0SG/+eA69WHg0AnznAi4WfYTSKHHxW8wej+bDlo7AT+hk
	 eQyZigPnfF50GDxfmgdKOKvwhhBr6/94kyn5aVIVHmlI4EO+4751YLmZ6oeM54UaI2
	 nkOYTgzqhHkMJCsT0gfDjoROB5W8wzaY9CV3O/LWBiwm2bFrsKpYYb4Wqc8kMDU7c2
	 YM59eUcO5WfzVYUODs5vqQtxsYMv/fIRYdEakfgvIiLeiGMuBtIgDv6m9s1OudvxKN
	 0Sp0z9GjBxjww==
Date: Wed, 12 Mar 2025 13:09:43 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2] x86/hweight: Fix and improve __arch_hweight{32,64}()
 assembly
Message-ID: <Z9F5h7cEiV55dWMB@gmail.com>
References: <20250311150745.4492-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311150745.4492-1-ubizjak@gmail.com>


* Uros Bizjak <ubizjak@gmail.com> wrote:

> a) Use ASM_CALL_CONSTRAINT to prevent inline asm that includes call
> instruction from being scheduled before the frame pointer gets set
> up by the containing function. This unconstrained scheduling might
> cause objtool to print a "call without frame pointer save/setup"
> warning. Current versions of compilers don't seem to trigger this
> condition, but without this constraint there's nothing to prevent
> the compiler from scheduling the insn in front of frame creation.
> 
> b) Use asm_inline to instruct the compiler that the size of asm()
> is the minimum size of one instruction, ignoring how many instructions
> the compiler thinks it is. ALTERNATIVE macro that expands to several
> pseudo directives causes instruction length estimate to count
> more than 20 instructions.
> 
> c) Use named operands in inline asm.

I think this should be a 3-patch series. While it all modifies the same 
code, each change could introduce separate issues, so it's better to be 
individually bisectable IMO ...

Thanks,

	Ingo

