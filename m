Return-Path: <linux-kernel+bounces-246851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B41992C7FF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FE771C21083
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 01:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2209D5680;
	Wed, 10 Jul 2024 01:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qrcr5mcj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7DD10FF
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 01:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720575653; cv=none; b=JXg5/1ezH9Cy85uPE2jPC9kdvi3PPcX0xJWf03mobAiERFI7J4erX1HGluUpV2wOqJCZsPBGj63AGOXVNlpqyCa1iMgOC14v1ilZcq+SCIS/tcwsuxcwU/X5wEfi7RyJp8LEkIJsFGqTNSrrAne64qlrfGdH/PDori+vnGMJBno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720575653; c=relaxed/simple;
	bh=XjbnB/U6oZRbWYl5xoHndEWVu+Xq5IuDuwcBrrThnto=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KK+4K59aPYyoHqqepwmEWSMdSHMtNYvcqR54vm+hd8+kBw+mHFMfx6lEq4Vd0F+RcksmzKYLGVObquIeRAs5VszQYu5KK4k6vcYlYy+nJDfN9TEYL/4tGzDkUeGsXXiPK+4epGFDb0k0KYJDHhcRJS23TjrtzVm1FOK3U7becCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qrcr5mcj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841F6C3277B;
	Wed, 10 Jul 2024 01:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720575652;
	bh=XjbnB/U6oZRbWYl5xoHndEWVu+Xq5IuDuwcBrrThnto=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qrcr5mcjiKIsUa4NaHFTxkm6wFES6bAawN8AkHYKXAno+JvUYjFmBCcbs0wxtLOBT
	 hDT+JSpAeW0ab3QhybCzQxhCyHvuXLBWHbXSrYhCMkps+aPa92LLlmre5mk03wjO1u
	 rFlxr6LSqPDOO3/GSclPYI0EHidHGzRmdB+DbjHcjzmOaA4sdBIcFLxN099VshEw44
	 /+pqVQ0/vruT9ktCblShocejW1SRPK4m3QOpCVhyCj5BD/3mvRxTm7GnbwNP7W2Z+h
	 733iX5RFJjLuWg40r6F2siHlsNvdTDummwZj/urO5+wxRtN5u9nadLVRzQjPyd6MdU
	 dznenJ99XSfzg==
Date: Wed, 10 Jul 2024 10:40:47 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org, oleg@redhat.com,
 jolsa@kernel.org, clm@meta.com, paulmck@kernel.org
Subject: Re: [PATCH 06/10] perf/uprobe: Split uprobe_unregister()
Message-Id: <20240710104047.fccde0f9f4332fc974cd9217@kernel.org>
In-Reply-To: <20240708092415.801757710@infradead.org>
References: <20240708091241.544262971@infradead.org>
	<20240708092415.801757710@infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 08 Jul 2024 11:12:47 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> With uprobe_unregister() having grown a synchronize_srcu(), it becomes
> fairly slow to call. Esp. since both users of this API call it in a
> loop.
> 
> Peel off the sync_srcu() and do it once, after the loop.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> ---
>  include/linux/uprobes.h     |    8 ++++++--
>  kernel/events/uprobes.c     |    8 ++++++--
>  kernel/trace/bpf_trace.c    |    6 ++++--
>  kernel/trace/trace_uprobe.c |    6 +++++-
>  4 files changed, 21 insertions(+), 7 deletions(-)
> 
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -113,7 +113,8 @@ extern int uprobe_write_opcode(struct ar
>  extern int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
>  extern int uprobe_register_refctr(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
>  extern int uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool);
> -extern void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
> +extern void uprobe_unregister_nosync(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
> +extern void uprobe_unregister_sync(void);
>  extern int uprobe_mmap(struct vm_area_struct *vma);
>  extern void uprobe_munmap(struct vm_area_struct *vma, unsigned long start, unsigned long end);
>  extern void uprobe_start_dup_mmap(void);
> @@ -163,7 +164,10 @@ uprobe_apply(struct inode *inode, loff_t
>  	return -ENOSYS;
>  }
>  static inline void
> -uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
> +uprobe_unregister_nosync(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
> +{
> +}
> +static inline void uprobes_unregister_sync(void)
>  {
>  }
>  static inline int uprobe_mmap(struct vm_area_struct *vma)
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1126,7 +1126,7 @@ __uprobe_unregister(struct uprobe *uprob
>   * @offset: offset from the start of the file.
>   * @uc: identify which probe if multiple probes are colocated.
>   */
> -void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
> +void uprobe_unregister_nosync(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
>  {
>  	struct uprobe *uprobe;
>  
> @@ -1138,10 +1138,14 @@ void uprobe_unregister(struct inode *ino
>  	__uprobe_unregister(uprobe, uc);
>  	mutex_unlock(&uprobe->register_mutex);
>  	put_uprobe(uprobe);
> +}
> +EXPORT_SYMBOL_GPL(uprobe_unregister_nosync);
>  
> +void uprobe_unregister_sync(void)
> +{
>  	synchronize_srcu(&uprobes_srcu);
>  }
> -EXPORT_SYMBOL_GPL(uprobe_unregister);
> +EXPORT_SYMBOL_GPL(uprobe_unregister_sync);
>  
>  /*
>   * __uprobe_register - register a probe
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3181,9 +3181,11 @@ static void bpf_uprobe_unregister(struct
>  	u32 i;
>  
>  	for (i = 0; i < cnt; i++) {
> -		uprobe_unregister(d_real_inode(path->dentry), uprobes[i].offset,
> -				  &uprobes[i].consumer);
> +		uprobe_unregister_nosync(d_real_inode(path->dentry), uprobes[i].offset,
> +					 &uprobes[i].consumer);
>  	}
> +	if (cnt)
> +		uprobe_unregister_sync();
>  }
>  
>  static void bpf_uprobe_multi_link_release(struct bpf_link *link)
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -1104,6 +1104,7 @@ static int trace_uprobe_enable(struct tr
>  static void __probe_event_disable(struct trace_probe *tp)
>  {
>  	struct trace_uprobe *tu;
> +	bool sync = false;
>  
>  	tu = container_of(tp, struct trace_uprobe, tp);
>  	WARN_ON(!uprobe_filter_is_empty(tu->tp.event->filter));
> @@ -1112,9 +1113,12 @@ static void __probe_event_disable(struct
>  		if (!tu->inode)
>  			continue;
>  
> -		uprobe_unregister(tu->inode, tu->offset, &tu->consumer);
> +		uprobe_unregister_nosync(tu->inode, tu->offset, &tu->consumer);
> +		sync = true;
>  		tu->inode = NULL;
>  	}
> +	if (sync)
> +		uprobe_unregister_sync();
>  }
>  
>  static int probe_event_enable(struct trace_event_call *call,
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

