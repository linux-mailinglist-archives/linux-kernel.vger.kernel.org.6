Return-Path: <linux-kernel+bounces-406153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CED9C5B83
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B8C128144A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56492003DD;
	Tue, 12 Nov 2024 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tSPx5jS9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p+/sOxN3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32AC1FBF6E;
	Tue, 12 Nov 2024 15:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731424155; cv=none; b=lJkNECFZ+G675ErtVDgNPJfCEviJW5qJnxOHE5ECMcpYdPtxuq5i/ICd/t/xe5E372MCquHJoPRApWcft0JxeZU1+Xx+Em7dfPCBardp3LoW7nNh9NF2YIZik+40RfnwSadey7hkniknc1ucSZ1UBIweACWknDrAttdDxo3ti+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731424155; c=relaxed/simple;
	bh=1yal8WnyDj7WFmQTjtVBqR/Cp2DayfFSKxcCh2gmJb4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iirVO/SNFUIKvUp6qtd7n81n/qIg+WKMCJYlMAkuUdWKOnB7SnJ1UA40mgldV2rWjtyGIP9HCARTTV8GTml3nhv0YdlEeRamsg6BDO+c3i/KS0XwkE2WLwSvxQF6nLSGEiGBLsitj6HKYCa6N1982Qgufr+Q+hV3TgS/AlGhnr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tSPx5jS9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p+/sOxN3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731424152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+OwuircvxUSa0rTscRYfW7ivkxPcWV/LKtkFlw2hGKg=;
	b=tSPx5jS9oii0btPsjnoFzDrjL8q4vDgEm558vreVqWxdUWauz32a4YFHDA5Zm9DTWe/exO
	m/sFLgqyq0NaoM4ALjnXBvqKmkp2zFRxAIxBj3uAnInrZ4tCJ3ZDWZ/8wu8xYer7cdwS1i
	Vls7Bc+RMp2ybtDTFHdu5BQ0hgIzDVnLHprqxEkpmsN+YgklQyNfXSptRXteb20QKmgcxF
	bkEmEDJIyFIHzs3Rb5OxoXOcxV10phPPV69ZqtRiXVjUwzwFbwO6KprXIfuH+y5Xde8nn+
	5KkxYIg2zf5qdgTAWAw2rC+ZbzxkWSIYXrT+30Le8F2PMDud821tEcZxTcDuBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731424152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+OwuircvxUSa0rTscRYfW7ivkxPcWV/LKtkFlw2hGKg=;
	b=p+/sOxN3Bs0C7HUz9S8JdQpZDGBP1h0uNHRTlfS66d3H3AsogsfU6VQCumczuYdxB3dBdA
	7de6h++tqZhrwmBg==
To: Kunwu Chan <kunwu.chan@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Kunwu Chan <chentao@kylinos.cn>,
 syzbot+b506de56cbbb63148c33@syzkaller.appspotmail.com
Subject: Re: [PATCH] bpf: Convert lpm_trie::lock to 'raw_spinlock_t'
In-Reply-To: <20241108063214.578120-1-kunwu.chan@linux.dev>
References: <20241108063214.578120-1-kunwu.chan@linux.dev>
Date: Tue, 12 Nov 2024 16:08:47 +0100
Message-ID: <87v7wsmqv4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Nov 08 2024 at 14:32, Kunwu Chan wrote:
> When PREEMPT_RT is enabled, 'spinlock_t' becomes preemptible
> and bpf program has owned a raw_spinlock under a interrupt handler,
> which results in invalid lock acquire context.

This explanation is just wrong.

The problem has nothing to do with an interrupt handler. Interrupt
handlers on RT kernels are force threaded.

>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>  _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
>  trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:462
>  bpf_prog_2c29ac5cdc6b1842+0x43/0x47
>  bpf_dispatcher_nop_func include/linux/bpf.h:1290 [inline]
>  __bpf_prog_run include/linux/filter.h:701 [inline]
>  bpf_prog_run include/linux/filter.h:708 [inline]
>  __bpf_trace_run kernel/trace/bpf_trace.c:2340 [inline]
>  bpf_trace_run1+0x2ca/0x520 kernel/trace/bpf_trace.c:2380
>  trace_workqueue_activate_work+0x186/0x1f0 include/trace/events/workqueue.h:59
>  __queue_work+0xc7b/0xf50 kernel/workqueue.c:2338

The problematic lock nesting is the work queue pool lock, which is a raw
spinlock.

> @@ -330,7 +330,7 @@ static long trie_update_elem(struct bpf_map *map,
>  	if (key->prefixlen > trie->max_prefixlen)
>  		return -EINVAL;
>  
> -	spin_lock_irqsave(&trie->lock, irq_flags);
> +	raw_spin_lock_irqsave(&trie->lock, irq_flags);
>  
>  	/* Allocate and fill a new node */

Making this a raw spinlock moves the problem from the BPF trie code into
the memory allocator. On RT the memory allocator cannot be invoked under
a raw spinlock.

Thanks,

        tglx


