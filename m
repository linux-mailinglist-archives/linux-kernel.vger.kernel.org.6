Return-Path: <linux-kernel+bounces-296236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D72ED95A808
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 01:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834621F22DE0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 23:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FAB17C7C3;
	Wed, 21 Aug 2024 23:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHoDBrnW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DBF1494AD
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 23:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724281517; cv=none; b=OoNtG0OolRQGEbJdcJGTxB6f8F9kF1ENWnExmEzr+Igh0hiGUgSKvhSw1gjFIujqHx2wCwSmJWJgHVZm3ChCrlwuizlVbqW2XpjtxMhK1c3DU4JPVeymkwtO88HH6LF1eKDr1EywmTNM1kYfH8QhWErc98AKBy6BOuMfa4Rk914=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724281517; c=relaxed/simple;
	bh=n/T0JmBgia3qu1uQaKJnMNYTcx4cBiF/qtikMH12Faw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaW6yn5mANYLDJjqZhcxH5dfmX3WMRXa4+3YJ1NEoevaZB3lq/aSBN/jHe8FHfe6Gr7RfAtFwhDeTeSZ1NK5f3u1J8K4rshe9RX9gzMsawe1N+39kOPA5d04d1Moz5GFzZ5b8xseNPifEiLpWufFzUQgtBV04Wc79D6h4+URwhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHoDBrnW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09D5C32781;
	Wed, 21 Aug 2024 23:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724281517;
	bh=n/T0JmBgia3qu1uQaKJnMNYTcx4cBiF/qtikMH12Faw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nHoDBrnWdjy5/j6X5nS92fRuh1o/N0UN3q1Bv0L1+IGJASWh9ekgLpLCKbLXqCqdz
	 lU1pZeAqnZ3soRnfl3/8+OQFzTYXgX54T+cBUDn2aDQ+JTX4nDL6d+GCo1PC17GRZU
	 8MIRvh7fnWEpZSmWcsy6jufbMCocRBMyFlbMOypNqKkz2IZj2S5DVGlWkqGRIOgoxt
	 sjNMuwjvwS2Uc/aHhF/traspSOkKYGKX2Ya1BHIMC/DsbiWOSE0mafo9F3Dqqdfy+U
	 gPQ9av/wE74YW/i0Hzue1Kk7b/6loN9eiIDNtq7QjGHhoxolddPwdZzWLn8x+vMcVq
	 07G0q7gKPl2cg==
Date: Wed, 21 Aug 2024 13:05:15 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, void@manifault.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org,
	joelaf@google.com
Subject: Re: [PATCH 9/9] sched: Add pick_task(.core)
Message-ID: <ZsZyq-_vUpruRHsR@slm.duckdns.org>
References: <20240813222548.049744955@infradead.org>
 <20240813224016.471745809@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813224016.471745809@infradead.org>

Hello, Peter.

On Wed, Aug 14, 2024 at 12:25:57AM +0200, Peter Zijlstra wrote:
> In order to distinguish between a regular vs a core pick_task()
> invocation, add a boolean argument.
> 
> Notably SCX seems to need this, since its core pick

Tried converting scx to use the new interface and it looks like SCX doesn't
need this either. With small behavior changes around ENQ_LAST and
stopping/running, pick_task() can behave the same for regular and core-sched
cases.

Everything else looks fine too. Once this patchset gets applied, I'll pull
and update right away.

Thanks.

-- 
tejun

