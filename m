Return-Path: <linux-kernel+bounces-395360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED669BBCDD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 19:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91A2F28232D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E4A1C9EAF;
	Mon,  4 Nov 2024 18:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+nlp8nv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06FC224F0
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 18:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730743687; cv=none; b=YzLGNmauz4+jPQlFCiLwmon40thB53Ps1mdzg6j6ZeD21MP0lakD3UpNgbaZNgVAZOorjUckMKHqq1LkdBrjSMK6AKgJMu/ufgAaRJxcpPxZkvyobNv9vXx4wnWFWWNAa0pvNNSlxoIobEc+O3PfeF11/dje9LdFJz9jedi1k2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730743687; c=relaxed/simple;
	bh=PVnrBL4lkjktcJ+d1zuTLRbNSKpea3enMqS82gtgDdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwEEiEGfSzbohV2y42yJRqNG+mR6tYE3TmXDwctxBu89FlWpjQlXJ2o+Po4f2C9Jpj9yJNh75ldXqVb3inOnjXY3r+2pB4irFK4iPpnQLYQA3TNUIyuQB3PRvN8di9tuSGhATrT6TSV0uhl5VJEBnVaFcIkqJO/ba+jtqrh+Dh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+nlp8nv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AAD6C4CECE;
	Mon,  4 Nov 2024 18:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730743687;
	bh=PVnrBL4lkjktcJ+d1zuTLRbNSKpea3enMqS82gtgDdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H+nlp8nvIcoB9P8nky4+5VamsTcU4SmIHwVifd91p4+CczWtgx0IsmfnAaffaBNeT
	 0bXVUC+fscyYmMFkq2WNRw25f/ZWDjTbiIwWTz430egNEVX4QYGET+qyNQ3djupsDU
	 2wqVtftsnY50wlo4Fg522CphKNonZ69nJQExRk9dAD79E8yYbvjqXdHp8gtuzxSnra
	 wEQ4Gd30Gx6Lblv3wIvbqaONfJIUmJPJeYxDWGWqJBDAAafqIobQmZ5/6vbdYy9OMI
	 PvD7xhub+4qJjOHN3a5gywN3aYcL4B8tf2rXfSQj1vNDUepBtETTiwkYCYKcxBykZp
	 FyWEnpFmbPqzA==
Date: Mon, 4 Nov 2024 08:08:05 -1000
From: Tejun Heo <tj@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Hillf Danton <hdanton@sina.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [BUG] -next lockdep invalid wait context
Message-ID: <ZykNhbMOrlgCXFYJ@slm.duckdns.org>
References: <41619255-cdc2-4573-a360-7794fc3614f7@paulmck-laptop>
 <e06d69c9-f067-45c6-b604-fd340c3bd612@suse.cz>
 <ZyK0YPgtWExT4deh@elver.google.com>
 <66a745bb-d381-471c-aeee-3800a504f87d@paulmck-laptop>
 <20241102001224.2789-1-hdanton@sina.com>
 <ZyV2DfuIPsISds-1@Boquns-Mac-mini.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyV2DfuIPsISds-1@Boquns-Mac-mini.local>

Hello,

On Fri, Nov 01, 2024 at 05:45:01PM -0700, Boqun Feng wrote:
...
> Because it's a different bug.
> 
> 	schedule():
> 	  __schedule():
> 	    rq_lock(); // <- rq lock is a raw spin lock, so no sleep inside
> 	    switch_mm_irqs_off():
> 	      trace_tlb_flush():
> 	        bpf_trace_run2():
> 		  stack_map_get_build_id_offset():
> 		    mmap_read_trylock(): // this is actually ok, because
> 		    			 // trylock() on rwsem won't
> 					 // sleep.
> 		      __mmap_lock_trace_acquire_returned():
> 		        get_mm_memcg_path():
> 			  cgroup_path():
> 			    kernfs_path_from_node():
> 			      read_lock_irqsave(); // on RT, read_lock()
> 			      			   // is a rwsem IIUC,
> 						   // so might sleep.
> 						   // hence the issue.
> 
> Maybe kernfs can use RCU instead of read_lock here? I don't know...

Yeah, we should be able to make kn->name RCU protected and drop the usage of
the rename lock in read paths.

Thanks.

-- 
tejun

