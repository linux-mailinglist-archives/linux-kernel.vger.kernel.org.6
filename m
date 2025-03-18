Return-Path: <linux-kernel+bounces-566268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 018A7A675B1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81AB41888A44
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BC520D50F;
	Tue, 18 Mar 2025 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qXI9QbUP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yQzwZE6/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qXI9QbUP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yQzwZE6/"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B4B20468F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306152; cv=none; b=m/LlH3CGxpD9ipfl6Mm2kp2yIh2VGIwUKYS4JQ3VzOBZpn5IbSg5ZNevKEqAKqFG5KGJwkZD8YuNPjlZmw5hBJ8yjLkM0mSZGPLsV9AjTRadivDNWKPupjJxUgNvkaxa8pTwJ5jK/h+HldU8FHHhkrrn9HMMWwOoFtaec/Oi09U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306152; c=relaxed/simple;
	bh=XvW5AhmOIyebiQSdlNHiE7cLWdX3Ge3S8iYcvuw++ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzYhNAg4ixw9QJ8zdGOy3ZYgXZVi5/UD6iZhOm4lvX4w/idwh3A1h4OClOO0CX14ASvUNCP2CYz2/BugvusTNmdbaVb1ChVXAWLTN+btQT0cawrcqOsMhABcaqzCUxT7GCNfJTp00uFarN05YK9KvlgsJI8jsqGHDHWpgClVvgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qXI9QbUP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yQzwZE6/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qXI9QbUP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yQzwZE6/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2B0AC21F11;
	Tue, 18 Mar 2025 13:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742306149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HbbQJCb0W94lwPm3G3yIcFUzjFf7cmr8Xph5NtAbbg8=;
	b=qXI9QbUPZxiat7LCaEnc9mT83UzPp2cFJwTuOxQb4GmZ4i8Z3euU/M1wdpjACe0uJ8WBks
	hGqsbpRs+cxClHiuZAQ396EjEz0VndZlI0bKPpf/j98ArurLP3PBsTOiuTQWrrceJ0SLDm
	82gnR+aaTXiPBaQsuVGBgZHGKX1VUBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742306149;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HbbQJCb0W94lwPm3G3yIcFUzjFf7cmr8Xph5NtAbbg8=;
	b=yQzwZE6/Llf6ZXu+tPMdSK2leVliEhwnXC5m0xe8cDmhueyDXhIf4QObOJSAk5YPDBoUwM
	x4KhjspAK18Vd5DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742306149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HbbQJCb0W94lwPm3G3yIcFUzjFf7cmr8Xph5NtAbbg8=;
	b=qXI9QbUPZxiat7LCaEnc9mT83UzPp2cFJwTuOxQb4GmZ4i8Z3euU/M1wdpjACe0uJ8WBks
	hGqsbpRs+cxClHiuZAQ396EjEz0VndZlI0bKPpf/j98ArurLP3PBsTOiuTQWrrceJ0SLDm
	82gnR+aaTXiPBaQsuVGBgZHGKX1VUBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742306149;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HbbQJCb0W94lwPm3G3yIcFUzjFf7cmr8Xph5NtAbbg8=;
	b=yQzwZE6/Llf6ZXu+tPMdSK2leVliEhwnXC5m0xe8cDmhueyDXhIf4QObOJSAk5YPDBoUwM
	x4KhjspAK18Vd5DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C0DF13A43;
	Tue, 18 Mar 2025 13:55:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SR7nBWV72Wf5fAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 18 Mar 2025 13:55:49 +0000
Date: Tue, 18 Mar 2025 14:55:44 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/18] nvmet-fcloop: prevent double port deletion
Message-ID: <dbef52cf-a112-4fbd-b1ad-c9eebc1f4787@flourine.local>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
 <20250318-nvmet-fcloop-v3-9-05fec0fc02f6@kernel.org>
 <e5c91532-6f35-4124-b32d-a47aa4ce972b@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5c91532-6f35-4124-b32d-a47aa4ce972b@suse.de>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,flourine.local:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Tue, Mar 18, 2025 at 12:15:04PM +0100, Hannes Reinecke wrote:
> >   fcloop_remoteport_delete(struct nvme_fc_remote_port *remoteport)
> >   {
> >   	struct fcloop_rport *rport = remoteport->private;
> > +	bool delete_port = true;
> >   	unsigned long flags;
> >   	flush_work(&rport->ls_work);
> >   	spin_lock_irqsave(&fcloop_lock, flags);
> > +	if (test_and_set_bit(PORT_DELETE, &rport->flags))
> > +		delete_port = false;
> >   	rport->nport->rport = NULL;
> >   	spin_unlock_irqrestore(&fcloop_lock, flags);
> Can't you just check for a NULL rport->nport->rport pointer
> and do away with the PORT_DELETE flag?

Unfortunately, nport->rport is also set to NULL in __unlink_remote_port
and __unlink_target_port. If we would just update the pointer here, it
would be possible.

I played a bit around when to clear the nport->rport pointer but it
didn't work. There were always some UAFs or NULL pointer accesses. With
the flags I was able to get it fixed. I am not insisting on this
solution, just trying to explain why I choosed it.

