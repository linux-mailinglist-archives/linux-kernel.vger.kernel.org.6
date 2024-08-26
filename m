Return-Path: <linux-kernel+bounces-301372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E6B95EFB1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 13:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BF1C1C2149A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFF71547E9;
	Mon, 26 Aug 2024 11:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NGzFtWFg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t1oSoP1E";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NGzFtWFg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t1oSoP1E"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EED6155A4F
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 11:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724671603; cv=none; b=Rlp9jMAbyElgeRvaLuhMBaSgEbLjk7psq0RnQjeUB+D+k/eRVmEn4+ZGn7lB/lz31jknzd+Fvnpry4MgqWtwA2vAZ36Kyy+J5dZA68QcM/XjIR/jBRY1cyz8vQjzlnagSC+zTZe88n8sZooSV6ZGtoEnRsogBo5HQE08GFrlNow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724671603; c=relaxed/simple;
	bh=b5WExipv8BdOySIni1tn+Wh7PbF3sPm9d6sInjufJhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzyfhHpjyHm6NtUPakPhdIHyVemoQn5doQOkDh5b3Zp6cqe5+8/Yu/B2wDQxikVPqF3Uf+nlF9qZfiZ3RCz9J20l3Mb0/x+W5jlETFOTQPiVPMCke+WrF1HU5tmFk6cTsQSWos0NWf+G7DsprbiCgBSCkGN9/uSPGB6VsTo8IBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NGzFtWFg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t1oSoP1E; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NGzFtWFg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t1oSoP1E; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B048A21AA6;
	Mon, 26 Aug 2024 11:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724671599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PmKJMKcI/y7dNkyLfi7cvnd87hl3q4+K6RJHxGte1Ho=;
	b=NGzFtWFgfupz64ZkEalBdAnpB8jBTMP4bB1p6YZNup469U00MgLwJIFTDjalvmPwsfY6pZ
	cjdEs6jHLjXh4EdkmvfBMlmcWgz0xxZUL1WXd8U+p7q+6Bk2LtRAcfseQP8WHDMmRMPuf0
	Le2kzI2a7x8MGp8DX5cnySqp7oxlHTc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724671599;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PmKJMKcI/y7dNkyLfi7cvnd87hl3q4+K6RJHxGte1Ho=;
	b=t1oSoP1EGPxRQWzB5Y+LzUiSUQrgD9hepJW+8tSbTKztRhH3c0nuc9GTNuwnTUfjIuz9aM
	+WsyDa+d5x77X4DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724671599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PmKJMKcI/y7dNkyLfi7cvnd87hl3q4+K6RJHxGte1Ho=;
	b=NGzFtWFgfupz64ZkEalBdAnpB8jBTMP4bB1p6YZNup469U00MgLwJIFTDjalvmPwsfY6pZ
	cjdEs6jHLjXh4EdkmvfBMlmcWgz0xxZUL1WXd8U+p7q+6Bk2LtRAcfseQP8WHDMmRMPuf0
	Le2kzI2a7x8MGp8DX5cnySqp7oxlHTc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724671599;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PmKJMKcI/y7dNkyLfi7cvnd87hl3q4+K6RJHxGte1Ho=;
	b=t1oSoP1EGPxRQWzB5Y+LzUiSUQrgD9hepJW+8tSbTKztRhH3c0nuc9GTNuwnTUfjIuz9aM
	+WsyDa+d5x77X4DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8CCF61398D;
	Mon, 26 Aug 2024 11:26:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wVkSIG9mzGaEFgAAD6G6ig
	(envelope-from <iivanov@suse.de>); Mon, 26 Aug 2024 11:26:39 +0000
Date: Mon, 26 Aug 2024 14:31:50 +0300
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Corey Minyard <corey@minyard.net>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi:ssif: Improve detecting during probing
Message-ID: <20240826113150.42lyq6nmkyn53cv6@localhost.localdomain>
References: <20240816065458.117986-1-iivanov@suse.de>
 <ZsU9SRlQgzQn8bDs@mail.minyard.net>
 <20240822072255.fncuy4xdkglnf3bn@localhost.localdomain>
 <ZsdN8sBIUYetCUOp@mail.minyard.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsdN8sBIUYetCUOp@mail.minyard.net>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Hi,

On 08-22 09:40, Corey Minyard wrote:
> > > +++ b/drivers/char/ipmi/ipmi_ssif.c
> > > @@ -1368,8 +1368,20 @@ static int ssif_detect(struct i2c_client *client, struct i2c_board_info *info)
> > >  	rv = do_cmd(client, 2, msg, &len, resp);
> > >  	if (rv)
> > >  		rv = -ENODEV;
> > 
> > What is my worry is that in case of SMBus errors, device is there but
> > for some reason it got stuck/crashed or whatever, so will get out of
> > detect function from here and with ENODEV return code probe function
> > will be called for no reason.
> 
> That's not how the i2c code works.  See my next comment.
> 
> > 
> > > -	else
> > > +	else {
> > > +	    if (len < 3) {
> > > +		rv = -ENODEV;
> > 
> > No point to call probe(), right?
> 
> Originally (before I add the call from ssif_probe()), this is not involved in
> the probe() call.  Instead, the detect function is involved in calling a
> table of addresses in driver->address_list.  So in this case this
> function is never called at all from the i2c code, since there is no
> address list.

I see, thank you for explanation.

> > >  
> > > +	/*
> > > +	 * Send a get device id command and validate its response to
> > > +	 * make sure a valid BMC is there.
> > > +	 */
> > > +	rv = ssif_detect(client, NULL);
> > > +	if (rv) {
> > > +		dev_err(&client->dev, "Not present\n");
> > > +		goto out;
> > > +	}
> > > +
> > 
> > The point is that even after this point IPMI device can start failing
> > to properly communicate with the OS, real SMBus errors, like EREMOTEIO
> > in my case, but unfortunately code bellow do not handle this very well,
> > I think.
> 
> It is possible that the BMC gets rebooted or something between the call
> to ssif_detect() and the code below, but the probability is really low.
> If it answers a detect, the rest of the things should work.
> 

I have my daubs, but patch proposed will fix the issue that I see.

Thank you,
Ivan

