Return-Path: <linux-kernel+bounces-576067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0773AA70AA2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F38CB188EA3C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6951C84B2;
	Tue, 25 Mar 2025 19:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPPXSp6E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E1213633F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 19:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742931544; cv=none; b=M1oILnUQE6sALq9TNmKYw7FrAtqo30LmNYnEDrjHpLdRQOvX/oB182RA1M2voVXkFmLUQYuxhHrFqjl01iK+arSXgZ9z1peYpyeWIRVSJxKQLTH8nkF0w5ljgolDXoSpJovNFvUHgMgYJC68UTbEPAk8yrX9REtN3TyRzsEqGbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742931544; c=relaxed/simple;
	bh=wtevGHjO9YfmadWTDHQb7tQn90i90ndWDKXe4b3kLSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXvbQpyNJgSEb/pvFshfB/bIdC0vE82evavsgezNq/ucAjbQibqva42gsOxIksIfUgjQt7qUq0yBm+aa8x62A9ysaPIDXd5P3P+gqRRVCj1gjxrrCriVJ8DVLlsXOIzOgBZ89oCfuY3K0dN9S3gOExBZ1+ztqGhVD4axMWD2ol0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPPXSp6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E086DC4CEE4;
	Tue, 25 Mar 2025 19:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742931543;
	bh=wtevGHjO9YfmadWTDHQb7tQn90i90ndWDKXe4b3kLSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UPPXSp6EoR0oYs4TLxEK4iOB5tlo7SGeKpZVf3ypQh3dpxUr+UqnQ+s+Xpo2syLCv
	 e9LX+Yi1UX+CjMbv/c++QblBKrV8LH5IpORXu4gtkAmEP5NhMDAuDVvCOa9je1S08n
	 mBrSSCMEXVn7kUDL9uIKSn4bt/l8fIcQQLf1qTSHuy5Bk8Tmgq3RrvQ8m1XIljZkbd
	 cSR6t4GogP6umlbx28rmjBnMWuKyBz4k8h+hdgM6Cbmiqy+3SxITwi5nCo02fAz1pj
	 +ELgoqFEY9h0lAjFjATkJxdtQkQZosA7YNTtyo2T/QQXpOC+CmTCz1VVUFhvxT+aX1
	 spCLId5bzt0nA==
Date: Tue, 25 Mar 2025 12:39:00 -0700
From: Kees Cook <kees@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 22/22] lkdtm: Obfuscate do_nothing() pointer
Message-ID: <202503251238.EE695D3@keescook>
References: <cover.1742852846.git.jpoimboe@kernel.org>
 <30b9abffbddeb43c4f6320b1270fa9b4d74c54ed.1742852847.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30b9abffbddeb43c4f6320b1270fa9b4d74c54ed.1742852847.git.jpoimboe@kernel.org>

On Mon, Mar 24, 2025 at 02:56:12PM -0700, Josh Poimboeuf wrote:
> If execute_location()'s memcpy of do_nothing() gets inlined and unrolled
> by the compiler, it copies one word at a time:
> 
>     mov    0x0(%rip),%rax    R_X86_64_PC32    .text+0x1374
>     mov    %rax,0x38(%rbx)
>     mov    0x0(%rip),%rax    R_X86_64_PC32    .text+0x136c
>     mov    %rax,0x30(%rbx)
>     ...
> 
> Those .text references point to the middle of the function, causing
> objtool to complain about their lack of ENDBR.
> 
> Prevent that by resolving the function pointer at runtime rather than
> build time.  This fixes the following warning:
> 
>   drivers/misc/lkdtm/lkdtm.o: warning: objtool: execute_location+0x23: relocation to !ENDBR: .text+0x1378
> 
> Cc: Kees Cook <kees@kernel.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202503191453.uFfxQy5R-lkp@intel.com/
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Thanks!

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

