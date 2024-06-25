Return-Path: <linux-kernel+bounces-229072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F095916A74
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0076284DB0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBDF17335E;
	Tue, 25 Jun 2024 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RvDVfhnW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A90172BB5;
	Tue, 25 Jun 2024 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719325827; cv=none; b=sIpSF1aEICaGnIfOPc7lhufb1JqeJqgd2rae6UreIBhc95UxKFCuxx0g+AXeMlIcd2qBGXPzD8qDtyZAkxkvUlXkI55sm6D4QktHrn67/icJIxlxs89VHaCTnwKyNkWXtVxtk194alDRi3+mD3AisG9SOjgyd/RB/7svbeKCe5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719325827; c=relaxed/simple;
	bh=9tO7IZgG2Eakun8AumgjuwsmLm6VCVkaQQyUnGM/LJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNYkJn3GspAd8KhUm4HVHpfVbs/IR/OJf1hfhKOiixMdcKzF7IAPv4rzTsuIpuj/rsMwsFgh5ri2lpKKp2ANA3N97jH7GdAOpg4/+TZCrzQqK6T0kBU3mR8/QyLVyzuZyH0krGzQiGSmQ8IxYoGTkHLMfPKK7PygM4kLPXYrrBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RvDVfhnW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4841CC32781;
	Tue, 25 Jun 2024 14:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719325826;
	bh=9tO7IZgG2Eakun8AumgjuwsmLm6VCVkaQQyUnGM/LJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RvDVfhnWZ4+6R35mtCpawhGntF5GxG/7AHndEhYp8YGC6IT/2L2zZBo2SIJ03GO06
	 HviWdrFveIUNGho+BX6Qi57vp1d//KzwQmS6K8aR1LSGeQ+Dba08EUI78j0nOnqraa
	 5lIf0l518d+SPZaBXGMlOtANAebIjjezbFyr+Xl0=
Date: Tue, 25 Jun 2024 16:30:24 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-aspeed@lists.ozlabs.org, linux-usb@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Ma Ke <make24@iscas.ac.cn>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>, Lee Jones <lee@kernel.org>,
	Julia Lawall <julia.lawall@inria.fr>,
	Neal Liu <neal_liu@aspeedtech.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] usb: gadget: aspeed_udc: validate endpoint index for
 ast udc
Message-ID: <2024062532-strep-president-44d7@gregkh>
References: <20240625022306.2568122-1-make24@iscas.ac.cn>
 <edeaa699-7cfe-44ed-abde-7cf3d3efe3bf@web.de>
 <2024062556-ladder-canister-1ab1@gregkh>
 <ff2aaf0d-5456-43d1-af52-78986b3401f9@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff2aaf0d-5456-43d1-af52-78986b3401f9@web.de>

On Tue, Jun 25, 2024 at 02:50:25PM +0200, Markus Elfring wrote:
> >>> We should verify the bound of the array to assure that host
> >>> may not manipulate the index to point past endpoint array.
> >>
> >> Why did you not choose an imperative wording for your change description?
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.10-rc5#n94
> >
> > Markus, please stop reviewing USB patches.  This is not helpful at all,
> > and causes new developers extra work for no reason at all.
> 
> How does this feedback fit to the linked information source?

That is not what I wrote.

I wrote, "Please stop reviewing USB patches."

Please stop now.

greg k-h

