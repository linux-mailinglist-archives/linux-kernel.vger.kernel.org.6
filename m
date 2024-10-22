Return-Path: <linux-kernel+bounces-375842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 986EA9A9B93
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F43EB24556
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A231547EE;
	Tue, 22 Oct 2024 07:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bAtSvp6M";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3EiqQYYG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bAtSvp6M";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3EiqQYYG"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB064132120
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 07:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729583753; cv=none; b=nynEKn3m+JuTkLmr0/4MFLNGbyXbHeovHHW8vwDm/lGeol+fq+jPKzwtLNwgQaPNCcPEGB/V1y32XrXJFkC8DB8Ko9NXuS0ljlM0qKrbFWNkQIWbEWl7dI22vGeHgWgcaYg3zb/fJnkjm1g88qKwbvci0RK2EDoNcK2HMf/3UQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729583753; c=relaxed/simple;
	bh=/8Er/AUYD4hj1s7+XSWDuI9wLsc8YldxLC8X8QCJho0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBAz86mPuj/ULwZXaobM+9oPvyVeiBtKEMZNUdg9s305nYJuX3XDR31uM6ZhxqlCLeam8TRuoeyOjrcUI9OkRMLSxPxZUwf3GywfFA8GthikKGiAX/l4jI3CTm68svhysPjjw/nVPF3edGSeLfoSSLAXJEjctGSpFCHgTvqa+g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bAtSvp6M; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3EiqQYYG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bAtSvp6M; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3EiqQYYG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AB6CA1FD0E;
	Tue, 22 Oct 2024 07:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729583749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4NAbHlybu6mwcZvgKSBIXk7hxsZ4TE+ZES+Tk18EMyU=;
	b=bAtSvp6Max7ie7ok146EvYL+n/LsZhzbG/L++zZPXnNVK4xIUOc3gSoUhiB2fUcLeOLjNM
	+lmn85llmGBQG278tKVMt2B/NZdE+Wor/+jD/tcMcWn0SmHpYTOMVSypl18J8Dj/TF3IMF
	0lB6+qcdYIgQSkG7lsO3KXTcnY7/kyo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729583749;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4NAbHlybu6mwcZvgKSBIXk7hxsZ4TE+ZES+Tk18EMyU=;
	b=3EiqQYYGSDtcO0WyDquCrLp15NYNQPirQc/e5lF+nW4gzsfe9yLRfN3bY710DnRhKPIIil
	BK5o8CXUyh+9jUAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bAtSvp6M;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3EiqQYYG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729583749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4NAbHlybu6mwcZvgKSBIXk7hxsZ4TE+ZES+Tk18EMyU=;
	b=bAtSvp6Max7ie7ok146EvYL+n/LsZhzbG/L++zZPXnNVK4xIUOc3gSoUhiB2fUcLeOLjNM
	+lmn85llmGBQG278tKVMt2B/NZdE+Wor/+jD/tcMcWn0SmHpYTOMVSypl18J8Dj/TF3IMF
	0lB6+qcdYIgQSkG7lsO3KXTcnY7/kyo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729583749;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4NAbHlybu6mwcZvgKSBIXk7hxsZ4TE+ZES+Tk18EMyU=;
	b=3EiqQYYGSDtcO0WyDquCrLp15NYNQPirQc/e5lF+nW4gzsfe9yLRfN3bY710DnRhKPIIil
	BK5o8CXUyh+9jUAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D10C13AC9;
	Tue, 22 Oct 2024 07:55:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id InDAC4VaF2dRcAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 22 Oct 2024 07:55:49 +0000
Date: Tue, 22 Oct 2024 09:55:43 +0200
From: Oscar Salvador <osalvador@suse.de>
To: James Houghton <jthoughton@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Jason Gunthorpe <jgg@nvidia.com>,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm: Add missing mmu_notifier_clear_young for
 !MMU_NOTIFIER
Message-ID: <Zxdaf9tRs3fgOPqm@localhost.localdomain>
References: <20241021160212.9935-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021160212.9935-1-jthoughton@google.com>
X-Rspamd-Queue-Id: AB6CA1FD0E
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,localhost.localdomain:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Mon, Oct 21, 2024 at 04:02:12PM +0000, James Houghton wrote:
> Remove the now unnecessary ifdef in mm/damon/vaddr.c as well.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

