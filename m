Return-Path: <linux-kernel+bounces-231730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0DC919CF7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 03:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B032B1C21C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 01:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89B4291E;
	Thu, 27 Jun 2024 01:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PPKdZfSq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DC7360
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 01:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719451693; cv=none; b=g26SH6QOsSvHSjpifG/Nr1NallhouWmymLCeZHx3eXeGN0EWVPIR6dQDdjXESGBBCSsdALViHxxd7rqmfXtwRIg1Wx6l38fg3nQEoLI0dVrOFoKWwWlXSgEfONKUhruvaECeiQ2VovDKlUQ+SZTChrAAl0YBscpYM9GQ/tW8AbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719451693; c=relaxed/simple;
	bh=94WKLEImDrzuXsLyEWQzT3QrnoLJARKqK7LpjuSesRY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RxQnkd8KdyrNvv7vtT7LSghsGzsheTgWG/qnEmdoavL5+Yp2fPY6Ba5P8wVzhWYlJ8+Z+5Cha6rLZXCPzASVgFRvCT8auTFrgrXZ/ZpEAZA1BzWRICpKR19eWbnNyKHnsWjaNmkPl/EBD3IiXMIWCk5MP2OzmeyIgeAzRPF4xg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PPKdZfSq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664A2C116B1;
	Thu, 27 Jun 2024 01:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719451692;
	bh=94WKLEImDrzuXsLyEWQzT3QrnoLJARKqK7LpjuSesRY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PPKdZfSqtTVbDrXkByiPv/el1lO3mxTUNt5c8JDwKRLgJDC8iyIaDrGNs00riNqRc
	 PF1PxG8R1rJjIgIHvQHf0ACrHsNc/H6wOIS17KLilbGJ2iMdToOmT1U5cBRUDmvOdy
	 yFe0jHykClsuJsX85/2etR5/YbLJnp9FlzyN1op8=
Date: Wed, 26 Jun 2024 18:28:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>, Vlastimil
 Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>, Matthew
 Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
 "Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki
 <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
 linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2 00/15] Avoid MAP_FIXED gap exposure
Message-Id: <20240626182811.fa717f7b1051a35af72cebfa@linux-foundation.org>
In-Reply-To: <nlq44eay3zjapg23tjprukm7w2ae6qcy5xtc5xsxogsmd52lwu@fhfzf4l6777u>
References: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
	<20240626135855.a4b64612a9104ff163e30bd7@linux-foundation.org>
	<nlq44eay3zjapg23tjprukm7w2ae6qcy5xtc5xsxogsmd52lwu@fhfzf4l6777u>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jun 2024 21:15:18 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:

> * Andrew Morton <akpm@linux-foundation.org> [240626 16:59]:
> > On Tue, 25 Jun 2024 15:11:30 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
> > 
> > > It is now possible to walk the vma tree using the rcu read locks and is
> > > beneficial to do so to reduce lock contention.  Doing so while a
> > > MAP_FIXED mapping is executing means that a reader may see a gap in the
> > > vma tree that should never logically exist - and does not when using the
> > > mmap lock in read mode.  The temporal gap exists because mmap_region()
> > > calls munmap() prior to installing the new mapping.
> > 
> > What are the consequences when this race hits?  IOW, why do we need to
> > change anything?
> > 
> 
> In the (near) future, we want to walk the vma tree to produce
> /proc/<pid>/maps.  Without this change we will see the temporal gap and
> expose it to the user.  This series was initially sent to Suren as part
> of his patch set.
> 
> We also have the new interface for an ioctl request to a vma at or above
> an address. I had highlighted that an rcu reader would be ideal, but
> proved too difficult at this time. These patches by Andrii are currently
> not using the rcu reading method as this and a per-vma locking
> clarification are needed.
> 
> Since there were two users for this code, I decided to send it out
> before the other patches.

OK, thanks.  We're approaching -rc6 and things are a bit sketchy so I'm
inclined to hold this off until the next cycle, unless there's urgency?

