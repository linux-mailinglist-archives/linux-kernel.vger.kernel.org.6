Return-Path: <linux-kernel+bounces-542530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E07B6A4CAD0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B7D53A55C5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8D5228CBC;
	Mon,  3 Mar 2025 18:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZq3mHGz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6C8148316
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 18:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741025208; cv=none; b=HY5NMWKcMRG8yIL7ZnAo8iamrWDbica22NRjbGU616bnB8RRLcNmhjyjl5/XEtnqvrWW8dFY7I7lps7zuDrnIQ/WncVjB2nSBh9p244pdwjwSZiPqdzZN6MiIPY3K097DEwwRe3S8X7xicg6Eq6w57i/VtQF79z7PLi1OY7PbRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741025208; c=relaxed/simple;
	bh=rcE/YcFLrloUYa1/xvihN5Sll/3BdqwsqWR0xk1arLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XG83pdfcBR8uQ7uEkYzDZDEw6KNkZp9T2iVGL60psXqcOWp5DBh2YBTRiT4rZrHCElttrj5Fw4dgp/gUA37CCS+cBW2UMPsr5cAF16cD8sA0Vg4/jUlsyUB8wipKLpIgMP/yeHq9u6z+4vlFXnehTwkbGRb/nCsTYi4S1+I63Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZq3mHGz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA6AC4CED6;
	Mon,  3 Mar 2025 18:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741025207;
	bh=rcE/YcFLrloUYa1/xvihN5Sll/3BdqwsqWR0xk1arLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gZq3mHGzaVL+kRLl0OdvRto7bYmS/D7xLoDyPaVtJQNw0yLNcA5F1DtvoAOwZxDle
	 Jxeu9/+XObftZKVE957lFEay7Vpyr9YDQqV3zNjZfwPvisR1dan10oCew6D8zbXeLQ
	 zLQ7+hDb8LrJ+b/xYDOYBix5Ofs40m/lgnCWKuT7sMVhHQCoaKBcedKQdhdA082fF6
	 2JGKb6GF5Qznyt4Qd9PC2EyOuum846Sk4HEVwL8V6qbzfyy8w5ijfuVvK/KKXMBPo7
	 dpO/eBzPLW3XdfKsYHiOwBrGNtSSLHt4frmekywyeN56YEP2+cvN4z6RBFDyGjWBhj
	 FIpRDD7iV8LuQ==
Date: Mon, 3 Mar 2025 08:06:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: Validate prev_cpu in
 scx_bpf_select_cpu_dfl()
Message-ID: <Z8XvtpTW1i9LY74v@slm.duckdns.org>
References: <20250303175159.167804-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303175159.167804-1-arighi@nvidia.com>

On Mon, Mar 03, 2025 at 06:51:59PM +0100, Andrea Righi wrote:
> If a BPF scheduler provides an invalid CPU (outside the nr_cpu_ids
> range) as prev_cpu to scx_bpf_select_cpu_dfl() it can cause a kernel
> crash.
> 
> To prevent this, validate prev_cpu in scx_bpf_select_cpu_dfl() and
> trigger an scx error if an invalid CPU is specified.
> 
> Fixes: f0e1a0643a59b ("sched_ext: Implement BPF extensible scheduler class")
> Cc: stable@vger.kernel.org # v6.12+
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Applied to sched_ext/for-6.14-fixes.

Thanks.

-- 
tejun

