Return-Path: <linux-kernel+bounces-358264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C21E997C50
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 07:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A16C1C21E46
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 05:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661B719DFA7;
	Thu, 10 Oct 2024 05:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CEXBRA3a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="G5rIzFPW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CEXBRA3a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="G5rIzFPW"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F23418CC0B;
	Thu, 10 Oct 2024 05:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728537410; cv=none; b=Hv1LZ7is0sRvVWt/fn2+GvwpZPTMExPMXIO3POrSX8Ix/k1tv9i/a7BoKiaaDTwLTRq6PLot5Myzo9+Hq2uKrO7CIytgCvsQMLUcoHKU9xMcld/b36WnACPYCIqoTzW89IesZsMZG4q7DU0U6hFqQjLcSwvsyYmYtcwHHimxc9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728537410; c=relaxed/simple;
	bh=cUaRAoeSoWcPfYQUZpUBNZt2vefDaVFvNB837NFDNaQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z60mdb1mQ+sFLPYUSvhcoDYxNS0T4pupDL0AorwibF+Z5BTQ5U9QblChSeYto2RX3jvk9TXSjRoyyG1KSswGaA5EHm9GGx7NCUSvOLxilkYPLwrpDbIu492O5SAzmgOTKCsDcAQuWpCeuvSAOZZ+LEl9E4XXt9iruV5GkZ91X1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CEXBRA3a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=G5rIzFPW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CEXBRA3a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=G5rIzFPW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 384CE1FDA7;
	Thu, 10 Oct 2024 05:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728537401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P15Jng6hSOUy2FPv/d+QMlSiHS1fJQ+d1J3po5m+H7o=;
	b=CEXBRA3aZNQx7ojzu91J86Y035dIeHQPtof5e0k0ER65YpHmJq6oYH0A77/m06p/GZ0h7m
	VATaKG/R+x5O+RyhQGvsCyf1ycqWSKHzbyGHp1jY7ja/5cZb6uDbjxuuNJVsxrcvUWybU/
	zjVqt7R2kvRTDxKQZzTszU2tRDXZDAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728537401;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P15Jng6hSOUy2FPv/d+QMlSiHS1fJQ+d1J3po5m+H7o=;
	b=G5rIzFPWmG9A8agsL4V3U7/Y+rZHiYMSy+AWjrpcCLtiVRAAl1I2aq7TLtxyg5z5SHb+0F
	9AuASicPW6qzADBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728537401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P15Jng6hSOUy2FPv/d+QMlSiHS1fJQ+d1J3po5m+H7o=;
	b=CEXBRA3aZNQx7ojzu91J86Y035dIeHQPtof5e0k0ER65YpHmJq6oYH0A77/m06p/GZ0h7m
	VATaKG/R+x5O+RyhQGvsCyf1ycqWSKHzbyGHp1jY7ja/5cZb6uDbjxuuNJVsxrcvUWybU/
	zjVqt7R2kvRTDxKQZzTszU2tRDXZDAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728537401;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P15Jng6hSOUy2FPv/d+QMlSiHS1fJQ+d1J3po5m+H7o=;
	b=G5rIzFPWmG9A8agsL4V3U7/Y+rZHiYMSy+AWjrpcCLtiVRAAl1I2aq7TLtxyg5z5SHb+0F
	9AuASicPW6qzADBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0C8B137CF;
	Thu, 10 Oct 2024 05:16:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S3E2OThjB2eoNQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 10 Oct 2024 05:16:40 +0000
Date: Thu, 10 Oct 2024 07:17:36 +0200
Message-ID: <87y12wsfin.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Kai-Heng Feng <kaihengf@nvidia.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Vasiliy Kovalev <kovalev@altlinux.org>,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bo liu <bo.liu@senarytech.com>
Subject: Re: [PATCH v2] ALSA: hda/conexant - Fix audio routing for HP EliteOne 1000 G2
In-Reply-To: <b0ac19a5-1d93-41a5-beaa-279939e8ebde@nvidia.com>
References: <20241009134248.662175-1-kovalev@altlinux.org>
	<87h69ltmgn.wl-tiwai@suse.de>
	<b0ac19a5-1d93-41a5-beaa-279939e8ebde@nvidia.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Thu, 10 Oct 2024 05:32:18 +0200,
Kai-Heng Feng wrote:
> 
> 
> On 2024/10/9 9:50 PM, Takashi Iwai wrote:
> > On Wed, 09 Oct 2024 15:42:48 +0200,
> > Vasiliy Kovalev wrote:
> >> 
> >> There is a problem with simultaneous audio output to headphones and
> >> speakers, and when headphones are turned off, the speakers also turn
> >> off and do not turn them on.
> >> 
> >> However, it was found that if you boot linux immediately after windows,
> >> there are no such problems. When comparing alsa-info, the only difference
> >> is the different configuration of Node 0x1d:
> >> 
> >> working conf. (windows): Pin-ctls: 0x80: HP
> >> not working     (linux): Pin-ctls: 0xc0: OUT HP
> >> 
> >> This patch disable the AC_PINCTL_OUT_EN bit of Node 0x1d and fixes the
> >> described problem.
> >> 
> >> Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
> > 
> > Thanks, applied now.
> 
> Though this is already applied, is it possible to see if the issue
> also happens on S4?
> 
> Linux doesn't put PCI devices like HDA to D3 during shutdown and
> reboot while Windows does, that might be the reason boot Linux after
> Windows can workaround the issue.
> 
> Linux does put PCI devices to D3 for hibernate (S4), so we can use it
> as an experiment.

Right, it should have been the cached version so that the setup is
reapplied automatically; i.e. replace snd_hda_set_pin_ctl() with
snd_hda_set_pin_ctl_cached().

Vasiliy, care to test and submit an incremental fix?


thanks,

Takashi

