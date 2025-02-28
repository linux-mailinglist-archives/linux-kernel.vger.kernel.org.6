Return-Path: <linux-kernel+bounces-537985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DA6A4934D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E6687AAEA9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7994724395E;
	Fri, 28 Feb 2025 08:18:48 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69DF24BBE5
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730728; cv=none; b=moIkG/Ds+SHuRWkmPNbfJieRRzmK4rN0IJ2/vV+64YbTm134CRzdD7XppPp/UrCN0Fu6lSmElADX9n9n82WxEXVB6Ar9GfAmoAigoyFDE96RkGT2gcn4rdF9Llo+u52dE7xbkdScH3XtF22k4Vk561UD06zg1e2yW/tG4Ilota4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730728; c=relaxed/simple;
	bh=e5XtTj74ob3AppKN6TtsDCP5wsKB2j4ygIUksIEqFwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xf6iuN+WoCUtmtlnRpuVGA/U+vJVMmNi2/4h2oWin0/IvL05WnpU30S+v8WVyTJS2IMMpPVjaXGlFJuXH8J6KjW3IAXVoQhcnJB/7YBFHdTbbz0ZVA1eNYKYkpA3whnZUgmVG+kU+1l+iB8mKO+NAVxlog46nYGpziu4qe9AOt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DA1382116F;
	Fri, 28 Feb 2025 08:18:44 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C750C13888;
	Fri, 28 Feb 2025 08:18:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +qZYMGRxwWeTNgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 28 Feb 2025 08:18:44 +0000
Date: Fri, 28 Feb 2025 09:18:44 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] nvmet-fcloop: track ref counts for nports
Message-ID: <dd2178ca-2875-4afb-b7d0-3a00af9f76bf@flourine.local>
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
X-Rspamd-Queue-Id: DA1382116F
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

On Fri, Feb 28, 2025 at 08:19:19AM +0100, Hannes Reinecke wrote:
> >   static int
> >   __targetport_unreg(struct fcloop_nport *nport, struct fcloop_tport *tport)
> >   {
> > -	if (!tport)
> > -		return -EALREADY;
> > +	int ret;
> That's iffy.
> Q1: How can you end up with a NULL tport?

The existing code doesn't get the life time right. I don't think it's
necessary anymore. This gets removed in the next two patches.

> Q2: Why do we have _two_ arguments? Can't we use 'nport->tport'?

This is addressed when the rport and tport get their own ref counting
(next two patches).

> Q3: What do you do when tport is valid and tport != nport->tport?

That is not going to happen after the full series.

I've tried to keep the changes logically separated. This patch here is
only updating the nport ref counters. It took a long time to get these
changes into a readable state. I really would like to avoid doing to
many things in one patch.

