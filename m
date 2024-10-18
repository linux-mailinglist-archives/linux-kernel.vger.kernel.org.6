Return-Path: <linux-kernel+bounces-370745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA179A318A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 02:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 197451C22E8A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 00:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123624685;
	Fri, 18 Oct 2024 00:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bX2U+rWH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C8310E4
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 00:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729209635; cv=none; b=qEgdF/b4B2xf4o7rgMcToiVhqwiEhIYFdemSa3gV87/vqwTzYrBP31zu9T4PWLZfsMX9MwwGIIa2L4XDoT/UOhZFaTGox/QtElspVXZ7GfgnKcq7rh0i5hFk5ZectyvdTgFo/xtyK22D3Z6xfcsLyiP9aUlfjKigaNBozEY/F7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729209635; c=relaxed/simple;
	bh=jEidQ8huvNa9jQ91Lz9Wd5W27GjtDkgEz2PDNCEUFaM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZzhvMKxf0wjIJ/F/Zm0c8PABVwyOEsP4a/b7gqu/EAFT0y3HGpH0lKmTx0EWXfcEfeaeQ9GPT807y7vr921XivXk15YvvLsjXvzvlx0ABHLfJBIwRrAo/VI23MXTIYkjTFHP9gJiNvVO5hYLVSTPUMGajAvOH0jsZ1SVx/YuWPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bX2U+rWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E39C4CEC3;
	Fri, 18 Oct 2024 00:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729209634;
	bh=jEidQ8huvNa9jQ91Lz9Wd5W27GjtDkgEz2PDNCEUFaM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bX2U+rWHpPrtvU7/m9OOQsqcSOUNtubDWRj/B7F9ms2Mf/qmtdqFGFAaAhJZGRgvm
	 3DIah/y9Qwcz0OX+mJI5V9P8k51jzmIZQrklR5DgABaau4WZoI4QCX+x3EhyuwvzYp
	 vIvhNeBrTIC2SMnXgTkhrGTQVfRJHf1B+LlJJz90=
Date: Thu, 17 Oct 2024 17:00:33 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Jeff Xu <jeffxu@chromium.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Jann Horn <jannh@google.com>, David Hildenbrand <david@redhat.com>, Qi
 Zheng <zhengqi.arch@bytedance.com>, Kefeng Wang
 <wangkefeng.wang@huawei.com>, Pedro Falcato <pedro.falcato@gmail.com>
Subject: Re: [PATCH 1/2] mm/mremap: Clean up vma_to_resize()
Message-Id: <20241017170033.6bac2c50f609f6c63c861783@linux-foundation.org>
In-Reply-To: <hwz7y3jqi7ynxwtqzisrlo3zrdkdwlfb45nb4nixjcontpiry6@mdtki5al2no5>
References: <20241016201719.2449143-1-Liam.Howlett@oracle.com>
	<20241016201719.2449143-2-Liam.Howlett@oracle.com>
	<CABi2SkWhgY4amyT+EGTma7a9ymPs7ArnFLkAnm5ko556DpC_Cg@mail.gmail.com>
	<4izjonpaqhkx6p3csfyxcjicgqahbmj2k6gupazehb3l7xhnvi@twlvpx2wc6ce>
	<CABi2SkW1Au3WZ6Qem=FppOFBGRn3GDJo5+U3yXpk2brK9MR8NQ@mail.gmail.com>
	<20241017140813.fe555ec947b17dd035e4c0d7@linux-foundation.org>
	<hwz7y3jqi7ynxwtqzisrlo3zrdkdwlfb45nb4nixjcontpiry6@mdtki5al2no5>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Oct 2024 19:53:10 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:

> > eg, "check_the_cheese()" versus "cheese_is_fresh()".  The latter name
> > tells you what is being checked and it tells you what a "true" return
> > value means.
> 
> Fair enough, how about resize_is_valid()?

Sounds great.  Although I do prefer cheese_is_fresh().

