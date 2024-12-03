Return-Path: <linux-kernel+bounces-429754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDDF9E2381
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA7F11694CF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF9D1F76AA;
	Tue,  3 Dec 2024 15:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TOvI03bd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CPfMiSxv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TOvI03bd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CPfMiSxv"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3C51F75B6
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239942; cv=none; b=eWVKdsv/xD6COs8ZoSRPC9a0FzEa5/wcTlWtG8u2xoTpqOtRLmuHOkoxk0vcoRnynIoubycTHAHodWVRxJbzuzdT7DEKm37hA2FUbO5pq25jcOz5ppJ5PjZuyqmx9UOSzDL4orC20c4IpdSaONA8Rl9BGvVCEPf69AYeRRyRC/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239942; c=relaxed/simple;
	bh=aYlKV2jeVxibKzOnRwiGHIdTA3Vocb7dvubioivekLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNorayj+OP82DAKJ1PeQ8UraTKT94gEHBVPm/KOCc4heCoz3WdVXztScihD3QOq20TOnscM357GGzJTxQ+ToiVBS7k1ByIj5AhKLLy3FWg5UFsUQta7xka9uf572nDImEH5nS4ANU/mI5C9uu0zH0c+4IcX9yj46ZkEu+JG7bXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TOvI03bd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CPfMiSxv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TOvI03bd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CPfMiSxv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DB6D81F44F;
	Tue,  3 Dec 2024 15:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733239938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sQEPANKUT0cfADuBgnXFUugp30DVlgxMGy/pm9+LgAM=;
	b=TOvI03bdyxJ4Lq3UN+Mk8rfoTSUlMXsX6spi+bN2NZG18Uz2WAj7xFxHX914XqkK48k0Bz
	4+WeV/5mmYtMavM0eeCb4WRy2HQ3yJxnxL65kpk0eNzgD2W/sCgTOIRvTcqLEYSpfvBbxg
	rgVWmZOjEhGAEzhDZAS8INMZmJgVcMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733239938;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sQEPANKUT0cfADuBgnXFUugp30DVlgxMGy/pm9+LgAM=;
	b=CPfMiSxvT5UIg8zMYu1DkDeI14ZiNXUF4pziyMwb5mLyoV3Q2bG3pLVeIdoPpoGVD0vZ/4
	2510+XqdSMJJPHDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733239938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sQEPANKUT0cfADuBgnXFUugp30DVlgxMGy/pm9+LgAM=;
	b=TOvI03bdyxJ4Lq3UN+Mk8rfoTSUlMXsX6spi+bN2NZG18Uz2WAj7xFxHX914XqkK48k0Bz
	4+WeV/5mmYtMavM0eeCb4WRy2HQ3yJxnxL65kpk0eNzgD2W/sCgTOIRvTcqLEYSpfvBbxg
	rgVWmZOjEhGAEzhDZAS8INMZmJgVcMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733239938;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sQEPANKUT0cfADuBgnXFUugp30DVlgxMGy/pm9+LgAM=;
	b=CPfMiSxvT5UIg8zMYu1DkDeI14ZiNXUF4pziyMwb5mLyoV3Q2bG3pLVeIdoPpoGVD0vZ/4
	2510+XqdSMJJPHDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3ACD113A15;
	Tue,  3 Dec 2024 15:32:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5v9oC4IkT2dZSQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 03 Dec 2024 15:32:18 +0000
Date: Tue, 3 Dec 2024 16:32:12 +0100
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: Re: [PATCH RESEND v2 2/6] mm/page_isolation: don't pass gfp flags to
 start_isolate_page_range()
Message-ID: <Z08kfBOXMiu7FFXN@localhost.localdomain>
References: <20241203094732.200195-1-david@redhat.com>
 <20241203094732.200195-3-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203094732.200195-3-david@redhat.com>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.ozlabs.org,linux-foundation.org,nvidia.com,ellerman.id.au,gmail.com,csgroup.eu,kernel.org,linux.ibm.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,nvidia.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Dec 03, 2024 at 10:47:28AM +0100, David Hildenbrand wrote:
> The parameter is unused, so let's stop passing it.
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

