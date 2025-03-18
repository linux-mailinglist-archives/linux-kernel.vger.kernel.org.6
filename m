Return-Path: <linux-kernel+bounces-566275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2B9A675BB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BC9F17BADC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3A220D4FE;
	Tue, 18 Mar 2025 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tCwU+aIL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qhBm95KO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tCwU+aIL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qhBm95KO"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1315F20D50F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306323; cv=none; b=DWKjAPsVv9mcjw13CBOI7ZkTThFvuEawSIqBMEYIF/TRZMpyyB9GNer2d0x9IZbRsKoxBDQaggzk3Us2BYlfDPL9LleIRhVv8vPLmRvfig7Nu0/kHCqlEMMdMgM0vnCWlJlMMRWu8CjzgqXXXnNblxTPIfmJdonp4FC+mP0yrtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306323; c=relaxed/simple;
	bh=/rRUJB29oIW9SVyhAr6UvQFY9DqPnmLGM+Y6UIZ0UqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHxUksUzi3NxUMsRkC/soAF9v9+iF9SIqgQK6/+0WPkqFbesgeRQKukAeCKxnh+QrHC1VaKQDPLtl2u5EgscnZYj2JK0jeWSwuQpcZs17PfrAOkvEF7Lhh0P8YS+2gdxnAUvmzFmoxsI+ZTtg4s3NDdubDhluj64ueD3t7B6A08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tCwU+aIL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qhBm95KO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tCwU+aIL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qhBm95KO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2D8161FB8B;
	Tue, 18 Mar 2025 13:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742306316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oMZsbt5FP/7lZCFP5G6rNOmyLmrJneszQ4p8hqVY674=;
	b=tCwU+aILtVfHcK6WpYY+q9K/jmIn29BF0LXmOcnvUvgAbNQs9pPxELPFsGmSdvl2N0YsO8
	LqsihYOZ15adcXS4TNByWsC7EPa/lOpLKGS1CM6CCzRmzHbkbi8zivGcJV+z5+7EgV7dJx
	2MveBvEVMGGiRceuykq334RuOslvQSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742306316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oMZsbt5FP/7lZCFP5G6rNOmyLmrJneszQ4p8hqVY674=;
	b=qhBm95KOjJ63saOpkLonqlpOO6G/iNm1iW7nKksQhEjUL69/G0kdBDL3t0fbKOSP1uQNGT
	BQBcF1Gk5+Q4WABg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742306316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oMZsbt5FP/7lZCFP5G6rNOmyLmrJneszQ4p8hqVY674=;
	b=tCwU+aILtVfHcK6WpYY+q9K/jmIn29BF0LXmOcnvUvgAbNQs9pPxELPFsGmSdvl2N0YsO8
	LqsihYOZ15adcXS4TNByWsC7EPa/lOpLKGS1CM6CCzRmzHbkbi8zivGcJV+z5+7EgV7dJx
	2MveBvEVMGGiRceuykq334RuOslvQSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742306316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oMZsbt5FP/7lZCFP5G6rNOmyLmrJneszQ4p8hqVY674=;
	b=qhBm95KOjJ63saOpkLonqlpOO6G/iNm1iW7nKksQhEjUL69/G0kdBDL3t0fbKOSP1uQNGT
	BQBcF1Gk5+Q4WABg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F1D613A82;
	Tue, 18 Mar 2025 13:58:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SlaZBgx82WcpfwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 18 Mar 2025 13:58:36 +0000
Date: Tue, 18 Mar 2025 14:58:35 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/18] nvmet-fcloop: allocate/free fcloop_lsreq
 directly
Message-ID: <984ea057-de15-472a-9be3-79594f6bfc00@flourine.local>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
 <20250318-nvmet-fcloop-v3-10-05fec0fc02f6@kernel.org>
 <603b438e-02f6-4f01-8ffa-12ab6ec8e745@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <603b438e-02f6-4f01-8ffa-12ab6ec8e745@suse.de>
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[flourine.local:mid]
X-Spam-Score: -8.30
X-Spam-Flag: NO

On Tue, Mar 18, 2025 at 12:17:11PM +0100, Hannes Reinecke wrote:
> > +	tls_req = kmalloc(sizeof(*tls_req), GFP_KERNEL);
> > +	if (!tls_req)
> > +		return -ENOMEM;
> 
> This cries out for kmem_cache_alloc() ...

Okay, will switch to this API. FWIW, in the same call path there are
more kmallocs.

