Return-Path: <linux-kernel+bounces-424383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B109DB3BD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61628B20E24
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 08:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694AB14B945;
	Thu, 28 Nov 2024 08:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qOfSgclG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Cc26DFz+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mFgd71lM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Cb+Ohr9W"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C131482ED;
	Thu, 28 Nov 2024 08:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732782519; cv=none; b=Bn9S0Jhxw5iH25uHHlCKLsfU4fGzegAQs2GwyThnvp+wpRLU514Z7+upmLGaj/Y0znctwwafp2Em31qWOXgYCm0ZCm6hkN2HdKpeWOofJB2udR6UyH5C3vqfvRe/CeVToYcokX4AbUnnB/Y60jwxANcvmfc7oPxiBdNPKs41kZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732782519; c=relaxed/simple;
	bh=ppOz57D5/QOHyWkP+XkuxOjZgzhGJyX5lCZfk7fzMU0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BsOPx7NF4P5gsyy7LcPDDGd7gIFQxAcbZm8d+H0TsGUUMcLfXwLPyGoXC4tTTUeOOV8oS0CgmI8I3J9Ub0pDn9eeZuhQky05vi+8Tk1KGXyOFFHRUb/tGeBPKLLe+IrHU7SDf04IekoxYTEajLtuY4R9dafEsLy/DfBlLCBoZoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qOfSgclG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Cc26DFz+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mFgd71lM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Cb+Ohr9W; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DD12F1F79B;
	Thu, 28 Nov 2024 08:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732782516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sAmLvEd3LAjcLACR2vxOVbz4VKip1PistZd7oHGkXaU=;
	b=qOfSgclGYpNs0yNMHF2pcG09VFvFieiTcgXYMibWTPzRVTzrUuJaIqCeX1urMImPhf1LS/
	duiDvSV1PpU3Njj4MkZxkTSiXU9scJMzzeaWSasBe6M1L0E5z4kbSPJY9H8sV5JwioVRBy
	so1G+p+BMdZDbSs8kh31ikZd5H2Gro4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732782516;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sAmLvEd3LAjcLACR2vxOVbz4VKip1PistZd7oHGkXaU=;
	b=Cc26DFz+has3rNMsGN+35hNL5Pvaf4JdULNQNmlPRXViJkvmWjWjY2FUvNy85Hca6ksSlu
	oWKhUp2e0nyVgWAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mFgd71lM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Cb+Ohr9W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732782515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sAmLvEd3LAjcLACR2vxOVbz4VKip1PistZd7oHGkXaU=;
	b=mFgd71lM4m4QryJ2QwircMfrQld0K2evzfngfonakrQoiQuJ28hJWa4PFd7uiWl2+Tmoau
	zbbdY7x8au82SJQ2qVkB/hotmgGnMxtnpEv9u5C4bSZlczAlHjp5DcDyW7ACDS8IH6aZD9
	477bbOXRX9g8Z/EZW1bqEkwdxBARFX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732782515;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sAmLvEd3LAjcLACR2vxOVbz4VKip1PistZd7oHGkXaU=;
	b=Cb+Ohr9WyhX5lkPZyfTiTpXnm8pyhFySQjoIhRmS/tM8E7ln6dLPO95ZQ2hrzhy8hmj1Uu
	l80bFfW4GiLkQcCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A04F013974;
	Thu, 28 Nov 2024 08:28:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Un4HJrMpSGcPJAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 28 Nov 2024 08:28:35 +0000
Date: Thu, 28 Nov 2024 09:28:35 +0100
Message-ID: <87wmgn4v9o.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: <bo.liu@senarytech.com>
Cc: "'Takashi Iwai'" <tiwai@suse.de>,
	<perex@perex.cz>,
	<tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<feng.liu@senarytech.com>
Subject: Re: =?GB2312?B?tPC4tDo=?= [PATCH V2] ALSA: hda/conexant: fix
 Z60MR100 startup pop issue
In-Reply-To: <022d01db416f$116441c0$342cc540$@senarytech.com>
References: <20241128060812.433362-1-bo.liu@senarytech.com>
	<874j3r6db8.wl-tiwai@suse.de>
	<022d01db416f$116441c0$342cc540$@senarytech.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: DD12F1F79B
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 28 Nov 2024 09:25:22 +0100,
<bo.liu@senarytech.com> wrote:
> 
> > On Thu, 28 Nov 2024 07:08:12 +0100,
> > bo liu wrote:
> > > 
> > > When Z60MR100 startup, speaker will output a pop. To fix this issue, 
> > > we mute codec by init verbs in bios when system startup, and set GPIO 
> > > to low to unmute codec in codec driver when it loaded .
> > > 
> > > Signed-off-by: bo liu <bo.liu@senarytech.com>
> > > ---
> > >  sound/pci/hda/patch_conexant.c | 35 
> > > ++++++++++++++++++++++++++++++++++
> > >  1 file changed, 35 insertions(+)
> > > 
> > > diff --git a/sound/pci/hda/patch_conexant.c 
> > > b/sound/pci/hda/patch_conexant.c index e851785ff058..62c53e64bcad 
> > > 100644
> > > --- a/sound/pci/hda/patch_conexant.c
> > > +++ b/sound/pci/hda/patch_conexant.c
> > > @@ -42,6 +42,7 @@ struct conexant_spec {
> > >  	unsigned int gpio_led;
> > >  	unsigned int gpio_mute_led_mask;
> > >  	unsigned int gpio_mic_led_mask;
> > > +	unsigned int gpio_unmute_bit_mask;
> > >  	bool is_cx8070_sn6140;
> > >  };
> > >  
> > > @@ -308,6 +309,7 @@ enum {
> > >  	CXT_FIXUP_HP_MIC_NO_PRESENCE,
> > >  	CXT_PINCFG_SWS_JS201D,
> > >  	CXT_PINCFG_TOP_SPEAKER,
> > > +	CXT_FIXUP_HP_A_U,
> > >  };
> > >  
> > >  /* for hda_fixup_thinkpad_acpi() */
> > > @@ -762,6 +764,24 @@ static void cxt_setup_mute_led(struct hda_codec
> *codec,
> > >  	}
> > >  }
> > >  
> > > +static void cxt_setup_mute_gpio_and_unmute(struct hda_codec *codec,
> > > +				unsigned int gpio_mute_mask)
> > > +{
> > > +	struct conexant_spec *spec = codec->spec;
> > > +
> > > +	if (gpio_mute_mask) {
> > > +		spec->gpio_unmute_bit_mask = gpio_mute_mask;
> >
> > Any reason to store this in spec?  As far as I see the code below, it's
> used only locally here, so it doesn't have to be stored there.
> 
> The purpose of adding this is to differentiate the configuration of the
> LED_MUTE GPIO and to retain debugging information. Of course, this field can
> be removed if desired.

Yes, please remove.


Takashi

