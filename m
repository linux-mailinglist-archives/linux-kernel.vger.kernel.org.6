Return-Path: <linux-kernel+bounces-408175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B33D9C7B74
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91F0EB26537
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFC920401E;
	Wed, 13 Nov 2024 18:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fcK7xueT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RDWUaPX8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fcK7xueT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RDWUaPX8"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B10374C4
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 18:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731523272; cv=none; b=deIsSvh0X8TCqPEgPN1PXS/YRN5Ua+q8yjM5oX90gxuDEvQDCgBKOb44q0+ChhLoqQEfhmj9iONxj/i9U0enKymDlVXp94FA2U/oYep5pim+3EbAmfKsLjTt1C3dcL00xU7fnk0XylU3LiCuhILK6Hg07tWOc17I7C2V/tfNnh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731523272; c=relaxed/simple;
	bh=tCu/a3qI1KV/fp1POlDk12WXoro6FEo/k8kK858a/A0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UCarNfnZ8BCb8RyopzA8BRV808HF3hYAXTsxAhAElhHYpDGFh7oWhuFdulQx/Gkhbgn1cEaVh846EjuQRmGMsMf7rbIgZmOpH0g3VU3fA9/dee+vWKDweFjpGupPCeB76R+L7zOof3q0uqQ2nC7u+3o3RpTfRTst1k8BQUS5rJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fcK7xueT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RDWUaPX8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fcK7xueT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RDWUaPX8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8A30A1F395;
	Wed, 13 Nov 2024 18:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731523268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8sUM0M8V19GhSGnm250+NhsypvBxJkhxWwffbG/Q0pg=;
	b=fcK7xueTJ0PuKs90qHioaV8SFjsyS1jXkPgG5HYQhJw96gVskquKLeRY7AouPnGZavmrsN
	6A8u731/DlZWdmbaHLEVKEXF8Uji6kOu7okB/he0y/AE0K8EJ/BKotqA0Oqrph2Kyxcu+/
	GDvflev2fG96kuSLHAzAHD1HR6R0fPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731523268;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8sUM0M8V19GhSGnm250+NhsypvBxJkhxWwffbG/Q0pg=;
	b=RDWUaPX8u4XZ41JjLp3RxA2x1CXg0+3bqlW4ra9Drs8mSvnezJfrcETk31RcRboVWTjilk
	809HjqOTE0dqDuCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731523268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8sUM0M8V19GhSGnm250+NhsypvBxJkhxWwffbG/Q0pg=;
	b=fcK7xueTJ0PuKs90qHioaV8SFjsyS1jXkPgG5HYQhJw96gVskquKLeRY7AouPnGZavmrsN
	6A8u731/DlZWdmbaHLEVKEXF8Uji6kOu7okB/he0y/AE0K8EJ/BKotqA0Oqrph2Kyxcu+/
	GDvflev2fG96kuSLHAzAHD1HR6R0fPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731523268;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8sUM0M8V19GhSGnm250+NhsypvBxJkhxWwffbG/Q0pg=;
	b=RDWUaPX8u4XZ41JjLp3RxA2x1CXg0+3bqlW4ra9Drs8mSvnezJfrcETk31RcRboVWTjilk
	809HjqOTE0dqDuCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67D7213A6E;
	Wed, 13 Nov 2024 18:41:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uV/zGMTyNGfXXgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 13 Nov 2024 18:41:08 +0000
Message-ID: <82e15a21-c5ee-45a4-add6-fcb94c6fcc71@suse.cz>
Date: Wed, 13 Nov 2024 19:41:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] sched/numa: Fix memory leak due to the overwritten
 vma->numab_state
Content-Language: en-US
To: Adrian Huang <adrianhuang0701@gmail.com>, raghavendra.kt@amd.com
Cc: ahuang12@lenovo.com, akpm@linux-foundation.org, bsegall@google.com,
 dietmar.eggemann@arm.com, juri.lelli@redhat.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mgorman@suse.de,
 mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
 sunjw10@lenovo.com, vincent.guittot@linaro.org, vschneid@redhat.com
References: <1794be3c-358c-4cdc-a43d-a1f841d91ef7@amd.com>
 <20241111100809.20527-1-ahuang12@lenovo.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20241111100809.20527-1-ahuang12@lenovo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.24
X-Spamd-Result: default: False [-4.24 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.14)[-0.705];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com,amd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On 11/11/24 11:08, Adrian Huang wrote:
> <snip>
>>However since there are 800 threads, I see there might be an opportunity
>>for another thread to enter in the next 'numa_scan_period' while
>>we have not gotten till numab_state allocation.
>>
>>There should be simpler ways to overcome like Vlastimil already pointed
>>in the other thread, and having lock is an overkill.
>>
>>for e.g.,
>>numab_state = kzalloc(..)
>>
>>if we see that some other thread able to successfully assign
>>vma->numab_state with their allocation (with cmpxchg), simply
>>free your allocation.
>>
>>Can you please check if my understanding is correct?
> 
> Thanks for Vlastimil's and Raghu's reviews and comments.
> 
> Yes, your understanding is correct. Before submitting this patch,
> I had two internal proposals: lock and cmpxchg. Here is the my cmpxchg
> version (Test passed). If you're ok with this cmpxchg version, may I have
> your reviewed-by? I'll send a v2 then.

Yeah much better, thanks!

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 3356315d7e64..7f99df294583 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3399,10 +3399,16 @@ static void task_numa_work(struct callback_head *work)
>  
>  		/* Initialise new per-VMA NUMAB state. */
>  		if (!vma->numab_state) {
> -			vma->numab_state = kzalloc(sizeof(struct vma_numab_state),
> -				GFP_KERNEL);
> -			if (!vma->numab_state)
> +			struct vma_numab_state *ptr;
> +
> +			ptr = kzalloc(sizeof(*ptr), GFP_KERNEL);
> +			if (!ptr)
> +				continue;
> +
> +			if (cmpxchg(&vma->numab_state, NULL, ptr)) {
> +				kfree(ptr);
>  				continue;
> +			}
>  
>  			vma->numab_state->start_scan_seq = mm->numa_scan_seq;
> 
> 


