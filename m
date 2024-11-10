Return-Path: <linux-kernel+bounces-403344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EB09C346A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 20:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98C031C21231
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 19:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD9B13C670;
	Sun, 10 Nov 2024 19:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m118utQW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C0E10A3E
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 19:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731267488; cv=none; b=PZI5ZK80uZiO7P7M6U3YcDgOAxrSwzkyqQSFRUz6WDz8R3s4jlzVuFYRTg+4uvbZzcBZ83F/wgipVj3q5XY5YbUcNltPLjqK6tmUthGs2obhFBDfI9jHorwd0ZlRNJs3+4xtHalqR2J0ad1K5Z17K4ROhoTPiurDB8/yfnP4JZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731267488; c=relaxed/simple;
	bh=5raMsL3YtEnQyRroqq9Rox8lVOkFKhPtiGZ9lTnhkgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhGB09mJVfLwtyA77bheoOxK57Pa4wzRhqRmrbtwpmzbqf4vaqayWzA1l9QSPsF/hCGmTe4lsmBD7K8Pk7Z4YUUKe3Jz7tkIcgvEcHwrcpkt8JnjKQ7syIiktAdNfI/DWhi8tG0ypebmP1VV0Kc5aH/i1ViK9wbmyGVhF9G3jNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m118utQW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6867C4CECD;
	Sun, 10 Nov 2024 19:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731267488;
	bh=5raMsL3YtEnQyRroqq9Rox8lVOkFKhPtiGZ9lTnhkgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m118utQWIGUa4e4DgltV1NqVZp2+Q6Fikl0FKEUXB8GeKszg0Tb/0UDACgTlGIxTh
	 K3FI79SCjafrgPOrUjaL/sHdLIS8vzYd6AGt27DBZiuD+Tzm/8Cc05HBqBpK4dupwP
	 UJo+sVzxgxlIKg3fu6bUYPtKwnxV9WfLXAZII8bdxkvZ6+JLt/tyu/TOzpc4r4MzAZ
	 keZ7hLXYzZsYYplDqcSmTIF2+sJ7Zh+xm0MjbS3TStl/QqXqjVUnNqgI0AUKEHoLgs
	 ZuDI+tC/zBX53HKS6Vx/HSrJbdpwJSlqAy2mk83QgQYfu9I2iFaRdz2MCQVE0G/fOn
	 tfPRtHE1Nw4iA==
Date: Sun, 10 Nov 2024 09:38:06 -1000
From: Tejun Heo <tj@kernel.org>
To: Johannes Bechberger <me@mostlynerdless.de>
Cc: Andrea Righi <arighi@nvidia.com>, Changwoo Min <multics69@gmail.com>,
	void@manifault.com, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, sched-ext@meta.com, ggherdovich@suse.com,
	dschatzberg@meta.com, yougmark94@gmail.com, changwoo@igalia.com,
	kernel-dev@igalia.com
Subject: Re: [PATCH 2/3] sched_ext: Rename scx_bpf_consume() to
 scx_bpf_dsq_move_to_local()
Message-ID: <ZzELnt99rwACjvIJ@slm.duckdns.org>
References: <20241109194853.580310-1-tj@kernel.org>
 <20241109194853.580310-3-tj@kernel.org>
 <81281555-d57f-4507-a3a5-ea9d1aa27871@gmail.com>
 <ZzCej_1NNr2wB0AD@gpd3>
 <42a6a270d7b01c02eb4d78bb408165641c6b435a@mostlynerdless.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42a6a270d7b01c02eb4d78bb408165641c6b435a@mostlynerdless.de>

Hello,

On Sun, Nov 10, 2024 at 04:09:15PM +0000, Johannes Bechberger wrote:
> Hello all,
> 
> the changes look really good and the renaming will make it much easier
> to explain what a simple scheduler does, lowering the entry barrier.

Andrea, Changwoo, Johannes, can you guys reply with Acked-by so that I can
record the consensus in the commit?

> > > * Insert @p into the vtime priority queue of the DSQ identified by @dsq_id.
> > > - * Tasks queued into the priority queue are ordered by @vtime and always
> > > - * consumed after the tasks in the FIFO queue. All other aspects are identical
> > > - * to scx_bpf_dsq_insert().
> > > + * Tasks queued into the priority queue are ordered by @vtime. All other aspects
> > > + * are identical to scx_bpf_dsq_insert().
> > >
> > > I suggest keeping this part, "and always consumed after the tasks
> > > in the FIFO queue." Otherwise, IIRC, there is no place to explain
> > > the priority between FIFO and priority DSQs explicitly.
> > >
> > I think we don't allow anymore to use the FIFO queue and the prio queue
> > at the same time. Maybe we should clarify this here and also mention
> > that we can't use scx_bpf_dsq_insert_vtime() with the built-in DSQs.
> 
> I would like to second that we clarify the differences between the built-in
> and the non-builtin DSQs.

Will add that.

> Also: Could we mention that the priority queue is stable? If I remember correctly,
> then tasks with the same priority are scheduled in a FIFO manner.

If it is, that's accidental. I don't think we want to make a guarantee about
ordering stability. It's not like that's going to make any meaningful
difference.

Thanks.

-- 
tejun

