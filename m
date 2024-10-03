Return-Path: <linux-kernel+bounces-349152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD9898F1CA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 16:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AFD4281D25
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45D919F101;
	Thu,  3 Oct 2024 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qeHROMZH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+tRuteZ5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qeHROMZH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+tRuteZ5"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF69F126C13
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 14:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727966958; cv=none; b=YgFgKEW3gec0N26d952VEqrVCImcd6agF2M7ub2z0h2YsaJQ8GnXYRp9t4U99JFR5XkcHHuyfwF9IfNbWasn5rhUv8v6ANmsiBUPa2IBrpuAV+Si9U0Jtdr8Q6Eb4s7NZetOS0+d4rCX2eStyhNKuDwVJxBO7+vU4NUlODexxak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727966958; c=relaxed/simple;
	bh=zFgOAXLPaj/893bB/AmE3FEcVuxcgVijUjzbisQqyY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YI/Gc3OFjloMb+4O9MtLNhkcfe5F6Kj7XEmfW+LAWhPCJDW2hBKabDQmFAmhxwQE5Uq5jw3T7TnxqBwIL9tPvF0T9Ya0C4/cd9d0ngv2kZ4LyVfU+f9PzD9GoSkIr4eh1UiXYytWPgD9d9MN7FyvXSWfatMsVcq+lP1qlmgt+2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qeHROMZH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+tRuteZ5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qeHROMZH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+tRuteZ5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 013581FDF2;
	Thu,  3 Oct 2024 14:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727966954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PUMSKIIV3Gvmq2NSihehWA898ICrNIc6geNfrWzL1zI=;
	b=qeHROMZHxrOjU5rnLREWSoSLcpYZOEq3TfiUyeGwWNNewsDtKMvKTfYWEEBy2eMJ8QUz94
	74WvQd+a+Z22hWjsnDJ+mgY5fZWvVcsgXxyEwxpz5KV4N/cTG1JzyNqYvn+HxcGq7HxI6O
	HdwdLOuohXQ83v0BJisO7j8oh+yfWgA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727966954;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PUMSKIIV3Gvmq2NSihehWA898ICrNIc6geNfrWzL1zI=;
	b=+tRuteZ53PeYU6XFs6ugM0a/hFpQ+fyBxSQ8a8mrlo2D4CVLuauyVxyeAtW+v6CQAxGdNS
	8GCiuZsbJ6MlpnCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727966954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PUMSKIIV3Gvmq2NSihehWA898ICrNIc6geNfrWzL1zI=;
	b=qeHROMZHxrOjU5rnLREWSoSLcpYZOEq3TfiUyeGwWNNewsDtKMvKTfYWEEBy2eMJ8QUz94
	74WvQd+a+Z22hWjsnDJ+mgY5fZWvVcsgXxyEwxpz5KV4N/cTG1JzyNqYvn+HxcGq7HxI6O
	HdwdLOuohXQ83v0BJisO7j8oh+yfWgA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727966954;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PUMSKIIV3Gvmq2NSihehWA898ICrNIc6geNfrWzL1zI=;
	b=+tRuteZ53PeYU6XFs6ugM0a/hFpQ+fyBxSQ8a8mrlo2D4CVLuauyVxyeAtW+v6CQAxGdNS
	8GCiuZsbJ6MlpnCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE9D113882;
	Thu,  3 Oct 2024 14:49:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id odPmNemu/marVAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 03 Oct 2024 14:49:13 +0000
Message-ID: <3cbe26aa-1f6c-48c3-ad5e-203c98333dab@suse.cz>
Date: Thu, 3 Oct 2024 16:49:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: percpu: fix typo to pcpu_alloc_noprof() description
Content-Language: en-US
To: Jeongjun Park <aha310510@gmail.com>, dennis@kernel.org, tj@kernel.org,
 cl@linux.com
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Suren Baghdasaryan <surenb@google.com>
References: <20240924152412.118487-1-aha310510@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240924152412.118487-1-aha310510@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,linux.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 9/24/24 17:24, Jeongjun Park wrote:
> In the previous commit, the function name was changed from pcpu_alloc to 
> pcpu_alloc_noprof , but the function description was not changed accordingly.
> The function name should be changed to pcpu_alloc_noprof in the description
> as well.
> 
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>

See 51a7bf0238c2 ("scripts/kernel-doc: drop "_noprof" on function prototypes")

So in fact we can't do that now (as the bot reply suggests), even if
pcpu_alloc() doesnt seem to exist - all the hooks wrapping
pcpu_alloc_noprof() are named differently?

> ---
>  mm/percpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 20d91af8c033..7081b0ed59d6 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -1726,7 +1726,7 @@ static void pcpu_alloc_tag_free_hook(struct pcpu_chunk *chunk, int off, size_t s
>  #endif
>  
>  /**
> - * pcpu_alloc - the percpu allocator
> + * pcpu_alloc_noprof - the percpu allocator
>   * @size: size of area to allocate in bytes
>   * @align: alignment of area (max PAGE_SIZE)
>   * @reserved: allocate from the reserved chunk if available
> --
> 


