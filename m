Return-Path: <linux-kernel+bounces-214937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E33908C62
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801FA1C25D25
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 13:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B8219A29F;
	Fri, 14 Jun 2024 13:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m67iA66n";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K1Pm2DcZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m67iA66n";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K1Pm2DcZ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F89018C05
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 13:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718371208; cv=none; b=sTLuW4UR9WQgEsJgbt8NCjs3W4ZCm58QYzBGzWIX3iRIj6UtJym2NF84G+mJs3IBuoHh6TqusyB3R8+ScBBsL8YHbjV7mOFn3dixNtpfOME4HGrYPqHpInjId8V8wwyEjZRbgot6p3t2W9Vxbe+P5JTzuXGwjFDOTYa5N6NjFuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718371208; c=relaxed/simple;
	bh=QreHZYh9/NHv4vn5RyJ+g/BcHVu2Ifdrukik7znp0l4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L1G+jlxtwTiYNLiz8L28cRL7E5cDGj18sfw71jrqPbD8/RQ6oJJXcUwr6a2iTBBpscADB5buirauGeTdzAU1ew+VUmR7kGx//tEVcqiC8rhHaeUJB9QYzlq3nRbXR3sklIDcp4jkwF+36ehoDJY4iEVXjoyGDw7S8MjH2PJhiVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m67iA66n; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K1Pm2DcZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m67iA66n; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K1Pm2DcZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9700C20520;
	Fri, 14 Jun 2024 13:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718371205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eOn5MQNTKpgnx87el0pUyppOx7TmIkRzmFQRkKcz4fY=;
	b=m67iA66nH7tp5y+fQl40DOWTxnRzt+BcY34ei1YjRnphE8m6dMUwsBAzGEEpUzxmhH+j1a
	CPWqbHR6KbKMYWRN5lPcx2p+PlPbDWg+r7WSLt+agTH1aNFY2p8Wkn9aq4Qc8yECx2tM8U
	00fRYTZAXYzSAbBPDVLryvYq9TN+UDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718371205;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eOn5MQNTKpgnx87el0pUyppOx7TmIkRzmFQRkKcz4fY=;
	b=K1Pm2DcZA7Jsn7oKZUVSgNkfsNrb9p/DJ5vfMeeEKvJFD+/JU7cdcZhJbGuLh5efWJhPij
	SxmS7mp9j+pdG6Bg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=m67iA66n;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=K1Pm2DcZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718371205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eOn5MQNTKpgnx87el0pUyppOx7TmIkRzmFQRkKcz4fY=;
	b=m67iA66nH7tp5y+fQl40DOWTxnRzt+BcY34ei1YjRnphE8m6dMUwsBAzGEEpUzxmhH+j1a
	CPWqbHR6KbKMYWRN5lPcx2p+PlPbDWg+r7WSLt+agTH1aNFY2p8Wkn9aq4Qc8yECx2tM8U
	00fRYTZAXYzSAbBPDVLryvYq9TN+UDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718371205;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eOn5MQNTKpgnx87el0pUyppOx7TmIkRzmFQRkKcz4fY=;
	b=K1Pm2DcZA7Jsn7oKZUVSgNkfsNrb9p/DJ5vfMeeEKvJFD+/JU7cdcZhJbGuLh5efWJhPij
	SxmS7mp9j+pdG6Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 255BE13AB1;
	Fri, 14 Jun 2024 13:20:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sPjsB4VDbGa9OgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 14 Jun 2024 13:20:05 +0000
Date: Fri, 14 Jun 2024 15:20:29 +0200
Message-ID: <874j9v8xuq.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Baojun Xu <baojun.xu@ti.com>
Cc: <robh+dt@kernel.org>,
	<andriy.shevchenko@linux.intel.com>,
	<lgirdwood@gmail.com>,
	<perex@perex.cz>,
	<pierre-louis.bossart@linux.intel.com>,
	<kevin-lu@ti.com>,
	<shenghao-ding@ti.com>,
	<navada@ti.com>,
	<13916275206@139.com>,
	<v-hampiholi@ti.com>,
	<v-po@ti.com>,
	<niranjan.hy@ti.com>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<liam.r.girdwood@intel.com>,
	<yung-chuan.liao@linux.intel.com>,
	<broonie@kernel.org>,
	<soyer@irl.hu>
Subject: Re: [PATCH v8] ALSA: hda/tas2781: Add tas2781 hda SPI driver
In-Reply-To: <20240614040554.610-1-baojun.xu@ti.com>
References: <20240614040554.610-1-baojun.xu@ti.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 9700C20520
X-Spam-Score: -2.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[139.com,gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,gmail.com,perex.cz,ti.com,139.com,alsa-project.org,vger.kernel.org,intel.com,irl.hu];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Fri, 14 Jun 2024 06:05:54 +0200,
Baojun Xu wrote:
> +static struct tasdevice_config_info *tasdevice_add_config(
> +	struct tasdevice_priv *tas_priv, unsigned char *config_data,
> +	unsigned int config_size, int *status)
> +{
(snip)
> +	/*
> +	 * convert data[offset], data[offset + 1], data[offset + 2] and
> +	 * data[offset + 3] into host
> +	 */
> +	cfg_info->nblocks = get_unaligned_be32(&config_data[config_offset]);
> +	config_offset += 4;
> +
> +	/*
> +	 * Several kinds of dsp/algorithm firmwares can run on tas2781,
> +	 * the number and size of blk are not fixed and different among
> +	 * these firmwares.
> +	 */
> +	bk_da = cfg_info->blk_data = kcalloc(cfg_info->nblocks,
> +		sizeof(*bk_da), GFP_KERNEL);

So the allocation size relies on the firmware data content, and it can
practically any value.  It'd be safer to have some sanity check for
avoiding the allocation of too large pages.
Ditto for other allocations in this code; you should never trust the
firmware binary.

Also, in general, the comments are missing for functions in
tas2781_spi_fwlib.c completely.  A brief comment for each function
would be helpful for readers.


thanks,

Takashi

