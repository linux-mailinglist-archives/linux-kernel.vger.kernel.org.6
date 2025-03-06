Return-Path: <linux-kernel+bounces-548541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77733A54640
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC21E1895D4F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2207209681;
	Thu,  6 Mar 2025 09:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mjSVyQA6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8f8smvWg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mjSVyQA6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8f8smvWg"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F961A83ED
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253204; cv=none; b=Nb5MQ2ALI1IyvdmJVUvHQxlR8CZMBa8IHLsKjv69r0X61yRY2GBCXnGYvRHkema0oIhNgsDhPk597/yofYl+Tvq9Etgv/xUH2yJTbPmLTyYdDthWj3ugkJD1J1kDuo2ChuZaoRn3yeE45sU6H3e5cVbcQvB3MHxGkG7RqK75oAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253204; c=relaxed/simple;
	bh=a9h29uGb1l3E1PMcQ0auO6XS2PL5HLwNAM7jxWkxRVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fL2uMQXcL8nsCgjqtbdC0JGDEtn2XfT8SIAYAHfY3oyBqrNk7KTRX9vBA2WF/znAgzlRh1eK6WVCTsld9cqBta2HmrO76ZZoHO5Hdy5ul7psx0vO/d2uJGnjFuR/uQQo5goygIidqD4GM4aJ56KA2+HxZPK1k1Xdk4vhLy8T8LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mjSVyQA6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8f8smvWg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mjSVyQA6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8f8smvWg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A4FAA1F745;
	Thu,  6 Mar 2025 09:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741253200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O8S+uobPBadM/V3a3IdY2KN51KYzwx5o/vP9axxxsHo=;
	b=mjSVyQA6FOwZgDMpjD4SI7GZqPE77sEYlIHudIRXMKNDkBqg0LUgdx8zehU2Pry1BscZNB
	bQrY8+YIlYWZg8Yvi1avRyA6dmeInADozmKIP2WUG91Cw5yh1v6Txf9EzQI8sY4GIa98T5
	juhtUDid+/uCqrXJTNQEXI/sx/QPD1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741253200;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O8S+uobPBadM/V3a3IdY2KN51KYzwx5o/vP9axxxsHo=;
	b=8f8smvWgkoTuPmtAgYoWj5qhYkeTba6dXkXVYR7uU6hNBsEEZKEuy+rNzHYiZAyXa3jFFs
	fPOSDxRVtlpWQ8DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741253200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O8S+uobPBadM/V3a3IdY2KN51KYzwx5o/vP9axxxsHo=;
	b=mjSVyQA6FOwZgDMpjD4SI7GZqPE77sEYlIHudIRXMKNDkBqg0LUgdx8zehU2Pry1BscZNB
	bQrY8+YIlYWZg8Yvi1avRyA6dmeInADozmKIP2WUG91Cw5yh1v6Txf9EzQI8sY4GIa98T5
	juhtUDid+/uCqrXJTNQEXI/sx/QPD1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741253200;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O8S+uobPBadM/V3a3IdY2KN51KYzwx5o/vP9axxxsHo=;
	b=8f8smvWgkoTuPmtAgYoWj5qhYkeTba6dXkXVYR7uU6hNBsEEZKEuy+rNzHYiZAyXa3jFFs
	fPOSDxRVtlpWQ8DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92FB313A61;
	Thu,  6 Mar 2025 09:26:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id igkLI1BqyWfrFgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 06 Mar 2025 09:26:40 +0000
Date: Thu, 6 Mar 2025 10:26:36 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: James Smart <james.smart@broadcom.com>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] nvmet-fcloop: add ref counting to lport
Message-ID: <0efdf3e7-e49e-4e2f-846b-b072169de318@flourine.local>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
 <20250226-nvmet-fcloop-v1-2-c0bd83d43e6a@kernel.org>
 <20250305141740.GC18065@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305141740.GC18065@lst.de>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Wed, Mar 05, 2025 at 03:17:40PM +0100, Christoph Hellwig wrote:
> On Wed, Feb 26, 2025 at 07:45:54PM +0100, Daniel Wagner wrote:
> > +static void
> > +fcloop_lport_free(struct kref *ref)
> > +{
> > +	struct fcloop_lport *lport =
> > +		container_of(ref, struct fcloop_lport, ref);
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&fcloop_lock, flags);
> > +	list_del(&lport->lport_list);
> > +	spin_unlock_irqrestore(&fcloop_lock, flags);
> > +
> > +	kfree(lport);
> 
> Maybe it's just me, but I find the kref a really horrible pattern over
> usig a simple refcount_t.

There was already some kref usage in the fc code, that's why I started
to use it. But I agree there is not much to be gained from the kref
wrappers. I'll replace them.

> Otherwise adding proper refcounting looks fine.

BTW, I found a bunch more places which need to do proper ref counting. I
have now a version which works pretty good. Though there is one
case which gives me an UAF:

  setup target
  setup host
  connect
  loop
    remove target
    wait for host connecting state
    add target
    wait for host live state

When fcloop has no in flight commands and the target is removed, fcloop
will unregister the localport now. But the nvme-fc driver just assumes
that the port is always there and just sends down new commands
independend of the port status:

nvme_fc_start_fcp_op()
{
[...]

	ret = ctrl->lport->ops->fcp_io(&ctrl->lport->localport,
					&ctrl->rport->remoteport,
					queue->lldd_handle, &op->fcp_req);
[...]
}

There is nothing which updates the ctrl in nvme_fc_unregister_localport.
Not really sure what to do here. fcloop obviously is now behaving
differently to the hw drivers. But still, this looks very fragile that
there is no sort of synchronization between port unregistration and ctrl
state.

