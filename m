Return-Path: <linux-kernel+bounces-427284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FC89DFF17
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 095E5281F27
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06311FC11E;
	Mon,  2 Dec 2024 10:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NRRzMLVu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="r4eC7CtN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N7td421d";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AoxFt51K"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C143156C40
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 10:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733135860; cv=none; b=Y14qdKaOhdsW937nXBf32olzfZgtLsWTqM8ZE9/8uWiAWameXNVzQFsew4LwLZYfb9v7Rs/ggAvpYcsMoePm8Syb7qjqiCg0o16k3dmvztlJHwqH35Xs06tMBi7L6V55kc3XTXo2F2WgatJ+dv6/+QyXOuFlM+wjrncOZ/qqRnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733135860; c=relaxed/simple;
	bh=kulZHo2eGqHHW3CAYhUEsfIXSHlSvNL848Eejifpvrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjnV3R69sncrR8HlPONSzQzbVVVdX+V4d4ZQib3yLwbj3CF+OSnY19t1mzSscRtYzf59CRm6PpRnGmFtPc/7O3l/ZILBqnKvvctvldF9L+6DOirewbjp8iOeLaBbbgWzjmkPsq2X46a5ArFiqlyDqH/1pn0gPw0l5P2ViwpaW8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NRRzMLVu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=r4eC7CtN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N7td421d; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AoxFt51K; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CC5521F452;
	Mon,  2 Dec 2024 10:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733135851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MoayjsmtHtuWFe/nYuRkVJvWSmW7XjN4TkwXZL4rSEI=;
	b=NRRzMLVuZ6PwRDJgo6brsDQrSfNeL+7IzjVCTH6UaMloQhMk9hgW3pqaKe09rnXVMbzBHx
	GY8ORgLXkJ8oyLjf5DGen+Ad9sjBAKhsUPknUShxLBFVpWBTk72iXKFhTLB8cR8gGw+ZPw
	HyYyz+zgbJ2sX22ZGk/6kEn6t+bf4Lg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733135851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MoayjsmtHtuWFe/nYuRkVJvWSmW7XjN4TkwXZL4rSEI=;
	b=r4eC7CtNo31etFtez0MQX8rqTlLli+lA7wDdIchJxFkIYBxe0+OI86zRLRK3hzizU/tDcL
	Sgtn3U/ULBtXd/Dg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=N7td421d;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=AoxFt51K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733135850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MoayjsmtHtuWFe/nYuRkVJvWSmW7XjN4TkwXZL4rSEI=;
	b=N7td421du4YjwGN7xEYNuy4h183H7AJfcONB9Vt/ygmUjACHujnPZ4jalScxteTqK4sB/J
	1CIJtbrrlWzYgHHo71Vt7x1Q5b0jWUG/j29yMG2ACHhC3EmzbN4uIBmZc1FKVhPiKsl9TZ
	7rMGWrs66ko949DyqFm3HTdxvvmV3Q8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733135850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MoayjsmtHtuWFe/nYuRkVJvWSmW7XjN4TkwXZL4rSEI=;
	b=AoxFt51KbRENFVeBbizW5pRWXy1bvZn0QwjgPn6CK09htMLFsrtQsrATr2GBNDd6Yqxi48
	3rMmbKsDicpJmCDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 586EB13A31;
	Mon,  2 Dec 2024 10:37:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E3uwEuqNTWfpUgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 02 Dec 2024 10:37:30 +0000
Date: Mon, 2 Dec 2024 11:37:24 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb: Make __NR_USED_SUBPAGE check conditional
Message-ID: <Z02N5PnYa_S_ISeg@localhost.localdomain>
References: <20241202090728.78935-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202090728.78935-1-anshuman.khandual@arm.com>
X-Rspamd-Queue-Id: CC5521F452
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,arm.com:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Dec 02, 2024 at 02:37:28PM +0530, Anshuman Khandual wrote:
> The HugeTLB order check against __NR_USED_SUBPAGE is required only when
> HUGETLB_PAGE_OPTIMIZE_VMEMMAP is enabled. Hence BUG_ON() trigger should
> happen only when applicable.
> 
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
...
> +
>  	BUG_ON(hugetlb_max_hstate >= HUGE_MAX_HSTATE);
> +#ifdef HUGETLB_PAGE_OPTIMIZE_VMEMMAP

 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP ?
 

-- 
Oscar Salvador
SUSE Labs

