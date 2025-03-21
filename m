Return-Path: <linux-kernel+bounces-571501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A541CA6BDFB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28ABD3AFCE9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4CE1BF33F;
	Fri, 21 Mar 2025 15:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ualdCGVC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rHDuRmzb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ualdCGVC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rHDuRmzb"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B9142A94
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742569778; cv=none; b=Bf4+caNblPgB+KOyGJ8QZ62QNbRDacejQXqIdgmGmM8LEcP+OO7Pu3INOj9bFLiBmXYV4le76/NGC2P7iiafjOzMnVGsF4rMa6lVXlh29+utD1FxyMeYh7YHlZJ02sIGvOrYD7Y9htE8KvY0/oPtYmZgr+zl41WYofHsfSTMnsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742569778; c=relaxed/simple;
	bh=Vp/jBfkzLwkxCYSWwK6+uoh8+KQDvgpSnVQxUC7RpQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rO6MBOOZ0rcJJ9JSiVI1eBi8g+MmeOZLY/709JmsAiGWXBSCSCIT8AAIzAK9sP99oNTEHh5GoFKlKvnadMQKBUHJ1cBC1sRlqA/8tcdwTFKto/U3TQWbaBJ/6TIWguYN3szSl3ftEJJGApJsTbK8yc8GyiNBcc3wgw4JSQOhw5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ualdCGVC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rHDuRmzb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ualdCGVC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rHDuRmzb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4A0101FEF7;
	Fri, 21 Mar 2025 15:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742569774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DgznpANGOBOKlm9alAYsgKxcYpu8Q4cgo8ZhvrGmDAo=;
	b=ualdCGVCjsvY/bXsGDjJbRmm5wO9Q3vwFukMFFZljtNUV6OU8wUryyKdiXfgV3Wh+XnwKw
	Oi2wfjn/WtcTDqPdhGfb8wA/+TYd7UmE7Bc9ab2vx7N2YzJvbLoOjuDJ1oCo91Scmm/Og+
	UXcW30xdQ4dGH5lTmbwLkaX6qcxzQMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742569774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DgznpANGOBOKlm9alAYsgKxcYpu8Q4cgo8ZhvrGmDAo=;
	b=rHDuRmzbVpwKTgAsTemQmOFzj2QTE7ogoUfMdbpUcjSib2o/X3Ia98WRvl/zHeFdEY+j94
	pvCTzGGSEcZEdICg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ualdCGVC;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rHDuRmzb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742569774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DgznpANGOBOKlm9alAYsgKxcYpu8Q4cgo8ZhvrGmDAo=;
	b=ualdCGVCjsvY/bXsGDjJbRmm5wO9Q3vwFukMFFZljtNUV6OU8wUryyKdiXfgV3Wh+XnwKw
	Oi2wfjn/WtcTDqPdhGfb8wA/+TYd7UmE7Bc9ab2vx7N2YzJvbLoOjuDJ1oCo91Scmm/Og+
	UXcW30xdQ4dGH5lTmbwLkaX6qcxzQMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742569774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DgznpANGOBOKlm9alAYsgKxcYpu8Q4cgo8ZhvrGmDAo=;
	b=rHDuRmzbVpwKTgAsTemQmOFzj2QTE7ogoUfMdbpUcjSib2o/X3Ia98WRvl/zHeFdEY+j94
	pvCTzGGSEcZEdICg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 332CE139AA;
	Fri, 21 Mar 2025 15:09:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id urEqDC6B3WemDwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 21 Mar 2025 15:09:34 +0000
Message-ID: <c3a0e874-7035-4505-812b-60acc5fc2032@suse.cz>
Date: Fri, 21 Mar 2025 16:09:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm: Fix parameter passed to
 page_mapcount_is_type()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 willy@infradead.org, david@redhat.com, linmiaohe@huawei.com,
 gehao@kylinos.cn, shan.gavin@gmail.com
References: <20250321120222.1456770-1-gshan@redhat.com>
 <20250321120222.1456770-2-gshan@redhat.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250321120222.1456770-2-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4A0101FEF7
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux-foundation.org,infradead.org,redhat.com,huawei.com,kylinos.cn,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 3/21/25 13:02, Gavin Shan wrote:
> As the comments of page_mapcount_is_type() indicate, the parameter
> passed to the function should be one more than page->_mapcount.
> However, page->_mapcount (equivalent to page->page_type) is passed
> to the function by commit 4ffca5a96678 ("mm: support only one page_type
> per page") page_type_has_type() is replaced by page_mapcount_is_type(),
> but the parameter isn't adjusted.
> 
> Fix it by replacing page_mapcount_is_type() with page_type_has_type()
> in page_has_type(). Note that the issue doesn't cause any visible impacts
> due to the safety gap introduced by PGTY_mapcount_underflow limit.
> 
> Fixes: 4ffca5a96678 ("mm: support only one page_type per page")
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/page-flags.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 36d283552f80..e1a9f84bd5ab 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -950,7 +950,7 @@ static inline bool page_mapcount_is_type(unsigned int mapcount)
>  
>  static inline bool page_has_type(const struct page *page)
>  {
> -	return page_mapcount_is_type(data_race(page->page_type));
> +	return page_type_has_type(data_race(page->page_type));
>  }
>  
>  #define FOLIO_TYPE_OPS(lname, fname)					\


