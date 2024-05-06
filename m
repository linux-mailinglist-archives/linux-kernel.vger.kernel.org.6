Return-Path: <linux-kernel+bounces-170082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F24B68BD1AE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30CC8B22677
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4BE155398;
	Mon,  6 May 2024 15:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JAGBRmiL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BBTgObPk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JAGBRmiL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BBTgObPk"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1969A7580C
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 15:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715010097; cv=none; b=paMJnW2oZKquAc/IBjmdQeeYzdWckYkOXzQqJzPGcZcZJ6t45AC+ddGwm24NPg25w/lSswrmIfjoKTNH8B2U260/6u8+gSb5iCw5+GwQ6TIfY9CIbhTJuOaEFPhpXnHQ0ofhz/Ci3ZcbnRE5RvKNqrtFS88F75180IWp4wp85E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715010097; c=relaxed/simple;
	bh=r2fKkKODx3bsbU/zHy3RqTsEzCgGVZbwURDHIJCljNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTYPd6F5uRp7Y0B4jpscZei1ej0YiO2cupmSaca7cPCCtygQs8LLlIgFKPDHQdXAlLa4OEfjMM0IPGmtlSjJDrwL/ZgRAPPq6nkt3VtO2LTRzr6/0po56OoAcbLWCqYCSiy1Na5zst0WC2sNOEIJp8vzww6mJdzKISa3KyDUM1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JAGBRmiL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BBTgObPk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JAGBRmiL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BBTgObPk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 48F4E38586;
	Mon,  6 May 2024 15:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715010094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EX3lbGjtZr1MYyBbIkYm5Ykpw+gVZN3D98AWH25Rb0s=;
	b=JAGBRmiLG4Ca4zbRmnXhByMK7/RTX3PIOCv7Crrnf+fOxGM/Y/XcZz6/qezxRzrba+x6Kb
	yKKifPnPCD7/RV12EIeAxX8loQV1xrUXaEKYovxTM+zZC7uwUM8CtH6LSB9aYG1iNU1AyB
	cslYaA28Jz9l8On5J7Ywj4GRGduzbx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715010094;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EX3lbGjtZr1MYyBbIkYm5Ykpw+gVZN3D98AWH25Rb0s=;
	b=BBTgObPkplXvYQC17Ky833tZ4QY6nmelC79vlS1v1KUs6OGWM90yKLDGOBT7Dkmp+6X3IR
	LlpwUPdmCBD5LLAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715010094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EX3lbGjtZr1MYyBbIkYm5Ykpw+gVZN3D98AWH25Rb0s=;
	b=JAGBRmiLG4Ca4zbRmnXhByMK7/RTX3PIOCv7Crrnf+fOxGM/Y/XcZz6/qezxRzrba+x6Kb
	yKKifPnPCD7/RV12EIeAxX8loQV1xrUXaEKYovxTM+zZC7uwUM8CtH6LSB9aYG1iNU1AyB
	cslYaA28Jz9l8On5J7Ywj4GRGduzbx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715010094;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EX3lbGjtZr1MYyBbIkYm5Ykpw+gVZN3D98AWH25Rb0s=;
	b=BBTgObPkplXvYQC17Ky833tZ4QY6nmelC79vlS1v1KUs6OGWM90yKLDGOBT7Dkmp+6X3IR
	LlpwUPdmCBD5LLAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A65E113A25;
	Mon,  6 May 2024 15:41:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SV/vJS36OGblCgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 06 May 2024 15:41:33 +0000
Date: Mon, 6 May 2024 17:41:28 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>, Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	syzbot+41bbfdb8d41003d12c0f@syzkaller.appspotmail.com
Subject: Re: [PATCH v4 2/4] mm,page_owner: Fix refcount imbalance
Message-ID: <Zjj6KN0GhXbv3VYY@localhost.localdomain>
References: <20240404070702.2744-1-osalvador@suse.de>
 <20240404070702.2744-3-osalvador@suse.de>
 <202405060754.4405F8402F@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202405060754.4405F8402F@keescook>
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[41bbfdb8d41003d12c0f];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,kvack.org,suse.com,suse.cz,google.com,gmail.com,rivosinc.com,syzkaller.appspotmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Mon, May 06, 2024 at 07:59:11AM -0700, Kees Cook wrote:
> Does this also fix this?
> https://lore.kernel.org/all/202405061514.23fedba1-oliver.sang@intel.com/

Hi Kess,

yes, it does.

> 
> This is a report of the backtrace changing, but the warning was
> pre-existing.
> 
> > [...]
> > -static void dec_stack_record_count(depot_stack_handle_t handle)
> > +static void dec_stack_record_count(depot_stack_handle_t handle,
> > +				   int nr_base_pages)
> >  {
> >  	struct stack_record *stack_record = __stack_depot_get_stack_record(handle);
> >  
> > -	if (stack_record)
> > -		refcount_dec(&stack_record->count);
> > +	if (!stack_record)
> > +		return;
> > +
> > +	if (refcount_sub_and_test(nr_base_pages, &stack_record->count))
> > +		pr_warn("%s: refcount went to 0 for %u handle\n", __func__,
> > +			handle);
> 
> This pr_warn() isn't needed: refcount will very loudly say the same
> thing. :)

Yes, but I wanted to get the handle so I can match it with the
backtrace.

Thanks


-- 
Oscar Salvador
SUSE Labs

