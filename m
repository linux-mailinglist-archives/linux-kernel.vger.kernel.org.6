Return-Path: <linux-kernel+bounces-296784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C7995AF25
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 397DA1C22BE3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA166A8CF;
	Thu, 22 Aug 2024 07:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q72qKnkX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8CMsFHiy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r86aGzxQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9JPH6G4R"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED8915C13A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724311078; cv=none; b=swDb1hHYMNaojSkk0pa8gLBMvEqvk3kaJkTMl3XcTkJSU7wlKb9IDNAKgW9zoc9CVgQN3pXST13lBwoH8wAmszk7g2gKLe8wcypCxlw3g6MFMPz5AMjWwj3mEnRRg4KrQKI2Dox6IoTd3kdXMgxPs0yLof8aiLdbOTPUrFao9Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724311078; c=relaxed/simple;
	bh=rf9ulMskAH3M8RF9iG8KnQWxl54Eu4vwsu4uKC630d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZF2m0sfHXVls1tDh747oSSOX/7XcgXSOYeVAqj1jinBdf3JkzFXRVDp7A5V77FNyKOdlpCLc8gHZFaN7Niiq/HkCgi+0BbGQseccBoWiyVCdP6dB8ls6BASbRo3zcdgDJcxTVceN4clxs/flU65ls0BHwNh6KrCbGDuXwPcQgUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q72qKnkX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8CMsFHiy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=r86aGzxQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9JPH6G4R; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B78C1219A8;
	Thu, 22 Aug 2024 07:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724311068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4B79cYTjR2Bgjzg3ZSIzh3as+7VYTk7wzTMIDOp2bMI=;
	b=Q72qKnkXJPxMdxYAIZiIe0ZNwrJPyC41M8YAkNm02WVV503/kL0Gj4EesAb4WQK0uj9XxF
	xr7GErLCaepvaiTwsvYfZ1HjXYb/hwCXRLLhXMGGYd6lUK4swpYRRvucqVqcdBaBZD9lws
	/raADIq4cOqqf9om738XXrzMeQuK0eg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724311068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4B79cYTjR2Bgjzg3ZSIzh3as+7VYTk7wzTMIDOp2bMI=;
	b=8CMsFHiyDymxqJTfoeaoY6/Ij6cSHpQvI3PU21KfIvh3W0PyJt9nsuQqnmcX9bLl7Euvp4
	QOI9zu3V8yzYWeDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724311067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4B79cYTjR2Bgjzg3ZSIzh3as+7VYTk7wzTMIDOp2bMI=;
	b=r86aGzxQThOLY8RemsF3WGfSSYo9FOF5OEyXRmgPXJ4EN2HJfRWzW1+97GgVTYhl2fbTPS
	EekZoR1oitUJrrQLwvpivIuMr18sVmwFRQ41mxTwBVb/41Ax3XH4t41VLt7lcBdyGnnxwK
	M832NQqlx1oHDjAJR7NDxtkP1j11pt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724311067;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4B79cYTjR2Bgjzg3ZSIzh3as+7VYTk7wzTMIDOp2bMI=;
	b=9JPH6G4R3OW5y9bTD0l44lx/HUVCY3SVBs2UCx4PwaKZLEJGBbnU1j+jjCtXwfFWVD1WUC
	DbSrpBY0K46Et4Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E32713297;
	Thu, 22 Aug 2024 07:17:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h0NUJBvmxmbQUgAAD6G6ig
	(envelope-from <iivanov@suse.de>); Thu, 22 Aug 2024 07:17:47 +0000
Date: Thu, 22 Aug 2024 10:22:55 +0300
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Corey Minyard <corey@minyard.net>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi:ssif: Improve detecting during probing
Message-ID: <20240822072255.fncuy4xdkglnf3bn@localhost.localdomain>
References: <20240816065458.117986-1-iivanov@suse.de>
 <ZsU9SRlQgzQn8bDs@mail.minyard.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsU9SRlQgzQn8bDs@mail.minyard.net>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,minyard.net:email,imap1.dmz-prg2.suse.org:helo,localhost.localdomain:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Hi Corey,

On 08-20 20:05, Corey Minyard wrote:
> 
> If an IPMI SSIF device is probed and there is something there, but
> probably not an actual BMC, the code would just issue a lot of errors
> before it failed.  We kind of need these errors to help with certain
> issues, and some of the failure reports are non-fatal.
> 
> However, a get device id command should alway work.  If that fails,
> nothing else is going to work and it's a pretty good indication that
> there's no valid BMC there.  So issue and check that command and bail
> if it fails.
> 
> Reported-by: Ivan T. Ivanov <iivanov@suse.de>
> Signed-off-by: Corey Minyard <corey@minyard.net>
> ---
>  drivers/char/ipmi/ipmi_ssif.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> Ivan, is it possible for you to test this patch on the broken system?

This exact system is not available to me at the moment. I have few
other machines on which I could test this.

> It should work based on what you reported, but it's nice to be sure.
> 
> Also, I discovered that the detect function is kind of bogus, it only
> works on an address list that isn't present (any more).  However, I
> re-used it for my purposes in the probe function.
> 
> Thanks.
> 
> diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> index e8e7b832c060..4c403e7a9fc8 100644
> --- a/drivers/char/ipmi/ipmi_ssif.c
> +++ b/drivers/char/ipmi/ipmi_ssif.c
> @@ -1368,8 +1368,20 @@ static int ssif_detect(struct i2c_client *client, struct i2c_board_info *info)
>  	rv = do_cmd(client, 2, msg, &len, resp);
>  	if (rv)
>  		rv = -ENODEV;

What is my worry is that in case of SMBus errors, device is there but
for some reason it got stuck/crashed or whatever, so will get out of
detect function from here and with ENODEV return code probe function
will be called for no reason.

> -	else
> +	else {
> +	    if (len < 3) {
> +		rv = -ENODEV;

No point to call probe(), right?

> +	    } else {
> +		struct ipmi_device_id id;
> +
> +		rv = ipmi_demangle_device_id(resp[0] >> 2, resp[1],
> +					     resp + 2, len - 2, &id);
> +		if (rv)
> +		    rv = -ENODEV; /* Error means a BMC probably isn't there. */

Same.

> +	    }
> +	    if (!rv && info)
>  		strscpy(info->type, DEVICE_NAME, I2C_NAME_SIZE);
> +	}
>  	kfree(resp);
>  	return rv;
>  }
> @@ -1704,6 +1716,16 @@ static int ssif_probe(struct i2c_client *client)
>  		ipmi_addr_src_to_str(ssif_info->addr_source),
>  		client->addr, client->adapter->name, slave_addr);
>  
> +	/*
> +	 * Send a get device id command and validate its response to
> +	 * make sure a valid BMC is there.
> +	 */
> +	rv = ssif_detect(client, NULL);
> +	if (rv) {
> +		dev_err(&client->dev, "Not present\n");
> +		goto out;
> +	}
> +

The point is that even after this point IPMI device can start failing
to properly communicate with the OS, real SMBus errors, like EREMOTEIO
in my case, but unfortunately code bellow do not handle this very well,
I think.


>  	/* Now check for system interface capabilities */
>  	msg[0] = IPMI_NETFN_APP_REQUEST << 2;
>  	msg[1] = IPMI_GET_SYSTEM_INTERFACE_CAPABILITIES_CMD;
> -- 
> 2.34.1
> 

Regards,
Ivan


