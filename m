Return-Path: <linux-kernel+bounces-548635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91651A5474F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC48E1682F6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE9D1F5837;
	Thu,  6 Mar 2025 10:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ap9xXNtu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t7xhbWFY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ap9xXNtu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t7xhbWFY"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDBD7E9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741255571; cv=none; b=SVpS1uBgJP3GneCNokTAO0xE1AhkwZW52Rqb8MG7KO89COH/2v3uS8pzJLxxA8B5XffXi5V2PpGKueiE/8Gro8hre/P8lnuIN9EyvIG9Cilq4XwNUOIZe60iA4j1ot9F8jH0PQ0ka0vIK88FzPxdcfvqkJdHViy4M4zUsGOz/Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741255571; c=relaxed/simple;
	bh=8uwMk9eSw4+RYYUHHE2kXRw73rPJMGHwqh0fMuQwsaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfDt68x5VDrpJpzSQWwE4gqlpGbSrmbFPYZu3U/n+8tI/j3EV2iiG6AwBs6h/zkZnfLFFMc3Fl4xyrG9dYOZbpYdnF3/2hUyMjgnYDgaL+EzVnl7mK8y8IGSJ9xJ32Iv/swEL1y7wt+NW+jJiJq9goXWqW3PvSMYAeFJaypOGdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ap9xXNtu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t7xhbWFY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ap9xXNtu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t7xhbWFY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B3196211AD;
	Thu,  6 Mar 2025 10:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741255567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8uwMk9eSw4+RYYUHHE2kXRw73rPJMGHwqh0fMuQwsaI=;
	b=Ap9xXNtuRcm/s44PvuG5kMeaQNAwIgN09BgSPKd0OGbauxWuZbC4xUxCCiuPlv4ag47rKD
	4jk20a1jgmhPv+BYCm9usk5u6LKbEAtfvQ4nReYOC6EvZrTV6einSvrWS3Jwd2Whja40vq
	4xCvMp5gWXqGLIjLi0EtqIqVDpNe/cI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741255567;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8uwMk9eSw4+RYYUHHE2kXRw73rPJMGHwqh0fMuQwsaI=;
	b=t7xhbWFYi6/K9zuDgmmKrcZKPQcLd7HfmzwNNyO7J3FKO24Mrpw7sgZuudrIc7PiWTJlS0
	Jt0BX/hG7uDKWZDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ap9xXNtu;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=t7xhbWFY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741255567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8uwMk9eSw4+RYYUHHE2kXRw73rPJMGHwqh0fMuQwsaI=;
	b=Ap9xXNtuRcm/s44PvuG5kMeaQNAwIgN09BgSPKd0OGbauxWuZbC4xUxCCiuPlv4ag47rKD
	4jk20a1jgmhPv+BYCm9usk5u6LKbEAtfvQ4nReYOC6EvZrTV6einSvrWS3Jwd2Whja40vq
	4xCvMp5gWXqGLIjLi0EtqIqVDpNe/cI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741255567;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8uwMk9eSw4+RYYUHHE2kXRw73rPJMGHwqh0fMuQwsaI=;
	b=t7xhbWFYi6/K9zuDgmmKrcZKPQcLd7HfmzwNNyO7J3FKO24Mrpw7sgZuudrIc7PiWTJlS0
	Jt0BX/hG7uDKWZDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3D8813676;
	Thu,  6 Mar 2025 10:06:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 384EJ49zyWfnIwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 06 Mar 2025 10:06:07 +0000
Date: Thu, 6 Mar 2025 11:06:03 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: James Smart <james.smart@broadcom.com>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] nvmet-fcloop: add ref counting to lport
Message-ID: <bc38d0fc-0e3e-4196-b698-1528dc57421e@flourine.local>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
 <20250226-nvmet-fcloop-v1-2-c0bd83d43e6a@kernel.org>
 <20250305141740.GC18065@lst.de>
 <0efdf3e7-e49e-4e2f-846b-b072169de318@flourine.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0efdf3e7-e49e-4e2f-846b-b072169de318@flourine.local>
X-Rspamd-Queue-Id: B3196211AD
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Mar 06, 2025 at 10:26:40AM +0100, Daniel Wagner wrote:
> There is nothing which updates the ctrl in nvme_fc_unregister_localport.
> Not really sure what to do here. fcloop obviously is now behaving
> differently to the hw drivers. But still, this looks very fragile that
> there is no sort of synchronization between port unregistration and ctrl
> state.

Ah I see what's supposed to happen in this scenario.
nvme_fc_unregister_localport will return -EINVAL when the port is still
in use. That means fcloop is not allowed to pull the rug yet.

