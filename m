Return-Path: <linux-kernel+bounces-426567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E5F9DF50B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 09:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15FE3B211C1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 08:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCE612DD8A;
	Sun,  1 Dec 2024 08:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d9hMJ/PV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wM/QXLyE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rJcldgkm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CY3a9XI9"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9F46FD5;
	Sun,  1 Dec 2024 08:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733043128; cv=none; b=qk3LCl/4bw7z7m9/66g+Va73aSD1aUwY+CyEQojqyGaMBHU5V8O2uplcx8V+KdTpUtnz25JzaxhhOYcE9cswHXjuMKq/4ZW9g4aSJGvgAHGSkddQVjtf9yNtvazEocdFWTrVb31rzZn0Vr3guOO5eazl2fVGP69+yEUSEsywr2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733043128; c=relaxed/simple;
	bh=CAyguM1DSzeokMJloQ+itmnxxUMxAvTTxRz+3gb7REU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t72IbWBQSxBI2dTbMnHHpKVOAuT6r5dSuDsOF459SdOUHwtaAz8NSshzldl4GeIepy2nTDGypYIkhs8DFJv6+gebYXobkh/ejpWdFWadQPZKZogK647zok2pcX7nXt+k5WoNX3pK28tAkf81jvBeg/5SW5Tmp9umxJ9l+LNzBUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d9hMJ/PV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wM/QXLyE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rJcldgkm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CY3a9XI9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0802921183;
	Sun,  1 Dec 2024 08:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733043123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=InbJb7I8OR4chlQjQL0LZvVEHMiVRbAkpmktMf3VnvI=;
	b=d9hMJ/PV12mX3qTyceQWxYPM0iIsUT8cSrVgcN0x5T5R1QUAcYiZ83SRFUAOfs4p4dQK4+
	Fu8y7MguG8pzGhf8Jr4UEv0l2uuqQO7a/4CzVCpHq1N2S35ipNslw++t1hh4+610t09BR8
	coTFpg9Zj7tKGrLtS32sFM3oBI6g7gw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733043123;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=InbJb7I8OR4chlQjQL0LZvVEHMiVRbAkpmktMf3VnvI=;
	b=wM/QXLyEW4KCBZkb+odH2wPmbwHrf8+1KsLV0BiYgHAvKhCX0JhBdN6xoonMLcpzcIJfLt
	u7Z3GbDjtBiXJCDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rJcldgkm;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CY3a9XI9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733043122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=InbJb7I8OR4chlQjQL0LZvVEHMiVRbAkpmktMf3VnvI=;
	b=rJcldgkmLEoSNl7wiI2ySzHnU2NY++F48ag69zxvUWa8KGHp58LXs97l2o/Zo6JDh5z6ib
	bblDBayzbT5BXiJFV7JfqriMR2U3nVPzsg0nPRveBb1emfHIjxKIN/SnZE2MPRktCkX+Lu
	sSDKNsKKSg4IZhfwuEJ6Di+zroyD7QQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733043122;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=InbJb7I8OR4chlQjQL0LZvVEHMiVRbAkpmktMf3VnvI=;
	b=CY3a9XI9a6U5ehCJKPAAWV7oCA+EZN2CZ23Z7Jcbtjrg+qFJsy3WfZ4GRbdu+5Mo06te+Q
	GPt3QryaSm6zUTAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD12713974;
	Sun,  1 Dec 2024 08:52:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oIC+LLEjTGcKRwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 01 Dec 2024 08:52:01 +0000
Date: Sun, 01 Dec 2024 09:52:01 +0100
Message-ID: <87a5dfzsy6.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Baojun Xu <baojun.xu@ti.com>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] ALSA: hda/tas2781: Fix error code tas2781_read_acpi()
In-Reply-To: <ef773f8a-a61d-478b-9e81-41a38a75c77b@stanley.mountain>
References: <ef773f8a-a61d-478b-9e81-41a38a75c77b@stanley.mountain>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 0802921183
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,linaro.org:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, 30 Nov 2024 11:08:18 +0100,
Dan Carpenter wrote:
> 
> Return an error code if acpi_get_subsystem_id() fails.  Don't return
> success.
> 
> Fixes: 4e7035a75da9 ("ALSA: hda/tas2781: Add speaker id check for ASUS projects")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks, applied now.


Takashi

