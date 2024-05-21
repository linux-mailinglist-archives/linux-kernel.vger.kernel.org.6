Return-Path: <linux-kernel+bounces-184704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4294C8CAAC5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFA65B21E37
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 09:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560E957CB2;
	Tue, 21 May 2024 09:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wt+2AfCB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o0iL+dvv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wt+2AfCB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o0iL+dvv"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA1350A6E
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 09:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716283608; cv=none; b=l/VOGO1Bks0ELvFdR+k/XQKxj/3UaSQFeE/0JAqBTR3gAUncxUmSFAWOlbOwJrNVJttUP8p63OZeqSq78FsUzwZCGysmf/NNc803vvlih4Irk5NVkuHs6C+noSiT4NZ34MFJpaKF3Onn4N9NTNL0yaDmz+kQo+Nczy63X0U5kUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716283608; c=relaxed/simple;
	bh=ReLRnosAncFwBKbnbLuCLJoQyjDkCDiJgrNvXOxpJNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fj9A9U2cO909CrAq2nif+ZROqV29WryLQnqD0c/AtleRHEaeMJDu+RTbSuF3VvFuplPaa7kT+RZrloRHwaVRH0u2ban1aybIYdf8ekbDUhx3HzAsijQzm9OlMuRu4dFPDc/nu5McDMNXuI6ooG4KgES7E8s8HnKkCtBEVcx8620=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wt+2AfCB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=o0iL+dvv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wt+2AfCB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=o0iL+dvv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 506443463D;
	Tue, 21 May 2024 09:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716283605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1GWukd9NO4u4o6Q13nvrfzriDiUBgbt+4zVzPdfTsTE=;
	b=wt+2AfCBu3/MulyG94WXb59RPwUJeCxdGWUUnWS/42v3QyYensjX1M+gTTKQkDwIzBnqPN
	0syUTsUWNpHpuGsAghYBZ4gZ3N5dFbZDt5VWJKU1wdCIXaEakdRXM2pCaxk8bJEOF1RSxM
	+z2HtcoqkNyZXP4/SL51arGG+LaqcSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716283605;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1GWukd9NO4u4o6Q13nvrfzriDiUBgbt+4zVzPdfTsTE=;
	b=o0iL+dvvVuoNS4tYjWAZsLq/xyG8ty3SjDYPf60C2oDtitEvyxLYMb7wxW6tqbs7dDiSSi
	YJ4/i7hyplODoNDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716283605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1GWukd9NO4u4o6Q13nvrfzriDiUBgbt+4zVzPdfTsTE=;
	b=wt+2AfCBu3/MulyG94WXb59RPwUJeCxdGWUUnWS/42v3QyYensjX1M+gTTKQkDwIzBnqPN
	0syUTsUWNpHpuGsAghYBZ4gZ3N5dFbZDt5VWJKU1wdCIXaEakdRXM2pCaxk8bJEOF1RSxM
	+z2HtcoqkNyZXP4/SL51arGG+LaqcSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716283605;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1GWukd9NO4u4o6Q13nvrfzriDiUBgbt+4zVzPdfTsTE=;
	b=o0iL+dvvVuoNS4tYjWAZsLq/xyG8ty3SjDYPf60C2oDtitEvyxLYMb7wxW6tqbs7dDiSSi
	YJ4/i7hyplODoNDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BCB9813A1E;
	Tue, 21 May 2024 09:26:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SKdsK9RoTGZoRgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 21 May 2024 09:26:44 +0000
Date: Tue, 21 May 2024 11:26:43 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC PATCH v2 06/20] powerpc/8xx: Fix size given to
 set_huge_pte_at()
Message-ID: <Zkxo0xmTHgjgBtKw@localhost.localdomain>
References: <cover.1715971869.git.christophe.leroy@csgroup.eu>
 <04f4e737608ea0b177b88057db138fbf0d6ab138.1715971869.git.christophe.leroy@csgroup.eu>
 <ZksUiwNaKx2n1fJO@localhost.localdomain>
 <f26807dd-bbd2-405d-9a88-c0654c525a5c@csgroup.eu>
 <87zfsk2dnu.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfsk2dnu.fsf@mail.lhotse>
X-Spam-Flag: NO
X-Spam-Score: -8.30
X-Spam-Level: 
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[csgroup.eu,linux-foundation.org,nvidia.com,redhat.com,gmail.com,vger.kernel.org,kvack.org,lists.ozlabs.org];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Tue, May 21, 2024 at 10:48:21AM +1000, Michael Ellerman wrote:
> Yeah I can. Does it actually cause a bug at runtime (I assume so)?

No, currently set_huge_pte_at() from 8xx ignores the 'sz' parameter.
But it will be used after this series.

-- 
Oscar Salvador
SUSE Labs

