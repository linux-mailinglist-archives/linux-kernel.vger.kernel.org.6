Return-Path: <linux-kernel+bounces-219002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CEA90C89F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1D61F21137
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C5620A94A;
	Tue, 18 Jun 2024 09:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IsgqsHoE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bpTQTt26";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IsgqsHoE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bpTQTt26"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C7F20A930;
	Tue, 18 Jun 2024 09:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718704555; cv=none; b=X5DrPXpm7KMzwCSWEVpXz5SvOBBkFC4xa0ns5FyL4vilPJ9mu7QlsQok5LOb7ZCOC+6vfHEvylHG2+9Ra+PeNwJhRYKES9QcfMjYxUQKlOzbPgIgowQZ2Le12XCrekEfpOvsoQpHVyCy+sHpLyBaKFMPj1bojCLUU0vSH3CPXoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718704555; c=relaxed/simple;
	bh=AJMj7ek0kowPMFtSbr2GJIvvNf2d7aDR47y2G/QEHhs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ObDB/D5BCuQtahPCMLoFY7Wo1H9toWjrdu7U9X2V2rtxzQ89do3pkAMgOcidUEM6/+dQQjux07kH5SEbxLqzCafV6icjlIFDF3lKpqr3Mxx+dXrO/rsRq5AkOeGeDdx2XLDaDjIyRfbBoVr9Gk3lcJkOe29ST+QQT0k7J4ukxc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IsgqsHoE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bpTQTt26; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IsgqsHoE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bpTQTt26; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 641CE219BC;
	Tue, 18 Jun 2024 09:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718704547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Go1j8HvK+MGc8aAcWocej2QyY55edzekY9cQ6sslnE=;
	b=IsgqsHoElwkPnDB4RqeWcJt/6pXKQnVmVTV1Gn0VYbjMB5uw+rrMs4YJn6vGQYxw+cuzlD
	ZUiNU7WmP+RyNs8kr6v2Ro9gfNiDhxG3bQ5CqQwfkn6XAVLMRW/LfYrDifRDw8BOUTCtef
	YXkYtqExr5xth8RSjcFNNp9QQM79oZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718704547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Go1j8HvK+MGc8aAcWocej2QyY55edzekY9cQ6sslnE=;
	b=bpTQTt26LgOqm53oeu/YTkgbJwrmObi9bDmVIFUMsv944g1AuXAMjPUvk9Y7th7yh7skSb
	FVwvBwi6oHYbi7CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718704547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Go1j8HvK+MGc8aAcWocej2QyY55edzekY9cQ6sslnE=;
	b=IsgqsHoElwkPnDB4RqeWcJt/6pXKQnVmVTV1Gn0VYbjMB5uw+rrMs4YJn6vGQYxw+cuzlD
	ZUiNU7WmP+RyNs8kr6v2Ro9gfNiDhxG3bQ5CqQwfkn6XAVLMRW/LfYrDifRDw8BOUTCtef
	YXkYtqExr5xth8RSjcFNNp9QQM79oZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718704547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Go1j8HvK+MGc8aAcWocej2QyY55edzekY9cQ6sslnE=;
	b=bpTQTt26LgOqm53oeu/YTkgbJwrmObi9bDmVIFUMsv944g1AuXAMjPUvk9Y7th7yh7skSb
	FVwvBwi6oHYbi7CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A7F913AA0;
	Tue, 18 Jun 2024 09:55:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Loh1EaNZcWZuIQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 18 Jun 2024 09:55:47 +0000
Date: Tue, 18 Jun 2024 11:56:13 +0200
Message-ID: <87jzim7ewy.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] sound/oss/dmasound: add missing MODULE_DESCRIPTION() macro
In-Reply-To: <20240617-md-m68k-sound-oss-dmasound-v1-1-5c19306be930@quicinc.com>
References: <20240617-md-m68k-sound-oss-dmasound-v1-1-5c19306be930@quicinc.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Tue, 18 Jun 2024 03:37:09 +0200,
Jeff Johnson wrote:
> 
> With ARCH=m68k, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in sound/oss/dmasound/dmasound_core.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Thanks, applied.


Takashi

