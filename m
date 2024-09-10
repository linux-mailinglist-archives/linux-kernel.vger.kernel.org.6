Return-Path: <linux-kernel+bounces-323016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F18069736A6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21C371C24C1D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C23F19068E;
	Tue, 10 Sep 2024 11:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SBZuaV+T";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vgMsKVm0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FQ1LfOjF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lQZ672wM"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4E019007F
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 11:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725969573; cv=none; b=QHiLYH3LuP33RB/uM9X9eqO0A1tDnusyF7qx+KK5avBmbRYdE86ZoufmrNOshaUVGQ0ID3txRrvbRKFlPNI2kbpAhMOe8l2OxH3jXvFp19anKgYYI29ZK7smhKiIcHA56mTtRJxVQ9TKYtKw2WnxmtrES0/vyQ22xvlaFxz6rNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725969573; c=relaxed/simple;
	bh=IgtQEyWjK5jYGN9qgOqdkd8v/T1Rh+9fewAkZXXetTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQceUFn0/+qpt5Gd5jrG1vUkld3ohy+UJkq7v1pDcjXsJ+XKQRcNDo4vlLV3hXIPFUK8yc/5WCKkFuJvgzJUd7NZ9RMnUGHGgQH6zoUaB+WjWrtSHCDT7Pv4tLuWwhth+RdDVpg4rBZRnXPR3G+os/1zpL9eBMW8MYcjdPNfzao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SBZuaV+T; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vgMsKVm0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FQ1LfOjF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lQZ672wM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E77671FCDB;
	Tue, 10 Sep 2024 11:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725969570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sNdePKyjGq3+O+HZZ9zNfnNaBcll3lXBgM1kKQ2oDSQ=;
	b=SBZuaV+TWT+QD2XJvxfYD5Pz+u6kTUWTkwYmphD8RbTsRLHlWI9lkjn6P4EspxdGhtb6Vj
	se4JX4ISHKB9K7acQlldfYFH1YVBEDEZKmEtwEuGY2aG50R4EslgbIrbtlTVu2e35vFutb
	kANffGtT3Z+GMRGSY0RXzSj/oUVCCPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725969570;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sNdePKyjGq3+O+HZZ9zNfnNaBcll3lXBgM1kKQ2oDSQ=;
	b=vgMsKVm0Vp6B1FR8FGA7InSDJ4yGFTBaAku5pfBMsQPU69ukklSAjLyXK2cSFUWfMFsoYA
	t6p/WhWUdS+JOXCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FQ1LfOjF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lQZ672wM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725969568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sNdePKyjGq3+O+HZZ9zNfnNaBcll3lXBgM1kKQ2oDSQ=;
	b=FQ1LfOjF4/hKzqDnsiVWyKpgpDw90sxVtF2o+LwI2ou+9q7r/ma7+9Ajg6/Fu6y0l3d/QU
	4CsIIDnQorpkwNUssy+npFKHkhYzVU6zCs4k8kMBMUVQzEyfWJdKN5+H4DLpsohx8C+hED
	aQT3wzxzM/uYCbqIGHWzj8YGPs4heqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725969568;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sNdePKyjGq3+O+HZZ9zNfnNaBcll3lXBgM1kKQ2oDSQ=;
	b=lQZ672wM5XimcchHmciPfRDLiulDDJDYtWLowZR6RuBMBCMCsAU3esMcgP0NE4F58tPh/v
	DBD87ucBtCMBvxAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA7BA132CB;
	Tue, 10 Sep 2024 11:59:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dVoQMKA04GZBfgAAD6G6ig
	(envelope-from <iivanov@suse.de>); Tue, 10 Sep 2024 11:59:28 +0000
Date: Tue, 10 Sep 2024 15:05:10 +0300
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Corey Minyard <corey@minyard.net>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi:ssif: Improve detecting during probing
Message-ID: <20240910120510.62h76nzr7lu7qdvn@localhost.localdomain>
References: <20240816065458.117986-1-iivanov@suse.de>
 <ZsU9SRlQgzQn8bDs@mail.minyard.net>
 <20240910102531.grjtn2rdmagcgphb@localhost.localdomain>
 <CAB9gMfqnpu9hpS8U=umGFV6k+KSoG+Luw80KL10_Qdqo3mLU8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB9gMfqnpu9hpS8U=umGFV6k+KSoG+Luw80KL10_Qdqo3mLU8g@mail.gmail.com>
X-Rspamd-Queue-Id: E77671FCDB
X-Spam-Score: -6.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,minyard.net:email,suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 09-10 06:30, Corey Minyard wrote:
> > >
> > > If an IPMI SSIF device is probed and there is something there, but
> > > probably not an actual BMC, the code would just issue a lot of errors
> > > before it failed.  We kind of need these errors to help with certain
> > > issues, and some of the failure reports are non-fatal.
> > >
> > > However, a get device id command should alway work.  If that fails,
> > > nothing else is going to work and it's a pretty good indication that
> > > there's no valid BMC there.  So issue and check that command and bail
> > > if it fails.
> > >
> > > Reported-by: Ivan T. Ivanov <iivanov@suse.de>
> > > Signed-off-by: Corey Minyard <corey@minyard.net>
> > > ---
> > >  drivers/char/ipmi/ipmi_ssif.c | 24 +++++++++++++++++++++++-
> > >  1 file changed, 23 insertions(+), 1 deletion(-)
> >
> > Do you plan to merge this fix?
> 
> Yes, it's queued for the next release window.  I should have responded
> with that.
> 

Thank you! No worries.

Regards,
Ivan


