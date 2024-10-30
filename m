Return-Path: <linux-kernel+bounces-389560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FDD9B6E70
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ECD8282042
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AE7214424;
	Wed, 30 Oct 2024 21:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ke8LG39H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF84714F90
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730322597; cv=none; b=G2U2PiNwhJCO6fx1/sDAK5RuAOCcQk4xwBsaLWoR/HzieOusGiGCWnyMGn4BUJfwvv8rWvpUclMXZEGkx/nRuF2pMZbC9R0c+u38kr7yPZ0bOZWqXqd4LaMsgaxnWFBV2v6ten8FFGYd6MFJbxgt4cKAbkY29A9EILPNTS6zGS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730322597; c=relaxed/simple;
	bh=oZFxjSoGQtjd6Lx9hE5iekBYPz9HbbJkaFEA4Q5brus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEj2vRnUsaMkx0Zph9OBSMwPNBas+NSSOk16110dURzfgZHuKB9n5GFXXDjOUQWugIF3exLTMNnAxiPQt5J/7gwXCRcYn6FCtbjOPDlHw/uwCpb2kk4uQgkocCENTqs5oI6QkmcsJN/Sgq09gHdlnicKyKn4W+/pMr/nhhMUzpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ke8LG39H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49FE4C4CECE;
	Wed, 30 Oct 2024 21:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730322597;
	bh=oZFxjSoGQtjd6Lx9hE5iekBYPz9HbbJkaFEA4Q5brus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ke8LG39HOIa1OgXE7S+Ju0d0+JuRD0NKQGQZsfN0S8X3ZTf1+s/9s59J52nbuGpQM
	 k4W5I/C4qmbH1t0vQxx25cPV+pdFahF6iy1RP3ax5EgrYr6gYKphe8jnVmMYZAbT3x
	 w+FKgCfpP2ESjodzb61iDwvKX4GenC6Kh4hWCmEnz0DNRFHZOwsGFVqkatxlYQ0IRA
	 Hz3Jbfht7QhpCBLz0wfDc9dGWyn29S4zwopYraa94JCOLmnMtiwF60qXMkYNEQyh1B
	 GDFk058+ZUYigsuQPcmEXXqCUDKeVpSjVhOTOiB1zRydUbwFy3j4vspoXL3ojGBMri
	 gD4//Va2hCkWw==
Date: Wed, 30 Oct 2024 11:09:56 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, void@manifault.com,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2/6] sched: Employ sched_change guards
Message-ID: <ZyKgpI3YMTfzhgFK@slm.duckdns.org>
References: <20241030151255.300069509@infradead.org>
 <20241030152142.488737132@infradead.org>
 <ZyKeAGgnuZiz3a4A@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyKeAGgnuZiz3a4A@slm.duckdns.org>

On Wed, Oct 30, 2024 at 10:58:40AM -1000, Tejun Heo wrote:
> On Wed, Oct 30, 2024 at 04:12:57PM +0100, Peter Zijlstra wrote:
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -4496,6 +4496,8 @@ static void scx_ops_disable_workfn(struc
>  		const struct sched_class *new_class =
>  			__setscheduler_class(p->policy, p->prio);
>  
> +		update_rq_clock(task_rq(p));
> +

Oh, this probably should be paired with DEQUEUE_NOCLOCK.

Thanks.

-- 
tejun

