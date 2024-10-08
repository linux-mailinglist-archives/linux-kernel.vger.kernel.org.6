Return-Path: <linux-kernel+bounces-354337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B43BA993C0A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 03:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6412C1F235AC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 01:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB5BC139;
	Tue,  8 Oct 2024 01:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MW7xEQVN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C713214
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 01:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728350142; cv=none; b=H60a/fUG5dUXGNsZoghPUkJMU2gYSyVZ5VMJRXi6zpk3fhJVXBVUVt2omskBVxAATQse9JlHgHnh/zYjTqSkI92AgAeiimykBEAdMpfUL3h81/VxgHefzcXSEeOMUrn4QTa+oJPgyn2hlIDjdHWMRzRb3z2ww6PCplspP2zxP6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728350142; c=relaxed/simple;
	bh=YWVrCCzoI73RBeFOnUhsx7r7Uv+muCzR7+GAO6zvPfA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=t4rP7thI8mASRD04yKNM9xeLhd2+Z7AsFVL0sOO/KnFPqGbOGPqJx+OXMXxL7VxFwgVe7x9QKVlIP2LtRFL4Fk0A7BuNYf2XjPFeAOX08h2+9duEmrr0/TkD1nr/c0bq5ZxoxP4JpJ96hEusLGM0l+Yusxtimw03UT7Vveqoluo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MW7xEQVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09ED9C4CEC6;
	Tue,  8 Oct 2024 01:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1728350142;
	bh=YWVrCCzoI73RBeFOnUhsx7r7Uv+muCzR7+GAO6zvPfA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MW7xEQVN2fiOKhr8jefB7HW30S+lTB9beYGnmSHOKLWJDuJrn4Vz2c61UOPtAAQml
	 nD/8TtfpN9NwIg5yqcAJORb4Je/I1LMTRoGo5FmksxfmttjH9qM0yX/hKGEpPIIRj6
	 T9jhr+Rae4fUzy6Iv0LiSMWy8HaqbE9xgDiCJxjM=
Date: Mon, 7 Oct 2024 18:15:41 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Florian Westphal <fw@strlen.de>
Cc: linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>,
 Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, Ben Greear
 <greearb@candelatech.com>
Subject: Re: [PATCH lib] lib: alloc_tag_module_unload must wait for pending
 kfree_rcu calls
Message-Id: <20241007181541.4bbe9b8580f6475023256515@linux-foundation.org>
In-Reply-To: <20241007205236.11847-1-fw@strlen.de>
References: <20241007205236.11847-1-fw@strlen.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Oct 2024 22:52:24 +0200 Florian Westphal <fw@strlen.de> wrote:

> Ben Greear reports following splat:
>  ------------[ cut here ]------------
>  net/netfilter/nf_nat_core.c:1114 module nf_nat func:nf_nat_register_fn has 256 allocated at module unload
>  WARNING: CPU: 1 PID: 10421 at lib/alloc_tag.c:168 alloc_tag_module_unload+0x22b/0x3f0
>  Modules linked in: nf_nat(-) btrfs ufs qnx4 hfsplus hfs minix vfat msdos fat
> ...
>  Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/04/2020
>  RIP: 0010:alloc_tag_module_unload+0x22b/0x3f0
>   codetag_unload_module+0x19b/0x2a0
>   ? codetag_load_module+0x80/0x80
> 
> nf_nat module exit calls kfree_rcu on those addresses, but the free
> operation is likely still pending by the time alloc_tag checks for leaks.
> 
> Wait for outstanding kfree_rcu operations to complete before checking
> resolves this warning.
> 
> Reproducer:
> unshare -n iptables-nft -t nat -A PREROUTING -p tcp
> grep nf_nat /proc/allocinfo # will list 4 allocations
> rmmod nft_chain_nat
> rmmod nf_nat                # will WARN.
> 
> ...
>
> --- a/lib/codetag.c
> +++ b/lib/codetag.c
> @@ -228,6 +228,8 @@ bool codetag_unload_module(struct module *mod)
>  	if (!mod)
>  		return true;
>  
> +	kvfree_rcu_barrier();
> +
>  	mutex_lock(&codetag_lock);
>  	list_for_each_entry(cttype, &codetag_types, link) {
>  		struct codetag_module *found = NULL;

It's always hard to determine why a thing like this is present, so a
comment is helpful:

--- a/lib/codetag.c~lib-alloc_tag_module_unload-must-wait-for-pending-kfree_rcu-calls-fix
+++ a/lib/codetag.c
@@ -228,6 +228,7 @@ bool codetag_unload_module(struct module
 	if (!mod)
 		return true;
 
+	/* await any module's kfree_rcu() operations to complete */
 	kvfree_rcu_barrier();
 
 	mutex_lock(&codetag_lock);
_

But I do wonder whether this is in the correct place.

Waiting for a module's ->exit() function's kfree_rcu()s to complete
should properly be done by the core module handling code?

free_module() does a full-on synchronize_rcu() prior to freeing the
module memory itself and I think codetag_unload_module() could be
called after that?

