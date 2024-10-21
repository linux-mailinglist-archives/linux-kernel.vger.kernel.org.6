Return-Path: <linux-kernel+bounces-373755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C6B9A5C13
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E461C2199E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8271D0F54;
	Mon, 21 Oct 2024 07:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w2bqYB2D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="x5pkQ8Dc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ohGxU7if";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cTdeW+gC"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29AA1940A2;
	Mon, 21 Oct 2024 07:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729494527; cv=none; b=MXNFh606rjLeJQEsdTNGVxsQTmApC8tF8getUnnAhT4T0ODP9vH2vBTAX+Wpyd6oXeZYUUvL9RsATlrsSgAXDmEtkYFR9iIwp1Gsq5g2KyYbL7ojHx9UcRAhKDJ6S+kiToVfMQ0KuvXWL2MssywshKi0LU8YI+BchWSMZDOI9Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729494527; c=relaxed/simple;
	bh=DJ/LMXa8DNzbZlDTMg9MkBRugetCEuzG8+gEMP8AGOs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QdPHABZBkMild53OJrz3xrbndwTjh3hJKqj8gdkN5LsWzwHO46Gqedo8WP4w4P4ZkfvvA15VR6/kvOcmbbEuZXfw1Et3lQuEVP6CYdm8emlEYQhvh7egyOOemZ6u7YupJ/CMUX8MU0JGExMCImW1jSwVuwLNorR5IgrTISnwwUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w2bqYB2D; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=x5pkQ8Dc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ohGxU7if; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cTdeW+gC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D172121FC9;
	Mon, 21 Oct 2024 07:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729494523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mbDBxoWKkQMhSe40y2KcT39f+Czf7BLV/i78/Xk1dFs=;
	b=w2bqYB2DWayNdgQk+kyqKcswbyy/uH0bbsnlOPnCbFPofbdkVJVhO/fxbZJ45Gog7GWQ1l
	CeF7+zPwps+wIHuJyRR3+Jdp0FG8IJ4j8l/SyQMxuGdXFEzgMDn1ccSQ5ES0+4TuE5fhAA
	2B5bJuvS7UI67EOxo9/QRbDTueW1W2w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729494523;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mbDBxoWKkQMhSe40y2KcT39f+Czf7BLV/i78/Xk1dFs=;
	b=x5pkQ8DcWQZ9Xo7oSzwc/bG0e1xBnLr50pLwGwb2j6Z7jf1rNiwG1vqAfXWIfz9k8FKhb+
	90lHIsZN83qz/dAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729494522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mbDBxoWKkQMhSe40y2KcT39f+Czf7BLV/i78/Xk1dFs=;
	b=ohGxU7ifBTz6z8C+KkJBBWIcKtYQiOWSp8/Ov/Ung0jP6WBKqWjhWkj04JdCVUQxPS9vl1
	Sz9UZiLZM0z7v7P40jwwnb64W2p9jBX1/sFNwFXrwf9+8Bq23CEhGu/mxuKlAjERD91S4G
	1ocwmihwI+a1SWFnlv+p5PbLyFXSeu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729494522;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mbDBxoWKkQMhSe40y2KcT39f+Czf7BLV/i78/Xk1dFs=;
	b=cTdeW+gC1dpK6vVuBhBoNKqwBKQ9oUSI4DF6rjcPn9TsQuTF0XJK9woqG3liqPCeZMsdld
	Ar7Mrl+AI0BpxBAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 699FB136DC;
	Mon, 21 Oct 2024 07:08:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id weFNGPr9FWcXSgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 21 Oct 2024 07:08:42 +0000
Date: Mon, 21 Oct 2024 09:09:42 +0200
Message-ID: <874j56j5jd.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Andrey Shumilin <shum.sdl@nppct.ru>
Cc: Clemens Ladisch <clemens@ladisch.de>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	lvc-patches@linuxtesting.org,
	khoroshilov@ispras.ru,
	ykarpov@ispras.ru,
	vmerzlyakov@ispras.ru,
	vefanov@ispras.ru
Subject: Re: [PATCH] ALSA: firewire-lib: Avoid division by zero in apply_constraint_to_size()
In-Reply-To: <20241018060018.1189537-1-shum.sdl@nppct.ru>
References: <20241018060018.1189537-1-shum.sdl@nppct.ru>
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
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 18 Oct 2024 08:00:18 +0200,
Andrey Shumilin wrote:
> 
> The step variable is initialized to zero. It is changed in the loop,
> but if it's not changed it will remain zero. Add a variable check
> before the division.
> 
> The observed behavior was introduced by commit 826b5de90c0b
> ("ALSA: firewire-lib: fix insufficient PCM rule for period/buffer size"),
> and it is difficult to show that any of the interval parameters will
> satisfy the snd_interval_test() condition with data from the
> amdtp_rate_table[] table.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 826b5de90c0b ("ALSA: firewire-lib: fix insufficient PCM rule for period/buffer size")
> Signed-off-by: Andrey Shumilin <shum.sdl@nppct.ru>

Applied now.  Thanks.


Takashi

