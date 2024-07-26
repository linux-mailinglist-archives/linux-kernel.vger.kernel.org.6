Return-Path: <linux-kernel+bounces-263462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF0993D668
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28021283EEC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC318179950;
	Fri, 26 Jul 2024 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wifk2Ggx"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAD3134A8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 15:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722008919; cv=none; b=B0pfYDjjn5sDdVy6tBMV3lNkGoWzDhEFkV4Btr9K1iXH7joD87PGri6rUOImF3K1cfDAEkxqGUS6ISTJROs7Jsa/OX/0KZnAFoKJLybTta/w3GNXzgsEFqlOr2a8qtlH1anXobIeJ/0hNiNYu0ALm/lnA+cL8uNgvWvPIRA6kDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722008919; c=relaxed/simple;
	bh=zvZF8HfrQejz/1nRGpvJtpbFBJCy6sW8t11b31BLtko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsyP6HnTOnikpkgCMvf59ysqz1At4n/ykkzYUSfNKbLDwJcR7Rj/5Za0QKMNzrCPLRhDfHcHdxhyfISOMvSdotDdZLsxYkQ0aKlJCLQvW55jRwJOtfyHP8Nms+qfYxdMD2ZVsdyMj9LxMBpz4o3TbpfiME8Pypg7Vu5V7TSka1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wifk2Ggx; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 26 Jul 2024 08:48:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722008915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xAiY6xy1vYp9Vc1+qLGpcdiwV7rz8YuP3/AppObKDGI=;
	b=wifk2GgxWaDid6XNGUsTYPZa1z6WURX6tZpEpkZzaULvdWVlNffUIfuvnz0gb0NTdb9DAz
	+oTxgqp5oP2J/sfKsBMnIYBDV/ARnzywPd4o1z8DnskdBrz9PvpXHQQ+iUIoicY3wgZlbP
	U5zLMIKIIwktVO1i09fXxkdHIFywSjI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Greg Thelen <gthelen@google.com>, Facebook Kernel Team <kernel-team@meta.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] memcg: expose children memory usage for root
Message-ID: <lhlfj2keag2ciurt7v76d4nhyk5k5czrkvuocbgxkeep6zgwgo@ifjthvn5osvr>
References: <20240722225306.1494878-1-shakeel.butt@linux.dev>
 <CAJD7tkaR3s6fzRZWdvMvfSRBRaozSj7d2pH5HUjtbuOW+RROFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkaR3s6fzRZWdvMvfSRBRaozSj7d2pH5HUjtbuOW+RROFA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jul 25, 2024 at 04:20:45PM GMT, Yosry Ahmed wrote:
> On Mon, Jul 22, 2024 at 3:53 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > Linux kernel does not expose memory.current on the root memcg and there
> > are applications which have to traverse all the top level memcgs to
> > calculate the total memory charged in the system. This is more expensive
> > (directory traversal and multiple open and reads) and is racy on a busy
> > machine. As the kernel already have the needed information i.e. root's
> > memory.current, why not expose that?
> >
> > However root's memory.current will have a different semantics than the
> > non-root's memory.current as the kernel skips the charging for root, so
> > maybe it is better to have a different named interface for the root.
> > Something like memory.children_usage only for root memcg.
> >
> > Now there is still a question that why the kernel does not expose
> > memory.current for the root. The historical reason was that the memcg
> > charging was expensice and to provide the users to bypass the memcg
> > charging by letting them run in the root. However do we still want to
> > have this exception today? What is stopping us to start charging the
> > root memcg as well. Of course the root will not have limits but the
> > allocations will go through memcg charging and then the memory.current
> > of root and non-root will have the same semantics.
> >
> > This is an RFC to start a discussion on memcg charging for root.
> 
> I vaguely remember when running some netperf tests (tcp_rr?) in a
> cgroup that the performance decreases considerably with every level
> down the hierarchy. I am assuming that charging was a part of the
> reason. If that's the case, charging the root will be similar to
> moving all workloads one level down the hierarchy in terms of charging
> overhead.

No, the workloads running in non-root memcgs will not see any
difference. Only the workloads running in root will see charging
overhead.


