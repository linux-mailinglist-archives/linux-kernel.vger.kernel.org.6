Return-Path: <linux-kernel+bounces-518109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DFAA38A11
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F3A416F222
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BA0225A5B;
	Mon, 17 Feb 2025 16:52:46 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCC0225A4E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739811166; cv=none; b=tBzReYDZcuVKZN+aZA46npvdRRqN5byovFIKNBh0PCLBJSLCagGSoyDL61lFVHSTfAN16szt/qPARxOROxoAzBejsd8nGsIlxXjaY1B/aMrTCngL8gom/ZpwBlcdqSCSd0q0ED5c4a1cw2kDWfhZX5f5IwkxSMv5EPBj+5WFqLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739811166; c=relaxed/simple;
	bh=8hdXX7fViOrZwAtnhTmRckaz1Ylr/OHyhKBG0zEf4xk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AAfyB2ga2gKO3EAjOOxDOXATeXyjpDk8Hd5Hxz06hahhUdJBDkzKuOTys7Br8WcXw3WHJV0LzXwboHPTn/LNrGSIHx8XI8l2kpFmiYAKPAsAGRJwwILA80cid6/DjEMkG5Xh1sClLDvsYL5B4Zb2sRxzJ1wo1AVI95JYmlAOyNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA1BC4CED1;
	Mon, 17 Feb 2025 16:52:44 +0000 (UTC)
Date: Mon, 17 Feb 2025 11:53:03 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Harshit Agarwal <harshit@nutanix.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Jon Kohler <jon@nutanix.com>, Gauri
 Patwardhan <gauri.patwardhan@nutanix.com>, Rahul Chunduru
 <rahul.chunduru@nutanix.com>, Will Ton <william.ton@nutanix.com>
Subject: Re: [PATCH v2] sched/rt: Fix race in push_rt_task
Message-ID: <20250217115303.003a1005@gandalf.local.home>
In-Reply-To: <D7C6B8EE-7AFC-4F1E-8A59-E9573658146C@nutanix.com>
References: <9C390C10-8741-4992-8E29-303C907C8C00@nutanix.com>
	<20250213175435.114441-1-harshit@nutanix.com>
	<20250217105007.45ba8cb4@gandalf.local.home>
	<D7C6B8EE-7AFC-4F1E-8A59-E9573658146C@nutanix.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Feb 2025 16:36:47 +0000
Harshit Agarwal <harshit@nutanix.com> wrote:

> Hi Steve,
> 
> Thanks for the information. I realized my mistake this after updating this 
> thread and then later I sent the patch as a separate thread here 
> https://lore.kernel.org/lkml/20250214170844.201692-1-harshit@nutanix.com/
> and included the link to v1 along with the changes made.

Yeah I just noticed it ;-)


> 
> I had also added a comment on is_migration_disabled like you suggested  here. 
> This separate patch addresses your comments already.
> Sorry for the confusion.

I'm behind in my email and I'm just chugging away in order.

-- Steve

