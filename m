Return-Path: <linux-kernel+bounces-321150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7289D971536
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE50AB24E7D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67BD1B3F20;
	Mon,  9 Sep 2024 10:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cQnnboIV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AAJn5MOa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cQnnboIV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AAJn5MOa"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7EF1AC8BF;
	Mon,  9 Sep 2024 10:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725877299; cv=none; b=I5Tno9SVHaQC8rqm45TpAyPnYqRFgKAE51//EZYOcdMan6vKnFIZNhg6D/nJ/+ezz9kI/9uhuq9UqCWnKnGl7VkWX/vLuBi9UcBttME/pXbGxSHq9ETiQpTLpxKiXkN/6ku7EFi9uI6LS3GH4AUeQPwIE4M+zNbgZyUC4V1BnB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725877299; c=relaxed/simple;
	bh=ejK0GbtAF+GSVLIFnAP+sjR3J5oxAOAx8bemhH4f7CE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BJ/7hW6+PI5/385JhsPvAI4tNvXvrLZxDrtHdEnuzgcdEcuPeD3f1OrHygDJhZdfs9g5qyew6zirdVAQfAjy6bbkSDV6ehTK8LnO24GBQOU+VbRF1ZId2oUfE/VL5a0kvm1rKYVBy6BGluzMp+y3ioR8QWT3z83A/2rxWaTJNoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cQnnboIV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AAJn5MOa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cQnnboIV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AAJn5MOa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8252A1F7B0;
	Mon,  9 Sep 2024 10:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725877295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ez3YO4IDzShoayvYusyxy01T+IMorgiexfzzsj2ELEA=;
	b=cQnnboIVh5x4b83VCBtKbm7fL9ifS/OFJWry9R7N8WCAdnl/C3H7+55O7ONp2DSNGdiFy1
	Z+aJWgacGhZVOtEGElAmwG61Spip1DUNaPsuPX2hT7L3e4aHhXsa07lPtvsAwBbm/F/EzL
	9MygEBLgjI6hAqEQhvDqOB7JBjbu5Zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725877295;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ez3YO4IDzShoayvYusyxy01T+IMorgiexfzzsj2ELEA=;
	b=AAJn5MOaE3ju8ZdR8NGWcIGYuI+MBAGOXkCOcEHvmjbyBEXe4mFmrpLTyFVt3IEcm2mI1c
	BASMa36x/eFmELAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cQnnboIV;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=AAJn5MOa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725877295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ez3YO4IDzShoayvYusyxy01T+IMorgiexfzzsj2ELEA=;
	b=cQnnboIVh5x4b83VCBtKbm7fL9ifS/OFJWry9R7N8WCAdnl/C3H7+55O7ONp2DSNGdiFy1
	Z+aJWgacGhZVOtEGElAmwG61Spip1DUNaPsuPX2hT7L3e4aHhXsa07lPtvsAwBbm/F/EzL
	9MygEBLgjI6hAqEQhvDqOB7JBjbu5Zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725877295;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ez3YO4IDzShoayvYusyxy01T+IMorgiexfzzsj2ELEA=;
	b=AAJn5MOaE3ju8ZdR8NGWcIGYuI+MBAGOXkCOcEHvmjbyBEXe4mFmrpLTyFVt3IEcm2mI1c
	BASMa36x/eFmELAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53F4B13312;
	Mon,  9 Sep 2024 10:21:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TXVVEy/M3mbOFQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 09 Sep 2024 10:21:35 +0000
