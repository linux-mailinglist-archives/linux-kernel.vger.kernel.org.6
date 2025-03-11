Return-Path: <linux-kernel+bounces-556020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFD4A5BFE5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A66C03A6181
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751871E47A5;
	Tue, 11 Mar 2025 12:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vBIeQqR9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kuoDrVEn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vBIeQqR9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kuoDrVEn"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F963597C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694431; cv=none; b=ABG4HwK12W4dajhellfHtU/ugF0hkFLSlGq/CYzgCXAIzsLCl2LFkAc+EGQWEpiG24HAU+xBLP0Bp3rzuOtXMTBJOujo8PxoKTrixylxbV3hWhyQ1PHX2Gq8+RCC/XapqdGTaG/toKa5rN367s9UQ8hdCdBrwjd9FxPiKvqeA3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694431; c=relaxed/simple;
	bh=JzkrOFhGkENMK4Rg1p53WvrgcmmdMId0Tsg3pBQf8Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNaOOu/pGWfcT8DUSYOJ/fvBpuhllueaAJOnj+rMI/iTdio3I7WHgcvWvPeA/iqO20LJ9RKBVyxJjxM23LUtJpnluzSVHNiqhrsIgc4wpwWW5T5nuwc+BEay0mW/Yj6WupRn5JUAKeH/258s8OwSt9jzfyjBz4w6tlfT4WSII9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vBIeQqR9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kuoDrVEn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vBIeQqR9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kuoDrVEn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from localhost (unknown [10.100.12.32])
	by smtp-out1.suse.de (Postfix) with ESMTP id 1060D2117D;
	Tue, 11 Mar 2025 12:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741694428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x8WkA39bFX3GqqFALG3OsmUN05f4JXXHMUC4Yp+Z/J4=;
	b=vBIeQqR9gJGCprOzJvE8U38YdIcTjjSKjKx09YIiqEc/VFCj9oVYGWtFbhuR4MYobQeV0S
	vKZr050O4csrIn3QPrZq7p1YmnnRN4jKmUMSH/G7c2vPNlK5dg+GTYwkmf7tFvrYKO9I+u
	reom673AlFCk5A5fEmKBatc4hkPySj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741694428;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x8WkA39bFX3GqqFALG3OsmUN05f4JXXHMUC4Yp+Z/J4=;
	b=kuoDrVEno3+Qe8velVwmuLL+SaoaDe8p6or5q+nTiq/09nKhZYx0xK2CpQ9Mtz1Iza+NhR
	XsfLA47NwE4U3xBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741694428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x8WkA39bFX3GqqFALG3OsmUN05f4JXXHMUC4Yp+Z/J4=;
	b=vBIeQqR9gJGCprOzJvE8U38YdIcTjjSKjKx09YIiqEc/VFCj9oVYGWtFbhuR4MYobQeV0S
	vKZr050O4csrIn3QPrZq7p1YmnnRN4jKmUMSH/G7c2vPNlK5dg+GTYwkmf7tFvrYKO9I+u
	reom673AlFCk5A5fEmKBatc4hkPySj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741694428;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x8WkA39bFX3GqqFALG3OsmUN05f4JXXHMUC4Yp+Z/J4=;
	b=kuoDrVEno3+Qe8velVwmuLL+SaoaDe8p6or5q+nTiq/09nKhZYx0xK2CpQ9Mtz1Iza+NhR
	XsfLA47NwE4U3xBA==
Date: Tue, 11 Mar 2025 13:00:28 +0100
From: Jiri Bohac <jbohac@suse.cz>
To: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, Philipp Rudo <prudo@redhat.com>,
	Donald Dutile <ddutile@redhat.com>, Pingfan Liu <piliu@redhat.com>,
	Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>,
	Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v2 4/5] kdump: wait for DMA to finish when using CMA
Message-ID: <Z9Al3DI_PsWPN83k@dwarf.suse.cz>
References: <Z7dc9Cd8KX3b_brB@dwarf.suse.cz>
 <Z7demEmgm-D_fqi2@dwarf.suse.cz>
 <Z8UNvvEF2Ow/qigk@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8UNvvEF2Ow/qigk@MiWiFi-R3L-srv>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Mon, Mar 03, 2025 at 10:02:38AM +0800, Baoquan He wrote:
> On 02/20/25 at 05:55pm, Jiri Bohac wrote:
> > +static void crash_cma_clear_pending_dma(void)
> > +{
> > +	if (!crashk_cma_cnt)
> > +		return;
> > +
> > +	mdelay(CMA_DMA_TIMEOUT_MSEC);
> > +}
> > +
> >  /*
> >   * No panic_cpu check version of crash_kexec().  This function is called
> >   * only when panic_cpu holds the current CPU number; this is the only CPU
> > @@ -116,6 +125,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
> >  		if (kexec_crash_image) {
> >  			struct pt_regs fixed_regs;
> >  
> > +			crash_cma_clear_pending_dma();
> 
> This could be too ideal, I am not sure if it's a good way. When crash
> triggered, we need do the urgent and necessary thing as soon as
> possible, then shutdown all CPU to avoid further damage. This one second
> of waiting could give the strayed system too much time. My personal
> opinion.

Good point! I think it makes sense to move the call to crash_cma_clear_pending_dma()
past the call of machine_crash_shutdown where all the shutdown
happens, like this:

> >  			crash_setup_regs(&fixed_regs, regs);
> >  			crash_save_vmcoreinfo();
> >  			machine_crash_shutdown(&fixed_regs);

+			crash_cma_clear_pending_dma();

I'll post a v3 with this change included.

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


