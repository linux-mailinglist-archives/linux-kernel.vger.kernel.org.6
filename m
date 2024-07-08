Return-Path: <linux-kernel+bounces-244965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC32B92AC50
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 00:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758E11F2301F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 22:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAE315217A;
	Mon,  8 Jul 2024 22:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMDgB3LD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742FD381BE
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 22:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720479417; cv=none; b=JuD0bDOfddEqKl0gM9HjJb8t0cBG+nNdFy1W3gsalGcj22IDwCg8BS6TsKskOGq/Xjan0PwVJEy5GdBc2f2IWVzABg3HRg2jbUrrGLk10QPTr5vTU7AlmNAXSXQIKs99FZMWawQbo0YUsvjn3yXLWAqx9FW3vvXpf2nxM+prNE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720479417; c=relaxed/simple;
	bh=31cTM9ovItH88ng6QYMYVzgmJG33BK7TGTnD2aWdFDE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UjmgPNVTY+t3zSqbgSeAcMDk0BMBxEuLrVZjn9AjxgPCED/THMROhDxjzHl9W0QQSEHxPaphdhGob7SSM2hZYQ0S2LTvdelQVKY9HnLiM5Jj4BlCq6FfyGdYEfK7U5UlopuEAMUNKVVe0iF4kKQ7FMA+VNnljyNRpTIzmCG6Xcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMDgB3LD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C22BC116B1;
	Mon,  8 Jul 2024 22:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720479417;
	bh=31cTM9ovItH88ng6QYMYVzgmJG33BK7TGTnD2aWdFDE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CMDgB3LDTyJqC9rFsdFz1gE3mkpepE1VTydIzxB4EaTSV/tK7/MM1WnkV8sz71cJJ
	 hRbOL6YFeRkus1+xb+5wCcCa8o+pV4Y7YZKk1bbp08CyNHhWFRKkVMF2CUkA81GX6y
	 XiLvn41xhCg2hyTaXeLeExncwrUcGRtVt1D4hAkt/dvXJnn3KewRwrQfZX9y3ico8Q
	 tMUrTvTvXfbfp9bQhTH2g8PDc3m8BMg26MK+XGFoSgME2pG5NjmCimyN2q5R76kRKp
	 vkkaxe3p62StO2sf7G1eHmLE5mFUpwEl7P8wSq9IGZe4lXwWZK4RjOQ2BuNrT/Q3P+
	 ETcwszBXLHlpg==
Date: Tue, 9 Jul 2024 07:56:51 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org, oleg@redhat.com,
 jolsa@kernel.org, clm@meta.com, paulmck@kernel.org
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
Message-Id: <20240709075651.122204f1358f9f78d1e64b62@kernel.org>
In-Reply-To: <20240708091241.544262971@infradead.org>
References: <20240708091241.544262971@infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 08 Jul 2024 11:12:41 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Hi!
> 
> These patches implement the (S)RCU based proposal to optimize uprobes.
> 
> On my c^Htrusty old IVB-EP -- where each (of the 40) CPU calls 'func' in a
> tight loop:
> 
>   perf probe -x ./uprobes test=func
>   perf stat -ae probe_uprobe:test  -- sleep 1
> 
>   perf probe -x ./uprobes test=func%return
>   perf stat -ae probe_uprobe:test__return -- sleep 1
> 
> PRE:
> 
>   4,038,804      probe_uprobe:test
>   2,356,275      probe_uprobe:test__return
> 
> POST:
> 
>   7,216,579      probe_uprobe:test
>   6,744,786      probe_uprobe:test__return
> 

Good results! So this is another series of Andrii's batch register?
(but maybe it becomes simpler)

Thank you,

> 
> Patches also available here:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/uprobes
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

