Return-Path: <linux-kernel+bounces-537925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB607A49289
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F240188908E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9A31CAA81;
	Fri, 28 Feb 2025 07:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UAZFwBtz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XtbLek28";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UAZFwBtz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XtbLek28"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89B51C701E
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 07:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729422; cv=none; b=bT2+qhAbHiaT2mU69XkiCMra8sWPKl/s4VROMGKi4v/N1GZ54TZuPQW+FAP53yXb2WxC3XHWbg0ZzMvdUymDBxZAolhUDwkcWullbdfjEUo8B0yKJmak37YqqsCa+yUy5EwH8azKqyGN4HiL3xLOpK/SW4dQgq+Lf5cuEfdQBy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729422; c=relaxed/simple;
	bh=sXeSRtt8KMLM94AGLcgdrPYyAwLovRHZDFXkfhdwGzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3YnuBPYc8qNFmYtfpydZsSzaPP1LThPks0eerPHKWD+va0I3fHXJpnsvEZqY+kKmD7AOnLXxF0M63f1lQz5EcuBJJRVfMVPpNiibo9wvQu7awefPPUv0p9TFFhnJAvI+W/iOsj+akqbq3Wa1mPrhV30mGEgT9qB+YAPnoiJtWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UAZFwBtz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XtbLek28; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UAZFwBtz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XtbLek28; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0B75C2116F;
	Fri, 28 Feb 2025 07:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740729419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hMhfRxvqIxKZMaQZi3hmHrhrCs+pyqYO7m7E4eS+VBs=;
	b=UAZFwBtzHSBKCPtNx7WHhO16JG5xF871Dgorzgjj0w8p4FRTsaATlE/P2h3j6giFJLHg0B
	rhahqIkCoSAEq+9dXSBKtYMsAx4m2eiBBMV/Ho9xCLV+vF/gHwzfBsK4MXaGML0/T9L8zj
	DkgwsAGJFyY5hexDsD2sgml5KjqwFPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740729419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hMhfRxvqIxKZMaQZi3hmHrhrCs+pyqYO7m7E4eS+VBs=;
	b=XtbLek288T5w9IO4MIJcSfmiX2k8M8x9cjE2u8pWYPlML4RxBCb63mpouktiobGF+hQJi+
	X6pX5jXg5sfOMUCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740729419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hMhfRxvqIxKZMaQZi3hmHrhrCs+pyqYO7m7E4eS+VBs=;
	b=UAZFwBtzHSBKCPtNx7WHhO16JG5xF871Dgorzgjj0w8p4FRTsaATlE/P2h3j6giFJLHg0B
	rhahqIkCoSAEq+9dXSBKtYMsAx4m2eiBBMV/Ho9xCLV+vF/gHwzfBsK4MXaGML0/T9L8zj
	DkgwsAGJFyY5hexDsD2sgml5KjqwFPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740729419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hMhfRxvqIxKZMaQZi3hmHrhrCs+pyqYO7m7E4eS+VBs=;
	b=XtbLek288T5w9IO4MIJcSfmiX2k8M8x9cjE2u8pWYPlML4RxBCb63mpouktiobGF+hQJi+
	X6pX5jXg5sfOMUCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E58BE13888;
	Fri, 28 Feb 2025 07:56:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vjwUN0pswWfGLgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 28 Feb 2025 07:56:58 +0000
Date: Fri, 28 Feb 2025 08:56:58 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] nvmet-fcloop: refactor fcloop_nport_alloc
Message-ID: <0e41c69f-32f0-4c19-8d52-04d767acbaed@flourine.local>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
 <20250226-nvmet-fcloop-v1-3-c0bd83d43e6a@kernel.org>
 <fd877a93-8630-4180-a591-5916e18cda72@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd877a93-8630-4180-a591-5916e18cda72@suse.de>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Feb 28, 2025 at 08:11:11AM +0100, Hannes Reinecke wrote:
> > +	nport = fcloop_nport_lookup(opts->wwnn, opts->wwpn);
> > +	if (nport && ((remoteport && nport->rport) ||
> > +		      (!remoteport && nport->tport))) {
> > +		/* invalid configuration */
> > +		goto out_put_nport;
> > +	}
> > -	spin_lock_irqsave(&fcloop_lock, flags);
> > +	if (!nport) {
> > +		nport = kzalloc(sizeof(*nport), GFP_KERNEL);
> > +		if (!nport)
> > +			goto out_free_opts;
> > -	list_for_each_entry(tmplport, &fcloop_lports, lport_list) {
> > -		if (tmplport->localport->node_name == opts->wwnn &&
> > -		    tmplport->localport->port_name == opts->wwpn)
> > -			goto out_invalid_opts;
> > +		INIT_LIST_HEAD(&nport->nport_list);
> > +		nport->node_name = opts->wwnn;
> > +		nport->port_name = opts->wwpn;
> > +		kref_init(&nport->ref);
> > -		if (tmplport->localport->node_name == opts->lpwwnn &&
> > -		    tmplport->localport->port_name == opts->lpwwpn)
> > -			lport = tmplport;
> > +		spin_lock_irqsave(&fcloop_lock, flags);
> > +		list_add_tail(&nport->nport_list, &fcloop_nports);
> > +		spin_unlock_irqrestore(&fcloop_lock, flags);
> 
> Don't you need to check here if an 'nport' with the same node_name and
> port_name is already present?

There is the existing check which filters out some of the duplicates
(the check is there to allow setting up the target or the remote port
first, so the order doesn't matter), though I am not sure if it would
catch all duplicates. I don't mind adding this, but I'd say it would be
better in a separate patch. I tried to refactor this code without
changing anything else.

