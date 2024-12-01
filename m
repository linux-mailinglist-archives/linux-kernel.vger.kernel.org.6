Return-Path: <linux-kernel+bounces-426554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DA79DF4E3
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 08:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37DF162DBA
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 06:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F34F5473C;
	Sun,  1 Dec 2024 06:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="nca0ZPjl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A4F29CE6
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 06:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733036394; cv=none; b=TndN9O6ldNaQlUL8nKs/4K2avtJI8nYBQVamzfJosLvvQS6fEwND+DVZeejvdXkqPGCdWEAINPkK+SxBPKs8gfDbg5FwmotQPgKbME/qPjWzE0VULGTe7jsye6Lr2w/F9HjNKgVwb8U3G1BCIcdTsRD0Y/B3norYfbIy3Bj67dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733036394; c=relaxed/simple;
	bh=gYLJdRFK4oBa/CZ9J3uxe9m9yhUdD2Er/DAuyttmBGk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Yq7q/1VK0CFgheV4gChNUtUSNr7cYvFGngyuoBUlouEObYxquqPYuI6FDn+o7WZj8eHLb7I0wJdMstdtLpwcdNnGEJ8PRxAmOd3tnQhFrJOYiXoJ5bPeW1qNxq6FNypvSmvNXYaIqnqQrK7WFLYVZ7GKmjYdv8nWOt5V1+7ujAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=nca0ZPjl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31BBC4CECF;
	Sun,  1 Dec 2024 06:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1733036394;
	bh=gYLJdRFK4oBa/CZ9J3uxe9m9yhUdD2Er/DAuyttmBGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nca0ZPjl9wwSpanyfQgFWWkyXkWFnXDJFtEpy4gwA45jLjRcbrdnkfr3vsTexIrpi
	 B8+YbZnbXRk30JjnB3RtEyvSd7WSwzvPvJ8JxmBfK9gWRLM0tx88nohS/SxlK2/r57
	 EQU8v6CMeha6U2jC+xZYQST/eQadpg1bwp52fdD8=
Date: Sat, 30 Nov 2024 22:59:53 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: David Hildenbrand <david@redhat.com>, <nao.horiguchi@gmail.com>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/memory-failure: fix
 VM_BUG_ON_PAGE(PagePoisoned(page)) when unpoison memory
Message-Id: <20241130225953.dbb95dbf5f6c785e931f45f7@linux-foundation.org>
In-Reply-To: <0519bf4b-49aa-6b81-a041-362a171b2a5e@huawei.com>
References: <20240712064249.3882707-1-linmiaohe@huawei.com>
	<20240712140921.9aa90b18d22e67417d59dfc1@linux-foundation.org>
	<8fe349f9-d3d3-65ab-6045-da0bd19249ea@huawei.com>
	<00e18339-d911-4332-8732-e31bcecbf823@redhat.com>
	<5f8107e2-2b37-d899-f7f2-5a6093d8b089@huawei.com>
	<de73f251-08a0-4122-acfd-1d7fce7540ea@redhat.com>
	<ec6ed1aa-0b6e-df66-1442-93786eabd1ef@huawei.com>
	<dded1b96-8ff3-489a-a92e-b206829feb85@redhat.com>
	<f3aa7133-5754-73f4-9ee1-bff1a8637c07@huawei.com>
	<a4078c71-acf2-4652-92cb-fb9356703dc6@redhat.com>
	<0519bf4b-49aa-6b81-a041-362a171b2a5e@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Aug 2024 14:25:14 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> >>>> Yup, this will be a good alternative. But will it be better to simply check PagePoisoned() instead?
> >>>
> >>> The memmap of offline memory sections shall not be touched, so .... don't touch it ;)
> >>>
> >>> Especially because that PagePoisoned() check is non-sensical without poisoining-during-memmap-init. You would still work with memory in offline sections.
> >>>
> >>> I think the code is even wrong in that regard: we allow for memory offlining to work with HWPoisoned pages, see __offline_isolated_pages(). Staring at unpoison_memory(), we might be putting these pages back to the buddy? Which is completely wrong.
> >>
> >> I agree with you. Thanks for detailed explanation. :)
> >> Thanks David.
> > 
> > So ... I assume there will be a new patch? :)
> 
> I was just back from my two-weeks holidays. ;) I will try to send a new version when possible.

Maybe I missed the v2.  I'll drop this v1 patch.

