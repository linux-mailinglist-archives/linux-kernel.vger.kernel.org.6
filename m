Return-Path: <linux-kernel+bounces-310352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A548E967BAC
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 20:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D47F11C2149F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 18:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0ED14AD38;
	Sun,  1 Sep 2024 18:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rKztV13G";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/o5hJTLj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rKztV13G";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/o5hJTLj"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB91217B50B
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 18:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725214123; cv=none; b=t95oehlcEqWEnQBjxWH8xVZr0RjeG3MBk9K/VFgnmR3stEenDJls2J891AZqQxz1USiw/amBHXyiTfvyprhZoongS1oals73CoRIt/UB3asQOT5I0q4tdSyVQ/Y0ewXPdrht1799w8S99zD+OQtbK2rWJQHRNp2Osej6jAlVdUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725214123; c=relaxed/simple;
	bh=l/DscAc6cYYodCaK24DuuBIlCuEz9gQJBJI+fydlwEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgzXiYFd1oN736yfvin78QfiQizCXS0mOz3FfXSeXHEXuSaIIBAf33yjwjPgQlWF4wD8YTvAmYDEXfPtOOwZfLUUtrttgaiQzoFf4L8eZOBR7Xw708zV5oel6VcY55xj2CuZXdFKt989MI6kqrSGVv5vMFAfqvpcudHZzOge2wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rKztV13G; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/o5hJTLj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rKztV13G; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/o5hJTLj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 305EA21B0E;
	Sun,  1 Sep 2024 18:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725214120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EXvhVwXL6q1VPAGcxfLTeiywV9hLbQpFABx3PsM7Smg=;
	b=rKztV13GlzK8NzP5goehMFsPIFg+Hc8PcYYM1rY6l3R4XGTOlSt8H+bbvtJ0IpiOrd/eyu
	dhMnSxsZ1u5iv+sOmoBC4fyUM9258+SDi3fO98XhddzANc9ON5pBnzcCnh8ik9ta2IfKqH
	7megWyAdqzMFJk2NmK0Be+sE2HJtkO8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725214120;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EXvhVwXL6q1VPAGcxfLTeiywV9hLbQpFABx3PsM7Smg=;
	b=/o5hJTLjwL/0dsVF5riGuaM/Hy240GzlYssktZZcepZkKwDrAuFdP9S/cEvorZbn5DEGXn
	kT3jvjUWlb4ySSAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725214120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EXvhVwXL6q1VPAGcxfLTeiywV9hLbQpFABx3PsM7Smg=;
	b=rKztV13GlzK8NzP5goehMFsPIFg+Hc8PcYYM1rY6l3R4XGTOlSt8H+bbvtJ0IpiOrd/eyu
	dhMnSxsZ1u5iv+sOmoBC4fyUM9258+SDi3fO98XhddzANc9ON5pBnzcCnh8ik9ta2IfKqH
	7megWyAdqzMFJk2NmK0Be+sE2HJtkO8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725214120;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EXvhVwXL6q1VPAGcxfLTeiywV9hLbQpFABx3PsM7Smg=;
	b=/o5hJTLjwL/0dsVF5riGuaM/Hy240GzlYssktZZcepZkKwDrAuFdP9S/cEvorZbn5DEGXn
	kT3jvjUWlb4ySSAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4E4D1373A;
	Sun,  1 Sep 2024 18:08:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XubQJqet1GbnXwAAD6G6ig
	(envelope-from <aherrmann@suse.de>); Sun, 01 Sep 2024 18:08:39 +0000
Date: Sun, 1 Sep 2024 20:08:38 +0200
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
Subject: Re: [PATCH v5 3/4] x86/cacheinfo: Delete global num_cache_leaves
Message-ID: <20240901180838.GC4089@alberich>
References: <20240827051635.9114-1-ricardo.neri-calderon@linux.intel.com>
 <20240827051635.9114-4-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240827051635.9114-4-ricardo.neri-calderon@linux.intel.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,intel.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Aug 26, 2024 at 10:16:34PM -0700, Ricardo Neri wrote:
> Linux remembers cpu_cachinfo::num_leaves per CPU, but x86 initializes all
> CPUs from the same global "num_cache_leaves".
> 
> This is erroneous on systems such as Meteor Lake, where each CPU has a
> distinct num_leaves value. Delete the global "num_cache_leaves" and
> initialize num_leaves on each CPU.
> 
> Reviewed-by: Len Brown <len.brown@intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
Tested-by: Andreas Herrmann <aherrmann@suse.de>

Test was done with a system equipped with AMD Phenom II X6 1055T and
test kernels based on v6.11-rc5-176-g20371ba12063.


Thanks,
Andreas

