Return-Path: <linux-kernel+bounces-522184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66372A3C721
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C5943AD026
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA62214A68;
	Wed, 19 Feb 2025 18:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6i9KZxD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE521A7264
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739988715; cv=none; b=Z+Al4AOSeyJDU/GxErMP2iFny9XsOd/ioDCdcyIwBGu7HOD/AzaSiXrpPVX+DH9itCsycbVDpMX5KqGBd8TMBwbmxkur7YR6Kji16G1CD8oJiunI34br75Mxu8eFtQ6ZRnnAvr4ojFyzUcfH6TnikZpnF7wXd4KIso6c5at+0Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739988715; c=relaxed/simple;
	bh=2yk+f4hF0trROeSpDOIcPoyING70h3GIYL3QYr3f3Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONZJz2fC4eKh5WPsnOl+Fhf6JQ1QLQVl0KDrkA7JvnEoJvvW8Fi/e9OjT/7NShc3gsBe7SflW+kkVXlZNtcvRSeHTAD6OwxJyJQXx26XElbmBu996amAfyvl//XlcHRURPsNQCZQFgcocBUk4BKRilcpxLqAp5qM84SwEbs/vtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6i9KZxD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B44C4CED1;
	Wed, 19 Feb 2025 18:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739988715;
	bh=2yk+f4hF0trROeSpDOIcPoyING70h3GIYL3QYr3f3Fs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t6i9KZxD/JHDVJv4xrDF1Xmo3ZlPyKbQWd5Dv209AFhq5TO79lKNOa7etkmYOGASZ
	 y6hTpKVMrozY42xH9w2fHgwhbjmqrLPGiQF7Oa5hjo9BAV2amGjRI7UMJ8x16cylOC
	 G1CIvRR/hxDF9cGysGBvXKQc+nPugwFKfgbGkWepiY/m7Ls1D/GMkwucsCfB7bd0fO
	 lonpcaVMOvXjZFkCJgkp7rUjV7TTFtzjNzUc5CnT4W9PAW6KorZccEQnKfPuskiE+K
	 9eBRd8UTsG9cW5rNU8TDUQ7i25G+uyMzP9C8402cK3VY3Znk6gJr7Inj3E9/RAkvcS
	 fESmh/5pcW2ww==
Date: Wed, 19 Feb 2025 10:11:52 -0800
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, samitolvanen@google.com, nathan@kernel.org,
	ojeda@kernel.org, alexei.starovoitov@gmail.com, mhiramat@kernel.org,
	jmill@asu.edu
Subject: Re: [PATCH v3 09/10] x86/ibt: Implement FineIBT-BHI mitigation
Message-ID: <202502191008.A13C96E1@keescook>
References: <20250219162107.880673196@infradead.org>
 <20250219163515.259229338@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219163515.259229338@infradead.org>

On Wed, Feb 19, 2025 at 05:21:16PM +0100, Peter Zijlstra wrote:
> While WAIT_FOR_ENDBR is specified to be a full speculation stop; it
> has been shown that some implementations are 'leaky' to such an extend
> that speculation can escape even the FineIBT preamble.
> 
> To deal with this, add additional hardening to the FineIBT preamble.
> 
> Notably, using a new LLVM feature:
> 
>   https://github.com/llvm/llvm-project/commit/e223485c9b38a5579991b8cebb6a200153eee245
> 
> which encodes the number of arguments in the kCFI preamble's register.
> 
> Using this register<->arity mapping, have the FineIBT preamble CALL
> into a stub clobbering the relevant argument registers in the
> speculative case.
> 
> (This is where Scott goes and gives more details...)
> 
> Suggested-by: Scott Constable <scott.d.constable@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

