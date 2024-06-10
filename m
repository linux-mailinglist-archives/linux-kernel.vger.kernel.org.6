Return-Path: <linux-kernel+bounces-207642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3339901A1D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68B501F2190B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F04BA53;
	Mon, 10 Jun 2024 05:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ow0T3g1s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="y28M07Ht";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ow0T3g1s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="y28M07Ht"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936E9A935
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717995836; cv=none; b=abJj3MaOKY3dPVaJ7ttvagKLh8F46KL6lWqpNZeS3OSZMDzvbSLroqMjbuFmxbCmo6ObJP0Yl/xB/+Ut6k85Lh3ZgaqtNgaDlLqwvyb3Bs8CRdpZzgpPe6mYwWdRIwputFJ45fPSUjtCS718caId3LTcr7nieyCuJiiN7g6bNrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717995836; c=relaxed/simple;
	bh=6+wYzOhSzLvlsdLTPsXrtV9m6Ro5SPn+MlG2yFEQBHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0PVk0VwttVF2w62vPwFcmch40FdGimW5VOdeJs0A8EMmYxFhp0ILDJcGMYPhhMTq4W/nRWc+eNeiDctkCqWMV+kbL+UdsYMyFu6QFNJF8CozQL/geVw76KKBo7RKpwu9RQDmxmWlnwHx3bevVFzUXj5Zf00PmNT56pBmyLrPt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ow0T3g1s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=y28M07Ht; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ow0T3g1s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=y28M07Ht; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 642E81F7A6;
	Mon, 10 Jun 2024 05:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717995832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e+9/xWudwyvHquTKWWdLAZXx3USzblOimcE1ZFTIXWA=;
	b=ow0T3g1stzOTkAKxlPb2UciIqA5F6BmoDI6I/MJ7TvOSdK2VYGDsmBCie9OXZDYNEH7vG8
	MWlV9jq/bRsjHIbjJ8im38wdywluf6OgRTLEuQclG9HioSd8zFyVswJB5myjxYs0ypEAgb
	vypF+QPsGn/Loikxs+sqkK3L7SztahA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717995832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e+9/xWudwyvHquTKWWdLAZXx3USzblOimcE1ZFTIXWA=;
	b=y28M07Ht2i1owZwh4enC2uu7PeEGiPkoel040Mzqxo+l+bFu3RtANnbeSJeDxZCkEXO22H
	VwlRNI9iAjYMl6CQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ow0T3g1s;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=y28M07Ht
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717995832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e+9/xWudwyvHquTKWWdLAZXx3USzblOimcE1ZFTIXWA=;
	b=ow0T3g1stzOTkAKxlPb2UciIqA5F6BmoDI6I/MJ7TvOSdK2VYGDsmBCie9OXZDYNEH7vG8
	MWlV9jq/bRsjHIbjJ8im38wdywluf6OgRTLEuQclG9HioSd8zFyVswJB5myjxYs0ypEAgb
	vypF+QPsGn/Loikxs+sqkK3L7SztahA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717995832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e+9/xWudwyvHquTKWWdLAZXx3USzblOimcE1ZFTIXWA=;
	b=y28M07Ht2i1owZwh4enC2uu7PeEGiPkoel040Mzqxo+l+bFu3RtANnbeSJeDxZCkEXO22H
	VwlRNI9iAjYMl6CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F30613A7F;
	Mon, 10 Jun 2024 05:03:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nXiOADiJZma2HwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 10 Jun 2024 05:03:52 +0000
Date: Mon, 10 Jun 2024 07:03:46 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next 1/3] mm/hugetlb_cgroup: identify the legacy
 using cgroup_subsys_on_dfl()
Message-ID: <ZmaJMqqc4myJNUEm@localhost.localdomain>
References: <20240605070133.1941677-1-xiujianfeng@huawei.com>
 <20240605070133.1941677-2-xiujianfeng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605070133.1941677-2-xiujianfeng@huawei.com>
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 642E81F7A6
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.de:dkim,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]

On Wed, Jun 05, 2024 at 07:01:31AM +0000, Xiu Jianfeng wrote:
> Currently the numa_stat file encodes 1 into private using the micro
> MEMFILE_PRIVATE() to identify the legacy. Actually, we can use
> cgroup_subsys_on_dfl() instead. This is helpful to handle .private
> in the static array of the comming patch.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

Nit below:

> ---
>  mm/hugetlb_cgroup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index e20339a346b9..45f94a869776 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -460,7 +460,7 @@ static int hugetlb_cgroup_read_numa_stat(struct seq_file *seq, void *dummy)
>  	int nid;
>  	struct cftype *cft = seq_cft(seq);
>  	int idx = MEMFILE_IDX(cft->private);
> -	bool legacy = MEMFILE_ATTR(cft->private);
> +	bool legacy = !cgroup_subsys_on_dfl(hugetlb_cgrp_subsys);
>  	struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(seq_css(seq));
>  	struct cgroup_subsys_state *css;
>  	unsigned long usage;
> @@ -839,7 +839,7 @@ static void __init __hugetlb_cgroup_file_legacy_init(int idx)
>  	/* Add the numa stat file */
>  	cft = &h->cgroup_files_legacy[8];
>  	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.numa_stat", buf);
> -	cft->private = MEMFILE_PRIVATE(idx, 1);
> +	cft->private = MEMFILE_PRIVATE(idx, 0);

Do we still have to set it to '0'?
Is it not by default?

-- 
Oscar Salvador
SUSE Labs

