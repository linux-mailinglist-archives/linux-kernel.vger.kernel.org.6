Return-Path: <linux-kernel+bounces-254959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 923229339C7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44A1A1F226DF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C2439FEB;
	Wed, 17 Jul 2024 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DPJ73xBr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nq6a81xg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DPJ73xBr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nq6a81xg"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0A39445
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 09:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721208317; cv=none; b=l7zNyJvR7HuI+wC1GhIQLAOrvtGsoRzRlpVbta7IBWSrmeSmnbDgdDgNik1qnZHW43UtABwcrvz0s6uSMQme2cJjL/5PatweiLCUH1BEf/K3ZW3kYbAMV0mUM7PsfXtLYqB9XjX3ZJsoNQkkfLMwqEvZYu2piDxZYnlPxkjnDIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721208317; c=relaxed/simple;
	bh=GSeA4PcrdkP6SJWYfJVHD1jiIOgZl3XKc2jY4obLw4k=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AjQJfQ6D6vrGuXTr/BnBDdTMaXtEreOEazurPCuGfjKYZnRAg6cDi56UgxOMy0UFMpzsa2OlyikmCCR8CN+zC2hTb9IYw93OaTdI8+uIjt93Xk0nQ6tew4hC5VWgF2bqJJxN66S0G1bVhyMv/OgkkguO1Ca0nNg/55Dc9pWTeMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DPJ73xBr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nq6a81xg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DPJ73xBr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nq6a81xg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7135221AD1;
	Wed, 17 Jul 2024 09:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721208313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VmNCkLtrjI+fG5BWtot2mLs+buqGfR+f5WECiw7z6xw=;
	b=DPJ73xBr4gGkyARfcnUrOKT6aP9aH8BISgFqvA/qx8WjtfcVDwSZ/A59mRX+znKADqp4aR
	+QKLMu37ceYMKMdEOszElbZyo+oNU6Eu2G4SzbPKhYmf3eSfX9VEbQ6nmstb+60IcW0Ia/
	V3TYmn65q6QK4HbMoFNv3sgZgqlA7bk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721208313;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VmNCkLtrjI+fG5BWtot2mLs+buqGfR+f5WECiw7z6xw=;
	b=nq6a81xgMgSEYZaqc2YKb0IvdncZ3D5mP2JFKLS3bN4mnTEfzkBo6SCV+22agDw2gtRFkt
	kqKl8nbDk8c1jHBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721208313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VmNCkLtrjI+fG5BWtot2mLs+buqGfR+f5WECiw7z6xw=;
	b=DPJ73xBr4gGkyARfcnUrOKT6aP9aH8BISgFqvA/qx8WjtfcVDwSZ/A59mRX+znKADqp4aR
	+QKLMu37ceYMKMdEOszElbZyo+oNU6Eu2G4SzbPKhYmf3eSfX9VEbQ6nmstb+60IcW0Ia/
	V3TYmn65q6QK4HbMoFNv3sgZgqlA7bk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721208313;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VmNCkLtrjI+fG5BWtot2mLs+buqGfR+f5WECiw7z6xw=;
	b=nq6a81xgMgSEYZaqc2YKb0IvdncZ3D5mP2JFKLS3bN4mnTEfzkBo6SCV+22agDw2gtRFkt
	kqKl8nbDk8c1jHBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33CE4136E5;
	Wed, 17 Jul 2024 09:25:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0r1wC/mNl2a7JQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 17 Jul 2024 09:25:13 +0000
Date: Wed, 17 Jul 2024 11:25:45 +0200
Message-ID: <87sew8xtd2.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: wangdicheng <wangdich9700@163.com>
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-arm-kernel@lists.infradead.org,
	wangdicheng <wangdicheng@kylinos.cn>
Subject: Re: [PATCH] ALSA: usb-audio: Fix microphone sound on HD webcam.
In-Reply-To: <20240717091951.11344-1-wangdich9700@163.com>
References: <20240717091951.11344-1-wangdich9700@163.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,perex.cz,suse.com,vger.kernel.org,alsa-project.org,lists.infradead.org,kylinos.cn];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Wed, 17 Jul 2024 11:19:51 +0200,
wangdicheng wrote:
> V1 -> V2: align the space

Please put "v2" in the subject, i.e. "[PATCH v2] ALSA: ..."

> --- a/sound/usb/quirks.c
> +++ b/sound/usb/quirks.c
> @@ -2179,6 +2179,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
>  		   QUIRK_FLAG_FIXED_RATE),
>  	DEVICE_FLG(0x1bcf, 0x2283, /* NexiGo N930AF FHD Webcam */
>  		   QUIRK_FLAG_GET_SAMPLE_RATE),
> +	DEVICE_FLG(0x1bcf, 0x2281, /* HD Webcam */
> +		   QUIRK_FLAG_GET_SAMPLE_RATE),
>  
>  	/* Vendor matches */
>  	VENDOR_FLG(0x045e, /* MS Lifecam */

This still doesn't to apply the latest code cleanly.
You must be using an old kernel code.  There was rearrangement of the
table entries in the commit 668abe6dc7b6, and this has been backported
to some stable kernels as well.

Please try to rebase to the latest code.


thanks,

Takashi

