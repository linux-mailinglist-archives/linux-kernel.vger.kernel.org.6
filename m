Return-Path: <linux-kernel+bounces-217215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E5190ACEC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0C601C2100F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA59194A7E;
	Mon, 17 Jun 2024 11:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="W8Fvm97T";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="W8Fvm97T"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EC5194158;
	Mon, 17 Jun 2024 11:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718623696; cv=none; b=A1RUwJUA+twLDkYqxzf1jxDjhDMlDDYcD41fonAsMzgW+ovh9FNZPd6hyOoCLec7DBDl7IYLOhe6nOI8NzRU2qZOGXaRqE8LN1txsBl3yM8qm5h5HE7wps6O7Ucr10yOliGkXQnNNz7XvhxGfR63n/5drtRYIkiEa9FWymzQGAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718623696; c=relaxed/simple;
	bh=rZtwfZcAcbhNNbZEwXAxnoSf+Xv255V7gujoHtNJcWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jh0bbDbfSkpMfgGZ042Z8TRgiForXoCQX+3GkxVan766zS9U7Rec/m9jpEoP8y4EnozgvbWg3YXbzwAwBld70trJO6hzovIH7NidoX4SCR5kwn/WAL1AVs5K37X9WPjfKKXMO+WPezufLjd23k0WBtbndvjT2IAnvPuwyLbyMl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=W8Fvm97T; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=W8Fvm97T; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5C164380D6;
	Mon, 17 Jun 2024 11:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718623691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Yeijq2vbhF/Nh3y0N533Ledk3xH/c5yeo/BXp9/K9o=;
	b=W8Fvm97TTDC6l3bkw57tZhol1FXXu+BS3KiRc7xQgzk5F2Yj8vZSFJy48U/m2qP7ozTi70
	2bskO3WCK8OWZY4rV+MmzsXpsmqS2AmzGEF9Qo3NN0t0l3qqIE1IqxzyEa/z5Euyex9KUk
	ivw+8mYTgbxuQcLbScfcSyivBwg+R4g=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718623691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Yeijq2vbhF/Nh3y0N533Ledk3xH/c5yeo/BXp9/K9o=;
	b=W8Fvm97TTDC6l3bkw57tZhol1FXXu+BS3KiRc7xQgzk5F2Yj8vZSFJy48U/m2qP7ozTi70
	2bskO3WCK8OWZY4rV+MmzsXpsmqS2AmzGEF9Qo3NN0t0l3qqIE1IqxzyEa/z5Euyex9KUk
	ivw+8mYTgbxuQcLbScfcSyivBwg+R4g=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2559C13AAA;
	Mon, 17 Jun 2024 11:28:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uQEqAMsdcGZ8HAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Mon, 17 Jun 2024 11:28:11 +0000
Date: Mon, 17 Jun 2024 13:28:05 +0200
From: Michal Hocko <mhocko@suse.com>
To: cve@kernel.org, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>
Cc: linux-cve-announce@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2024-35840: mptcp: use OPTION_MPTCP_MPJ_SYNACK in
 subflow_finish_connect()
Message-ID: <ZnAdxYLsEwDrF31j@tiehlicka>
References: <2024051756-CVE-2024-35840-99fa@gregkh>
 <ZmFtaijTs6mOpB5B@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmFtaijTs6mOpB5B@tiehlicka>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[5]

On Thu 06-06-24 10:03:59, Michal Hocko wrote:
> Hi,
> what is the actual security threat here? As far as I can see, the
> problem that the commit requested here addresses seems to be rather
> functional, rather than responding to an unexpected packet options with
> a reset, we actually establish a connection with some garbage parameters
> (likely unpredictable). Which is unfortunate but I do not see any
> security implications.

Does the silence mean that there are no actual security implications
here?

> On Fri 17-05-24 16:27:13, Greg KH wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > mptcp: use OPTION_MPTCP_MPJ_SYNACK in subflow_finish_connect()
> > 
> > subflow_finish_connect() uses four fields (backup, join_id, thmac, none)
> > that may contain garbage unless OPTION_MPTCP_MPJ_SYNACK has been set
> > in mptcp_parse_option()
> > 
> > The Linux kernel CVE team has assigned CVE-2024-35840 to this issue.
> > 
> > 
> > Affected and fixed versions
> > ===========================
> > 
> > 	Issue introduced in 5.7 with commit f296234c98a8 and fixed in 5.15.148 with commit 413b91350732
> > 	Issue introduced in 5.7 with commit f296234c98a8 and fixed in 6.1.75 with commit 51e4cb032d49
> > 	Issue introduced in 5.7 with commit f296234c98a8 and fixed in 6.6.14 with commit ad3e8f5c3d5c
> > 	Issue introduced in 5.7 with commit f296234c98a8 and fixed in 6.7.2 with commit 76e8de7273a2
> > 	Issue introduced in 5.7 with commit f296234c98a8 and fixed in 6.8 with commit be1d9d9d38da
> > 
> > Please see https://www.kernel.org for a full list of currently supported
> > kernel versions by the kernel community.
> > 
> > Unaffected versions might change over time as fixes are backported to
> > older supported kernel versions.  The official CVE entry at
> > 	https://cve.org/CVERecord/?id=CVE-2024-35840
> > will be updated if fixes are backported, please check that for the most
> > up to date information about this issue.
> > 
> > 
> > Affected files
> > ==============
> > 
> > The file(s) affected by this issue are:
> > 	net/mptcp/subflow.c
> > 
> > 
> > Mitigation
> > ==========
> > 
> > The Linux kernel CVE team recommends that you update to the latest
> > stable kernel version for this, and many other bugfixes.  Individual
> > changes are never tested alone, but rather are part of a larger kernel
> > release.  Cherry-picking individual commits is not recommended or
> > supported by the Linux kernel community at all.  If however, updating to
> > the latest release is impossible, the individual changes to resolve this
> > issue can be found at these commits:
> > 	https://git.kernel.org/stable/c/413b913507326972135d2977975dbff8b7f2c453
> > 	https://git.kernel.org/stable/c/51e4cb032d49ce094605f27e45eabebc0408893c
> > 	https://git.kernel.org/stable/c/ad3e8f5c3d5c53841046ef7a947c04ad45a20721
> > 	https://git.kernel.org/stable/c/76e8de7273a22a00d27e9b8b7d4d043d6433416a
> > 	https://git.kernel.org/stable/c/be1d9d9d38da922bd4beeec5b6dd821ff5a1dfeb
> 
> -- 
> Michal Hocko
> SUSE Labs

-- 
Michal Hocko
SUSE Labs

