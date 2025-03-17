Return-Path: <linux-kernel+bounces-565160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A225A661F0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433CE3B74A8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301CA1F63F0;
	Mon, 17 Mar 2025 22:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBGzMtpn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904641F941
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742251707; cv=none; b=bBTffrVNlIYyYvbJhtLntTqY/+OMmymmzZqg/CRvaua8bqYI30XOhNFBCD9qbmfSqIRhtRjKYptYhJZ/bQmwyguc3g03CU4JuYzy063q2vzqe3MVqRW5eFzypaVwLcH37tDS6GaNDVB9g43nZBOi0II175Qbf+r5JwSBldK++V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742251707; c=relaxed/simple;
	bh=hIsLZVXmJV1zKbZHdyvcavTGWICeicStgjCYkyMOP7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLu1QP+KPWKnl5N9IeI1sdCZc2YrBIhgWCQPVrrHBC0646gHRknQCkFYt6RxSnYt8koLlMQs+XuVI+fpX+fzxQea6Odjeoeyl7FSD/j0OOV5YJUYM+NfzCfJXiRH4QF/BT6hh7m1yixFu5MC8bpXBLDiZJjP6mkL/OYToqW0Pn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBGzMtpn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1C9C4CEE3;
	Mon, 17 Mar 2025 22:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742251706;
	bh=hIsLZVXmJV1zKbZHdyvcavTGWICeicStgjCYkyMOP7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kBGzMtpnBGWR5lANTTrIXe4VErlp3fmviybxr+11COZ1PAfKmQz3KSXR0PwOOqNoO
	 U6W1SDpJC6IOUoxtm2qCv3DmhWN0CTstFmeoUQ94CjbvNwSNYaXgv3N3ZLWZk81jMh
	 yTHk6GqAEAWmBiMpxDYefkOMpYwsBvmdl3mtsL8eBpmHvTLFbhW20y+FjSIiXPx0KU
	 8Z+J/zxDeEbt+HDpTY/vPtcuAhOhCvz3oJDWi2lJZoID2mbmo2Zy/dp8VWBIipotfB
	 cOOypsdxsAsaA+UStEzoiqndQepKGY8qNidFKinPzk8CJl8yBoyORTNfIOX+UK142O
	 UfgP2J4bQoCcA==
Date: Mon, 17 Mar 2025 12:48:25 -1000
From: Tejun Heo <tj@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
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
Message-ID: <Z9imufPw3NbcpqJV@slm.duckdns.org>
References: <20250315022158.2354454-1-joelagnelf@nvidia.com>
 <20250315022158.2354454-4-joelagnelf@nvidia.com>
 <20250315072225.GG36322@noisy.programming.kicks-ass.net>
 <3b244939-6d55-4d86-8b77-a9a7629f8239@nvidia.com>
 <20250317103101.GC34541@noisy.programming.kicks-ass.net>
 <Z9hUby9e1JYaE6iC@slm.duckdns.org>
 <20250317170602.GE6888@noisy.programming.kicks-ass.net>
 <8d9e6300-113e-4a89-8fc3-2ae895c77794@nvidia.com>
 <Z9ifV3UcLPNvBttF@slm.duckdns.org>
 <4b8a25f7-c7c8-467f-8d03-6e590712ffbd@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b8a25f7-c7c8-467f-8d03-6e590712ffbd@nvidia.com>

On Mon, Mar 17, 2025 at 11:39:32PM +0100, Joel Fernandes wrote:
> On 3/17/2025 11:16 PM, Tejun Heo wrote:
> > On Mon, Mar 17, 2025 at 10:48:16PM +0100, Joel Fernandes wrote:
> > ...
> >> Just to clarify, Tejun is suggesting that in mixed mode, we boost EXT
> >> independent of FAIR. And in normal mode, we we boost both FAIR+EXT, because well
> >> - nothing would be running as fair anyway.
> >>
> >> But what is the point of doing that, if we have boost EXT independent of FAIR
> >> anyway? We need that code _anyway_ due to mixed mode so it would not simplify
> >> anything.
> >>
> >> Or did Tejun mean something else about "toggle the reservations"?
> > 
> > My understanding is that if we have both FAIR and EXT's DL servers reserving
> > execution time all the time, we'd be reserving execution time for something
> > which can't be active, so the only change necessary I think is just
> > retracting FAIR's or EXT's reservation whent we know they are not active
> > (ie. if EXT is not loaded or EXT is loaded in full-sys mode).
> > 
> Ah, I see what you mean. We already have a 'toggle' like that though because if
> FAIR or EXT is not running (due to whatever reason), we would have already
> called 'dl_server_stop()' or would never have called 'dl_server_start()'.
> 
> On the other hand, even if full-sys-mode, we need the EXT server to boost it to
> above RT if EXT is running, so we need its server initialized and ready to go.
> 
> Let me know if I missed anything though, thanks,

I'm not very familiar with DL but it looks like a stopped DL server would
still be reserving bandwidth which limits what other actual DL users would
be able to reserve without causing overflow. It looks like EXT's activation
modes should be calling into dl_bw_manage() so that FAIR's and EXT's
reservations can be retracted when not in use.

Thanks.

-- 
tejun

