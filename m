Return-Path: <linux-kernel+bounces-415386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF179D3553
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5D5C1F22E9F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855F0176228;
	Wed, 20 Nov 2024 08:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/hHPaim"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E634214F9F8
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 08:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732091158; cv=none; b=Q3fIyzyeAJOubdIuaFLqfN7SPS/XQvH3W2+yeIasvuPWY9B6frDI17HTnyLGO73CJzk1JLx1FJWpzFuzSDUn2ikQJWx6gblsvf4nHq8UKrlKuGFSd7SnU+a3VqtFddPHVRiz/iXAkoh7YgjXODmgRdzZYIaz5KU6Jbf3CglMlXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732091158; c=relaxed/simple;
	bh=4Ab81/oZ3tg0L1aPfgX8QvkKm7XHs4TUULMGxDOY9Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPVrTQJsgb4wmloQi7iZClGRjxQbZIjYXNVwl1JYSxy4f8OXnWrJAy2oqyHbFENeZzLpJg+dxWuOECUBGsDjijL+/GDs3Sb2Ah0uQU6MbfiVIcXM1Q9/5ZWCxWeeItOq7/WOck//e8didWNwhkKNBSzK3avBpH7Bo9c7KXLsqs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/hHPaim; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F774C4CED0;
	Wed, 20 Nov 2024 08:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732091157;
	bh=4Ab81/oZ3tg0L1aPfgX8QvkKm7XHs4TUULMGxDOY9Y4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M/hHPaimECvHctCWZOe0zxE2QGMqDZr4gy4+6JZLf8O0vnODPo/mWVa9EnsuqH91k
	 cCorBjU9wt1Eo1uraS81N9xl+UzoIOvpZ0+0lQkUkjT3zMr7k2gSsqdFzUSRDh8JaH
	 GHCGK4XcqErt+NJsrIKFU6UXldo2h4O5lTMmNYqKl9wYphPnsMg/76zbsEi+fpvWxA
	 4b4DcuHwCX7Y6n790dZ5MR0BH3z1Nf27JPQlM9eaxLFHbH8YzFSxTfxvvNMEYQh6Mf
	 255NS6yp3PfSQuW9dTpjksDNxrmeWEB1jYCpeYZI7itbglsJFcTj/wdo80s7TrDr3+
	 M3+ifZBOL4Spg==
Date: Wed, 20 Nov 2024 09:25:53 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org, bp@alien8.de,
	x86@kernel.org
Subject: Re: [PATCH v2 1/2] x86/ioremap: introduce helper to implement
 xxx_is_setup_data()
Message-ID: <Zz2dEcLrCtXEq4cg@gmail.com>
References: <20241118010819.46602-1-bhe@redhat.com>
 <20241118010819.46602-2-bhe@redhat.com>
 <7cc5e26c-42fc-a700-ae19-608920cafe44@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cc5e26c-42fc-a700-ae19-608920cafe44@amd.com>


* Tom Lendacky <thomas.lendacky@amd.com> wrote:

> >  /*
> >   * Examine the physical address to determine if it is boot data by checking
> >   * it against the boot params setup_data chain.
> >   */
> > -static bool memremap_is_setup_data(resource_size_t phys_addr,
> > -				   unsigned long size)
> > +static bool __ref __memremap_is_setup_data(resource_size_t phys_addr,
> 
> Oh, I see why the __ref is needed now, because this calls an __init
> function based on the early bool.
> 
> While this nicely consolidates the checking, I'll let the x86
> maintainers decide whether they like that an __init function is calling
> a non __init function.

So why would it be a problem? Only non-__init calling __init is a bug, 
because __init functions cease to exist after early bootup. Also, 
calling certain kernel subsystems too early, before they are 
initialized, is a bug as well.

But calling non-__init functions that have initialized already is like 
totally normal: printk() for example, but also all locking facilities, 
etc.

Am I missing anything here?

Thanks,

	Ingo

