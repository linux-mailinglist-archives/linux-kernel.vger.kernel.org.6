Return-Path: <linux-kernel+bounces-310613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 179B6967F18
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5D121F2252F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 06:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAA9154C04;
	Mon,  2 Sep 2024 06:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iZoHUEEk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NreKgMPv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iZoHUEEk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NreKgMPv"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC13F76048;
	Mon,  2 Sep 2024 06:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725256972; cv=none; b=rda5EMLMFTykYQukrKf0JZOlbjY9Gf+cjj+IPBWyUB/B+RvyGQ6GUGuTivRf1uU0haKG0idGvn4a4c0UvDZJw3c7R+vWwNG9FZwuw/6b0KSkd3ForITS1iGH+ueDgY9CV6J2TbZxusztANjtE1MRpNsvmlrFG8i66N3Z5VD4AbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725256972; c=relaxed/simple;
	bh=1++mAhyIz10QUhGalaHZiJ5iYXrg+KufP+6ktjmElnM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pG1biQi273J+Vmt+7ZTq58I2r04zi0iGOp8caVoTaAFKpIvJ9pEX2VSFVy+muuiFN+h/9ajKYoUzNanj3j8fjhqd9xn3BxgwFLL0XRHRGwGGl70s3K/zRE6Xu5vs/nkqNdBKZjtGAeWXWhwk03xadU6TYem8KSEXYLWC9yuB8xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iZoHUEEk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NreKgMPv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iZoHUEEk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NreKgMPv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0698221B14;
	Mon,  2 Sep 2024 06:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725256968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AfiN2DBqhgu0TrFyXWh4/vcmeInhhytqO+aujGbBy2A=;
	b=iZoHUEEkSg6fHuHlbUBbkIIsbQs5LOj9YD5lDa83kn9toVPV2IBz3xcAbMqx7U4VfulnUr
	h7W2JD8Q5HYkOrIg8n7sKriWN5sgV7DrUoaHo5Fju3WtLbiwndybmv8zksvz6JlZvZp5oC
	/ixA0e01KKOUIiwlot3uLTBEacoXDJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725256968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AfiN2DBqhgu0TrFyXWh4/vcmeInhhytqO+aujGbBy2A=;
	b=NreKgMPv6eDm/xoMrSV5P7qRnOQ8jT75HPNNR65+tmCUsvbfLebyVKnrqdvLuWlojWoE5a
	d5nPTJSlsgqueuDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iZoHUEEk;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NreKgMPv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725256968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AfiN2DBqhgu0TrFyXWh4/vcmeInhhytqO+aujGbBy2A=;
	b=iZoHUEEkSg6fHuHlbUBbkIIsbQs5LOj9YD5lDa83kn9toVPV2IBz3xcAbMqx7U4VfulnUr
	h7W2JD8Q5HYkOrIg8n7sKriWN5sgV7DrUoaHo5Fju3WtLbiwndybmv8zksvz6JlZvZp5oC
	/ixA0e01KKOUIiwlot3uLTBEacoXDJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725256968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AfiN2DBqhgu0TrFyXWh4/vcmeInhhytqO+aujGbBy2A=;
	b=NreKgMPv6eDm/xoMrSV5P7qRnOQ8jT75HPNNR65+tmCUsvbfLebyVKnrqdvLuWlojWoE5a
	d5nPTJSlsgqueuDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C813913AE5;
	Mon,  2 Sep 2024 06:02:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uc/ALgdV1Wa4FQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 02 Sep 2024 06:02:47 +0000
Date: Mon, 02 Sep 2024 08:03:33 +0200
Message-ID: <874j6yk2x6.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ALSA: ali5451: Remove trailing space after \n newline
In-Reply-To: <20240901162125.144069-1-colin.i.king@gmail.com>
References: <20240901162125.144069-1-colin.i.king@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 0698221B14
X-Spam-Level: 
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.01
X-Spam-Flag: NO

On Sun, 01 Sep 2024 18:21:25 +0200,
Colin Ian King wrote:
> 
> There is a extraneous space after a newline in a dev_dbg message.
> Remove it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thanks, applied now.


Takashi

