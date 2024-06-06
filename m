Return-Path: <linux-kernel+bounces-203726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE4B8FDF81
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D5F281D6C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 07:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0E313AD1D;
	Thu,  6 Jun 2024 07:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="I6RLl4RT";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YWBU5sB8"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7AE1BDEF;
	Thu,  6 Jun 2024 07:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717658654; cv=none; b=Z5aBAz70GMVbC7xu1d8JCB3dyp8MNbkbvxBuhTBykHAC79F62pB+58RD6VraMAm3dVFi8xXN/20AKef8yVF4FIKF6cyGi9rmHYCpFovmy4oVe4DPptY+FenCcnJYm//SpHJayUU1uwIiwZeeyXJP9oiehMPwCJQPJqAuacQl9MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717658654; c=relaxed/simple;
	bh=jXYEynwSQ/kS6Y2DZCqgLn0Xi95jhH4Mfjku3tq6uV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InfsNNijnyvkqpVAZGRV7fFGQltTUP0xt7dyXqqf3Y9hJ7G38on3VPt+UN93wCW+nWoUE6jTBTdiRM70WNoT7+JyqBzdLBuuvbggLm6YG6xfu4epnichYT/PRUW9fhWBpKbevwoKFaaOq1ImRMq4pTzFNOzBfPFtM14Q3AX6hig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=I6RLl4RT; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YWBU5sB8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DEB0521A84;
	Thu,  6 Jun 2024 07:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717658650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dV+8uG3NWP7Z2WVw8rJlpezXlpJJAU6quHjqjCAuUvg=;
	b=I6RLl4RTFv4iNm7RZk3oBzz1X4U9wTNmf++6TiYnwSjlgBzTnp/ljntV/374TuQ6sb1U0P
	w78+ysogjl1D35qof9jCd54F1SLwGyi604q2F0UQmdUrsbd0U7o2WKoK2kxnZPNOHtLndx
	j+4gpxqNtyWYaqwMc+09upJmlQUC/K4=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=YWBU5sB8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717658649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dV+8uG3NWP7Z2WVw8rJlpezXlpJJAU6quHjqjCAuUvg=;
	b=YWBU5sB8RlKNt2fwTCRD3FIIKW2t72h7Ml+CqY9t0gBQC3Kq+xjuwBIBk3ByKnMyzjFdfs
	UBnR1OJ4dJET6uT5HsViBzkUz+tbSd6ScKOJrtNglepjY85ZlsO2l7lXptvRy5TPdg0SQe
	tX1gGABBxJBt3T2PC3Cag5d/FWVjZvc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C631513A79;
	Thu,  6 Jun 2024 07:24:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /GBaLRlkYWbETgAAD6G6ig
	(envelope-from <mhocko@suse.com>); Thu, 06 Jun 2024 07:24:09 +0000
Date: Thu, 6 Jun 2024 09:24:09 +0200
From: Michal Hocko <mhocko@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org,
	Kees Cook <keescook@chromium.org>
Subject: Re: CVE-2023-52734: net: sched: sch: Bounds check priority
Message-ID: <ZmFkGWitjXvyOtbK@tiehlicka>
References: <2024052100-CVE-2023-52734-c8c2@gregkh>
 <ZlWNaIMC3NCkIFxv@tiehlicka>
 <2024052824-justice-lair-14e6@gregkh>
 <ZlbIZ8bdBK4tZcBa@tiehlicka>
 <2024052930-dealt-class-f845@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024052930-dealt-class-f845@gregkh>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DEB0521A84
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Wed 29-05-24 11:51:10, Greg KH wrote:
> On Wed, May 29, 2024 at 09:30:08AM +0200, Michal Hocko wrote:
[...]
> > I am questioning the decision to make it a CVE. Because if that was a
> > real deal then WARN_ON is something kernel CNA is considering a CVE worth
> > problem! So a CVE has been filed with a fix that is CVE itself.
> > Seriously how could this pass through the CVE review process?
> 
> "How" is "this was part of the entries in the GSD records that MITRE
> asked us to back-fill as CVE entries".  Those entries already went
> through two different rounds of review last year for the GSD record, and
> I did another one as well now before the CVE creation happened.  

I am sorry but I have no idea how that is supposed to justify assigning
a CVE to a non-issue with a fix that is clearly considered a CVE on its
own. An overlook, sure. That is understandable but the above doesn't
make any sense to me.

> It was in a batch where I reviewed 124 entries at once,

OK, this makes much more sense and I do not mean to blame you for
overlooking a particular things. But ...

> and if I only got one
> wrong, hey, that's a very good % overall, don't you think?  Especially
> as it has been a publicily listed "vulnerability fix" for well over a
> year now in the GSD system, and no one objected to it there.

... it is unavoidable to overlook completely bogus or even harmfull CVE
fixes if they are generated in the current volumes. It is much worse
that it is easier to overlook those which really are important.
Especially during CVSS assessment. This simply cannot scale!

[...]

> I welcome others to help out with this work, including yourself, if you
> so desire.  That would help out a lot.

I am sorry but I fundamentally disagree with the way how CVEs are
processed _now_ and therefore I will not put my name under that. I am
still hopeful that this is just the new process finding its own way and
it will settle on something much more reasonable and _useful_.

-- 
Michal Hocko
SUSE Labs

