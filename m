Return-Path: <linux-kernel+bounces-185197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9988CB1E8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 18:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CA7C1C22069
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EE12233A;
	Tue, 21 May 2024 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hlWyJHcd";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hlWyJHcd"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E13A1CD13;
	Tue, 21 May 2024 16:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716307517; cv=none; b=PFsrHJHoYNvVtA3diu8AU/81TMWwbgCCeDVA35H2VwsaPx40duiMu9Rh4skd1khV/2oR3Z5wxzlB8Vk5UjmR/ctdrt3KP8CaEVxA+qA6bm2bB8O85lEUbF3292AubrmTzeSOXrTvYe+MHJvQzYP1Q4tVLfrvFKjTAFHVyk5rAjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716307517; c=relaxed/simple;
	bh=N7gDzwrxS3u32IRNatT6UTzz15/lI/SVlb6Xi9bZwPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzhY1QnBLCRyFV5X8tlDhItlcUXPW3JxfrvvewKjBgESMKsOonc7TtSIv0C7lHN1SyQjNohnaI1czijEaG6bbsrfDuYP8jSSLHV7ByvvHSf2frR4zIozTjDyW8cpUkFsE+yGOlRD57H+p+ZIg5ilBD/lvI2l97iw2TEPU8SaYvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hlWyJHcd; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hlWyJHcd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8EBA75BDBC;
	Tue, 21 May 2024 16:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716307513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ju4HNRiaOvRrYI7sR7Tczm4YBlqCQdYlg/CzuEceDBI=;
	b=hlWyJHcdQ3/8wmaYYDDHuX2FB9ta379fxwid5iToThDQ2ggLqDNUCmkA4vVrekbRS+PLc5
	Dd9n/kYjc4WBI50qRKDd/FtJMs9/Sr6b9mn/R8ud6xYMZ6i05Ha+uht2vQMSkdXrwTtCDc
	eHgWzQGG4lUwsLwP5scU/vAILMcEvX0=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=hlWyJHcd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716307513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ju4HNRiaOvRrYI7sR7Tczm4YBlqCQdYlg/CzuEceDBI=;
	b=hlWyJHcdQ3/8wmaYYDDHuX2FB9ta379fxwid5iToThDQ2ggLqDNUCmkA4vVrekbRS+PLc5
	Dd9n/kYjc4WBI50qRKDd/FtJMs9/Sr6b9mn/R8ud6xYMZ6i05Ha+uht2vQMSkdXrwTtCDc
	eHgWzQGG4lUwsLwP5scU/vAILMcEvX0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A8BD13A1E;
	Tue, 21 May 2024 16:05:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 14nxGjnGTGYTPwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 21 May 2024 16:05:13 +0000
Date: Tue, 21 May 2024 18:05:03 +0200
From: Michal Hocko <mhocko@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-27429: netrom: Fix a data-race around
 sysctl_netrom_obsolescence_count_initialiser
Message-ID: <ZkzGL_vXciG7ipm5@tiehlicka>
References: <2024051722-CVE-2024-27429-878c@gregkh>
 <ZkxdqOUek_MHqIMn@tiehlicka>
 <2024052105-pulsate-reborn-119a@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024052105-pulsate-reborn-119a@gregkh>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8EBA75BDBC
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Tue 21-05-24 16:40:24, Greg KH wrote:
> On Tue, May 21, 2024 at 10:39:04AM +0200, Michal Hocko wrote:
> > This and couple of others are all having the same pattern. Adding
> > READ_ONCE for an integer value with a claim that this might race with
> > sysctl updates. While the claim about the race is correct I fail to see
> > how this could have any security consequences. Even if a partial write
> > was observed which sounds _more_ than theoretical these all are merely
> > timeouts and delays.
> > 
> > Is there anything I am missing?
> 
> Nope, you are right, our fault, I'll go revoke this now.

please also revoke all others touching the same function.

-- 
Michal Hocko
SUSE Labs

