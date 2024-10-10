Return-Path: <linux-kernel+bounces-359419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3579F998B33
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391101C22527
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161F71CC16C;
	Thu, 10 Oct 2024 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="khdA80mR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BVybbqgJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="khdA80mR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BVybbqgJ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8673A1CB312;
	Thu, 10 Oct 2024 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728573464; cv=none; b=P89erWLrm1h+Dta82vQU6pb9cT+iFazjCsNc9hv77mFE76cdx2+KoZLd4YiTpnk/3X+LEl5yPtf9DQ811xs67rZjlj56EtOTCpizfwCrJZYSowK7iEgxYi31z2ChWDFRMQgfETfboG1YMLs5z4j/5bByAnNM7JBGdkbFYOXlSog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728573464; c=relaxed/simple;
	bh=gG5srqL+EtKOJZeJNYOMLO2PrNfeumVel5mVNfhnJgA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MdpCFIGJdcjTuie9Ed05cFz02f9iSNi+QINTyWeE4bmyVA7bzwTME24kGBZ79AnOkrEqEDoLM3TD4CISvKcIFl6revQKswn5GPrP219nw1CwNkHfJpQ6FOieS3aTaGvdw7X3lAbui/XvpJAsXbxb1eHG3utX0OFAj40muBmHqXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=khdA80mR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BVybbqgJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=khdA80mR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BVybbqgJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AF4041F7FA;
	Thu, 10 Oct 2024 15:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728573460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LJuZzUClB75D4K3mAoxbLzQ/sZDYPSVhPPP6IwNNY4k=;
	b=khdA80mRwYypyvmm/fCahPDV8NbeflJnn/zAFn54ICbYk+1sqIzRpO6tmLRfCx2K5pQm9U
	f3aMrjf4e6aDMW66L/JHaruHjkyzCI3BZGYCh778zj/6WgnkTOdtb+GpTbrkAFrfuzDdcm
	2fww+dMH4daHBKnAcZA1zB4EzpGuFYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728573460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LJuZzUClB75D4K3mAoxbLzQ/sZDYPSVhPPP6IwNNY4k=;
	b=BVybbqgJo42E8OjvZJyWk2pbqOtYlfmejq/ixHXAKHg08bahy+83YCjxyhAdKTMK1Qoxvz
	i5KKOYaLqHBeORDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728573460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LJuZzUClB75D4K3mAoxbLzQ/sZDYPSVhPPP6IwNNY4k=;
	b=khdA80mRwYypyvmm/fCahPDV8NbeflJnn/zAFn54ICbYk+1sqIzRpO6tmLRfCx2K5pQm9U
	f3aMrjf4e6aDMW66L/JHaruHjkyzCI3BZGYCh778zj/6WgnkTOdtb+GpTbrkAFrfuzDdcm
	2fww+dMH4daHBKnAcZA1zB4EzpGuFYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728573460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LJuZzUClB75D4K3mAoxbLzQ/sZDYPSVhPPP6IwNNY4k=;
	b=BVybbqgJo42E8OjvZJyWk2pbqOtYlfmejq/ixHXAKHg08bahy+83YCjxyhAdKTMK1Qoxvz
	i5KKOYaLqHBeORDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6826413A6E;
	Thu, 10 Oct 2024 15:17:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fw8RGBTwB2dGeAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 10 Oct 2024 15:17:40 +0000
Date: Thu, 10 Oct 2024 17:18:36 +0200
Message-ID: <87v7y0yoj7.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	"'Luke D. Jones'" <luke@ljones.dev>,
	<tiwai@suse.com>,
	<linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>,
	<foss@athaariq.my.id>,
	<sbinding@opensource.cirrus.com>,
	<kailang@realtek.com>,
	<perex@perex.cz>
Subject: Re: [PATCH] ALSA: hda/realtek: fixup ASUS GA605W
In-Reply-To: <300a9fe1-a431-4fa2-8a25-d31d0d264099@opensource.cirrus.com>
References: <20241009205800.40570-1-luke@ljones.dev>
	<000d01db1afa$4e76b430$eb641c90$@opensource.cirrus.com>
	<87wmig17f2.wl-tiwai@suse.de>
	<001401db1b17$2afd9060$80f8b120$@opensource.cirrus.com>
	<8734l410tn.wl-tiwai@suse.de>
	<300a9fe1-a431-4fa2-8a25-d31d0d264099@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.991];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 10 Oct 2024 17:07:24 +0200,
