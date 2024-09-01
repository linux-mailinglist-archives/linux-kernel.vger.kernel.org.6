Return-Path: <linux-kernel+bounces-310350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC60967BA8
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 20:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F9E71F21837
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 18:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BCA183CC1;
	Sun,  1 Sep 2024 18:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qMCTd3Bn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9oI7iXTq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eP7QcwuB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tz3KS+q7"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B8417E919
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 18:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725214094; cv=none; b=chxM3RaUow34Q3FEIhsUVvY3zB83P7zKDjGWra5lWu4EPXK8byXtSqHNU0fP+r6neImJhphlggXPj1o1fuRLep3B7GNTFmrW58uhUziLAxvWoLMu6mS1y4PJYeaBQqCIWCzA2zB1H5/lb87lkw6Da9EltxA+Dv2M6FT3er44uOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725214094; c=relaxed/simple;
	bh=rFag0zrN5liY/FgN4p8vx/uomZQXuGFf6KrHQ0c3Wvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ua9NcnuIN8sSNb1SIw+g47N2il9sejpzHqdAkuW0K3qN9R8OIJKTyYAS1k85kJv+SsMOtz3HaBoWYwjIJ2aO16h5uycTfRCgSZe5DDgDDCMtoSfNRIgVbl+NwGqAtMl40jmcJmx+0tOA4TSGpZTT/oLd9ZNg7pK33zNy4KmZCcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qMCTd3Bn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9oI7iXTq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eP7QcwuB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tz3KS+q7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B64C621B0C;
	Sun,  1 Sep 2024 18:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725214090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yeu+FWAer1Fai729WDTnws0KdwFU8RI3XH6EY7luH1k=;
	b=qMCTd3BnzpspOkIl3ldqhadwxUA+5ze7lzBOL2Cq2uD1NfsVfpaLkckFWvhmL0vx/9zeJh
	kQN2f1EW0S55dPp+RVIpoViCtEigPjWwqBpu534ETtCOM1KSWjAbDFQuCsYoVEQTgqBtYy
	XN0h3eCztCpP+KVd0Iah0NEX7C2XhSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725214090;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yeu+FWAer1Fai729WDTnws0KdwFU8RI3XH6EY7luH1k=;
	b=9oI7iXTq355UOQ7cZB7FPyVX8zxshr7NYFxcoxM2m9oIKmaYZV4GL+Hy1UNAHtzg78DJxa
	vXJ4l2RdGD7xkSBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eP7QcwuB;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tz3KS+q7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725214089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yeu+FWAer1Fai729WDTnws0KdwFU8RI3XH6EY7luH1k=;
	b=eP7QcwuBO6JCZUAHXh69CfjNZPlZgnw+rVekwA08D1e68w7QJPtw/QLyRqS8H+vHSBWUrl
	jkkb1sOMd/6GOkO655cOS/JHddWIVD4zODlmctzLK0dtCzioEtictR5oiQ9lrLBAlXPFqe
	S66RfR4iqM6ziI72TQ0rCvvLI0LnjMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725214089;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yeu+FWAer1Fai729WDTnws0KdwFU8RI3XH6EY7luH1k=;
	b=tz3KS+q7JTcR0CjDSKWgQGVhsyYnvPk3XwmlUJgg0pYt0PqtMLLDr6hFrKZJwKLyKl0n0G
	NhU29kF+x0tmn0Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 35DC81373A;
	Sun,  1 Sep 2024 18:08:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 08CtC4mt1GaZXwAAD6G6ig
	(envelope-from <aherrmann@suse.de>); Sun, 01 Sep 2024 18:08:09 +0000
Date: Sun, 1 Sep 2024 20:08:07 +0200
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
Subject: Re: [PATCH v5 2/4] cacheinfo: Allocate memory for memory if not done
 from the primary CPU
Message-ID: <20240901180807.GB4089@alberich>
References: <20240827051635.9114-1-ricardo.neri-calderon@linux.intel.com>
 <20240827051635.9114-3-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240827051635.9114-3-ricardo.neri-calderon@linux.intel.com>
X-Rspamd-Queue-Id: B64C621B0C
X-Spam-Score: -6.01
X-Rspamd-Action: no action
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim,intel.com:email,arm.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Aug 26, 2024 at 10:16:33PM -0700, Ricardo Neri wrote:
> Commit 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU")
> adds functionality that architectures can use to optionally allocate and
> build cacheinfo early during boot. Commit 6539cffa9495 ("cacheinfo: Add
> arch specific early level initializer") lets secondary CPUs correct (and
> reallocate memory) cacheinfo data if needed.
> 
> If the early build functionality is not used and cacheinfo does not need
> correction, memory for cacheinfo is never allocated. x86 does not use the
> early build functionality. Consequently, during the cacheinfo CPU hotplug
> callback, last_level_cache_is_valid() attempts to dereference a NULL
> pointer:
> 
>      BUG: kernel NULL pointer dereference, address: 0000000000000100
>      #PF: supervisor read access in kernel mode
>      #PF: error_code(0x0000) - not present page
>      PGD 0 P4D 0
>      Oops: 0000 [#1] PREEPMT SMP NOPTI
>      CPU: 0 PID 19 Comm: cpuhp/0 Not tainted 6.4.0-rc2 #1
>      RIP: 0010: last_level_cache_is_valid+0x95/0xe0a
> 
> Allocate memory for cacheinfo during the cacheinfo CPU hotplug callback if
> not done earlier.
> 
> Reviewed-by: Radu Rendec <rrendec@redhat.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Fixes: 6539cffa9495 ("cacheinfo: Add arch specific early level initializer")
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
Tested-by: Andreas Herrmann <aherrmann@suse.de>

Test was done with a system equipped with AMD Phenom II X6 1055T and
test kernels based on v6.11-rc5-176-g20371ba12063.


Thanks,
Andreas

