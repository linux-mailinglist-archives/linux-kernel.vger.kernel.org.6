Return-Path: <linux-kernel+bounces-382752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A949B12F5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 00:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F64B283A22
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 22:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657BC1D1E91;
	Fri, 25 Oct 2024 22:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="czGX/vG9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCAD217F3E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 22:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729896328; cv=none; b=cr9vEvYSEzJJo3gUFd2Th3Sx30cHwlNmlxt8skJy2FCv9bQ88Oy1TNFQDCOWZmosFfajO/uDiERHeP38az/mlQXUO18EcX07PtShz2bTZ/e9WBukAeugczfwrdaxECp06VI/pD16+JotYqYTolzI/W14xgb0Rq8pol2qcgKhApM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729896328; c=relaxed/simple;
	bh=4bjvBAHBNnKIvt0MmCHkfl9XQKQ+4C/OYg2iexwWGIw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Sa2yaZ7ccoV+ekPhSujXGQyxyybTMetUeHzLnK95VcNMzRhpuv4WW0KUQWmKRJZRAomQ24Mirhc0vpwXo8zE6Ze/3TBaaYbmj8f+9bTYBHYiExvvpyj2zUtYLTtvTQbpgwwqV9kwV/YnYFBkFICR1Nh1QIuI5sG3iIduc4JJziM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=czGX/vG9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D46C4CEC3;
	Fri, 25 Oct 2024 22:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729896328;
	bh=4bjvBAHBNnKIvt0MmCHkfl9XQKQ+4C/OYg2iexwWGIw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=czGX/vG9LV1Rv1Hjt9kkVbCUwwpAK/+T5wi0yLxQNjFRLyjJUZuqXGPS00iKuXdPF
	 Ozw/pHZFPoixNMNAoDRI2JMW1K4GZez+ZaEcnZAlmIw3aqFFLeohQhcShGW2ZLcMVU
	 x3fXM3O0ZCBIgTypod37u6+HSjauJ6SgLcsVxD0E=
Date: Fri, 25 Oct 2024 15:45:27 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Matthew Wilcox <willy@infradead.org>, hughd@google.com,
 david@redhat.com, wangkefeng.wang@huawei.com, shy828301@gmail.com,
 dhowells@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: shmem: fallback to page size splice if large folio
 has poisoned subpages
Message-Id: <20241025154527.31873b55fb75d778c431f5ef@linux-foundation.org>
In-Reply-To: <01423085-1622-41ed-a882-64291f3e97ab@linux.alibaba.com>
References: <fd3893f318493a3720dc1a4b1c33f0f692ddf125.1729825743.git.baolin.wang@linux.alibaba.com>
	<ZxsRCyBSO-C27Uzn@casper.infradead.org>
	<01423085-1622-41ed-a882-64291f3e97ab@linux.alibaba.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Oct 2024 11:41:28 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> 
> 
> On 2024/10/25 11:31, Matthew Wilcox wrote:
> > On Fri, Oct 25, 2024 at 11:26:39AM +0800, Baolin Wang wrote:
> >> The tmpfs has already supported the PMD-sized large folios, and splice()
> >> can not read any subpages if the large folio has a poisoned subpage,
> >> which is not good as we discussed in previous mail[1].
> > 
> > folios do not have subpages.  folios have pages.  do not use the term
> > "subpage" anywhere.  ever.
> 
> OK. This is my previous habit of naming it. Will change 'subpages' to 
> 'pages' for folios.

While at it, please try to avoid depending upon references to previous
email discussions.  The links may be bad 10 years from now, and it's
laborious for readers to trawl through the online discussion archives
to extract the information they need.

Including the link is fine, and potentially useful.  But please also
include the relevant information right here in the changelog.

