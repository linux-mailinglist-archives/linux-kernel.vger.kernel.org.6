Return-Path: <linux-kernel+bounces-188591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5768CE406
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27A141F217CC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1ED85267;
	Fri, 24 May 2024 10:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nx/O++w0";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nx/O++w0"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588BD55E73;
	Fri, 24 May 2024 10:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545471; cv=none; b=oEMGnHiAElYJrPCaQVOCmXA/64VYa1oeThddg1GcLyCARDp6eifazYyh9oZIFpk7vrKPQ9CB2Q6z4dCD7rIO0V8WT4j3UEwVi924eIAOGBeUjflKiKijGTxYCUP+OZSzeHnylmJpWJQVawiNTPCLgqw9rFwAfoNyTlQfFJWwMg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545471; c=relaxed/simple;
	bh=9kgNx994pKzolw9CWmdc7IWCOws4XyHz5c9lpBZfYMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOBj77EInICtyXG3sQAqzGsG+5D1Fheh4URC3Kjlro6klTyyt2s5L09051QEDmXhyi8diPHixFLnB3H63spz6ffzlkOORGkaojIkqToXzHnGQcqkrJqbrt6WWE0KoeiTshFy2ZOvGw9PpENG03Za6uSJjFh4zp9yNLRLCtRUsHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nx/O++w0; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nx/O++w0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 64FD633A12;
	Fri, 24 May 2024 10:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716545465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2TZ0stl9BSXah0gGxoM3/BYyBtq0boaJRO/ho9ciTAA=;
	b=nx/O++w02PfP4uWEl/hgiUBFnypdKjevWeKbl+Dd3To80TPnib0s1MtbuTDKZ/MtIsrU8w
	CLL7gUs2XMnm9hjg824MN4sw8gXGsBQxsARfvRzrPgOWbmYb76Ki3KB4T2GXi9jwv+kDWZ
	43VUve0mTMKXRarWESqSe+oFfAZptq4=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="nx/O++w0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716545465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2TZ0stl9BSXah0gGxoM3/BYyBtq0boaJRO/ho9ciTAA=;
	b=nx/O++w02PfP4uWEl/hgiUBFnypdKjevWeKbl+Dd3To80TPnib0s1MtbuTDKZ/MtIsrU8w
	CLL7gUs2XMnm9hjg824MN4sw8gXGsBQxsARfvRzrPgOWbmYb76Ki3KB4T2GXi9jwv+kDWZ
	43VUve0mTMKXRarWESqSe+oFfAZptq4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C3E613A6B;
	Fri, 24 May 2024 10:11:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id omPKELlnUGZuZgAAD6G6ig
	(envelope-from <mhocko@suse.com>); Fri, 24 May 2024 10:11:05 +0000
Date: Fri, 24 May 2024 12:10:56 +0200
From: Michal Hocko <mhocko@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-35906: drm/amd/display: Send DTBCLK disable message on
 first commit
Message-ID: <ZlBnsEsr66mR-frf@tiehlicka>
References: <2024051954-CVE-2024-35906-1c6f@gregkh>
 <ZkxbObACcnUMZ3LA@tiehlicka>
 <2024052136-cubbyhole-ecologist-5b68@gregkh>
 <ZkzREEA5_N_xfqED@tiehlicka>
 <2024052110-grasp-liking-22c0@gregkh>
 <ZkzgZoxF_RD50PdW@tiehlicka>
 <2024052243-napping-coastal-3306@gregkh>
 <Zk790Afi1sfwgrZi@tiehlicka>
 <2024052309-scabby-favored-0973@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024052309-scabby-favored-0973@gregkh>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 64FD633A12
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	DKIM_TRACE(0.00)[suse.com:+]

On Thu 23-05-24 15:49:59, Greg KH wrote:
> On Thu, May 23, 2024 at 10:26:56AM +0200, Michal Hocko wrote:
> > On Wed 22-05-24 05:57:38, Greg KH wrote:
> > [...]
> > > > I completely do get why you do not care about that downstream
> > > > engineering cost but generating bogus CVEs on top of a huge pile of
> > > > dubious ones is less than useful, don't you think?
> > > 
> > > How is this a "bogus" CVE on their own?
> > 
> > I suspect you haven't looked at those commits. This is a boot time
> > suboptimal HW configuration. There is no way any user can exploit that I
> > can see. Not to mention it cases system boot hangs!
> 
> Yes, you are correct, the original should not have had a CVE assigned to
> it, that was wrong, and I have rejected it now.  Same for the revert, it
> too is now rejected.  Thanks for the review, it is much appreciated.

Thanks for considering the feedback!

> Also, the reason the original had a cve assigned to it was a fault on my
> side, that shouldn't have happened, and I've re-reviewed to make sure
> that I didn't mark anything else that way as well (so far I have not
> found anything, the 'revert' caused problems in our tools, not to blame
> them, but me, the author of that tool...)

Good to hear this has an explanation.

[...]
> Because of asking, many others are starting to help out, you can too,
> just submit patches against the cve/review/proposed/ directory with a
> list of commits that you feel should have CVEs assigned for, or annotate
> why you feel specific ones we have reviewed should NOT have a CVE
> assigned, and our tools can handle them quite well as part of the
> assignment process (see scripts/cve_review for a tool that some of us
> use to create these files, that's not required, as not all of us use it,
> but the output format is the key, and that's a simple list of commit
> ids, personally I generate that from mboxes.)

Do I get it right that proposals shouldn't be sent via email to
cve@kernel.org as suggested by the in tree documentation? I do not mind
the specific workflow but until now I have followed Documentation/process/cve.rst
as authoritative source of the process. It would be really great if that
matched the workflow.

> > > Also, this is work ostensibly that you are also already doing for your
> > > day-job, right?
> > 
> > We, like stable trees, rely on Fixes tag and those (including other
> > commits that might be this tag) are reviewed by domain experts.
> 
> Great, so you already have reviewed all of these, so it should be a
> simple match up on your end.

Not at all. Every incoming CVE has to go through CVSS assessment at
least. This on its own is a very non-trivial and time consuming task
that obviously scales with the number of CVEs. There is more going
on besides that. 

[...]

> > If you really want to build a trust around the CVE process then make it
> > more transparent. I would start by adding reason why something has been
> > marked CVE. You are saying there is peer review process going on then
> > why not add Reviewed-by: to make it explicit and visible.
> 
> We have that, see the git log of the cve/review/ directory for the files
> and where most all of the cves come from.  Some come directly from
> requests by others to us, and a few other places (i.e. security
> reports), so we of course can't document the source of everything for
> obvious reasons.

Thanks for pointing me there but I do not think this is what I've had in
mind. I do understand that there is some pattern matching happening to
select most of the candidates, but as you've said this is then reviewed
and during that review you likely need to read through that changelog
and build some sort of statement why this is considered a security
threat.

I believe exactly _this_ would be a much more valuable information in
the CVE announcement than a copy&past of the changelog which on its own
can be trially referenced by a link. Also if there is a peer review
happening then Reviewed-by would be really nice. Not to mention
Reported-by if this was externally reported (the report could be a part
of the announcement as well).

Thanks!
-- 
Michal Hocko
SUSE Labs

