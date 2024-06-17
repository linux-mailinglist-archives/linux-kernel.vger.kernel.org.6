Return-Path: <linux-kernel+bounces-217239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8DA90AD3C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7C23B24D11
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3CA194C82;
	Mon, 17 Jun 2024 11:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kJ5UC2Wz";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kJ5UC2Wz"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD4261FCA;
	Mon, 17 Jun 2024 11:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718624487; cv=none; b=EjLYzfgVPhmjGtbXRhV4HzRca/qHW2TCZNvv1LeZHMuYzp40GFzKzeNmuC6A12Rko5CzkoKcUsrDmAqeMl4qytw8bb4W+maIUdB7v6ywwAKV+PB4DkSioNB/0a9iWc5j+cl3RWAgEM7mK8OQDh833lQ9PEbC6UX0lScYavcmUpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718624487; c=relaxed/simple;
	bh=8gMWpRMuBWJTqZQtOEgAZjSy7QQURjs6LMsM2cNGbF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnxCrHbNvEhbBZuA7ump5GgxcvmbOd54vfa1fa5/6LmPhafs0jC7E8OWu+Mzgupg19GByB0QEK3XBCG6kATG98cr7n6kWqEWbrdoH/inYnvXV2jxBwrM7vX3+fOdIFZvQ7dp946ZW8yk0T3gJGx/tmsixL4FBQ4G5QjSPDdB8Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kJ5UC2Wz; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kJ5UC2Wz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 820E15FFC7;
	Mon, 17 Jun 2024 11:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718624483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pPiVO78Gkmq1Xd+cyo5MdAjHvVBtpiyXAvp/Q09wzvM=;
	b=kJ5UC2WzMyJ2VPl6aaL8TMnDqka+5JvPqSF7W227/r4OVII0ko6Crr0OaOIvjymfvGT+Rm
	vL3e6r+spSbSzqo5OonqIsk4B04ZQznW9SZPV+4JQGYVqV1eAbt4HhTQT2QgAS1q8hH3IM
	vAWCIOcT7Egq7PhRTG5kWjnrWm64mek=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718624483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pPiVO78Gkmq1Xd+cyo5MdAjHvVBtpiyXAvp/Q09wzvM=;
	b=kJ5UC2WzMyJ2VPl6aaL8TMnDqka+5JvPqSF7W227/r4OVII0ko6Crr0OaOIvjymfvGT+Rm
	vL3e6r+spSbSzqo5OonqIsk4B04ZQznW9SZPV+4JQGYVqV1eAbt4HhTQT2QgAS1q8hH3IM
	vAWCIOcT7Egq7PhRTG5kWjnrWm64mek=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69661139AB;
	Mon, 17 Jun 2024 11:41:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id To28FuMgcGbhIAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Mon, 17 Jun 2024 11:41:23 +0000
Date: Mon, 17 Jun 2024 13:41:22 +0200
From: Michal Hocko <mhocko@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-35840: mptcp: use OPTION_MPTCP_MPJ_SYNACK in
 subflow_finish_connect()
Message-ID: <ZnAg4ndsrYCuqN6j@tiehlicka>
References: <2024051756-CVE-2024-35840-99fa@gregkh>
 <ZmFtaijTs6mOpB5B@tiehlicka>
 <ZnAdxYLsEwDrF31j@tiehlicka>
 <2024061743-aversion-uncured-d770@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024061743-aversion-uncured-d770@gregkh>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
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
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Mon 17-06-24 13:31:13, Greg KH wrote:
> On Mon, Jun 17, 2024 at 01:28:05PM +0200, Michal Hocko wrote:
> > On Thu 06-06-24 10:03:59, Michal Hocko wrote:
> > > Hi,
> > > what is the actual security threat here? As far as I can see, the
> > > problem that the commit requested here addresses seems to be rather
> > > functional, rather than responding to an unexpected packet options with
> > > a reset, we actually establish a connection with some garbage parameters
> > > (likely unpredictable). Which is unfortunate but I do not see any
> > > security implications.
> > 
> > Does the silence mean that there are no actual security implications
> > here?
> 
> Sorry, no, I was traveling and am still trying to catch up with the
> pending queue.  Should get to it later today or tomorrow, sorry for the
> delay.

Thanks!

-- 
Michal Hocko
SUSE Labs

