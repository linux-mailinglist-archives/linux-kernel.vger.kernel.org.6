Return-Path: <linux-kernel+bounces-218334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3ADE90BCBE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 23:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4D371C237AE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 21:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBBF190042;
	Mon, 17 Jun 2024 21:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gv6LwSZ1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9879C14F128;
	Mon, 17 Jun 2024 21:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718659070; cv=none; b=HUTIazBxU4n65W9VKZtAcGvKLvGsvqdI/B+fJPr1ohLZVLadqCFfM2dRYXnA25LlgLdmOYZKqbyk2csHiapDw/y3xj5i+0GiyUJ94jp9no7NtUDZaVRt5eq1xinqra94OBbLrlqXgfJuTJ3n31OIsjL/3gXKP6Y5VAhxJj+OzbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718659070; c=relaxed/simple;
	bh=GqQujzE9bih3T6lKmLMtyfVkLhbQUTxfWHOIK2hGXXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZSQd5TuOc6+nDOOsOQzK7C8DlPEGc5xxkn+cXBrjFzuvFttGThDstOwqtKUB+ooD1hAWw5P93Fv9B02KhnN+QMkwKeF5VLDNsbhEeAxFl/Olvbaqs8BxiUygcrSyJyn34ms1BXzpUaK2jtHg2O7oBP1CNi/e+BnhNsh3sOUcBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gv6LwSZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A23C4AF1C;
	Mon, 17 Jun 2024 21:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718659070;
	bh=GqQujzE9bih3T6lKmLMtyfVkLhbQUTxfWHOIK2hGXXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gv6LwSZ1TtuqamOoBQUnOEw8kQv/U0JS2I9n1IQm4uYh5u82LVBFgFWBCaPfMXgl2
	 k7KJnIF4at6GriS/IcmQ1xN/ya2TLpbaEtFn9yYxJZNRrWWqKVAUIZYiy0HR3TEw3h
	 1+bpp4Htkoy4n906lx2sKOrcDg3iUntS1My9uW3nV6CzYCdeJ4QvaLXq0jq7oYpHUH
	 6fArEnj/zH2itBIhDfoDmoPzJwZ4N1nSfr3wYIAaVuzxdyMGxZFe7imDbIRcLpMD6S
	 EJKu3Pd94a6QqFqNH0peMYtS22eNrUmVotEEXPcQB2vsijMnfzglMVyq/7qLFaflLY
	 dOziBhvkB2TQg==
Date: Mon, 17 Jun 2024 14:17:49 -0700
From: Kees Cook <kees@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Gabriel Krisman Bertazi <krisman@suse.de>,
	linux-cve-announce@vger.kernel.org, cve@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52685: pstore: ram_core: fix possible overflow in
 persistent_ram_init_ecc()
Message-ID: <202406171413.DE595AF@keescook>
References: <2024051752-CVE-2023-52685-64c5@gregkh>
 <87jzjeojwp.fsf@mailhost.krisman.be>
 <2024052811-cornfield-monday-8bb9@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024052811-cornfield-monday-8bb9@gregkh>

On Tue, May 28, 2024 at 09:01:13PM +0200, Greg Kroah-Hartman wrote:
> On Mon, May 27, 2024 at 08:32:54PM -0400, Gabriel Krisman Bertazi wrote:
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> > 
> > > Description
> > > ===========
> > >
> > > In the Linux kernel, the following vulnerability has been resolved:
> > >
> > > pstore: ram_core: fix possible overflow in persistent_ram_init_ecc()
> > >
> > > In persistent_ram_init_ecc(), on 64-bit arches DIV_ROUND_UP() will return
> > > 64-bit value since persistent_ram_zone::buffer_size has type size_t which
> > > is derived from the 64-bit *unsigned long*, while the ecc_blocks variable
> > > this value gets assigned to has (always 32-bit) *int* type.  Even if that
> > > value fits into *int* type, an overflow is still possible when calculating
> > > the size_t typed ecc_total variable further below since there's no cast to
> > > any 64-bit type before multiplication.  Declaring the ecc_blocks variable
> > > as *size_t* should fix this mess...
> > >
> > > Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> > > analysis tool.
> > 
> > Hi Greg,
> > 
> > [Cc'ing Kees, who is listed as the pstore maintainer]
> > 
> > I want to dispute this CVE.  The overflow is in the module
> > initialization path, and can only happen at boot time or if the module
> > is loaded with specific parameters or due to specific acpi/device tree
> > data.  Either way, it would require root privileges to trigger.
> 
> Normally root privileges isn't the issue, as many containers allow root
> to do things (including loading modules, crazy systems...)
> 
> Anyway, I'll defer to Kees as to if this should be revoked or not.

It's a module parameter or device tree value that is at most INT_MAX or
UINT_MAX respectively. Also, it is bounds checked against the buffer
itself:
        if (ecc_total >= prz->buffer_size) {

So even if it wrapped around and got "too small", there's no damage to
be had here.

The worst case is that the ramoops info goes missing because pstore
refuses to do anything with the bad value, but pstore can be disabled
way more easily than that, by design.

So, no, I don't think this is CVE worthy. I took the patch because it's
reasonable to try to get the math right and provide better error
reporting.

-- 
Kees Cook

