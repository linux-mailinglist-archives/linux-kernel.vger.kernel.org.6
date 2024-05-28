Return-Path: <linux-kernel+bounces-191732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4608D1339
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 06:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEA97B21494
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 04:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1809C17C7F;
	Tue, 28 May 2024 04:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ydGePfnm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rMs5cO0m";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ydGePfnm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rMs5cO0m"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF991BC20
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 04:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716869554; cv=none; b=TiaWYG+SXIR7mJskflBn/LjCEVKynzB4+3b+UiWfyhfOMqnO5+ljXDBz3s2oOFkQAv0+c/OiQgoKbt8qXgHJbA+Cx5Lq8GwlMWZxIfTBYxOPy0P80F6RvfOJ36t2M1Le4ZLG9GCvIAbn1AcQFa5SR2Qq+sghpl56JQTKs789L3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716869554; c=relaxed/simple;
	bh=oI4MYNkcDayvJQTPe4NF+Zcqhv1sZeFcoIetBpgj7xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEsfOADfcBUbk+9fUZhYJ2oufyu9n04MEKAyfZW2Rk9mJiQYLV03bbLKF9sWrz85AvQvtD9xjoJ6aauMhF6jYg/uuA3Vv4sWCSsmwWdKdIrDvrGPTljMtQMTAgaed46egWkFAbUEse+wDH1hWeq+tcHMduivaKEFKr62NSZK8QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ydGePfnm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rMs5cO0m; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ydGePfnm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rMs5cO0m; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 79B2A200EB;
	Tue, 28 May 2024 04:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716869550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gy2fmPzIz29y+vFL0cHH3XbtFn60EEpegJmC7HngM3Y=;
	b=ydGePfnmIFiekzX2yeycuMFI3rGMkCkSm045XqJUhrvys0C8qxOEGBafgRcN84NeAq4CEd
	i4q/rp5lq07sxDnmBMITYthirZ3qtBaTXrZepvWmFStMArWSYrIr9hgRpBvwHlzaZ10PNi
	OGWSInYJGkJWj9AkxN0yT42eNwHcWW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716869550;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gy2fmPzIz29y+vFL0cHH3XbtFn60EEpegJmC7HngM3Y=;
	b=rMs5cO0mrpiKyRxl6kONIAW8jrBVplDJSL5Vofvz1QfKe7+Et5CXrdDbpsDo69bBRaEmJf
	EoRZbtRSGLab+kDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ydGePfnm;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rMs5cO0m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716869550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gy2fmPzIz29y+vFL0cHH3XbtFn60EEpegJmC7HngM3Y=;
	b=ydGePfnmIFiekzX2yeycuMFI3rGMkCkSm045XqJUhrvys0C8qxOEGBafgRcN84NeAq4CEd
	i4q/rp5lq07sxDnmBMITYthirZ3qtBaTXrZepvWmFStMArWSYrIr9hgRpBvwHlzaZ10PNi
	OGWSInYJGkJWj9AkxN0yT42eNwHcWW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716869550;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gy2fmPzIz29y+vFL0cHH3XbtFn60EEpegJmC7HngM3Y=;
	b=rMs5cO0mrpiKyRxl6kONIAW8jrBVplDJSL5Vofvz1QfKe7+Et5CXrdDbpsDo69bBRaEmJf
	EoRZbtRSGLab+kDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF59913A6B;
	Tue, 28 May 2024 04:12:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vbSXN61ZVWYJCwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 28 May 2024 04:12:29 +0000
Date: Tue, 28 May 2024 06:12:24 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v4 03/16] mm: Provide mm_struct and address to
 huge_ptep_get()
Message-ID: <ZlVZqNfjCw5Ay5qo@localhost.localdomain>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,nvidia.com,redhat.com,ellerman.id.au,gmail.com,vger.kernel.org,kvack.org,lists.ozlabs.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 79B2A200EB
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.51

On Mon, May 27, 2024 at 03:30:01PM +0200, Christophe Leroy wrote:
> On powerpc 8xx huge_ptep_get() will need to know whether the given
> ptep is a PTE entry or a PMD entry. This cannot be known with the
> PMD entry itself because there is no easy way to know it from the
> content of the entry.
> 
> So huge_ptep_get() will need to know either the size of the page
> or get the pmd.
> 
> In order to be consistent with huge_ptep_get_and_clear(), give
> mm and address to huge_ptep_get().
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs

