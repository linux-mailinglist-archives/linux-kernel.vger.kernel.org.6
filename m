Return-Path: <linux-kernel+bounces-375833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5871D9A9B74
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B645DB212A2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8685414A4F9;
	Tue, 22 Oct 2024 07:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1n7MXVHm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lzwsiTr9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1n7MXVHm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lzwsiTr9"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA7B146D68
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 07:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729583356; cv=none; b=TPXiJz6vyG1PnX9cJ5s6ojB+2KevwrFt2VLlij69YEagUrUGOC+C/OjoQ9FUJoIjVkLok1zIFrntUaoCC+qm4RiLtqaP0Uou+af621rzu4tubNAVAsUH2CUHth2HdtdRwZTyuPiPcyaTUPTUsE8VGqCAlvg+H0IB6zJTrGd4Vjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729583356; c=relaxed/simple;
	bh=JIBJ4WOG+AeTkswaT04lD/+oeGL72JWI1TbKNinGrHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdZC7XmU58w1HRMITJAvpG7B54RsIfpD5NodkIXLWyagGqzWQq3B5KN9swW8pl2qurnE50lfPJSduFUGm38qGAb6YkrsVsNEBNouQPEWEB3bvScPDD0gRxw1Zqi13twnahY/K41/arI93AoK/xDhry0a3ItgBGgteLvBd7k9VlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1n7MXVHm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lzwsiTr9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1n7MXVHm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lzwsiTr9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1ED3621C79;
	Tue, 22 Oct 2024 07:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729583353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m7sZdKMGSdM6kuvLwufr4oBJIa0eABSyj1x+dLkMRJ8=;
	b=1n7MXVHm6P6xSUKAFFCHHBL1jHjA3GLQvxX8tJ+Lmm84sbnSceCMM4psZa7nAK96qpZ9KU
	9kDX/CdxyzZawiHEiVv70dsH7swJXu3isuZvM2jbB266+jkDpaDeJoM99e52UCyGEwCeOt
	CW+QUaKH+H4yIFuG2Y9FMnIhKN4eFgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729583353;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m7sZdKMGSdM6kuvLwufr4oBJIa0eABSyj1x+dLkMRJ8=;
	b=lzwsiTr9kgCRA8TwWBeyL+sx6DSNIMKiJQtLRAddW1+k4MjRxzvr62vUXJdwLxPk8Z1ZPJ
	hfzZssdpyjBGUEDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1n7MXVHm;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lzwsiTr9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729583353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m7sZdKMGSdM6kuvLwufr4oBJIa0eABSyj1x+dLkMRJ8=;
	b=1n7MXVHm6P6xSUKAFFCHHBL1jHjA3GLQvxX8tJ+Lmm84sbnSceCMM4psZa7nAK96qpZ9KU
	9kDX/CdxyzZawiHEiVv70dsH7swJXu3isuZvM2jbB266+jkDpaDeJoM99e52UCyGEwCeOt
	CW+QUaKH+H4yIFuG2Y9FMnIhKN4eFgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729583353;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m7sZdKMGSdM6kuvLwufr4oBJIa0eABSyj1x+dLkMRJ8=;
	b=lzwsiTr9kgCRA8TwWBeyL+sx6DSNIMKiJQtLRAddW1+k4MjRxzvr62vUXJdwLxPk8Z1ZPJ
	hfzZssdpyjBGUEDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B7EB13AC9;
	Tue, 22 Oct 2024 07:49:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qQdCB/hYF2dCbgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 22 Oct 2024 07:49:12 +0000
Date: Tue, 22 Oct 2024 09:49:06 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Huang Ying <ying.huang@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	x86@kernel.org, linux-coco@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	David Hildenbrand <david@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH -V3] x86/tdx, memory hotplug: Check whole hot-adding
 memory range for TDX
Message-ID: <ZxdY8ty-nAj3dlQQ@localhost.localdomain>
References: <20241022031617.159969-1-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022031617.159969-1-ying.huang@intel.com>
X-Rspamd-Queue-Id: 1ED3621C79
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,intel.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Tue, Oct 22, 2024 at 11:16:17AM +0800, Huang Ying wrote:
> On systems with TDX (Trust Domain eXtensions) enabled, current kernel
> checks the TDX compatibility of the hot-added memory ranges through a
> memory hotplug notifier for each memory_block.  If a memory range
> which isn't TDX compatible is hot-added, for example, some CXL memory,
> the command line as follows,
> 
>   $ echo 1 > /sys/devices/system/node/nodeX/memoryY/online
> 
> will report something like,
> 
>   bash: echo: write error: Operation not permitted
> 
> If pr_debug() is enabled, current kernel will show the error message
> like below in the kernel log,
> 
>   online_pages [mem 0xXXXXXXXXXX-0xXXXXXXXXXX] failed
> 
> Both are too general to root cause the problem.  This may confuse
> users.  One solution is to print some error messages in the TDX memory
> hotplug notifier.  However, kernel calls memory hotplug notifiers for
> each memory block, so this may lead to a large volume of messages in
> the kernel log if a large number of memory blocks are onlined with a
> script or automatically.  For example, the typical size of memory
> block is 128MB on x86_64, when online 64GB CXL memory, 512 messages
> will be logged.
> 
> Therefore, this patch checks the TDX compatibility of the whole
> hot-adding memory range through a newly added architecture specific
> function (arch_check_hotplug_memory_range()).  If this patch rejects
> the memory hot-adding for TDX compatibility, it will output a kernel
> log message like below,
> 
>   virt/tdx: Reject hot-adding memory range: 0xXXXXXXXX-0xXXXXXXXX for TDX compatibility.
> 
> The target use case is to support CXL memory on TDX enabled systems.
> If the CXL memory isn't compatible with TDX, the kernel will reject
> the whole CXL memory range.  While the CXL memory can still be used
> via devdax interface.
> 
> This also makes the original TDX memory hotplug notifier useless, so
> this patch deletes it.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>

Acked-by: Oscar Salvador <osalvador@suse.de>

One question below:

...

> +int tdx_check_hotplug_memory_range(u64 start, u64 size)
>  {
> -	struct memory_notify *mn = v;
> -
> -	if (action != MEM_GOING_ONLINE)
> -		return NOTIFY_OK;
> +	u64 start_pfn = PHYS_PFN(start);
> +	u64 end_pfn = PHYS_PFN(start + size);
>  
>  	/*
>  	 * Empty list means TDX isn't enabled.  Allow any memory
> -	 * to go online.
> +	 * to be hot-added.
>  	 */
>  	if (list_empty(&tdx_memlist))
> -		return NOTIFY_OK;
> +		return 0;
>  
>  	/*
>  	 * The TDX memory configuration is static and can not be
> -	 * changed.  Reject onlining any memory which is outside of
> +	 * changed.  Reject hot-adding any memory which is outside of
>  	 * the static configuration whether it supports TDX or not.
>  	 */
> -	if (is_tdx_memory(mn->start_pfn, mn->start_pfn + mn->nr_pages))
> -		return NOTIFY_OK;
> +	if (is_tdx_memory(start_pfn, end_pfn))
> +		return 0;
>  
> -	return NOTIFY_BAD;
> +	pr_info("Reject hot-adding memory range: %#llx-%#llx for TDX compatibility.\n",
> +		start, start + size);

Why not using pr_err() here?

I was checking which kind of information level we use when failing at
hot-adding memory, and we seem to be using pr_err(), and pr_debug() when
onlining/offlining.

Not a big deal, and not saying it is wrong, but was just wondering the reasoning
behind.


-- 
Oscar Salvador
SUSE Labs

