Return-Path: <linux-kernel+bounces-344937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C5698B014
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 00:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B171F21D0D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD86E188929;
	Mon, 30 Sep 2024 22:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqPBsMSl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267AE21373
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 22:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727735931; cv=none; b=iYovhGN1bnJVAEXwLYeULP3pvfODMIQVxtfViktXG8GykYCa8Rc6aF74bPhc9dmvcpCkWJuxYxiS6zOlhAlbAM++sY/1N4xntxJx5OBCXc5QPJZB1DAQSXw6uZkHPNx8pGin1uHrP7D9Y/DNCo8TsaZmouLO0OfOytS6uvJMO7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727735931; c=relaxed/simple;
	bh=WNT9003AkFv8E8wTS9wKNscfgRo4eUoUEcioZYXRmRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7B72NC5EuCqxAkmZeEqdc3fs1gtQufiy9fkBJIIKpoAW0eAjQuaiHvB4KiH5YfoNUmcGnQvggEhq+kosm6UUT255nUHb8vpKNnfWgJvsdWW9/S5MsWzXqCi1SeDPgiJrChmaKHMMHXK1gGzNY4PXQO/WGwWA3B/2y1z/eT8r64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqPBsMSl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74554C4CEC7;
	Mon, 30 Sep 2024 22:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727735931;
	bh=WNT9003AkFv8E8wTS9wKNscfgRo4eUoUEcioZYXRmRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oqPBsMSlVeW5QOwgjU40tVxF47qq7TTtaA8vx3/7gOKA//xgpJ/A9gUyIeUSs4GN2
	 1aFAmTkojkCc2yrYgquGRdvoskArLpI14IGSexYZdBsiq5J74bjDGCwITVu8uZqkOU
	 1SDgHl1V7eeNpWbIp0alXnAsCQDN1ltPxV2GEu7ygsVudOd/Y9eX8jbYsK4BUi2SNB
	 iA9mRXL365zwFjteDF21rw428fHTD8uNgZlc1P/oA76i7/Jr9xHquoLRV1VAQoChFt
	 lw8JgqUaLc4YyeZtKQk5ITMq2TQHjjY4yE082IJVgsKno9t1rSjW2twbxNb2X67amY
	 TG6JULH3xhVrA==
Date: Mon, 30 Sep 2024 15:38:48 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, samitolvanen@google.com, nathan@kernel.org,
	ojeda@kernel.org, kees@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH 13/14] x86: BHI stubs
Message-ID: <20240930223848.ulipiky3uw52ej56@treble>
References: <20240927194856.096003183@infradead.org>
 <20240927194925.707462984@infradead.org>
 <20240930213030.ixbsyzziy6frh62f@treble>
 <54d392d3-32b3-4832-89e1-d2ada1af22a8@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <54d392d3-32b3-4832-89e1-d2ada1af22a8@citrix.com>

On Mon, Sep 30, 2024 at 11:23:38PM +0100, Andrew Cooper wrote:
> On 30/09/2024 10:30 pm, Josh Poimboeuf wrote:
> > On Fri, Sep 27, 2024 at 09:49:09PM +0200, Peter Zijlstra wrote:
> >> +SYM_INNER_LABEL(__bhi_args_0, SYM_L_LOCAL)
> >> +	UNWIND_HINT_FUNC
> >> +	cmovne %r10, %rdi
> > IIUC, this works because if the "jz" in the CFI preamble mispredicts to
> > the __bhi_args_* code, "cmovne" will zero out the speculative value of
> > rdi.
> >
> > Why use %r10 instead of a literal $0?  Also how do you know %r10 is 0?
> 
> There's no encoding for CMOVcc which takes an $imm.

Ah.

> %r10 is guaranteed zero after the FineIBT prologue

If the "jz" in the FineIBT prologue mispredicts, isn't %r10 non-zero by
definition?

> , but I don't see
> anything in patch 11 which makes this true in the !FineIBT case.

I thought this code is only used by FineIBT?

-- 
Josh

