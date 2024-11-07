Return-Path: <linux-kernel+bounces-400493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3F89C0E58
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8135B2361C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 19:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87BD217F22;
	Thu,  7 Nov 2024 19:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdRkOuTc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2545A217912
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 19:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731006298; cv=none; b=mB6NBA/1nU7Mj9HUTRcBQTu5fUqCKqiUdcGtOMW7cPMr0kE3hxgqPYrHZ2QDrR11DI11Ohrxu6/g4HB8AlOgTl2/FLsaOXSmYcfQMS2aKs5JJDuUguvmgDGgQkDGodFWbTlzU2XjFR8rJY0rTYoOVuO0446Gv3NT90ensSkjvaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731006298; c=relaxed/simple;
	bh=AqqvcKRxHdeFFo0K4aYA8ojpAsP1PMZ/iU4sb/OEeh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fw1NnN42pI4wWeuA5AOam7DujLdU0/l+AHCGgUzyJHZax7NqQq/lDeJu1Jox4JotKzp4K7/msCKaOhbx/nMGUvjiBgDnSXK19HkF5PT6/fpklLt2TdfvjSAo8S8STlg8HQiGkeG7BjUwtXz+R4F01aFw/Abnblkr8CS/EzvDx80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdRkOuTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7502EC4CECC;
	Thu,  7 Nov 2024 19:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731006297;
	bh=AqqvcKRxHdeFFo0K4aYA8ojpAsP1PMZ/iU4sb/OEeh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sdRkOuTcPPAk0JWJebPKR3lNTm9k0+yRMzOFPcWiESpcOXb8b2iBUTad+HCJfRE6p
	 xRQlTlagvdWaeuPANqUl9h0zReAdbSkm4xKd/cqv+d8eT9CxCpVG1H+yuTbBkKQtyl
	 J3bEUQtAAHX7wyFqm596EJXolxYOn/YqQRgvvLyXLGgA1jMe8B9UmQ8GS3VXvj2WH1
	 iZKklkySkffJ6Km8p26tWTQcJP/mYJXpGoP3cZCMLh+ybMK3gm/cdZU24m+7OYy7n9
	 I3Z0rzd+ShPZnSap9beUmL+zz0jrkFTILxr9p8pZ5ZaBDexROuBW4eQzEhzrpUu/5p
	 xmJnE/OGpKS0g==
Date: Thu, 7 Nov 2024 09:04:56 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-6.13] sched_ext: Do not enable LLC/NUMA
 optimizations when domains overlap
Message-ID: <Zy0PWPaYHWsgh7Rp@slm.duckdns.org>
References: <20241107084805.120265-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241107084805.120265-1-arighi@nvidia.com>

Hello, Andrea.

Some nits below:

On Thu, Nov 07, 2024 at 09:48:03AM +0100, Andrea Righi wrote:
> +static bool llc_and_numa_mismatch(void)
> +{
...
> +	for_each_online_cpu(cpu) {
> +		sd = cpu_rq(cpu)->sd;
> +
> +		while (sd) {

This can be for_each_domain(cpu, sd).

> +			bool is_llc = sd->flags & SD_SHARE_LLC;
> +			bool is_numa = sd->flags & SD_NUMA;
> +
> +			if (is_llc != is_numa)
> +				return true;
> +
> +			sd = sd->parent;
> +		}
> +	}
> +
> +	return false;
> +}
> +
>  /*
>   * Initialize topology-aware scheduling.
>   *
>   * Detect if the system has multiple LLC or multiple NUMA domains and enable
>   * cache-aware / NUMA-aware scheduling optimizations in the default CPU idle
>   * selection policy.
> + *
> + * Assumption: under normal circumstances we can assume that each CPU belongs
> + * to a single NUMA domain and a single LLC domain.
> + *
> + * However, in complex or highly specialized systems (e.g., multi-socket,
> + * chiplet-based, or virtualized systems), the relationship between NUMA and
> + * LLC domains can become more intricate, though each CPU is still considered
> + * to belong to a single NUMA and LLC domain in the kernel's internal
> + * representation.
> + *
> + * Another assumption is that each LLC domain is always fully contained within
> + * a single NUMA domain. In reality, in chiplet-based or virtualized systems,
> + * LLC domains may logically span multiple NUMA nodes. However, the kernel’s

Are there any actual systems that have a single LLC spanning multiple NUMA
nodes? I think it'd be sufficient to state that the kernel assumes that a
CPU belongs to a single LLC and a single LLC belongs to a single socket.

Otherwise, looks great to me.

Thanks.

-- 
tejun

