Return-Path: <linux-kernel+bounces-342276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C137B988D07
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 01:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5A1E1C21189
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 23:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D791188A1F;
	Fri, 27 Sep 2024 23:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDd+11zs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD843C6BA
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 23:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727480569; cv=none; b=WuNKf5rCETcfhTya1USE5q/VY1Rn/iOzesv4TspVrnQo5zDfrdOQXhQ5bK0vMnz0o0iupHIFhRk27k0iS5JxFRHFhKes/ubKSGxtD6fI8ue8VbGSh/kiyzGYXZXYky8FK6jYSiO1Kp3wF3QefidANGP+KaY9eZ3CL+yj5S6Oedw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727480569; c=relaxed/simple;
	bh=bAGREr1e3Dkk12cNbHlWvlcD+qBvW+WZwLg67rAdCeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2RsAIfc7lIt613lWB+P3RSz0ksZxmNGiSuu8c0fIH63YTBcWkE2hSZ+0x4iLMlhmQrBXBEHioqQODs1TPxt911vV6PvrB0U0AEuaJi7nH+g2WHOKd9UGT9ZagSOfdaQGF5NuPOHTVw5GvBcjlHN04btWG6ZzKn9DfSOzJ34G2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDd+11zs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD905C4CEC4;
	Fri, 27 Sep 2024 23:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727480569;
	bh=bAGREr1e3Dkk12cNbHlWvlcD+qBvW+WZwLg67rAdCeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FDd+11zsYilZx/jb18ZyNVtnBimjCDF9DY2ubfxCK+SGYNEvvgJXK1i7BEDbil/Dx
	 19/raepIWGRsn7BVBcplaoBJN8tkHB/tTaB8T2JERxU/mTSfjgQToI/UQema9rd3bB
	 h+QKxJJKW9kz73Fb0uFB0qA7vwBTcNtvVamUI1IfDaj2L7kbOUaUJOYDyvfI9L4mXb
	 VhrFQIQdaB5jv0PHjRUZR1SSMRDK1wfLMf0KpJwGq4tloy1IGeJiw+OmBXv3wJgtCw
	 +jK780s3xrftC0b7vOFIFzyVwHlw1aLWlkE96RHbgzN7M+1ygpliO9QFZu4+HPoHNO
	 a65z0bYocZd7w==
Date: Fri, 27 Sep 2024 16:42:47 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jose.marchesi@oracle.com,
	hjl.tools@gmail.com, ndesaulniers@google.com,
	samitolvanen@google.com, nathan@kernel.org, ojeda@kernel.org,
	kees@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH 04/14] objtool/x86: Add .tail_call_sites
Message-ID: <20240927234247.tm4zsho6wdc5gmby@treble>
References: <20240927194856.096003183@infradead.org>
 <20240927194924.730517860@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240927194924.730517860@infradead.org>

On Fri, Sep 27, 2024 at 09:49:00PM +0200, Peter Zijlstra wrote:
> @@ -893,7 +893,6 @@ static int create_cfi_sections(struct ob
>  
>  	sec = find_section_by_name(file->elf, ".cfi_sites");
>  	if (sec) {
> -		INIT_LIST_HEAD(&file->call_list);

Hm, why exactly are we re-initing the list head anyway in these
boilerplate create_*_sections() functions?  I'm guessing that backfired
here.  I can't figure out a reason why we'd doing that anyway.

I'm also wondering why we made these boilerplate function names plural
"sections" when they only create a single section :-)

-- 
Josh

