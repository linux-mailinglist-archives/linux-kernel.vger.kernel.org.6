Return-Path: <linux-kernel+bounces-212269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0356F905D85
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 23:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254931C211A9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 21:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7388526C;
	Wed, 12 Jun 2024 21:17:52 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DF0210FF;
	Wed, 12 Jun 2024 21:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718227071; cv=none; b=gDH9i/Hcn1rXYJ+elW71V0U7VY/wo1e6uYF9cPvp8G3vj0VvGruzuydZNfGWCFE30HvkXV0DGxp8Cf1kWcnMUN9XglMk78GsdQ34WJtQUE6wyclg1X5P8nWUK+3dOMAOF697VgXUOwM9s4k4MOw9KFg08SUt0nfS8pObK/GnKtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718227071; c=relaxed/simple;
	bh=vEtzTEM2k7xLovHgE/1wAEzwHMADwkncLdx8SgC6E34=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f/P9cNbJmmWcMzvwcBpd4KbXixQlqP7Q2ED311qnCCsUWQYubrXFFP9tRMNy+72YErGve73HLIa14MbaSNnhsW7Xx1f+R+KszXSkeX1XH3owjiGX0A2lAFBs4Qsv8Huacs6bniSh/rH5PTF6PnAKAZplGeljPqViTi+Bu+lFBhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABFBC116B1;
	Wed, 12 Jun 2024 21:17:50 +0000 (UTC)
Date: Wed, 12 Jun 2024 17:17:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Linux Regressions <regressions@lists.linux.dev>, Dan Carpenter
 <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: LTP tracing crashed on arm64 rk3399-rock-pi-4 - pc :
 ftrace_ops_test
Message-ID: <20240612171748.0bc6d9cb@rorschach.local.home>
In-Reply-To: <20240612125130.2c1d6d2d@rorschach.local.home>
References: <CA+G9fYsSVJQZH=nM=1cjTc94PgSnMF9y65BnOv6XSoCG_b6wmw@mail.gmail.com>
	<20240612125130.2c1d6d2d@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jun 2024 12:51:30 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > [  100.600222] Hardware name: Radxa ROCK Pi 4B (DT)
> > [  100.600229] pstate: 800003c5 (Nzcv DAIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [  100.600239] pc : ftrace_ops_test+0x34/0x138  
> 
> Hmm, could you show the exact line of the above code? Specifically we have:
> 
> 	rcu_assign_pointer(hash.filter_hash, ops->func_hash->filter_hash);
> 	rcu_assign_pointer(hash.notrace_hash, ops->func_hash->notrace_hash);
> 
> Hmm, it's a NULL pointer dereference at 0x8, so ops is likely not NULL,
> as func_hash is much farther down. But if func_hash is NULL,
> filter_hash is at the 0x8 offset.
> 
> So now the question is, how did func_hash become NULL. It should always
> be pointing at something. May have to do with the subops. Will investigate.
> 

> 
> 
> > [  100.600258] lr : function_graph_enter+0x144/0x208

I wonder if we need the following patch:

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 8317d1a7f43a..fc205ad167a9 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -641,7 +641,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 	{
 		for_each_set_bit(i, &fgraph_array_bitmask,
 					 sizeof(fgraph_array_bitmask) * BITS_PER_BYTE) {
-			struct fgraph_ops *gops = fgraph_array[i];
+			struct fgraph_ops *gops = READ_ONCE(fgraph_array[i]);
 			int save_curr_ret_stack;
 
 			if (gops == &fgraph_stub)


Because if the compiler decides to re-read gops from fgraph_array[i] after the
above check for the following line that does:

			save_curr_ret_stack = current->curr_ret_stack;
			if (ftrace_ops_test(&gops->ops, func, NULL) &&
			    gops->entryfunc(&trace, gops))
				bitmap |= BIT(i);


and gops now points to fgraph_stub, it will trigger this bug.

Can you apply the above change and see if the bug goes away?

Thanks,

-- Steve

