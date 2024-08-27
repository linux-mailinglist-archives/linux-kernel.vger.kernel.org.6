Return-Path: <linux-kernel+bounces-302628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6A0960131
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 07:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364EF280BDB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 05:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB86132132;
	Tue, 27 Aug 2024 05:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YtoBu6i2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YXKcG0Eu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YtoBu6i2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YXKcG0Eu"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7095F2260C;
	Tue, 27 Aug 2024 05:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724737983; cv=none; b=uvLc2wjUpKJd4EqXALGHTQnsImfSLzTksZr2WWLDqxm3DHhmLyjSkac3OdGh1fWII7/0KXbU+BxX6Bvc2TegdKtP4MDvKQEjAfSECh7PoVvSt7MpGvlFq4tm0EWwuAlqqKZ53LPfcXvG40aGmMVpi4CVTxGROjy5X1smNYXWCRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724737983; c=relaxed/simple;
	bh=pl4c7h6INgfUNX2XD6vsgEE11FLBxWG1vx7R8FGrVcI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kr6dkYOdN2bV+YCH0E4rRmfPzsLhz6F12Q3ffDEyexH3tanC1bonvpaq3+Oklz7DJfF4wcf94dbe2J3sZoa68f30/a+RmQ3GpUdFy85955T+qBcb3tFa5NJu9fHkFNO55syqt+IuhvrcBMaVOgsoyL1+Ll5LJMfp3UuNYgsum4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YtoBu6i2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YXKcG0Eu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YtoBu6i2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YXKcG0Eu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 46F0721AFC;
	Tue, 27 Aug 2024 05:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724737979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YbyRpVQyzDYEEPLh9ZRLZD4ogKV9LDeaqbmK0A8SjRo=;
	b=YtoBu6i2DV6dE5lauEETwW8nn/hQ5jH9JhKEtPlA5SgpGIhfy+W2VmV30vdhqU3fCdIJG+
	iGKL3ivuRzfcYBFAyWrMoqaXewTW6bDyFCj/QYqsb3YosrJLDklkXEcliYpOyWFR/Xbemf
	ucjjiw00J8VWgw198BlzT8JfOwbwvnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724737979;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YbyRpVQyzDYEEPLh9ZRLZD4ogKV9LDeaqbmK0A8SjRo=;
	b=YXKcG0Eu6elKoG5bJRvzVKjVPVxCdK32YCKQjbcaKfwtUD0w5irGjgoB/hcLB6cHhoQtEV
	2aGm8hncAmA4SmBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YtoBu6i2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YXKcG0Eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724737979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YbyRpVQyzDYEEPLh9ZRLZD4ogKV9LDeaqbmK0A8SjRo=;
	b=YtoBu6i2DV6dE5lauEETwW8nn/hQ5jH9JhKEtPlA5SgpGIhfy+W2VmV30vdhqU3fCdIJG+
	iGKL3ivuRzfcYBFAyWrMoqaXewTW6bDyFCj/QYqsb3YosrJLDklkXEcliYpOyWFR/Xbemf
	ucjjiw00J8VWgw198BlzT8JfOwbwvnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724737979;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YbyRpVQyzDYEEPLh9ZRLZD4ogKV9LDeaqbmK0A8SjRo=;
	b=YXKcG0Eu6elKoG5bJRvzVKjVPVxCdK32YCKQjbcaKfwtUD0w5irGjgoB/hcLB6cHhoQtEV
	2aGm8hncAmA4SmBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C20F1398B;
	Tue, 27 Aug 2024 05:52:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vGktBbtpzWbjXQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 27 Aug 2024 05:52:59 +0000
Date: Tue, 27 Aug 2024 07:53:42 +0200
Message-ID: <87o75e340p.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: soxiebing <soxiebing@163.com>
Cc: tiwai@suse.de,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: fix snd_hda_bus_reset when single_cmd is not supported
In-Reply-To: <20240827033043.107572-1-soxiebing@163.com>
References: <20240821014238.338864-1-soxiebing@163.com>
	<20240827033043.107572-1-soxiebing@163.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 46F0721AFC
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[163.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 27 Aug 2024 05:30:43 +0200,
soxiebing wrote:
> 
> >On Mon, 26 Aug 2024 11:19:58 +0200,
> >soxiebing wrote:
> >> 
> >> >On Wed, 21 Aug 2024 03:42:38 +0200,
> >> >soxiebing wrote:
> >> >> 
> >> >> From: songxiebing <songxiebing@kylinos.cn>
> >> >> 
> >> >> When an azx_get_desponse timeout occurs, ensure that bus_reset
> >> >> can be used when fallback_to_single_cmd is not supported.
> >> >> 
> >> >> Signed-off-by: songxiebing <songxiebing@kylinos.cn>
> >> >
> >> >Why do you need to change?  Does it fix any real problem you faced?
> >> 
> >> Thanks for reply, i am testing all these days, but the problem is
> >> still exists even if using bus reset.
> >>
> >> The problem i encountered is that hda_call_codec_resume returned 
> >> timeout of 120 seconds(defined CONFIG_DPM_WATCHDOG)) when doing s4, 
> >> azx_get_response timeout occured, it is a low probability event.
> >> 
> >> To avoid exceeding 120s, can i change the count value to 3 in 
> >> hda_set_power_state ?
> >
> >So the change you suggested isn't for any real "fix" but to allow the
> >possible workaround with single_cmd to be applicable somehow in a
> >different form.  Then we should rather try debugging the original
> >issue, instead of change it.
> >
> >Does the response timeout happen *during* the S4 suspend, or during S4
> >resume, or after S4 resume?
> >
> >To be noted, the behavior you changed is only for the single_cmd
> >option is set explicitly, so it's more or less the designed behavior,
> >and I don't think it's good to change blindly.
> 
> The timeout happen during S4 resume. 
> 
> In hda_set_power_state function, the count value setting at most 10 times,
> i feel like there are a lot of retries, can we change it to 3 times, to avoid
> exceeding 120s ?

No, no, if such a long timeout happens, something is already wrong.
Extending it is no real fix at all.

You need to figure out which access or action causes the problem at
first.


Takashi

