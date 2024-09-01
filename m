Return-Path: <linux-kernel+bounces-310353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE21967BAD
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 20:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2321F219DD
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 18:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE82F183CC1;
	Sun,  1 Sep 2024 18:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="COkKsJRf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1aBcI1rA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DKMbLq04";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5c2c6Oor"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA6117E919
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 18:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725214158; cv=none; b=Rcb39iTEtVi331oQnXrCi3C0NMlR6ynediQP7okSpq+MXS86huQE68cWHqb64UEyDdWv1EWGXZZdRcDSJbLd5KakAhedsRhTNAYOcY0OeMUKoJJwp+oBD0S/lo/EAEKvW+SyZ27bG0IyqDgsa8osVsPnQtr1ia1EZzMn7jyAHsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725214158; c=relaxed/simple;
	bh=G/HxXszFZjhy2sHdwr023YRLB5MYD5w/fBTBWj7zO0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzSW232arKUXUdrRZctQ3JjjK584PE6ZdHcBNwgXkIVJXHC/a2zmT6SZRbECraji+dinOo/b0J0xYgTgM6+bB3TMnccuBTVona+RCPiIbRKj0fDExeXQKzEREQ+oWg1x2wAwla5QLiQUx0AfI3Stchzq8skQUw5sU5l5dUKzd1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=COkKsJRf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1aBcI1rA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DKMbLq04; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5c2c6Oor; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BDAE11FB61;
	Sun,  1 Sep 2024 18:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725214155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=plJa1DOC/pTcMpMktFQ38f1rbzKiwGKMYANUPlG+VnQ=;
	b=COkKsJRfSB8wDUzERvrPwgH1eYOnTZTe/wUvmAtCzQhatpzsuYvAaKJpD/E6nNpCemWUD5
	JD8CCzIiO6dfrCzh/df4fH7eGjD06jF769qna3oQwaBn4R+nT0OcakuzaTIe9FeLnA+6or
	M+0YKc15Jw0+rf22MwZhBIlxKX9K3FI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725214155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=plJa1DOC/pTcMpMktFQ38f1rbzKiwGKMYANUPlG+VnQ=;
	b=1aBcI1rAzuP2IwADt7uUE8RtoPOr7/Pou3TNBB6/YD8aqKeCPF9xjXz9SVft4ZqCLF5RG/
	K3kTLsty5U54n0Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DKMbLq04;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5c2c6Oor
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725214153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=plJa1DOC/pTcMpMktFQ38f1rbzKiwGKMYANUPlG+VnQ=;
	b=DKMbLq04F/de/1UWu+JGRlBi3lJUK0BF8BGXPcBbekUoTkMjAm/XoAdJT0eSY3YVqQWZk4
	uZFDsk9WgBNnfvpwlFg8zqw8EWNqT2VXDa4JBkq1dy9YoDYoS7EDDSYRuaVwocMYFLza7q
	rDJ0vLWSrdf1wq9s3QdpuQzivTj8O9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725214153;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=plJa1DOC/pTcMpMktFQ38f1rbzKiwGKMYANUPlG+VnQ=;
	b=5c2c6Oor2iqkvyVLgluLggPn2avMKK1JA/H+iff7FqT5EQuCOYSfl+kshTWWz+ehAzdudp
	3T5phBTIOBXz6CCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3808A1373A;
	Sun,  1 Sep 2024 18:09:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id huciDMmt1GYIYAAAD6G6ig
	(envelope-from <aherrmann@suse.de>); Sun, 01 Sep 2024 18:09:13 +0000
Date: Sun, 1 Sep 2024 20:09:11 +0200
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
Message-ID: <20240901180911.GD4089@alberich>
References: <20240827051635.9114-1-ricardo.neri-calderon@linux.intel.com>
 <20240827051635.9114-5-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240827051635.9114-5-ricardo.neri-calderon@linux.intel.com>
X-Rspamd-Queue-Id: BDAE11FB61
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,intel.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Aug 26, 2024 at 10:16:35PM -0700, Ricardo Neri wrote:
> init_cache_level() no longer has a purpose on x86. It no longer needs to
> set num_leaves, and it never had to set num_levels, which was unnecessary
> on x86.
> 
> Replace it with "return 0" simply to override the weak function, which
> would return an error.
> 
> Reviewed-by: Len Brown <len.brown@intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
Tested-by: Andreas Herrmann <aherrmann@suse.de>

Test was done with a system equipped with AMD Phenom II X6 1055T and
test kernels based on v6.11-rc5-176-g20371ba12063.


Thanks,
Andreas

