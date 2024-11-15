Return-Path: <linux-kernel+bounces-410105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C6A9C968C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 01:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58EEAB23818
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 00:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4BFCA5B;
	Fri, 15 Nov 2024 00:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="rMdP5LDl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD81A8460
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 00:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731629217; cv=none; b=Zq4qwJZ9tt5czvEXm3t4CsYTxsDBuJHnXcCjubqb2yGV/MEpXhX433zBSUSRqTxNRbRyD2U6MUYSzAZaGyykw71I6hqCIqbTkyESPj2aZ+IPdfFNhsFVIOAyi3B3msym0aM6hyqnS0tGakBHlIZ3bUVkMiUPiJEIapa0KECXrmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731629217; c=relaxed/simple;
	bh=ON0e3OmoA65GBl7OIilW+jYg7J6IAjTzN93UvxaDyiU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Bn3fk7gWNNf6t1xXnbKYNAqBqIiJKWLf/GfT308X++ZmsLPuw4uulfMoBHCFQI9XDMN4LhOmc+19bH0C6WFSG6EJOGRWnLHGCfcnh1wpSRkJ9oeq/w0OQvG+LNTPr2wKHbUlgASWgI5ezD19i7UI75BehaJEc+/uFe9eXttq3Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=rMdP5LDl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8912EC4CECD;
	Fri, 15 Nov 2024 00:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1731629217;
	bh=ON0e3OmoA65GBl7OIilW+jYg7J6IAjTzN93UvxaDyiU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rMdP5LDlJvwK6NaU5eNZHIbF6f6vpIiuCeVlMn7RloLnXpy6cAhvfWeR7TRYc6NKS
	 aRXIphMhrVfrnpCG4l366hWnaoneGVdEOfmjLdr47xo+nFkdXR4o/n49tkcjErJ3Ab
	 SGvdJwP/4BZDvAlfeQs8VIs7Nuv4pXzzI23sj9pM=
Date: Thu, 14 Nov 2024 16:06:52 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>,
 ",Mika Westerberg" <mika.westerberg@linux.intel.com>, ",Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH] kernel/resource: Simplify API __devm_release_region()
 implementation
Message-Id: <20241114160652.442ac4d4ee437810946aefbe@linux-foundation.org>
In-Reply-To: <e69c7536-f184-4588-bdec-62b79d39c411@icloud.com>
References: <20241017-release_region_fix-v1-1-84a3e8441284@quicinc.com>
	<e69c7536-f184-4588-bdec-62b79d39c411@icloud.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 22:07:22 +0800 Zijun Hu <zijun_hu@icloud.com> wrote:

> On 2024/10/17 23:34, Zijun Hu wrote:
> > From: Zijun Hu <quic_zijuhu@quicinc.com>
> > 
> > Simplify __devm_release_region() implementation by dedicated
> > API devres_release() which have below advantages than current
> > __release_region() + devres_destroy():
> > 
> > It is simpler if __devm_release_region() is undoing what
> > __devm_request_region() did, otherwise, it can avoid wrong and
> > undesired __release_region().
> > 
> > Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> > ---
> > linux-next tree has similar fixes as shown below:
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=0ee4dcafda9576910559f0471a3d6891daf9ab92
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=9bd133f05b1dca5ca4399a76d04d0f6f4d454e44
> > ---
> >  kernel/resource.c | 3 +--
> 
> Hi Andrew,
> 
> There are no maintainer or supporter for kernel/resource.c according to
> get_maintainer.pl.
> 
> could you please code review for this patch?

Yup, thanks, I'll toss it onto the pile for consideration after
6.13-rc1.

