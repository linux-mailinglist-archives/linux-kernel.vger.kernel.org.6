Return-Path: <linux-kernel+bounces-355613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0846F9954C4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FF52B29B31
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960861E0DF4;
	Tue,  8 Oct 2024 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xw30QfLm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0BF1DFE11
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 16:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728405919; cv=none; b=iQ92f8U9KcwAs0tdDVhV0bSp9Su8ONAcz7g6sRNzBsb1jKKP4fry+4ya0rlc43t0p4xsJNdtZKMSNzT8IFG8uV+nWkm5saornyUbKVBeLeUWq3X1gwzTZR5gIoAlnt3Rbx1F+dbBcn6Nc382gLtn0n7doIwTSmp1LTYjs5s5DsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728405919; c=relaxed/simple;
	bh=To+T5IiE9dvjOKbmAyeykmdRdYg0KfglgGfocxbJc7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ej3fauewKVqm2FQi7RiJPHtJjsq/OeHjANzB/HcrJ1V2aqoWsbzwaW0CtlmeSeQEHtMAbxk+l3mf+1JwTpnH66Z6SCbBb6OWWeEjW1EPubuudBRbui56t2+hpiWNPiaHYnq6haSJZZwf7ukAgPzrBTbPdD5yb2k95xT0dkvHTI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xw30QfLm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE0CC4CECE;
	Tue,  8 Oct 2024 16:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728405916;
	bh=To+T5IiE9dvjOKbmAyeykmdRdYg0KfglgGfocxbJc7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xw30QfLmZG3CnIJB8JDzCwRMKWVm3w0LTksmnwTJ3+aGIUKyp7Ab5JP0eKh16R41t
	 6SSbhmsfBycUpnHRMqsuIpXR3tkhiOfNBelEKtILYwdR+HvTWSQ5a2tlUUADvhQ6Ow
	 0qLyFGIC7ssY8Ql/Kw3qiX4JbatwPeCBHTFdns7n5K/FkLm3lItRHVUS++ecRYYamz
	 EwUQP3YT3pOHm05DOhA2aIvRLS57hYqUKbXGtmHOkFpbhRIsPLox9m5BjUbKVa1VSc
	 l467bfSipmGy09Pg/7C5qEzcXyNnWKB1wGZ39tPuShqT+YRPJG4r+xjbQAc7quCKy0
	 ZkNHCVkLeL3MA==
Date: Tue, 8 Oct 2024 09:45:14 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: bp@alien8.de, david.kaplan@amd.com, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [RFC][PATCH 2/2] x86: Clean up default rethunk warning
Message-ID: <20241008164514.ky7ybaoitytvbwlp@treble>
References: <20241007083210.043925135@infradead.org>
 <20241007083844.119369498@infradead.org>
 <20241007173345.yokak3mlnqpsuxty@treble>
 <20241008072502.GC14587@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241008072502.GC14587@noisy.programming.kicks-ass.net>

On Tue, Oct 08, 2024 at 09:25:02AM +0200, Peter Zijlstra wrote:
> On Mon, Oct 07, 2024 at 10:33:45AM -0700, Josh Poimboeuf wrote:
> > On Mon, Oct 07, 2024 at 10:32:12AM +0200, Peter Zijlstra wrote:
> > > Replace the funny __warn_thunk thing with a more regular
> > > WARN_ON_ONCE(), and simplify the ifdeffery.
> > > 
> > > Notably this avoids RET from having recursive RETs (once from the
> > > thunk and once from the C function) -- recursive RET makes my head
> > > hurt for no good reason.
> > 
> > This could use an explanation for why the ifdefs can be removed and why
> > the alternative can be removed.
> 
> The alternative is in the WARN_ONCE now.

Ah, sneaky... It should really be called WARN_ONCE_AFTER_ALTERNATIVES or
something.

-- 
Josh

