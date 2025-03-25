Return-Path: <linux-kernel+bounces-575149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF94A6EE46
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 064553B593C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818CA25522B;
	Tue, 25 Mar 2025 10:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wJhjptq3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TzxyWRWf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wJhjptq3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TzxyWRWf"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6523C253F00
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 10:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742900115; cv=none; b=XUQkxLTqbuqUtmlXtej6tcYCH+xR3i3JFwGpLYdrgy2sf4UBjP3dyFAIvl321NjGpRPJHumILUtMX8uNuPnCDFMdZ0U92vTn77PvfT7vG9zuWxcFYfmgnSgmuMuxQ1nX24eCgLBDmVtmyAS5tgP+EGXjjpLe5GTb4Vj3CZIZJxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742900115; c=relaxed/simple;
	bh=YylJy3yAARQd8KBGJ0HVDpapnVnO2xHAN/fPPUzMW/A=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sQExaUgjQI7Zu4hsHq7ulsmPPOLrjuFjckaiQN41Yan7VY9n8XvlQoTYkcU/V121G/6HbjfGLLOfRjCUsSJplbzBwE8BBCGAf0eNo3jAhyKWPGnyszpJj2C0tEVKSGKGdw3dBJCSJlSfebI12JD2WGdi9fRzvCoeiR3wgRFSN2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wJhjptq3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TzxyWRWf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wJhjptq3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TzxyWRWf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 84A002116C;
	Tue, 25 Mar 2025 10:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742900112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=89Y4yu3i2TxcxhT8wOczL77W6mneQx77O599Opfu2b4=;
	b=wJhjptq3Q2BnWWaQ/XX3Ytm2HJv9LzTQU/8rF58XDcYKepLJhO3F2PdEJMVmveJsnZSVa6
	E8gnsgRx1aHiHiUmNIytLmkESJlRk+Zs0zMa5PoJZ3QbTvBi2UYtSCifS9jCAldXJHHgSi
	fZ31uDyZPpDQyel4CIckiIegbFUpGLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742900112;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=89Y4yu3i2TxcxhT8wOczL77W6mneQx77O599Opfu2b4=;
	b=TzxyWRWfTRftw2LUsUH6A/DjJebNXwr3Sni/WyE7/eKWqg2E90yj8d6xtlO4pknsQZjg5G
	qylWPEDK1w/RzEDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wJhjptq3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TzxyWRWf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742900112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=89Y4yu3i2TxcxhT8wOczL77W6mneQx77O599Opfu2b4=;
	b=wJhjptq3Q2BnWWaQ/XX3Ytm2HJv9LzTQU/8rF58XDcYKepLJhO3F2PdEJMVmveJsnZSVa6
	E8gnsgRx1aHiHiUmNIytLmkESJlRk+Zs0zMa5PoJZ3QbTvBi2UYtSCifS9jCAldXJHHgSi
	fZ31uDyZPpDQyel4CIckiIegbFUpGLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742900112;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=89Y4yu3i2TxcxhT8wOczL77W6mneQx77O599Opfu2b4=;
	b=TzxyWRWfTRftw2LUsUH6A/DjJebNXwr3Sni/WyE7/eKWqg2E90yj8d6xtlO4pknsQZjg5G
	qylWPEDK1w/RzEDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C8D2137AC;
	Tue, 25 Mar 2025 10:55:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pjt4EZCL4mdgUgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 25 Mar 2025 10:55:12 +0000
Date: Tue, 25 Mar 2025 11:55:11 +0100
Message-ID: <87ldstcrcg.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: cs35l56: Remove unnecessary NULL check before release_firmware()
In-Reply-To: <20250325084639.801054-1-nichen@iscas.ac.cn>
References: <20250325084639.801054-1-nichen@iscas.ac.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 84A002116C
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 25 Mar 2025 09:46:39 +0100,
Chen Ni wrote:
> 
> release_firmware() checks for NULL pointers internally.
> Remove unneeded NULL check for fmw here.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Thanks, applied now.


Takashi

