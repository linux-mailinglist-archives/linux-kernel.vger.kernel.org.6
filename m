Return-Path: <linux-kernel+bounces-188605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8CF8CE443
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA4A2825D8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8BF84FDC;
	Fri, 24 May 2024 10:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="awZau41h";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cW+Nr8dK"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10B06EB4A;
	Fri, 24 May 2024 10:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716546810; cv=none; b=cKhBUJ2r7NY/8WGKn6H8orY2HLh6ejv44eBEMZ76YIEIHtNmlnx6LiKERhtlRdfLXerDn8wfN3Rbsw9RDAH/TCTw2rrV/ObJLKPOUnObMWeyxU3kpPG02QFVYeRopcwfFcIkkeWp9q2gixVfUuYZ+UiTc7T/Z/V5q0dADuQ7oCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716546810; c=relaxed/simple;
	bh=VoDeTw5LAOr0YrYdBecD70KKdNMdESDhUlj9kHa+JNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGo/kEwXKVMUFPPU3aeXz0dt8g9QV2c8KbBQRP65kIXhjBoz9EYRDLRh2Dlg7FXnMCCndo0w27HIlRJ26VwE8QKxq3JARu611/bRVDDzOP0EUvRltsPLIfQY3fxmXf92v+Q4z7+82MgJAi0HRzSxWSAwRyqwHVMgxcgGFh7666w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=awZau41h; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cW+Nr8dK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C56DE20380;
	Fri, 24 May 2024 10:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716546807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jBUJs+clTevIxUQQTuz4esHassTfo+4toG/IdUx2C8E=;
	b=awZau41hTpcQY8GF4jlIkpQoA8+Br+7wHFwF7Z0OQmQJTWy2oThd1ymhFfrL8InvnwzFmi
	aU6GT+ju3vwud3qolgq4HLOHveertpLpYHtVzFu2DAZptCpZUr1q/0aJgwOdIwARxxzFzy
	rwDPvLJCBbpHmiyKuh2NOi/eWavo/CA=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=cW+Nr8dK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716546806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jBUJs+clTevIxUQQTuz4esHassTfo+4toG/IdUx2C8E=;
	b=cW+Nr8dK7O099S2uOc/mARXPYJxA5iBAxMIB1j84X2Kswi5IEqmil77TY+AyVZlSjoWZzH
	w9leto9sfXvDQNSTmtTLpV+Nrv2QiJhs4++ArYMuYAaL12mGVywyNyQpy7hMDpXmnh0SF3
	pMy/q3g6+vUENqRnQFdT8TRkEuCJV/Y=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5C6013A82;
	Fri, 24 May 2024 10:33:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 99SiJvZsUGb7DQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Fri, 24 May 2024 10:33:26 +0000
Date: Fri, 24 May 2024 12:33:22 +0200
From: Michal Hocko <mhocko@suse.com>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: linux-cve-announce@vger.kernel.org, Lee Jones <lee@kernel.org>
Subject: Re: CVE-2024-26650: platform/x86: p2sb: Allow p2sb_bar() calls
 during PCI device probe
Message-ID: <ZlBs8u8M5US5aAro@tiehlicka>
References: <20240326175007.1388794-18-lee@kernel.org>
 <Zkz2qpUP-HVROO1I@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zkz2qpUP-HVROO1I@tiehlicka>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C56DE20380
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim]

On Tue 21-05-24 21:31:54, Michal Hocko wrote:
> This patch has been reverted in upstream by 03c6284df179 ("Revert
> "drm/amd/amdgpu: Fix potential ioremap() memory leaks in
> amdgpu_device_init()"") and based on the changelog the CVE should be
> rejected.

Wait a second. I've screwed up here. I am sorry, my bad. This revert has
nothing to do with CVE-2024-26650 - 5913320eb0b3 ("platform/x86: p2sb:
Allow p2sb_bar() calls during PCI device probe"). I guess I got
completely confused by the fact that the same change exists under a
different commit b28ff7a7c324 ("platform/x86: p2sb: Allow p2sb_bar()
calls during PCI device probe").

I must have mixed this with CVE-2024-35928 somehow. zhengzucheng has
already pointed to that one. Sorry about that!

-- 
Michal Hocko
SUSE Labs

