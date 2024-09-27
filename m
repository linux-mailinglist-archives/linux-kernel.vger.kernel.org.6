Return-Path: <linux-kernel+bounces-342160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB509988B12
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 22:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EDFE1F2304E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 20:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D911C2DB1;
	Fri, 27 Sep 2024 20:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhTUq8S2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859C046B8;
	Fri, 27 Sep 2024 20:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727467880; cv=none; b=GKua0JvpL6LUTtyaED8CfYElf7kfJUCT5eJLMwqrTzU4+cSUlQmMy/CkVUEmW1gGOKJNsDZMyTWATiulAfCu9edISTxcOsrwXj675sSxDwY0j/6MkBSfVZByOY7CMuhkJfgXc64eq1Y2/Kx6ePmLXMI5J0JFqYlviDFARozIUns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727467880; c=relaxed/simple;
	bh=SQXHlvTS63B99udjXhHwAkvdfEHNlbOoiwLEXWXnaAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=siXdQvwxmQq+yYxCcPVvMEC4gO8dWjlgmpDwSdhiJIP4Grhka1iwq6y7JmJveuDWUNP3WXaQevP7c54QROl5j0mzUwgnaE6+T63o7uMKW5alVTqp7hMCJk4umOqafI3nUxXZNKFhnVl4CldC1/Q0F9mz7fQ3Os2oT8Mu8yDRhFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhTUq8S2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7F8C4CEC4;
	Fri, 27 Sep 2024 20:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727467879;
	bh=SQXHlvTS63B99udjXhHwAkvdfEHNlbOoiwLEXWXnaAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KhTUq8S22+5QfTK3w3cD2cR6wu0+E5NkgUtDRnWG/OPXmXn1X89jfIWPyubveVzO6
	 dYanIaI2cpG/eLMukQtAnbelTWeXN/CNgr9IIvciuD8Tl76FD/fk8oExmByULWRApx
	 OErOjeQS1zfsdBhg/NnRb3GwHb/toGUDxGH+WFSIH6ZqudGOqlynUx9TttrDMQ/gmc
	 kkgCwTPMyezHE+65dV4qJ76ZTEk7ZSehdctIGBb6ebUC/CMBniBiv8mT/nboiymq8G
	 K9dMW16oTe1DjPeVX0kaNrhw6GAnvsLH1b67mIG0RLqlZC4iHHzoJvZCAYtvb1w3I4
	 Z1SeL0xvQ5Bng==
Date: Fri, 27 Sep 2024 10:11:18 -1000
From: Tejun Heo <tj@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, Barret Rhoden <brho@google.com>,
	Ben Segall <bsegall@google.com>, David Vernet <void@manifault.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Josh Don <joshdon@google.com>,
	Juri Lelli <juri.lelli@redhat.com>, Hao Luo <haoluo@google.com>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Andrea Righi <andrea.righi@canonical.com>
Subject: Re: [PATCH] sched_ext: Call put_task_struct() only once in
 scx_ops_enable()
Message-ID: <ZvcRZt4foaB1IjTT@slm.duckdns.org>
References: <6c4afcdc-fa86-4f0a-a6c1-ec8265190fd0@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c4afcdc-fa86-4f0a-a6c1-ec8265190fd0@web.de>

On Thu, Sep 26, 2024 at 03:30:12PM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 26 Sep 2024 14:51:07 +0200
> 
> A put_task_struct() call was immediately used after a return value check
> for a scx_ops_init_task() call in this function implementation.
> Thus call such a function only once instead directly before the check.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

This no longer applies after 9753358a6a2b ("sched_ext: Fix SCX_TASK_INIT ->
SCX_TASK_READY transitions in scx_ops_enable()").

Thanks.

-- 
tejun

