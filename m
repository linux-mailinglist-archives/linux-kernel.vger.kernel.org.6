Return-Path: <linux-kernel+bounces-310750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB9D9680D0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 735F9281D63
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42231714B7;
	Mon,  2 Sep 2024 07:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PGk19JQi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cgpmiXXI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PGk19JQi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cgpmiXXI"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A403C00
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725262906; cv=none; b=FEQ8stud+ee4/GfHY+qWd61tlPWTe75McM04aKypPZwJX54hO402SXea8HZ4S7QuxgTd76bBM1A3vIUaXbiz4Jvjpni+iv94rLc3aCmlTP2IE9A0Syt5Jbp2/La8YpRfq4gJEQNcVfyJfYr3YCDGa36onxNZyQ652Aut9EL+yiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725262906; c=relaxed/simple;
	bh=RwAiEQncvL/zmNqMSLohnfQbc/Bw6xxgZ90oDSvUlFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JhASVwuKNSORJ3oTm/wN6+VDd4mhW7+iRoOrXDBlccj6AUCiSlUI9fD193EtSNOX9/elTbKxk6UoddvmZPObk7JVtmpmHodNqW/qgcT5g3FMDAeEBFXJOB3pKxO6r2y9B652N43ySq49UjbqVLWcFJ70w2tAkRSSYezfcPCehu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PGk19JQi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cgpmiXXI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PGk19JQi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cgpmiXXI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 86B461F76E;
	Mon,  2 Sep 2024 07:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725262902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EX0H1PjAqRRFPK0zDTGARbiqf560EUsl9OA9NCyB7po=;
	b=PGk19JQidipHXNAd2IVyouzoLwyiKTAoYi+JvdaoVa7Tvwv9Pzmc2IKUnJVwpd5uNHG6UT
	fV2SFg3Zt+4nKBcqjTvKD6LA/M/flcQikTTNu0OTnOwlPGnkjvSvFLf+5uqMNjijJf8hFR
	HROWpNlmW2iNPdLGGTIYYoYdr9cYkIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725262902;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EX0H1PjAqRRFPK0zDTGARbiqf560EUsl9OA9NCyB7po=;
	b=cgpmiXXI/xEhdFmiYK2HISL+Lbzj+XXxgAF0ERaP60qVev+zPeATVa6w0w15aTR4Jp6jW3
	+stGpjlkdm63XxBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PGk19JQi;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cgpmiXXI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725262902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EX0H1PjAqRRFPK0zDTGARbiqf560EUsl9OA9NCyB7po=;
	b=PGk19JQidipHXNAd2IVyouzoLwyiKTAoYi+JvdaoVa7Tvwv9Pzmc2IKUnJVwpd5uNHG6UT
	fV2SFg3Zt+4nKBcqjTvKD6LA/M/flcQikTTNu0OTnOwlPGnkjvSvFLf+5uqMNjijJf8hFR
	HROWpNlmW2iNPdLGGTIYYoYdr9cYkIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725262902;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EX0H1PjAqRRFPK0zDTGARbiqf560EUsl9OA9NCyB7po=;
	b=cgpmiXXI/xEhdFmiYK2HISL+Lbzj+XXxgAF0ERaP60qVev+zPeATVa6w0w15aTR4Jp6jW3
	+stGpjlkdm63XxBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F420E13AE5;
	Mon,  2 Sep 2024 07:41:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TqoJOjVs1WYIMgAAD6G6ig
	(envelope-from <aherrmann@suse.de>); Mon, 02 Sep 2024 07:41:41 +0000
Date: Mon, 2 Sep 2024 09:41:40 +0200
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
Subject: Re: [PATCH v5 4/4] x86/cacheinfo: Clean out init_cache_level()
Message-ID: <20240902074140.GA4179@alberich>
References: <20240827051635.9114-1-ricardo.neri-calderon@linux.intel.com>
 <20240827051635.9114-5-ricardo.neri-calderon@linux.intel.com>
 <20240901180911.GD4089@alberich>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240901180911.GD4089@alberich>
X-Rspamd-Queue-Id: 86B461F76E
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,intel.com:email,suse.de:dkim,suse.de:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -6.01
X-Spam-Flag: NO

On Sun, Sep 01, 2024 at 08:09:13PM +0200, Andreas Herrmann wrote:
> On Mon, Aug 26, 2024 at 10:16:35PM -0700, Ricardo Neri wrote:
> > init_cache_level() no longer has a purpose on x86. It no longer needs to
> > set num_leaves, and it never had to set num_levels, which was unnecessary
> > on x86.
> > 
> > Replace it with "return 0" simply to override the weak function, which
> > would return an error.
> > 
> > Reviewed-by: Len Brown <len.brown@intel.com>
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> 
> Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
> Tested-by: Andreas Herrmann <aherrmann@suse.de>
> 
> Test was done with a system equipped with AMD Phenom II X6 1055T and
> test kernels based on v6.11-rc5-176-g20371ba12063.

FYI, the test consisted of booting the mainline kernel w/o and w/ your
patches, checking for potential new errors/warnings in kernel log and
checking for changes or incosistencies in information of cache
characteristics as reported in sysfs, and by some tools (lscpu,
lstopo, x86info) -- e.g. x86info does not use sysfs to gather cache
information for CPUs.


Regards,
Andreas

