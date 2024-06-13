Return-Path: <linux-kernel+bounces-213194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C61C90700F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB493289463
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E022B146D6E;
	Thu, 13 Jun 2024 12:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hZAaElmB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Zjv5w1BF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hZAaElmB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Zjv5w1BF"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EAE145A03
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281388; cv=none; b=sSZisvuxeToqEEA+ejdvvHGbHU1V17diShKIkwTSMxG+r/sgbR/X3B+b4d5BzYreihPprt3r3kJ4mAeQKAj9rBaydYzTmb3UYK3ALFUXhsu1JdhCD5WIo590d4JNDrJdBscwzLxjCV68yxdTCcHKIvqHViAwFSUrko2LvjLJ8Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281388; c=relaxed/simple;
	bh=axK0BDnhqirFCUDdXgvVo3g+EGvLaM0cBzN0tLj2pzk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kDxnr0J8/WplUctCv4qEIRINKjNBzMUdf7XRRTs4iwX8LqyZ4xkxMGNm6mAX8fAaIico3SfwpwHKiqj5OEnUtkWndndWHmKrLQwnSOUuO/t+7p/GXAbEGCCitS59Dcj/l39Rgo8lu/wsUTy+yd7Kpc1xbT6bjVL49fC0AGpl0l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hZAaElmB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Zjv5w1BF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hZAaElmB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Zjv5w1BF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 43C025D322;
	Thu, 13 Jun 2024 12:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718281384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wZUNWmSgXT4ylcdc8OI7ZtHGdqliabURi29bSW7LwGc=;
	b=hZAaElmB5lred2TmOfQIoi1Gv4+Kp1y8jwfj4IMSu+jVQpE3X7S5b7KxQo857dQE47rZvn
	7Jd2bsOSMw45xxW0KdO0iOyieDjInedOrzEZ8ZJX+DosD13TPwPQtSkU8Rx+KgpWigC9iJ
	utKzXMyJm/Qtbc6JS0vpmKOX0Iei//4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718281384;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wZUNWmSgXT4ylcdc8OI7ZtHGdqliabURi29bSW7LwGc=;
	b=Zjv5w1BF2BM+A5WeGZGJxiGvEZD/xv/pwHibSHqCdSemFnKVgXTi4PbdE7k5xNoHAfDCOO
	bSmbgasiVHXbsIDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hZAaElmB;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Zjv5w1BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718281384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wZUNWmSgXT4ylcdc8OI7ZtHGdqliabURi29bSW7LwGc=;
	b=hZAaElmB5lred2TmOfQIoi1Gv4+Kp1y8jwfj4IMSu+jVQpE3X7S5b7KxQo857dQE47rZvn
	7Jd2bsOSMw45xxW0KdO0iOyieDjInedOrzEZ8ZJX+DosD13TPwPQtSkU8Rx+KgpWigC9iJ
	utKzXMyJm/Qtbc6JS0vpmKOX0Iei//4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718281384;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wZUNWmSgXT4ylcdc8OI7ZtHGdqliabURi29bSW7LwGc=;
	b=Zjv5w1BF2BM+A5WeGZGJxiGvEZD/xv/pwHibSHqCdSemFnKVgXTi4PbdE7k5xNoHAfDCOO
	bSmbgasiVHXbsIDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B236C13A7F;
	Thu, 13 Jun 2024 12:23:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id O+/FKafkamZjJgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 13 Jun 2024 12:23:03 +0000
Date: Thu, 13 Jun 2024 14:23:27 +0200
Message-ID: <877cetni9s.wl-tiwai@suse.de>
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
Subject: Re: [PATCH v7 0/1] Add tas2781 driver for SPI.
In-Reply-To: <20240613082633.388-1-baojun.xu@ti.com>
References: <20240613082633.388-1-baojun.xu@ti.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 43C025D322
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[19];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[139.com,gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,gmail.com,perex.cz,ti.com,139.com,alsa-project.org,vger.kernel.org,intel.com,irl.hu];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,ti.com:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Thu, 13 Jun 2024 10:26:32 +0200,
Baojun Xu wrote:
> 
> This patch was used to add TAS2781 devices on SPI support in sound/pci/hda.
> It use ACPI node descript about parameters of TAS2781 on SPI, it like:
>     Scope (_SB.PC00.SPI0)
>     {
>         Device (GSPK)
>         {
>             Name (_HID, "TXNW2781")  // _HID: Hardware ID
>             Method (_CRS, 0, NotSerialized)
>             {
>                 Name (RBUF, ResourceTemplate ()
>                 {
>                     SpiSerialBusV2 (...)
>                     SpiSerialBusV2 (...)
>                 }
>             }
>         }
>     }
> 
> And in platform/x86/serial-multi-instantiate.c, those spi devices will be
> added into system as a single SPI device, so TAS2781 SPI driver will
> probe twice for every single SPI device. And driver will also parser
> mono DSP firmware binary and RCA binary for itself.
> 
> Signed-off-by: Baojun Xu <baojun.xu@ti.com>
> 
> Baojun Xu (1):
>   ALSA: hda/tas2781: Add tas2781 hda driver based on SPI

Since you're sending only one patch, we need no cover letter, and all
needed stuff should be documented in the patch description itself.
That is, The texts like above should go there, too.


thanks,

Takashi

