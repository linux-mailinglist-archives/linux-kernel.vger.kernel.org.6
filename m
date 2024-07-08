Return-Path: <linux-kernel+bounces-244036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CD4929E3E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 10:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95EA5283365
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968323FB1B;
	Mon,  8 Jul 2024 08:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w8oaJ4CP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4SqZ+WtW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w8oaJ4CP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4SqZ+WtW"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537632F874
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 08:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720427061; cv=none; b=tHRTNj5XPG1myz7ym1fmz4BHrelZJg6rHRH3EDXuQbT/Y8EwA3iVe4HTcpsUuH/LjXCf++KM00FB2QwWiqHUcs6QYxaE/NzWIHmfH3IKDzrKBmMRFRzKs+9kw7RIVcaGNlYjqCrt+XxQNDMoNjLyJHXJaESf7mKpIAsT2LE++VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720427061; c=relaxed/simple;
	bh=Rqpgfk5yllfmXjmDkL3KMnbUFsRhx+/BYSvXdnNTtKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSJ3gUD5tm8V5o8mfAQZOAlJEdD5yUCTZlr5XWD+prVYNK9Aw+WfRyD3WghhSBuikX0umVg/x5Ka8nFdXhBbSJUeNJu6zl+iA6qE9K9AY8vyUDbQmf6MV0WRt9uXD68FVP8veMzxuQ8/3W/sOVv0inFKH8NvoMurKEyEW/0hIl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w8oaJ4CP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4SqZ+WtW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w8oaJ4CP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4SqZ+WtW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7C1F81FC0D;
	Mon,  8 Jul 2024 08:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720427058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qWXPETxPIsP7YGSU/X1TKH8MVdKI3GNs9fRlVyTz56Q=;
	b=w8oaJ4CPZWa/KytcGmJ53wiWN1gKgZOqJYCe5aSl4KFKPj/NUVr1VDWh7e80/UhNZaMF5S
	Pa9kQfHfECWXZykGwW4c8VGzq85rFA52jfVlAh5AwqC574fgpkxrKzkEEb1CaiuZfsNg/M
	3tFZuUy8Ntuf5FdVHJRPO7gNSvWQpQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720427058;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qWXPETxPIsP7YGSU/X1TKH8MVdKI3GNs9fRlVyTz56Q=;
	b=4SqZ+WtWeDjccTVpTpGt8xXZxDQvfxhAmrcivfqO6MCCB3rpOq3h0rx05mAbUpIHSQTofA
	nkVLIEc33q3g/+CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720427058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qWXPETxPIsP7YGSU/X1TKH8MVdKI3GNs9fRlVyTz56Q=;
	b=w8oaJ4CPZWa/KytcGmJ53wiWN1gKgZOqJYCe5aSl4KFKPj/NUVr1VDWh7e80/UhNZaMF5S
	Pa9kQfHfECWXZykGwW4c8VGzq85rFA52jfVlAh5AwqC574fgpkxrKzkEEb1CaiuZfsNg/M
	3tFZuUy8Ntuf5FdVHJRPO7gNSvWQpQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720427058;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qWXPETxPIsP7YGSU/X1TKH8MVdKI3GNs9fRlVyTz56Q=;
	b=4SqZ+WtWeDjccTVpTpGt8xXZxDQvfxhAmrcivfqO6MCCB3rpOq3h0rx05mAbUpIHSQTofA
	nkVLIEc33q3g/+CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6AB61396E;
	Mon,  8 Jul 2024 08:24:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ws6TLzGii2ZyIAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 08 Jul 2024 08:24:17 +0000
Date: Mon, 8 Jul 2024 10:24:11 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb: fix potential race in
 __update_and_free_hugetlb_folio()
Message-ID: <ZouiK8Fm5RGNpwSb@localhost.localdomain>
References: <20240708025127.107713-1-linmiaohe@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708025127.107713-1-linmiaohe@huawei.com>
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]

On Mon, Jul 08, 2024 at 10:51:27AM +0800, Miaohe Lin wrote:
> There is a potential race between __update_and_free_hugetlb_folio() and
> try_memory_failure_hugetlb():
> 
>  CPU1					CPU2
>  __update_and_free_hugetlb_folio	try_memory_failure_hugetlb
> 					 folio_test_hugetlb
> 					  -- It's still hugetlb folio.
>   folio_clear_hugetlb_hwpoison
>   					  spin_lock_irq(&hugetlb_lock);
> 					   __get_huge_page_for_hwpoison
> 					    folio_set_hugetlb_hwpoison
> 					  spin_unlock_irq(&hugetlb_lock);
>   spin_lock_irq(&hugetlb_lock);
>   __folio_clear_hugetlb(folio);
>    -- Hugetlb flag is cleared but too late.
>   spin_unlock_irq(&hugetlb_lock);
> 
> When above race occurs, raw error page info will be leaked. Even worse,
> raw error pages won't have hwpoisoned flag set and hit pcplists/buddy.
> Fix this issue by deferring folio_clear_hugetlb_hwpoison() until
> __folio_clear_hugetlb() is done. So all raw error pages will have
> hwpoisoned flag set.
> 
> Fixes: 32c877191e02 ("hugetlb: do not clear hugetlb dtor until allocating vmemmap")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Cc: <stable@vger.kernel.org>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

