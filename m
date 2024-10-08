Return-Path: <linux-kernel+bounces-354761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B425B994249
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7193B284B0A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6B51F7099;
	Tue,  8 Oct 2024 08:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fNLyx3f6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q/dpWv/n";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BdRGEq5z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FlCjWPIb"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848311F7098;
	Tue,  8 Oct 2024 08:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728375175; cv=none; b=ZwKz00ngw2vbzAPul3wSdX7OuzsoL4HOhPxxNf8gzn944qSyy62QdXZlgsBLKfEgz49qvQBR89hrx2nr8J+ANcx57nEHrlGb+3IraG3OLIHOirq42g69HrpNGwJFU9cZG0HlN4+bI78uifW3MlkI5eik8vJ/O3ZkVJy65L9Cg18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728375175; c=relaxed/simple;
	bh=eUK8Z4+ky18odN/N9vCnDQhwJr08DQCifVaqQRayCkQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O/cvtRkLzkQ+U5P38/Ql1mbzwG/iRZdf/7z1qui0NhFx+m2WeCT8fsi8cc4XSM6sSIfiOt5wJy0vpLIzyrxf8Ry0cEQAZ0aYNMvdDXP9UlmtYotSTakRPi6dTcKfWi4GIziR1ps7425W1lJObfxolK9zv5KauO/Ipr9fw8hGv0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fNLyx3f6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q/dpWv/n; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BdRGEq5z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FlCjWPIb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A89961F8D7;
	Tue,  8 Oct 2024 08:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728375171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cji+FWp4Mo6dzbnpYnXNGYBboaD0Twq8QXHLbrBsGa4=;
	b=fNLyx3f6H3gw8XlNQ01YcTaNOOfH3qWW204jqsKSo0LTrGhbDXXdBMSjA6hrD9ReFH0Dzh
	vaZB0sDqKpxvAoXvXMNe/7lLwMOkNYOUzXDh7tNs6PvLftuKr3pln/8DmdQK1JDW2hVqTU
	rq5c6ji78EiMHtkg7TA5CRAabiYUFiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728375171;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cji+FWp4Mo6dzbnpYnXNGYBboaD0Twq8QXHLbrBsGa4=;
	b=Q/dpWv/nVqQEYYgbCDOKPoxcunkYOs/XREa4KWsGuv7/BjoK1IAaY8bO1jAG8W7UYdHV1i
	jcIuTKIJR05dkLBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728375170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cji+FWp4Mo6dzbnpYnXNGYBboaD0Twq8QXHLbrBsGa4=;
	b=BdRGEq5zyGNlJEp9qe6pefj11Olfgtbkh+2lHVt5bJh2OG6XFR0Qmn3I7iuCAZJJEESM7g
	HcNesdMm0SnFI/s4vsY1ohB7alLDvpFUF1oescUn01Lhouj7P3eMAJ2WXr/pa83cqfFh7V
	7PqW2MHGUFIMifVHO+CYIxCnImpVz9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728375170;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cji+FWp4Mo6dzbnpYnXNGYBboaD0Twq8QXHLbrBsGa4=;
	b=FlCjWPIbD7ZglxKBKdVVo8rCtA5gSpyVfMGG+FnzSJZh7muPM2zHlLRAqLXAXOmKEkgzZJ
	nNsv51yKc1dNBwBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 771B51340C;
	Tue,  8 Oct 2024 08:12:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AYxAGYLpBGdsHQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 08 Oct 2024 08:12:50 +0000
Date: Tue, 08 Oct 2024 10:13:46 +0200
Message-ID: <87msjfvwp1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Sound:dbri:Fix formatting issue in dbri.c
In-Reply-To: <20241008055155.11798-1-zhujun2@cmss.chinamobile.com>
References: <20241008055155.11798-1-zhujun2@cmss.chinamobile.com>
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 08 Oct 2024 07:51:55 +0200,
Zhu Jun wrote:
> 
> Changed sprintf format specifier for rp->start from %016Lx to %016llx
> to correctly handle unsigned long long values.
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

Applied now.  Thanks.


Takashi

