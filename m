Return-Path: <linux-kernel+bounces-228858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2B49167D9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A7C6286F57
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEB3155336;
	Tue, 25 Jun 2024 12:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XWw8bD6G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD9D1487C8;
	Tue, 25 Jun 2024 12:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318595; cv=none; b=lC9UkUYwnVCwwdfEKwq0ES3yihyMN2nHOcCbFmAQ+MvD5IRaM2H9z7+Neg8nXZQHhXQWgOIdKB4qNo+ZClkv6u+e/a13RW3KNPah+o6KIogCgePtwBYA7lr7rBiieUDuxES0DtATHRaY2na/sLwECMA02EVQStbFad03dxcGNIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318595; c=relaxed/simple;
	bh=IA6jC8XTItCVnYkwZOTQ5t8CtJcSSO5iYQC//SFjUCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agwpr/HOGom5Txx+oWqlePKwrn2Ly8+QzZrWLP9Vd6fjDn/QpQyfjsWfj1deiCItlekH6TXofI6lBProbn2zSJOuFBfBOqMZw/DnPN9em4PA7XWfVCwDJrzIzK9GuHNpxo+EfZFiDhmfl4SnopJ6DHNIKIpzJBH1wZKnbzuQJF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XWw8bD6G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F157BC32781;
	Tue, 25 Jun 2024 12:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719318595;
	bh=IA6jC8XTItCVnYkwZOTQ5t8CtJcSSO5iYQC//SFjUCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XWw8bD6G9VvIqpoQ5PeHaZVwh5pvOLzT+Xx+vPOZYL0NDfgfX6E/gACdNZYvDni6H
	 /DSRtmt6r5gyodtdQ0DBoxgihdXisNS7NtLRYZI2FgMrbAKOMTbEHuUVSZoY3Yuv/W
	 fzJskr3corZdMowUMwpmuaFJDXHRmkVIhQu1FX7w=
Date: Tue, 25 Jun 2024 14:29:52 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Ma Ke <make24@iscas.ac.cn>, linux-aspeed@lists.ozlabs.org,
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>, Neal Liu <neal_liu@aspeedtech.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] usb: gadget: aspeed_udc: validate endpoint index for
 ast udc
Message-ID: <2024062541-disdain-essay-7434@gregkh>
References: <20240625022306.2568122-1-make24@iscas.ac.cn>
 <edeaa699-7cfe-44ed-abde-7cf3d3efe3bf@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <edeaa699-7cfe-44ed-abde-7cf3d3efe3bf@web.de>

On Tue, Jun 25, 2024 at 02:00:15PM +0200, Markus Elfring wrote:
> > We should verify the bound of the array to assure that host
> > may not manipulate the index to point past endpoint array.
> 
> Why did you not choose an imperative wording for your change description?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.10-rc5#n94
> 
> 
> > Found by static analysis.
> 
> Were any special tools involved?
> 
> 
> How do you think about to add any tags (like “Fixes” and “Cc”) accordingly?


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

