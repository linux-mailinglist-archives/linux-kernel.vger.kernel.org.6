Return-Path: <linux-kernel+bounces-229214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DBB916CF7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E36B1F29EF2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D51016F8F4;
	Tue, 25 Jun 2024 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zPt753lM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91841CABB;
	Tue, 25 Jun 2024 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719329108; cv=none; b=rsTM19W4OjANcW3KFk+SWfpgB0o12jtbX1FzSXctF4bHOHi2HzDkw6Dv2d3Gp90JUf/zubh7RzOcepKuKunKBZEcm5690kJd/ut2vDFPkTwUy2E1Mdp6Qwe7C1k2YJlK3TbsxL/g0e0cCnnxwzkm2Wtns7TSd3pLrn1qQnCq5MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719329108; c=relaxed/simple;
	bh=9ATm6u9GQtzia4cO4CCanYRiBsUIMielL7YcNMryhKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+Tiklf7B8kOkE2ceKAvLjMmi+BMn1M961muM3XJifcwVI2s0wDyCkcGW8VJdiNgbkUsQTP3e1pCJU3V+RR8jpZRb6kiADslIGD0+2DWIQmGwIQuinmxiPG8EGh5P+Krlhfe/zx1iEqOollD4VtPnBKZ1dOJU5KQPgmS7G549lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zPt753lM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8CE1C32781;
	Tue, 25 Jun 2024 15:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719329108;
	bh=9ATm6u9GQtzia4cO4CCanYRiBsUIMielL7YcNMryhKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zPt753lMCbNHYxxzeC9in8PKtzKv63K3kC1fbF7B7j/HbszDzpL/5KT6NYeM7IVTC
	 lVLKj0IQrkeotWxumBO2TKd9FsxsD8Qehd+RLw+NMXtOi0JQCNshB5o63yYqGcEIpL
	 jpTRlc7Vkic5fSTLgrBoX+MXbjIiiBBb9sLGSPLU=
Date: Tue, 25 Jun 2024 17:25:05 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-aspeed@lists.ozlabs.org, linux-usb@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Ma Ke <make24@iscas.ac.cn>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>, Julia Lawall <julia.lawall@inria.fr>,
	Neal Liu <neal_liu@aspeedtech.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] usb: gadget: aspeed_udc: validate endpoint index for
 ast udc
Message-ID: <2024062553-koala-granddad-50f1@gregkh>
References: <20240625022306.2568122-1-make24@iscas.ac.cn>
 <edeaa699-7cfe-44ed-abde-7cf3d3efe3bf@web.de>
 <2024062556-ladder-canister-1ab1@gregkh>
 <ff2aaf0d-5456-43d1-af52-78986b3401f9@web.de>
 <2024062532-strep-president-44d7@gregkh>
 <5fa430f5-3e18-4c20-93d4-6733afd6bdcf@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fa430f5-3e18-4c20-93d4-6733afd6bdcf@web.de>

On Tue, Jun 25, 2024 at 05:20:07PM +0200, Markus Elfring wrote:
> >>>>> We should verify the bound of the array to assure that host
> >>>>> may not manipulate the index to point past endpoint array.
> >>>>
> >>>> Why did you not choose an imperative wording for your change description?
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.10-rc5#n94
> >>>
> >>> Markus, please stop reviewing USB patches.  This is not helpful at all,
> >>> and causes new developers extra work for no reason at all.
> >>
> >> How does this feedback fit to the linked information source?
> >
> > That is not what I wrote.
> 
> You indicated concerns according to patch review processes,
> didn't you?
> 
> See also:
> * Patch submission notes
>   https://elixir.bootlin.com/linux/v6.10-rc5/source/Documentation/process/maintainer-tip.rst#L100

This is not the tip tree.

> * Contributor Covenant Code of Conduct
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/code-of-conduct.rst?h=v6.10-rc5#n3

I do not see how this is relevant here.

> > I wrote, "Please stop reviewing USB patches."
> >
> > Please stop now.
> 
> I might be going to influence evolution of this software area in other ways
> under other circumstances.

Please take some time and find other projects to help out.

greg k-h

