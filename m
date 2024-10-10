Return-Path: <linux-kernel+bounces-358948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A39B9985A7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70E1BB22110
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8348E1C3F3C;
	Thu, 10 Oct 2024 12:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Jo0wdbVX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wTCNZNFt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Jo0wdbVX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wTCNZNFt"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567501C3F18;
	Thu, 10 Oct 2024 12:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728562428; cv=none; b=lGWho1dh78ct7SQRQ+64KGHPWAbknMIhVryz69IEs/Lu3ncHgYzc2/OS/QlC+5G7Eexxtc5NXkW+tqI4WJrJBcb4Ec20SProJY1wgU0cvkaRZDSJUVtt8LWYJNEGw7YLoQf9cXPAsYXRt7kvQpl1xQZ7ctNrriew+INR3So9KzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728562428; c=relaxed/simple;
	bh=ZkgrSXJ7onTTxEyF80naFkkH0e8UozBrRCaIXcf2YZA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U0rCNw+QUPRDKH0TCYf0sKwsX0aaDNxSSAJ+OZgk2kmn6HdY43suwWbRUTXvGZAICVeOFtJBM6nGy6im3K/R2Ja9wpkh15wPgLFC+m58XwgZgQx/AL2bmwcNq0rPjAIbnR169e1nZCVMlsvhGHprnt4KPXWdlD43XJ1Uf/6WSAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Jo0wdbVX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wTCNZNFt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Jo0wdbVX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wTCNZNFt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7C9891FDED;
	Thu, 10 Oct 2024 12:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728562425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LCpmE+DBNKaM7oVrritzx0iaaoy1AxeMLC+c/z8yVtE=;
	b=Jo0wdbVXiyrJ4/KkbiNheIyPiCvTvuwZaq1gYunToELNaLk8ZVgA6UJpwoj41n6T4bAJTu
	reyEgW90aGOFjINNBMkDykHXaVj5i/8sFOSIHYsVQ5s+GkldbFe1BiMDmTg/2HOSUAmlVU
	jvyczU/Mdr7TqkNVaINKBGjVS+BUza4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728562425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LCpmE+DBNKaM7oVrritzx0iaaoy1AxeMLC+c/z8yVtE=;
	b=wTCNZNFtslirGjCKDSCWHTqiSJiynSI1C8avTssbP7drNzrOrTj1iS+MG1zZnKFErlYsLH
	cOgf9tZuUpNgNqCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728562425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LCpmE+DBNKaM7oVrritzx0iaaoy1AxeMLC+c/z8yVtE=;
	b=Jo0wdbVXiyrJ4/KkbiNheIyPiCvTvuwZaq1gYunToELNaLk8ZVgA6UJpwoj41n6T4bAJTu
	reyEgW90aGOFjINNBMkDykHXaVj5i/8sFOSIHYsVQ5s+GkldbFe1BiMDmTg/2HOSUAmlVU
	jvyczU/Mdr7TqkNVaINKBGjVS+BUza4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728562425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LCpmE+DBNKaM7oVrritzx0iaaoy1AxeMLC+c/z8yVtE=;
	b=wTCNZNFtslirGjCKDSCWHTqiSJiynSI1C8avTssbP7drNzrOrTj1iS+MG1zZnKFErlYsLH
	cOgf9tZuUpNgNqCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3AEC61370C;
	Thu, 10 Oct 2024 12:13:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zZEiDfnEB2ctPAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 10 Oct 2024 12:13:45 +0000
Date: Thu, 10 Oct 2024 14:14:41 +0200
Message-ID: <87wmig17f2.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Simon Trimmer <simont@opensource.cirrus.com>
Cc: "'Luke D. Jones'" <luke@ljones.dev>,
	<tiwai@suse.com>,
	<linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>,
	<rf@opensource.cirrus.com>,
	<foss@athaariq.my.id>,
	<sbinding@opensource.cirrus.com>,
	<kailang@realtek.com>,
	<perex@perex.cz>
Subject: Re: [PATCH] ALSA: hda/realtek: fixup ASUS GA605W
In-Reply-To: <000d01db1afa$4e76b430$eb641c90$@opensource.cirrus.com>
References: <20241009205800.40570-1-luke@ljones.dev>
	<000d01db1afa$4e76b430$eb641c90$@opensource.cirrus.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
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

On Thu, 10 Oct 2024 11:53:49 +0200,
Simon Trimmer wrote:
> 
> On Wed, Oct 09, 2024, Luke D. Jones wrote:
> > The GA605W laptop has almost the exact same codec setup as the GA403
> > and so the same quirks apply to it.
> > 
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > ---
> >  sound/pci/hda/patch_realtek.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> > index 41e1119877b3..19b0bae074b6 100644
> > --- a/sound/pci/hda/patch_realtek.c
> > +++ b/sound/pci/hda/patch_realtek.c
> > @@ -10507,7 +10507,7 @@ static const struct snd_pci_quirk
> > alc269_fixup_tbl[] = {
> ...
> >  	SND_PCI_QUIRK(0x1043, 0x1e63, "ASUS H7606W",
> ALC285_FIXUP_CS35L56_I2C_2),
> > -	SND_PCI_QUIRK(0x1043, 0x1e83, "ASUS GA605W",
> ALC285_FIXUP_CS35L56_I2C_2),
> > +	SND_PCI_QUIRK(0x1043, 0x1e83, "ASUS GA605W",
> ALC285_FIXUP_ASUS_GA403U_HEADSET_MIC),
> ...
> 
> Hi Luke,
> Thanks!
> 
> The support code for the CS35L56 has changed a little in Takashi's branches
> from what that patch was generated against and there is no longer an
> existing quirk in the fixup table to trigger the component binding (but the
> general idea seems reasonable to hook the fixup of the headset mic).

Right, the patch doesn't apply to the latest tree for 6.12-rc.

We should start with setting up only the pincfg.  The binding with
Cirrus is handled via find_cirrus_companion_amps().  The shared DAC
of speaker and bass speaker is an open question, whether we still need
the workaround by alc285_fixup_speaker2_to_dac1().  Let's see.

BTW, rather a question to Cirrus devs: may the call of
find_cirrus_companion_amps() conflict with the existing manual setup
of the Cirrus codec by a quirk entry?


thanks,

Takashi

