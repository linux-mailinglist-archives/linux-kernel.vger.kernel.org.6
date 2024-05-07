Return-Path: <linux-kernel+bounces-171269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8F38BE204
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FC69289B40
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8138D15DBCE;
	Tue,  7 May 2024 12:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nHGf+pT/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VbbVc2ek";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nHGf+pT/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VbbVc2ek"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4670E158D6D;
	Tue,  7 May 2024 12:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715084607; cv=none; b=uNlh/R8oaPxnatvXDzmervj/MfTPeV0BroCSivkPFdLpWKLlBbb92OA/vJDiiPtXaU6WzioDHFO65s7sg9ONj0umhKZWa5z8060qj4talYs8HUB7QUToQrrzo3yeY8FiMbxm0z4I5788+ImgYal8em/7duLxJLT9lsTTvYHEQr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715084607; c=relaxed/simple;
	bh=2jFVexOgDEd4e1eXCSwvP7UB75DW2FjYVEgTn+wjHEA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mFQ+fFP+IG3xzLHJxYpAYcgwM7GKvpIqYj/K9ajS2Eq6Qgui5bp7NOnodvSCkHpWXyMS/y0GGvoY968EFNHyzNME/WupB/WFvZvZGtvf6hIXDk7JfVwaQJl/HY6BhAVCkV44Ejif6BXiNi32TYZpgkQZ+mTvARyA8snXU1+pEwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nHGf+pT/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VbbVc2ek; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nHGf+pT/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VbbVc2ek; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5229833E6C;
	Tue,  7 May 2024 12:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715084604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HB9vSZXCYjKZxq7x1waJdJomxVN3F/dasGNZHwiylVo=;
	b=nHGf+pT/d5ghnLrHlEuONJ0yTuxo1fkZwdGtC9BBcEhKSV/KoGxK+EilrO6Sv5E9limwDc
	MwicSK3aU0roKNWJX0CC6s3iF3/GZ6ZFPqjy6yoArWF3YCSrKJ5aJLPjgkuJXLCMAcS36/
	3IiX2g+jcudNWYaMrQMLcsk212eh0pU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715084604;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HB9vSZXCYjKZxq7x1waJdJomxVN3F/dasGNZHwiylVo=;
	b=VbbVc2ek/x0uJe85ay27tmyFBIJVoL2NSakUAExZgt8VGh3ccqeoJPcqFbzFgKTw7dLpPU
	Hw7HI3/k1S+6cgBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715084604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HB9vSZXCYjKZxq7x1waJdJomxVN3F/dasGNZHwiylVo=;
	b=nHGf+pT/d5ghnLrHlEuONJ0yTuxo1fkZwdGtC9BBcEhKSV/KoGxK+EilrO6Sv5E9limwDc
	MwicSK3aU0roKNWJX0CC6s3iF3/GZ6ZFPqjy6yoArWF3YCSrKJ5aJLPjgkuJXLCMAcS36/
	3IiX2g+jcudNWYaMrQMLcsk212eh0pU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715084604;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HB9vSZXCYjKZxq7x1waJdJomxVN3F/dasGNZHwiylVo=;
	b=VbbVc2ek/x0uJe85ay27tmyFBIJVoL2NSakUAExZgt8VGh3ccqeoJPcqFbzFgKTw7dLpPU
	Hw7HI3/k1S+6cgBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3748A13A2D;
	Tue,  7 May 2024 12:23:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hYjLDDwdOmYpEQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 07 May 2024 12:23:24 +0000
Date: Tue, 07 May 2024 14:23:38 +0200
Message-ID: <87o79herp1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Junhao Pei <ArcticLampyrid@outlook.com>
Cc: tiwai@suse.de,
	sbinding@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	rf@opensource.cirrus.com
Subject: Re: [PATCH v4 0/1] ALSA: hda/realtek: Fix internal speakers for Legion Y9000X 2022 IAH7
In-Reply-To: <TYCP286MB2535E8C7B2F9E7EDD75C4382C41C2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB2535E8C7B2F9E7EDD75C4382C41C2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.26 / 50.00];
	BAYES_HAM(-2.96)[99.81%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[outlook.com];
	FREEMAIL_ENVRCPT(0.00)[outlook.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -3.26
X-Spam-Flag: NO

On Mon, 06 May 2024 10:09:27 +0200,
Junhao Pei wrote:
> 
> This fixes the sound not working from internal speakers on
> Lenovo Legion Y9000X 2022 IAH7 models.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218744
> 
> This patch depends on [PATCH v1 1/2] ALSA: hda: cs35l41: Ignore errors when configuring IRQs (by Stefan Binding)
> See also <https://lore.kernel.org/lkml/20240429154853.9393-2-sbinding@opensource.cirrus.com/>
> 
> Change from v3 <https://lore.kernel.org/lkml/TYCP286MB25357A4599E935F26A8AAB24C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM/T/>:
> - Remove the patch for cs35l41 to obey the trigger type from DSDT, for it is rarely used, and
>   the existing samples (Y9000X 2022 IAH7) has wrong trigger type in DSDT, which makes this change
>   useless.
> - Instead, ignore errors when configuring interrupts to allow laptops with bad ACPI to play audio.
>   (via a patch from Stefan Binding)
> 
> Change from v2 <https://lore.kernel.org/lkml/TYCP286MB253523D85F6E0ECAA3E03D58C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM/T/>:
> - Correct spkid gpio index.
> 
> Change from v1 <https://lore.kernel.org/lkml/TYCP286MB25352F3E995FED9CCE90F1F6C40B2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM/T/>:
> - Add a patch for cs35l41 to obey the trigger type from DSDT.
> - Avoid disabling interupts for second amps.
> 
> Junhao Pei (1):
>   ALSA: hda/realtek: Fix internal speakers for Legion Y9000X 2022 IAH7

Applied to for-next branch now.  Thanks.


Takashi

