Return-Path: <linux-kernel+bounces-263369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B798493D4FA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2069D287B10
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12871EEB2;
	Fri, 26 Jul 2024 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CbqejKE8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oPDhyO50";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BkvrW/q0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8dEOA5J+"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F84C4C8C;
	Fri, 26 Jul 2024 14:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722003597; cv=none; b=Di4URlAizw+GGS6Yq5FAPD4D3KyK3KDJEW9bBEfkVdL6lofxdkpmz7eAPODoEcuxlaeU4CNk1+GX55XaInRt9PwBfmx/rPlWxPpw0U5no1weLk4Y5CKeeuMntx8I32zKu/VghH/6p3LPhzIPACz1UrU53tjxKJ8bhV2ENYN7KII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722003597; c=relaxed/simple;
	bh=JBKSlO27DYTY9vlhbfh78Vrum7iL/FZVXe8uTYF/+qY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Drj8cbLZET2OvpX4O1lYi219HWNG/S2ETGKcuMBDwKkLesqGKVfUQz6c73tyYPikvZK8TLRZKNW0mreJI9sPVPRq4kPvZvRRmqg5cIBl5UnpZAcmWBaHKdlLPPCCrGwbkKyndC2WVMkKc9yS5TxtmIo855At0x7kbs1W8h5BByQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CbqejKE8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oPDhyO50; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BkvrW/q0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8dEOA5J+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E081421BDF;
	Fri, 26 Jul 2024 14:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722003593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EVIcc43oqQoDSILwZYqe1MDhmRzn7/ptMvcrEbAq04s=;
	b=CbqejKE8sgY/KPSgI3ZLsQvDe/t/nLBXH8XJvBvwVV8ygP0Zd+2oZkoF8264k8Hs9rha02
	XlTb7NeFnjO51BuNg7DIYU5VoDrXZG8Ui1ZrQTH6NqQVYpDJwSVBAythmoXhFO07zgbV0l
	/lMqPWr7EaHEsMQ9ZRPGMOpYkpEujx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722003593;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EVIcc43oqQoDSILwZYqe1MDhmRzn7/ptMvcrEbAq04s=;
	b=oPDhyO50Gn+jrMHQ4mqZzL0I1WBaH/5CRUUlsPLKh4n3YG0O/CvjKRBWoxgui8BuyrRwmL
	m5titBvlnJU7krCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="BkvrW/q0";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8dEOA5J+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722003592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EVIcc43oqQoDSILwZYqe1MDhmRzn7/ptMvcrEbAq04s=;
	b=BkvrW/q04O6bJQ4UbXg0RNTWrxeXRHtLD9UxV+aAXSy3wcrk/7nA3niVpj2Qd4IDtZhyLE
	IbPeAY25v4ChIrp0XXTPFewwy8UW46/r5HtWgxnxSmJKRRZyhEmHOmqebwW3vZ4a6Imxgc
	I3MRtt9aL5K+nsMvwTMod87SOq0hMkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722003592;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EVIcc43oqQoDSILwZYqe1MDhmRzn7/ptMvcrEbAq04s=;
	b=8dEOA5J+/23AAbEMBteVxDPYhO5dSKwiiP+DxRFUAZ6zmnY/bEWlzdnzMDHexDTdg3Bv0Q
	wK4G6ASpoOhuHBCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1C50138A7;
	Fri, 26 Jul 2024 14:19:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t+8vKoiwo2aHHQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 26 Jul 2024 14:19:52 +0000
Date: Fri, 26 Jul 2024 16:20:28 +0200
Message-ID: <878qxokzf7.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: soxiebing <soxiebing@163.com>
Cc: tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	songxiebing <songxiebing@kylinos.cn>,
	bo liu <bo.liu@senarytech.com>
Subject: Re: [PATCH v2] ALSA: hda: conexant: Fix headset auto detect fail in the polling mode
In-Reply-To: <20240726100726.50824-1-soxiebing@163.com>
References: <20240726012342.8645-1-soxiebing@163.com>
	<20240726100726.50824-1-soxiebing@163.com>
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
X-Spamd-Result: default: False [-3.31 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.31
X-Rspamd-Queue-Id: E081421BDF

On Fri, 26 Jul 2024 12:07:26 +0200,
soxiebing wrote:
> 
> From: songxiebing <songxiebing@kylinos.cn>
> 
> The previous fix (7aeb25908648) only handles the unsol_event reporting
> during interrupts and does not include the polling mode used to set
> jackroll_ms, so now we are replacing it with snd_hda_jack_detect_enable_callback.
> 
> V1 -> V2: fix char persent compile error
> 
> Fixes: 7aeb25908648 ("ALSA: hda/conexant: Fix headset auto detect fail in cx8070 and SN6140")
> Co-developed-by: bo liu <bo.liu@senarytech.com>
> Signed-off-by: bo liu <bo.liu@senarytech.com>
> Signed-off-by: songxiebing <songxiebing@kylinos.cn>

Thanks, applied now.


Takashi

