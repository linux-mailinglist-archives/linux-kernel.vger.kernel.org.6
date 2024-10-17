Return-Path: <linux-kernel+bounces-370590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6330D9A2F48
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18CA92848B0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CA61EE008;
	Thu, 17 Oct 2024 21:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Rlo0+Rhz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE141EE002
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 21:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729199295; cv=none; b=T2Cqsarbchq/0kgarRbEp9RaCDbUTvQloqbbmXv02BME4rMe1IRXhjhQa43m4nRbJo3c4Dt0sqCFfxcw5bfWVOeNKgDWeQWlHFB/LOH3/C7jpHKau0yXJqEpZbjAkwAZiHbj5FKYMoTfTlz+Ymmvd/qioaoEzqY7+T0lIw19/I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729199295; c=relaxed/simple;
	bh=ZuuN+2bvokfFHmLl4MuEabN0US1Th7GC0dpGBGVvyio=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TRMGrxhjBn7RFeqVYS31lwXoieODHbWdEGV84wXOq9Rf2scLl+VGCFFoo068wrbUtPijH+0qEtyjpRKAirFtnPQxM0XpX6UvKo0F2BgYJz7xTUvfybZ2cBCTyKDxuWMDiTFvcddgeWdQElVeFrgvJnuIyZE7eaMq/7bBK1IQiZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Rlo0+Rhz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD27C4CEC3;
	Thu, 17 Oct 2024 21:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729199294;
	bh=ZuuN+2bvokfFHmLl4MuEabN0US1Th7GC0dpGBGVvyio=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rlo0+RhzRlEBqivcUdgCxS+YHhstPpDiza/dZOS+DHsDH9S6tml3AjfiTNapUT0LD
	 dl8T7ugnXrduJzjjqHXncSkh03bKoxEpmxdFAH/V7mG4nNjLsfWDl+UzX6IYGUhfzl
	 kadt9pG0ClTio+RuG4cf8vNNCcYVpDQhgy/SDfoM=
Date: Thu, 17 Oct 2024 14:08:13 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jeff Xu <jeffxu@chromium.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Jann Horn <jannh@google.com>, David Hildenbrand <david@redhat.com>, Qi
 Zheng <zhengqi.arch@bytedance.com>, Kefeng Wang
 <wangkefeng.wang@huawei.com>, Pedro Falcato <pedro.falcato@gmail.com>
Subject: Re: [PATCH 1/2] mm/mremap: Clean up vma_to_resize()
Message-Id: <20241017140813.fe555ec947b17dd035e4c0d7@linux-foundation.org>
In-Reply-To: <CABi2SkW1Au3WZ6Qem=FppOFBGRn3GDJo5+U3yXpk2brK9MR8NQ@mail.gmail.com>
References: <20241016201719.2449143-1-Liam.Howlett@oracle.com>
	<20241016201719.2449143-2-Liam.Howlett@oracle.com>
	<CABi2SkWhgY4amyT+EGTma7a9ymPs7ArnFLkAnm5ko556DpC_Cg@mail.gmail.com>
	<4izjonpaqhkx6p3csfyxcjicgqahbmj2k6gupazehb3l7xhnvi@twlvpx2wc6ce>
	<CABi2SkW1Au3WZ6Qem=FppOFBGRn3GDJo5+U3yXpk2brK9MR8NQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Oct 2024 11:15:20 -0700 Jeff Xu <jeffxu@chromium.org> wrote:

> > > > -static struct vm_area_struct *vma_to_resize(unsigned long addr,
> > > > +static int mremap_vma_check(struct vm_area_struct *vma, unsigned long addr,
> > > The original function is vma_to_resize, and mremap_vma_check is
> > > missing this context.
> > > Maybe mremap_vma_check_resize is a better name ?
> >
> > Good point.  That suggestion is long though.  Perhaps
> > vma_check_resize(), since this is a static function in the mremap.c
> > file, it is fine to drop mremap from the name.
> >
> I'm ok with that.

Any function with "check" in the name makes my teeth ache.  "check"
what?  And the name doesn't carry any connotation of the return value's
meaning.

eg, "check_the_cheese()" versus "cheese_is_fresh()".  The latter name
tells you what is being checked and it tells you what a "true" return
value means.

Also, the dang function isn't documented.

Also, why is mremap_to() calling mremap_vma_check() without testing its
return value?  mremap_vma_check() doesn't actually alter anything, does
it?  If it does then it's misnamed.

