Return-Path: <linux-kernel+bounces-433354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8228E9E5759
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 14:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C3F9283F6B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A59218AAE;
	Thu,  5 Dec 2024 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z4H9n/v3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="moQNLK5n";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z4H9n/v3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="moQNLK5n"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581F5199FBB;
	Thu,  5 Dec 2024 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733405824; cv=none; b=MZE0X3PqlooITJzNkHrEDvYNK/9qsCPpyPYNWsvHMzZ//syJZIsqo6YBwcqS4LaAOMjh35EWqKFu6s+jIMQ+TP1Feo7+OtCA90mt71R991ShU6pLdykcxAsdX9x7bYgUI/GnybB3KEGM02HP0zoEkgQmue2up5sTSoahdBHcHsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733405824; c=relaxed/simple;
	bh=tZvaQMgSsfB6+PBvwNIpceoyFDrmiZGALLuK77coPek=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rC8HFq7epmypFY2fhBAAau2lPf1DlVxakl3e3RWXEEbqeIuAC7IceE2h6zxE71Uji+B1NcVHDkBYcVzxKBlVxRjW87PXZ3YL7FAdDZIZo3TUjJGdVagVUWAoac/hhv/KCSHm7tHBTD1zMABbwmMjQeiW/qFjX7u+08i/fnbWSBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z4H9n/v3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=moQNLK5n; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z4H9n/v3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=moQNLK5n; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 725FC1F38F;
	Thu,  5 Dec 2024 13:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733405820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N51jm9ZvQlnU9MCAiRdF9dKQoZU/Xf+qDWzFsCOWkmI=;
	b=Z4H9n/v3ilqmpWjpDw1wwV70YJfULXcJBRi4XGrLXDbXObexkqxc1HnFBIqCGxpJfxEr8D
	cL+s/xDNgj3InYJzRDtYeEf/Ow5umB3Qa9JcIE5xg0fphZmJIKjmXfPA3Zp+YZAcYv3coN
	ZpX/XAOTEcZa+pXMu3z1mcOlHxdcY6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733405820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N51jm9ZvQlnU9MCAiRdF9dKQoZU/Xf+qDWzFsCOWkmI=;
	b=moQNLK5n8AXwaCuTxajB8MTlGAmwSmnZpsMJGtrsWzp9QdmI9/DXWP4FTSI5vPW0agh/8z
	vcdEX6Pd11UJA4Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733405820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N51jm9ZvQlnU9MCAiRdF9dKQoZU/Xf+qDWzFsCOWkmI=;
	b=Z4H9n/v3ilqmpWjpDw1wwV70YJfULXcJBRi4XGrLXDbXObexkqxc1HnFBIqCGxpJfxEr8D
	cL+s/xDNgj3InYJzRDtYeEf/Ow5umB3Qa9JcIE5xg0fphZmJIKjmXfPA3Zp+YZAcYv3coN
	ZpX/XAOTEcZa+pXMu3z1mcOlHxdcY6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733405820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N51jm9ZvQlnU9MCAiRdF9dKQoZU/Xf+qDWzFsCOWkmI=;
	b=moQNLK5n8AXwaCuTxajB8MTlGAmwSmnZpsMJGtrsWzp9QdmI9/DXWP4FTSI5vPW0agh/8z
	vcdEX6Pd11UJA4Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C496138A5;
	Thu,  5 Dec 2024 13:37:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r9zpDHysUWfFSwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 05 Dec 2024 13:37:00 +0000
Date: Thu, 05 Dec 2024 14:36:59 +0100
Message-ID: <87r06mtfno.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: lola: Fix typo in lola_clock.c
In-Reply-To: <20241205095156.17837-1-zhujun2@cmss.chinamobile.com>
References: <20241205095156.17837-1-zhujun2@cmss.chinamobile.com>
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
	BAYES_HAM(-3.00)[99.98%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 05 Dec 2024 10:51:56 +0100,
Zhu Jun wrote:
> 
> The word 'ajustement' is wrong, so fix it.
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

Thanks, applied now.


Takashi

