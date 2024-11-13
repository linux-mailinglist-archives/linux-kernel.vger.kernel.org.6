Return-Path: <linux-kernel+bounces-407168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9120E9C6997
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 07:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DA1EB22BE0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 06:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9EF17D36A;
	Wed, 13 Nov 2024 06:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="yfjxYDHY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FDF175D5D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 06:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731481144; cv=none; b=phBBDX+DFNBMw6gTj/6qpTBpZ08A+O9jyshIgW0hqRi+2vD3hYq0XGLwlnfE71eBUA7CuEkveCZr5qizNBXD0G/ZkynXu/ttgwasmxMhLSJJ5LUXOmZHl+BPcGeyiXrSgrLeex8AVVJhlcu9XiKAKch1wn4017Nj2nvrJkul5Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731481144; c=relaxed/simple;
	bh=cVitClo5nRCBuMhUk5E/ANZSQvCkEAI1V3dKH5MbYt4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nerocf5keHlbTV6Hq9sA+T87Oter8EFZRxm10Pw+MVRHNCVeKWTE8/Z5nSu0FKx+4KD2TfBOVXGht0qeZUv6/nvyMGYiInxCy03bPkDU7uO+uRRYFdufHLSAcxnQJxFF64PU7xkN+OfqUZqIQNjggDKlqzChxAbPdZ/7HJsBoNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=yfjxYDHY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D40C4CED0;
	Wed, 13 Nov 2024 06:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1731481143;
	bh=cVitClo5nRCBuMhUk5E/ANZSQvCkEAI1V3dKH5MbYt4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=yfjxYDHY+66a6yzeaEzS6U2vHqvLjdcnS2yWMkLZKPPl6kdMFcTg+0FKBSpTB3UVp
	 PW7XVxMKPki452DV2FgLy1TwvASS1aS5BO41qG7UYo90I4yuLIPmTUGXTnc0SN2vm4
	 asgG3aXDqDPQ8l0VP1V1HQ3feFsKSVLJpY6gIJ3E=
Date: Tue, 12 Nov 2024 22:59:02 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, Sourabh Jain
 <sourabhjain@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Zi Yan
 <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Mahesh J
 Salgaonkar <mahesh@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, "Aneesh Kumar K . V"
 <aneesh.kumar@kernel.org>, Donet Tom <donettom@linux.vnet.ibm.com>, LKML
 <linux-kernel@vger.kernel.org>, Sachin P Bappalige <sachinpb@linux.ibm.com>
Subject: Re: [RFC v3 -next] cma: Enforce non-zero pageblock_order during
 cma_init_reserved_mem()
Message-Id: <20241112225902.f20215e5015f4d7cdf502302@linux-foundation.org>
In-Reply-To: <054b416302486c2d3fdd5924b624477929100bf6.1728656994.git.ritesh.list@gmail.com>
References: <054b416302486c2d3fdd5924b624477929100bf6.1728656994.git.ritesh.list@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Oct 2024 20:26:09 +0530 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com> wrote:

> cma_init_reserved_mem() checks base and size alignment with
> CMA_MIN_ALIGNMENT_BYTES. However, some users might call this during
> early boot when pageblock_order is 0.

This sounds like "some users" are in error.  Please tell us precisely
which users we're talking about here.

Is there a startup ordering issue here?  It feels like a bad idea to
work around callers' flaws within the callee.

Please also describe the userspace-visible effects of this.  Because it
might be the case that we will want to backport any fix into earlier
kernels, and we shouldn't do that until we know how those kernels will
benefit.

And to aid all of this, please attempt to identify a Fixes: target, to
aid others in identifying which kernel version(s) need patching.

Please answer all the above in the next (non-RFC!) version's changelog.

Meanwhile, I'll queue up this version for some testing.

Thanks.

