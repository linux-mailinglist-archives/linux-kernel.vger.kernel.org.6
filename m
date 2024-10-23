Return-Path: <linux-kernel+bounces-377870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B004A9AC7DE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE3E21C2248D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69121A0721;
	Wed, 23 Oct 2024 10:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JrzRX/uQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1077519DF7A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729679149; cv=none; b=ujr0hV17NBsQfJ5+QjOsmkDjLXewVIb829Kl+quKKhCHwLszyO8bgfT/yXShK63Y0eRwi0TJsRumvxZy5q9NiMmqui84hUfDgUi7qDBjWjEd+/CgnD048O2sGrlL36qz9FsRTqQb0RRlVgd752EDS4FQeaL6ZruDd8EvmhmVUTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729679149; c=relaxed/simple;
	bh=kiad79M4J8TdoDt4GW6MFagwImU19W48hVeGANJoa0k=;
	h=Date:From:To:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=agrxLhZJfVeTX5qWo3QGuwwwPFukW/OYsL55J8zAodmoeps9iiWIUMvDKhsQarm5Y077R6qKHAshvsewYEGy9yFRXffNGE9jmSODGcByWigOAL4khlBXHmzhl0utIqmt5+4jgvuyBzsLPJlIjDnk3CGHCxUNmzhkMAFsz4J7Ja0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JrzRX/uQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46810C4CEC6;
	Wed, 23 Oct 2024 10:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729679148;
	bh=kiad79M4J8TdoDt4GW6MFagwImU19W48hVeGANJoa0k=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=JrzRX/uQs4DY6qSqFjy9adJmBOOH2YVT8Z7RggrdbwWeuWkL6Zh1dxCS9YBDREXrE
	 dj0SqIeQJsWF+OIIuvUl+gcb6JoAKj2Wj2yArNwQ0E4Ehsy69orA+4OozGv2zHbTIj
	 JmV37V4o6NL5nKdcl/fMbQJZ2JZ9mzmKObqRIRhY=
Date: Wed, 23 Oct 2024 03:25:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn
 <jannh@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Linus
 Torvalds <torvalds@linux-foundation.org>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH hotfix 6.12 0/8] fix error handling in mmap_region() and
 refactor
Message-Id: <20241023032547.1c73092187c85782bd9bd3c6@linux-foundation.org>
In-Reply-To: <20241023032236.c7a4f842b7a71c0e492bf322@linux-foundation.org>
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
	<20241023032236.c7a4f842b7a71c0e492bf322@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 03:22:36 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue, 22 Oct 2024 21:40:51 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> 
> > After this we go further, refactoring the code, placing it in mm/vma.c in
> > order to make it eventually userland testable, and significantly
> > simplifying the logic to avoid this issue arising in future.
> 
> I'm not sure that patches 4-8 are strictly 6.12 material.  What's the
> thinking here?
> 

A downside to merging all 8 patches into 6.12-rcX is that when -stable
takes patches 1-4, they will have had negligible testing without the
presence of patches 5-8.  Patches 5-8 might accidentally fix
something..

