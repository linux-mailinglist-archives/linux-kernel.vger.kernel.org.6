Return-Path: <linux-kernel+bounces-397305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8229BDA45
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 01:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C3331C22CF5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 00:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272CB15E8B;
	Wed,  6 Nov 2024 00:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1t+4ZWO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E0280B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 00:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730852799; cv=none; b=gkybj93Rjinzf9cg6wEjeluW4ReqYZF8MVS0UIEVycB53YZFu5hvm3HSKipwMoWim+pY3O8g2GfOy8tjqWf1exuJdA4WeVZdD6fHmSwTpYsKroAjQaNvBpRyRx/6QnNpyPtGBv7muTGuAwSKyoXaaKqvlXszZVGqCPGfpW6XM4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730852799; c=relaxed/simple;
	bh=oKf5oeoVGRCMVz8uqAA2me+Z+QdTh5jv7yveiCuLp+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y97VGDHr2g3rA4PXz6PJOjP2HhCa3deTwONhsRe8F7h13OXFlkhJMVPj9AClJe3m69VQGGEjR+DZIpKMk3lNhIqGCv1tnafYiOEdQ2HC7QEuugrb7o5e2WlsGVu5HoFEAN7w2DcUEnVkdIeJE2duX4PkXJANRvFw0blb6wwl8t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1t+4ZWO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6DFC4CECF;
	Wed,  6 Nov 2024 00:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730852799;
	bh=oKf5oeoVGRCMVz8uqAA2me+Z+QdTh5jv7yveiCuLp+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a1t+4ZWOim2PgthtfrtKzsitjoFsK249PmN0jW0Heq/XTbBIHXpzXrNLcbieBhLIb
	 keQo5RXipo8MLiKfvmBSyol+JWIFgsE3YfAlYG/elvGZVaXIMAhgbr5FJL6+W30+8A
	 t5ienKCmCtLnJ9k5KqT1VEewWZjLijA3vZW3Ksghrp6fzLN/psSwlcYmNtzBcw7Zck
	 M54kgEtuvUpIjX1YgcoCEvynLYmsKLvBJpPcuvzmn1IEubbbvxC+ACueHNdeZle2Gh
	 c9jmIFoOuLRJuN6a4T/Z7KWi2sOglbhTxxVsAmEjRv4aro1mjSQUsFvmvkEeSXzZP3
	 zjmXfojNZPa3A==
Date: Tue, 5 Nov 2024 14:26:38 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, sched-ext@meta.com,
	Changwoo Min <multics69@gmail.com>
Subject: Re: [PATCH sched_ext/for-6.13 1/2] sched_ext: Avoid live-locking
 bypass mode switching
Message-ID: <Zyq3vmLP4R2WjnmB@slm.duckdns.org>
References: <ZyqSm4B4NuzuHEbp@slm.duckdns.org>
 <Zyqw9rI-hbxhMqv_@gpd3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zyqw9rI-hbxhMqv_@gpd3>

Hello,

On Wed, Nov 06, 2024 at 12:57:42AM +0100, Andrea Righi wrote:
...
> Do you think there's any benefit using the idle injection framework here
> instead of this cpu_relax() loop? At the end we're trying to throttle
> the scx scheduler from hammering a DSQ until the scheduler is kicked
> out, so we may just inject real idle cycles?

That involves switching to the dedicated task and so on, right? When this is
needed, we can't even trust whether the system is going to make forward
progress within the scheduler. I don't think it'd be a good idea to call out
to something more complicated. Also, from forward-progress-guaranteeing
point of view, cpu_relax() is as good as anything else and this shouldn't be
active long enough for power consumption to be a factor.

Thanks.

-- 
tejun

