Return-Path: <linux-kernel+bounces-302037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7274495F903
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A645C1C21B05
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84469194A4C;
	Mon, 26 Aug 2024 18:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcxbJS2X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DAF18BC38
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 18:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724697124; cv=none; b=NptsGy0llU5OXWjQ7R53gBlc/mlyHLypFP0nR7ZrGxLHo6IYENqCWfcXRMhaQ9mW+WDGboxjq2T3nstU2rydR+6KJ3uOZTQTBifYJVXEpTYfKSR1QmiswT5kVbcCcA55Haq86OPTAI0tMb7VSuWm/Yu5IZ5RLWt37P3UayPv728=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724697124; c=relaxed/simple;
	bh=vc0JmngRsZKXBHdkhwWGWQ6Qprj+zKH/xMHH2tqTvc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ax3jNOuBXqwvvWCG5zKpX4z9ibZAOsGRK/bKJM9/bcZKJvOdP1ytundF57i0CXfLcDgWDDGhYMQ0TNX/p92F764fuqwlUY4hCNYLfyIRCPVV1cnTkr50fZvuOjDCo7ZyLAoMcsgRsDzEt2WmTbTWdEBwgbeMMr3l359g2OG/DZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcxbJS2X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F17CC8B7C9;
	Mon, 26 Aug 2024 18:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724697124;
	bh=vc0JmngRsZKXBHdkhwWGWQ6Qprj+zKH/xMHH2tqTvc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BcxbJS2XzALYp++nfpwj0T1C7pW7jZqHx6koBHZUqEqov+2iU2vaz6yRRtGFqrjnF
	 SdH2b6JCL0Ms+BXZrAKNRlIMEmUyWbCEV9Y6FXIqnLRvwFxVKlNb2oWfxTfnxcY4e4
	 Djm28TPDKTleuzIo2Th94Qs7DDSphnqyMg8wcENDNRFoIf1Ben3TNvFeoAI5zpsVXZ
	 KEloq/N5+CRVtTDUtSYP3ce5eDsB1uBV3J6SpnUuKFTEjdD0YTG7kRxJhMQYcI1De5
	 o73KS/WbriLhtVV4fow0LLASaF8GaBFXICO/tvtxXsh4bC6LXVa6s6U6kLQXeZOTr2
	 80lNKXVHurstw==
Date: Mon, 26 Aug 2024 08:32:03 -1000
From: Tejun Heo <tj@kernel.org>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: void@manifault.com, linux-kernel@vger.kernel.org
Subject: Re: [sched_ext/for-6.11]: Issue with BPF Scheduler during CPU Hotplug
Message-ID: <ZszKI2GA-8yparh_@slm.duckdns.org>
References: <8cd0ec0c4c7c1bc0119e61fbef0bee9d5e24022d.camel@linux.ibm.com>
 <Zo3PgETt43iFersn@slm.duckdns.org>
 <dde4b09001da2641f9679b9409727e2147c5e9a6.camel@linux.ibm.com>
 <daf2370f5456cbf1660bbdc13621559fb3f2f6cc.camel@linux.ibm.com>
 <Zq1NksrG9blyN-KR@slm.duckdns.org>
 <e3069da05fb1676f8faad88b9a4dfc4a6cef4175.camel@linux.ibm.com>
 <Zru5_UmEmWhNaPyo@slm.duckdns.org>
 <fa56b39990dd0b90f971018f5abb7352c60af3b1.camel@linux.ibm.com>
 <ZsTwoWJQcnsJhYbe@slm.duckdns.org>
 <3da12c96daecaa055c478816f5e86c7b44a04d53.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3da12c96daecaa055c478816f5e86c7b44a04d53.camel@linux.ibm.com>

Hello,

On Fri, Aug 23, 2024 at 02:50:01PM +0530, Aboorva Devarajan wrote:
...
> I applied this patch to the almost latest sched-ext (for-6.12) branch upto
> commit 89909296a51e792 ("sched_ext: Don't use double locking to migrate
> tasks across CPUs") and let the test run for over 20 hours, and it completed
> without any hangs on both x86 and PowerPC.
> 
> So, indeed, making sure that both scx_fork_rwsem and cpu_hotplug_lock (read)
> are only held together simulataneously when they can both be acquired seems
> to be resolving the deadlock.

Thanks a lot for confirming. Let me think it over a bit re. what should be
applied.

Thanks.

-- 
tejun

