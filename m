Return-Path: <linux-kernel+bounces-433359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7093C9E5762
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 14:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596FD188312F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33622218E94;
	Thu,  5 Dec 2024 13:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QgKfpS75";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GCoWUgHg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QgKfpS75";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GCoWUgHg"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1827218852;
	Thu,  5 Dec 2024 13:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733406032; cv=none; b=QTjGe6lBqts+W9Z1NLRf7LuWPaYG3/Kf0GBsFbWRzbFMi6NPqVQIgQe+QyEPlGCHRmGyMx8grIzXbVF1V4IOcLWogsY0TAA95iSwXNaOmQHoY8IqezsFmOGCF0otDdQcaITijIYR8DodJHSSJ3pP9iDir13btAgF8oi3l8xpIWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733406032; c=relaxed/simple;
	bh=ZGvXMjW88upxx0fPmx36SeRsaX1DIzCQfcIrjGdk4ZM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CZ+Qsf/x6E8hvCDey/y25qwf6C7iHxyDbP/BsHYKScw9JCSTcEqbvX3ETmSx4Kxh3lJ0uryNY5SCwl7ieGYvE7cigY9S5d8v37S9C2rAGd+jia4E8lIK9qfQ/M3J/j4B9Q1ChNRlY6RyaVk06/x4NeTj26L+1IR5pM3EPA7XvPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QgKfpS75; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GCoWUgHg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QgKfpS75; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GCoWUgHg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1E2D91F38C;
	Thu,  5 Dec 2024 13:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733406029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nU4zye91tjThTyXwrSipPttrgEtAJSfGaC89apsk4hE=;
	b=QgKfpS75omFkpHfkQaP5YtnQp8Bv+5otu5KCSFmxb2rsZjbJ85hIOs6ti34XkU8lXD5JKp
	1OozwiCADaX82qgWuB0Cmv/njXZEt2jH4Mje6+Pic4mS5T4UdDxxXyI7QezvQxDVdZ3SBh
	fa6Cq6h/73l7z9thi60ozaUHofLjemk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733406029;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nU4zye91tjThTyXwrSipPttrgEtAJSfGaC89apsk4hE=;
	b=GCoWUgHgvn2vsuYsbuZm0pjtasstKBobaPSgijy1AfVCqVr4PlIFZLA4ugubBXwsbPV6tI
	SoQqt0JmBPQhdbCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733406029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nU4zye91tjThTyXwrSipPttrgEtAJSfGaC89apsk4hE=;
	b=QgKfpS75omFkpHfkQaP5YtnQp8Bv+5otu5KCSFmxb2rsZjbJ85hIOs6ti34XkU8lXD5JKp
	1OozwiCADaX82qgWuB0Cmv/njXZEt2jH4Mje6+Pic4mS5T4UdDxxXyI7QezvQxDVdZ3SBh
	fa6Cq6h/73l7z9thi60ozaUHofLjemk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733406029;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nU4zye91tjThTyXwrSipPttrgEtAJSfGaC89apsk4hE=;
	b=GCoWUgHgvn2vsuYsbuZm0pjtasstKBobaPSgijy1AfVCqVr4PlIFZLA4ugubBXwsbPV6tI
	SoQqt0JmBPQhdbCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C83B5138A5;
	Thu,  5 Dec 2024 13:40:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QdcFL0ytUWfTTAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 05 Dec 2024 13:40:28 +0000
Date: Thu, 05 Dec 2024 14:40:28 +0100
Message-ID: <87plm6tfhv.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kailang Yang <kailang@realtek.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Joshua Grisham <josh@joshuagrisham.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	linux-sound@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ALSA: hda/realtek: Fix spelling mistake "Firelfy" -> "Firefly"
In-Reply-To: <20241205102833.476190-1-colin.i.king@gmail.com>
References: <20241205102833.476190-1-colin.i.king@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -1.79
X-Spamd-Result: default: False [-1.79 / 50.00];
	BAYES_HAM(-2.99)[99.96%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 05 Dec 2024 11:28:33 +0100,
Colin Ian King wrote:
> 
> There is a spelling mistake in a literal string in the alc269_fixup_tbl
> quirk table. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thanks, applied now.


Takashi

