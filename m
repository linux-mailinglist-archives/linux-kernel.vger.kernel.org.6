Return-Path: <linux-kernel+bounces-344632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E43A98AC17
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96B71F23F80
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38697193417;
	Mon, 30 Sep 2024 18:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzNsJsOb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB8043AD2
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727721199; cv=none; b=FUOwV8rE96vGpCpDfobdOAQ7ltO18dFahmmqDNxQ7zFNrOobDmjXpH+g/QJGFLPYcSVgKc3UKWfAuB6HHeNSNqgxgElFWIX7olgBySDIAmIbRxUqUICHdD0kndxTHPAFnLs51nhBvuC8kIrHndn56U8axVJsuV6SJPrysOUyQKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727721199; c=relaxed/simple;
	bh=OvzBbmdgzLCNz04NvdCQdufuJ557GTmhBU2YGxSbG3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oM30L0K/ksiI2qLZy6UhFNdmjQBQMbztbV47fqR3bHoPvW395DQOk5UYm1w/d0wEVxBTOURUsir1iZclvhpF4RObQNbewqu/5hnTtYmw7drXyVDAqVUO5VMjkzNiTZxwMGa+wPlSkqW73mVpzZ/rvdvExZoqHBHMV/NZzfRyidc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzNsJsOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B55C4CEC7;
	Mon, 30 Sep 2024 18:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727721199;
	bh=OvzBbmdgzLCNz04NvdCQdufuJ557GTmhBU2YGxSbG3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dzNsJsObtqoF/v2Ez3YXAQcYsMNYEA+RWTYwTIq3fj0g66KSU2Tz1Z1ze3C9D8J8w
	 YgFuKze/Fxzl4838Qs8u8lAkUbMGDz83kO/vpOB1L/WCBeHq0n9ZEh61XCvzdU/vkQ
	 skY4is5CUY+tWl7s5CET7XGKNxIFWMzfdIO/AUiBOCqhp2DlcITOdaWPfW6uXE8txN
	 QR5N0nN7AiZtA8TFDQGyy4hKJtlH9PG/zAJMbtMceu6ykZPEetJO5tkl+OBo11AQ5S
	 UlfTvPGdWUcmEt8aeyuvNDxPz8EflO19sw0SDUBS26qkM4HWX8u2wzoOfxLQD/v3dL
	 VKoeLPGovBXIA==
Date: Mon, 30 Sep 2024 08:33:17 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <andrea.righi@linux.dev>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Provide a per-scheduler unique sequence
 counter
Message-ID: <Zvru7Qx4aZ9MVU6G@slm.duckdns.org>
References: <20240927165901.40313-1-andrea.righi@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927165901.40313-1-andrea.righi@linux.dev>

Hello, Andrea.

On Fri, Sep 27, 2024 at 06:59:01PM +0200, Andrea Righi wrote:
...
> @@ -662,6 +662,13 @@ struct sched_ext_ops {
>  	 */
>  	u64 hotplug_seq;
>  
> +	/*
> +	 * enable_seq - unique per-scheduler counter that can be accessed from
> +	 * user-space to determine if a scheduler (within a specific hierarchy)
> +	 * has been restarted.
> +	 */
> +	s64 enable_seq;

Let's just make it a global variable for now. When we package up context for
each scheduler instance into a struct, it will get packaged up together.
It's a bit odd to add enable_seq to ops as userspace can't do anything with
it (note that hotplug_seq is different in that it's provided by the
userspace on load).

Thanks.

-- 
tejun

