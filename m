Return-Path: <linux-kernel+bounces-427889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FFF9E079E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D626F1677B1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8566420898D;
	Mon,  2 Dec 2024 15:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D0jvy1c2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9Y23Ihkb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FmMKpYdF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bxTR1NC/"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438D6205E32;
	Mon,  2 Dec 2024 15:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153488; cv=none; b=j2Xvt2v+GoWrZ5t2nnjPRLCnF/w6LH8BTmBxsizN7d56SOcchS+qExZrh4yO+AKFF80vajT4l5Pq7t+/skw4ECfK1uaXrPG2ql5wpeWCY9sjcFCqmyV+T6EGevjrFCpMftQM7M1FaY67BPR3ASYVKn6ov6tjOLhOocBnCqYuPNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153488; c=relaxed/simple;
	bh=NtP10/e5geCHRKEgdqJZgBe7TDm0YtMc3aT7kVcEZvw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jkoIxiXwNAP6yusYEYlEmyVf6zpSd/aIRmsNyrv/AphM8aHDiiwdCGnbIoU2YTgKo6Dhzxrh09B8p/e8+LZjukhyh6JqCecLSuVx4ueCLePVdBxb9tQUT7FNTh4iFlvAcsNhgqF1GFRo6aqj2sbNhGJf5C8sHMAug4lNvx/H3VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D0jvy1c2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9Y23Ihkb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FmMKpYdF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bxTR1NC/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 63B2C1F396;
	Mon,  2 Dec 2024 15:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733153485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f5rPQTidteaJ5EWqLwUG18Q2x2ScbpqASwTGZ9DnuiA=;
	b=D0jvy1c2PRFYWtbKz3tQHCgW3p/unGVU8a8bygB/yjAeM/VGA/R5VIlsQg584nurDbm9VD
	JzN67YE6JAkmoGRUBwfc77d3IR6lXs+YI59jLOAJ3FHu3JadRq5daqXJzlvPBAmPWp0/d/
	tRhNUwsSQhreZWxxMEySBPhw7xNdLTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733153485;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f5rPQTidteaJ5EWqLwUG18Q2x2ScbpqASwTGZ9DnuiA=;
	b=9Y23Ihkb54BWE5scAlIoIySZa+wstvsZbL2o/VAURbHht1AQnYESZ2aEyOUIH8G2Pl17xD
	Om1rtZarT2ubrxDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733153484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f5rPQTidteaJ5EWqLwUG18Q2x2ScbpqASwTGZ9DnuiA=;
	b=FmMKpYdFY634sLCfvhg+ejJlEcPekRxjC+sITsM05POpwGZab577kwtUtOdSnEfTPxVaI6
	l4aFDhSBvHtOzG+W5XbW78pxgHNx0T5wRmgUvtcsVzsaTUHLFBr25GCAYoDQRN0PgVx+T+
	YAToLBZM34EITMc1xly0FAsY+jAHFCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733153484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f5rPQTidteaJ5EWqLwUG18Q2x2ScbpqASwTGZ9DnuiA=;
	b=bxTR1NC/tk8U0FHJSVgGbmWXR2LCGVqklYJK5Trx9pr+YHxUHZlSEHItMhw/DuEAB8gKP4
	25AZInupl3EJ/lBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0705B139C2;
	Mon,  2 Dec 2024 15:31:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g6SIAMzSTWfEMgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 02 Dec 2024 15:31:24 +0000
Date: Mon, 02 Dec 2024 16:31:23 +0100
Message-ID: <87frn6umno.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?Beno=EEt?= Sevens <bsevens@google.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	wangdicheng <wangdicheng@kylinos.cn>,
	Manuel Barrio Linares <mbarriolinares@gmail.com>,
	Lianqin Hu <hulianqin@vivo.com>,
	Shen Lichuan <shenlichuan@vivo.com>,
	Cyan Nyan <cyan.vtb@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: Fix a DMA to stack memory bug
In-Reply-To: <CAGCho0Xe-jGcanAxehP+ENmrG0Otq5DzQO-yKHx7Ot_UzSRXWQ@mail.gmail.com>
References: <60e3aa09-039d-46d2-934c-6f123026c2eb@stanley.mountain>
	<CAGCho0Xe-jGcanAxehP+ENmrG0Otq5DzQO-yKHx7Ot_UzSRXWQ@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,perex.cz,suse.com,kylinos.cn,gmail.com,vivo.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Score: -1.80
X-Spam-Flag: NO

On Mon, 02 Dec 2024 16:05:01 +0100,
Benoît Sevens wrote:
> 
> Hi Dan,
> 
> On Mon, 2 Dec 2024 at 13:57, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > The usb_get_descriptor() function does DMA so we're not allowed
> > to use a stack buffer for that.  Doing DMA to the stack is not portable
> > all architectures.  Move the "new_device_descriptor" from being stored
> > on the stack and allocate it with kmalloc() instead.
> >
> 
> Thanks for fixing this. It looks good to me.
> 
> Note that the commit that is being fixed is already queued for
> backporting, so I don't know how this usually goes then.

We just follow the same pattern as the Linus upstream, applying the
fix on top of the previous fix.

In anyway, now I merged it.  Will be included in the next PR for rc2.

Thanks!


Takashi

