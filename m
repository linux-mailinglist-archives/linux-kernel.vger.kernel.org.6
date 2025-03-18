Return-Path: <linux-kernel+bounces-566252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF15DA6757B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0BD9881FDB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F005D20D515;
	Tue, 18 Mar 2025 13:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FyFKpzo4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1yjJhnj9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FyFKpzo4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1yjJhnj9"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B298020D512
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742305462; cv=none; b=qdchs5TQ6PeNZIOcfKqeTnuGRYVbko8d5WXTEgjvHnJBZCdDDLeScIoyaV7wQtD2GXl2STraayxxybGQlzLuJMd4idc6wCToH8KsCxFTIWy5O0MKULMTBEGDdUXID9Q9kwh31k8fO+9pZgLnGPXHGz51/r46K9jfki12C0KGG00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742305462; c=relaxed/simple;
	bh=PDhSugmhXBSZ52jALcMjafAWtjZhtL8gSIEEafLBw34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwhoECpm2mtFCFR0aI0elz3uxjmYOfAab2URbTGezUexKtuvlkMclhjPQQE8fQlyEbU9BgkQx3tA4vAqbiNnV1kF30lBvexhn1kGvXGKfnWBAEyHVaVDPEqAUkyTW8h/GWpqDlNxOmvhYq+1DmkQNJalaVtV3OWGTHg6yfbZHGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FyFKpzo4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1yjJhnj9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FyFKpzo4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1yjJhnj9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D8F1F1FCFA;
	Tue, 18 Mar 2025 13:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742305458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gx94z57EDJL61j391zhUGB+b5vNvyl4XRAtfqiFyack=;
	b=FyFKpzo4GGf6wQCABIkQuuGZpZyDQDQktEi9VMIb4YWf4XVWN2ttf1BMlE6eLz37aIpQPN
	PFlmEcBXPHxCmjauqUsRb/ju8IWpaGTemdf8kGND5rwkqc/GCj2GykruC8DBNYz9F1Qdu0
	QjQhPHwoNZBC51ZesDlqyn2VSD0lQyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742305458;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gx94z57EDJL61j391zhUGB+b5vNvyl4XRAtfqiFyack=;
	b=1yjJhnj9hdu2la0F3CqnOYZC3Vbes2WEIAHS/cgw5U4bKzP1ZL3n96kexnp2M28apuas/7
	PN073tFoCZQXDkCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742305458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gx94z57EDJL61j391zhUGB+b5vNvyl4XRAtfqiFyack=;
	b=FyFKpzo4GGf6wQCABIkQuuGZpZyDQDQktEi9VMIb4YWf4XVWN2ttf1BMlE6eLz37aIpQPN
	PFlmEcBXPHxCmjauqUsRb/ju8IWpaGTemdf8kGND5rwkqc/GCj2GykruC8DBNYz9F1Qdu0
	QjQhPHwoNZBC51ZesDlqyn2VSD0lQyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742305458;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gx94z57EDJL61j391zhUGB+b5vNvyl4XRAtfqiFyack=;
	b=1yjJhnj9hdu2la0F3CqnOYZC3Vbes2WEIAHS/cgw5U4bKzP1ZL3n96kexnp2M28apuas/7
	PN073tFoCZQXDkCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C99C2139D2;
	Tue, 18 Mar 2025 13:44:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KkalMLJ42WdydwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 18 Mar 2025 13:44:18 +0000
Date: Tue, 18 Mar 2025 14:44:18 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/18] nvmet-fcloop: track ref counts for nports
Message-ID: <030b7827-5060-44bc-b5ee-b1833063b835@flourine.local>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
 <20250318-nvmet-fcloop-v3-5-05fec0fc02f6@kernel.org>
 <181c5e4c-f25c-46aa-9be0-06e515f14543@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <181c5e4c-f25c-46aa-9be0-06e515f14543@suse.de>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,flourine.local:mid];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flourine.local:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Tue, Mar 18, 2025 at 12:06:54PM +0100, Hannes Reinecke wrote:
> On 3/18/25 11:39, Daniel Wagner wrote:
> > A nport object is always used in association with targerport,
> > remoteport, tport and rport objects. Add explicit references for any of
> > the associated object. This ensures that nport is not removed too early
> > on shutdown sequences.
> > 
> > Signed-off-by: Daniel Wagner <wagi@kernel.org>
> > ---
> >   drivers/nvme/target/fcloop.c | 106 +++++++++++++++++++++++++------------------
> >   1 file changed, 63 insertions(+), 43 deletions(-)
> > 
> > diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> > index 245bfe08d91ec81f1979251e8c757a0d46fd09e9..69121a5f0f280936d1b720e9e994d6e5eb9186ff 100644
> > --- a/drivers/nvme/target/fcloop.c
> > +++ b/drivers/nvme/target/fcloop.c
> > @@ -1054,8 +1054,15 @@ static void
> >   fcloop_remoteport_delete(struct nvme_fc_remote_port *remoteport)
> >   {
> >   	struct fcloop_rport *rport = remoteport->private;
> > +	unsigned long flags;
> >   	flush_work(&rport->ls_work);
> > +
> > +	spin_lock_irqsave(&fcloop_lock, flags);
> > +	rport->nport->rport = NULL;
> > +	spin_unlock_irqrestore(&fcloop_lock, flags);
> > +
> > +	/* nport ref put: rport */
> >   	fcloop_nport_put(rport->nport);
> >   }
> The comment is a bit odd; obviously fcloop_nport_put() puts the nport
> reference for the rport.
> Maybe just remove them?

Sure, I left in it, to figure out which of the get/put pair up. This was
not so clear during the various stages of this series. Now that there is
a rport->nport and tport->nport is left, it's indeed a bit useles.

