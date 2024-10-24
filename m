Return-Path: <linux-kernel+bounces-380243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B89ED9AEAE8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7465C283913
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FF51F5825;
	Thu, 24 Oct 2024 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bM03Xwxe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE951D5176
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 15:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729784576; cv=none; b=iJQbmpaHL/21g/CXMD4SeHq7kc3WvYE4qcZUvtcxTtaJjLJzgE1IjFFR2APfO0A7OTMO/ip2xtVMkkih9Na7pIOhH/TfrDPeIN0Xz0+LPNU6j8Cy5QPaKuV7I4FU2+lPRdxo3LXUcX0Kfg0vWj7qY3LnAOaACKIe5s8/xCKQRAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729784576; c=relaxed/simple;
	bh=kT+XekTU6hfLD2TR2cbS028Ueo4jAYU56FaiEmgBnMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2E3+lx8dCjsU1gpuCJWmm2f1KoykrE2oUd/YScxcXvOkfmCXnrlyWUuXFYMATKc707/jozfqEAMCaoOAVDthUKP+FRj0H5sv/1rmeesNjAt9i4oCEoSvB7c0ly/9Edqj9NG5u9Uet5+EyIdUYXcVuY/vi8yfoD5Y7PlV5YhVfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bM03Xwxe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D58C4CEC7;
	Thu, 24 Oct 2024 15:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729784575;
	bh=kT+XekTU6hfLD2TR2cbS028Ueo4jAYU56FaiEmgBnMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bM03XwxeNYhbtkoNSnlty9VpXCvUqz8VTvyrPqkoow3ZvDu2yGgezxA1ZY+eg8kes
	 QKolSe+eADgX6WeTIG2DIqzOQWvkkf6EJm2yqsERVJU6nI9rB7/0QmR65qo3m9z54z
	 quTEPxNErGCZs/oDGKXyac5rp3pS71WWj1Vjb/tgf9xe/Ghz+AUBtQMsEcUqbu/hrS
	 1Ycs+P6lDKfjU1+1UXXFk7vat0XWJVl5a1zY0bmak0JEQ9IXC/QpD1fzMc/Z1EJ9NM
	 +iU2k6XvvO1h/cAp32CBcDRlY/CzoWWU4mTSTxDRSEiPsKk6gub4HyY4j6Tmz5kf/Z
	 VlEeG3Xhrb+FA==
Date: Thu, 24 Oct 2024 08:42:54 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
	Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86: fix user address masking non-canonical speculation
 issue
Message-ID: <20241024154254.c2ylwy3b7kilvoir@treble.attlocal.net>
References: <20241024013214.129639-1-torvalds@linux-foundation.org>
 <20241024061300.l5y4ng5gmkfrfdht@treble.attlocal.net>
 <xonbgoepadskqagkprwpcse33sgl3yebo52liuskde2eiozcza@njkktzlcar6g>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xonbgoepadskqagkprwpcse33sgl3yebo52liuskde2eiozcza@njkktzlcar6g>

On Thu, Oct 24, 2024 at 05:02:42PM +0300, Kirill A. Shutemov wrote:
> On Wed, Oct 23, 2024 at 11:13:00PM -0700, Josh Poimboeuf wrote:
> > On Wed, Oct 23, 2024 at 06:31:59PM -0700, Linus Torvalds wrote:
> > > @@ -2389,6 +2390,15 @@ void __init arch_cpu_finalize_init(void)
> > > +		/*
> > > +		 * Enable this when LAM is gated on LASS support
> > > +		if (cpu_feature_enabled(X86_FEATURE_LAM))
> > > +			USER_PTR_MAX = (1ul << 63) - PAGE_SIZE;
> > > +		 */
> > 
> > I'm probably missing something but once LAM is enabled, how wouldn't
> > this allow non-canonical address speculation?  i.e. when bit 47/56 is
> > set and 63 is cleared, would it not go untouched by mask_user_address()
> > and thus be speculatively interpreted by AMD as a kernel address?
> 
> CPU with LAM enabled enforces bit 63 to be equal bit 47/56 and raises #GP
> otherwise.

Right, but I'm asking about the speculation bug which happens before the
exception (and which prompted this patch in the first place).

-- 
Josh

