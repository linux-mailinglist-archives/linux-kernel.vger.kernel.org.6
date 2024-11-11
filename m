Return-Path: <linux-kernel+bounces-403889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A12909C3C4B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E6462828F0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E425A19AD71;
	Mon, 11 Nov 2024 10:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="chH0u9RU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b4CuQKn/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z8ATjqtO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NJhsr08+"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F3C1A0AE1;
	Mon, 11 Nov 2024 10:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321654; cv=none; b=P+AYs4iZYcabWn3IUdyYz+lPHDa6OpV5//F4Ncc4v4iRgr7vQ5uE5bOo7a+VdSOvlOtJdB7kRveFYaGmzhh64zxnpnNOakpoVAaupNzsfO1RkCA+6ery8vTIHlo+5SljpcrVF7+Jt3na9j9xbGyuZGjVAvipsvRgnel3jSJOy9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321654; c=relaxed/simple;
	bh=fOkdmPZDGjju7rzkbovfqpK4GxPQOtQyDWcYY6gofck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZRxdFsWYABGaTbCG62ARieQ1sC0R9thbX4lN1lreOOwWb7884tP4cd9+sraYO94eyemtfA3vYC/jc1vmNKjF8Z/0dSVdosmON7036QWpEcG0z91zTCfn8W61B6aD8WNPutL9CwcR6FjDpauBTW3AYgazWmBrTs1o7mbLKIRPAfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=chH0u9RU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b4CuQKn/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z8ATjqtO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NJhsr08+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E16211F38E;
	Mon, 11 Nov 2024 10:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731321650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Sy3P7l50jw5Q3m02cbagM28IC7Qgliycy6c/QZpm90g=;
	b=chH0u9RUGnf6cL2ueMITdUf9zqDoLVy83InaCfwVEhnQmm/nWsAJ80YQXzlCoyeDHFqhh5
	i//YS9utH4kxWd4tXRQRR0NMmYAjB11Zk6KjdpRMiXoDWjY4s+vF4U4OUWpCCznNFPJ2Ab
	hX/8DdiUpa0UUyooAs9jsN5dND1Z77o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731321650;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Sy3P7l50jw5Q3m02cbagM28IC7Qgliycy6c/QZpm90g=;
	b=b4CuQKn/gKUPj7KpHAUa4qd0PxIJGQfLK3ty7KDDdocACwMp7TA3TqIdDtVLf7VWiuv/+k
	evxyocthuAS+yEBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=z8ATjqtO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NJhsr08+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731321649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Sy3P7l50jw5Q3m02cbagM28IC7Qgliycy6c/QZpm90g=;
	b=z8ATjqtOIYsEk2UWms31pBSVru8Lj8u/sg2scunR4R4oF8WH9CR4th18dZomlluSQ1XlEo
	FynkMzh8Pbl+7VtXetLQU/Fr5s5MCKE8pey7YEZRKUm8PPe41N72r8jj1ijYVH9NFZkk5n
	e7WVzFquwtlAvAlNKMpltEhh0vvSdDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731321649;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Sy3P7l50jw5Q3m02cbagM28IC7Qgliycy6c/QZpm90g=;
	b=NJhsr08+NV9ZlH8mafwy0AA0AKiRzuQsZOpjnMcASRjBtt+V2Uur7GHg44Wk5mqGSmpwHA
	WWO4fkOeb8cN9xDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB63613301;
	Mon, 11 Nov 2024 10:40:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lXseMTHfMWcEHQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 11 Nov 2024 10:40:49 +0000
Message-ID: <f6e053b5-982d-472b-9c75-95d7f390bd68@suse.cz>
Date: Mon, 11 Nov 2024 11:40:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2024-50219: mm/page_alloc: let GFP_ATOMIC order-0 allocs
 access highatomic reserves
Content-Language: en-US
To: cve@kernel.org, linux-kernel@vger.kernel.org,
 linux-cve-announce@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Matt Fleming <mfleming@cloudflare.com>
References: <2024110925-CVE-2024-50219-c970@gregkh>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <2024110925-CVE-2024-50219-c970@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E16211F38E
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 11/9/24 11:15, Greg Kroah-Hartman wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> mm/page_alloc: let GFP_ATOMIC order-0 allocs access highatomic reserves
> 
> Under memory pressure it's possible for GFP_ATOMIC order-0 allocations to
> fail even though free pages are available in the highatomic reserves. 
> GFP_ATOMIC allocations cannot trigger unreserve_highatomic_pageblock()
> since it's only run from reclaim.
> 
> Given that such allocations will pass the watermarks in
> __zone_watermark_unusable_free(), it makes sense to fallback to highatomic
> reserves the same way that ALLOC_OOM can.
> 
> This fixes order-0 page allocation failures observed on Cloudflare's fleet
> when handling network packets:

