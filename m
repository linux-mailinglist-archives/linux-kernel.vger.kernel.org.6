Return-Path: <linux-kernel+bounces-228859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6918C9167DE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98AAB1C251AD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94D41552EE;
	Tue, 25 Jun 2024 12:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cOl+tL7k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EBD3F9CC;
	Tue, 25 Jun 2024 12:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318658; cv=none; b=YK831Tz7HSn9kyeDWMirnMmdoCgMbsKXOxzuJXBlY1vxv7Ibh3n0gm2aM6uF7hgR4ocKEq4IaPeCm6FHxIvdbnZniiJvIbFnu4g4gh2n7nwebIE4XNUKU1MHzUw6I+DmwrpHGO1i3ZY/irkjnkcCNR31kboIZi7ao1te4qP9wTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318658; c=relaxed/simple;
	bh=7ZnF264um0Yqg5hHDTg1nc/wQWc+Bl1oj8XVxnLnpOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bd7AqRSuuMxIokwJwXOtjKXaO7cKkrWHuuS9fR1P7GwwljC2qdW0QIN3ViM5pxNeAWmq3KC16zsa+xa2YpNBW/y2iMX8HMXbiHjGv2soyHArjXKTMUce6GgxlXKUGnBNo3i5ITEyIeUqZQSjbz3G8s975lyX/c49zVFGvePSnpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cOl+tL7k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43ED2C32786;
	Tue, 25 Jun 2024 12:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719318657;
	bh=7ZnF264um0Yqg5hHDTg1nc/wQWc+Bl1oj8XVxnLnpOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cOl+tL7k+e8oLbUP1ARC0d6J0DStfdhpYKH+90kTUAiSlHDBGZCqpn3MAB181VN/X
	 TafwHnPlLZnHqv2Y61YDuT1lc5k7SZfeHDJnlOYIrpanS/sHW3h7irPjWnKiSTayjU
	 de/K91gruCLlE4VpMAopvoU9YWes0yizxw9CzXBE=
Date: Tue, 25 Jun 2024 14:30:54 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Ma Ke <make24@iscas.ac.cn>, linux-aspeed@lists.ozlabs.org,
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>, Neal Liu <neal_liu@aspeedtech.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] usb: gadget: aspeed_udc: validate endpoint index for
 ast udc
Message-ID: <2024062556-ladder-canister-1ab1@gregkh>
References: <20240625022306.2568122-1-make24@iscas.ac.cn>
 <edeaa699-7cfe-44ed-abde-7cf3d3efe3bf@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edeaa699-7cfe-44ed-abde-7cf3d3efe3bf@web.de>

On Tue, Jun 25, 2024 at 02:00:15PM +0200, Markus Elfring wrote:
> > We should verify the bound of the array to assure that host
> > may not manipulate the index to point past endpoint array.
> 
> Why did you not choose an imperative wording for your change description?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.10-rc5#n94

Markus, please stop reviewing USB patches.  This is not helpful at all,
and causes new developers extra work for no reason at all.

You have been warned many times about this, and many people have talked
to you about this.  If you continue, you will have to be banned the
mailing lists, again.

greg k-h

