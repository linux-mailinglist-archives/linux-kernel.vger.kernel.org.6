Return-Path: <linux-kernel+bounces-230104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3E5917867
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7399A1F21F43
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 05:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4975214D2A4;
	Wed, 26 Jun 2024 05:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e9rC+Fmg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0Y5SL1IM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X7GhUBHi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C/bdMNXX"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6819B14A4D0;
	Wed, 26 Jun 2024 05:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719381514; cv=none; b=GPruFIEtYz2TdXeckvxTUD62YJMWRbcVooHYiDhEaqfS4FZQ55/kI8GOfcffOsk86SjzIe3IIoIxzMBjk8KjjfeDMBY7JZlKnr0+hsGU3GsuZMPzWXYFInvG3S3vWr3GnrlHNspN0G1hMXxWgcFXaeQx/Ms7IG4nm7L+3ZdQwkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719381514; c=relaxed/simple;
	bh=inVXOAMIdOZjO3QO75g9cTCjaOkAQugpokklTpMiCRI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zf40JiwYc0yqwsGokMsmtXzSDla+3NYR1g8TsnDL953j1+1DVipU5ORXpUeg1GCCvu0G986SNxolT/Zl0q9/ivRYQw2yRwjeXcFNb3J0/5+rV5F56fqWxbcfY8Ek3eP+SWJ8g6NYxAMuW7YW3DglayEFddpxCCV4+UMVsUxecEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e9rC+Fmg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0Y5SL1IM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X7GhUBHi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=C/bdMNXX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EB8FB1FB3E;
	Wed, 26 Jun 2024 05:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719380995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j/rEw1FTMyOhY9HcnraTtAszd9vB9c1FXutJrwG1tbw=;
	b=e9rC+Fmg7+qpgN6VhN1hDSByLi5jKcsnpqp3/hS5cTGB+SkcIuJzoIVCyJg4/mje2CCOih
	PNiHaYpJ0/aFrvODbJFyZVYg5YejyZq0YAJgCugu+tAyT353PWBZ8ImiI+ZKHz0xRIoluO
	i5UAsugD0oQTt6RCHk11jC92SDqhRnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719380995;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j/rEw1FTMyOhY9HcnraTtAszd9vB9c1FXutJrwG1tbw=;
	b=0Y5SL1IMYVt16dABNhPuEGxRB3SD+Q7hWlnKeCTtEaqEL9t3ry3iNMquJP3UEQoUPkVRoF
	WnIMFKLbmIWEmOAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719380994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j/rEw1FTMyOhY9HcnraTtAszd9vB9c1FXutJrwG1tbw=;
	b=X7GhUBHiXtwPhA49sxEFcxjL2Vi07x8dZg1bMj5EGvRIA8V6lEVmgXwtdOtqlgOdrncBH0
	PZdbAhK3rkAEUHeYE+XzgyQhv+IJk8dg45cxwgg0mJCPsIXoGbscvAy7MYcjYGyerueHTq
	VQF+BZeAKu4UEcTiYk74aF4Yy9NXyMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719380994;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j/rEw1FTMyOhY9HcnraTtAszd9vB9c1FXutJrwG1tbw=;
	b=C/bdMNXXI2TMRncdE+24AqnfuZ8sEmhADpcy35Kgvm04mIf0d7fvJHsUbSJKY65ECZwNZQ
	7Zl3fCceBpoFg9CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B3DA13ABD;
	Wed, 26 Jun 2024 05:49:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nao+IAKse2YeLQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 26 Jun 2024 05:49:54 +0000
Date: Wed, 26 Jun 2024 07:50:21 +0200
Message-ID: <878qysl0bm.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Dirk Su <dirk.su@canonical.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Kailang Yang <kailang@realtek.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Athaariq Ardhiansyah <foss@athaariq.my.id>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	linux-sound@vger.kernel.org (open list:SOUND),
	linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] ALSA: hda/realtek: fix mute/micmute LEDs don't work for EliteBook 645/665 G11.
In-Reply-To: <20240626021437.77039-1-dirk.su@canonical.com>
References: <20240626021437.77039-1-dirk.su@canonical.com>
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
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Wed, 26 Jun 2024 04:14:36 +0200,
Dirk Su wrote:
> 
> HP EliteBook 645/665 G11 needs ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF quirk to
> make mic-mute/audio-mute working.
> 
> Signed-off-by: Dirk Su <dirk.su@canonical.com>

Thanks, applied now.


Takashi

