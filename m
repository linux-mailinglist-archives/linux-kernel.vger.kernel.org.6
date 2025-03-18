Return-Path: <linux-kernel+bounces-566238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9769BA6755C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7716E188769C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BAC20D4E8;
	Tue, 18 Mar 2025 13:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ti6+d0Se";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7hZKMF50";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OdSyO4nq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VmZL08TL"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA6320C02F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742305142; cv=none; b=QcamjCnqyXgVX2viEYLlNoo+VUj6Vea5RFeY2poc95PfCmN0UidS9SKt2ygg5CmNkxxdXXWiVdj9r9soNfo6OiRL0okoB4nCneX/rOKiRV7DNbx75M2XP2+gU6BIU3fFKBjE4HZHWS5UEz1+UHx9svrdgwgsUnjAERHXxoozGfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742305142; c=relaxed/simple;
	bh=tMihzWxOQTSbrWP6tFZDL4SGRmTqKIs0GfmuNafNo4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fo2EH7TSWoS1eRPKQ1BD1USsED0E3rYvQUMYHYPeqIoj00PprhNqD6kcykT6nDtxSOp7S3/i8Qg8RPzjQA6hYxG4hJTcJEkEUVzIC1Gf9J7/wTarBSMSmt+XBIP7L+QSk9IAzFqD8dSqXnS8TsnK9t6GsopM189U/mnqx1D4kvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ti6+d0Se; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7hZKMF50; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OdSyO4nq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VmZL08TL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6078721C8A;
	Tue, 18 Mar 2025 13:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742305138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gibNWB+WbdBuAKKlNMqlggV5EjTaStrFi2d7OCuqByI=;
	b=ti6+d0SeW7BhmFkgW7r23+8+arYvvQLNuMn2yAaZT9tEB/cDjjDjnjOJvnxeNMWQ8Bh4JK
	m3Zdpe+9YvemIYxdUwVFzgSLzX7XwX5a1tWrhK+rWND+oNw5+u2UEHci6FdIHM83EffluB
	lcjbQvZpzGHX3LffXc6XW6X+jmJ3P18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742305138;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gibNWB+WbdBuAKKlNMqlggV5EjTaStrFi2d7OCuqByI=;
	b=7hZKMF50XG8wveUdt+w2kmkMK9l75Irx0QJEAJnQt4rF8sDCwgXzg2ETjF5QLpPimUGHJq
	JF7l60AXbutZ0eCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742305137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gibNWB+WbdBuAKKlNMqlggV5EjTaStrFi2d7OCuqByI=;
	b=OdSyO4nqpjnojlVp+PHoADAXfRquM7StiM1yjO/6zCRc3BqoIm+i/V5oL/itaL4mAaBwDe
	wiWxbK9K15AEK9XmMyvpK1vHU9Hy9ZjeBVYffFPOhyf5lxoee4MusZLpdbi1BUDjKSBmJ8
	uKSRL8lSe94Dxq4aMbitXq8RLWt55BM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742305137;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gibNWB+WbdBuAKKlNMqlggV5EjTaStrFi2d7OCuqByI=;
	b=VmZL08TLpu1OmzYSdIdd0l3lqVESCJ+hKvfCTeSEeCS+pBeJYlyo6vLAbpsY38PpvD5rBZ
	d5/znPsz/0qvHWCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 50EAB139D2;
	Tue, 18 Mar 2025 13:38:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7x7BEnF32Wd/dAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 18 Mar 2025 13:38:57 +0000
Date: Tue, 18 Mar 2025 14:38:56 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/18] nvmet-fcloop: refactor fcloop_nport_alloc
Message-ID: <66261f08-5386-4b22-aa6f-7be1d4023fee@flourine.local>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
 <20250318-nvmet-fcloop-v3-4-05fec0fc02f6@kernel.org>
 <a9055e3c-d36f-4706-9fdc-f4532d14adb6@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9055e3c-d36f-4706-9fdc-f4532d14adb6@suse.de>
X-Spam-Score: -8.30
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,flourine.local:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Mar 18, 2025 at 12:02:48PM +0100, Hannes Reinecke wrote:
> > -	list_for_each_entry(tmplport, &fcloop_lports, lport_list) {
> > -		if (tmplport->localport->node_name == opts->wwnn &&
> > -		    tmplport->localport->port_name == opts->wwpn)
> > -			goto out_invalid_opts;
> > +		INIT_LIST_HEAD(&nport->nport_list);
> > +		nport->node_name = opts->wwnn;
> > +		nport->port_name = opts->wwpn;
> > +		refcount_set(&nport->ref, 1);
> > -		if (tmplport->localport->node_name == opts->lpwwnn &&
> > -		    tmplport->localport->port_name == opts->lpwwpn)
> > -			lport = tmplport;
> > +		spin_lock_irqsave(&fcloop_lock, flags);
> > +		list_add_tail(&nport->nport_list, &fcloop_nports);
> > +		spin_unlock_irqrestore(&fcloop_lock, flags);
> >   	}
> Hmm. I don't really like this pattern; there is a race condition
> between lookup and allocation leading to possibly duplicate entries
> on the list.

Yes, that's not a good thing.

> Lookup and allocation really need to be under the same lock.

This means the new entry has always to be allocated first and then we
either free it again or insert into the list, because it's not possible
to allocate under the spinlock. Not that beautiful but correctness wins.

