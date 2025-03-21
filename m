Return-Path: <linux-kernel+bounces-571157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 041A7A6B9DA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 346BE7A3F65
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0864C223335;
	Fri, 21 Mar 2025 11:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JXuVA2E0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E1FyE1pq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JXuVA2E0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E1FyE1pq"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DA0222592
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742556384; cv=none; b=ca93BIGwW3OGkB09d7q+hRCSuL/5XsRZs9Tl4DScQ/FEtbNZMpRRSwYfvQLwMJVCvvS0+rQBR//6BHYfDVtn3E/YZrHCJ5BQcAx1/yH4cTIcJAXk6Qehp7NJ9h3mH3QWN5FY2VGjIglsT19KE30/xabAsznlFHo0gW5j2ZZaKNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742556384; c=relaxed/simple;
	bh=wqu0oKPTt/0lRfWx2VyO1L6oFacWb5YPg2HmJSB3mzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHJnaoowE75uXV/H1kp2C4tMeHWW+s5Bz5CiZKIwNz+pDIAq7I9JA9/BkvY/6gAL9zb5deDyT3asNONfeczqGR0FE0wafr8eTZQJUNHo0yyfCftr+NqvtjIFJFvDMjKV2nuZ3lWmaVU0w6MYhgA2KTX/7/TovFfSQcDHbP98T00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JXuVA2E0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E1FyE1pq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JXuVA2E0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E1FyE1pq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D912A21752;
	Fri, 21 Mar 2025 11:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742556380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YM/FlJu51DPZxhfXzpnqUzpM5zsH6AKHxn7kKiWJjq4=;
	b=JXuVA2E0TMCms66Ss+KfXl02CDxLlCz3C5QDHsF3oEe/RPYZsp8gUXOLiOsK+aDYkuI5U5
	K4kfuOuA6N5KjjN6LitiwTmQR/pI81xxtpKHITFkG1txlgaBtJSlwdChGxNtc3jzIqeXtg
	8soI7XdvU3wgPBrsvbQwUCeUUdCC+bQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742556380;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YM/FlJu51DPZxhfXzpnqUzpM5zsH6AKHxn7kKiWJjq4=;
	b=E1FyE1pqtQifQDAnlfQOel5Jw8dtPmZk1WTHByUe0sYX2TRz+2UoPg+9hvEHb4qcjLS66k
	64h7Qu8KZCm08tAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742556380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YM/FlJu51DPZxhfXzpnqUzpM5zsH6AKHxn7kKiWJjq4=;
	b=JXuVA2E0TMCms66Ss+KfXl02CDxLlCz3C5QDHsF3oEe/RPYZsp8gUXOLiOsK+aDYkuI5U5
	K4kfuOuA6N5KjjN6LitiwTmQR/pI81xxtpKHITFkG1txlgaBtJSlwdChGxNtc3jzIqeXtg
	8soI7XdvU3wgPBrsvbQwUCeUUdCC+bQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742556380;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YM/FlJu51DPZxhfXzpnqUzpM5zsH6AKHxn7kKiWJjq4=;
	b=E1FyE1pqtQifQDAnlfQOel5Jw8dtPmZk1WTHByUe0sYX2TRz+2UoPg+9hvEHb4qcjLS66k
	64h7Qu8KZCm08tAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5829A139AA;
	Fri, 21 Mar 2025 11:26:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5bo4EtxM3WdUQQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 21 Mar 2025 11:26:20 +0000
Date: Fri, 21 Mar 2025 11:26:18 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.15] mm/vma: add give_up_on_oom option on modify/merge,
 use in uffd release
Message-ID: <233o4lohzhriye27szk6mucduneuvosmnp6pmnjepz3enxjgtt@id6kwhjgysbj>
References: <20250321100937.46634-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321100937.46634-1-lorenzo.stoakes@oracle.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri, Mar 21, 2025 at 10:09:37AM +0000, Lorenzo Stoakes wrote:
> Currently, if a VMA merge fails due to an OOM condition arising on commit
> merge or a failure to duplicate anon_vma's, we report this so the caller
> can handle it.
> 
> However there are cases where the caller is only ostensibly trying a
> merge, and doesn't mind if it fails due to this condition.
>

Ok, so here's my problem with your idea: I don't think merge should be exposed
to vma_modify() callers. Right now (at least AIUI), you want to modify a given
VMA, you call vma_modify(), and it gives you a vma you can straight up modify
without any problems. Essentially breaks down any VMAs necessary. This feels
contractually simple and easy to use, and I don't think leaking details about
merging is the correct approach here.

> Since we do not want to introduce an implicit assumption that we only
> actually modify VMAs after OOM conditions might arise, add a 'give up on
> oom' option and make an explicit contract that, should this flag be set, we
> absolutely will not modify any VMAs should OOM arise and just bail out.
>

Thus, to me the most natural solution is still mine. Do you think it places too
many constraints on vma_modify()? vma_modify() on a single VMA, without
splitting, Just Working(tm) is a sensible expectation (and vma_merge being fully
best-effort). Things like mprotect() failing due to OOM are also pretty disastrous,
so if we could limit that it'd be great.

In any case, your solution looks palatable to me, but I want to make
sure we're not making this excessively complicated.

-- 
Pedro

