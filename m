Return-Path: <linux-kernel+bounces-537968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C97A49300
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C32E18954ED
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB7C1E1A20;
	Fri, 28 Feb 2025 08:09:13 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC8F1D63CF
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730153; cv=none; b=hP4wRImHaMKBZocW/rmTY27YfJWYukZOkjG+oG0JhsKzqPIkoJXYIqV5X5CfVWmb+ASe5Bvm59k2Wgysr28y/OXccYADoVlwNriUAtq8WFqMIMj5iwhIPCI9olKZem2GTgGb6cHt4cOjB4sYEQ3wxak7wvXyNLPig8KHoNXnrw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730153; c=relaxed/simple;
	bh=pSwabahylI74AyvP/BXgAZ0fXYQsoMYkzYBJZeU0ix4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSvovtfQJWevL/HE5WHWcxaF2LbPkU5D6/N1iay+nGWZjpxSCa/477lQh0hQnNHxU2X+ctyXOlwvn1/ph3VVy20zHXi8WQFTjA1vrEF10mZQ6qE3onVXP2dVXqizn3Qgj1/9J7qiuj08ISFTqXow4KgUujf7ejIyvIG3g4noYSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 908862116F;
	Fri, 28 Feb 2025 08:09:09 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7470E13888;
	Fri, 28 Feb 2025 08:09:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1zUiHCVvwWcDMwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 28 Feb 2025 08:09:09 +0000
Date: Fri, 28 Feb 2025 09:09:04 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] nvmet-fcloop: track ref counts for nports
Message-ID: <0f8504e1-c890-41b2-9cfb-2b45cd92e6ad@flourine.local>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
 <20250226-nvmet-fcloop-v1-4-c0bd83d43e6a@kernel.org>
 <d4b09a75-30f8-4db7-a02b-25ae405f7340@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4b09a75-30f8-4db7-a02b-25ae405f7340@suse.de>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 908862116F
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

On Fri, Feb 28, 2025 at 08:19:19AM +0100, Hannes Reinecke wrote:
> >   static void
> >   fcloop_targetport_delete(struct nvmet_fc_target_port *targetport)
> >   {
> > -	struct fcloop_tport *tport = targetport->private;
> > -
> > -	flush_work(&tport->ls_work);
> > -	fcloop_nport_put(tport->nport);
> >   }
> Errm. Isn't this function empty now? Can't it be remove altogether?

Sure, I'll get rid of it.

> >   	nport = fcloop_alloc_nport(buf, count, false);
> >   	if (!nport)
> >   		return -EIO;
> > @@ -1475,6 +1491,9 @@ fcloop_create_target_port(struct device *dev, struct device_attribute *attr,
> >   		return ret;
> >   	}
> > +	/* nport ref get: targetport */
> > +	fcloop_nport_get(nport);
> > +
> 
> I would rather move it to the end of the function, after we set all the
> references. But that's probably personal style...

I don't mind, During debugging I started to move the get/put function
where the pointers are updated, to highlight why we do the get/put. But
that was still pretty hard to find the leaks. Eventually I added some
debugging patches which annotated the call. The left over of these debug
patches are the 'nport ref get: transport' comments (*). Now that I am
confident that all is in balance, there is no reason not to make the
code more streamlined.

(*) Would something like this here be a no go? It really helps when
trying to debug the inbalance:

+static void __nvmet_fc_tgtport_put(struct nvmet_fc_tgtport *tgtport);
+static int __nvmet_fc_tgtport_get(struct nvmet_fc_tgtport *tgtport);
+
+#if 1
+#define nvmet_fc_tgtport_put(p)						\
+({									\
+	pr_info("nvmet_fc_tgtport_put: %px %d %s:%d\n",			\
+		p, atomic_read(&p->ref.refcount.refs),			\
+		__func__, __LINE__);					\
+	__nvmet_fc_tgtport_put(p);					\
+})
+
+#define nvmet_fc_tgtport_get(p)						\
+({									\
+	int ___r = __nvmet_fc_tgtport_get(p);				\
+									\
+	pr_info("nvmet_fc_tgtport_get: %px %d %s:%d\n",			\
+		p, atomic_read(&p->ref.refcount.refs),			\
+		__func__, __LINE__);					\
+	___r;								\
+})
+#else
+#define nvmet_fc_tgtport_put(p) __nvmet_fc_tgtport_put(p)
+#define nvmet_fc_tgtport_get(p) __nvmet_fc_tgtport_get(p)
+#endif

