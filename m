Return-Path: <linux-kernel+bounces-359337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A600A998A55
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9E381C2442E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4A21CDA09;
	Thu, 10 Oct 2024 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WY9CFkJW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DlRNticD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WY9CFkJW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DlRNticD"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6451CCEE3;
	Thu, 10 Oct 2024 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570975; cv=none; b=Gov1APkTnmS/82z5npFR3oebVNvKjc1F+YriPZ/pOJu9a99SgC/EhpuAm2r0m0xRemjqcAeg7dhQnSfroJ35i1KFqJRC6ywaswkSFARS9bG1c9vMrNNfKwN3huUimsbKp8PR15HyVDpvFdCBeBkLv+Z5ocdgctwtmGgzZjAGXg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570975; c=relaxed/simple;
	bh=0HWa+HgvncmD0KmVXfi81CVYBk+mrUwhHki8BfXhDr4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jrFEAjcfx5tFpK9DBlg/Pv7ew54sQ9KJ+mZTONmNYLJLCAbeSBsQslNk/hpWaLKvp/1vxi5vC/KvD6bpT4wwvQL4LmCEkM/CbB0PK1dUlNa/ucTXy44YRaTvUEcVIkUbey8PU2dzjBF1S7fnZYml/H+xT1eorPSkH3UgsMqa/B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WY9CFkJW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DlRNticD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WY9CFkJW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DlRNticD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 451E421CAC;
	Thu, 10 Oct 2024 14:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728570972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+UrJgQMX/YVnCa77CSnsnA4rtK5Q2INuKgk8SpCa+6A=;
	b=WY9CFkJWnco+0KhhTgGRMTjSMef/51OM37yyykwbfFvc2zRAm7LK+MfT57+sAz3P1+ZqEv
	frwpqvktsG1jg9YON1J7GZRq9LerY6mKbAbu+PJFzxv+aWG3ElW250oREazYskdTjFi6Bt
	bxvUQRQU7olWsRWW6OKL7OdoEcZ3/yA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728570972;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+UrJgQMX/YVnCa77CSnsnA4rtK5Q2INuKgk8SpCa+6A=;
	b=DlRNticDHdgxDzFMaBGOnyLg1QpfoIkkys5s91EYuQpbOZ/QNKBgTA13/XUujPcsA7mFsq
	VZP7WN2pSKA58DBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WY9CFkJW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DlRNticD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728570972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+UrJgQMX/YVnCa77CSnsnA4rtK5Q2INuKgk8SpCa+6A=;
	b=WY9CFkJWnco+0KhhTgGRMTjSMef/51OM37yyykwbfFvc2zRAm7LK+MfT57+sAz3P1+ZqEv
	frwpqvktsG1jg9YON1J7GZRq9LerY6mKbAbu+PJFzxv+aWG3ElW250oREazYskdTjFi6Bt
	bxvUQRQU7olWsRWW6OKL7OdoEcZ3/yA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728570972;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+UrJgQMX/YVnCa77CSnsnA4rtK5Q2INuKgk8SpCa+6A=;
	b=DlRNticDHdgxDzFMaBGOnyLg1QpfoIkkys5s91EYuQpbOZ/QNKBgTA13/XUujPcsA7mFsq
	VZP7WN2pSKA58DBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E63711370C;
	Thu, 10 Oct 2024 14:36:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IRj4NlvmB2dFagAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 10 Oct 2024 14:36:11 +0000
Date: Thu, 10 Oct 2024 16:37:08 +0200
Message-ID: <8734l410tn.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Simon Trimmer <simont@opensource.cirrus.com>
Cc: 'Takashi Iwai' <tiwai@suse.de>,
	"'Luke D. Jones'" <luke@ljones.dev>,
	<tiwai@suse.com>,
	<linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>,
	<rf@opensource.cirrus.com>,
	<foss@athaariq.my.id>,
	<sbinding@opensource.cirrus.com>,
	<kailang@realtek.com>,
	<perex@perex.cz>