Richard Fitzgerald wrote:
> 
> On 10/10/2024 3:37 pm, Takashi Iwai wrote:
> > On Thu, 10 Oct 2024 15:20:25 +0200,
> > Simon Trimmer wrote:
> >> 
> >> On Thu, 10 Oct 2024 13:15, Takashi Iwai wrote:
> >>> On Thu, 10 Oct 2024 11:53:49 +0200, Simon Trimmer wrote:
> >>>> On Wed, Oct 09, 2024, Luke D. Jones wrote:
> >>>>> The GA605W laptop has almost the exact same codec setup as the GA403
> >>>>> and so the same quirks apply to it.
> >>>>> 
> >>>>> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> >>>>> ---
> >>>>>   sound/pci/hda/patch_realtek.c | 2 +-
> >>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>> 
> >>>>> diff --git a/sound/pci/hda/patch_realtek.c
> >>> b/sound/pci/hda/patch_realtek.c
> >>>>> index 41e1119877b3..19b0bae074b6 100644
> >>>>> --- a/sound/pci/hda/patch_realtek.c
> >>>>> +++ b/sound/pci/hda/patch_realtek.c
> >>>>> @@ -10507,7 +10507,7 @@ static const struct snd_pci_quirk
> >>>>> alc269_fixup_tbl[] = {
> >>>> ...
> >>>>>   	SND_PCI_QUIRK(0x1043, 0x1e63, "ASUS H7606W",
> >>>> ALC285_FIXUP_CS35L56_I2C_2),
> >>>>> -	SND_PCI_QUIRK(0x1043, 0x1e83, "ASUS GA605W",
> >>>> ALC285_FIXUP_CS35L56_I2C_2),
> >>>>> +	SND_PCI_QUIRK(0x1043, 0x1e83, "ASUS GA605W",
> >>>> ALC285_FIXUP_ASUS_GA403U_HEADSET_MIC),
> >>>> ...
> >>>> 
> >>>> Hi Luke,
> >>>> Thanks!
> >>>> 
> >>>> The support code for the CS35L56 has changed a little in Takashi's
> >> branches
> >>>> from what that patch was generated against and there is no longer an
> >>>> existing quirk in the fixup table to trigger the component binding (but
> >> the
> >>>> general idea seems reasonable to hook the fixup of the headset mic).
> >>> 
> >>> Right, the patch doesn't apply to the latest tree for 6.12-rc.
> >>> 
> >>> We should start with setting up only the pincfg.  The binding with
> >>> Cirrus is handled via find_cirrus_companion_amps().  The shared DAC
> >>> of speaker and bass speaker is an open question, whether we still need
> >>> the workaround by alc285_fixup_speaker2_to_dac1().  Let's see.
> >>> 
> >>> BTW, rather a question to Cirrus devs: may the call of
> >>> find_cirrus_companion_amps() conflict with the existing manual setup
> >>> of the Cirrus codec by a quirk entry?
> >> 
> >> I think we're good (I rarely get to access to the end products so try to
> >> stick to the parts of the system that I have the details for which never
> >> includes the Realtek codec...) in this general case I'd just expect that the
> >> quirk entries wouldn't have the element at the end of the chain that used to
> >> do the amp component binding fixup and the remaining tweaks for things like
> >> the Realtek routing and mute indicators would be unaffected.
> > 
> > Well, there are quirks that do call comp_generic_fixup() with fixed
> > arguments, and I'm afraid they'll lead to some spurious error
> > messages.  Namely, find_cirrus_companion_amps() is called before
> > snd_hda_apply_fixup(PRE_PROBE), so comp_generic_fixup() might be
> > already invoked there, and the quirk entry invokes
> > comp_generic_fixup() again.  This will end up with an error message by
> > the parent->codec check in hda_component_manager_init().
> > It's just a message and nothing harmful happening, though.
> > 
> find_cirrus_companion_amps() currently only handles CS35L54/56/57, and
> when that patch was sent it also converted all quirks using those
> devices so they _don't_ call comp_generic_fixup().

Ah thanks, I completely overlooked that!

> The purpose of the
> warning was to detect people adding a quirk that tried to do the old
> way of manual component binding setup from the quirk.
>
> The remaining quirks that call comp_generic_fixup() are for CS35L41/51,
> which we haven't converted yet because there are many more models, some
> with strange ACPI and some that are old models we can't easily get hold
> of to re-test.

OK, so we are fine :)

And, even if the conflict happens, it's an error message and it
indicates that we can get rid of that quirk.


Takashi

