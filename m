Return-Path: <linux-kernel+bounces-188906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D05A8CE85D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 17:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04693B227D4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 15:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B620D12E1E0;
	Fri, 24 May 2024 15:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aTRAVVvU";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aTRAVVvU"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3187012E1C2;
	Fri, 24 May 2024 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716566383; cv=none; b=IpiXR8l2E2+4BCS29yojAAC6F45oJLZRC6J8OnI/AYMxO4IR2mhnJvHsmNwQDQlkbdKPBriLCBT0VGRM5dajD/mgJphs7QmLt4rXmO6X5PldZFIhyTJMOc0j2JyATOTEVtckT7SO6eKKwnHMftpemrAmj8voEhvAW9HsCoML2as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716566383; c=relaxed/simple;
	bh=hvuWDrU2Ip+Tob9l3Os8XGlHe9NBBPsRVFVcCUzZXnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMVGyr1pEgxvaUTTFgKHmovl0ctghbrVxDP67tUw6BvuQTsAfZZh0sVyZfRT8PheJXymfEcWeF7LeWXYyupFjMWWSZynQGzi+/k9KRMeXM0VHnDq1ECFxHlmWBiiD0puaFF6Q5I6N9aUTtCNg+Z/r1kmZkaGai4ONvrJQKg7TFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aTRAVVvU; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aTRAVVvU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 651BF33C04;
	Fri, 24 May 2024 15:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716566379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z6SrSJH80mBXMJosakFAut4dasqTK7qqiumc8g90Ihs=;
	b=aTRAVVvUmZx18Lzwk6UC//52FEjSbe7sWPHH5PKPvbxqEsVRHv8WneJuW/OP4Bh5VBaeGx
	6WnL2xZh9GhGj8kwKg+1MoJuvqXNlkmtvi8N0mYiknWc5IiutkMP0SRgVDb9qaNNXm3vwY
	UL/UrtevqurtW6Seql/idmeOGe/GRAw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716566379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z6SrSJH80mBXMJosakFAut4dasqTK7qqiumc8g90Ihs=;
	b=aTRAVVvUmZx18Lzwk6UC//52FEjSbe7sWPHH5PKPvbxqEsVRHv8WneJuW/OP4Bh5VBaeGx
	6WnL2xZh9GhGj8kwKg+1MoJuvqXNlkmtvi8N0mYiknWc5IiutkMP0SRgVDb9qaNNXm3vwY
	UL/UrtevqurtW6Seql/idmeOGe/GRAw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3FEE413A3D;
	Fri, 24 May 2024 15:59:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QW6WDGu5UGacJAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Fri, 24 May 2024 15:59:39 +0000
Date: Fri, 24 May 2024 17:59:34 +0200
From: Michal Hocko <mhocko@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-35906: drm/amd/display: Send DTBCLK disable message on
 first commit
Message-ID: <ZlC5ZooIRyVb9ITu@tiehlicka>
References: <ZkzREEA5_N_xfqED@tiehlicka>
 <2024052110-grasp-liking-22c0@gregkh>
 <ZkzgZoxF_RD50PdW@tiehlicka>
 <2024052243-napping-coastal-3306@gregkh>
 <Zk790Afi1sfwgrZi@tiehlicka>
 <2024052309-scabby-favored-0973@gregkh>
 <ZlBnsEsr66mR-frf@tiehlicka>
 <2024052458-matrimony-making-b7f1@gregkh>
 <ZlCd6kD4w2mezWBj@tiehlicka>
 <2024052453-afar-tartly-3721@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024052453-afar-tartly-3721@gregkh>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 24-05-24 17:22:24, Greg KH wrote:
[...]
> > > And people want to word-smith the text all the time already, so we just
> > > default to using the changelog text as that's the most "neutral" and
> > > public information out there (i.e. we don't have to worry about any sort
> > > of data-retention or classification laws as the information is already
> > > public in kernel changelog text.)
> > 
> > This part I do not understand. What is wrong about a reasoning why
> > something has been considered a CVE? E.g. something like 
> > CVE assigned because a potential WARN_ON is fixed and that could panic
> > with panic_on_warn. Fixed by <URL_TO_LINUS_TREE>
> > 
> > or
> > CVE assigned because UAF is fixed and those can be generally used to
> > construct more complex attacks. Fixed by <URL_TO_LINUS_TREE>
> > 
> > etc.
> 
> Doing the work to classify all of these in this manner isn't going to
> happen by us, sorry, as it is not required by the CVE process, and
> frankly, we are doing a load of work already here.

I would really like the understand this position. You are doing the
classification already, right? What does prevent you from making that a
part of the process? Why wouldn't you like to help CVE consumers to
understand that process better?
-- 
Michal Hocko
SUSE Labs

