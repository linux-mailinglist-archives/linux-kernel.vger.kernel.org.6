Return-Path: <linux-kernel+bounces-179816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91488C65E0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 13:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17BEF1C21094
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 11:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E626F077;
	Wed, 15 May 2024 11:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Aj3EiNwR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4MiX9VHs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Aj3EiNwR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4MiX9VHs"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500B1219E8
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 11:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715773476; cv=none; b=dk0sjER7Uyen5t/q660YhMeT9j2yIkj6a28d4Muj/QfgrRIFsdghOTutZTQWKHfI2KrVy6X5LIUTbxKKHCbGg2Z90WzfxrrXw6PX2Z+fzbEkzLdH/+is6H3FOIuvqWPx4N0+AtkvSxAPEmSvireqp3Adr1kg0JAsT/ZpMSMBJ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715773476; c=relaxed/simple;
	bh=jSKPg5u+RaI8uHpd6Omgfufe5106IvN57emK6hK1FtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvsRvvAHxiAVJ+1lrVK460aAxknjJjDJoKWXBy1fH1jCQpVU0rJerrRRMtq/4YhQ+1PhrcuNYVTlCwHWx3v4qBB0hJcXlcf5TUUfG6D3VAkswixGlWTAJmGnb+2dhZ+JI9fFYZbdaDHMSsUshF80CoYS7G2UKVWwTmE6OF6R8PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Aj3EiNwR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4MiX9VHs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Aj3EiNwR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4MiX9VHs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4003C205F8;
	Wed, 15 May 2024 11:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715773472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OvF3X7BK8jjfa9pXaL7JCD3/i65vNNFCv8JmHw1RPiA=;
	b=Aj3EiNwRUat0YbUUj2HQeKL3aFcwJqn1ATr7v1H5TO1SiEQRvC12Jr2oHxQAdCYbvTljMQ
	1rmZmpY5baO8z6ve4mF0uMiSsDs5LnC2mxJvU1jnMD7mvxAqyU8UhstErShNq/8ZYhGAJ9
	W+F9E9+5kqa7nLxsqntppZpJCK52rM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715773472;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OvF3X7BK8jjfa9pXaL7JCD3/i65vNNFCv8JmHw1RPiA=;
	b=4MiX9VHsXvPyLHNxq+aft6FyPSKpS1COMx9+Jch7CtZm3aEFLztVAolUaMw6LEP61Qs+ny
	BrN6ni8+EapFKFAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715773472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OvF3X7BK8jjfa9pXaL7JCD3/i65vNNFCv8JmHw1RPiA=;
	b=Aj3EiNwRUat0YbUUj2HQeKL3aFcwJqn1ATr7v1H5TO1SiEQRvC12Jr2oHxQAdCYbvTljMQ
	1rmZmpY5baO8z6ve4mF0uMiSsDs5LnC2mxJvU1jnMD7mvxAqyU8UhstErShNq/8ZYhGAJ9
	W+F9E9+5kqa7nLxsqntppZpJCK52rM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715773472;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OvF3X7BK8jjfa9pXaL7JCD3/i65vNNFCv8JmHw1RPiA=;
	b=4MiX9VHsXvPyLHNxq+aft6FyPSKpS1COMx9+Jch7CtZm3aEFLztVAolUaMw6LEP61Qs+ny
	BrN6ni8+EapFKFAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDA8D1372E;
	Wed, 15 May 2024 11:44:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OPVuLx+gRGY+AQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 15 May 2024 11:44:31 +0000
Date: Wed, 15 May 2024 13:44:22 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Jane Chu <jane.chu@oracle.com>
Cc: linmiaohe@huawei.com, nao.horiguchi@gmail.com,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] mm/madvise: Add MF_ACTION_REQUIRED to
 madvise(MADV_HWPOISON)
Message-ID: <ZkSgFgXrxCtopWp9@localhost.localdomain>
References: <20240510062602.901510-1-jane.chu@oracle.com>
 <20240510062602.901510-3-jane.chu@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510062602.901510-3-jane.chu@oracle.com>
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[huawei.com,gmail.com,linux-foundation.org,kvack.org,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]

On Fri, May 10, 2024 at 12:25:59AM -0600, Jane Chu wrote:
> The soft hwpoison injector via madvise(MADV_HWPOISON) operates in
> a synchrous way in a sense, the injector is also a process under
> test, and should it have the poisoned page mapped in its address
> space, it should legitimately get killed as much as in a real UE
> situation.
> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>

You should also mention that this aligns with what the madvise man page
mentions:

"... This operation may result in the calling process receiving a SIGBUS
and the page being unmapped..."

Reviewed-by: Oscar Salvador <oalvador@suse.de>

> ---
>  mm/madvise.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index c8ba3f3eb54d..d8a01d7b2860 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1147,7 +1147,7 @@ static int madvise_inject_error(int behavior,
>  		} else {
>  			pr_info("Injecting memory failure for pfn %#lx at process virtual address %#lx\n",
>  				 pfn, start);
> -			ret = memory_failure(pfn, MF_COUNT_INCREASED | MF_SW_SIMULATED);
> +			ret = memory_failure(pfn, MF_ACTION_REQUIRED | MF_COUNT_INCREASED | MF_SW_SIMULATED);
>  			if (ret == -EOPNOTSUPP)
>  				ret = 0;
>  		}
> -- 
> 2.39.3
> 

-- 
Oscar Salvador
SUSE Labs

