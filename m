Return-Path: <linux-kernel+bounces-387556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4A59B52D6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 20:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F9F282DAF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 19:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EF120720A;
	Tue, 29 Oct 2024 19:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4CQ75R8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C581DDA2D
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 19:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730230620; cv=none; b=crnFZAld/SyRuRaHj0i/7N19pab4phPuEF6PkDiQSaobv5NhGaJKeH+RCBiwCkS7CyIOXrJkuBnBiy6g9L8kH9pkMFJYx4Lbm35DpRdfneIKWHIiLnM5J0EXBuTDy+GN7tqhVQn23g2RwRJ2ik3pnaE0hFNgdkM5YBS1pEokwd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730230620; c=relaxed/simple;
	bh=2G2w2Tlv1jSuI27J+1fmhh8XWzDm8+MT6bwJ2SuaDf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7LHZ28lBgKLwivYnCs8nOf72v4YonCIXssCK0tAJOGwYPgEqheGcl8qiI60t1FbI7HAuoln2s0Fse2kr3FqK+JvRx5IpCk9lUAFCYdmKUQYyLNR2n+mAy8/jByKRyNrWd89EuB/B+Ohv7nzDJqiZrYZEvxQ0G88Ash0J0MKG3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4CQ75R8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B718FC4CECD;
	Tue, 29 Oct 2024 19:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730230619;
	bh=2G2w2Tlv1jSuI27J+1fmhh8XWzDm8+MT6bwJ2SuaDf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K4CQ75R8RmQwLuo6ChAX0R4w5x6nmnAd0uKoGJ7ePHi/LwylX7IVJSDAI9YgWvyqx
	 xYZz1pZhdYI6c/l91Ya6QQv6y/qP0UhzuQYVLkz7YtJ5hml6usxd2bUi58jopEjob5
	 13Nk6Bzt9FcsXaz3jOgTj85lzDqYtHrtpjPSF0m3wEMrWrduj/ej86wlxIjZSI9yYu
	 5kPL07s80XG9R5edM225KXEt/X48eYQNi0+bLAEvwXJrLHjI8pyoOyFg7naXN0yiUu
	 dB/4QuyDqtmQ4ryiqZE7NYeX7JW6uGt+7b5zxs4lfOogW5fcZ6hbf/5EnMoBPXCk2Z
	 tVIsTQIfAa7EQ==
Date: Tue, 29 Oct 2024 09:36:58 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] sched_ext: Introduce NUMA awareness to the default
 idle selection policy
Message-ID: <ZyE5Wql986JDxppv@slm.duckdns.org>
References: <20241029101618.318812-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029101618.318812-1-arighi@nvidia.com>

On Tue, Oct 29, 2024 at 11:16:18AM +0100, Andrea Righi wrote:
> Similarly to commit dfa4ed29b18c ("sched_ext: Introduce LLC awareness to
> the default idle selection policy"), extend the built-in idle CPU
> selection policy to also prioritize CPUs within the same NUMA node.
> 
> With this change applied, the built-in CPU idle selection policy follows
> this logic:
>  - always prioritize CPUs from fully idle SMT cores,
>  - select the same CPU if possible,
>  - select a CPU within the same LLC domain,
>  - select a CPU within the same NUMA node.
> 
> Both NUMA and LLC awareness features are enabled only when the system
> has multiple NUMA nodes or multiple LLC domains.
> 
> In the future, we may want to improve the NUMA node selection to account
> the node distance from prev_cpu. Currently, the logic only tries to keep
> tasks running on the same NUMA node. If all CPUs within a node are busy,
> the next NUMA node is chosen randomly.
> 
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Applied to sched_ext/for-6.13.

Thanks.

-- 
tejun

