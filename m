Return-Path: <linux-kernel+bounces-187079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2AB8CCCD4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AF651C211E6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 07:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E2613C9C7;
	Thu, 23 May 2024 07:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ncz3E3Jf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4XjMnnbI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ncz3E3Jf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4XjMnnbI"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761833B29D;
	Thu, 23 May 2024 07:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716448698; cv=none; b=mP6c5CYr1DXCX2dgkCWVAxrqYZpcflCQ6WLNoepPTYg0b3oUpA9CHNK84QoTv6mmdJesFbVblGmv5KL63eQTBbq1DGLsjvnWbeD/F6tDTao72ZfMEnLxqRa8OhwEwiIWqWMwSLwKhUg/HQj+UwXsR8RzQRGPeS9hPWE7eFM+JWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716448698; c=relaxed/simple;
	bh=eW1g5x920VyrEE3W8JHEFUtHNlejKcpRIqrD03GNb6c=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lqVO+a32NIXGrwT7/QpXSFp09Pmc1DDgOVHZCTxxwjQh9uJCjMAbdPj3jvaZDp7hHqhYNk4W6Md/aiUxU2nqPBkJnuKWS45+uxxOvjnuvjgcKiPKs+9EWWMUmCrNxN/wZTnaKnjEoewN3DoEQxKRjRE5UZge4yTuFtq33bPbyrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ncz3E3Jf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4XjMnnbI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ncz3E3Jf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4XjMnnbI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 836901FF90;
	Thu, 23 May 2024 07:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716448695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9C3+Zvv/jEllbJWgFoIJayK9mlGR5eL5wYtye4uFvQ8=;
	b=ncz3E3JfVgGAcXOzveAm0cGuOibd6lBaPRZ+Kva3ZvZXwJs6LVcb1MVJeKckDQbMwxeV6V
	4twBxYc8Q1GIxsGQsPQEOCOdPtD5V6j3VWYFsY87kUx4ZYobzFeL0/QbPxO7Fn0La+EK1i
	QqHZ8BdTwrjTzvrTJFFXgvYA5nBHENw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716448695;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9C3+Zvv/jEllbJWgFoIJayK9mlGR5eL5wYtye4uFvQ8=;
	b=4XjMnnbI7kg30XV7dOTF4zgD+0fibaWaJ+8tAC2zDHvBoYaFvhNRsKOTZ7i6rXR6X/WNux
	f/q47ptfyrcMciAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716448695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9C3+Zvv/jEllbJWgFoIJayK9mlGR5eL5wYtye4uFvQ8=;
	b=ncz3E3JfVgGAcXOzveAm0cGuOibd6lBaPRZ+Kva3ZvZXwJs6LVcb1MVJeKckDQbMwxeV6V
	4twBxYc8Q1GIxsGQsPQEOCOdPtD5V6j3VWYFsY87kUx4ZYobzFeL0/QbPxO7Fn0La+EK1i
	QqHZ8BdTwrjTzvrTJFFXgvYA5nBHENw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716448695;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9C3+Zvv/jEllbJWgFoIJayK9mlGR5eL5wYtye4uFvQ8=;
	b=4XjMnnbI7kg30XV7dOTF4zgD+0fibaWaJ+8tAC2zDHvBoYaFvhNRsKOTZ7i6rXR6X/WNux
	f/q47ptfyrcMciAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E4E113A6C;
	Thu, 23 May 2024 07:18:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fEYPCrftTmaKVQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 23 May 2024 07:18:15 +0000
Date: Thu, 23 May 2024 09:18:35 +0200
Message-ID: <87msohatdg.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Andy Chi <andy.chi@canonical.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Kailang Yang <kailang@realtek.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Athaariq Ardhiansyah <foss@athaariq.my.id>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	linux-sound@vger.kernel.org (open list:SOUND),
	linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] ALSA: hda/realtek: fix mute/micmute LEDs don't work for ProBook 440/460 G11.
In-Reply-To: <20240523061832.607500-1-andy.chi@canonical.com>
References: <20240523061832.607500-1-andy.chi@canonical.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.23 / 50.00];
	BAYES_HAM(-2.93)[99.68%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.23
X-Spam-Flag: NO

On Thu, 23 May 2024 08:18:31 +0200,
Andy Chi wrote:
> 
> HP ProBook 440/460 G11 needs ALC236_FIXUP_HP_GPIO_LED quirk to
> make mic-mute/audio-mute working.
> 
> Signed-off-by: Andy Chi <andy.chi@canonical.com>

Thanks, applied.


Takashi

