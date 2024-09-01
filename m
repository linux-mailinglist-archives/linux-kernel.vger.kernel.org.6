Return-Path: <linux-kernel+bounces-310349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6A5967BA7
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 20:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC1EF1F219F3
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 18:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39C1183CC1;
	Sun,  1 Sep 2024 18:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PvQLLw1M";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ok5btGBV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PvQLLw1M";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ok5btGBV"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A85183087
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 18:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725214045; cv=none; b=R+BbrPFxq/RfrsEeR+020B3G22rFafC1oy9+a17xk0d/fO/lM9ej3Tpk7AsqKqU3ybjsftXfJHFIChN+X1TtvhHxs2u5jm87CgHm/QjcreRen2QZakj3N978zFMO8mVgbYJzixyvY7sUGYu2OA4rD+1maRtDrRQ5E3/fhKfKqC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725214045; c=relaxed/simple;
	bh=wuRSBojzwRSR4ERWRbSWZsS61h2pF5C/wvzBv5F1YwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCbFe+WpxptgsoIGI6iil0BcAtrA57qlfChRzFm4YjaN4oK/JETbYwidbJWW5JiWOK9G0cqvfC5vVJhMTvwQXR7p2G4Z8w5LL6exaKo1tmEpH7fOinkEeGZAGaAEAf9cX0/DYp1Y6/GcDm37wO7uho2Sm++x8XZoLjHphP+UlQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PvQLLw1M; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ok5btGBV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PvQLLw1M; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ok5btGBV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3AC8B21108;
	Sun,  1 Sep 2024 18:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725214041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mhb+C5QgYr2sUBVl6HqCYpZgpxZwb4zSv4b2sxqvEY4=;
	b=PvQLLw1Mv6y84QvNAjd2LNML2RD4Ge5kgtlb/64ufgQ9Z85xLKaqGbp2EfEJfT1Acipyeq
	fQOx8fpF8d8iNbYE2qlmGP3RAVGBPKiS7jOH0go5n2ULC/kPoJKMtaYmqRXVeYFW+hpiA3
	aC4d8akxoTCSRy69MRRJEXfD3YwYZvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725214041;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mhb+C5QgYr2sUBVl6HqCYpZgpxZwb4zSv4b2sxqvEY4=;
	b=Ok5btGBV1Pn+pvgwswEbb3TV4Msh1M9PLYk2gRhx/S9Cp4hyhCHZMSIEWTWjaZL5WQzHlc
	zkHODdpRmJKWSbBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PvQLLw1M;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Ok5btGBV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725214041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mhb+C5QgYr2sUBVl6HqCYpZgpxZwb4zSv4b2sxqvEY4=;
	b=PvQLLw1Mv6y84QvNAjd2LNML2RD4Ge5kgtlb/64ufgQ9Z85xLKaqGbp2EfEJfT1Acipyeq
	fQOx8fpF8d8iNbYE2qlmGP3RAVGBPKiS7jOH0go5n2ULC/kPoJKMtaYmqRXVeYFW+hpiA3
	aC4d8akxoTCSRy69MRRJEXfD3YwYZvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725214041;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mhb+C5QgYr2sUBVl6HqCYpZgpxZwb4zSv4b2sxqvEY4=;
	b=Ok5btGBV1Pn+pvgwswEbb3TV4Msh1M9PLYk2gRhx/S9Cp4hyhCHZMSIEWTWjaZL5WQzHlc
	zkHODdpRmJKWSbBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA96B1373A;
	Sun,  1 Sep 2024 18:07:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tiPFJ1it1GZdXwAAD6G6ig
	(envelope-from <aherrmann@suse.de>); Sun, 01 Sep 2024 18:07:20 +0000
Date: Sun, 1 Sep 2024 20:07:19 +0200
From: Andreas Herrmann <aherrmann@suse.de>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: x86@kernel.org, Andreas Herrmann <aherrmann@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
	Radu Rendec <rrendec@redhat.com>,
	Pierre Gondois <Pierre.Gondois@arm.com>, Pu Wen <puwen@hygon.cn>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Huang Ying <ying.huang@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/4] cacheinfo: Check for null last-level cache info
Message-ID: <20240901180719.GA4089@alberich>
References: <20240827051635.9114-1-ricardo.neri-calderon@linux.intel.com>
 <20240827051635.9114-2-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240827051635.9114-2-ricardo.neri-calderon@linux.intel.com>
X-Rspamd-Queue-Id: 3AC8B21108
X-Spam-Level: 
X-Spamd-Result: default: False [-6.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,arm.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -6.01
X-Spam-Flag: NO

On Mon, Aug 26, 2024 at 10:16:32PM -0700, Ricardo Neri wrote:
> Before determining the validity of the last-level cache info, ensure that
> it has been allocated. Simply checking for non-zero cache_leaves() is not
> sufficient, as some architectures (e.g., Intel processors) have non-zero
> cache_leaves() before allocation.
> 
> Dereferencing NULL cacheinfo can occur in update_per_cpu_data_slice_size().
> This function iterates over all online CPUs. However, a CPU may have come
> online recently, but its cacheinfo may not have been allocated yet.
> 
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
Tested-by: Andreas Herrmann <aherrmann@suse.de>

Test was done with a system equipped with AMD Phenom II X6 1055T and
test kernels based on v6.11-rc5-176-g20371ba12063.


Thanks,
Andreas

