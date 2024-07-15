Return-Path: <linux-kernel+bounces-252602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB0A9315D7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25D0282589
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CF518D4DC;
	Mon, 15 Jul 2024 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KrZNjzK5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983811836D4;
	Mon, 15 Jul 2024 13:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721050366; cv=none; b=FrWvBz2W02ZsMLalq/V+S36DlB54LOedey28VA+KI2IlvSb9EqJrUgRM7NWDouxBBe7yIpVdECPm4fBsvoQgx8DonBjPeBUlZGIMJrJXO3oaDUpBuX/xDGGtCCi5Iqm8URtm2QJgGlnRBmgrhxIbMW27wokrPA/sUTkNrdWe+xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721050366; c=relaxed/simple;
	bh=1VQXo3PQ5bUOEU7LlOYBCGdHR6/CQC2eaEBkjR0wsG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwpGraOHRhl4Q39V9CO+PjfNl4mR76K1kH4v+PKR+ceNT+qNDbyEEHQtksb3nUsNnmD77RFUgIsK8mGM2u4CaFMJu6AcepKNFfXaN4J1doaL9XnVWyBK5S77S2KbG1wbmQpvvEggUBuL5wi76NAAmzbNI1wU2kBKsdsOtGvx1qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KrZNjzK5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BD2C4AF0A;
	Mon, 15 Jul 2024 13:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721050366;
	bh=1VQXo3PQ5bUOEU7LlOYBCGdHR6/CQC2eaEBkjR0wsG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KrZNjzK51rTtDoDFiImif0pGXpQ4jdnFE9ZsBtq2XyEkzAm2mgk5ffOEmJ+6xjaBF
	 64Fz5YaYTnW4qHWMgTc+R6rjAmHBilPRr+ChmGXlCXyLHGXUUHs1k/77XiXRJUGkaq
	 RAyDpAoHDsFDIXYnUjrUmV2KQ5VkbaAWrTWZ8EaY=
Date: Mon, 15 Jul 2024 15:32:43 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: make24@iscas.ac.cn, linuxppc-dev@lists.ozlabs.org,
	kernel-janitors@vger.kernel.org, stable@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Aleksandr Mishin <amishin@t-argos.ru>,
	Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
	Frederic Barrat <fbarrat@linux.ibm.com>,
	Ian Munsie <imunsie@au1.ibm.com>,
	Maxime Ripard <mripard@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Shuah Khan <shuah@kernel.org>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v4] cxl: Fix possible null pointer dereference in
 read_handle()
Message-ID: <2024071537-schematic-envoy-4272@gregkh>
References: <20240715025442.3229209-1-make24@iscas.ac.cn>
 <6c50de6d-7f35-4427-bd11-5f02f5e90c08@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c50de6d-7f35-4427-bd11-5f02f5e90c08@web.de>

On Mon, Jul 15, 2024 at 03:18:56PM +0200, Markus Elfring wrote:
> > In read_handle(), of_get_address() may return NULL if getting address and
> > size of the node failed. When of_read_number() uses prop to handle
> > conversions between different byte orders, it could lead to a null pointer
> > dereference. Add NULL check to fix potential issue.
> >
> > Found by static analysis.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 14baf4d9c739 ("cxl: Add guest-specific code")
> > Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> 
> How will interests evolve for caring more according to known research
> and development processes?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.10#n398
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/researcher-guidelines.rst?h=v6.10#n5
> 
> 
> > ---
> > Changes in v4:
> > - modified vulnerability description according to suggestions, making the
> > process of static analysis of vulnerabilities clearer. No active research
> > on developer behavior.
> …
> 
> Does such information indicate any communication difficulties?


Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