Date: Mon, 09 Sep 2024 12:22:22 +0200
Message-ID: <874j6pazz5.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Leo Tsai <antivirus621@gmail.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	leo.tsai@cmedia.com.tw,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: Add a new CM9825 standard driver.
In-Reply-To: <875xr5b02r.wl-tiwai@suse.de>
References: <20240909022340.7808-1-antivirus621@gmail.com>
	<875xr5b02r.wl-tiwai@suse.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 8252A1F7B0
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 09 Sep 2024 12:20:12 +0200,
Takashi Iwai wrote:
> 
> On Mon, 09 Sep 2024 04:23:40 +0200,
> Leo Tsai wrote:
> > 
> > The CM9825 is a High Definition Audio Codec.
> > There are 2 independent stereo outputs, one of the stereo
> > outputs is cap-less with HP AMP, and the other is line out to
> > connect the active speaker. The inputs can be Line-in and MIC-in.
> > 
> > Signed-off-by: Leo Tsai <antivirus621@gmail.com>
> > ---
> >  sound/pci/hda/patch_cmedia.c | 268 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 268 insertions(+)
> >  mode change 100644 => 100755 sound/pci/hda/patch_cmedia.c
> > 
> > diff --git a/sound/pci/hda/patch_cmedia.c b/sound/pci/hda/patch_cmedia.c
> > old mode 100644
> > new mode 100755
> 
> You changed the file permission mistakenly here?
> 
> > index 2ddd33f8dd6c..3195261a7d2c
> > --- a/sound/pci/hda/patch_cmedia.c
> > +++ b/sound/pci/hda/patch_cmedia.c
> (snip)
> > +	{0x3C, AC_VERB_SET_AMP_GAIN_MUTE | 0x0a0, 0x2d},	/* Gain set */
> > +	{0x3C, AC_VERB_SET_AMP_GAIN_MUTE | 0x090, 0x2d},	/* Gain set */
> 
> FWIW, those are equivalent with:
> 	{0x3C, AC_VERB_SET_AMP_GAIN_MUTE, AC_AMP_SET_OUTPUT | AC_AMP_SET_RIGHT | 0x2d},	/* Gain set */
> 	{0x3C, AC_VERB_SET_AMP_GAIN_MUTE, AC_AMP_SET_OUTPUT | AC_AMP_SET_LEFT | 0x2d},	/* Gain set */
> 
> > +static void cm9825_unsol_hp_delayed(struct work_struct *work)
> > +{
> > +	struct cmi_spec *spec =
> > +	    container_of(to_delayed_work(work), struct cmi_spec, unsol_hp_work);
> > +	struct hda_jack_tbl *jack;
> > +	hda_nid_t hp_pin = spec->gen.autocfg.hp_pins[0];
> > +	bool hp_jack_plugin = false;
> > +	int err = 0;
> 
> Both are unnecessary initializations.
> 
> > +static int cm9825_resume(struct hda_codec *codec)
> > +{
> > +	struct cmi_spec *spec = codec->spec;
> > +	hda_nid_t hp_pin = 0;
> > +	bool hp_jack_plugin = false;
> > +	int err;
> > +
> > +	err =
> > +	    snd_hda_codec_write(spec->codec, 0x42, 0,
> > +				AC_VERB_SET_PIN_WIDGET_CONTROL, 0x00);
> > +	if (err)
> > +		codec_dbg(codec, "codec_write err %d\n", err);
> > +
> > +	/* hibernation resume needs the full chip initialization */
> > +	if (cmi_is_s4_resume(codec))
> > +		codec_dbg(spec->codec, "resume from S4\n");
> 
> Is the comment above correct?
> It only shows a debug print and does nothing else, no?
> 
> > @@ -32,6 +252,53 @@ static const struct hda_codec_ops cmi_auto_patch_ops = {
> >  	.unsol_event = snd_hda_jack_unsol_event,
> >  };
> >  
> > +static int patch_cm9825(struct hda_codec *codec)
> > +{
> (snip)
> > +	INIT_DELAYED_WORK(&spec->unsol_hp_work, cm9825_unsol_hp_delayed);
> 
> If you use the delayed work, it has to be cleared at the destructor
> via cancel_delayed_work().  That is, you'd need the own ops.free
> callback implementation.
> 
> And if doing so, it's better to put this initialization earlier (right
> after the alloc of spec and its field initializations), so that you
> can call cancel_delayed_work() unconditionally.

And last but not least: don't forget to put v2 prefix to the subject
at the next submission, e.g.
  Subject: [PATCH v2] ALSA: hda: ....


Takashi

