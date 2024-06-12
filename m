Return-Path: <linux-kernel+bounces-211099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0505904D1B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BFAC1F25360
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E03B16C862;
	Wed, 12 Jun 2024 07:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="diUUyued"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5693F16C843;
	Wed, 12 Jun 2024 07:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718178470; cv=none; b=Z6NKYe3YEK16IkqVJ/nD3GTRXU6skgFqY320DUWDojx6zC6gnxuqSjenUGF+MQwT23qbGzoKfrYZgKiMO4tOzv2jJzOlwta19tvN9LOvC35ZQnbw898cyCO10FVySSFoyntBVQKTzRh2rxp/5mtSOqhRKMJZCnHSnOHNxDMSFqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718178470; c=relaxed/simple;
	bh=hNFkGSStIb3CHNnbUhBTgO8w9EfwVT9h1J+//nvOGiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cP7ykM2aieWlzBrpF8CcD6elqZgOTtVEL7lIGxCT2YyV+BP/tI0H+zkn5ZUtH6MYtl3G0ieq0QlOhxWwc1geoLI80n96s/vdNa9AN0/xL2ZOYyebNHe6yYHQqQQB8lzBGf048sNo8E9LcZ1Dby1onNDOHDjxbF7ieTs6FuhKjp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=diUUyued; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DE0C4AF48;
	Wed, 12 Jun 2024 07:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718178469;
	bh=hNFkGSStIb3CHNnbUhBTgO8w9EfwVT9h1J+//nvOGiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=diUUyuedTzO5Pp/4Yv6PtkimbV1ZJBP6fO7P+lR2HW6/2x68eXUcRvJx+AsnFMNXb
	 JPgBl3JMs27SK1RMT26l+ZCdeHBiC/WdZFoCpojveIUQ8HS0Ugv0DEyS43hZ7Bg1j3
	 Z29CzYPtvzzRSlLslpyV+5IBXAhODLkHKSJYivcQ=
Date: Wed, 12 Jun 2024 09:47:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhai He <zhai.he@nxp.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"sboyd@kernel.org" <sboyd@kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Zhipeng Wang <zhipeng.wang_1@nxp.com>,
	Jindong Yue <jindong.yue@nxp.com>
Subject: Re: [EXT] Re: [PATCH] Supports to use the default CMA when the
 device-specified CMA memory is not enough.
Message-ID: <2024061215-strum-quarry-c574@gregkh>
References: <20240612023831.810332-1-zhai.he@nxp.com>
 <2024061228-unburned-dander-c9a2@gregkh>
 <AS1PR04MB955995BF689849177D95DE28EAC02@AS1PR04MB9559.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS1PR04MB955995BF689849177D95DE28EAC02@AS1PR04MB9559.eurprd04.prod.outlook.com>

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Wed, Jun 12, 2024 at 07:34:56AM +0000, Zhai He wrote:
> Thanks Greg for your review.
> The reason I changed the error level is because these logs will be printed
> when memory allocation from the specified device CMA fails, but if the
> allocation fails, it will be allocated from the default cma area. It can
> easily mislead developers' judgment, so I changed it to debug level.

Then you need to explain this in the changelog text :(

thanks,

greg k-h

