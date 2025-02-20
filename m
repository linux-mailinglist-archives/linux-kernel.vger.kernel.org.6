Return-Path: <linux-kernel+bounces-524802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E21A3E748
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D72AF7A9EBE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD9B1F03F3;
	Thu, 20 Feb 2025 22:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+USRd4A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FED1E9B07
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 22:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740089565; cv=none; b=BrTsjym2Qd3QOAldUVDa8koSOCb4sGIsA90HriL3MsSXxTkUB6l+CXx0S3ruZt3hYwq4zvhxM1uQYZMrlRnzzGFAG75zgJiwqyddwXvFQMUxyvp3aJsqddRSkt09+QlTBm4Vu5yad/Mr4lj+IWUtcVTprz4PfOLXCd87l1+EsLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740089565; c=relaxed/simple;
	bh=uyKh7wnb8TDinlMeRpuwYK67AejNrbRG5UBLByLInq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITOTL5MbeDRTApF8Cz9WiGc/OtuVUOSFMrDl9AFujDEdapf1S0NuxniftyntYhwSkVePUuxn0OCXAjvJBzyfUOswLhX1s+vm2lUYlm5VeNDOQsnNPVD/uVzZeauZdhYl5p5dy7XDPX25CmZmyuaqHuIIAe6l9ajMbE2nISxRQHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+USRd4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56991C4CED1;
	Thu, 20 Feb 2025 22:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740089564;
	bh=uyKh7wnb8TDinlMeRpuwYK67AejNrbRG5UBLByLInq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X+USRd4AfKPeHLNgh33LnNC9fp1u9JLCDQEcWiNHFjKa4TfgYpvAo2CxT11OrluKL
	 mYNEexT9a29NuOw0qh5syQMKOuETk9CsTPHsQMcNHaCa4R34Ffbq14vZkB53y10lW/
	 cyD08yWqOujKKCiIEpVX5eaoy8yjVfTHi//shGtvmPcCYd6rZ0PbuXpFh9BChxb8Kb
	 0w2Jl4/KY33oBa09xmW6ROHX/LFUcLfjja5E/O49+Cuu4GZT+Kk4ktlxxHBKan9NDx
	 uAOdDRZJ8QU7U7T8vMEFcwxCqXjX8O0wn/c2zz84iw+UXrnbHPaavfeUPRTfTRGwco
	 nJfvH2lQZrGXw==
Date: Thu, 20 Feb 2025 14:12:42 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/1] objdump: Fix disassembly if CROSS_COMPILE not set
Message-ID: <20250220221242.rdmfpabnhowjpu2m@jpoimboe>
References: <20250215142321.14081-1-david.laight.linux@gmail.com>
 <20250220221157.njqmvge5t6kvn6b5@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250220221157.njqmvge5t6kvn6b5@jpoimboe>

On Thu, Feb 20, 2025 at 02:11:59PM -0800, Josh Poimboeuf wrote:
> On Sat, Feb 15, 2025 at 02:23:21PM +0000, David Laight wrote:
> > If CROSS_COMPILE isn't set and -v specified the code tries to run
> > 	system("(null)objdump ....")
> > which really doesn't work very well.
> > Fix by changing NULL to "".
> > 
> > Fixes: ca653464dd097 ("objtool: Add verbose option for disassembling affected functions")
> > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > ---
> >  tools/objtool/check.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> > index 753dbc4f8198..c1b771e772fd 100644
> > --- a/tools/objtool/check.c
> > +++ b/tools/objtool/check.c
> > @@ -4506,6 +4506,8 @@ static int disas_funcs(const char *funcs)
> >  	char *cmd;
> >  
> >  	cross_compile = getenv("CROSS_COMPILE");
> > +	if (!cross_compile)
> > +		cross_compile = "";
> 
> Makes sense, I'm not sure how this works for me already?  Regardless:
> 
> Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> Peter, can you take this one?

With s/objdump/objtool/ in subject :-)

-- 
Josh

