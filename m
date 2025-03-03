Return-Path: <linux-kernel+bounces-544937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34ABAA4E7F2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D90BB8E105E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D15292F9F;
	Tue,  4 Mar 2025 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X2bY2xHa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Tkiy+ZMG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZTttCRHq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ChoIAOY2"
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B5F27FE6D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105337; cv=pass; b=nBVYx0O90DV1iAEoA9/YKFAkAT9QX7pJ3VL8n124LyLO1R0CqJ06rRMmRl2YeX6XuLO703E15ljPduy2LuvO91Le8zEIMRY79oXZHHulT38+dy26nCxMG2S1hs1AN5tHaAYqkCFxTA3C7twKO06ntkWxlVEibEcFeTQKILejdIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105337; c=relaxed/simple;
	bh=mwxaK4669S3GvHcRq4TyN7XjcNBKaAxeBjfvAWZvGvU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hu4Q12E4hgtQAm9GSlGhBIFiCr9i3eNzQW6bRuTW7u2QXE1r8LC5gNVySX/XlHOf3PAMLXXauVMCJZolehUYdceWKqDvRS81L4zuOF234WeEjRqdVdww+in+cAXXhy+C9HyX+SnnX+f8cotAgH4Og/psxk1bvobJv9AKw3wbza0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X2bY2xHa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Tkiy+ZMG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZTttCRHq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ChoIAOY2; arc=none smtp.client-ip=195.135.223.130; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 9487F40D4DD2
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:22:13 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=X2bY2xHa;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Tkiy+ZMG;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ZTttCRHq;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ChoIAOY2
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gsH2PqfzG33C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:20:51 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id B9A92400C6; Tue,  4 Mar 2025 19:20:42 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X2bY2xHa;
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Tkiy+ZMG;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZTttCRHq;
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ChoIAOY2
X-Envelope-From: <linux-kernel+bounces-541716-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X2bY2xHa;
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Tkiy+ZMG;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZTttCRHq;
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ChoIAOY2
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id C9D2E41DCB
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:41:08 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 7E48C2DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:41:08 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A26F41721E9
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F87120F09F;
	Mon,  3 Mar 2025 12:40:57 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176CF1E5B78
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 12:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741005654; cv=none; b=mGdtvO8g2aZEZlPvbaZei4Brt1iD0d1f9SEsoYSrD/4YQc2hXq0mSAkmI9hpTJYW1T3Jucll2vSg/r2UJigNRpnHWtn9RPFV4OHgPoRUe9Blf71pVr3153Xv1qtHTTbLF17dxYzgurCvNzdjvYQTb3k2t4x05GoHzUTh/E3PCSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741005654; c=relaxed/simple;
	bh=mwxaK4669S3GvHcRq4TyN7XjcNBKaAxeBjfvAWZvGvU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oePzK8eT7o5bLavrTjXc3Cv0c0pmFbMy3sXvHaRTRe/e2o8Rbgmy3RZ7fBB7AphhCrsemE9WIT89BzkraExgSCp61oXTkzZkPrhXoJBWMsYbsy5ZHn4wiF+OnYYi1w4VRNdz8fGK/Une6H5bdWGire7id1uj9yfF9/ly2Uzt784=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X2bY2xHa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Tkiy+ZMG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZTttCRHq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ChoIAOY2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ECFD021182;
	Mon,  3 Mar 2025 12:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741005651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LmIPuZjPI2XS9p2XhyzdtDrvchyUKON/ocNRWtdEE4g=;
	b=X2bY2xHaHp3YDYuWzIom/EYZzyvfZ5s2G6Cxph6GUGM0+yIAlQXK8UC6El8Wp20UHTTPM9
	p7qh+wIjAkC22bV8rDXiI6uATJoiaEI12N/iosXoxbqDcRw4Ql1plLBYer2Xipuu7o3Hm7
	XDFXgVqd3sq9DJBdicFa2nb4/a3jHOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741005651;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LmIPuZjPI2XS9p2XhyzdtDrvchyUKON/ocNRWtdEE4g=;
	b=Tkiy+ZMGFQrD79qaF1iVv54csXc+EqlAX/AtuCtzLwP+VaYU+dKZLR31eL1DbRc3KUxFki
	TRSu89Y7spVciRDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZTttCRHq;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ChoIAOY2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741005650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LmIPuZjPI2XS9p2XhyzdtDrvchyUKON/ocNRWtdEE4g=;
	b=ZTttCRHqnB6FDN91S/kzMvHah3d/sLBYe2bRZdzKPHlhbP5Yv5jwp2FLhra4JKmg7U9wJa
	mWXQvcpToWhyZXRYunVrI5UzAwHu9/9Q9QoYfvekhpdedRFb4e8+riihK+s7qL3WLEEFHh
	F83UtDtikn37qjJKl+I/nmXQGfxraW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741005650;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LmIPuZjPI2XS9p2XhyzdtDrvchyUKON/ocNRWtdEE4g=;
	b=ChoIAOY2h8408KaExQCSDVpmkk271GUtj+ajiU4eRyuBcwPf8YXSj38+yV6Y3YELlGiF/N
	JT7eoQv7WkmgKMCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD41213939;
	Mon,  3 Mar 2025 12:40:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UJu2KFKjxWdSSAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 03 Mar 2025 12:40:50 +0000
Date: Mon, 03 Mar 2025 13:40:50 +0100
Message-ID: <87o6yie17x.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Murad Masimov <m.masimov@mt-integration.ru>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: Re: [PATCH] ALSA: usx2y: validate nrpacks module parameter on probe
In-Reply-To: <20250303100413.835-1-m.masimov@mt-integration.ru>
References: <20250303100413.835-1-m.masimov@mt-integration.ru>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: ECFD021182
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gsH2PqfzG33C
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741710066.62434@KzW11T7BbNe7A+yQ6TIHew
X-ITU-MailScanner-SpamCheck: not spam

On Mon, 03 Mar 2025 11:04:13 +0100,
Murad Masimov wrote:
> 
> The module parameter defines number of iso packets per one URB. User is
> allowed to set any value to the parameter of type int, which can lead to
> various kinds of weird and incorrect behavior like integer overflows,
> truncations, etc. Number of packets should be a small non-negative number.
> 
> Since this parameter is read-only, its value can be validated on driver
> probe.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Murad Masimov <m.masimov@mt-integration.ru>

Thanks, applied now.


Takashi


