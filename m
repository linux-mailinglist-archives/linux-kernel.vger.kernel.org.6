Return-Path: <linux-kernel+bounces-184660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F848CAA28
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 10:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1B6F1F224C1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 08:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A211D5579F;
	Tue, 21 May 2024 08:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Gv8JLnIj";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Gv8JLnIj"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501AA57304;
	Tue, 21 May 2024 08:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716280752; cv=none; b=VkSyLQRJJIE1QAC2RtiYWW94VDe4BONfpDUttcpNDqTqGYGJTbi4ia7MB00R3jGHbE5DREZiqzKA61tfoViWqjHwuCtvAOUpuWMc3fjNOZS3Kw4P0kMl7TQ46coOVUvVxoRFKaFKLEttYCN1XKgzuzbUecDuC8IT6PO95TTMLHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716280752; c=relaxed/simple;
	bh=eiYFVgVJRQ84uNBtAhrJ8Hb9qIRn6K+6kOEDfaD7+XA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQr0PeYYb78k8tIjTKIUCm9iwX+Rz9mujbGmT5VuYK0T9wPNCIGBWT0oLPqAukZmi5ZbpDKHXmGvOyedb+Y1KvFKa62cpoMKuOPDC/BtytkoaekI+jIYkKcWfKn9+6eSj56c8WcsS1snGa7CavbOoEEysYQJz13QRrQKsvATnak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Gv8JLnIj; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Gv8JLnIj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3EDBA226DE;
	Tue, 21 May 2024 08:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716280749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uNlQEhWKDPg0mUNeqAgN+HxsnxA2bnJ/Aa0B6OagB3I=;
	b=Gv8JLnIjLCStSU7zPwjXV9SJZ/DSPc6FIEmwnx29COXNG88FHsmOh6eOcN0GsYPhI6Bdpe
	fms+zq9KPTY61X39q5biyZgrjdOnoJm1VZUFUv5NoCwEwvlV0zxvlqgelZqs27Sfq8WC53
	CHEpUR9IFlzJWQ7e3xxvMSGANqdrbFY=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Gv8JLnIj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716280749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uNlQEhWKDPg0mUNeqAgN+HxsnxA2bnJ/Aa0B6OagB3I=;
	b=Gv8JLnIjLCStSU7zPwjXV9SJZ/DSPc6FIEmwnx29COXNG88FHsmOh6eOcN0GsYPhI6Bdpe
	fms+zq9KPTY61X39q5biyZgrjdOnoJm1VZUFUv5NoCwEwvlV0zxvlqgelZqs27Sfq8WC53
	CHEpUR9IFlzJWQ7e3xxvMSGANqdrbFY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2670313A1E;
	Tue, 21 May 2024 08:39:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ovq2Bq1dTGYXPQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 21 May 2024 08:39:09 +0000
Date: Tue, 21 May 2024 10:39:04 +0200
From: Michal Hocko <mhocko@suse.com>
To: cve@kernel.org, linux-kernel@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Cc: linux-cve-announce@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2024-27429: netrom: Fix a data-race around
 sysctl_netrom_obsolescence_count_initialiser
Message-ID: <ZkxdqOUek_MHqIMn@tiehlicka>
References: <2024051722-CVE-2024-27429-878c@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024051722-CVE-2024-27429-878c@gregkh>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3EDBA226DE
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.01

This and couple of others are all having the same pattern. Adding
READ_ONCE for an integer value with a claim that this might race with
sysctl updates. While the claim about the race is correct I fail to see
how this could have any security consequences. Even if a partial write
was observed which sounds _more_ than theoretical these all are merely
timeouts and delays.

Is there anything I am missing?

On Fri 17-05-24 14:02:29, Greg KH wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> netrom: Fix a data-race around sysctl_netrom_obsolescence_count_initialiser
> 
> We need to protect the reader reading the sysctl value
> because the value can be changed concurrently.
> 
> The Linux kernel CVE team has assigned CVE-2024-27429 to this issue.
> 
> 
> Affected and fixed versions
> ===========================
> 
> 	Issue introduced in 2.6.12 with commit 1da177e4c3f4 and fixed in 4.19.310 with commit e3a3718b1723
> 	Issue introduced in 2.6.12 with commit 1da177e4c3f4 and fixed in 5.4.272 with commit 1e84b108f2a7
> 	Issue introduced in 2.6.12 with commit 1da177e4c3f4 and fixed in 5.10.213 with commit 18c95d11c347
> 	Issue introduced in 2.6.12 with commit 1da177e4c3f4 and fixed in 5.15.152 with commit b3f0bc3a315c
> 	Issue introduced in 2.6.12 with commit 1da177e4c3f4 and fixed in 6.1.82 with commit e439607291c0
> 	Issue introduced in 2.6.12 with commit 1da177e4c3f4 and fixed in 6.6.22 with commit 7e1e25891f09
> 	Issue introduced in 2.6.12 with commit 1da177e4c3f4 and fixed in 6.7.10 with commit 591192c3a9fc
> 	Issue introduced in 2.6.12 with commit 1da177e4c3f4 and fixed in 6.8 with commit cfd9f4a740f7
> 
> Please see https://www.kernel.org for a full list of currently supported
> kernel versions by the kernel community.
> 
> Unaffected versions might change over time as fixes are backported to
> older supported kernel versions.  The official CVE entry at
> 	https://cve.org/CVERecord/?id=CVE-2024-27429
> will be updated if fixes are backported, please check that for the most
> up to date information about this issue.
> 
> 
> Affected files
> ==============
> 
> The file(s) affected by this issue are:
> 	net/netrom/nr_route.c
> 
> 
> Mitigation
> ==========
> 
> The Linux kernel CVE team recommends that you update to the latest
> stable kernel version for this, and many other bugfixes.  Individual
> changes are never tested alone, but rather are part of a larger kernel
> release.  Cherry-picking individual commits is not recommended or
> supported by the Linux kernel community at all.  If however, updating to
> the latest release is impossible, the individual changes to resolve this
> issue can be found at these commits:
> 	https://git.kernel.org/stable/c/e3a3718b1723253d4f068e88e81d880d71f1a1e9
> 	https://git.kernel.org/stable/c/1e84b108f2a71daa8d04032e4d2096522376debb
> 	https://git.kernel.org/stable/c/18c95d11c347a12e5c31df1325cef6b995d14ecf
> 	https://git.kernel.org/stable/c/b3f0bc3a315cf1af03673a0163c08fe037587acd
> 	https://git.kernel.org/stable/c/e439607291c082332e1e35baf8faf8552e6bcb4a
> 	https://git.kernel.org/stable/c/7e1e25891f090e24a871451c9403abac63cb45dd
> 	https://git.kernel.org/stable/c/591192c3a9fc728a0af7b9dd50bf121220062293
> 	https://git.kernel.org/stable/c/cfd9f4a740f772298308b2e6070d2c744fb5cf79

-- 
Michal Hocko
SUSE Labs