Subject: Re: [PATCH] ALSA: hda/realtek: fixup ASUS GA605W
In-Reply-To: <001401db1b17$2afd9060$80f8b120$@opensource.cirrus.com>
References: <20241009205800.40570-1-luke@ljones.dev>
	<000d01db1afa$4e76b430$eb641c90$@opensource.cirrus.com>
	<87wmig17f2.wl-tiwai@suse.de>
	<001401db1b17$2afd9060$80f8b120$@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 451E421CAC
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 10 Oct 2024 15:20:25 +0200,
Simon Trimmer wrote:
> 
> On Thu, 10 Oct 2024 13:15, Takashi Iwai wrote:
> > On Thu, 10 Oct 2024 11:53:49 +0200, Simon Trimmer wrote:
> > > On Wed, Oct 09, 2024, Luke D. Jones wrote:
> > > > The GA605W laptop has almost the exact same codec setup as the GA403
> > > > and so the same quirks apply to it.
> > > >
> > > > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > > > ---
> > > >  sound/pci/hda/patch_realtek.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/sound/pci/hda/patch_realtek.c
> > b/sound/pci/hda/patch_realtek.c
> > > > index 41e1119877b3..19b0bae074b6 100644
> > > > --- a/sound/pci/hda/patch_realtek.c
> > > > +++ b/sound/pci/hda/patch_realtek.c
> > > > @@ -10507,7 +10507,7 @@ static const struct snd_pci_quirk
> > > > alc269_fixup_tbl[] = {
> > > ...
> > > >  	SND_PCI_QUIRK(0x1043, 0x1e63, "ASUS H7606W",
> > > ALC285_FIXUP_CS35L56_I2C_2),
> > > > -	SND_PCI_QUIRK(0x1043, 0x1e83, "ASUS GA605W",
> > > ALC285_FIXUP_CS35L56_I2C_2),
> > > > +	SND_PCI_QUIRK(0x1043, 0x1e83, "ASUS GA605W",
> > > ALC285_FIXUP_ASUS_GA403U_HEADSET_MIC),
> > > ...
> > >
> > > Hi Luke,
> > > Thanks!
> > >
> > > The support code for the CS35L56 has changed a little in Takashi's
> branches
> > > from what that patch was generated against and there is no longer an
> > > existing quirk in the fixup table to trigger the component binding (but
> the
> > > general idea seems reasonable to hook the fixup of the headset mic).
> > 
> > Right, the patch doesn't apply to the latest tree for 6.12-rc.
> > 
> > We should start with setting up only the pincfg.  The binding with
> > Cirrus is handled via find_cirrus_companion_amps().  The shared DAC
> > of speaker and bass speaker is an open question, whether we still need
> > the workaround by alc285_fixup_speaker2_to_dac1().  Let's see.
> > 
> > BTW, rather a question to Cirrus devs: may the call of
> > find_cirrus_companion_amps() conflict with the existing manual setup
> > of the Cirrus codec by a quirk entry?
> 
> I think we're good (I rarely get to access to the end products so try to
> stick to the parts of the system that I have the details for which never
> includes the Realtek codec...) in this general case I'd just expect that the
> quirk entries wouldn't have the element at the end of the chain that used to
> do the amp component binding fixup and the remaining tweaks for things like
> the Realtek routing and mute indicators would be unaffected.

Well, there are quirks that do call comp_generic_fixup() with fixed
arguments, and I'm afraid they'll lead to some spurious error
messages.  Namely, find_cirrus_companion_amps() is called before
snd_hda_apply_fixup(PRE_PROBE), so comp_generic_fixup() might be
already invoked there, and the quirk entry invokes
comp_generic_fixup() again.  This will end up with an error message by
the parent->codec check in hda_component_manager_init().
It's just a message and nothing harmful happening, though.


Takashi

