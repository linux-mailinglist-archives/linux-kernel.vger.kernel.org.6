Return-Path: <linux-kernel+bounces-538038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 789D9A493DA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2D2188F179
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67F4253B67;
	Fri, 28 Feb 2025 08:45:16 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D984B1C6FFD
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740732316; cv=none; b=QaRx7VhxpR8E1xcEXTN8qUlBpUkEvwioPNZfFLrHYIqH49vgZo+GDlVR/Pr91sv74mw0U7jUWzXbEzNa/eRca3iIlY8Dx5JDBZ2VSUW3N7G581Li0w+Y2zwCQrJGwH9LA1ujUenSWFk6IdzvDFIiwo5gWVJepB3We6446VbFadM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740732316; c=relaxed/simple;
	bh=RBIBB1TOcqVm8RyyOIRxJiXCiRWd50D1WKWqmJ05Jrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgXE8DIIhsqcmxTZ4nbreu5Rtpq6qhkm58rIvwD+ueVVOfZm/7nvYKb+MjWB/Heqd6G9+WCJEb5tcQS3Tt1V+hTlGSqkK35wG23r8LRChXzgja4wN161Da3haDy2gL4IDlKQlHNlf70kk5RRLIP4s7LOhD9qA1aGCbKl8hS9pdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0D9021F38F;
	Fri, 28 Feb 2025 08:45:13 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F26A813888;
	Fri, 28 Feb 2025 08:45:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id swBhOph3wWe7PwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 28 Feb 2025 08:45:12 +0000
Date: Fri, 28 Feb 2025 09:45:12 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] nvmet-fc: take tgtport reference only once
Message-ID: <7ab71df0-e9e8-4035-a215-f5259c69fe88@flourine.local>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
 <20250226-nvmet-fcloop-v1-8-c0bd83d43e6a@kernel.org>
 <f944fdb3-081f-474a-9193-f482fe87f72b@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f944fdb3-081f-474a-9193-f482fe87f72b@suse.de>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 0D9021F38F
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

On Fri, Feb 28, 2025 at 08:34:51AM +0100, Hannes Reinecke wrote:
> On 2/26/25 19:46, Daniel Wagner wrote:
> > The reference counting code can be simplified. Instead taking a tgtport
> > refrerence at the beginning of nvmet_fc_alloc_hostport and put it back
> > if not a new hostport object is allocated, only take it when a new
> > hostport object is allocated.
> > 
> Can it really?
> Main point of this operation is that 'tgtport' isn't going away during while
> we're figuring out whether we need it.
> 
> With this patch it means that

The tgtport is not going away. nvmet_fc_alloc_hostport can only be
called with reference on tgtport being hold:

nvmet_fc_rcv_ls_req
  nvmet_fc_tgtport_get(tgtport)
  nvmet_fc_handle_ls_rqst_work
    nvmet_fc_handle_ls_rqst
      nvmet_fc_ls_create_association
        nvmet_fc_alloc_target_assoc
          nvmet_fc_alloc_hostport

The goal with this patch here is to make it simpler to read where we
take a ref. IMO, there is not really anything gained by the existing
logic, though I agree it's not obvious that the tgtport is not going
away. Would it be okay to add a comment?

