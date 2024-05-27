Return-Path: <linux-kernel+bounces-190144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5ADC8CFA29
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCB6B1C20D71
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180F017BC9;
	Mon, 27 May 2024 07:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Fa7czT0B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p3lf1QEG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Fa7czT0B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p3lf1QEG"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9D41F5FA;
	Mon, 27 May 2024 07:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716795026; cv=none; b=QkF8UeFALuMGgxPZ/CiQocRoQFfhJkTELzaW5cnYxx0RD2VZlnyEUzojC4v07IxemYwTrDM+FPBUvM9ZWPEOqmPlf3MGyDBwBmpA3PHkJf7hSqo+ViUggR6J7H0I12+M9AQNAWgT5S5QrRzrBjSlq5Yp9490xW+t4NZPcneelu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716795026; c=relaxed/simple;
	bh=kZOAFVEGf8BGOvGQnLyNxKGobzZ9MZiX4ytpEF7UloE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d4RAkpFQAjtSlTD8lG4ZBg/hn1fNNPzM8J4bwW0PLnt7VwA64piWoi2C1X9gWniDBU3S0ODBPzwv19NlObJkf7ljiIPdDW1dSnXQFCb+9n4aT/kS0DNJAP/Ea6MXbQOunc6z/bOrxQGnMVEQozQivVGfsTQEes8E9q2SL+PgQ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Fa7czT0B; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p3lf1QEG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Fa7czT0B; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p3lf1QEG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B849F1FB80;
	Mon, 27 May 2024 07:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716795022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gH7RK4lg/aTfFcwih3pLH5lRA1fX13MGIKzh6pvjK6w=;
	b=Fa7czT0BAXh3r5Vm0tHOnLyysm7sQYi2ZGW2/vMPswE8TzjWFSDKBcm9LZcEYM3+I4uIKD
	C0b406VQJ4hiiYXRrq9/7tuGj9k3QA80n+f0+vGFkjBHLJ5WgZ7CfqhFg/nyoPj9RNCcN6
	6cpnGp4e0psmlOc3vMfHyrPXApfimu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716795022;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gH7RK4lg/aTfFcwih3pLH5lRA1fX13MGIKzh6pvjK6w=;
	b=p3lf1QEGztjeEbe44P9J5mT3ecv2ZF/DlrNx6rbLuU4z1jWHv/4QLIPGycZ/tM9PAOROfB
	Z8QHUkM3ATDdHADg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Fa7czT0B;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=p3lf1QEG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716795022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gH7RK4lg/aTfFcwih3pLH5lRA1fX13MGIKzh6pvjK6w=;
	b=Fa7czT0BAXh3r5Vm0tHOnLyysm7sQYi2ZGW2/vMPswE8TzjWFSDKBcm9LZcEYM3+I4uIKD
	C0b406VQJ4hiiYXRrq9/7tuGj9k3QA80n+f0+vGFkjBHLJ5WgZ7CfqhFg/nyoPj9RNCcN6
	6cpnGp4e0psmlOc3vMfHyrPXApfimu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716795022;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gH7RK4lg/aTfFcwih3pLH5lRA1fX13MGIKzh6pvjK6w=;
	b=p3lf1QEGztjeEbe44P9J5mT3ecv2ZF/DlrNx6rbLuU4z1jWHv/4QLIPGycZ/tM9PAOROfB
	Z8QHUkM3ATDdHADg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E58413A6B;
	Mon, 27 May 2024 07:30:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +WY1F442VGYiMwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 27 May 2024 07:30:22 +0000
Date: Mon, 27 May 2024 09:30:43 +0200
Message-ID: <87ikyzlnj0.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Luke D. Jones" <luke@ljones.dev>
Cc: tiwai@suse.com,
	perex@perex.cz,
	sbinding@opensource.cirrus.com,
	kailang@realtek.com,
	shenghao-ding@ti.com,
	simont@opensource.cirrus.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Adjust G814JZR to use SPI init for amp
In-Reply-To: <20240526091032.114545-1-luke@ljones.dev>
References: <20240526091032.114545-1-luke@ljones.dev>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.42 / 50.00];
	BAYES_HAM(-2.91)[99.60%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B849F1FB80
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.42

On Sun, 26 May 2024 11:10:32 +0200,
Luke D. Jones wrote:
> 
> The 2024 ASUS ROG G814J model is much the same as the 2023 model
> and the 2023 16" version. We can use the same Cirrus Amp quirk.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>

Thanks, applied.


Takashi

