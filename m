Return-Path: <linux-kernel+bounces-564714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1197A659A2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46FE8188CE42
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6893D1B0F30;
	Mon, 17 Mar 2025 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxyGTeG+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B441A83FB
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230640; cv=none; b=qxpdDmfpDE0TZkxAz1ulk0M9K5dGvQ9zae3t7aYXNgknFYr1EeyYppZPsqHin0c/TWLVRk4kQ+NpF43avFV9P1SnOAxLQ+mtoxbovq7aix3sGTtAlX9GPHDLo09uZ2w0UTXTrtgB54o5+URBKCpW0OFr48+u63ltxTyMH3Xqq98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230640; c=relaxed/simple;
	bh=OAjlU0Gz65Q0UCSzk8Pc3sou4cltFCl4F2yVDcU/gMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+u2BUiq0njmkhsMB6l97Hl7etPHIX2fjYz09yvjdFfWLtQ/u7P3ZFNHo3knQqjHxvIapcKFRaTkvHfSNXew18pt+E0YAhkRI7OqRwVkqAOTAPwOQlf50AZNmS+R/W18ujuAVW9VY1SafTjyUYbC73F3+gzQcNMEG4Y/fJ5aAgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxyGTeG+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB27C4CEE3;
	Mon, 17 Mar 2025 16:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742230640;
	bh=OAjlU0Gz65Q0UCSzk8Pc3sou4cltFCl4F2yVDcU/gMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rxyGTeG+bfC6h1PufP79txV0QH0Is0R9wp1RMXDgxAedfiHWSpCpRffpc9ChNA+zE
	 UUFwUpkuCU2AIr1URx3e0adQO3YNWmi2cRsMGS7DEvY67xIM8gLEF2TOub0ZjfBEYm
	 mxZPdcd5cMtaEoo0A/MWb2MIwAYncy9/Fnzjp9naPHHvaw0x4oNDbt9VFnbT4vMcL+
	 ODMMtDa4ctpTkjuiHHav1vCB1ynTxcAJNOHm4XR/JGZXsQIv0RY7Dje2uWvCyOe5go
	 k11s4kCeR2yiE+kE0zBm/G61GtUTRZqIpWYpFCSGjh7ZzM1Okg26J9dRA4k5wgqHv8
	 fobgKJwZGOcMA==
Date: Mon, 17 Mar 2025 06:57:19 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
	Andrea Righi <arighi@nvidia.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Luigi De Matteis <ldematteis123@gmail.com>, paulmck@kernel.org,
	boqun.feng@gmail.com
Subject: Re: [PATCH RFC 3/8] sched/ext: Add a DL server for sched_ext tasks
Message-ID: <Z9hUby9e1JYaE6iC@slm.duckdns.org>
References: <20250315022158.2354454-1-joelagnelf@nvidia.com>
 <20250315022158.2354454-4-joelagnelf@nvidia.com>
 <20250315072225.GG36322@noisy.programming.kicks-ass.net>
 <3b244939-6d55-4d86-8b77-a9a7629f8239@nvidia.com>
 <20250317103101.GC34541@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317103101.GC34541@noisy.programming.kicks-ass.net>

Hello,

On Mon, Mar 17, 2025 at 11:31:01AM +0100, Peter Zijlstra wrote:
> On Sat, Mar 15, 2025 at 07:15:27PM -0400, Joel Fernandes wrote:
> > If so, that will not handle the case where the system has both
> > FAIR and EXT tasks in the mix (EXT has a partial mode where certain tasks can be
> > made EXT with certain others left as FAIR) and FAIR runs 100% and starves EXT.
> 
> Well, you did not mention that issue, you only babbled about RT.
> 
> I did point out that issue with ext, and TJ said this mixed mode wasn't
> really meant to be used or somesuch.

It's true that most of the current use cases don't use mixed mode. That
said, some folks are interested in it and if we can prevent starvation from
fair saturating CPUs in mixed mode with a DL server, that'd be really nice.
Would it be possible to toggle the reservations depending on the ext's
operation mode?

Thanks.

-- 
tejun

