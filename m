Return-Path: <linux-kernel+bounces-281802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CC294DB81
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 10:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C5B282808
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 08:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0116A14BF87;
	Sat, 10 Aug 2024 08:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hvMyslfl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="twiaINLH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hvMyslfl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="twiaINLH"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F7D24B2F
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 08:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723279258; cv=none; b=WnnDwGbnqzCZPuyCU7/Kb97hHk3ceZiv+jhHffa51UPGisNZd7+vsMS+JUyP7gyUO6zQB70Ts2fAACZydrBiiVIvwuy2YbDG/I95AusxJ/ogOv/yXAElI10I02ew/5zrnH/O8Kw7CQk7EtmsDQD6nl0IRWjrARyMXWEmJbWUNM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723279258; c=relaxed/simple;
	bh=zT5rASv96Ev8n9CddTVeF1TAdQH7tDQYlH/IQ8smeuo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VaN/qqne8ckv9LynWtXmG5+3OlvASBFlslnGioKaa9HR4KRH1WU/2cekNBCBVmFBXjhXHs7/BdkwiC0Iploz7RB/QTZVhZrPE3Ry+LH+SsXwra4r6eeansgQ9jE5qbS2HPIwe4n1Z1SCQ81T5GBqaq6nqm++QG+1oFUnq5izOCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hvMyslfl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=twiaINLH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hvMyslfl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=twiaINLH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B7F69220E0;
	Sat, 10 Aug 2024 08:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723279254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JOlgF9chdSFGs3DgiXE9oTOri2EHGPEGhgk4hioJWuk=;
	b=hvMyslfl1Oe1tI1q7bQBtBd3LHUe8KIm0hQU618WeXvPxVIsct/+tlF6Hn66KzO2jXJED1
	etjr1czhUcMEn2TLUXOQVzLf58UwgRLxpDAgTGF0FNrFXVLYgMOTKGszugJzFeZDTzcVIG
	KFpinlXggNhdo0DBinz0/nNqLHRUuZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723279254;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JOlgF9chdSFGs3DgiXE9oTOri2EHGPEGhgk4hioJWuk=;
	b=twiaINLHiatdKiMDBzGlMbjAu+R6EdysgaDWY9WtiebRK0SlrdFODd3EM5eEHBmU/C7tC6
	nXke1zuo+a+Sq3Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723279254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JOlgF9chdSFGs3DgiXE9oTOri2EHGPEGhgk4hioJWuk=;
	b=hvMyslfl1Oe1tI1q7bQBtBd3LHUe8KIm0hQU618WeXvPxVIsct/+tlF6Hn66KzO2jXJED1
	etjr1czhUcMEn2TLUXOQVzLf58UwgRLxpDAgTGF0FNrFXVLYgMOTKGszugJzFeZDTzcVIG
	KFpinlXggNhdo0DBinz0/nNqLHRUuZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723279254;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JOlgF9chdSFGs3DgiXE9oTOri2EHGPEGhgk4hioJWuk=;
	b=twiaINLHiatdKiMDBzGlMbjAu+R6EdysgaDWY9WtiebRK0SlrdFODd3EM5eEHBmU/C7tC6
	nXke1zuo+a+Sq3Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76EC913704;
	Sat, 10 Aug 2024 08:40:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aPHFGpYnt2azJAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 10 Aug 2024 08:40:54 +0000
Date: Sat, 10 Aug 2024 10:41:34 +0200
Message-ID: <87a5hklqgx.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Norman Bintang <normanbt@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	broonie@kernel.org,
	alsa-devel@alsa-project.org,
	Takashi Iwai <tiwai@suse.com>,
	cujomalainey@chromium.org,
	Chih-Yang Hsia <paulhsia@chromium.org>,
	David Riley <davidriley@chromium.org>
Subject: Re: [PATCH] ALSA: pcm: Add xrun counter for snd_pcm_substream
In-Reply-To: <20240809140648.3414349-1-normanbt@chromium.org>
References: <20240809140648.3414349-1-normanbt@chromium.org>
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
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
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
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Fri, 09 Aug 2024 16:06:45 +0200,
Norman Bintang wrote:
> 
> This patch adds an xrun counter to snd_pcm_substream as an alternative
> to using logs from XRUN_DEBUG_BASIC. The counter provides a way to track
> the number of xrun occurences, accessible through the /proc interface.
> 
> The counter is enabled when CONFIG_SND_PCM_XRUN_DEBUG is set.
> 
> Example output:
> 
> $ cat /proc/asound/card0/pcm9p/sub0/status
> 
> owner_pid   : 1425
> trigger_time: 235.248957291
> tstamp      : 0.000000000
> delay       : 1912
> avail       : 480
> avail_max   : 1920
> -----
> hw_ptr      : 672000
> appl_ptr    : 673440
> xrun_counter: 3  # (new row)
> 
> Signed-off-by: Norman Bintang <normanbt@chromium.org>
> Reviewed-by: Chih-Yang Hsia <paulhsia@chromium.org>
> Tested-by: Chih-Yang Hsia <paulhsia@chromium.org>
> Reviewed-by: David Riley <davidriley@chromium.org>

Applied to for-next branch.  Thanks.


Takashi

