Return-Path: <linux-kernel+bounces-437265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425DD9E9104
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3FC8280E95
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BFC2165F6;
	Mon,  9 Dec 2024 10:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KJYKtAgN"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87BD130AC8
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741723; cv=none; b=iButvET7EQoHx9acvvoYW3Q4ZPS7XUYiv6alNS24WNtybhoGq88S3LD9qxEZLBshqqNGhdW+4E9S5xN4ja1LCsP3wgzb6tniX9cupQnfS0ZeaTZ74L/1EgqCpHn8gBqcTS+S+UW2UmsjpeEc+krkUnVHFkxRST98GHquZmDjg4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741723; c=relaxed/simple;
	bh=cTzwRwB0TyD+Ekx4nihwDBuxIdGU2s+AtsO5C2FVJrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/fJecnFX+K1Wr95ftqRLI9EcS4qPNkP7/IVfKs2PdktChi6G+IdKHVCiwzjIqZCTisTWRec7LoSyekzU3XHZzSb0DrlXml9huU8WerbSN0dfoIDUuZ9Q1Lze6pTS9toP1TsBmKJbyLXgkeY9jCH57vrZ+8BNsPRCKmu+lvEotM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KJYKtAgN; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=khqLakZnXrmLWajDW0xGtT9CGiA5uggq6975+xLFSmE=; b=KJYKtAgNOpjTYN8pxUCCmMBxeu
	jYbdhJH6H1VNpJ2mbJgViY0ma6V9hrYPXVWSQgwwkjz3LSz9dq2i02OSkJbejCTVXUV7yZw/3y5nf
	3aXCzGnhpkSSwSLWd9wyzUm7x16Ta+pmCMLKwD/eu3vBxt0pevmZNXqnMvadPCDKGPsARPIcf+oLH
	857oAYkyONuS+SK8qDedlwq4bnlzGhTkUiOn854UNiqSjU6/mM3ZPbnRmTBurk38aopOM72UYcIiX
	VTDQ6k2+wzCjPCXOsCaAo2RRgzD6iVQXXH+MtyMRba1+xp+e/c/8wWo16WZiGz3Q+++Omui5e3ckV
	NbTi+e+g==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tKbQ3-00000003WkK-2ZSo;
	Mon, 09 Dec 2024 10:55:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8B9FA3003FF; Mon,  9 Dec 2024 11:55:14 +0100 (CET)
Date: Mon, 9 Dec 2024 11:55:14 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Cc: Joel Fernandes <joel@joelfernandes.org>,
	Ilya Maximets <i.maximets@ovn.org>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, vineethrp@google.com,
	shraash@google.com
Subject: Re: [v6.12] WARNING: at kernel/sched/deadline.c:1995
 enqueue_dl_entity (task blocked for more than 28262 seconds)
Message-ID: <20241209105514.GK21636@noisy.programming.kicks-ass.net>
References: <571b2045-320d-4ac2-95db-1423d0277613@ovn.org>
 <20241206151819.GA3949140@google.com>
 <CAO7JXPhdv+Jx_UpAq=-aG-BKwiyjZ2kvuZDM4+GLjbya_=ZJsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO7JXPhdv+Jx_UpAq=-aG-BKwiyjZ2kvuZDM4+GLjbya_=ZJsw@mail.gmail.com>

On Fri, Dec 06, 2024 at 11:57:30AM -0500, Vineeth Remanan Pillai wrote:

> I was able to reproduce this WARN_ON couple of days back with
> syzkaller. dlserver's dl_se gets enqueued during a update_curr while
> the dlserver is stopped. And subsequent dlserver start will cause a
> double enqueue. 

Right, I spotted that hole late last week. There is this thread:

  https://lore.kernel.org/all/20241209094941.GF21636@noisy.programming.kicks-ass.net/T/#u

Where I just added this thunk:

  @@ -1674,6 +1679,12 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 
 void dl_server_stop(struct sched_dl_entity *dl_se)
 {
+	if (current->dl_server == dl_se) {
+		struct rq *rq = rq_of_dl_se(dl_se);
+		trace_printk("stop fair server %d\n", cpu_of(rq));
+		current->dl_server = NULL;
+	}
+
 	if (!dl_se->dl_runtime)
 		return;
 
Which was my attempt at plugging said hole. But since I do not have
means of reproduction, I'm not at all sure it is sufficient :/


