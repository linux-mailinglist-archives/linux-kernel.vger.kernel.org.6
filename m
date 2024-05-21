Return-Path: <linux-kernel+bounces-185065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0390A8CB013
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999D72838FB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB907F49F;
	Tue, 21 May 2024 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jt7rX7V8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F96535B7
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716300621; cv=none; b=lUSt/lfbC9s8YLPyft/+72wklkt2ufnyA2J09igM8aPam/BFBDJZ8bXwYpAI1YsRxK2LLzQT4mQuJ4Jp+xandZwvTV6E2n4AFyfqmENTFRoUauJeRFEJXJ2xHc3wfymDBKdKQIQKlvB3ow/C/6Fa2uMHnurZavt3FIpmxeM5dnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716300621; c=relaxed/simple;
	bh=amWnjt4JjeCxkbq0DcmeXrYrb3QX2mJNLgyTI5kZlMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fxz/WL0BpJzXWppXKGn1yAUgd6bUPJ5/tcN7eKv1XSDgn3PX81tssy4Pf8yXO0PpVlxPOQppGi06DZdpgwxPefUTiDIrq7DnJ+1t4PjYFVVzm7u60lfcsESVLvjumXzhrDGgoYX4uuK2mRCTGOO6DSrqKJnlViWPJxbpJm8tV+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jt7rX7V8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC87C2BD11;
	Tue, 21 May 2024 14:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716300621;
	bh=amWnjt4JjeCxkbq0DcmeXrYrb3QX2mJNLgyTI5kZlMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jt7rX7V87jSD6Pg/RJE+R+B+xHXjLuKsp7h91efnNLo9h9dCsX9mUCF9mvWRfzv7b
	 hRFiibRtI9BqRKbgP7fN12FIOa2sSx/qeC++FlkL9c6RVGAi5j9xsAoAgGFfF41tCN
	 hfNU2jjvFlwMSu2bNL3A9Yi7jmMGXdLLxZ5LgfsLXjMeivPKjy9vYJGYNQeOwdaNKp
	 PnXzASPuvJUcnjeHpQF6q4vqyNhrSjIVSkv8TJl8ZoNSeDEG2rwatv6b1r82UeXFDw
	 DXXjMzOz+vgS2wXujor3bQFJOuGK/bVZ50BFHvGKSPk+dbwAxIaxNJrCKK76u2rR1e
	 Nx0E71iXijzgg==
Date: Tue, 21 May 2024 08:10:18 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>, hch@lst.de, sagi@grimberg.me,
	emilne@redhat.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, jrani@purestorage.com,
	randyj@purestorage.com, hare@kernel.org
Subject: Re: [PATCH v3 1/1] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Message-ID: <ZkyrSqGQX6kQf7nG@kbusch-mbp.dhcp.thefacebook.com>
References: <20240520202045.427110-1-jmeneghi@redhat.com>
 <20240520202045.427110-2-jmeneghi@redhat.com>
 <f808fa46-e7c7-48e6-8c80-3d28efd0afec@suse.de>
 <595e5988-b94d-41ba-a233-f87aed55028d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <595e5988-b94d-41ba-a233-f87aed55028d@redhat.com>

On Tue, May 21, 2024 at 09:58:31AM -0400, John Meneghini wrote:
> On 5/21/24 02:46, Hannes Reinecke wrote:
> > > +    list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> > > +        atomic_set(&ctrl->nr_active, 0);
> > > +        nvme_mpath_clear_ctrl_paths(ctrl);
> > 
> > You always reset the variables here, even if specified iopolicy is
> > the same than the currently active one.
> > I'd rather check if the iopolicy is different before changing the settings.
> 
> Yes, Keith pointed this out too.  This is actually a feature not a bug.  In
> situations were we want to "reset" the nr_active counters on all controllers
> the user can simply set the queue-depth iopolicy a second time.  I don't
> expect users to do this very often... they shouldn't be changing IO policies
> back and forth too much... but the ability to "reset" the nr_active counters
> during testing has been very helpful and important to do.  So I'd like to
> keep this.  Moreover, this is NOT the performance path. I don't see the
> point in making performance optimizations in a code path that is run once a
> year.

I missed that you actually want to reset the counters on a live queue.
Wouldn't that just lead to an imbalance? If that is really a feature,
then I retract a previous comment: you do need the atomic_dec_not_zero
(or whatever it was called) since the active count is no longer tied to
the inc's.

