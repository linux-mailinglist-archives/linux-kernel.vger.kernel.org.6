Return-Path: <linux-kernel+bounces-333286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9B097C667
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933381C2143F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D964E199943;
	Thu, 19 Sep 2024 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qiaLlNA1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8WgXI4ra";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qiaLlNA1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8WgXI4ra"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6E91991AB;
	Thu, 19 Sep 2024 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726736224; cv=none; b=WVbrjidILCY4CxO3emxTiuVn6Ky1MuDgccJNwOWmNMMknDHJEfaOsSdQsLmsEbz1zdv7hXO3MUCz7kErFkZzaY8zGe6atDZ9bF9fdyj31lxQYwx3aBD7lTRfgrzaq6+PYiKPf5apEBaSAVugGYTdLS67HyGHevR0wt0zgbXoVoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726736224; c=relaxed/simple;
	bh=a3imPDKU4F8x26aj5GR4LklMpGZycrHBarNWJaSxQoQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QcDDGR9U3xF4ODQBShWXw45vaobYQ8W8+jjEKeTgBAozq3WkIdCSr/Uoa468mVN5/s45EH/CnfwFhIN270GGb61ZN6NbsbeHkvGMYRwvRbmFvXEp8T/9uLF+DZMFNGRu7iBXPoYysOLuKCICqtfY5xC1espCSo6ZenORApGNdZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qiaLlNA1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8WgXI4ra; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qiaLlNA1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8WgXI4ra; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7A3D820863;
	Thu, 19 Sep 2024 08:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726736214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=96dUAEKZsvERcAjWDxiPW5H6Y1CxOvpbvlwAXEDik30=;
	b=qiaLlNA1zzNSj9Fizg+ztYaxIjAGol+v+u6s4cs6biDNsED8tF1pm36FlbqN2Ynb4krIJ4
	yyN8aeWJsr0SgdVci8mY7+iSVqtsY7IY/vBaxOiqAXDK33aKrZVMUXAl34BeJeZ4OVggkc
	9dRByhb6zDHkr9FXzKOHVQImCUH/4+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726736214;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=96dUAEKZsvERcAjWDxiPW5H6Y1CxOvpbvlwAXEDik30=;
	b=8WgXI4ramYSSL9qgxGB/v05W4Lj5eNPF/c1jgS4YK/CQupYKqbbATjxXO8G9xMXxrh7wkd
	AgEEhPIsUVbWLVAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qiaLlNA1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8WgXI4ra
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726736214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=96dUAEKZsvERcAjWDxiPW5H6Y1CxOvpbvlwAXEDik30=;
	b=qiaLlNA1zzNSj9Fizg+ztYaxIjAGol+v+u6s4cs6biDNsED8tF1pm36FlbqN2Ynb4krIJ4
	yyN8aeWJsr0SgdVci8mY7+iSVqtsY7IY/vBaxOiqAXDK33aKrZVMUXAl34BeJeZ4OVggkc
	9dRByhb6zDHkr9FXzKOHVQImCUH/4+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726736214;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=96dUAEKZsvERcAjWDxiPW5H6Y1CxOvpbvlwAXEDik30=;
	b=8WgXI4ramYSSL9qgxGB/v05W4Lj5eNPF/c1jgS4YK/CQupYKqbbATjxXO8G9xMXxrh7wkd
	AgEEhPIsUVbWLVAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3BA2913AAA;
	Thu, 19 Sep 2024 08:56:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lRzGDFbn62amZwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 19 Sep 2024 08:56:54 +0000
Date: Thu, 19 Sep 2024 10:57:44 +0200
Message-ID: <874j6cc96f.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Christoffer Sandberg <cs@tuxedo.de>
Cc: Takashi Iwai <tiwai@suse.de>,
	Werner Sembach <wse@tuxedocomputers.com>,
	Jerry Luo
 <jerryluo225@gmail.com>,
	Christian Heusel <christian@heusel.eu>,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>
Subject: Re: [REGRESSION][BISECTED] Audio volume issues since 4178d78cd7a8
In-Reply-To: <cedb8758bb506bf9454b90eebcaaea24@tuxedo.de>
References: <c930b6a6-64e5-498f-b65a-1cd5e0a1d733@heusel.eu>
	<87jzfbh5tu.wl-tiwai@suse.de>
	<66dfd536-ae17-4d75-b514-7931a3734e54@gmail.com>
	<20f70c0a92a27db29f188e05c33ba82c@tuxedo.de>
	<1fbba03e-56b8-4e74-adf6-998e3a2d9dac@gmail.com>
	<87setxe68m.wl-tiwai@suse.de>
	<87r09he63e.wl-tiwai@suse.de>
	<dfb141e8-6afa-4d21-8cd4-f9a53e8a192e@tuxedocomputers.com>
	<87r09hcbr0.wl-tiwai@suse.de>
	<cedb8758bb506bf9454b90eebcaaea24@tuxedo.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 7A3D820863
X-Spam-Level: 
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.de,tuxedocomputers.com,gmail.com,heusel.eu,lists.linux.dev,vger.kernel.org,perex.cz];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -5.51
X-Spam-Flag: NO

On Wed, 18 Sep 2024 16:10:00 +0200,
Christoffer Sandberg wrote:
> 
> 
> 
> On 18.9.2024 15:49, Takashi Iwai wrote:
> > On Wed, 18 Sep 2024 15:39:28 +0200,
> > Werner Sembach wrote:
> >> 
> >> Hi
> >> 
> >> Am 18.09.24 um 10:09 schrieb Takashi Iwai:
> >> > On Wed, 18 Sep 2024 10:06:01 +0200,
> >> > Takashi Iwai wrote:
> >> >> [...]
> >> >> I don't see any relevant about the incorrect volumes by the suggested
> >> >> commit, but at least we should avoid applying the quirk for a
> >> >> non-existing speaker pin.
> >> >>
> >> >> Jerry, yours is with CX11970 (codec id 0x14f120d0), right?
> >> 
> >> Yes, at least for the preproduction sample of the Sirius Gen1 I have
> >> at hand atm.
> >> 
> >> pciid is 2782:12c3
> >> 
> >> @Christoffer: I guess 2782:12c5 is for the Gen2?
> 
> Yes the other is for Sirius Gen2
> 
> > 
> > Hm, and one of those PCI SSID conflicts with System76 Pangolin
> > (pang14)?  All seem to have the very same codec CX11970.
> 
> I don't think I saw the pci id explicitly listed, but that was the
> assumption.
> 
> > 
> > If they really conflict in both PCI and HD-audio codec IDs, the only
> > way would be to check DMI string, I'm afraid.
> > 
> 
> I asked about the volumes since it could be a hint that a second
> speaker is activated but stuck on a fixed volume. This would make a
> low general volume setting sound louder but still somewhat adjustable.
> 
> However, if we can not verify second speaker pair, then I agree, DMI
> limit would be the safe choice.

So, just to make clear: the device reported for a regression and the
device you tried to tweak are different models?  The former is
Pangolin and the latter Sirius Gen 2.  I'm confused by models.

With the quirk, you'll get an individual mixer element controlling the
top speaker volume?


Takashi

