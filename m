Return-Path: <linux-kernel+bounces-295018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE51D95956B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 09:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49F72B257A9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 07:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A081A2847;
	Wed, 21 Aug 2024 07:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eKir8DRC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fG7tpIC0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eKir8DRC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fG7tpIC0"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB2A1A2857;
	Wed, 21 Aug 2024 07:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724224288; cv=none; b=iMZmT8RRfXu0MFiDhi2wicdSoTLwZ+nUT288fX66fJ7PzbHgKkJ+k/H/fu76PqbBWsBd8M5SPoHMTdc/vg8tur77+WLgdYVu4d9PsbfLaJiW+NdRUdV/yHCL+Foe1cQIXUrU/1U1tUdqB1q3e+ubkZKlZ4/v1CcKRaggxeQOBnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724224288; c=relaxed/simple;
	bh=NZjH4uZaW1H6fHzTuS0UFwh6dLwoqwxPmN2hIUNCSJE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uEkrX0LDVCQHg3jFOMdI89jxkvIP6IpbtVvdQQ2HhQaXiEm6nQmOTYxdAM5RLyl+WyccOLOzCS6k2AX47pTrjhyT7Sp9/71b6zDX5yNU0EGgZZgE0mBJqSndxCsG80ZmDPdxLL/obT8riHFf9vSEPkVMOEAfwmgKAxkAHgy4ENU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eKir8DRC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fG7tpIC0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eKir8DRC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fG7tpIC0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CF6AF21F8F;
	Wed, 21 Aug 2024 07:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724224277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TCLVOPeh+8Qu1riV+de82s9/4W58qAkfUcb2ksUW10s=;
	b=eKir8DRC3m7a3HQfbUI5AeeSMbt3ecq2ztPISVFBnbM+nj27ZOBXBsjaqxfqe98uk9E+P3
	o45JxNvqCbQNdBpwr8G3Wvlxl/IBIGBOWRx0sR2sgxCzY6M8t+awjx5piDBD+1T+AgVWgT
	kkj7hpnqEi8/jQh9Lbepa/WpxmbHBmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724224277;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TCLVOPeh+8Qu1riV+de82s9/4W58qAkfUcb2ksUW10s=;
	b=fG7tpIC0RtizhfgZ6qbmyG4TmYa2LrrTZ/kE5ikaMssaVzMFXP999oktNyOqdbtiq7CG3H
	qCD495DAbwEUoTCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724224277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TCLVOPeh+8Qu1riV+de82s9/4W58qAkfUcb2ksUW10s=;
	b=eKir8DRC3m7a3HQfbUI5AeeSMbt3ecq2ztPISVFBnbM+nj27ZOBXBsjaqxfqe98uk9E+P3
	o45JxNvqCbQNdBpwr8G3Wvlxl/IBIGBOWRx0sR2sgxCzY6M8t+awjx5piDBD+1T+AgVWgT
	kkj7hpnqEi8/jQh9Lbepa/WpxmbHBmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724224277;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TCLVOPeh+8Qu1riV+de82s9/4W58qAkfUcb2ksUW10s=;
	b=fG7tpIC0RtizhfgZ6qbmyG4TmYa2LrrTZ/kE5ikaMssaVzMFXP999oktNyOqdbtiq7CG3H
	qCD495DAbwEUoTCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0FEC13770;
	Wed, 21 Aug 2024 07:11:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LpDFJRWTxWatJwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 21 Aug 2024 07:11:17 +0000
Date: Wed, 21 Aug 2024 09:11:59 +0200
Message-ID: <87le0qqri8.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: soxiebing <soxiebing@163.com>
Cc: tiwai@suse.de,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	songxiebing <songxiebing@kylinos.cn>
Subject: Re: [PATCH v1] ALSA: hda: fix snd_hda_bus_reset when single_cmd is not supported
In-Reply-To: <20240821014238.338864-1-soxiebing@163.com>
References: <20240821014238.338864-1-soxiebing@163.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[163.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 21 Aug 2024 03:42:38 +0200,
soxiebing wrote:
> 
> From: songxiebing <songxiebing@kylinos.cn>
> 
> When an azx_get_desponse timeout occurs, ensure that bus_reset
> can be used when fallback_to_single_cmd is not supported.
> 
> Signed-off-by: songxiebing <songxiebing@kylinos.cn>

Why do you need to change?  Does it fix any real problem you faced?


thanks,

Takashi

