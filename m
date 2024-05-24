Return-Path: <linux-kernel+bounces-188763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BA28CE699
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 16:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273A71C20B7C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0009612BF38;
	Fri, 24 May 2024 14:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hA1Ya6qN";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hA1Ya6qN"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AA686255;
	Fri, 24 May 2024 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716559343; cv=none; b=hmBkFxiBH3D7iMtXeHpYq+uC3ByMr5J5p4BSvweUipuEcvTjI7QOztAuo8aURAwjbSwwZCTsB/nO+y5I91sFt1o05DK6UK11d8jft+T/HbLDGnVZ1uyLzunLltxzjo5v0fLUaLUk1Dkux52e+9oGu1Hir0gGSAx1PLDq9tpKGKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716559343; c=relaxed/simple;
	bh=hUnQZvh1OeWX8YEpNoZSomA44bla0dHoyGnqIqhTFrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuDg3GIH4v0bIkuFXJPilOA5Ys4OA+QLjhmxjqksP4XGGdztIIBwVfE4XwnsGw90nte9Zr1pP+Bz5+GO+galou5kX8zQl2640/1DwLEVqmQLIRViYIekFklKBn6EKl8zevf/3T7bQh41ZFWAbnCC5vw1dPPpr4EOKdgMJXlPcXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hA1Ya6qN; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hA1Ya6qN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4AC4A33B4C;
	Fri, 24 May 2024 14:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716559339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LMNjuXW0YTCBOxUjnc2jkU2tEh+hEHW9XCcd6JROZNk=;
	b=hA1Ya6qNdSQBUavvKiUNORHOym71k5veHqOr+WcN+gHZhSPXkCkx5m5ZcZ7rIbXgSsqPv4
	bG9p4oov+FHMP3J/7H8weoib2IkYGeVuwj0vSVmfTQgsueJWSeqoEOxN8HBxDFvhzy6MSx
	IxHEXTLTNOq8IyGyA9COeRIu49Unxw0=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716559339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LMNjuXW0YTCBOxUjnc2jkU2tEh+hEHW9XCcd6JROZNk=;
	b=hA1Ya6qNdSQBUavvKiUNORHOym71k5veHqOr+WcN+gHZhSPXkCkx5m5ZcZ7rIbXgSsqPv4
	bG9p4oov+FHMP3J/7H8weoib2IkYGeVuwj0vSVmfTQgsueJWSeqoEOxN8HBxDFvhzy6MSx
	IxHEXTLTNOq8IyGyA9COeRIu49Unxw0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3168F13A3D;
	Fri, 24 May 2024 14:02:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fXAbCeudUGbrBAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Fri, 24 May 2024 14:02:19 +0000
Date: Fri, 24 May 2024 16:02:18 +0200
From: Michal Hocko <mhocko@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-35906: drm/amd/display: Send DTBCLK disable message on
 first commit
Message-ID: <ZlCd6kD4w2mezWBj@tiehlicka>
References: <ZkxbObACcnUMZ3LA@tiehlicka>
 <2024052136-cubbyhole-ecologist-5b68@gregkh>
 <ZkzREEA5_N_xfqED@tiehlicka>
 <2024052110-grasp-liking-22c0@gregkh>
 <ZkzgZoxF_RD50PdW@tiehlicka>
 <2024052243-napping-coastal-3306@gregkh>
 <Zk790Afi1sfwgrZi@tiehlicka>
 <2024052309-scabby-favored-0973@gregkh>
 <ZlBnsEsr66mR-frf@tiehlicka>
 <2024052458-matrimony-making-b7f1@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024052458-matrimony-making-b7f1@gregkh>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 24-05-24 13:47:00, Greg KH wrote:
