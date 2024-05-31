Return-Path: <linux-kernel+bounces-196807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 550DD8D61FF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B26D287AEB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0346158A0B;
	Fri, 31 May 2024 12:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="buTmRst5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CqoWYuPv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rweyPEsK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xbUK2QWJ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84DD1581ED;
	Fri, 31 May 2024 12:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717159142; cv=none; b=c/2UipmMIGs7O6dwizkbiJ20igHmCFWJvH7PZsjfm+LWGLdGWh3cNEoeWorFG6CupSneRFiw7Iv/tuHNI80u9p+rlbX3RLDNFwGGqGK5JIK/eAEwNU3GUrPf8UQx1c5Oa2G2H3MEhaw6nIOADuj6hK42xSQVrSoD/OFxaZIcS6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717159142; c=relaxed/simple;
	bh=IPc8jlhLuzCqTnWJaLMFTsOyIKrZtUkJnSVzGut2KNs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YKyKVc0RpPDu9+aKX2cZGK+2xZLneNajfpJra8CTQet87slV30jkUJUEbnscV6nrKv4/+n34YvpHHo9aaUF/CO5nEahCyhbu8pP2BnussL7jsCwU0mQizO8HK0/9HoNuQI8vSzG9fSKxuLcnSBwNEaDw77H6Qsm5dtNnOoDFcKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=buTmRst5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CqoWYuPv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rweyPEsK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xbUK2QWJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D3DCB21BCB;
	Fri, 31 May 2024 12:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717159139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Id2Wss5xxMjf0A2gtsNDPrctLn2eyY404RyQsHumymI=;
	b=buTmRst5f2sIJdCOyHq1LcbQu3ML9DgMP7/76B/bCW7hO3Um1UazPmYRDZGnMEdBoTQw1l
	BV+MRXgeberk61fD2GU8HBkuksGjKf37dY+C9yA1jtDGy410HA/OVBT9KJCBY+V1be0793
	RGwOZasJEQDjKPihWXFVbnYQcvFxndM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717159139;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Id2Wss5xxMjf0A2gtsNDPrctLn2eyY404RyQsHumymI=;
	b=CqoWYuPvhW+ljUduNbnxAn7qhmt+yxxfVA2GX2MwKit6Qu/YbVHI6Vy0dBXAX/AIgs6NMC
	8Ahz+Je6tvlHZfDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rweyPEsK;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xbUK2QWJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717159138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Id2Wss5xxMjf0A2gtsNDPrctLn2eyY404RyQsHumymI=;
	b=rweyPEsKGRbRSnkLQuXsThuTBcIZde9ZNptYG0LsVrvMwZGrlxsXPXkYI/zZoeUTqdwjtE
	tKrgq04XHkjuHNYJjyfbo0JEyOEmbxinoS0pK+lvIaU87wTDvr6auFekVLBVyuk+GV3NU9
	BshI+Yk0kpdFjfjxlBhWnOhShFYWfB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717159138;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Id2Wss5xxMjf0A2gtsNDPrctLn2eyY404RyQsHumymI=;
	b=xbUK2QWJ2GU9pi7HShs4CAbs6FjizIBVs5CjwONqe1tRwH8JsrvgdFj2WInMascfruJpC2
	QQ3ERH59LpGw2CDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52924137C3;
	Fri, 31 May 2024 12:38:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k6FrEOLEWWbhVQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 31 May 2024 12:38:58 +0000
Date: Fri, 31 May 2024 14:39:20 +0200
Message-ID: <871q5i40lj.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Simon Trimmer <simont@opensource.cirrus.com>
Cc: <tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH] ALSA: hda: cs35l41: Possible null pointer dereference in cs35l41_hda_unbind()
In-Reply-To: <20240531120820.35367-1-simont@opensource.cirrus.com>
References: <20240531120820.35367-1-simont@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -5.43
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D3DCB21BCB
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.43 / 50.00];
	BAYES_HAM(-2.92)[99.66%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Fri, 31 May 2024 14:08:20 +0200,
Simon Trimmer wrote:
> 
> The cs35l41_hda_unbind() function clears the hda_component entry
> matching it's index and then dereferences the codec pointer held in the
> first element of the hda_component array, this is an issue when the
> device index was 0.
> 
> Instead use the codec pointer stashed in the cs35l41_hda structure as it
> will still be valid.
> 
> Fixes: 7cf5ce66dfda ("ALSA: hda: cs35l41: Add device_link between HDA and cs35l41_hda")
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>

Thanks, applied now.


Takashi

