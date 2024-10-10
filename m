Return-Path: <linux-kernel+bounces-358252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE869997C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 847131F24BFA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 04:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498D219DF8B;
	Thu, 10 Oct 2024 04:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHGJOb/P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84DF18F2FF
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728536151; cv=none; b=q0pqFmD6iIEULKZQq/+E0jtyIjvGezgUU0FHSJjt55FacvpIChMj7Fo0tnuTrQjVEg3BA7MlZmDRWKLHdEyZWWNiikmeviqY3nX4XHAyH14zoI3QXCNCILz3rr2AG4WFcbE+Hhm+0XeTG6Nm/5SJMX6YTU8avCcU24gYrn3sCsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728536151; c=relaxed/simple;
	bh=7Hb8+1NY3gbVVMkT1xM+VLo6Upz6WuBtNPGG05PFcnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDL2G/XRpRuh0QeuJ6chzZP0Jx0judK4YoDi5gQaVUuNqBOMHka/c/GwqAKZMo5f4GpjaoJyQwtbksZWSJZuyqHh+W4hgiWiV/CnJC3oMcKOouM43Vt9wwDWfEmz6MrA8LIJx44y/umqdj/djAfnWBWUEZkst8/I+DHu64A1x/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHGJOb/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA55C4CEC6;
	Thu, 10 Oct 2024 04:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728536151;
	bh=7Hb8+1NY3gbVVMkT1xM+VLo6Upz6WuBtNPGG05PFcnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KHGJOb/Pg+llP8+wp2YxeQuX5KtA/XveH5dxwP9YJ23SrXKfGebJzXnHqXrALeayF
	 QgfcwsdJzL57jwsiTf4+T8AHVvDNfU/eAXHe1P/KR/pKfYSbczWctfxpKiyzVNFq3I
	 d03AwK3eKEY9kP/+xdo/1XRwzW3ianCoUFahTTyV0VZFf2CBK8JM3d50R+vv9y9a6B
	 5A2jwk5xUm44CwSs064q8yit4yd96vcaE6V7vFV1Vr1aqetdUh4VLthN9/glOXSciR
	 q2CoXwQOKv8rSB1yM60LuiTygq8sdPofULLpoQGXCjuqXl5KJqPLRggVEWSNI9Y40W
	 uoVbevn42GMNw==
Date: Wed, 9 Oct 2024 21:55:49 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jose.marchesi@oracle.com,
	hjl.tools@gmail.com, ndesaulniers@google.com,
	samitolvanen@google.com, nathan@kernel.org, ojeda@kernel.org,
	kees@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH 04/14] objtool/x86: Add .tail_call_sites
Message-ID: <20241010045549.3repx52zkefgu32w@treble.attlocal.net>
References: <20240927194856.096003183@infradead.org>
 <20240927194924.730517860@infradead.org>
 <20240927234247.tm4zsho6wdc5gmby@treble>
 <20241009152503.GR17263@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241009152503.GR17263@noisy.programming.kicks-ass.net>

On Wed, Oct 09, 2024 at 05:25:03PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 27, 2024 at 04:42:47PM -0700, Josh Poimboeuf wrote:
> > On Fri, Sep 27, 2024 at 09:49:00PM +0200, Peter Zijlstra wrote:
> > > @@ -893,7 +893,6 @@ static int create_cfi_sections(struct ob
> > >  
> > >  	sec = find_section_by_name(file->elf, ".cfi_sites");
> > >  	if (sec) {
> > > -		INIT_LIST_HEAD(&file->call_list);
> > 
> > Hm, why exactly are we re-initing the list head anyway in these
> > boilerplate create_*_sections() functions?  I'm guessing that backfired
> > here.  I can't figure out a reason why we'd doing that anyway.
> 
> Yeah, I can't remember where that came from, nor why I removed this
> particular one :/

I think you removed this one because file->call_list is also used by
create_direct_call_sections() so it's not wise to clear it if it was
already initalized and needed for another purpose.

> 
> > I'm also wondering why we made these boilerplate function names plural
> > "sections" when they only create a single section :-)
> 
> Because elf_create_section_pair() creates two section_s_, right?

Ah right.

-- 
Josh

