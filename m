Return-Path: <linux-kernel+bounces-360108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8700D999482
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 23:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27BA3284EF4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3559D1E00B6;
	Thu, 10 Oct 2024 21:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqlfepOl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B7D18DF6B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 21:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728596327; cv=none; b=VenwJWoOgnu+O44gZttYKjAQkmrJY/eDA46tj26wAGl2b6YlRW59lRuZhJHNyoKio1rqa48P4yAj8CTjEPvIbGfhuAyxx6+CXAu1OsQI+zntkkyG9Mo0QPhtjqmE/o8P1tmr3MVBjOvZZBJAsUV9C2oN9ZaIZAtCG+hkPghLyGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728596327; c=relaxed/simple;
	bh=JeJy9GlTDJOVH57I868OIvTNKeAnjK0wrrPLLz/46K4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJBZ4JCmXyzQVbmmRatQzVhbIWupU/nJY+We8HtIiGkzPiTmhqON/xoKGL5DT0lyiUyna424ZNiM4XBGiiMCZU8xmgEfAlV40tP4QjaqgyyDsyUQ34OaOkjHvPzGpb/QtM/KZ/8ef5pHRVkfs+DM18BuAOYnZeJIE+/ovWCHepQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqlfepOl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF94DC4CEC5;
	Thu, 10 Oct 2024 21:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728596327;
	bh=JeJy9GlTDJOVH57I868OIvTNKeAnjK0wrrPLLz/46K4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sqlfepOl0YsLp9avoOCisvZztiTm53OY2xyhDGC8Av7oKJFDJmwSxcWWYI5xcTAt4
	 6nHFEUOD7qjUe/qOirWocYnwzXRP99f49U+GLdEbwp1T9awUVN2mGIsncsspbw77tg
	 uacW8Ol0rg7zIkIcU2WJ7EIxBY9ucqCIeOLUZaWRFzmJ7Tln8RXdqmwUTJRI/kIuMs
	 7vFJ6DXwQF1VOkwTq9+6ZFVyykhd3lLJZCLuMOBVEhNB0orVV9axbfItvzXK81Cf9B
	 +CGhlMg6+E7EojeMNuXqYRJ75IfhCTZU8rZBjqrunUNQDKKnkdMG3RP+b/FIjDBw3+
	 05yQ8tZqBfCEg==
Date: Thu, 10 Oct 2024 11:38:45 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org, sched-ext@meta.com,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 6/6] sched_ext: Don't hold scx_tasks_lock for too long
Message-ID: <ZwhJZaXC2xKQlD3D@slm.duckdns.org>
References: <20241009214411.681233-1-tj@kernel.org>
 <20241009214411.681233-7-tj@kernel.org>
 <20241010191237.GF28209@maniforge>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010191237.GF28209@maniforge>

Hello,

On Thu, Oct 10, 2024 at 02:12:37PM -0500, David Vernet wrote:
...
> >  static struct task_struct *scx_task_iter_next(struct scx_task_iter *iter)
> >  {
> >  	struct list_head *cursor = &iter->cursor.tasks_node;
> >  	struct sched_ext_entity *pos;
> >  
> > -	lockdep_assert_held(&scx_tasks_lock);
> > +	if (!(++iter->cnt % SCX_OPS_TASK_ITER_BATCH)) {
> > +		scx_task_iter_unlock(iter);
> > +		cpu_relax();
> 
> Could you explain why we need this cpu_relax()? I thought it was only
> necessary for busy-wait loops.

I don't think we need them with the current queued spinlock implementation
but back when the spinlocks were dumb, just unlocking and relocking could
still starve out others.

cc'ing Waiman who should know a lot better than me. Waiman, what's the
current state? When releasing a spinlock to give others a chance, can we
just do unlock/lock or is cpu_relax() still useful in some cases?

Thanks.

-- 
tejun

