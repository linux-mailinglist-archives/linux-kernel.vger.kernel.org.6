Return-Path: <linux-kernel+bounces-175819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F5E8C25A1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 15:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A25E9B240D5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A0D12BF39;
	Fri, 10 May 2024 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wPuIxG+C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9427E127E0D;
	Fri, 10 May 2024 13:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715347552; cv=none; b=M1V2poItw52aAgrW4/yXusBru7X/kDDj1BXhpZdbxp3Zh/VQX+3Lsg8ZU5ygmoV7FAyZmnAbRx8g6MPh91zPjZWIGoMajYoY/d0iRUz+nmbTWpJCWbo+fL59sMBYbfzv2zpt7RuelJe2U4m2qSfNbaqqRTvbYWiB3jg13yEofv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715347552; c=relaxed/simple;
	bh=Y8yNq2xxYFXKYdgmE9D8bXj8aKByPKiEKFQscg4dWEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZEItgNtb3qeLZ4kJXem9LqCofu54ljna2Vuikb9zkS2erG0GanloDKm9X9aDgCD1cLmAypUk5372NkKzv9sLMYeSFGO1P9+mYtwckBXNpzk8Z99GQaMuwpyiXLGDOUfJq+sryaRCOk8AkPnvS0na98jOVWu33ozN/lLrMQB6cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wPuIxG+C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D04C113CC;
	Fri, 10 May 2024 13:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715347552;
	bh=Y8yNq2xxYFXKYdgmE9D8bXj8aKByPKiEKFQscg4dWEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wPuIxG+CHAZFKLTBwbwQmJKf4aPFgBSw/s5EFuXz7wPsjOX7IB8KHerSd5jOYTUZa
	 nMhwu81mn9YL3ZJ89sNx3tjocEQRH0BqL4GuXa9KeC3dJ8xdM9mCyRuASFQvuUwM4n
	 /Dyw3UczC7pfpZqLid6k4Aseu9Qquy6Y4tMrYvys=
Date: Fri, 10 May 2024 14:25:49 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: "cve@kernel.org" <cve@kernel.org>,
	"linux-cve-announce@vger.kernel.org" <linux-cve-announce@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: CVE-2024-26898: aoe: fix the potential use-after-free problem in
 aoecmd_cfg_pkts
Message-ID: <2024051019-value-catsup-cc96@gregkh>
References: <2024041744-CVE-2024-26898-d199@gregkh>
 <8237dfa9a5f408a76ccf0c5767104383ba55f347.camel@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8237dfa9a5f408a76ccf0c5767104383ba55f347.camel@oracle.com>

On Fri, May 10, 2024 at 01:12:50PM +0000, Siddh Raman Pant wrote:
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > aoe: fix the potential use-after-free problem in aoecmd_cfg_pkts
> > 
> > This patch is against CVE-2023-6270. The description of cve is:
> > 
> > [...]
> > 
> > The Linux kernel CVE team has assigned CVE-2024-26898 to this issue.
> 
> Isn't the new CVE a duplicate?

Given the lack of information in that older CVE, no, I do not think so
as there is no real information provided there at all.

thanks,

greg k-h

