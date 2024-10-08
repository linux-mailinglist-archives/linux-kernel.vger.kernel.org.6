Return-Path: <linux-kernel+bounces-354762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8135D99424B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA400B27F65
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D2A1F8915;
	Tue,  8 Oct 2024 08:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zx1vHIGH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cZzAm3fy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PDpTIboh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X42Kpznv"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8521DE8B5;
	Tue,  8 Oct 2024 08:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728375223; cv=none; b=fABJQUEW0y8fN7eiAQWU0/OBKnnI2JWGLw0TA7DB7UhriOeldbJhPoaj5SeDcn380lpDcqzw+LKtfKDV9SRuzuQDgLr9SVMKNCK99x36xdQIXBpoEKz22XrnrE7Xshfi2sBKRJ1YuYs067xuw8x2RVbrw7uOhYOZKqN6dy8UYd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728375223; c=relaxed/simple;
	bh=RLOIW+CXbCKn+TSOWrmg2pE8nbPBJT081Fijh423jsw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lC/DKHK+e/piI2sEGr6WXHWXFH8fCchhrEmWo+0fyyXWlQAN+nhahQ91p6ZL4+IAuXULeEB56Dofv7iTyRXv7DkODO8vHeCOnUa+7y447XTSfTqI/08xS4gm0CDn36GPd/Zy0SzfJazuTktEEkB++dNTfoVW0y5dmAdxhkxAQ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zx1vHIGH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cZzAm3fy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PDpTIboh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X42Kpznv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CB68F219EA;
	Tue,  8 Oct 2024 08:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728375219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s19y3MbDqKaGhgKApryzrv6Z6W35csossCcX0lXqfTo=;
	b=zx1vHIGHKBVr2dmRlBWUrJvpC+1glFvRAGYo4ffZstSF3LL64rXWfkdWRZKsoperZ8+gCh
	he8HWlo5A01frga9qpm43UVBb5R1FuSHwgbYLp/m9AGW8iMWgSfNEfaEI+Viq9WH2av1d6
	zMm7ThS/eMhS5+S7Xvv8XRRCkO7iOxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728375219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s19y3MbDqKaGhgKApryzrv6Z6W35csossCcX0lXqfTo=;
	b=cZzAm3fyBbvxBIOKVqjJxYx3QC0SbpVKeCnYurlEwxpLFh+n5ssGBotQ74USD4fuAVU/bX
	a5Rkmy+M0A7UjgBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728375218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s19y3MbDqKaGhgKApryzrv6Z6W35csossCcX0lXqfTo=;
	b=PDpTIbohARLrpQruIt3TPOzoLwdQ1mCG2tYlRaoR1zYgjA5T4aHxI5IjsewIWbRd3dDGy7
	kMw+nBUgq+DN10mBWbvezHfQo2cawq2HjFwx98XybEaNWuTRXKiEPUFxJsSqYp0udVEC0C
	d6kFSpwsd80cPMtcxLX/3B4aSiKaFuk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728375218;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s19y3MbDqKaGhgKApryzrv6Z6W35csossCcX0lXqfTo=;
	b=X42Kpznv/Bmi2ld0rHJpMt0Y8JqynChE4V9POUbG2IOCcfyfyA8j7EbueVQGanz1PoW890
	PtRQMaGkfJzaGhBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9CE2E1340C;
	Tue,  8 Oct 2024 08:13:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LPIVJbLpBGemHQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 08 Oct 2024 08:13:38 +0000
Date: Tue, 08 Oct 2024 10:14:34 +0200
Message-ID: <87ldyzvwnp.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	duoming@zju.edu.cn,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound:aica:Remove unused variable
In-Reply-To: <20241008061357.12042-1-zhujun2@cmss.chinamobile.com>
References: <20241008061357.12042-1-zhujun2@cmss.chinamobile.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Tue, 08 Oct 2024 08:13:57 +0200,
Zhu Jun wrote:
> 
> The variable is never referenced in the code, just remove it
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

Applied now, thanks.


Takashi