> On Fri, May 24, 2024 at 12:10:56PM +0200, Michal Hocko wrote:
> > On Thu 23-05-24 15:49:59, Greg KH wrote:
> > > On Thu, May 23, 2024 at 10:26:56AM +0200, Michal Hocko wrote:
> > > > On Wed 22-05-24 05:57:38, Greg KH wrote:
> > [...]
> > > Because of asking, many others are starting to help out, you can too,
> > > just submit patches against the cve/review/proposed/ directory with a
> > > list of commits that you feel should have CVEs assigned for, or annotate
> > > why you feel specific ones we have reviewed should NOT have a CVE
> > > assigned, and our tools can handle them quite well as part of the
> > > assignment process (see scripts/cve_review for a tool that some of us
> > > use to create these files, that's not required, as not all of us use it,
> > > but the output format is the key, and that's a simple list of commit
> > > ids, personally I generate that from mboxes.)
> > 
> > Do I get it right that proposals shouldn't be sent via email to
> > cve@kernel.org as suggested by the in tree documentation?
> 
> The documentation should say that you _SHOULD_ send proposals to
> cve@kernel.org, did we get it wrong somehow?
> 
> > I do not mind
> > the specific workflow but until now I have followed Documentation/process/cve.rst
> > as authoritative source of the process. It would be really great if that
> > matched the workflow.
> 
> I'm confused as to what in that document is incorrect, care to point it
> out?

Maybe I've just misunderstood the part about sending patches against
cve/review/proposed/. I was thinking about sending pull requests against
vulns.git.
 
> > > > If you really want to build a trust around the CVE process then make it
> > > > more transparent. I would start by adding reason why something has been
> > > > marked CVE. You are saying there is peer review process going on then
> > > > why not add Reviewed-by: to make it explicit and visible.
> > > 
> > > We have that, see the git log of the cve/review/ directory for the files
> > > and where most all of the cves come from.  Some come directly from
> > > requests by others to us, and a few other places (i.e. security
> > > reports), so we of course can't document the source of everything for
> > > obvious reasons.
> > 
> > Thanks for pointing me there but I do not think this is what I've had in
> > mind. I do understand that there is some pattern matching happening to
> > select most of the candidates, but as you've said this is then reviewed
> > and during that review you likely need to read through that changelog
> > and build some sort of statement why this is considered a security
> > threat.
> 
> Right now for the 3 people doing all of the reviews, 1 is using pattern
> matching of a sort (see the cve_review tool for the big regex and
> workflow used there), one is reading each patch/header in mbox format,
> and one is using some other tool.  Then for the ones that we disagree on
> (i.e. not a score of 2 out of 3), we comment as to why we feel they
> should, or should not, be accepted.

Thanks for the clarification.

> As this process is evolving, we
> haven't really documented it, except here and in talks with others as we
> travel.  We're working on making that more public over time.
> 
> Note, I do not know of any other CNA that does this in public as much as
> we are already, we are pushing the boundry of what CNAs are doing pretty
> hard here by putting almost all of our reviews in public _before_ a CVE
> is assigned.  That's not normal, and hopefully we don't get told to stop
> that (sshhh, don't tell anyone...)

I really like and appreciate this part! That is a huge improvement
comparing to the previous process.

> > I believe exactly _this_ would be a much more valuable information in
> > the CVE announcement than a copy&past of the changelog which on its own
> > can be trially referenced by a link. Also if there is a peer review
> > happening then Reviewed-by would be really nice. Not to mention
> > Reported-by if this was externally reported (the report could be a part
> > of the announcement as well).
> 
> We can't do a "Reported-by:" for CVEs as we aren't allowed to add
> personal information like that to the records as per cve.org's rules.

OK, understood. Although I do remember CVEs crediting parties
discovering/reporting the issue.

> And people want to word-smith the text all the time already, so we just
> default to using the changelog text as that's the most "neutral" and
> public information out there (i.e. we don't have to worry about any sort
> of data-retention or classification laws as the information is already
> public in kernel changelog text.)

This part I do not understand. What is wrong about a reasoning why
something has been considered a CVE? E.g. something like 
CVE assigned because a potential WARN_ON is fixed and that could panic
with panic_on_warn. Fixed by <URL_TO_LINUS_TREE>

or
CVE assigned because UAF is fixed and those can be generally used to
construct more complex attacks. Fixed by <URL_TO_LINUS_TREE>

etc.
-- 
Michal Hocko
SUSE Labs

