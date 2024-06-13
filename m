Return-Path: <linux-kernel+bounces-213083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C9B906AE0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8213B286D88
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAE5143725;
	Thu, 13 Jun 2024 11:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uyt8bPUx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bSqdLiXB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uyt8bPUx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bSqdLiXB"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AEA13C9DE;
	Thu, 13 Jun 2024 11:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718277620; cv=none; b=Kwa55iAOm5Yg6qh+mkZeCLflxIMv4eY4UYPBHtagUcw9TB0kGAegd4Fmi7eMPdIZgsGgrztUxdYftBoNwp2ZoxWa7sQrrZIpFmdtQtfZbvnu/S3CJgffXebSgjPlV3mntKwo6kUdtKht2fRDHbQdUqvLurM7OTYj6ztSY2Fo3A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718277620; c=relaxed/simple;
	bh=WyIdasgc4uiJGg5laTQoeL5mSzMxOocQZuY9gYG05Z4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yp9ET4/RATL5SJFskwcD1Af/m/37GmWP/kloJ/wpyaauneONSIsxSfEI1prOV8AS4L/Ip9YLxygYod+6BKvePdLN9YyY4hq4FyDvZyJFutIIUmbOnygRlHL3q5z3FpRslNwN+bUlBS+rqkzMtz2x81ldr6ZWGrnRs4rtYAe2gkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uyt8bPUx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bSqdLiXB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uyt8bPUx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bSqdLiXB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1E52A35317;
	Thu, 13 Jun 2024 11:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718277617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kf3+0R9NdX4IckkSTlV1RU1cwXOmSIch1pBOXHTjlL4=;
	b=uyt8bPUx6PTKtJYBmVEgSx5A41nN4XBM125/CnFAsPAk13PmIlaYCMa/kYu3SLfElOnFOG
	H5adLQb/ucP9NVuIqT27htG1mYy88/BImzwblAnsrs3MmKti3xmhWA1dCGxiIjyMiMOZ08
	Evmi4Bh4lNojlCP4jdOXAOfGGRVYaO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718277617;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kf3+0R9NdX4IckkSTlV1RU1cwXOmSIch1pBOXHTjlL4=;
	b=bSqdLiXBbxE52Lc3+L/7+k0NvRtaC0JkvQnQy1ipUq30yniaQngrqHVOQ9SH2aypHDrNZ4
	Nuh2QyBqsRIfTTAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uyt8bPUx;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bSqdLiXB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718277617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kf3+0R9NdX4IckkSTlV1RU1cwXOmSIch1pBOXHTjlL4=;
	b=uyt8bPUx6PTKtJYBmVEgSx5A41nN4XBM125/CnFAsPAk13PmIlaYCMa/kYu3SLfElOnFOG
	H5adLQb/ucP9NVuIqT27htG1mYy88/BImzwblAnsrs3MmKti3xmhWA1dCGxiIjyMiMOZ08
	Evmi4Bh4lNojlCP4jdOXAOfGGRVYaO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718277617;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kf3+0R9NdX4IckkSTlV1RU1cwXOmSIch1pBOXHTjlL4=;
	b=bSqdLiXBbxE52Lc3+L/7+k0NvRtaC0JkvQnQy1ipUq30yniaQngrqHVOQ9SH2aypHDrNZ4
	Nuh2QyBqsRIfTTAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C040A13A87;
	Thu, 13 Jun 2024 11:20:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CjeGLfDVama2EgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 13 Jun 2024 11:20:16 +0000
Date: Thu, 13 Jun 2024 13:20:40 +0200
Message-ID: <87msnpnl6f.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
Cc: tiwai@suse.com,
	perex@perex.cz,
	sbinding@opensource.cirrus.com,
	kailang@realtek.com,
	luke@ljones.dev,
	shenghao-ding@ti.com,
	simont@opensource.cirrus.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Limit mic boost on N14AP7
In-Reply-To: <20240605153923.2837-1-edson.drosdeck@gmail.com>
References: <20240605153923.2837-1-edson.drosdeck@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 1E52A35317
X-Spam-Score: -2.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.00 / 50.00];
	BAYES_HAM(-2.99)[99.93%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Wed, 05 Jun 2024 17:39:23 +0200,
Edson Juliano Drosdeck wrote:
> 
> The internal mic boost on the N14AP7 is too high. Fix this by applying the
> ALC269_FIXUP_LIMIT_INT_MIC_BOOST fixup to the machine to limit the gain.
> 
> Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>

Thanks, applied now.


Takashi

