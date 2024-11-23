Return-Path: <linux-kernel+bounces-419284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 931B09D6BBB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 23:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29766161A1E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 22:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B52319CC02;
	Sat, 23 Nov 2024 22:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aOZPOlZt"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F30C433AB
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 22:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732400166; cv=none; b=SgDl2NXfN1JlxtWX6Rjm4+U7K4ejlvD5Ov1dTCnZtLKbsPRRVtFFUOdfavRJ2pBUZ9WJwueD9J7/E93QqAYjII7eJY0S+7INLBoOlI74mFpH8P8lLhIv4Pw2hB/TYzmi2Me+mTFKhU0nhUzEO3xCmRllb+TzQSCq898Ht7/JBnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732400166; c=relaxed/simple;
	bh=I+mHaJgefbkzwUl+01PtiitXGIMXujzs5bRyr/xe+Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlpENKMZcyGcZ8vpp7fex7RUv+Tv0jsjLRBTooU7+CnThzUrMUq19szvvynlmQBZMK0lsBWJO02vfUeoeeRYS2JS3uUqeH/jPeX/e1Pp61ECwiG8V4Lq8YNgdKOaa4LamNfR+/SbXfOXkPt1+IzazePf8rC2G0q1HRw0UECqvqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aOZPOlZt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JYR0lfiZ1TWLALwPOMCeGprcH2BZa7iQPqABEcTjuZQ=; b=aOZPOlZtqy6H42q8zLm4DaFwNf
	gSvRpOoyp2ZAk/7hTHPLv3cEjVjJQfcAXWS7/BDQxwEypfLUFOoq+Qbt/21/VcyxjMGHSBtfggyRN
	ldtucx8OHB60gx6HtylhwrH5E4r6T48P4i2xdPU6b4EbZr5nu2oRoxUWFfHvdSpjSZkOizEypoM+Y
	66d8B4X+NLm6TzEiKVS9KZuXJZleAynXaBf4NKWE9CzgcG46SgPytEQmFKn5lHiqPLkN1SevqsQ07
	g6N/M3YplKRHCydPPgXztLyjkaAyZ0Dvh5dxAKpHHodMsR1VKuYKDA9NzsadgkX2K76bPIKf5XYpZ
	MzAqFLYg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tEyQ0-00000009hNs-1VyV;
	Sat, 23 Nov 2024 22:15:56 +0000
Date: Sat, 23 Nov 2024 22:15:56 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Junjie Fu <fujunjie1@qq.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, dave.hansen@intel.com, mhocko@kernel.org
Subject: Re: [PATCH] mm/mempolicy: Fix decision-making issues for memory
 migration during NUMA balancing
Message-ID: <Z0JUHBJ5MOKF1n-k@casper.infradead.org>
References: <tencent_57D6CF437AF88E48DD5C5BD872753C43280A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_57D6CF437AF88E48DD5C5BD872753C43280A@qq.com>

On Sun, Nov 24, 2024 at 03:09:35AM +0800, Junjie Fu wrote:
> Because the definition of MPOL_PREFERRED is as follows: "This mode sets the
> preferred node for allocation. The kernel will try to allocate pages from
> this node first and fall back to nearby nodes if the preferred node is low
> on free memory. If the nodemask specifies more than one node ID, the first
> node in the mask will be selected as the preferred node."
> 
> Thus, if the node where the current page resides is not the first node in
> the nodemask, it is not the PREFERRED node, and memory migration can be
> attempted.

I think you've found poor documentation, not a kernel bug.  If multiple
nodes are set in PREFERRED, then _new_ allocations should come from the
first node, but _existing_ allocations do not need to be moved to the
new node.  At least IMO that was the original intent of allowing
multiple nodes to be set.  Otherwise, what is the point?

