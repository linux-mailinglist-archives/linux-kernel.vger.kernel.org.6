Return-Path: <linux-kernel+bounces-186493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 463A68CC4E4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76A341C2183E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4E1140E3C;
	Wed, 22 May 2024 16:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qf3wgycv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D51C13D8AA
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 16:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716395384; cv=none; b=D0BP7kw7h0km1BGTqhq2vmR25hrFJFPzmyrD4vEVLcO0lHI/ewlP2WZuzZ6pwP/nZGQw82ww2GOOmmDvF141zP8aQNU4O6CaDU+FLkvXrIriLqBhchogfaGp9iaCZN8isWwB+um3Oi5Pejm5R+m1k98DPWMBW9dq2oU4Ius5oMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716395384; c=relaxed/simple;
	bh=JUtNNJy/nHM4nKkU6sDEme4IkoVcVSX2db5+h1zO+ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KG3ovxWIuS5l3awB5k523NQwamidtmlJKzA5E1CxCYKr0scayNJqUE4N8ZhVYCARKcOd/bYsyJUpHmrtVM3CWY7DGrlKsFUq4jJ9SJES7j9DPVIXti2ulkmahbPo+3R14isB0Lf2OyTHuTW0g8WtGXyV3FAtwxCOoR+RdMNifDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qf3wgycv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3A1C2BBFC;
	Wed, 22 May 2024 16:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716395384;
	bh=JUtNNJy/nHM4nKkU6sDEme4IkoVcVSX2db5+h1zO+ac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qf3wgycv0vGY1lvXnKMRNqMJUZL34+i6jciTl+/h2OitcbI7fSBAfLJ4bsWwxDMyp
	 SxUgE79/uzg3gdbuS1OCa3tK44ftrHsrL8tIsH5KJQUIQHEqR8fpgAgDbDDfTTodIi
	 jQQ6Mk0/T0Wc9EtESMSelBkiW+DnB5zn2nzS7b3jYB3IaYMa4joL+31qGVJXjZ6SIB
	 8u20pzIMLtrO1UxrMD9+Bb4j9JbMgdefFMaI2lDceBrYCBhgjB/e/RJCn5YkmiyyBL
	 9qu+2ZsoTI37O7zfnnOzaHE9hpnmG9/CZd8o5QBrDLS4caN0HNQWyDjpu7/FVt5ENm
	 nxv5xGzprRVjA==
Date: Wed, 22 May 2024 10:29:40 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: hch@lst.de, sagi@grimberg.me, emilne@redhat.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
Subject: Re: [PATCH v4 1/1] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Message-ID: <Zk4ddPmottdOJND1@kbusch-mbp.dhcp.thefacebook.com>
References: <20240522154212.643572-1-jmeneghi@redhat.com>
 <20240522154212.643572-2-jmeneghi@redhat.com>
 <Zk4VtiCjeqkBKCBA@kbusch-mbp.dhcp.thefacebook.com>
 <cef5a764-ffab-495c-bea2-e4c6a7c76944@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cef5a764-ffab-495c-bea2-e4c6a7c76944@redhat.com>

On Wed, May 22, 2024 at 12:23:51PM -0400, John Meneghini wrote:
> On 5/22/24 11:56, Keith Busch wrote:
> > On Wed, May 22, 2024 at 11:42:12AM -0400, John Meneghini wrote:
> > > +static void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
> > > +{
> > > +	struct nvme_ctrl *ctrl;
> > > +	int old_iopolicy = READ_ONCE(subsys->iopolicy);
> > > +
> > > +	WRITE_ONCE(subsys->iopolicy, iopolicy);
> > > +
> > > +	/* iopolicy changes reset the counters and clear the mpath by design */
> > > +	mutex_lock(&nvme_subsystems_lock);
> > > +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> > > +		atomic_set(&ctrl->nr_active, 0);
> > 
> > Can you me understand why this is a desirable feature? Unless you
> > quiesce everything at some point, you'll always have more unaccounted
> > requests on whichever path has higher latency. That sounds like it
> > defeats the goals of this io policy.
> 
> This is true. And as a matter of practice I never change the IO policy when IOs are in flight.  I always stop the IO first.
> But we can't stop any user from changing the IO policy again and again.  So I'm not sure what to do.
> 
> If you'd like I add the 'if (old_iopolicy == iopolicy) return;' here, but
> that's not going to solve the problem of inaccurate counters when users
> start flipping io policies around. with IO inflight. There is no
> synchronization between io submission across controllers and changing the
> policy so I expect changing between round-robin and queue-depth with IO
> inflight suffers from the same problem... though not as badly.
> 
> I'd rather take this patch now and figure out how to fix the problem with
> another patch in the future.  Maybe we can check the io stats and refuse to
> change the policy of they are not zero....

The idea of tagging the nvme_req()->flags on submission means the
completion handling the nr_active counter is symmetric with the
submission side: you don't ever need to reset nr_active because
everything is accounted for.

