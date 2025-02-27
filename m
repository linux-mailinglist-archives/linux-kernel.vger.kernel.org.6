Return-Path: <linux-kernel+bounces-536872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4ECA4853D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 416A418966C3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895FA1B4F3D;
	Thu, 27 Feb 2025 16:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m6Ehxif8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wlToCjRy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m6Ehxif8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wlToCjRy"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CF91DF247
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673814; cv=none; b=eNbYEh55l8NNxbkKqLyaEj1lPJTxQ8KDObRjfJa01qsAeYhRHz7a50mWKzMSxAesxIH8QnZbU1ywiaj5idYLXh2CkRvROo5mjsIs0I1fLcYP2aDHy6EzBm7uNAFVIHZjEsWXYjvs2AkRDyOFexy8pucEqpoSyXWb2ysnX6F05NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673814; c=relaxed/simple;
	bh=s9VL24yfUGSmBHVZyY7XnuK7LaK2fviPocWCSqyvQOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRlXPGfhgM0uLipHOM0dyQRyH5CQazvKDuCZeUx6nc7r3y5fXYa59Oi9I7B2u7sYeiRRmVWXnPxUc2cIKNSd0gZMVaTxZIJbsp++q3Jmi63k3+B82eTelLz5sTiBtH467t9V9RbEnJZaAjfabLoidx1RZBb/8dEqF1d3SSU/sd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m6Ehxif8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wlToCjRy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m6Ehxif8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wlToCjRy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 500BA21179;
	Thu, 27 Feb 2025 16:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740673811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sUR5yr5xrKYtwisJP33yULREbphDWSStzk3gHg4/86Y=;
	b=m6Ehxif86p9b9oNITYwyp1MjXjGLoPJ0mdop+VruoWE7WXUsGzOliFi7YOzJI9lMuPWDu7
	+VD4dH9+DzGdTDm/tWdfi68rTbHXrGugQAlfR16C6sB4Oq8/gFop+zgatzZwdbEkbmKbbr
	sYB2KTarMfwQgXfXXlvJcc0NnPeURdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740673811;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sUR5yr5xrKYtwisJP33yULREbphDWSStzk3gHg4/86Y=;
	b=wlToCjRyUSxIxbMMlobgiLETK7yjwIRVXWR/naJbibjZy2XSKTmP8ePo/N5HpwXfr3vAUh
	RlhPg4PJ6++NcVDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=m6Ehxif8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wlToCjRy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740673811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sUR5yr5xrKYtwisJP33yULREbphDWSStzk3gHg4/86Y=;
	b=m6Ehxif86p9b9oNITYwyp1MjXjGLoPJ0mdop+VruoWE7WXUsGzOliFi7YOzJI9lMuPWDu7
	+VD4dH9+DzGdTDm/tWdfi68rTbHXrGugQAlfR16C6sB4Oq8/gFop+zgatzZwdbEkbmKbbr
	sYB2KTarMfwQgXfXXlvJcc0NnPeURdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740673811;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sUR5yr5xrKYtwisJP33yULREbphDWSStzk3gHg4/86Y=;
	b=wlToCjRyUSxIxbMMlobgiLETK7yjwIRVXWR/naJbibjZy2XSKTmP8ePo/N5HpwXfr3vAUh
	RlhPg4PJ6++NcVDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F7D41376A;
	Thu, 27 Feb 2025 16:30:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +HQ6DxOTwGceIgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 27 Feb 2025 16:30:11 +0000
Date: Thu, 27 Feb 2025 17:30:10 +0100
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] nvmet-fcloop: track resources via reference
 counting
Message-ID: <25fbe7c0-3602-41e8-b216-fec19568830b@flourine.local>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
X-Rspamd-Queue-Id: 500BA21179
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Wed, Feb 26, 2025 at 07:45:52PM +0100, Daniel Wagner wrote:
> static void nvmet_port_subsys_drop_link(struct config_item *parent,
> 		struct config_item *target)
> {
> 	[...]
> found:
> 	list_del(&p->entry);
> 	nvmet_port_del_ctrls(port, subsys);
> 	nvmet_port_disc_changed(port, subsys);   /* XXX triggers the above UAF */
> 
> 	if (list_empty(&port->subsystems))
> 		nvmet_disable_port(port);
> 	up_write(&nvmet_config_sem);
> 	kfree(p);
> }
> 
> The nvmet_port_disc_changed is a bit useless, because these event will
> never be seen by the host. Anyway, more debugging is necessary.

The problem is there is no ref counting for pe->tgtport. And in
nvmet_port_disc_changed needs to take a ref on hostport. I am doing some
more testing and it looks promising. Hopefully this is one of those
famous lost words.

