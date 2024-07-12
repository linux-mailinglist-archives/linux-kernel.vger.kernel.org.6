Return-Path: <linux-kernel+bounces-250870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF0192FDDA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2866288376
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 15:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DACB174EF8;
	Fri, 12 Jul 2024 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xtLVN6IQ"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4651802B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720799355; cv=none; b=Z+4VntyfWmz3K9EMJzqF/dEEWFPRh3ihtS5hOHYBRAtbZJAAfTSlxIoGhd4aO6dkeTNUsCIExsXJV1WjDhyhWvpHD+tKAg6kwLettHfIgN7cvHF7gzr8yLoumgf4H+eCtgeUeIeetliRXEdu5wkJoxF71/tgWRljtyKRQpxK9iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720799355; c=relaxed/simple;
	bh=fbgk9v8TdlavMHwNJw2AYHzxCpNkaIh5ZUOHJAqm1ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcUREWkXcPXYVIYrgOi0d/L3PJg2kQsF7+iEyQCZ1//rYR1tMzWiE7vqNNgmGbfS1rMksRRPw65ZpXRLN38whFn81giqENNmmP8BsGnLNrB7tNo84yPxLEkgvJ4vPbpTmXDmiQDy1kZcpAfF+vIUVZ1HapowC45oYD/Ssyy2Ldk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xtLVN6IQ; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: youling.tang@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720799347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2EEPTXJLIRMcjxlu21hs5uJVsFBKvELtY6GyRCfbYlQ=;
	b=xtLVN6IQ+p4gD3MHciKv3oCaxJMGILkS9Q00aIsZkJWAzoG9JgDIfVqdDO6GjcS56bVoj1
	6lxD44PgH4XWpS1aQP+IpTf9YicdJHJQqx7SMrYHwWfyJv0FGijO9gVMJxvkVmv0/GLYHI
	N2WdgpMfFG/qpNjg60Mm0YZYaYJxNr0=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: tangyouling@kylinos.cn
Date: Fri, 12 Jul 2024 11:49:05 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Youling Tang <youling.tang@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH] mm: list_lru: Fix NULL pointer dereference in
 list_lru_add()
Message-ID: <oxzh24oit3ulkl5at66c4g3bsyo7z6jd54757yrkgqbeftfgjz@qlzktn3nrkpl>
References: <20240712032554.444823-1-youling.tang@linux.dev>
 <sd32qchit33aafht27utinrz5dizw62qbtwdmwbtugqrlglmtx@6aitsotgqnpi>
 <8ce42a2e-783f-4244-8e75-21dcd578adf5@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ce42a2e-783f-4244-8e75-21dcd578adf5@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Jul 12, 2024 at 12:28:57PM GMT, Youling Tang wrote:
> Hi, Kent
> 
> On 12/07/2024 12:07, Kent Overstreet wrote:
> > On Fri, Jul 12, 2024 at 11:25:54AM GMT, Youling Tang wrote:
> > > From: Youling Tang <tangyouling@kylinos.cn>
> > > 
> > > Note that list_lru_from_memcg_idx() may return NULL, so it is necessary
> > > to error handle the return value to avoid triggering NULL pointer
> > > dereference BUG.
> > > 
> > > The issue was triggered for discussion [1],
> > > Link [1]: https://lore.kernel.org/linux-bcachefs/84de6cb1-57bd-42f7-8029-4203820ef0b4@linux.dev/T/#m901bb26cdb1d9d4bacebf0d034f0a5a712cc93a6
> > I see no explanation for why this is the correct fix, and I doubt it is.
> > What's the real reason for the NULL lru_list_one, and why doesn't this
> > come up on other filesystems?
> We can break it down into two questions (independent of each other):
> 1) Error handling is necessary when l (lru_list_one) is NULL here.

No, you're just hiding the actual bug - since I wasn't clear, I'm naking
this patch.

