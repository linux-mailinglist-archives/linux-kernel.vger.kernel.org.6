Return-Path: <linux-kernel+bounces-407606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B949C6FC8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8142C2888F1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D354020371E;
	Wed, 13 Nov 2024 12:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IHUDcSP2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KMiNBHHY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wkemOI1K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Y6ueXzEI"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D92201039
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 12:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731502330; cv=none; b=OReBDL/l1DwTq0ctBsjsH91o0Hdctp08pC0qrnXcSq+FbeVwXLhgmfjy98VrngZ6+A4wXe7JGd/y9ZOuORy3JEcMSr0vtebswMPAv+ikzC5bspV15Zer4hbCvE84VPon1HvtnFpT6N3fKKnpWJuUz2Cp3RoBeC6awpwlknrXJVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731502330; c=relaxed/simple;
	bh=WyQtWstneepLTMrBEOxqmjc4pBnC9IHUU4ANmA4Wuko=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BX/DHlNdenn9KGj9judAk4VG8Jb6V50FmsHa3whF79tt8aMdZ3goDg2+Gb2nbinDoLSjQTbO6WBQ3hf1SQR59PNaz6greIkTgGcHOmVuNMT8uhA6oGwGBJeq/COWnS25gVvl16/dlM9sxKUMsDjS1EHiQZ9sNJjebwgWLiK5UUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IHUDcSP2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KMiNBHHY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wkemOI1K; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Y6ueXzEI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D35E8211A6;
	Wed, 13 Nov 2024 12:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731502326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RXMTi7XagrYYq8p3dCB7a2Ily+1vyXEOoAQIYNf5jKI=;
	b=IHUDcSP2+7HUcHkdqFFlo9ALydEhDMlVp4hJuQRMGjw1291RuERW+9zmog0+1cLNx0pOPi
	vdCVfCP7gCbdpomlfa49W1cVch2U+uqWQffw1NKMmBS3Bw2SGBhTEOyCNLVhaA+pQV29l7
	VZJWPZqKwcTLQcufAy5GtCxmW7jXXBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731502326;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RXMTi7XagrYYq8p3dCB7a2Ily+1vyXEOoAQIYNf5jKI=;
	b=KMiNBHHYWkVwlHO5UW8Cq/WORSsCv1VpUIXIjsP4V218gzqeS1iJc3EbfxZurtoIicmCTb
	L0OEERNlFXNkD1Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wkemOI1K;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Y6ueXzEI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731502325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RXMTi7XagrYYq8p3dCB7a2Ily+1vyXEOoAQIYNf5jKI=;
	b=wkemOI1KnQgOqwGUAFOJR4wNUoUDwSxfHpoozU0V0ByTlJjAMbVl8D9Or7FX3Xcqbsj/B3
	2XFDZlSfmM6pX0E831+Ckps2LdTZZtjCxfeGRKuaORrAn0xMVvTwLqnjsXo3PzlxCNB9dX
	gyP57lGVkmBbJfYc3BIo6CG+4O9Ng5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731502325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RXMTi7XagrYYq8p3dCB7a2Ily+1vyXEOoAQIYNf5jKI=;
	b=Y6ueXzEIGI4x1qlYKJ4oM7VPwPwIulMwV8C0D5ZH8CvROcLKi107VL6NWGG45TKYA1jW/o
	FvLecEJDlohC+gAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9977A13301;
	Wed, 13 Nov 2024 12:52:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id msknJPWgNGc2OAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 13 Nov 2024 12:52:05 +0000
Date: Wed, 13 Nov 2024 13:52:05 +0100
Message-ID: <87o72juwi2.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev,
	"Geoffrey D. Bennett" <g@b4.vu>,
	lkp@intel.com,
	oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: Re: sound/usb/mixer_scarlett2.c:4972 scarlett2_ioctl_select_flash_segment() warn: potential spectre issue 'private->flash_segment_nums' [r] (local cap)
In-Reply-To: <acf8826e-d236-4759-bd5c-e81de992b006@stanley.mountain>
References: <acf8826e-d236-4759-bd5c-e81de992b006@stanley.mountain>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: D35E8211A6
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,01.org:url,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,intel.com:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 11 Nov 2024 10:20:07 +0100,
Dan Carpenter wrote:
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   de2f378f2b771b39594c04695feee86476743a69
> commit: 6a7508e64ee3e8320c886020bcdcd70f7fcbff2c ALSA: scarlett2: Add ioctl commands to erase flash segments
> date:   11 months ago
> config: x86_64-randconfig-161-20241110 (https://download.01.org/0day-ci/archive/20241110/202411101058.RkdgFPCg-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202411101058.RkdgFPCg-lkp@intel.com/
> 
> smatch warnings:
> sound/usb/mixer_scarlett2.c:4972 scarlett2_ioctl_select_flash_segment() warn: potential spectre issue 'private->flash_segment_nums' [r] (local cap)
> sound/usb/mixer_scarlett2.c:4973 scarlett2_ioctl_select_flash_segment() warn: possible spectre second half.  'segment_num'
> 
> vim +4972 sound/usb/mixer_scarlett2.c
> 
> 6a7508e64ee3e8 Geoffrey D. Bennett 2023-12-20  4957  /* Select a flash segment for erasing (and possibly writing to) */
> 6a7508e64ee3e8 Geoffrey D. Bennett 2023-12-20  4958  static int scarlett2_ioctl_select_flash_segment(
> 6a7508e64ee3e8 Geoffrey D. Bennett 2023-12-20  4959  	struct usb_mixer_interface *mixer,
> 6a7508e64ee3e8 Geoffrey D. Bennett 2023-12-20  4960  	unsigned long arg)
> 6a7508e64ee3e8 Geoffrey D. Bennett 2023-12-20  4961  {
> 6a7508e64ee3e8 Geoffrey D. Bennett 2023-12-20  4962  	struct scarlett2_data *private = mixer->private_data;
> 6a7508e64ee3e8 Geoffrey D. Bennett 2023-12-20  4963  	int segment_id, segment_num;
> 6a7508e64ee3e8 Geoffrey D. Bennett 2023-12-20  4964  
> 6a7508e64ee3e8 Geoffrey D. Bennett 2023-12-20  4965  	if (get_user(segment_id, (int __user *)arg))
> 6a7508e64ee3e8 Geoffrey D. Bennett 2023-12-20  4966  		return -EFAULT;
> 6a7508e64ee3e8 Geoffrey D. Bennett 2023-12-20  4967  
> 6a7508e64ee3e8 Geoffrey D. Bennett 2023-12-20  4968  	/* Check the segment ID and segment number */
> 6a7508e64ee3e8 Geoffrey D. Bennett 2023-12-20  4969  	if (segment_id < 0 || segment_id >= SCARLETT2_SEGMENT_ID_COUNT)
> 6a7508e64ee3e8 Geoffrey D. Bennett 2023-12-20  4970  		return -EINVAL;
> 6a7508e64ee3e8 Geoffrey D. Bennett 2023-12-20  4971  
> 6a7508e64ee3e8 Geoffrey D. Bennett 2023-12-20 @4972  	segment_num = private->flash_segment_nums[segment_id];
> 
> I suspect this does need an array_index_nospec().

I'm not sure whether it can really leak, but sure,
array_index_nospec() can't hurt.

Care to submit a fix patch with that?  Thanks!


Takashi

