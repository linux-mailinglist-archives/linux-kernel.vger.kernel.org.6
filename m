Return-Path: <linux-kernel+bounces-358966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAA29985D2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B0DB281B87
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A16A1C4626;
	Thu, 10 Oct 2024 12:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Eota9niy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OWhiSjbv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Eota9niy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OWhiSjbv"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198491C461D;
	Thu, 10 Oct 2024 12:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728562942; cv=none; b=W0WFysWwELE2bRuw217vQsr84+9x7j4b1NRZD7H8rwDtXnO+mIwCK9KJLsNJhpPQ0D5O0lTzqA2pVVwsH9RK95O5GC5Btqy+jlUPp2LVvBXMvGJwg+x3FdRUiofSidW4vmeDCSS6sXWFCh12gIW2G8iHH8hgvT9envSYoa079GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728562942; c=relaxed/simple;
	bh=pF9sqy4VpT1yiIdmzxnljherPZdxbmq9WM4sPylqjjQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nvxPnlgTE916Vm0NyXdKE1e8iUasxHckMY+6hq0xeCK3nCNP4ri8h4XCm/V4jDDCkuKwviU6Tnkn05aJmk7PgmOLUDPFjrZH1w50RuBnTBWHE7yPmMB5r6xCY0NqK2zl6+ae5YzCBWl2ND106QsIPJ2XrfuchTRBvFHaUdHikmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Eota9niy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OWhiSjbv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Eota9niy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OWhiSjbv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5668F1FE4C;
	Thu, 10 Oct 2024 12:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728562937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ei8nontnfrkxnbvy1eKc0pyW434N6/D26yPcYL3+WQA=;
	b=Eota9niy7pEO05YzyPiSD6m5UjI41uyTRhUu90ZvkqQQusfdHVizDns+9esK211rVPIb21
	SBXAGQKv1tZU8F0yclNliuTAMxzAdA+oRXR46eMFzZJdkzvvMgwopn0GDWovu1C7B5IqLT
	uI+T56nOKsmf0tRwTR1Jk/H8OV37IPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728562937;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ei8nontnfrkxnbvy1eKc0pyW434N6/D26yPcYL3+WQA=;
	b=OWhiSjbvt7UNO77l3ufCUSfwDrVSTqbZ0Jh1oSMBSoZ8rD/avhoIrPOKo36Kve/pWKEBS4
	QLLSafwcNMJDcxBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Eota9niy;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OWhiSjbv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728562937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ei8nontnfrkxnbvy1eKc0pyW434N6/D26yPcYL3+WQA=;
	b=Eota9niy7pEO05YzyPiSD6m5UjI41uyTRhUu90ZvkqQQusfdHVizDns+9esK211rVPIb21
	SBXAGQKv1tZU8F0yclNliuTAMxzAdA+oRXR46eMFzZJdkzvvMgwopn0GDWovu1C7B5IqLT
	uI+T56nOKsmf0tRwTR1Jk/H8OV37IPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728562937;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ei8nontnfrkxnbvy1eKc0pyW434N6/D26yPcYL3+WQA=;
	b=OWhiSjbvt7UNO77l3ufCUSfwDrVSTqbZ0Jh1oSMBSoZ8rD/avhoIrPOKo36Kve/pWKEBS4
	QLLSafwcNMJDcxBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22C131370C;
	Thu, 10 Oct 2024 12:22:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uioWB/nGB2fdPgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 10 Oct 2024 12:22:17 +0000
Date: Thu, 10 Oct 2024 14:23:13 +0200
Message-ID: <87set4170u.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: tiwai@suse.com,
	perex@perex.cz,
	kl@kl.wtf,
	k.kosik@outlook.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: Use snprintf instead of sprintf in build_mixer_unit_ctl
In-Reply-To: <20241009070944.6937-1-zhujun2@cmss.chinamobile.com>
References: <20241009070944.6937-1-zhujun2@cmss.chinamobile.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 5668F1FE4C
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[outlook.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,perex.cz,kl.wtf,outlook.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Wed, 09 Oct 2024 09:09:44 +0200,
Zhu Jun wrote:
> 
> Simplified code by removing redundant assignment of sprintf return value
> and improved safety by replacing sprintf with snprintf.
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

Thanks, applied now.


Takashi

