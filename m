Return-Path: <linux-kernel+bounces-565271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD68A664F5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 02:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D5E179CB6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 01:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0170215B554;
	Tue, 18 Mar 2025 01:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mj89zOK/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF77155753;
	Tue, 18 Mar 2025 01:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742261155; cv=none; b=Hwo7K1PHyariF3tZl6iYFX8UReOejEI6QBF/AXI1AEfOFVKFP4fspLmudmduQDm9jTIhhwVa4QlyIS2Rx8HzksoEXflQPsX5Yqxg9p197hAmxKRVTe43MvewdZxG55V7ubdIWu2x9ThXNsynkYFody7lT9Ik+txjqu9w1CjQoGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742261155; c=relaxed/simple;
	bh=UXjn0fyrQYkQwF6j4cJrc5p9zVRAfkUTomr9zTyax1w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HCZzGUX1oodoMcCquC8HZ45L3u+gheopniirdVtrZEE3i81BHSye7OFalRYm/CKZdYJOUfxvsyvO/SBIot2sd+mioJFS/q9dVlMzhNXivvyp618wWFBH8mRtfF8WYTtVi6WQiwCS8glhPROcVkOy6/ovGbD7WARR8iyRpYmDr4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mj89zOK/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198D6C4CEE3;
	Tue, 18 Mar 2025 01:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742261154;
	bh=UXjn0fyrQYkQwF6j4cJrc5p9zVRAfkUTomr9zTyax1w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mj89zOK/dpjyod76yrzVqnJjFsPqWJQDD8HMoRqSMWCqv06ldoOFwklPUapLc3CbG
	 Q234Avd3V8u8m6fmbSYn65xLIxHpsIxk3KVjRQSD/o8G2wT1cCHgDTwGfUdNkfEGDF
	 rOuetg1/FZZMk85aqKxJ3CBKkzSvGkR4pPcCyJadEk0LiSTfIbPxKzxhora8vNH1OG
	 Z3PwtgPjkuUX//I9RwVmHKjhIsTOMmeLhy2WBkvNEtAtuxpmkeNvIMNt3DTcpxkz0u
	 mksZyjrGpZPMCjfC71RTmIYJZkpiAHLgSFC3GepQ3+eFBMsnll6iuB5AcGbdao9Boy
	 UhftkA4ptGSog==
Date: Tue, 18 Mar 2025 10:25:52 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] tracing: Fix a compilation error without
 CONFIG_MODULES
Message-Id: <20250318102552.7c7400873fa3f304cbefa9b6@kernel.org>
In-Reply-To: <20250314054257.3218dc35@batman.local.home>
References: <174188320269.3845006.11920186078507571954.stgit@mhiramat.tok.corp.google.com>
	<174188321162.3845006.12665585959241736399.stgit@mhiramat.tok.corp.google.com>
	<20250314054257.3218dc35@batman.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Mar 2025 05:42:57 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 14 Mar 2025 01:26:51 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > @@ -6040,9 +6042,10 @@ static void update_last_data(struct trace_array *tr)
> >  		memset(tscratch->entries, 0,
> >  		       flex_array_size(tscratch, entries, tscratch->nr_entries));
> >  		tscratch->nr_entries = 0;
> > -
> > +#ifdef CONFIG_MODULES
> >  		guard(mutex)(&scratch_mutex);
> >  		module_for_each_mod(save_mod, tr);
> > +#endif
> >  	}
> 
> Hmm, I think the real fix for this would be to make
> module_for_each_mod() a nop when modules are not configured.

Yeah, but in this case, save_mod() need to be removed too[*]. Or is it
better to make save_mod() a nop too?

[*] https://lore.kernel.org/oe-kbuild-all/202503142045.0sE1neLa-lkp@intel.com/

Thank you,

> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

