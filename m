Return-Path: <linux-kernel+bounces-342268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2969C988CE8
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 01:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC8CCB219EA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 23:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE9218C322;
	Fri, 27 Sep 2024 23:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXZhat2k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1C118892D
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 23:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727478931; cv=none; b=nf0td6ILYiUcVhvHGU0XDzqPAlZ9vS3YLmeIqBgJludWjIFAyLKC/T09KcAOlPSEz0lpdxIWu/AbGA+9PxxUaWjUVZNyOaSTffTlspUoVCqvOkDlElx7xRgAXw6gjKaLmem/ujN7WYV32gQempvSdkp8sNRL/z+aVa8scovBg9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727478931; c=relaxed/simple;
	bh=cwxtnm5wCxL37BhRwX28uNsajx5cUELdXIbAePm1gjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYFunYmWBrk/1XDdSKdbuJ3Ql0TPo7YtVLCGM5GyQpv5SkzWsj6XSsbN3xX4uy8/vDjWSo0O7wpTxmtQffRdJoO9uVj8jt19Iy//4mbKuagmP1WlwPlBsG6LrBTcVsh1SIXY4w2tRqbFXdqGIZ8tKgpWeIL0HIQzrVoPyUCbi5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXZhat2k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7348BC4CEC4;
	Fri, 27 Sep 2024 23:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727478930;
	bh=cwxtnm5wCxL37BhRwX28uNsajx5cUELdXIbAePm1gjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tXZhat2kKjR1zfehMh6y7e2oZri+2PLMX0Rzq+Hyhc8luikymKkT3z2x+pZucqgct
	 MnQMPNON4qdNRDHKR4FTJ1oes21c6esNO4O85l5X0VXRMjOJj0eVRszbrrnqM5hlSi
	 Camr66+/gJVzUmulO3VCq+jClPOlGEf+uccvKo1nbraWlDR1iDtG7wQFCaZpMpNJvk
	 AxlQlKnpAOWDp0h5dq4AUJvyn5b08hs2x1/l2t+ToRJ69zdsQ4/kBrbcHZuLzdRohK
	 YIMEStfprohi0hQPsqPt0qSU3+p70FUM6BI+XruNqFxIdAKnK2kfQwTeMBtFV5DZii
	 5j8zdxQ5IFQpA==
Date: Fri, 27 Sep 2024 16:15:27 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jose.marchesi@oracle.com,
	hjl.tools@gmail.com, ndesaulniers@google.com,
	samitolvanen@google.com, nathan@kernel.org, ojeda@kernel.org,
	kees@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH 01/14] x86/cfi: Wreck things...
Message-ID: <20240927231527.em2a4cjbnpos6c4u@treble>
References: <20240927194856.096003183@infradead.org>
 <20240927194924.390462812@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240927194924.390462812@infradead.org>

On Fri, Sep 27, 2024 at 09:48:57PM +0200, Peter Zijlstra wrote:
> vmlinux.o: warning: objtool: .export_symbol+0x3c9f0: data relocation to !ENDBR: entry_untrain_ret+0x0
> 
> Which states that while these functions are exported and (directly)
> callable, they cannot be called indirectly. There are two solutions:

IIRC, exported symbols are by far the most common "need" for ENDBR.  But
presumably the vast majority of them aren't being indirect called.

>  - exclude the .export_symbol section from validation; effectively
>    saying that having linkable but not indirectly callable exports are
>    fine by default, or

This is confusingly inconsistent IMO.

>  - make all of those use SYM_TYPED_FUNC_START to restore the
>    traditional (and expected, but less secure?) behaviour.

Why not just make SYM_FUNC_START imply "typed"?  That's consistent with
what the compiler does anyway right?

Even better, require exported+indirect-called symbols to use
EXPORT_SYMBOL_TYPED, otherwise they get sealed.  I suppose we'd need to
add some module-to-vmlinux ENDBR validation to make sure modules don't
get broken by this.

-- 
Josh

