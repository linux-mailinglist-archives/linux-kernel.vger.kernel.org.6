Return-Path: <linux-kernel+bounces-397840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCE29BE144
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72554B23648
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2A21D6DB4;
	Wed,  6 Nov 2024 08:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1srvWp2k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YccZmSgL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1srvWp2k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YccZmSgL"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD021D043D;
	Wed,  6 Nov 2024 08:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730882707; cv=none; b=rhXTQfvhwzehysTfnCFcY5wZ/lnoJdDkcOulK7KUZ91yyP12OXDQLDt16xGdkMz9xVESSo0YwjIio1AkjP5R7xhWiSj0Wr6cypjRjlKqTDUyT4mcrur4ugQwfO6/l2Gg7rif22dcx7bm8dtsjYcJaw4Ou9bN8aLdMg1nUHOVmkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730882707; c=relaxed/simple;
	bh=J24yp9eOiNrvQNu9kBFLlGNdEA4hj8a8DKe9HSNXhLc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aX8r8j4o3mSVxByp4Aj6nCQ5cPfn5WzJ+G/QN1cFQ8NLo79UgevWKnG0meRsIAm0m0nvq2bIK5mvb88YPiwdxKplC152c8KyQYYTgqIXFJ/0Lpu2x+1AIWV9a8bDxWyG5300u3fzFRJCB4UC2zLJg5dPSE1eBQkkE0ELHbCo3No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1srvWp2k; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YccZmSgL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1srvWp2k; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YccZmSgL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 834E81FCF8;
	Wed,  6 Nov 2024 08:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730882703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gktV8JM/O5wdbQsOMcRKLeeygObw2HDzdhZs6ZLIFWU=;
	b=1srvWp2kNcclibLGORjHmhWEwNU9Z0wLY3ViK9uaArGmuHq10mxemHvoraM2isDabYyKAK
	Yre+n+GH8qIkXnIySb7Hsr+7JXd2zN2I000OsDEyv8SxqZDPM+1Pmk79JPocuRmSKDUpU4
	7w1c4VTlZ0rasC+zaYiX9YCdZ3i5uC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730882703;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gktV8JM/O5wdbQsOMcRKLeeygObw2HDzdhZs6ZLIFWU=;
	b=YccZmSgL/BoF+4KT7T4Bd44jj9cluTEbc9XkUGgAC3tIGtrD7NR226/90Ijmk61bpgySf6
	HUwIH85FmGTA3/DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1srvWp2k;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YccZmSgL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730882703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gktV8JM/O5wdbQsOMcRKLeeygObw2HDzdhZs6ZLIFWU=;
	b=1srvWp2kNcclibLGORjHmhWEwNU9Z0wLY3ViK9uaArGmuHq10mxemHvoraM2isDabYyKAK
	Yre+n+GH8qIkXnIySb7Hsr+7JXd2zN2I000OsDEyv8SxqZDPM+1Pmk79JPocuRmSKDUpU4
	7w1c4VTlZ0rasC+zaYiX9YCdZ3i5uC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730882703;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gktV8JM/O5wdbQsOMcRKLeeygObw2HDzdhZs6ZLIFWU=;
	b=YccZmSgL/BoF+4KT7T4Bd44jj9cluTEbc9XkUGgAC3tIGtrD7NR226/90Ijmk61bpgySf6
	HUwIH85FmGTA3/DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 469D813736;
	Wed,  6 Nov 2024 08:45:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Cw7fD48sK2dkRAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 06 Nov 2024 08:45:03 +0000
Date: Wed, 06 Nov 2024 09:46:09 +0100
Message-ID: <87a5ecwy0e.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: vkoul@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	broonie@kernel.org,
	amadeuszx.slawinski@linux.intel.com
Subject: Re: [PATCH] ALSA: compress_offload: Use runtime pointer in snd_compr_poll()
In-Reply-To: <20241106075312.15601-1-peter.ujfalusi@linux.intel.com>
References: <20241106075312.15601-1-peter.ujfalusi@linux.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 834E81FCF8
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,intel.com:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 06 Nov 2024 08:53:12 +0100,
Peter Ujfalusi wrote:
> 
> runtime is not used as seen with W=1 :
> sound/core/compress_offload.c: In function ¡snd_compr_poll¢:
> sound/core/compress_offload.c:409:35: error: variable ¡runtime¢ set but not used [-Werror=unused-but-set-variable]
>   409 |         struct snd_compr_runtime *runtime;
>       |                                   ^~~~~~~
> 
> Instead of dropping the runtime, use it in the function in place of
> stream->runtime
> 
> Fixes: 04177158cf98 ("ALSA: compress_offload: introduce accel operation mode")
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

Applied now.  Thanks.


Takashi

