Return-Path: <linux-kernel+bounces-427046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 778519DFB93
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0721B22341
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F351F9428;
	Mon,  2 Dec 2024 08:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ljfnyQ99";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BGuhvRSx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N7fKio/+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cqJ2eX7F"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BF4F9E6
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 08:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733126528; cv=none; b=TBOdzcn9c1YZLqLETKRdPWYYbAH367m6qdWdtjHr2gV3NiF56c9QpTxlNofA7BncAXSW2wvjPzZkEHsX/MjyIVnuWhwnDexNBgm8ZSNmruPNngrWdFBO1Jp65mIPQ8OAjLsUtsBtjw5n1/MiiCFdImEjGFC91jAj1PJqNI22jM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733126528; c=relaxed/simple;
	bh=tt55vKZrPIjW1uGB05s8FrB5U6jLs1HUEP6ESjaB2Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DlNqHLPT4vcTB2ZgzjBdFOK92u8I+vpXuwhOOgaflSsw0EyJMtbLnMviudkHLNA+p2xwppyLwhItTinl5LXVPM6XjX5okyhSgXiRyrmP1uYqxUqjrR9CJ+TytV69CubErEb9egLKrHwYUwcNiiui/ztbjI3x7jjIA8Qiqyr6mPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ljfnyQ99; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BGuhvRSx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N7fKio/+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cqJ2eX7F; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E794B1F442;
	Mon,  2 Dec 2024 08:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733126525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TYi9YaPM8g/SjpzvzeWea/rBiqknKC5DNrxlBy+QMZs=;
	b=ljfnyQ99u76o7QAompCtuBwJkqvT3xIi8b25xHpltGejjGbebz/04YB/3fb8eVNSrNOAgm
	IS4dRdm37tWCE3w4zXhy96Fla9mVcy9477IpsPKc79AvFMNV7wdWVxoPynldyEpgAl57Va
	yq6sB4FAbeqB25iI97S3RrdnDWVBg1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733126525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TYi9YaPM8g/SjpzvzeWea/rBiqknKC5DNrxlBy+QMZs=;
	b=BGuhvRSxVY8oFlsGVQee6JA3bvwr/I89R4o/P0hQRCkVqOEil30CGlz6BbeTUXwaA9+PC3
	2/0vENWYSEd6ovBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="N7fKio/+";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cqJ2eX7F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733126524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TYi9YaPM8g/SjpzvzeWea/rBiqknKC5DNrxlBy+QMZs=;
	b=N7fKio/+GEszpOyV3K13LAGcTGFmcbb8iUPqOlkkAtbRUAnmKzs9WIQ5CqpFgMv94Ej9PZ
	7K96wUPglRjBmpTI/9cn8sirQ7rqwiuTNYW/gbIX5V1FL896p1PQ656BUthp6RKh3CHTeC
	DjSFjLlrT2BNRFf/4p2GtbNh3Mwyd7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733126524;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TYi9YaPM8g/SjpzvzeWea/rBiqknKC5DNrxlBy+QMZs=;
	b=cqJ2eX7FegPs8a8k3ZfVdYfBw+r/TFhtRp9pMNrijfI8HIkrvFvRpTKdgvmjtPRdBIdJFr
	HkREUNKrOAR8KPDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 63EC713A31;
	Mon,  2 Dec 2024 08:02:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Nu7LFnxpTWd5IAAAD6G6ig
	(envelope-from <aherrmann@suse.de>); Mon, 02 Dec 2024 08:02:04 +0000
Date: Mon, 2 Dec 2024 09:02:03 +0100
From: Andreas Herrmann <aherrmann@suse.de>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: x86@kernel.org, Andreas Herrmann <aherrmann@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
	Radu Rendec <rrendec@redhat.com>,
	Pierre Gondois <Pierre.Gondois@arm.com>, Pu Wen <puwen@hygon.cn>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Huang Ying <ying.huang@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/2] cacheinfo: Allocate memory during CPU hotplug if
 not done from the primary CPU
Message-ID: <20241202080203.GC4089@alberich>
References: <20241128002247.26726-1-ricardo.neri-calderon@linux.intel.com>
 <20241128002247.26726-2-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241128002247.26726-2-ricardo.neri-calderon@linux.intel.com>
X-Rspamd-Queue-Id: E794B1F442
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:email,suse.de:dkim,intel.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Nov 27, 2024 at 04:22:46PM -0800, Ricardo Neri wrote:
> Commit 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU")
> adds functionality that architectures can use to optionally allocate and
> build cacheinfo early during boot. Commit 6539cffa9495 ("cacheinfo: Add
> arch specific early level initializer") lets secondary CPUs correct (and
> reallocate memory) cacheinfo data if needed.
> 
> If the early build functionality is not used and cacheinfo does not need
> correction, memory for cacheinfo is never allocated. x86 does not use the
> early build functionality. Consequently, during the cacheinfo CPU hotplug
> callback, last_level_cache_is_valid() attempts to dereference a NULL
> pointer:
> 
>      BUG: kernel NULL pointer dereference, address: 0000000000000100
>      #PF: supervisor read access in kernel mode
>      #PF: error_code(0x0000) - not present page
>      PGD 0 P4D 0
>      Oops: 0000 [#1] PREEPMT SMP NOPTI
>      CPU: 0 PID 19 Comm: cpuhp/0 Not tainted 6.4.0-rc2 #1
>      RIP: 0010: last_level_cache_is_valid+0x95/0xe0a
> 
> Allocate memory for cacheinfo during the cacheinfo CPU hotplug callback if
> not done earlier.
> 
> Moreover, before determining the validity of the last-level cache info,
> ensure that it has been allocated. Simply checking for non-zero
> cache_leaves() is not sufficient, as some architectures (e.g., Intel
> processors) have non-zero cache_leaves() before allocation.
> 
> Dereferencing NULL cacheinfo can occur in update_per_cpu_data_slice_size().
> This function iterates over all online CPUs. However, a CPU may have come
> online recently, but its cacheinfo may not have been allocated yet.
> 
> While here, remove an unnecessary indentation in allocate_cache_info().
> 
> Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> Reviewed-by: Radu Rendec <rrendec@redhat.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Tested-by: Andreas Herrmann <aherrmann@suse.de>
> Fixes: 6539cffa9495 ("cacheinfo: Add arch specific early level initializer")
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---

Reviewed-by: Andreas Herrmann <aherrmann@suse.de>

-- 
Regards,
Andreas

