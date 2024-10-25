Return-Path: <linux-kernel+bounces-381486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACE69AFFC6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCCE91F250D2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9C11D9A5B;
	Fri, 25 Oct 2024 10:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m6oT/a3Z"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BEF1C4A11
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729851063; cv=none; b=Zf1BtXMpnFSekxDpzs3xcYKjbwdJNpowyta0sRfQNFlRegduC56TB3S4zZ2PhjHHFMLReO8Eub0xPvw2K8aygOj1H+w8eMPgX66v5dRxYL+04KlKJTXnN01f2FlmakiJDAttFnLfenePkNdCYCu1Gg0HrL9A0aASlp6Cr4fBvZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729851063; c=relaxed/simple;
	bh=SlWWHWLUugzYHC55S7opnDUI0SDEAEwNmq9HBEKKbG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvT6AKh9whasMrKgUWY/WF9clwsicA3vb5LcVyFzgDDRS1g/VZstvU4atZ7K0bRvLVpo2JsB4khlzcfw9LZiGNuyccBGYaVEAGg9krYbLmGG780zb9dLJmdo06g5M2vkdPK/HzdyDoMLTRCEZUby6zuXPwbYnG8aYH2nzb5E8QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m6oT/a3Z; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3XgS1GVZDmFAqc6Ozj8d+BNi6qUBiw1WxaqxsT8sPa0=; b=m6oT/a3ZnweEHEGa+DJ7NhvBul
	gUxCrLEHN4hDnjKdAJl9MnvC2RNaXSHVogCXioA1iM8phCmbLbgDOHzoY4O2vdX45ymDAxdCQCazG
	nJw+jBm0gqz29naGO6Nfo02qTHCTjSNj7/c+ZJLmpbN2AQ/I+TgPTwizIiOBz1gh25rB8ugYJTq7v
	hyzF+/FZG/B8cy70gVJ3bCwzS4lG0F5H6GoNcT4Bd+eq4Qyo71DWYK89KUFlc2QmtQ5OfwTWT9gt+
	prxeSQ5nPkugwnzWzJ6qZk3elBr4Qv/hf3SZjyODOLXsg3s1whzLT4+Y4ecOHUs19dCNy6hh6iX4k
	SZ7F3YnA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t4HHW-0000000561P-0kgU;
	Fri, 25 Oct 2024 10:10:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2682130083E; Fri, 25 Oct 2024 12:10:58 +0200 (CEST)
Date: Fri, 25 Oct 2024 12:10:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] sched/uclamp: Fix unnused variable warning
Message-ID: <20241025101058.GK14555@noisy.programming.kicks-ass.net>
References: <b2ad1f31-21b9-42a5-a735-b9496470348a@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2ad1f31-21b9-42a5-a735-b9496470348a@arm.com>

On Tue, Oct 08, 2024 at 09:23:18AM +0100, Christian Loehle wrote:
> uclamp_mutex is only used for CONFIG_SYSCTL or
> CONFIG_UCLAMP_TASK_GROUP so ifdef that to fix the compile-time warning.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410060258.bPl2ZoUo-lkp@intel.com/
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  kernel/sched/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 43e453ab7e20..18d9622eac8d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1394,7 +1394,9 @@ void set_load_weight(struct task_struct *p, bool update_load)
>   * requests are serialized using a mutex to reduce the risk of conflicting
>   * updates or API abuses.
>   */
> +#if defined(CONFIG_UCLAMP_TASK_GROUP) || defined(CONFIG_SYSCTL)
>  static DEFINE_MUTEX(uclamp_mutex);
> +#endif
>  
>  /* Max allowed minimum utilization */
>  static unsigned int __maybe_unused sysctl_sched_uclamp_util_min = SCHED_CAPACITY_SCALE;
> -- 
> 2.34.1

Bah, too much email :/ But also,

  https://lkml.kernel.org/r/20241025073213.GE36494@noisy.programming.kicks-ass.net

where I said:

"sigh.. I hate our CONFIG space :/

Perhaps add __maybe_unused like the other variables it sits right next
to instead of adding yet more #ifdef crud?"



