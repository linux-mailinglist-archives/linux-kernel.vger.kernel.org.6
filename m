Return-Path: <linux-kernel+bounces-172870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BE88BF7E5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52EE8B22BB6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 08:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BC43D56D;
	Wed,  8 May 2024 07:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rjCDVSP8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lRPKv5tv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Xalq40C6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="S+Hsa4KB"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A05C446D5;
	Wed,  8 May 2024 07:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715155192; cv=none; b=WIo6cp527+OcfI9zYNPmz04SRM1whIkFXW9pvRxN5UpVUTHmQOw31Knih/YqWPIr1ar0xAeC8v8qsARqZ2Z0yEuhRC+dIILL2mSQvD0gn1hrbESnD0VsLsdGUUe/D016q49BUJQ2+0cuHgdjAyZv9MPejnCnEaFtqV0cu3MOOkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715155192; c=relaxed/simple;
	bh=nyFUsn33fu6w3Dq2tThtIx+Tar0ws9XIjnC+K+ffTM0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RyizUPOWwlvVsHghh1OmeHwZpXB7jEGd6oN/u0OqFsOpsLypoCBF5m+uaUxnsg0auBS93nWUbh8FL4lkMeJNiB4UVtMfguhR9PlU2M9N1JrOD0YgnglPIzJ2hgDKZ6JtCrAn0hM8tEfyynlpuov07Kbdn740C7lwxd3SVO8vAnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rjCDVSP8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lRPKv5tv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Xalq40C6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=S+Hsa4KB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 51F3A5C5D4;
	Wed,  8 May 2024 07:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715155188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+acEQVNqIiwbVXsDV+TxFfEtUIJ9v6I36NrbpwrULAE=;
	b=rjCDVSP85OBwgr44x2G+faH5cuUUNskqCDC95mMk70pG+jo6i/taCd3TWU+rq8/0EmKhRs
	ccOdeiMZPeISFcONIMxzJz2dotzU7TfNuMBLXmuhDU37IUjqeam75bM5Kk8RdcMlDlvu3H
	xR/81opXbltxOVB5QnDULaqqwUB/ZQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715155188;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+acEQVNqIiwbVXsDV+TxFfEtUIJ9v6I36NrbpwrULAE=;
	b=lRPKv5tvP5QuFyEune7EqeCEwyfVB++Qm7H7ZGAmA6e9UKYBOBeAWR4NjTBBaJfROwVgCk
	i1hYVy7tiNlMyODw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715155187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+acEQVNqIiwbVXsDV+TxFfEtUIJ9v6I36NrbpwrULAE=;
	b=Xalq40C6nkkyN6rvtSbUwxPmgHIhDq+qPd8vvRWoSmqx5gl04cTaX8lRWE10XP1vgVbwev
	MEJnv3XBkdC4DF9sRYYdy69fE33kHJp8H90yd+g+gydZitp5fjBL2r3lg1K6RrJ8TQ201A
	Oe+9rfgbghChVLpLjwvQ7oESfwwA1Yc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715155187;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+acEQVNqIiwbVXsDV+TxFfEtUIJ9v6I36NrbpwrULAE=;
	b=S+Hsa4KBlZwbFsXPOls6mL8S+idkRdYaHCQwmJZPtRGX48QBly/761Dx15WVpG/QQ3mbnk
	VqftFVNtuK2mhaBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 141E51386E;
	Wed,  8 May 2024 07:59:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5OvJA/MwO2YYfQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 08 May 2024 07:59:47 +0000
Date: Wed, 08 May 2024 10:00:02 +0200
Message-ID: <87o79gd98d.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Stefan Binding <sbinding@opensource.cirrus.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	<alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH v1] ALSA: hda/realtek: Add support for ASUS Zenbook 2024 HN7306W
In-Reply-To: <20240507160131.356114-1-sbinding@opensource.cirrus.com>
References: <20240507160131.356114-1-sbinding@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.29 / 50.00];
	BAYES_HAM(-2.99)[99.95%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -3.29
X-Spam-Flag: NO

On Tue, 07 May 2024 18:01:31 +0200,
Stefan Binding wrote:
> 
> This laptop uses CS35L41 HDA with 2 amps using I2C and Internal Boost.
> 
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>

Thanks, applied.


Takashi

