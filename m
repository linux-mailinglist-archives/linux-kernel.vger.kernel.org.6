Return-Path: <linux-kernel+bounces-191783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7565D8D1403
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 07:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 136581F2418D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 05:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DEC4F201;
	Tue, 28 May 2024 05:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uR1xaOLu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3HUchnWb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uR1xaOLu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3HUchnWb"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A0D4CB2B
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 05:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716874874; cv=none; b=UbXf5R3Nwjl77B77r7sNutc+jm2EwRAopfJa8b+Wm9VV3UdYkze1d2lMszYy1Y4wbJsjdZxWrM4gb1fISslLEErAXmRPBF0X/7d7b4LDcGgFs6P71Tkgttn1wSJd2Y4nFgIg6wNUDCSDU4ZNq48KejSnN8Z/uGH9n+FtcoTVtEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716874874; c=relaxed/simple;
	bh=2CRGleO5PvGwSI4yhgdhATinYSQtjtFB0ceUA/RghM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2+RHTh42OI0xuCLwTDELWW/NZX67GusixVigozqp5N9Iz0Zq+fWvm68iV5IPyAprEJ6CrjCYqZBdQU0woKi1wozzxqsK6m1t+OljVkHklTc7tXfAPBCXdI3sDeBzmD0Qov5WYElLzQy6gccL7fPtCmP6tOcPuOzVciX/haXrrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uR1xaOLu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3HUchnWb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uR1xaOLu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3HUchnWb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4D93921FE5;
	Tue, 28 May 2024 05:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716874870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HvLg3YcfOytUXK8s+9klAigf80meSg65jI1M6X+di9Y=;
	b=uR1xaOLuXJgO8F8luIHAiNPK/3HsTsZEkAuEdurxgU+uZkDfH5eamxVBPnLxSktxjLhp4b
	6EtlDxr/L3apbAbUHFM6/Y8mrKutJWTUc5x/iwRhYTgBT7A/s6VJ8rWlWsmEcbWNu7PQUu
	sRNOuGDBwZaVY7Oz/1onnvHHRqfh4TM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716874870;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HvLg3YcfOytUXK8s+9klAigf80meSg65jI1M6X+di9Y=;
	b=3HUchnWb1qnsO5VRZyCjhJYFR1JJZKtwmuj891qHdYQ8GM3LDJGZKJj2LS83aK0EZe2TKo
	fFjscNHWXFVgaFDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uR1xaOLu;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3HUchnWb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716874870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HvLg3YcfOytUXK8s+9klAigf80meSg65jI1M6X+di9Y=;
	b=uR1xaOLuXJgO8F8luIHAiNPK/3HsTsZEkAuEdurxgU+uZkDfH5eamxVBPnLxSktxjLhp4b
	6EtlDxr/L3apbAbUHFM6/Y8mrKutJWTUc5x/iwRhYTgBT7A/s6VJ8rWlWsmEcbWNu7PQUu
	sRNOuGDBwZaVY7Oz/1onnvHHRqfh4TM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716874870;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HvLg3YcfOytUXK8s+9klAigf80meSg65jI1M6X+di9Y=;
	b=3HUchnWb1qnsO5VRZyCjhJYFR1JJZKtwmuj891qHdYQ8GM3LDJGZKJj2LS83aK0EZe2TKo
	fFjscNHWXFVgaFDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C316013A55;
	Tue, 28 May 2024 05:41:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rjv6LHVuVWYIdwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 28 May 2024 05:41:09 +0000
Date: Tue, 28 May 2024 07:41:08 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v4 03/16] mm: Provide mm_struct and address to
 huge_ptep_get()
Message-ID: <ZlVudE37ENlFhTo4@localhost.localdomain>
References: <cover.1716815901.git.christophe.leroy@csgroup.eu>
 <941ae68c7813cafc7aee3f34131f895fb7599636.1716815901.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <941ae68c7813cafc7aee3f34131f895fb7599636.1716815901.git.christophe.leroy@csgroup.eu>
X-Spam-Flag: NO
X-Spam-Score: -6.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4D93921FE5
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,nvidia.com,redhat.com,ellerman.id.au,gmail.com,vger.kernel.org,kvack.org,lists.ozlabs.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]

On Mon, May 27, 2024 at 03:30:01PM +0200, Christophe Leroy wrote:
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -547,7 +547,7 @@ static int gup_hugepte(struct vm_area_struct *vma, pte_t *ptep, unsigned long sz
>  	if (pte_end < end)
>  		end = pte_end;
>  
> -	pte = huge_ptep_get(ptep);
> +	pte = huge_ptep_get(vma->mm, addr, ptep);

I looked again and I stumbled upon this.
It should have been "vma->vm_mm".

 

-- 
Oscar Salvador
SUSE Labs

