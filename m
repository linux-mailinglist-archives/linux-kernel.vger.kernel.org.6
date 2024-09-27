Return-Path: <linux-kernel+bounces-342170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A894988B32
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 22:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5A7EB20D86
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 20:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AB91C2329;
	Fri, 27 Sep 2024 20:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GA8o9RAP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A643218B
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 20:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727468747; cv=none; b=hek7QWxnUv4wgWrnAFIiPXVmLEUmEc6q/rlGXgAuUowuMnPiOnKEWiU+Xy1sa6ctC3vd0pACZuMI6ZvlBqOM6DeJYAK4LcLF1KWlTbHUspM0gdM6w0g8BhK4uyuPBohrp2kgIz4e0BKfPdULJCKmciU+naLiafN/GE2rd8O2PyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727468747; c=relaxed/simple;
	bh=BG0B2w8fDi3QD240E8yq4sTf5sjlGj8jOW8AvD6K3CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqGhLajJ+KGcjuE3Vb8w/+TZlKpCQiEBe9zqf6ynTaZ/wlyOGx89JrzEiYPE1GYfjPJhmzM/qXsd11PGhF8s5zmUcBqPkk3m+P+z6C3XBZgt5uFPzavFAL5MSm54POOQqlYA5wb2TnSk4GWKgyP5Fmo651vO9bMN51UREW/FYC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GA8o9RAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F094C4CEC4;
	Fri, 27 Sep 2024 20:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727468746;
	bh=BG0B2w8fDi3QD240E8yq4sTf5sjlGj8jOW8AvD6K3CE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GA8o9RAP1HX+xfwMSHIJz+U575Gu0Zellqv4P1kYgpYv1+Vw7UuIOgIpTxkYbVxpU
	 KHvPq4vS3uWW1z7hJeKhkw1Mr94iIV+btALjXwrRlmP+Enck62lerwptCmFLvcc3u3
	 07nL71OuatdQWg5lfO53GdQiYMNuoEQm7YPI44vok9ygogLIvbbuc0v2W1KM/ttH5d
	 6Itdsr1K3NUS2flbU0SN2fmSDxUpKG3LPgiVpIGiHn6Z4qMCikh7IHvFxlxySTwjLk
	 AmBpV0NVVeNtBf79ZSq6ySDfS7vB5trworOK++MsNNGiRlet6TgiXk90qCaCRlxX0I
	 cuVAPyv2pQXYA==
Date: Fri, 27 Sep 2024 10:25:45 -1000
From: Tejun Heo <tj@kernel.org>
To: Zhang Qiao <zhangqiao22@huawei.com>
Cc: David Vernet <void@manifault.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Remove redundant p->nr_cpus_allowed checker
Message-ID: <ZvcUyTUF11crCqwK@slm.duckdns.org>
References: <20240926103949.694868-1-zhangqiao22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926103949.694868-1-zhangqiao22@huawei.com>

On Thu, Sep 26, 2024 at 06:39:49PM +0800, Zhang Qiao wrote:
> select_rq_task() already checked that 'p->nr_cpus_allowed > 1',
> 'p->nr_cpus_allowed == 1' checker in scx_select_cpu_dfl() is redundant.
> 
> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>

Applied to sched_ext/for-6.12-fixes. I think we probably need a flag to tell
the BPF scheduler whether select_cpu has been called or not. Right now, most
schedulers assume that select_cpu() as called before enqueue() on wakeup
path but that's not true for CPU-affine tasks.

Thanks.

-- 
tejun

