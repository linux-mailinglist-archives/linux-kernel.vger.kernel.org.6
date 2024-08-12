Return-Path: <linux-kernel+bounces-282709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF8D94E7B9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFDD71C21966
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9E6158203;
	Mon, 12 Aug 2024 07:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nxdPnQJL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tHALmea+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nxdPnQJL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tHALmea+"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6AE5FBB7;
	Mon, 12 Aug 2024 07:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723447571; cv=none; b=qT1dYI5K5N/kskNUzwIrS9lTdaXRssxsrDlQPqb5qS3akK810phTAOVOdwFzCuArAAeRUaRcn8AonDzffrHojzeVUeDXRFabrCQwJt60nMp90PRoDkov3V8X/jSY7RN2E/Eh/hR7kAwz/BWPaq7tEKGxsc7y45AKP+m53g5EQyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723447571; c=relaxed/simple;
	bh=e4iG/Rv2hmbafwDzq0zo4JgOtrUeSZzZPoEnbxQKspw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Smm5L76j0LhFrNf9Umku52GAhYjRS4Izq04kYPc65MYvXuNMXGLKaq1t4epb/3hHgjxVm5mc9KC2RrUqVDk+wa3dxCaTlBZYVdt0wKKaf8AJDq56CtqUONa5t9S+SPq/GMA+1JU6z3mQ+t5C/uNlSNvAnqKc/9MJ2a7g6dMJVoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nxdPnQJL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tHALmea+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nxdPnQJL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tHALmea+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7CE532022C;
	Mon, 12 Aug 2024 07:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723447566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6XPo09EObUeV+exTTCamgWy1ozO+qtvAX7oaVDoIEGY=;
	b=nxdPnQJLeSibhsbzX61UBYq6xMRjEGLrVs1gtqlMODk09dSjOcuqq7ryf0ntum+l+0k0kK
	4IfuaLGR8uzK+xZ7nGuGgDD0NGyfS0Qr6+AGrsbmG+tOoRI3rMj5rl2iIpT6FpgywPHBvA
	0MX3h4hMWfGpuyHyn5hPTZowM4JOcyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723447566;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6XPo09EObUeV+exTTCamgWy1ozO+qtvAX7oaVDoIEGY=;
	b=tHALmea+jAACss2DZPv4BPnTKhr3LP5HsbbYZUUUbuxBSXhb3tLaiM4i5sOSjf7zcmusK2
	TOluQBarsNrqoBBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nxdPnQJL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tHALmea+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723447566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6XPo09EObUeV+exTTCamgWy1ozO+qtvAX7oaVDoIEGY=;
	b=nxdPnQJLeSibhsbzX61UBYq6xMRjEGLrVs1gtqlMODk09dSjOcuqq7ryf0ntum+l+0k0kK
	4IfuaLGR8uzK+xZ7nGuGgDD0NGyfS0Qr6+AGrsbmG+tOoRI3rMj5rl2iIpT6FpgywPHBvA
	0MX3h4hMWfGpuyHyn5hPTZowM4JOcyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723447566;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6XPo09EObUeV+exTTCamgWy1ozO+qtvAX7oaVDoIEGY=;
	b=tHALmea+jAACss2DZPv4BPnTKhr3LP5HsbbYZUUUbuxBSXhb3tLaiM4i5sOSjf7zcmusK2
	TOluQBarsNrqoBBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DCD5137BA;
	Mon, 12 Aug 2024 07:26:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WZcRBg65uWZRDQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 12 Aug 2024 07:26:06 +0000
Date: Mon, 12 Aug 2024 09:26:46 +0200
Message-ID: <87frra2ocp.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jonathan LoBue <jlobue10@gmail.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	shenghao-ding@ti.com,
	kailang@realtek.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	derekjohn.clark@gmail.com,
	luke@ljones.dev,
	benato.denis96@gmail.com,
	Kyle Gospodnetich <me@kylegospodneti.ch>,
	Jan Drogehoff <sentrycraft123@gmail.com>,
	Antheas Kapenekakis <lkml@antheas.dev>,
	Richard Alvarez <alvarez.richard@gmail.com>,
	Miles Montierth <cyber_dopamine@intheblackmedia.com>
Subject: Re: [PATCH] ALSA: hda/realtek: tas2781: Fix ROG ALLY X audio
In-Reply-To: <20240812045325.47736-1-jlobue10@gmail.com>
References: <20240812045325.47736-1-jlobue10@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.01 / 50.00];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[16];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,ti.com,realtek.com,alsa-project.org,vger.kernel.org,gmail.com,ljones.dev,kylegospodneti.ch,antheas.dev,intheblackmedia.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -1.01
X-Rspamd-Queue-Id: 7CE532022C

On Mon, 12 Aug 2024 06:53:25 +0200,
Jonathan LoBue wrote:
> 
> This patch enables the TI TAS2781 amplifier SoC for the ASUS ROG ALLY X.
> This is a design change from the original ASUS ROG ALLY, creating the need
> for this patch. All other Realtek Codec settings seem to be re-used from
> the original ROG ALLY design (on the ROG ALLY X). This patch maintains the
> previous settings for the Realtek codec portion, but enables the I2C
> binding for the TI TAS2781 amplifier (instead of the Cirrus CS35L41 amp
> used on the original ASUS ROG ALLY).
> 
> One other requirement must be met for audio to work on the ASUS ROG ALLY X.
> A proper firmware file in the correct location with a proper symlink. We
> had reached out to TI engineers and confirmed that the firmware found in
> the Windows' driver package has a GPL license. Bazzite Github is hosting
> this firmware file for now until proper linux-firmware upstreaming can
> occur. https://github.com/ublue-os/bazzite
> 
> This firmware file should be placed in
> /usr/lib/firmware/ti/tas2781/TAS2XXX1EB3.bin with a symlink to it from
> /usr/lib/firmware/TAS2XXX1EB3.bin
> 
> Co-developed by: Kyle Gospodnetich <me@kylegospodneti.ch>
> Signed-off-by: Kyle Gospodnetich <me@kylegospodneti.ch>
> Co-developed by: Jan Drogehoff <sentrycraft123@gmail.com>
> Signed-off-by: Jan Drogehoff <sentrycraft123@gmail.com>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> Tested-by: Richard Alvarez <alvarez.richard@gmail.com>
> Tested-by: Miles Montierth <cyber_dopamine@intheblackmedia.com>
> Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>

Applied to for-next branch.

Meanwhile, could you ask TI guys to include the missing firmware files
in linux-firmware git tree, too?


thanks,

Takashi

