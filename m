Return-Path: <linux-kernel+bounces-175426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5038C1F82
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 10:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A8251F220D6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6003B15F40B;
	Fri, 10 May 2024 08:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="V6F4acAT";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="V6F4acAT"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20529131192
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 08:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715328615; cv=none; b=B0LwnHBDR6/7l9kXwx7Wfn4q2uU4WyRNOf+fqe6IMnqHpLLOtq4jKbhpIq5Jm74mnsNRaN4E/zafPViLCqa+hYCesF417XKr3XiR3hX6Kc6+xzMd95q2UVAVU2RtfCdFmtValMjphA05L4QMgef50DViDFHQOc9uz0TZoFU/vZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715328615; c=relaxed/simple;
	bh=zgAuHVFHQr1ht3IEgbfanxeRqi+MyvpjdLBqSFhWuZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxwIrGTcFOAR8cTqYNR5A1H/pbMJk/30THNlkFgSXrDdQVwxXNQDN2M+pomK9yF/cT1iV2hf8ueXkauqniTvZ9bQcNvLzXWECdlEZTgu3l2LQfCD70dPXGmA/PnCxJtW9fA7EjBEXxQinUTYykjqvKGGn1Op9V9LNvqh/qNhDBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=V6F4acAT; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=V6F4acAT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5044B3EBAF;
	Fri, 10 May 2024 08:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715328612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=khNvkzd8LR0P71VStresAD/ElP/DV4CPOO6yMG2z+nA=;
	b=V6F4acATUac5VcSM2ZCsP4xzayjl4x+Gy2cVYGnxr8gm2PKSRphltaIxHfpctDxOzRXofe
	yg/HOUkf8c9DcjibchUGpJ8EHIodzXVgpNt0Y+87+o/O7dhOoriZKK0Dugq0kuXQHJD0sc
	Oup8aylmjo82XX4tUWEJfMUfNWQBNFY=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=V6F4acAT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715328612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=khNvkzd8LR0P71VStresAD/ElP/DV4CPOO6yMG2z+nA=;
	b=V6F4acATUac5VcSM2ZCsP4xzayjl4x+Gy2cVYGnxr8gm2PKSRphltaIxHfpctDxOzRXofe
	yg/HOUkf8c9DcjibchUGpJ8EHIodzXVgpNt0Y+87+o/O7dhOoriZKK0Dugq0kuXQHJD0sc
	Oup8aylmjo82XX4tUWEJfMUfNWQBNFY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 329CD1386E;
	Fri, 10 May 2024 08:10:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wbIqCmTWPWbYHgAAD6G6ig
	(envelope-from <mhocko@suse.com>); Fri, 10 May 2024 08:10:12 +0000
Date: Fri, 10 May 2024 10:10:03 +0200
From: Michal Hocko <mhocko@suse.com>
To: David Rientjes <rientjes@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, gthelen@google.coma,
	Chris Li <chriscli@google.com>
Subject: Re: [PATCH rfc 0/9] mm: memcg: separate legacy cgroup v1 code and
 put under config option
Message-ID: <Zj3WWwJ-21xWqRcL@tiehlicka>
References: <20240509034138.2207186-1-roman.gushchin@linux.dev>
 <jf44dfyaenz6xmn2hcodaginrshw5d5hfhmakdxtj4x6szk6b2@cr2rxamkgj2m>
 <edff9a60-a77f-bc6c-3d07-4f96a97f1e38@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edff9a60-a77f-bc6c-3d07-4f96a97f1e38@google.com>
X-Spam-Flag: NO
X-Spam-Score: -6.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5044B3EBAF
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.01 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim]

On Thu 09-05-24 19:59:19, David Rientjes wrote:
> On Wed, 8 May 2024, Shakeel Butt wrote:
> 
> > Hi Roman,
> > 
> > A very timely and important topic and we should definitely talk about it
> > during LSFMM as well. I have been thinking about this problem for quite
> > sometime and I am getting more and more convinced that we should aim to
> > completely deprecate memcg-v1.
> > 
> 
> I think this would be a very worthwhile discussion at LSF/MM, I'm not sure 
> if it would be too late for someone to make a formal proposal for it to be 
> included in the schedule.  Michal would know if there is a opportunity.

yes, I think we can and should have this discussion. I will put that on
the schedule. I will reference this email thread as a topic proposal
with Shakeel and Roman to lead the session.
-- 
Michal Hocko
SUSE Labs

