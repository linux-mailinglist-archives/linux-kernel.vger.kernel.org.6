Return-Path: <linux-kernel+bounces-576545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8E5A710C0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 07:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1020C7A5739
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 06:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE8A190696;
	Wed, 26 Mar 2025 06:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lPgdg4vw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="18plpg2A";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lPgdg4vw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="18plpg2A"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AF816C684
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 06:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742971811; cv=none; b=LCPvMVWhgoVPvgenIfkvFKGSMwKW30Yt5wxKbEs2nVnu4TwAyB1mV5Ac1BkPgFnOPv/SfCNteB47BO0mAMroDVKCLigAJqN9zWIluNL9wlGciDsDMQfoCXkmeYT1Qi4xndEyYrPSJV+Tdgf/8AH2ASJOQw89xcgRcEYbxD8pUbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742971811; c=relaxed/simple;
	bh=vvIMKN60Orf2V99yJ3fawF7I4H1WzJtvNXtSgz1Y/YM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D6pGTfuZqV82n/LzkFkccOW+pe4Vznoa87WchnSFffvdgcM9EX54bXdVZwiNP3zfNzzYHbBQIDOErQWkHHCGnnMQwugtQpMRqYc0cxoomPQA84SKRBQcd2V3KpmVg/7nNgCI3K9N62aiKEdUmT4lyZANV5sE9YfauMe+w+Rz8nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lPgdg4vw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=18plpg2A; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lPgdg4vw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=18plpg2A; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6772A1F391;
	Wed, 26 Mar 2025 06:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742971807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=laj/EhJ7jWdcyYdTlvjhEoV/kv6Zg6+tir35KJD6ti0=;
	b=lPgdg4vwbea8sbAMt3UUk4fxCdrVceLjyLVfvAMyCFWGotZnOqnzl2eOW/jxy4lklUMnbJ
	ZyWwjk+IzLpj1vsgUKjBOfQHLyvxtoER1If/nBTHqTLsfdA2ZgLD0Gruon6Bn9qACTPsdG
	nEQvhPFAS7XFKd0IOY0E+3UvcbEv1Lg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742971807;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=laj/EhJ7jWdcyYdTlvjhEoV/kv6Zg6+tir35KJD6ti0=;
	b=18plpg2AEalPvbDg0RtDh1aV4c8Rfp1EDW6Co8TN7K/8724QazTMKQvbXooh4bWQudm/i8
	7KKifdLwjrXuibDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lPgdg4vw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=18plpg2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742971807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=laj/EhJ7jWdcyYdTlvjhEoV/kv6Zg6+tir35KJD6ti0=;
	b=lPgdg4vwbea8sbAMt3UUk4fxCdrVceLjyLVfvAMyCFWGotZnOqnzl2eOW/jxy4lklUMnbJ
	ZyWwjk+IzLpj1vsgUKjBOfQHLyvxtoER1If/nBTHqTLsfdA2ZgLD0Gruon6Bn9qACTPsdG
	nEQvhPFAS7XFKd0IOY0E+3UvcbEv1Lg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742971807;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=laj/EhJ7jWdcyYdTlvjhEoV/kv6Zg6+tir35KJD6ti0=;
	b=18plpg2AEalPvbDg0RtDh1aV4c8Rfp1EDW6Co8TN7K/8724QazTMKQvbXooh4bWQudm/i8
	7KKifdLwjrXuibDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A08C13927;
	Wed, 26 Mar 2025 06:50:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bE6hCJ+j42fPMwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 26 Mar 2025 06:50:07 +0000
Date: Wed, 26 Mar 2025 07:50:06 +0100
Message-ID: <87iknwb80x.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: 1100928@bugs.debian.org,
	"C.D. MacEachern" <craig.daniel.maceachern@gmail.com>,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: Bug#1100928: [regression 6.1.y] microphone no longer records (on VivoBook_ASUSLaptop TP401MARB_J401MA)
In-Reply-To: <Z-MMsp3XJyNHOlma@eldamar.lan>
References: <174248253267.1718.4037292692790831697.reportbug@x>
	<Z95s5T6OXFPjRnKf@eldamar.lan>
	<Z-MMsp3XJyNHOlma@eldamar.lan>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 6772A1F391
X-Spam-Score: -2.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[bugs.debian.org,gmail.com,suse.de,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 25 Mar 2025 21:06:10 +0100,
Salvatore Bonaccorso wrote:
> 
> Hi Craig, all
> 
> On Sat, Mar 22, 2025 at 08:55:17AM +0100, Salvatore Bonaccorso wrote:
> > Control: tags -1 + moreinfo upstream
> > 
> > Hi
> > 
> > On Thu, Mar 20, 2025 at 10:55:32AM -0400, C.D. MacEachern wrote:
> > > Package: src:linux
> > > Version: 6.1.129-1
> > > Severity: important
> > > X-Debbugs-Cc: craig.daniel.maceachern@gmail.com
> > > 
> > > Dear Maintainer,
> > > 
> > > After update to kernel image 6.1.0-32 on Debian bookworm my builtin microphone
> > > would no longer record
> > > anything - no levels detected and I checked for muted channels with tools like
> > > pavucontrol and alsamixer.
> > > 
> > > I found that my microphone was using the `snd_hda_intel` driver in the kernel,
> > > so tried rebooting and choosing
> > > the 6.1.0-31 kernel instead to rule out hardware issue. Previous kernel works
> > > as expected, mic records and playback
> > > is fine, so some update related to this driver, or the driver itself was
> > > updated and no longer works correctly with
> > > the builtin microphone.
> > 
> > Thanks for reproting the issue (leaving boot log context, hw used,
> > below for context).
> > 
> > I think this might be introduced with 3b4309546b48 ("ALSA: hda: Fix
> > headset detection failure due to unstable sort") wich landed as well
> > in 6.1.129.
> > 
> > If you revert that commit on top of 6.1.129, does that fixes your
> > issue? Would you be able to test this?
> > 
> > #regzbot introduced: v6.1.128..v6.1.129
> > #regzbot link: https://bugs.debian.org/1100928
> > 
> > The solution might be similar to c6557ccf8094 ("ALSA: hda/realtek: Fix
> > microphone regression on ASUS N705UD") from 6.14-rc5 (which got
> > backported to 6.13.6, 6.12.18, 6.6.81 but not yet 6.1.y).
> 
> In case you need help in trying a kernel build with the revet applied,
> I'm attaching the revert patch. With that you can follow
> https://kernel-team.pages.debian.net/kernel-handbook/ch-common-tasks.html#id-1.6.6.4
> to build a kernel using the `test-patches` helper script to test with.
> 
> Is that enough help so we can confirm the breaking commit?
> 
> Kuan-Wei Chiu, Takashi Iwai any input on our issue?

Please give alsa-info.sh outputs from both working and non-working
kernels.  Run the script with --no-upload option and attach the
outputs.


thanks,

Takashi

