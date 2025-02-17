Return-Path: <linux-kernel+bounces-517990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BB5A38869
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3017416ED82
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4732229B1D;
	Mon, 17 Feb 2025 15:49:50 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F6E229B0B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807390; cv=none; b=ic++MwdIXFrcNB8zvgxFP9tRHUgYwJ01fAbh+LxwN0yVkBLzx/XV0WtXPHadzmBxxDuhHMjzpWZtF+nWb0kSOwILwIQ2/oL2kAIskLhNzNC8/qRhLbUPEBflLZRM+CKTmQyxSIwUtVBpeEGlGehquc9Puh3d0QmXFCOOIYlGf+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807390; c=relaxed/simple;
	bh=+T9+QSLbqVaktqQ4lOnMjR9OoKYV0X4W7fjhcNuiSPw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nwf1Rvki+JlBhiLMxaE4jKes1Xx7c2xHNFxVZ5FyNxBYKKL7JB13V0r/yd7X+aWSAa8S6wHrNVhkDSW3QqFjiMT9tjVGTgsbv6iiC9NuwESAus2op0KNo2PxuIwAG1k2maHL2/2bJ1vwu5H4eKaTV7LsOFJBX34JL8S7M6Cw+Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB18C4CED1;
	Mon, 17 Feb 2025 15:49:47 +0000 (UTC)
Date: Mon, 17 Feb 2025 10:50:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Harshit Agarwal <harshit@nutanix.com>, Peter Zijlstra
 <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, Jon Kohler <jon@nutanix.com>, Gauri
 Patwardhan <gauri.patwardhan@nutanix.com>, Rahul Chunduru
 <rahul.chunduru@nutanix.com>, Will Ton <william.ton@nutanix.com>
Subject: Re: [PATCH v2] sched/rt: Fix race in push_rt_task
Message-ID: <20250217105007.45ba8cb4@gandalf.local.home>
In-Reply-To: <20250213175435.114441-1-harshit@nutanix.com>
References: <9C390C10-8741-4992-8E29-303C907C8C00@nutanix.com>
	<20250213175435.114441-1-harshit@nutanix.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


FYI,

You should always send a new patch version as a separate thread. That's
because they can get lost in the thread and makes it harder for maintainers
to know what the next version of the patch is. I've picked the wrong patch
version before because there was another version sent that I missed.

On Thu, 13 Feb 2025 17:54:34 +0000
Harshit Agarwal <harshit@nutanix.com> wrote:

> Solution
> ========
> The solution here is fairly simple. After obtaining the lock (at 4a),
> the check is enhanced to make sure that the task is still at the head of
> the pushable tasks list. If not, then it is anyway not suitable for
> being pushed out. The fix also removes any conditions that are no longer
> needed.
> 
> Testing
> =======
> The fix is tested on a cluster of 3 nodes, where the panics due to this
> are hit every couple of days. A fix similar to this was deployed on such
> cluster and was stable for more than 30 days.

May also want to add:

  Since 'is_migration_disabled()' a faster check than the others, it was moved
  to be the first check for consistency.

> 
> Co-developed-by: Jon Kohler <jon@nutanix.com>
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> Co-developed-by: Gauri Patwardhan <gauri.patwardhan@nutanix.com>
> Signed-off-by: Gauri Patwardhan <gauri.patwardhan@nutanix.com>
> Co-developed-by: Rahul Chunduru <rahul.chunduru@nutanix.com>
> Signed-off-by: Rahul Chunduru <rahul.chunduru@nutanix.com>
> Signed-off-by: Harshit Agarwal <harshit@nutanix.com>
> Tested-by: Will Ton <william.ton@nutanix.com>
> ---

You can add here (after the above three dashes), how this version is
different from the last version. The text below the dashes and before the
patch is ignored by git, but is useful for reviewers. For instance:

Changes since v1: https://lore.kernel.org/all/20250211054646.23987-1-harshit@nutanix.com/

- Removed the redundant checks that task != pick_next_pushable_task() already has


Notice I added a link to the previous version. This helps find the previous
version without having to make this version a reply to it.

>  kernel/sched/rt.c | 54 +++++++++++++++++++++++------------------------
>  1 file changed, 26 insertions(+), 28 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 4b8e33c615b1..4762dd3f50c5 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1885,6 +1885,27 @@ static int find_lowest_rq(struct task_struct *task)
>  	return -1;
>  }
>  

Otherwise,

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Peter, could you pick this up?

-- Steve

