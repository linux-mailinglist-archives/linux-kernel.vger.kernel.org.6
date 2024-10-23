Return-Path: <linux-kernel+bounces-377858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D06C19AC7BA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7853F1F26639
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC2D1AAE1B;
	Wed, 23 Oct 2024 10:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CIuvvN1r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BAD1A256F
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 10:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729678959; cv=none; b=OgNyG8eoejseWcjN38YjO9K3F1k0NVM8PfZwbqNatnaG5xG86yMG/vXcPsUDctbEGQWISobotzga29Y5ieS8VzHIyMiSQ7Yv0PllQqzyCsawJe6gygygbMZXpG6TJ4S8zNkFt94VUqt8OjP6FVjXM+MvUwmxsj2jSSKHzZSt3Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729678959; c=relaxed/simple;
	bh=tpjKaHdslkPtm9FgDU3BjVq0XiBAYIX76eHEAHRlW3I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qDuX8te70iy+Noyt/hrlXLuOObz9ryFtRCVYHax2mCqvtOMKf6XHaS14XBY9aL4SoGfJfWnbK5mXxUYlM7/KSpt2kqQg69SjteenjWCR+gzqVmVyZlVvheb6RcO1FU8mDeESpR8gfWX3SYMQ8v09RxHTjYeVZOZMM1cp87xcpsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CIuvvN1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584ACC4CEC6;
	Wed, 23 Oct 2024 10:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729678957;
	bh=tpjKaHdslkPtm9FgDU3BjVq0XiBAYIX76eHEAHRlW3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CIuvvN1rdGu0Qs0L2e3yLCh9A0hMnauAwhQ9PGhGo+/MLat/rFMTsAnEQRLNjYwI7
	 bD/CTbneFr4Lr7Epl9WM0tfLd9t3tlulXt1TWxxE6GB8x930GPp7tqgv31R1oGgAN0
	 S6Ws6eOpeH2bWGTg+DbntfbGFPBgvO/6Y6yoz0TQ=
Date: Wed, 23 Oct 2024 03:22:36 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH hotfix 6.12 0/8] fix error handling in mmap_region() and
 refactor
Message-Id: <20241023032236.c7a4f842b7a71c0e492bf322@linux-foundation.org>
In-Reply-To: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Oct 2024 21:40:51 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> After this we go further, refactoring the code, placing it in mm/vma.c in
> order to make it eventually userland testable, and significantly
> simplifying the logic to avoid this issue arising in future.

I'm not sure that patches 4-8 are strictly 6.12 material.  What's the
thinking here?