Hi,

I would like to dispute the CVE. GFP_ATOMIC page allocations failures can
generally happen (typically from network receive path, like here) and should
always have a fallback. The impact could be somewhat worse performance at
worst. AFAIK they are not affected by panic_on_warn nor panic_on_oom either,
it's a pr_warn(), so I don't think there's a DoS vector.

It would be also nice to adjust any automatic flagging to distinguish this
for the future.

Thanks,
Vlastimil

>   kswapd1: page allocation failure: order:0, mode:0x820(GFP_ATOMIC),
>   nodemask=(null),cpuset=/,mems_allowed=0-7
>   CPU: 10 PID: 696 Comm: kswapd1 Kdump: loaded Tainted: G           O 6.6.43-CUSTOM #1
>   Hardware name: MACHINE
>   Call Trace:
>    <IRQ>
>    dump_stack_lvl+0x3c/0x50
>    warn_alloc+0x13a/0x1c0
>    __alloc_pages_slowpath.constprop.0+0xc9d/0xd10
>    __alloc_pages+0x327/0x340
>    __napi_alloc_skb+0x16d/0x1f0
>    bnxt_rx_page_skb+0x96/0x1b0 [bnxt_en]
>    bnxt_rx_pkt+0x201/0x15e0 [bnxt_en]
>    __bnxt_poll_work+0x156/0x2b0 [bnxt_en]
>    bnxt_poll+0xd9/0x1c0 [bnxt_en]
>    __napi_poll+0x2b/0x1b0
>    bpf_trampoline_6442524138+0x7d/0x1000
>    __napi_poll+0x5/0x1b0
>    net_rx_action+0x342/0x740
>    handle_softirqs+0xcf/0x2b0
>    irq_exit_rcu+0x6c/0x90
>    sysvec_apic_timer_interrupt+0x72/0x90
>    </IRQ>
> 
> [mfleming@cloudflare.com: update comment]
>   Link: https://lkml.kernel.org/r/20241015125158.3597702-1-matt@readmodwrite.com
> 
> The Linux kernel CVE team has assigned CVE-2024-50219 to this issue.
> 
> 
> Affected and fixed versions
> ===========================
> 
> 	Issue introduced in 5.9 with commit 1d91df85f399 and fixed in 5.15.171 with commit 4c4e238d3ada
> 	Issue introduced in 5.9 with commit 1d91df85f399 and fixed in 6.1.116 with commit 189b954469cf
> 	Issue introduced in 5.9 with commit 1d91df85f399 and fixed in 6.6.60 with commit b958948ae1cb
> 	Issue introduced in 5.9 with commit 1d91df85f399 and fixed in 6.11.7 with commit d0fdacfb85a3
> 	Issue introduced in 5.9 with commit 1d91df85f399 and fixed in 6.12-rc6 with commit 281dd25c1a01
> 
> Please see https://www.kernel.org for a full list of currently supported
> kernel versions by the kernel community.
> 
> Unaffected versions might change over time as fixes are backported to
> older supported kernel versions.  The official CVE entry at
> 	https://cve.org/CVERecord/?id=CVE-2024-50219
> will be updated if fixes are backported, please check that for the most
> up to date information about this issue.
> 
> 
> Affected files
> ==============
> 
> The file(s) affected by this issue are:
> 	mm/page_alloc.c
> 
> 
> Mitigation
> ==========
> 
> The Linux kernel CVE team recommends that you update to the latest
> stable kernel version for this, and many other bugfixes.  Individual
> changes are never tested alone, but rather are part of a larger kernel
> release.  Cherry-picking individual commits is not recommended or
> supported by the Linux kernel community at all.  If however, updating to
> the latest release is impossible, the individual changes to resolve this
> issue can be found at these commits:
> 	https://git.kernel.org/stable/c/4c4e238d3adad3c94bb255d0f117d3685bbfdd33
> 	https://git.kernel.org/stable/c/189b954469cf82f8b8cf496f8de94b006d2d4746
> 	https://git.kernel.org/stable/c/b958948ae1cb3e39c48e9f805436fd652103c71e
> 	https://git.kernel.org/stable/c/d0fdacfb85a3e1223b894cc6e60091ec91049e9e
> 	https://git.kernel.org/stable/c/281dd25c1a018261a04d1b8bf41a0674000bfe38
> 


