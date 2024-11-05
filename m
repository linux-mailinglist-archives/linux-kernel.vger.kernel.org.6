Return-Path: <linux-kernel+bounces-397250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121C99BD963
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 00:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DE95B225CE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 23:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B7321644E;
	Tue,  5 Nov 2024 23:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZDNOSi2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B8F1D3193
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 23:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730847756; cv=none; b=aoyfM3Jqj3zPuNi7hS+Ejy289gkC/3EDufnDTHiEtOQFFAG0YqQoeWDcT81658bP5oTBdo7VXzuypt1NxjPWaCpNizUlL84cR8BMQgtFoobq3rBik3xu9XnUnHsKVmEoH6o7E7hY6YxG22IPv8/wMU/fmBimXNFKEC85KAzIjJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730847756; c=relaxed/simple;
	bh=IpSl7kQ7MAtXbHyWzNmyHUdfgC1ppBr2WlJlap3IlFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arSS/3tE65F0hty8tNj+qkOcZjaGD+vBPre75DM1lMkqSVsbSl0FDPrrdwrlMZAkrgwzds/B0z/a4VYosW2MFWivEbcJsVsW0rBSTkWJX0IZHhBbEfANlIulGlT/Css4XxO+yiZM47GmOntZFmfIReBgcc6Gw3O23kd+lcOhmd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZDNOSi2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98245C4CECF;
	Tue,  5 Nov 2024 23:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730847754;
	bh=IpSl7kQ7MAtXbHyWzNmyHUdfgC1ppBr2WlJlap3IlFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oZDNOSi2fDXrnOSdPz6rNp6o7ugA33V9XnRICjmMXOaS2wfvjpPS7aGq53x/b+YVk
	 1jSnvYVZrhP7GaoVFvsC0l46F3R4+jaAFLKRF/5YQpFiclkVQZsMcpI2DRs1O9xxSB
	 698+pAacfYy2elxB+4oQcEwOXCp3YV0VhM4uqV9dv0HseCoNQ352GwizAZCRBPbEMd
	 Du9BbVFThgTnTG+X+yDuiZIrUvTd0e62veA1dMuHXPKCyNdwKaqe8SE5udW5voQB6o
	 86jSknZsQHjfrHffHKBm7MgGmfOobi5Ss5ZultazEmRgghYTqzM/WFfSbXbNosYipN
	 nZINK+NhUb0xA==
Date: Tue, 5 Nov 2024 13:02:33 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, sched-ext@meta.com,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <multics69@gmail.com>
Subject: Re: [PATCH sched_ext/for-6.13 1/2] sched_ext: Avoid live-locking
 bypass mode switching
Message-ID: <ZyqkCbC9NPBxsPU1@slm.duckdns.org>
References: <ZyqSm4B4NuzuHEbp@slm.duckdns.org>
 <20241105220346.GA64119@maniforge>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105220346.GA64119@maniforge>

Hello,

On Tue, Nov 05, 2024 at 04:03:46PM -0600, David Vernet wrote:
> On Tue, Nov 05, 2024 at 11:48:11AM -1000, Tejun Heo wrote:
> 
> [...]
> 
> >  static bool consume_dispatch_q(struct rq *rq, struct scx_dispatch_q *dsq)
> >  {
> >  	struct task_struct *p;
> >  retry:
> >  	/*
> > +	 * This retry loop can repeatedly race against scx_ops_bypass()
> > +	 * dequeueing tasks from @dsq trying to put the system into the bypass
> > +	 * mode. On some multi-socket machines (e.g. 2x Intel 8480c), this can
> > +	 * live-lock the machine into soft lockups. Give a breather.
> > +	 */
> > +	scx_ops_breather(rq);
> 
> Should we move this to after the list_empty() check? Or before the goto retry
> below so we can avoid having to do the atomic read on the typical hotpath?

I don't think there's going to be a measurable difference in terms of
overhead. It's going to be a cached unlikely jump in most cases and there's
value in catching the CPUs in the breather as soon as possible in case even
if the DSQ currently targeted is empty as it's difficult to reliably predict
the different lockup scenarios.

Thanks.

-- 
tejun

