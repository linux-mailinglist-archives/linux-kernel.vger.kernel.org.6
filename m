Return-Path: <linux-kernel+bounces-536156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE79AA47C2B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C687E161CCF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDC922A4D1;
	Thu, 27 Feb 2025 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iJ3kK9UP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RrvvtCiw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="l44HVgjv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OjA8sjlx"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A659FEEBB
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 11:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655644; cv=none; b=ao8bLlQxzWXlWoOxbgUriFwUcifVQMmL+4zneaF36WlwauwdQNcCRfLHQNKucnL3D/q5FbEhi88ixPlupJDw0JfnEUcNKj6zdCLLN9vCnoe9ImGidwCBJOLJwcuO2dOY0oEr8jdeFq76OS56bz5sHeQVoA5LqVE1fnGm3UKzd94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655644; c=relaxed/simple;
	bh=zs+wipBB6EI2SgHutO+YSjvV5WeiVU+6n1r/9ljPsKU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O4kUSm6tzjG5OIeOKXMgwGQPmg5RkvYXFgE49Y11v/uRewy6zdGkeq+YH/0OF/dZgNVhMhd1oemAQya2GstnDC7C8tF0ypJwBhARKcCcKThjoSz+aAbZvmYWC5/7hpy2dUnkhaVuOfT+D4ULVjkylYpANfx9+KNIwI20iHDLgmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iJ3kK9UP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RrvvtCiw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l44HVgjv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OjA8sjlx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9D19621167;
	Thu, 27 Feb 2025 11:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740655640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zGuAnpU6GSIy+r3pRUVjS2FIbKS6VZvfKEB6+JTUNyU=;
	b=iJ3kK9UP3redPXEHigYcZ4yktuRinv4rH9ygfIIi/pQOOSPvdirj6RNIIePfkgqVrlSksP
	IRs3y36fL5yc8C+6+JM8FgR5UGzUhBZuHLgCncvh6pFzv09walFURRgbNa2P15BjlmfUvY
	UJY0TqhJrCXJd+slnjgBbv+6YaVIV8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740655640;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zGuAnpU6GSIy+r3pRUVjS2FIbKS6VZvfKEB6+JTUNyU=;
	b=RrvvtCiw/nHsEkfJaSsx68z5UOa9BYvj2zCsdmOC+IyTaustQ626cHsf8NYLwUFTEhDMF7
	vjPJ4xIuenIr8QDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740655639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zGuAnpU6GSIy+r3pRUVjS2FIbKS6VZvfKEB6+JTUNyU=;
	b=l44HVgjvCuP2QUuL2FyUSD52FuJi3mML6c00jRIVo3IyTp2sTbxZLNQPaBmmRllhSqj4Mk
	3WACXvSZsS2Hm2rNAIlsNuduLSp0Bq9S0VEW9E8BwHeWsPL0xXVPN6rsqznAMPw/8QzqJy
	mvJH3iVL4q8BHgvyyLNjOiWNfQihjUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740655639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zGuAnpU6GSIy+r3pRUVjS2FIbKS6VZvfKEB6+JTUNyU=;
	b=OjA8sjlxJQ7bu579TU3gPh+1di7N/CxlPfNk/m3vk2eZBOjm3i4xLnb7XV6IaoyiqHlafn
	6uCGOiHJmuEdIKBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5326513888;
	Thu, 27 Feb 2025 11:27:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TnyAEhdMwGeZOQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 27 Feb 2025 11:27:19 +0000
Date: Thu, 27 Feb 2025 12:27:18 +0100
Message-ID: <877c5b7hm1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Charles Han <hanchunchao@inspur.com>
Cc: <perex@perex.cz>,
	<tiwai@suse.com>,
	<oswald.buddenhagen@gmx.de>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Sound: pci: emu10k1: fix inconsistent indenting warning in snd_emu10k1_synth_free()
In-Reply-To: <20250227085243.18413-1-hanchunchao@inspur.com>
References: <20250227085243.18413-1-hanchunchao@inspur.com>
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
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,gmx.de,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,inspur.com:email]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Thu, 27 Feb 2025 09:52:00 +0100,
Charles Han wrote:
> 
> Fix below inconsistent indenting smatch warning.
> smatch warnings:
> sound/pci/emu10k1/memory.c:444 snd_emu10k1_synth_free() warn: inconsistent indenting
> 
> Signed-off-by: Charles Han <hanchunchao@inspur.com>

Applied with the correction of subject prefix now.


thanks,

Takashi

