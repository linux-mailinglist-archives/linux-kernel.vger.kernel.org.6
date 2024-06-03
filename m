Return-Path: <linux-kernel+bounces-199635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D06718D8A06
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 21:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835121F25B09
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055671386B9;
	Mon,  3 Jun 2024 19:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cGwbRZmi"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE0F23A0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 19:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717442588; cv=none; b=nCLKqd9msNU6WG4ROwPgC5vCEYAKOjloqLgS7TIK/1GjaTQBuLRnkfTSjp/lIRJKcv/6G4XKJfvoj1+2jYEm1hk58D1EY7pSPHbEzpH07GLLB184bTuog2qQJ1lr9Bwv2SBog5uR7dc3+8hktMcmMLUttBM6GGR9jOamT5XTuFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717442588; c=relaxed/simple;
	bh=tCD7rk+TtcL9XJe2ohfT59ATEbHKkJKQ9F/BSCYgZhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6n50ETmTnAO6/C70iOyGdWhrMzu2oXa4/Db+Q6yPPPEmikSRdlvGvf3UhjY4rA3vxs916xHzaaQfiiGqbA4gdA+o6RXAomHm292b8nPiIcsj/JcDC4gS1h6S1IUxzlZjpw9BtQ6OOvW+x66xPJMkmAzIHKPLIsRqKyCymGqbqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cGwbRZmi; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: arch0.zheng@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717442583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=noF10pCDRK/dJImm3NQkYvsew29diU58F+L0dfPmzEw=;
	b=cGwbRZmiF4OqO07Knc0n/bOwCeAVfxMqx+CVF1plc7U8qsxiPIrkLpulsp9CqQyIZEUU1h
	KzVM/scchz7En6X6FFcMKhzoUQmnuxzyZu9tUpnSM4P6RJSSHLgf6t6ZaWVEx3asFqGZly
	DlUitqiCtE19n83YFN7IIfxMEU16i7I=
X-Envelope-To: syzbot+981b8efffb3d71c46bef@syzkaller.appspotmail.com
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: david@fromorbit.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: syzkaller-bugs@googlegroups.com
X-Envelope-To: zhengqi.arch@bytedance.com
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: hannes@cmpxchg.org
Date: Mon, 3 Jun 2024 12:22:57 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Qi Zheng <arch0.zheng@gmail.com>
Cc: syzbot <syzbot+981b8efffb3d71c46bef@syzkaller.appspotmail.com>,
	akpm@linux-foundation.org, david@fromorbit.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	muchun.song@linux.dev, syzkaller-bugs@googlegroups.com,
	zhengqi.arch@bytedance.com, shakeel.butt@linux.dev,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [syzbot] [mm?] UBSAN: shift-out-of-bounds in do_shrink_slab
Message-ID: <Zl4YEc01cnknfZTu@P9FQF9L96D>
References: <0000000000003051770619cec4f8@google.com>
 <9a7718e0-e30b-4b87-a0ed-dfcea389eaed@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a7718e0-e30b-4b87-a0ed-dfcea389eaed@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 03, 2024 at 11:25:42AM +0800, Qi Zheng wrote:
> Hi,
> 
> I think this bug was introduced by commit 6be5e186fd65
> ("mm: vmscan: restore incremental cgroup iteration"), and
> can be fixed by commit 9c8805439853 ("mm: vmscan: reset sc->priority on
> retry").

I'm almost sure it's the same issue.

Thanks

