Return-Path: <linux-kernel+bounces-364693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6928F99D7FC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA041B20F33
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DF31CF7AE;
	Mon, 14 Oct 2024 20:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UlElNun4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618AD1ABEA7
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 20:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728936840; cv=none; b=THO/37AJI76Kd1e6RTwf5GG509/wikChw4RqgWtiR2ondWqHj2OywRvTlBnCrm/ErPyCMIcJqRY39wlDMTQKjP5Bqf0Sp2mQ8mDNipEOWeFCsqzviT3Y7KgD6REsKczAUMnejIdGIPWOONb3gGiyVj97jeZBVtgrtWPykdkVbiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728936840; c=relaxed/simple;
	bh=NST5pS34AXXGgy4PuoW2anMjNee9FdAayNuMIVaaUUY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tMKjGwRfLWCle+YzQT5Uyb5ak8laqbLnRGrI0ZwdHN8Y9Y1PUEV1vbCe1s2D9TiDvTAxeb+i/iyUJ9bPYTbxxp6TCwcxJaVYrT5DCbQZZDuy08rhw0zPOO0M8v47Dsm2N1qOoP5OOE701fK6XuWvkuvKWxWuBbHNOyqKo96neCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UlElNun4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C231CC4CEC3;
	Mon, 14 Oct 2024 20:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1728936840;
	bh=NST5pS34AXXGgy4PuoW2anMjNee9FdAayNuMIVaaUUY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UlElNun4iTHHEvsMCSVlBBLid+PiFg8Lv7bhVhLHZAlXem46/mjHbSqjoRPsiUFVb
	 42fBZ2DogvVqCDJ0r+AePkAvBGw33W1J9Vt4AMW0kfBcxm5HObvahc1SxBtveRGIMr
	 GU9VME7jI64FCBU6nZwQ8vQG0JSgk1LEGMeYE1rE=
Date: Mon, 14 Oct 2024 13:13:59 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 syzbot+fa43f1b63e3aa6f66329@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] mm: swap: prevent possible data-race in
 __try_to_reclaim_swap
Message-Id: <20241014131359.4a4046efc464a6ce1dc38a4d@linux-foundation.org>
In-Reply-To: <8C4EFDA4-A286-40C9-8F96-BD3EE07D6C45@gmail.com>
References: <CAMgjq7Ah6PjeQuR3PRyRgCpH1ybj=76cmpMfvV50D1prjZpH+w@mail.gmail.com>
	<8C4EFDA4-A286-40C9-8F96-BD3EE07D6C45@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Oct 2024 13:08:29 +0900 Jeongjun Park <aha310510@gmail.com> wrote:

> >> As far as I can see, commit 862590ac3708 was applied starting
> >> from 6.12-rc1, so it looks like no additional commits are needed
> >> for the stable version.
> > 
> > Hi, sorry for the confusion, I meant mm-stable, not the stable branch.
> > It's better to merge this in 6.12.
> 
> I agree with you. I think this vulnerability should be fixed quickly,
> so it should be applied directly to the next rc version, not the
> next tree. However, this vulnerability does not affect the stable 
> version, so I think it is appropriate to move this patch to the
> mm-hotfixes-unstable tree.
> 
> What do you think, Andrew?

I moved it into the mm-hotfixes branch for a 6.12 merge.

