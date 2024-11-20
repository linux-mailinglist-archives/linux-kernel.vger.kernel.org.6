Return-Path: <linux-kernel+bounces-415671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568239D39B2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1694F2822D8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F551A0B0E;
	Wed, 20 Nov 2024 11:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JoN8oZ07";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YcWg6uAk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JoN8oZ07";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YcWg6uAk"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC8019D8A3;
	Wed, 20 Nov 2024 11:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732102951; cv=none; b=dDcg3JtiOAcdGA/t8DbxVp/Mnb9P+rSo8FKCLbSVbnXDFcuzuklM/OVOFVF1ds7X9vfqUNO1QksBs8PXTkfncln+xoJ2fuetGoryP7tH33oZ5haj32CXUXjB16li3b4ZvQgkp2CkD7mRG/TfmvtixcGft9ZJA8xhm2ylaWkkEPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732102951; c=relaxed/simple;
	bh=y4NLLTWyYXjyYGqPxXpWnwEh2JfHBgxN148ZNc6DGc4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mKuFvf2S2SNp513lTWSm8yui3x0N3mnIZpZWWc8PLSFsVtvQz1deNdCh/lXPiE0ckOXG82EV4BUzGn5Ue8DpaMjFLqtEIxmzGf7MA1QldrokN6s8joHz1C86CfE9PDlZZF0DI4EEW7KRhkXdZDoYq0DLyVqkhDmDLa1Dx6xCVjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JoN8oZ07; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YcWg6uAk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JoN8oZ07; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YcWg6uAk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E25BC1F76E;
	Wed, 20 Nov 2024 11:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732102947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iSJHqq17lovBmeACeob9g+ohEW03fo5ZEFf0G9GBxmU=;
	b=JoN8oZ07TeRcdLQwtEK5WRHi8Rao7iIHxMsjnW5Vtrp/F248OXC0zvMOXJcQp+fqW+Mhyv
	ze5yMPj2Hhr8VUdYG5OCWZjqsHHCUxsetNg9DIr729NFhWfy1vAWvgjBIjwXHBhOFex7y0
	3sBSA9iUxphlk00UQIDcJ0agPeeY62M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732102947;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iSJHqq17lovBmeACeob9g+ohEW03fo5ZEFf0G9GBxmU=;
	b=YcWg6uAkmJPZR4uc/UxsMTeqGsOGpM6kwRsygYljsl7KIufTPpqnGWsIYpVRchojDpqfom
	9e9N1EGHn6hFGmDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732102947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iSJHqq17lovBmeACeob9g+ohEW03fo5ZEFf0G9GBxmU=;
	b=JoN8oZ07TeRcdLQwtEK5WRHi8Rao7iIHxMsjnW5Vtrp/F248OXC0zvMOXJcQp+fqW+Mhyv
	ze5yMPj2Hhr8VUdYG5OCWZjqsHHCUxsetNg9DIr729NFhWfy1vAWvgjBIjwXHBhOFex7y0
	3sBSA9iUxphlk00UQIDcJ0agPeeY62M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732102947;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iSJHqq17lovBmeACeob9g+ohEW03fo5ZEFf0G9GBxmU=;
	b=YcWg6uAkmJPZR4uc/UxsMTeqGsOGpM6kwRsygYljsl7KIufTPpqnGWsIYpVRchojDpqfom
	9e9N1EGHn6hFGmDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5B0E13297;
	Wed, 20 Nov 2024 11:42:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S4pPKyPLPWfffAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 20 Nov 2024 11:42:27 +0000
Date: Wed, 20 Nov 2024 12:42:27 +0100
Message-ID: <87h6823zdo.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lkp@intel.com,
	broonie@kernel.org,
	arnd@arndb.de,
	xiaopeitux@foxmail.com
Subject: Re: [PATCH] ALSA: ac97: bus: Fix the mistake in the comment
In-Reply-To: <3990bfc8cd47637908eaa179802c1d91459d829b.1732083924.git.xiaopei01@kylinos.cn>
References: <202411180804.FUfdymYO-lkp@intel.com>
	<3990bfc8cd47637908eaa179802c1d91459d829b.1732083924.git.xiaopei01@kylinos.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[foxmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,vger.kernel.org,intel.com,kernel.org,arndb.de,foxmail.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,kylinos.cn:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 20 Nov 2024 07:30:19 +0100,
Pei Xiao wrote:
> 
> Fix mistake in the comment.
> sound/ac97/bus.c:192: warning: Function parameter or member 'drv' not described in 'snd_ac97_codec_driver_register'
> sound/ac97/bus.c:192: warning: Excess function parameter 'dev' description in 'snd_ac97_codec_driver_register'
> sound/ac97/bus.c:205: warning: Function parameter or member 'drv' not described in 'snd_ac97_codec_driver_unregister'
> sound/ac97/bus.c:205: warning: Excess function parameter 'dev' description in 'snd_ac97_codec_driver_unregister'
> sound/ac97/bus.c:351: warning: Function parameter or member 'codecs_pdata' not described in 'snd_ac97_controller_register'
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202411180804.FUfdymYO-lkp@intel.com/
> Fixes: 74426fbff66e ("ALSA: ac97: add an ac97 bus")
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>

Thanks, applied now.


Takashi

