Return-Path: <linux-kernel+bounces-353221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77795992A97
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C15A2836A5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 11:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E901C0DF0;
	Mon,  7 Oct 2024 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bCeyPW0S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VxdhU9lq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bCeyPW0S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VxdhU9lq"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866CB18A6AD
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 11:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728301653; cv=none; b=Dt0EVDncuXt89mrNy4WhoqePFQRKWlMrECL0cVgkwsxDXohgDc1UuUe2cDWOvCyad0pNWIE8WqQbsXW5UhZGysW7nNyixhEdceudOXgsAS2fzASZNgLIZK6H/5QPixNd5R/TfF/jgwAlcTXce304chhkjw/9k0d85z8hN59r508=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728301653; c=relaxed/simple;
	bh=wzyolnc6U3EBzFnkQ2YYsbdTqPSHZWebpaxbLJHj9qQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tzqFQB3PPlI+bUxPHkioHnPiWGOCnoKjvLYshHZSrE7PEhsDcgsctpgxO0naEhhPSkTwUuTd+pX4Cw8SYjXV1LvIh+yNRTkCib4qSsLDQmMbPg37S++RLSPq9jvNgCPxeMwmQkkfiLAxaaD4DZ6l1RqGmatPMxuyi7W2GDfkj/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bCeyPW0S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VxdhU9lq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bCeyPW0S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VxdhU9lq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 816B71FD45;
	Mon,  7 Oct 2024 11:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728301648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1UTFpXNKbCeN1tjzX5ImmjYoFdTF2FcVBKBRyUvUqM4=;
	b=bCeyPW0SiunQZXjwSx1hucUCl4BNtx70o4xmhySXSPRvJ3C7FMceWpwYtS7hRIqvwkhski
	YIk3mTGg0d8yZR87Rm3Fg44Hcznl6cmFXPyYp/6d4Sc3J/ziNjxcIrWf98l/Lcz8NuFNS1
	PbCOTR5lQm21uRhb+Xf9Wicf/w36HZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728301648;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1UTFpXNKbCeN1tjzX5ImmjYoFdTF2FcVBKBRyUvUqM4=;
	b=VxdhU9lq/SoC1l1jEFQeFeHc1d/fvmwsYOisBmdbcmrVo5ZeDeoHN/pUJxgsCa3srAIJgd
	DLMkR1mI4KL1TlDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bCeyPW0S;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VxdhU9lq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728301648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1UTFpXNKbCeN1tjzX5ImmjYoFdTF2FcVBKBRyUvUqM4=;
	b=bCeyPW0SiunQZXjwSx1hucUCl4BNtx70o4xmhySXSPRvJ3C7FMceWpwYtS7hRIqvwkhski
	YIk3mTGg0d8yZR87Rm3Fg44Hcznl6cmFXPyYp/6d4Sc3J/ziNjxcIrWf98l/Lcz8NuFNS1
	PbCOTR5lQm21uRhb+Xf9Wicf/w36HZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728301648;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1UTFpXNKbCeN1tjzX5ImmjYoFdTF2FcVBKBRyUvUqM4=;
	b=VxdhU9lq/SoC1l1jEFQeFeHc1d/fvmwsYOisBmdbcmrVo5ZeDeoHN/pUJxgsCa3srAIJgd
	DLMkR1mI4KL1TlDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 745AD13786;
	Mon,  7 Oct 2024 11:47:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IgElHFDKA2d4QwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 07 Oct 2024 11:47:28 +0000
Message-ID: <ac29dce6-468a-4249-ba17-36be2ce8b1f8@suse.cz>
Date: Mon, 7 Oct 2024 13:50:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Remove misleading 'unlikely' hint in
 vms_gather_munmap_vmas()
To: Breno Leitao <leitao@debian.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: kernel-team@meta.com, "open list:VMA" <linux-mm@kvack.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20241004164832.218681-1-leitao@debian.org>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <20241004164832.218681-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 816B71FD45
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 10/4/24 6:48 PM, Breno Leitao wrote:
> Performance analysis using branch annotation on a fleet of 200 hosts
> running web servers revealed that the 'likely' hint in
> vms_gather_munmap_vmas() was 100% consistently incorrect. In all
> observed cases, the branch behavior contradicted the hint.
> 
> Remove the 'unlikely' qualifier from the condition checking 'vms->uf'.
> By doing so, we allow the compiler to make optimization decisions based
> on its own heuristics and profiling data, rather than relying on a
> static hint that has proven to be inaccurate in real-world scenarios.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/vma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vma.c b/mm/vma.c
> index 4737afcb064c..9d4fe794dd07 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -1250,7 +1250,7 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>  		else if (is_data_mapping(next->vm_flags))
>  			vms->data_vm += nrpages;
>  
> -		if (unlikely(vms->uf)) {
> +		if (vms->uf) {
>  			/*
>  			 * If userfaultfd_unmap_prep returns an error the vmas
>  			 * will remain split, but userland will get a

