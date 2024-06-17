Return-Path: <linux-kernel+bounces-217261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9BB90AD8F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 416AAB25DD9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FFE17FAA2;
	Mon, 17 Jun 2024 12:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="klGPBevZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SafsiLJh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="klGPBevZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SafsiLJh"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93A61C2AF;
	Mon, 17 Jun 2024 12:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718625616; cv=none; b=rsDbxP8ErtIZOduTVl3znil4raj6ASFkxAfSWKEgOHJK/nB4e6I2QVc4awSX1MzqhzA/1ozGyNN7yw3XLhmb+myUcOP2woJ1k2qOJc1Z5Kx7NBE/KsKvMHnOoF69PGz0SKsOpMaxihfBMauybygNZxqEUukT8hPGfUPfhRE+hKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718625616; c=relaxed/simple;
	bh=LhQnlW331mh5qq6eTi31GkDvdypq3w2H94BZqhZHbZE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qs+bDb7IfbYBujp+T8QeMaMsyRaq0SoDnvOGk5CTs6pCu4qxd4hF2+MEx2g1VGPBfBQQvpu14ei/k3Mmc0fNFxNWElsfzeGEsZDdc584KRV+eC7IqbhFDljUj7zQzm4rsZPJ7l4JaJ8a+VWtELcwN6FJT7hHTDXPPRPEeneMtOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=klGPBevZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SafsiLJh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=klGPBevZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SafsiLJh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A3D9460008;
	Mon, 17 Jun 2024 12:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718625612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UgOV33l01jKCuWyhutocUQqIX3MFKi+pED6h55yk5ZI=;
	b=klGPBevZI/m/BSwBSRTkqFkJEP5/ei1Cw5dsymo5fU3QkixNkWBC0xZHVUA+hFB6nLK0+H
	xjOIaT//P+0shzA3bi1npnHM6A4+y6bySqQ+Zf7h8wdXMTJNHjbVVKUHulTJj/+spKn+6U
	G8GfIhulHLQ2arrNTye5QeT8MgX6kX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718625612;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UgOV33l01jKCuWyhutocUQqIX3MFKi+pED6h55yk5ZI=;
	b=SafsiLJh8T1F9o4FNEndY5h8WMlcdHQsBWRiuUpnv0ke8SUXIit3Vcr3GKK7awafLKqFbu
	ZgzsZNISRmD5d/Bw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=klGPBevZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SafsiLJh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718625612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UgOV33l01jKCuWyhutocUQqIX3MFKi+pED6h55yk5ZI=;
	b=klGPBevZI/m/BSwBSRTkqFkJEP5/ei1Cw5dsymo5fU3QkixNkWBC0xZHVUA+hFB6nLK0+H
	xjOIaT//P+0shzA3bi1npnHM6A4+y6bySqQ+Zf7h8wdXMTJNHjbVVKUHulTJj/+spKn+6U
	G8GfIhulHLQ2arrNTye5QeT8MgX6kX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718625612;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UgOV33l01jKCuWyhutocUQqIX3MFKi+pED6h55yk5ZI=;
	b=SafsiLJh8T1F9o4FNEndY5h8WMlcdHQsBWRiuUpnv0ke8SUXIit3Vcr3GKK7awafLKqFbu
	ZgzsZNISRmD5d/Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CB28139AB;
	Mon, 17 Jun 2024 12:00:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sm0RHUwlcGYeJwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 17 Jun 2024 12:00:12 +0000
Date: Mon, 17 Jun 2024 14:00:38 +0200
Message-ID: <87jzin93tl.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: bo liu <bo.liu@senarytech.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4] ALSA: hda/senarytech: add senarytech codec support
In-Reply-To: <20240617014634.63994-1-bo.liu@senarytech.com>
References: <20240617014634.63994-1-bo.liu@senarytech.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A3D9460008
X-Spam-Score: -3.39
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.39 / 50.00];
	BAYES_HAM(-2.88)[99.47%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Mon, 17 Jun 2024 03:46:34 +0200,
bo liu wrote:
> 
> Add initial Senarytech codec support for SN6186. Note that this hda
> patch relies on the configuration default registers to be set correctly
> (normally by BIOS/firmware) in order for it to set up pin widgets
> properly.
> 
> Signed-off-by: bo liu <bo.liu@senarytech.com>

This resulted in a build error when CONFIG_WERROR=y:

sound/pci/hda/patch_senarytech.c: In function ¡senary_auto_init¢:
sound/pci/hda/patch_senarytech.c:134:29: error: unused variable ¡spec¢ [-Werror=unused-variable]
  134 |         struct senary_spec *spec = codec->spec;
      |                             ^~~~
cc1: all warnings being treated as errors

It's senary_auto_init().  Could you fix and resubmit?


thanks,

Takashi

