Return-Path: <linux-kernel+bounces-404927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0EC9C4A7A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 01:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0AA6B31C02
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 00:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824E14409;
	Tue, 12 Nov 2024 00:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="nqNOw4zU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1B84C91
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 00:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731370264; cv=none; b=H2anqeZoqau6CtCINZIbWcL1BUpmd7AoymaMiTdFus2+houvWfsEPyzllxgbTIOEIiDpfnOcgSmjVSKpcLJ9InT8xtu6IW5OmJZStUj485u23qMUMGXUeRQuyzdW8dQblpDcifB26b8jCF07u8zLFZSJqaTXbs4Vlfq7IPXCEuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731370264; c=relaxed/simple;
	bh=3DPDYTaWToG+1nItkCo1KdEPJK4TtL89ZByaok+uIxs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HVtH3xC0MPNa+sSlTptcYLQivrN14vq8YzURpgyXGh3Veg3/MBEJ99CBf2TqTaRzhMzXEUIEFVeC2MIAYvMbh23kGno5TZQIFNKR+qO9SEVG+hRzU0rKD7f84x/7iyjj3TDocmZ2xsUYPgcI/pTrpyOTUPBfX5pVd9Qs4BloKko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=nqNOw4zU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32F6C4CECF;
	Tue, 12 Nov 2024 00:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1731370263;
	bh=3DPDYTaWToG+1nItkCo1KdEPJK4TtL89ZByaok+uIxs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nqNOw4zUVCIXgOu+pl5rQuZpt5FpkJg1atcHOguLCPqCWNgfv1DtA95TZc7B8JRA2
	 wAbA5LfUKnAYibKZYb+Wm3clv3LUY5/mRo1mBgKwhYiWZwFEhR/gL7FQ4q+mgsKG5I
	 CpmTIrMXyW9FWUGlMPvS5Wm/QyaFGpyXitT1qphY=
Date: Mon, 11 Nov 2024 16:11:02 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: willy@infradead.org, liam.howlett@oracle.com,
 lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz,
 hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com,
 mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com,
 oleg@redhat.com, paulmck@kernel.org, brauner@kernel.org,
 dhowells@redhat.com, hdanton@sina.com, hughd@google.com,
 minchan@google.com, jannh@google.com, shakeel.butt@linux.dev,
 souravpanda@google.com, pasha.tatashin@soleen.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 0/4] move per-vma lock into vm_area_struct
Message-Id: <20241111161102.e047bce4adfbf38002b7a9cf@linux-foundation.org>
In-Reply-To: <CAJuCfpGw1Nnh3nonDHv-UAeqTB=-3z1+hJk9Opy4X-6mbvdEhw@mail.gmail.com>
References: <20241111205506.3404479-1-surenb@google.com>
	<20241111221839.w4rqqlvvkm42jdgm@offworld>
	<CAJuCfpGw1Nnh3nonDHv-UAeqTB=-3z1+hJk9Opy4X-6mbvdEhw@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 11 Nov 2024 15:19:22 -0800 Suren Baghdasaryan <surenb@google.com> wrote:

> On Mon, Nov 11, 2024 at 2:18 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
> >
> > On Mon, 11 Nov 2024, Suren Baghdasaryan wrote:
> >
> > >To minimize memory overhead, vm_lock implementation is changed from
> > >using rw_semaphore (40 bytes) to an atomic (8 bytes) and several
> > >vm_area_struct members are moved into the last cacheline, resulting
> > >in a less fragmented structure:
> >
> > I am not a fan of building a custom lock, replacing a standard one.
> 
> Understandable.

If we're going to invent a new lock type, I'm thinking we should do
that - make it a standaline thing, add full lockdep support, etc.

I wonder if we could remove the lock from the vma altogeher and use an
old-fashioned hashed lock.  An array of locks indexed by the vma
address.  It might work well enough, although sizing the array would be
difficult.


