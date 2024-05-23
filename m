Return-Path: <linux-kernel+bounces-187181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FC68CCE2C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C20828126C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCA613CABE;
	Thu, 23 May 2024 08:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tptmEJHz";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tptmEJHz"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F400751016;
	Thu, 23 May 2024 08:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716452820; cv=none; b=QcRc4BwACxo6DX2JqPA9LYEoTrMcPu7Zu3HWfIaVQugeh9jpy0xNGhjyqc9V15RSV/Wb6B3cmqvuOMA98qyJt7DiM4Ui+9IzjIwtA51h7dl+SINRtjc3fMFrrTP/ZcjlrsWyGai7Sw32VMMVgYAf6NVe5qRbSlDy+kqLbPQc7bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716452820; c=relaxed/simple;
	bh=VhB+yYvGxyujM6LANiWsS9TSSh5BC2CXd2CWptZ2K4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uy6gEZApBYEGAr4wn7JxJpV98IkgViqXjgZpSb7BnPKrB3HBOeBowWg+3iPKnZUUQcsvo/xXbQJ1YjG12/AsBgllbUMbldr1LsDyhZ9mEW6x9fX6UTLuGt/A+WAOa6m8yP8OO1COHipb/O7/KQoi19ODIaVM6nWUKlQiqy13Xzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tptmEJHz; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tptmEJHz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2357022382;
	Thu, 23 May 2024 08:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716452817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mBH6EPW7Vz1SRmvs2kbmV+ndU39ouWoBblqvWLNfICg=;
	b=tptmEJHz9zEALDU9iRoFlsmKqRlatBwzIs3fowOQPnQqAuj/nF88zIl+RmXxUghaYPC0FX
	8g6u80bSY8M71vfU8N7KUVKHfyiFe/hVH79GJUkVsppWbDbnpwfEemm6r1faKqeXGJC1Gz
	T/PWsWFKCqXuNYlzvc6LR0UTHCSWFec=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=tptmEJHz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716452817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mBH6EPW7Vz1SRmvs2kbmV+ndU39ouWoBblqvWLNfICg=;
	b=tptmEJHz9zEALDU9iRoFlsmKqRlatBwzIs3fowOQPnQqAuj/nF88zIl+RmXxUghaYPC0FX
	8g6u80bSY8M71vfU8N7KUVKHfyiFe/hVH79GJUkVsppWbDbnpwfEemm6r1faKqeXGJC1Gz
	T/PWsWFKCqXuNYlzvc6LR0UTHCSWFec=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 093C413A6B;
	Thu, 23 May 2024 08:26:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2CnXOtD9TmbNZgAAD6G6ig
	(envelope-from <mhocko@suse.com>); Thu, 23 May 2024 08:26:56 +0000
Date: Thu, 23 May 2024 10:26:56 +0200
From: Michal Hocko <mhocko@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-35906: drm/amd/display: Send DTBCLK disable message on
 first commit
Message-ID: <Zk790Afi1sfwgrZi@tiehlicka>
References: <2024051954-CVE-2024-35906-1c6f@gregkh>
 <ZkxbObACcnUMZ3LA@tiehlicka>
 <2024052136-cubbyhole-ecologist-5b68@gregkh>
 <ZkzREEA5_N_xfqED@tiehlicka>
 <2024052110-grasp-liking-22c0@gregkh>
 <ZkzgZoxF_RD50PdW@tiehlicka>
 <2024052243-napping-coastal-3306@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024052243-napping-coastal-3306@gregkh>
X-Spam-Level: 
X-Spamd-Result: default: False [-6.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2357022382
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -6.01

On Wed 22-05-24 05:57:38, Greg KH wrote:
[...]
> > I completely do get why you do not care about that downstream
> > engineering cost but generating bogus CVEs on top of a huge pile of
> > dubious ones is less than useful, don't you think?
> 
> How is this a "bogus" CVE on their own?

I suspect you haven't looked at those commits. This is a boot time
suboptimal HW configuration. There is no way any user can exploit that I
can see. Not to mention it cases system boot hangs!

[...]
> > Seriously, we can disagree whether something is a security threat that
> > is worth marking by a CVE. But making the CVE generation process mostly
> > unattended script driven process without any _serious_ review in place
> > is burning a lot of man power that could be used in a much more
> > productive way. This is not the way how to convince people to use stable
> > kernels.
> 
> To think that any of this is an "unattended script without any _serious_
> review" is slandering all of the people who put in their free time to do
> this work for you and the community.  This is ANYTHING BUT an unattended
> script.

This is a perception one can easily draw by watching the stream of
incoming flow. Sorry if that is not the case but there is about zero
transparency about the process except for Documentation/process/cve.rst
and let me quote
"
As part of the normal stable release process, kernel changes that are
potentially security issues are identified by the developers responsible
for CVE number assignments and have CVE numbers automatically assigned
to them.
"

There is no mention about criteria, review process. Who is involve in
the assignment and who is doing the review. The vulns.git tree doesn't
contain Sign-off-by of those involved parties except for the submitter.

> Also, this is work ostensibly that you are also already doing for your
> day-job, right?

We, like stable trees, rely on Fixes tag and those (including other
commits that might be this tag) are reviewed by domain experts.

[...]

> I appreciate your reviews so far of "hey, this shouldn't really be a
> CVE, right?"  That's a lot of help and is making things better, but to
> insinuate that somehow we don't know what the hell we are doing, or that
> we are doing nothing other than a simple "assign everything!" process
> here is extremely insulting to me and to the other developers here
> working on this.

I am sorry if you feel that way but I haven't said anything like that.

I have raised a concern based on observed CVE flow that the current
process is automated without a proper review as I can see very dubious
CVEs being assigned (splats resembling oops/warnings coming from lockdep,
data_race fixes as they resemble race condition fixes, READ_ONCE fixes
which do not fix anything discussed in other thread and others).

I have tried to dispute quite some but quickly learned that many of them
have been dismissed because "no usecases are assumed". It is a very
broad category that could indeed make any fix a CVE.

If you really want to build a trust around the CVE process then make it
more transparent. I would start by adding reason why something has been
marked CVE. You are saying there is peer review process going on then
why not add Reviewed-by: to make it explicit and visible.

Thanks!

-- 
Michal Hocko
SUSE Labs

