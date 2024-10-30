Return-Path: <linux-kernel+bounces-389593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DDF9B6EC8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03491F21487
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89B11F12E0;
	Wed, 30 Oct 2024 21:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2xraPJ+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E3F1BD9E8
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730323667; cv=none; b=UixA+0dpDD+4FGo5xZkIQ/OtRVTl4VUymnvox49yiQpuYTVjbms4dr5jqBLYzK8H5vQFRzkaPaz4Kw+v8reeMFYU/ION1EghZkAj8ZlLhedt97JXwBWYR1hh2NBej0++S4QQYSQuFT4LB/YugtNibK9iq87blN5LIOn1Kkt+TT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730323667; c=relaxed/simple;
	bh=AZhh2KACLQ7EV6Ju5HAaFI1UrNow5lUi2yTUUORIPTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2mQ4MEIVoRhvlSvxJWB6zz6X/cOWD7rftL73dZGL+cvPiiVl0X7qFfHCoXl0IJYsNXppaw86pkVZT6llt27FfjUY9voGYRKLt8bJdGEn9YcdM2XnimKp9Kxpy4I4PNKZByeuqjDgf+6yh6nK+2hJln4CMeyY8Lw9kz+fYmsBs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2xraPJ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62338C4CECE;
	Wed, 30 Oct 2024 21:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730323666;
	bh=AZhh2KACLQ7EV6Ju5HAaFI1UrNow5lUi2yTUUORIPTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z2xraPJ+LSYgxRMXaAM/RoXHwi810TBZ9usumYiyJTs7O5Ukf1kjKCDogk5Jye3UL
	 5CYj8c43U7Aq94WIUDg1CyyWvPDCEVa/OYtIUPqn2idAdhqNYAjCqab+3dRkGKFx0Z
	 TX7/yBcD4LHG7ekP97I1TR+w9YwpyWBFPK0vCigxboBg30QJCZwpLtypGMQHaxCd7M
	 I+2X7MMhCFTm7hlQxzhnB1HghgqgeTN8JN5Mm8G1lk+kAXsWuCuolRcoEzgg5E0DKe
	 TDonxVCjTabb0cFTK7npSiYuXMj7hZ6AWe0iWtuKNYxaxIV4RcIkjF57PtQGJULJDg
	 4Izhis/3idp7w==
Date: Wed, 30 Oct 2024 11:27:45 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, void@manifault.com,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 6/6] sched: Cleanup sched_delayed handling for class
 switches
Message-ID: <ZyKk0c99KRGQineg@slm.duckdns.org>
References: <20241030151255.300069509@infradead.org>
 <20241030152142.928034708@infradead.org>
 <20241030154551.GN14555@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030154551.GN14555@noisy.programming.kicks-ass.net>

On Wed, Oct 30, 2024 at 04:45:51PM +0100, Peter Zijlstra wrote:
> TJ, strictly speaking you should probably do a __balance_callbacks() in
> __scx_task_irq_rq_unlock(). The various switched_from() methods like to
> queue_balance_callback().
> 
> I think you're currently good by the fact that only RT/DL do this, and
> you're not touching those in these loops.

Ah, will send a patch soon.

Thanks.

-- 
tejun

