Return-Path: <linux-kernel+bounces-248150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DFE92D8EF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06A301C2169A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC7D197A8B;
	Wed, 10 Jul 2024 19:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O7z3T8A3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037D78F66;
	Wed, 10 Jul 2024 19:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720639084; cv=none; b=Xp4nP0/ePeSQ7sB6Ymp5iqRx6aJ4o5R7NHfHh8X6Sj22mjcoEdi1l6RM6DKOSlLNM76c5x6dIQ1Iwa6y2qC3ZwKoSE+vv92Dl0gTU+WbMKJjct6Ic2PkrgGgP1ri7N1idhn2MGsyrroFiryNYqM0udBtjEJdz3ZEBK7QGGyNpjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720639084; c=relaxed/simple;
	bh=0ihz+DlqmEqKVS2DD/pDgRVbl8B31X8U8rySSkNJDMc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mpazpTYnR/aOeKWVtT6oWve4wScQLI8QeRSXF3hZV7lmwhqDUhrSGRlAySfc5BBdVz5LCDXTHK2vyY+cYUG0loJgO00R9ZKpZblRzIMhMwuytY6PkrJ4q2OGCwETXHKaLHKyLMZavqMMvc8OrS3/k7PQuGZMRkoxL6ac2PNq0kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=O7z3T8A3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0509CC32781;
	Wed, 10 Jul 2024 19:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720639083;
	bh=0ihz+DlqmEqKVS2DD/pDgRVbl8B31X8U8rySSkNJDMc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O7z3T8A3B4GolCybuptbj0cLCJONrz5UiiL1xZtL6EPax5CBzOyux7F3adKZtBxS3
	 /03+1jmomwoyqNbAB0nT677cKCtcgKIy0+OKzxu6YsjhGHprpUrFNK26wr1hLzCVpC
	 rTLXpJ6r0XxJTzpfur+kEr50SDe70f+lMmesTQHg=
Date: Wed, 10 Jul 2024 12:18:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hugh Dickins <hughd@google.com>
Cc: Usama Arif <usamaarif642@gmail.com>, kernel test robot
 <oliver.sang@intel.com>, Johannes Weiner <hannes@cmpxchg.org>,
 oe-lkp@lists.linux.dev, lkp@intel.com, Linux Memory Management List
 <linux-mm@kvack.org>, Chengming Zhou <chengming.zhou@linux.dev>, Yosry
 Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, David
 Hildenbrand <david@redhat.com>, "Huang, Ying" <ying.huang@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Shakeel Butt
 <shakeel.butt@linux.dev>, Andi Kleen <ak@linux.intel.com>,
 linux-kernel@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [linux-next:master] [mm] 47325a5c88:
 WARNING:at_mm/slub.c:#free_large_kmalloc
Message-Id: <20240710121802.e1445448d94b3f6ea16fdd12@linux-foundation.org>
In-Reply-To: <612af749-0a59-f91d-693a-43d6217ffebb@google.com>
References: <202407101031.c6c3c651-lkp@intel.com>
	<dd08adbb-6df5-4556-9fc4-cf37b6234aa1@gmail.com>
	<053bd429-ae19-4beb-a733-a7a838b1e010@gmail.com>
	<4bc6400e-6199-4147-9399-4a54c94613fd@gmail.com>
	<612af749-0a59-f91d-693a-43d6217ffebb@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jul 2024 11:49:09 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:

> It's a long time since I was active hereabouts, but the bot report
> and your flurry of updates make me think that you should step back,
> slow down, and look more carefully at the precedents here.
> 
> IIRC, the main problem is that parts of the swap_info_struct can
> still be in use from before while you're wanting to set up new values.
> Observe how alloc_swap_info() may return a fresh or an old allocation.
> Observe how enable_swap_info() is called after getting swapon_mutex
> late in swapon(), once past all possiblities of error.
> 
> I expect that your new zeromap needs to be taking the same care as is
> taken with swap_map and cluster_info: to be safe, follow their example
> in both swapon() and swapoff().

Thanks.  I've dropped the series "mm: store zero pages to be swapped
out in a bitmap" from mm-stable.  Let's revisit in the next -rc cycle.

