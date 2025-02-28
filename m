Return-Path: <linux-kernel+bounces-538012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB43EA49388
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2EF618942B6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC222512E3;
	Fri, 28 Feb 2025 08:30:48 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641F91DE2DC
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731448; cv=none; b=tAAq4aNR3tx6ZzhajDcWnQUHDP5AUdY/4RVDNYA+1DELEz1R5g0vNbdMI4mLx7+1uyj44gsf+CyFWtx1EIeRab92asC+XPelxykjjrcrMXwqoM3AB+ebPOm5s5XApPRhY/AcmqmYjfpf8B0eMbH5Y35pJYCPU0qCis+pwDGUS/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731448; c=relaxed/simple;
	bh=n1/l2QLf/n1N3RwfKsgNoQ4M9Ans7HtHSgv7DlYmLaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glaMbD7PVYBK8dCaweiHhL0wPy3t1984k5R+h0NJ1oyEQo8OqwckuWQrcjOcwMmWHBGSvOWv36svX6PD1a6GP1EywfF0WdJY/JSL6GCCBdyP/WOsc4T/8Og++e5wr0YrNqx1l4B8Z5dsBjrX7bmtZmLkZHYsEvHi1I58UERAwX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 912D321174;
	Fri, 28 Feb 2025 08:30:42 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F01913888;
	Fri, 28 Feb 2025 08:30:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BQ1PHjJ0wWeXOgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 28 Feb 2025 08:30:42 +0000
Date: Fri, 28 Feb 2025 09:30:38 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] nvmet-fcloop: track tport with ref counting
Message-ID: <adb0bdc1-f4be-4004-8651-7f8393276f46@flourine.local>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
 <20250226-nvmet-fcloop-v1-5-c0bd83d43e6a@kernel.org>
 <ceb7e531-cc0b-4a4a-a97d-c578daf9d5b2@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ceb7e531-cc0b-4a4a-a97d-c578daf9d5b2@suse.de>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 912D321174
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

On Fri, Feb 28, 2025 at 08:27:40AM +0100, Hannes Reinecke wrote:
> On 2/26/25 19:45, Daniel Wagner wrote:
> > The tport object is created via nvmet_fc_register_targetport and freed
> > via nvmet_fc_unregister_targetport. That means after the port is
> > unregistered nothing should use it. Thus ensure with refcounting
> > that there is no user left before the unregister step.
> > 
> > Signed-off-by: Daniel Wagner <wagi@kernel.org>
> > ---
> >   drivers/nvme/target/fcloop.c | 52 +++++++++++++++++++++++++++++---------------
> >   1 file changed, 35 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> > index 80693705c069dd114b2d4f15d0482dd2d713a273..2269b4d20af2ef9bb423617b94a5f5326ea124bd 100644
> > --- a/drivers/nvme/target/fcloop.c
> > +++ b/drivers/nvme/target/fcloop.c
> > @@ -233,8 +233,12 @@ struct fcloop_tport {
> >   	spinlock_t			lock;
> >   	struct list_head		ls_list;
> >   	struct work_struct		ls_work;
> > +	struct kref			ref;
> >   };
> > +static int fcloop_tport_get(struct fcloop_tport *tport);
> > +static void fcloop_tport_put(struct fcloop_tport *tport);
> > +
> >   struct fcloop_nport {
> >   	struct fcloop_rport *rport;
> >   	struct fcloop_tport *tport;
> > @@ -426,6 +430,7 @@ fcloop_tport_lsrqst_work(struct work_struct *work)
> >   		spin_lock(&tport->lock);
> >   	}
> >   	spin_unlock(&tport->lock);
> > +	fcloop_tport_put(tport);
> >   }
> >   static int
> > @@ -444,12 +449,16 @@ fcloop_t2h_ls_req(struct nvmet_fc_target_port *targetport, void *hosthandle,
> >   	tls_req->lsreq = lsreq;
> >   	INIT_LIST_HEAD(&tls_req->ls_list);
> > +	if (!tport)
> > +		return -ECONNABORTED;
> > +
> >   	if (!tport->remoteport) {
> >   		tls_req->status = -ECONNREFUSED;
> >   		spin_lock(&tport->lock);
> >   		list_add_tail(&tls_req->ls_list, &tport->ls_list);
> >   		spin_unlock(&tport->lock);
> > -		queue_work(nvmet_wq, &tport->ls_work);
> > +		if (queue_work(nvmet_wq, &tport->ls_work))
> > +			fcloop_tport_get(tport);
> 
> Don't you need to remove the 'tls_req' from the list, too, seeing that
> it'll never be transferred?

Good point. I'll add the error handling.

> > @@ -1576,8 +1597,7 @@ fcloop_delete_target_port(struct device *dev, struct device_attribute *attr,
> >   	if (!nport)
> >   		return -ENOENT;
> > -	ret = __targetport_unreg(nport, tport);
> > -
> > +	fcloop_tport_put(tport);
> >   	fcloop_nport_put(nport);
> Hmm. Are we sure that the 'tport' reference is always > 1 here? Otherwise
> we'll end up with a funny business when the tport is deleted
> yet the nport still has a reference ..

Yes, I am very sure about this. This doesn't mean it needs to stay like
this. The goal here is to avoid changing the existing structure of the
code and only annotate the life time of the different objects with ref
counters, so we get rid of the implicit 'rules' when it's safe to
access a pointer and when not.

Anyway, I really don't mind getting this sorted out eventually, but
please not in this series.

