Return-Path: <linux-kernel+bounces-289001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAB295411D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4706B220FB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 05:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0BC7B3F3;
	Fri, 16 Aug 2024 05:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FrIOFB8n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F968EDE
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 05:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723785906; cv=none; b=q6yE/FhWmU4u/VffJBMr7NWX8/DRCe4/bNmmODZ946wmGwwRuCY+9plIbQyg6ZCMOPygHf1mNkyEqgOuOl+13dKgaVN/Z6E+7RXnGyTI6m53HWCM2law7VTEtM113ZGnxfeAgZtvqwOpX5U5d4x0uW69pbb7x+nSPGuXxn7MgUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723785906; c=relaxed/simple;
	bh=2r9CFjNUYOawQduYci6MbLAEPCOnx0RPSs0yniWm+mw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=druEwOFZ22wmJkismphJaZR3zjVcdv/ynGSP9GK+IEnjM2pTQWOmGiqJfBi4/U5/vNn9HGiwHTQc9+EToiRXX1+fpS/DS7Ls8zM5JxxAIQ1iFnNyq9LcWX3AIKdBsQERoF5SEg/PZT5ByHRv5nt/c+/QXdQSdE1H00hRI6ZSMzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FrIOFB8n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8022CC32782;
	Fri, 16 Aug 2024 05:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1723785905;
	bh=2r9CFjNUYOawQduYci6MbLAEPCOnx0RPSs0yniWm+mw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FrIOFB8nsRTnIP52tg0Xenh4UASNvS8ffWOtRUl450IBQrxpJq4fcQ6phbySPNqO2
	 Ihh18DNsufi2hyNpUcmIeRkWBuh4XgS6b02JeckK2IE4DpGDKzWzS70YO75Zk62tRs
	 Ad4BoodTcMGeiB6iuD8kYpX2khGz6eo/bFirT1hw=
Date: Thu, 15 Aug 2024 22:25:04 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Gao Xiang <xiang@kernel.org>
Subject: Re: [PATCH] mm/migrate: fix deadlock in migrate_pages_batch() on
 large folios
Message-Id: <20240815222504.85e94e909d28bc64bc89b847@linux-foundation.org>
In-Reply-To: <fc4981c1-b7f1-4295-a0f8-a293b5610f79@linux.alibaba.com>
References: <20240728154913.4023977-1-hsiangkao@linux.alibaba.com>
	<87plqx0yh2.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<d93b06a5-20f2-41bd-a7f5-d06906d88ba4@linux.alibaba.com>
	<20240815220224.d7970835d5c12b4833bd04dc@linux-foundation.org>
	<aa5ac560-1dcc-45b6-8e24-0e9cb59feb18@linux.alibaba.com>
	<fc4981c1-b7f1-4295-a0f8-a293b5610f79@linux.alibaba.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Aug 2024 13:17:04 +0800 Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> >> does someone want to take a look at developing a v2?
> > 
> > I've replied your email last week, I'm not sure why it has not
> > been addressed?
> > 
> > https://lore.kernel.org/linux-mm/20240729021306.398286-1-hsiangkao@linux.alibaba.com/
> > 
> > The patch in your queue is already v2? No?
> 
> Really confused about this, since the comment above was about v1.
> and v2 is already sent (in July 29) and in -next for two weeks
> with
> 
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> 
> What else I need to do to resolve this already resolved comment
> so that I could enable large folios without deadlocks anymore?

Is cool, thanks - I failed to correctly update my notes-to-self.

