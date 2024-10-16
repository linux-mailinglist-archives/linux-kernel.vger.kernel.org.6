Return-Path: <linux-kernel+bounces-367600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 833FA9A0445
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B56671C2759F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962AF1D9A63;
	Wed, 16 Oct 2024 08:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QNSXilJz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nA7hsqFw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Wk7VZ7jh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="r2OTPr0V"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EB81D9A52;
	Wed, 16 Oct 2024 08:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067374; cv=none; b=lUMq9cH+CHl1HpDVh1R+4/Jja9bd4h075NlnbkgvDImWTMo3rBZoo0bVac83OskcAq/gn1i3nX+SP+TDbzTmXQ37ee+RA7dj9cfWJ9M/DXcBJjl3q01pLe8SE4HUj8AQ3SInxIH79tMoID+pSDe51GqsxkSGPlg3HzbbuSZSvJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067374; c=relaxed/simple;
	bh=2QVud6rRTEq78ehgnvE0AWq3Mxfx3WIffvwH5c15mIo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lEBhG2BU6ugJg7YYnacEIVla4kzDGv+E4Tf2SwGRCkMN+Epti0BI1hcHPFVOyIQg7k46/F6r3vqT6759MemeSqvEi0ywRptU8U9Pu9NtyFNbVBo3Bs3XE8RmU9WbrAtfVC7lKJEiJjdW+PO7jnYvAogG+8qTwK4ROpJjvjUrUKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QNSXilJz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nA7hsqFw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Wk7VZ7jh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=r2OTPr0V; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E037A1F83B;
	Wed, 16 Oct 2024 08:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729067365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LwXyh//LfRGrt4mj3bboVfc5hV0Wk7tWmfJNiNKL6Hs=;
	b=QNSXilJz+nzSKzxMAP56rvJrsea8kSlX3stK/Gbxyne7RE91dZluwXjkLK0OFwxW4EnD3Y
	/zaOrwyWih08zFM+6Esj8TuUwtQhJY4UuYvSBaAw4rpNvrK1lpaX7d3u2he1j1UAJ0Vn6r
	wroQaM+V/TDd7S9wjASQKQ9jdM6ItDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729067365;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LwXyh//LfRGrt4mj3bboVfc5hV0Wk7tWmfJNiNKL6Hs=;
	b=nA7hsqFwT6atk0P2lnXvwlfGYnDRUrCePbCK0HBLUz+fCYAFTZKSDN5nLM59V1IxESKrYl
	uXfevklELnyOciCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Wk7VZ7jh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=r2OTPr0V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729067364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LwXyh//LfRGrt4mj3bboVfc5hV0Wk7tWmfJNiNKL6Hs=;
	b=Wk7VZ7jhaWxAJwRN9MPq8GDSNquTpwFYzO+1GFj9V281jIA/A4tTRYMQKN0hSnLLuNWEIC
	uWUMSONUGP40H0GNoGD/UTxfGHMGK6zNB3MU6Kg6jihHiOYYK7hLaoZnZMkqwHn8jpsxC4
	iwwsYza79RnrVZjnhjlzwY5Pw4w4x5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729067364;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LwXyh//LfRGrt4mj3bboVfc5hV0Wk7tWmfJNiNKL6Hs=;
	b=r2OTPr0VgueZDZr0+9PwirlvlEKB2MdLEIZBWDGdAVfdl1zZKEe0SeHPb4CGL1rtaLNPA7
	GGU4NIVRX2bTpGDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A611413433;
	Wed, 16 Oct 2024 08:29:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id N51DJ2R5D2cqJwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 16 Oct 2024 08:29:24 +0000
Date: Wed, 16 Oct 2024 10:30:22 +0200
Message-ID: <87frowtppd.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Vasiliy Kovalev <kovalev@altlinux.org>
Cc: Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] ALSA: hda/conexant - Use cached pin control for Node 0x1d on HP EliteOne 1000 G2
In-Reply-To: <20241016080713.46801-1-kovalev@altlinux.org>
References: <20241016080713.46801-1-kovalev@altlinux.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: E037A1F83B
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Wed, 16 Oct 2024 10:07:13 +0200,
Vasiliy Kovalev wrote:
> 
> The cached version avoids redundant commands to the codec, improving
> stability and reducing unnecessary operations. This change ensures
> better power management and reliable restoration of pin configurations,
> especially after hibernation (S4) and other power transitions.
> 
> Fixes: 9988844c457f ("ALSA: hda/conexant - Fix audio routing for HP EliteOne 1000 G2")
> Suggested-by: Kai-Heng Feng <kaihengf@nvidia.com>
> Suggested-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>

Applied now.  Thanks.


Takashi

