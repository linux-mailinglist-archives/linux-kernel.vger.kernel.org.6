Return-Path: <linux-kernel+bounces-188645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFA68CE4DA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 13:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2AC028169E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 11:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31D184FDB;
	Fri, 24 May 2024 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YierkngI";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YierkngI"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E0E84FB1;
	Fri, 24 May 2024 11:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716550048; cv=none; b=LP9IqH2w3L9kHPTtlryziRKw1fAfk9saDh/O5BgSQT9RiKb6nDNlGNak0xtMSLKi241wafFGOFAikQE/lLPNZF9fuROcoC3O/+KMggPCBPJP5nlW4XYwQrcgO+g/tQfghuukOEDKrheV5p1CaxtI8/AQ6K94c99m72Dn6DUClfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716550048; c=relaxed/simple;
	bh=lWIcExuNIvSZE9aJBZpRjiblaXxJSviHY/f+mr0RxW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lp50eooHpYzWDjyESUX0x/oM8kEDrrcGom3QWeKRmHP7dIriujFTbi1pZ7y9g9SCmLOVpc2BDKCG0mo1h67wlMFE1gS6KiQui2Fj7LBzxz1isp0tEbmd1LgBqkqAxLH68v9xfkeTsgZxDFX94hbnafcIxDdGh8xQPC/amkXojOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YierkngI; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YierkngI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5ECB320982;
	Fri, 24 May 2024 11:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716550044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4WLWgVOfLhXHFK0AX9hIsRSzqQqW6MtlpTAPDJhTPOU=;
	b=YierkngITLivRB8ICZHBOnZmEVE2CAdTqe0ax7WvpT4PYwIo624XgcYVWefW++2bvLkAJ5
	nei5skVPwfU2I2gTpn2eW1Qa/04XsnHJzVhCb3FS9/Q5VNmPAGe3klzB1E4MOBE/kG1Akz
	SYzehHb3XE5RO9v8H5Q4MnU3R8x0cBY=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=YierkngI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716550044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4WLWgVOfLhXHFK0AX9hIsRSzqQqW6MtlpTAPDJhTPOU=;
	b=YierkngITLivRB8ICZHBOnZmEVE2CAdTqe0ax7WvpT4PYwIo624XgcYVWefW++2bvLkAJ5
	nei5skVPwfU2I2gTpn2eW1Qa/04XsnHJzVhCb3FS9/Q5VNmPAGe3klzB1E4MOBE/kG1Akz
	SYzehHb3XE5RO9v8H5Q4MnU3R8x0cBY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 449B613A3D;
	Fri, 24 May 2024 11:27:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rqnADZx5UGbtCwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Fri, 24 May 2024 11:27:24 +0000
Date: Fri, 24 May 2024 13:27:19 +0200
From: Michal Hocko <mhocko@suse.com>
To: Davide Benini <davide.benini@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, cve@kernel.org,
	linux-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-27429: netrom: Fix a data-race around
 sysctl_netrom_obsolescence_count_initialiser
Message-ID: <ZlB5l40ahqW8PGlC@tiehlicka>
References: <2024051722-CVE-2024-27429-878c@gregkh>
 <ZkxdqOUek_MHqIMn@tiehlicka>
 <2024052105-pulsate-reborn-119a@gregkh>
 <ZkzGL_vXciG7ipm5@tiehlicka>
 <2024052219-storewide-arrogance-8d54@gregkh>
 <5f3cccea-eff5-40f7-a868-743ca837e84d@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f3cccea-eff5-40f7-a868-743ca837e84d@suse.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5ECB320982
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -5.01

On Wed 22-05-24 12:21:54, Davide Benini wrote:
> On 22/05/24 07:11, Greg Kroah-Hartman wrote:
> > On Tue, May 21, 2024 at 06:05:03PM +0200, Michal Hocko wrote:
> > > On Tue 21-05-24 16:40:24, Greg KH wrote:
> > > > On Tue, May 21, 2024 at 10:39:04AM +0200, Michal Hocko wrote:
> > > > > This and couple of others are all having the same pattern. Adding
> > > > > READ_ONCE for an integer value with a claim that this might race with
> > > > > sysctl updates. While the claim about the race is correct I fail to see
> > > > > how this could have any security consequences. Even if a partial write
> > > > > was observed which sounds _more_ than theoretical these all are merely
> > > > > timeouts and delays.
> > > > > 
> > > > > Is there anything I am missing?
> > > > 
> > > > Nope, you are right, our fault, I'll go revoke this now.
> > > 
> > > please also revoke all others touching the same function.
> > 
> > I don't see any other CVEs that reference that function, but I do see
> > some that reference the same type of issue in the same file:
> > 	CVE-2024-27420
> > 	CVE-2024-27421
> > 	CVE-2024-27430
> > are those what you are referring to?  If not, which ones do you think
> > also should be revoked?
> 
> It seems all the CVEs in the range [CVE-2024-27420, CVE-2024-27430] are of the same kind.
> Shouldn't all be revoked?

Yes all these
bc76645ebdd0 ("netrom: Fix a data-race around sysctl_netrom_link_fails_count")
b5dffcb8f71b ("netrom: Fix a data-race around sysctl_netrom_routing_control")
f99b494b4043 ("netrom: Fix a data-race around sysctl_netrom_transport_no_activity_timeout")
a2e706841488 ("netrom: Fix a data-race around sysctl_netrom_transport_requested_window_size")
43547d869943 ("netrom: Fix a data-race around sysctl_netrom_transport_busy_delay")
806f462ba902 ("netrom: Fix a data-race around sysctl_netrom_transport_acknowledge_delay")
e799299aafed ("netrom: Fix a data-race around sysctl_netrom_transport_maximum_tries")
60a7a152abd4 ("netrom: Fix a data-race around sysctl_netrom_transport_timeout")
119cae5ea3f9 ("netrom: Fix data-races around sysctl_netrom_network_ttl_initialiser")
cfd9f4a740f7 ("netrom: Fix a data-race around sysctl_netrom_obsolescence_count_initialiser")
958d6145a6d9 ("netrom: Fix a data-race around sysctl_netrom_default_path_quality")

-- 
Michal Hocko
SUSE Labs

