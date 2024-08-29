Return-Path: <linux-kernel+bounces-306334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 205ED963D98
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71D75B236C6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4BC189B99;
	Thu, 29 Aug 2024 07:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mnRcuR1b";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mMtCLaZ6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mnRcuR1b";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mMtCLaZ6"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC511898E8
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 07:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724917781; cv=none; b=rsL6UACnBBq5f2RSmekhkgn/b9W0qNcY+bJ6XCfJ0qOqdIzn34vg5bHFoA96sAOLd5cimi9ePJNcgWywOUkwIISJn7Z2ot1R7WmyRLdFRLQXBy+zvP/REF0ljzSR1pfL/nJjfCvJox4Y8gQsdd2iPmW5SuWZQBNEj1KdCAQJ1hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724917781; c=relaxed/simple;
	bh=L6dvGWJhefL3O4KuMY6g1WRuqh59ISbecjgydlg5c5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Az13JPGDCellY+I5vikRSLSiOx5Bb7WoYsoI74dNM8sIhsZt6TzuQKDnfH71tHsfwkskiIpQxXJY6FB2qZwjqQUpMSyN1wsCw/KTVuWcHoj4wAXQh23uC0NqAE/BOW9BlW1uwALQ2Zj8TSKezq6PgmgKW9ZVyF9+VnPSt+9r0jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mnRcuR1b; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mMtCLaZ6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mnRcuR1b; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mMtCLaZ6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2E3871F7CD;
	Thu, 29 Aug 2024 07:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724917772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DSOkUjWbLC3ZiHsW8MmncSf9ua8YcybkM8ENoIXpScg=;
	b=mnRcuR1b0nF/SlxbSy7JcbFX2VXWMIYcec+HKre54Bx9BKikhpN4EjMn/NXMsHoexiqMb5
	kEp368wbtOAXwTZngMJrpprP9d8xH7e3RGTjvOJMfiNyZf1v4MQ3vJfbO4XKdaNw/LBgsm
	huJokZTvrtOv0aN9HHU3Xjfcyb45MsQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724917772;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DSOkUjWbLC3ZiHsW8MmncSf9ua8YcybkM8ENoIXpScg=;
	b=mMtCLaZ6x94daa+OfYeqiU24TDqN55nAMiUR6339BajwRYNeRijsCcOjXvDYHLvN9oFevK
	GDZMEnSD9gUkyvDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724917772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DSOkUjWbLC3ZiHsW8MmncSf9ua8YcybkM8ENoIXpScg=;
	b=mnRcuR1b0nF/SlxbSy7JcbFX2VXWMIYcec+HKre54Bx9BKikhpN4EjMn/NXMsHoexiqMb5
	kEp368wbtOAXwTZngMJrpprP9d8xH7e3RGTjvOJMfiNyZf1v4MQ3vJfbO4XKdaNw/LBgsm
	huJokZTvrtOv0aN9HHU3Xjfcyb45MsQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724917772;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DSOkUjWbLC3ZiHsW8MmncSf9ua8YcybkM8ENoIXpScg=;
	b=mMtCLaZ6x94daa+OfYeqiU24TDqN55nAMiUR6339BajwRYNeRijsCcOjXvDYHLvN9oFevK
	GDZMEnSD9gUkyvDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 121C4139B0;
	Thu, 29 Aug 2024 07:49:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vkkMBAwo0GYEUwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 29 Aug 2024 07:49:32 +0000
Message-ID: <90df6237-f6bd-42b1-a755-659c5e76f527@suse.cz>
Date: Thu, 29 Aug 2024 09:49:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mm, slub: avoid zeroing kmalloc redzone
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Christoph Lameter
 <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Feng Tang <feng.tang@intel.com>,
 "open list:SLAB ALLOCATOR" <linux-mm@kvack.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: Peng Fan <peng.fan@nxp.com>
References: <20240829032911.2801669-1-peng.fan@oss.nxp.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240829032911.2801669-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[oss.nxp.com,linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,intel.com,kvack.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 8/29/24 05:29, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Since commit 946fa0dbf2d8 ("mm/slub: extend redzone check to extra
> allocated kmalloc space than requested"), setting orig_size treats
> the wasted space (object_size - orig_size) as a redzone. However with
> init_on_free=1 we clear the full object->size, including the redzone.
> 
> Additionally we clear the object metadata, including the stored orig_size,
> making it zero, which makes check_object() treat the whole object as a
> redzone.
> 
> These issues lead to the following BUG report with "slub_debug=FUZ
> init_on_free=1":
> 
> [    0.000000] =============================================================================
> [    0.000000] BUG kmalloc-8 (Not tainted): kmalloc Redzone overwritten
> [    0.000000] -----------------------------------------------------------------------------
> [    0.000000]
> [    0.000000] 0xffff000010032858-0xffff00001003285f @offset=2136. First byte 0x0 instead of 0xcc
> [    0.000000] FIX kmalloc-8: Restoring kmalloc Redzone 0xffff000010032858-0xffff00001003285f=0xcc
> [    0.000000] Slab 0xfffffdffc0400c80 objects=36 used=23 fp=0xffff000010032a18 flags=0x3fffe0000000200(workingset|node=0|zone=0|lastcpupid=0x1ffff)
> [    0.000000] Object 0xffff000010032858 @offset=2136 fp=0xffff0000100328c8
> [    0.000000]
> [    0.000000] Redzone  ffff000010032850: cc cc cc cc cc cc cc cc                          ........
> [    0.000000] Object   ffff000010032858: cc cc cc cc cc cc cc cc                          ........
> [    0.000000] Redzone  ffff000010032860: cc cc cc cc cc cc cc cc                          ........
> [    0.000000] Padding  ffff0000100328b4: 00 00 00 00 00 00 00 00 00 00 00 00              ............
> [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.11.0-rc3-next-20240814-00004-g61844c55c3f4 #144
> [    0.000000] Hardware name: NXP i.MX95 19X19 board (DT)
> [    0.000000] Call trace:
> [    0.000000]  dump_backtrace+0x90/0xe8
> [    0.000000]  show_stack+0x18/0x24
> [    0.000000]  dump_stack_lvl+0x74/0x8c
> [    0.000000]  dump_stack+0x18/0x24
> [    0.000000]  print_trailer+0x150/0x218
> [    0.000000]  check_object+0xe4/0x454
> [    0.000000]  free_to_partial_list+0x2f8/0x5ec
> 
> To address the issue, use orig_size to clear the used area. And restore
> the value of orig_size after clear the remaining area.
> 
> When CONFIG_SLUB_DEBUG not defined, (get_orig_size()' directly returns
> s->object_size. So when using memset to init the area, the size can simply
> be orig_size, as orig_size returns object_size when CONFIG_SLUB_DEBUG not
> enabled. And orig_size can never be bigger than object_size.
> 
> Fixes: 946fa0dbf2d8 ("mm/slub: extend redzone check to extra allocated kmalloc space than requested")
> Reviewed-by: Feng Tang <feng.tang@intel.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Thanks, added to slab/for-next


