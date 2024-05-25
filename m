Return-Path: <linux-kernel+bounces-189333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0308CEE87
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 12:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECA301C20A60
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 10:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B59B2C1B9;
	Sat, 25 May 2024 10:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FG25BSdz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9j5f2Qw9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FG25BSdz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9j5f2Qw9"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A647022092
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 10:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716633200; cv=none; b=Lwmt9PWvRklR3Y+doDeK/zMYOJW3lX+H3YoLP840xH7NVvv+dJkTlDnYluiooRphLlBhJ7WOSAjrwkKNnUEwKi2n2mdyY39OrzVSDNHMO/eLWOHPfT6nf+W8a/8jMRlddaUaUr4ikqGb76DsFNVH/0LU8Aj58QC1t/xTHRSqz0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716633200; c=relaxed/simple;
	bh=x46igtU1tUzicwBmcOICHa9P+exO4P0vJ8MYZHmmc0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzDQ69uQqoec7sOU/syFcZX656DOjE2JyDvUDw2Awg/Tbpv/0Ga4isVaYsJ+KObJw8HaNou+bmH20+dXBn+PKshwNlWvbGs9zGDM7siYVPDL9q6vHdHPFcpUu4B3JERknK64GlsxIiU8aOmxzU9/MEW60bZsu83AIxDaBIh/fx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FG25BSdz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9j5f2Qw9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FG25BSdz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9j5f2Qw9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3BC452236D;
	Sat, 25 May 2024 10:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716633196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EyBe1R67Y6bo/xYFCjuP3FnAjryZ50/E+t5thd4tmxY=;
	b=FG25BSdzOpetS/IcEGGX5wNv68kYfzzfQ4D2FuLb+Wlmv7jM84OYtJ+rwZdJo5P6qEJRh1
	LaUtbPo8WUkODUMyo+9q1NUCOvZslgIWsJn/JSG7gIknOHhHcR76SXrcsDuuURUkiSkXOG
	FNLLQW7xw9wCsoxFzVAKAXfHETmlK28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716633196;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EyBe1R67Y6bo/xYFCjuP3FnAjryZ50/E+t5thd4tmxY=;
	b=9j5f2Qw9DCUifMKOgP+MHV7pFrM6j2unk/1MLKLMjkCOsJG8bj7MJTuJpSzkS2/OX15ABe
	IdScGMMpByiheLAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FG25BSdz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9j5f2Qw9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716633196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EyBe1R67Y6bo/xYFCjuP3FnAjryZ50/E+t5thd4tmxY=;
	b=FG25BSdzOpetS/IcEGGX5wNv68kYfzzfQ4D2FuLb+Wlmv7jM84OYtJ+rwZdJo5P6qEJRh1
	LaUtbPo8WUkODUMyo+9q1NUCOvZslgIWsJn/JSG7gIknOHhHcR76SXrcsDuuURUkiSkXOG
	FNLLQW7xw9wCsoxFzVAKAXfHETmlK28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716633196;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EyBe1R67Y6bo/xYFCjuP3FnAjryZ50/E+t5thd4tmxY=;
	b=9j5f2Qw9DCUifMKOgP+MHV7pFrM6j2unk/1MLKLMjkCOsJG8bj7MJTuJpSzkS2/OX15ABe
	IdScGMMpByiheLAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF24313A6B;
	Sat, 25 May 2024 10:33:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PUUdKGu+UWbBIQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Sat, 25 May 2024 10:33:15 +0000
Date: Sat, 25 May 2024 12:33:14 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC PATCH v2 11/20] powerpc/mm: Complement huge_pte_alloc() for
 all non HUGEPD setups
Message-ID: <ZlG-av78reSt_ksh@localhost.localdomain>
References: <cover.1715971869.git.christophe.leroy@csgroup.eu>
 <59a1390923c40b0b83ae062e3041873292186577.1715971869.git.christophe.leroy@csgroup.eu>
 <ZlFpPBlLoBZNjd73@localhost.localdomain>
 <d7da9fcb-2516-4233-b24f-22391cc7a553@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7da9fcb-2516-4233-b24f-22391cc7a553@csgroup.eu>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux-foundation.org,nvidia.com,redhat.com,ellerman.id.au,gmail.com,vger.kernel.org,kvack.org,lists.ozlabs.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3BC452236D
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.51

On Sat, May 25, 2024 at 06:44:06AM +0000, Christophe Leroy wrote:
> No, all have cont-PMD but only 8xx handles pages greater than PMD_SIZE 
> as cont-PTE instead of cont-PMD.

Yes, sorry, I managed to confuse myself. It is obvious from the code.

-- 
Oscar Salvador
SUSE Labs

