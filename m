Return-Path: <linux-kernel+bounces-554833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 418E3A5A0AD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71C88172D0C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7577233155;
	Mon, 10 Mar 2025 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b3xKyfCD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XEdzQ6Os";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b3xKyfCD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XEdzQ6Os"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B81232369
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 17:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741629149; cv=none; b=fI/FFs7KfRqnei28h8v2QNM8r4rguESIlbD/mukwRG8sLYvofO0Pi4NhpkFuNJJZ65DeyeuUtwt1AtajM5BFLv2Md5VXORySAVYgXdSKqpZxu3WJ2fPRD+4iyN05LM90J9hA+3MKxuEvsjYlIO5clzkA++BzNFcBH3dUWRQ03Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741629149; c=relaxed/simple;
	bh=PH6dCdoQKJ4tPfQFywdakMLx5XoUPTA3qpHs6ckukdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i5BkafdhIxfEHVjgMNPZhoqU1eKY01Q5YuZB10EVAK29H68NpaSnlr+5PR02ludnpjHfrEkdaKuv1qoLnICXrmXzyd3kWEuypXEjwiTJVOQmiaIhI+NgmwRjetYrHoATxarrMDb29xVle+wOYkvC6ZamD1WQ+WAHyjX2hgzFKUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=b3xKyfCD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XEdzQ6Os; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=b3xKyfCD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XEdzQ6Os; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8C0001F393;
	Mon, 10 Mar 2025 17:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741629145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ZNNFzLW+s59eHnXQyTn8Lm4Z2jh00lQpZl3pknjAdA=;
	b=b3xKyfCDqjktdTF1cokFAmJG3ezB50JTCo4IiXkfTtoWG7/TVad3GczBjSY4/JoTM2x0DP
	AhOV4Wh+FmoY0zikIpb4kGp7b3wbGMhlltxRHN6ZzmfK7AopGGE2Bn3Vj4uUD8OgtkamCt
	W5ksJqDctPfOCb0HLDJvrmVOjtZ1k/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741629145;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ZNNFzLW+s59eHnXQyTn8Lm4Z2jh00lQpZl3pknjAdA=;
	b=XEdzQ6Os1FscXLy/3Xtw2UEgdgF5CUW1DnhSPafNvysEyQWXbR9qN2+3rc3wKSd9rf9Aim
	b+kMB0GpOE13YHCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741629145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ZNNFzLW+s59eHnXQyTn8Lm4Z2jh00lQpZl3pknjAdA=;
	b=b3xKyfCDqjktdTF1cokFAmJG3ezB50JTCo4IiXkfTtoWG7/TVad3GczBjSY4/JoTM2x0DP
	AhOV4Wh+FmoY0zikIpb4kGp7b3wbGMhlltxRHN6ZzmfK7AopGGE2Bn3Vj4uUD8OgtkamCt
	W5ksJqDctPfOCb0HLDJvrmVOjtZ1k/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741629145;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ZNNFzLW+s59eHnXQyTn8Lm4Z2jh00lQpZl3pknjAdA=;
	b=XEdzQ6Os1FscXLy/3Xtw2UEgdgF5CUW1DnhSPafNvysEyQWXbR9qN2+3rc3wKSd9rf9Aim
	b+kMB0GpOE13YHCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76C121399F;
	Mon, 10 Mar 2025 17:52:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BuCMHNkmz2fveAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 10 Mar 2025 17:52:25 +0000
Message-ID: <38628bf6-1676-409a-9712-15095eec8dc1@suse.cz>
Date: Mon, 10 Mar 2025 18:52:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] mm/mremap: thread state through move page table
 operation
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jann Horn
 <jannh@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>
References: <cover.1741256580.git.lorenzo.stoakes@oracle.com>
 <1d85814f3a73eaa241c554b3e0f751f3e267a467.1741256580.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <1d85814f3a73eaa241c554b3e0f751f3e267a467.1741256580.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,oracle.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On 3/6/25 11:34, Lorenzo Stoakes wrote:
> Finish refactoring the page table logic by threading the PMC state
> throughout the operation, allowing us to control the operation as we go.
> 
> Additionally, update the old_addr, new_addr fields in move_page_tables()
> as we progress through the process making use of the fact we have this
> state object now to track this.
> 
> With these changes made, not only is the code far more readable, but we
> can finally transmit state throughout the entire operation, which lays the
> groundwork for sensibly making changes in future to how the mremap()
> operation is performed.
> 
> Additionally take the opportunity to refactor the means of determining the
> progress of the operation, abstracting this to pmc_progress() and
> simplifying the logic to make it clearer what's going on.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Small nit:

>  
> +/*
> + * Should move_pgt_entry() acquire the rmap locks? This is either expressed in
> + * the PMC, or overridden in the case of normal, larger page tables.
> + */
> +static bool should_take_rmap_locks(struct pagetable_move_control *pmc,
> +				   enum pgt_entry entry)
> +{
> +	if (pmc->need_rmap_locks)
> +		return true;
> +
> +	switch (entry) {
> +	case NORMAL_PMD:
> +	case NORMAL_PUD:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +

IMHO the "overriden" logic would be more obvious if we removed the initial
"if" and just had default: return pmc->need_rmap_locks

