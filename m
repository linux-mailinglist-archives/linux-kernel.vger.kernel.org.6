Return-Path: <linux-kernel+bounces-290984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D194955BDA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 09:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A72E2824C5
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 07:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0AA17580;
	Sun, 18 Aug 2024 07:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BDgt3Up2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dzPgriQl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1LMtm2a9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AE9vcJkG"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13298168B7;
	Sun, 18 Aug 2024 07:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723967294; cv=none; b=P9DO3pJ1khiUoPbSzY8vC8pJxcWJmzPZx67Hxm9FOB1vHRrSOBmhq2nl5KcBt03q+YQVq9xwAA7WLoRkZEXZn5eLnh7vNkzChbW/8tN8BG2NmgZJpAFnie9GPKoSxup2yoGsH8o9FUyq8s7wjRE1EOpf53AkvqaRHYlidiGsfRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723967294; c=relaxed/simple;
	bh=tHhFfxZzfIHmMVt+pbcC06wUVLu9JX6dcsd/xbm0K8Q=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rW9Dtu7WLECswRmc7AoWQnNSifLmSa4HDIieAxbXcyzKtINjykaU+0e7wNwuJzuOSOQUyKxMd0fFF5CEJYumP1E457EQT0c5xHEcpquWnUgIosSi8PS90TwL/UjMf+k2dkoZaiFm1pM14/5j9QfMrRl6Zx8ecwqPE5N1+YbLDog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BDgt3Up2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dzPgriQl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1LMtm2a9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AE9vcJkG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EDF361FBAF;
	Sun, 18 Aug 2024 07:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723967290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KFt+fryGiy5QNhJpernVmvnKt0akeRceLuutIY5Z7Rw=;
	b=BDgt3Up29G+KbQErme7F3D0slDzGV+fhIIkHwkiikZV442M503Cz83ORnHs4F8zuVVKbUS
	EP/RmUSZ6jHpe9qkJnkOrm4LKadAYMSWw56eFl38c5hHeIXmn7tqfvjw+gr4LX6KMo9qhG
	/sva89y/O6p5VAMxn70UTufWPEClH1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723967290;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KFt+fryGiy5QNhJpernVmvnKt0akeRceLuutIY5Z7Rw=;
	b=dzPgriQleAllmP0huwXPJaHuWPRMysAm92xpVRaNEnKT93szpg87ilNg+9xB5vff0jTSiO
	NRW76IkhnQyPdBDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723967289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KFt+fryGiy5QNhJpernVmvnKt0akeRceLuutIY5Z7Rw=;
	b=1LMtm2a97q5zjd4ZYdbjzUkzoyaTXwOkKVZ3I06fv1Ln9la49GcPvfahlo9CCb9KU4qHvh
	aCy4O/hEn5AES5K/Iat6yFXFUaGxocwlJvocIsS1kXYukkCbWH9XA5Wj0vi7ucBfMkiQVG
	i2a7X4gW4h3kR4lcxu/uJo2CuAH8DN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723967289;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KFt+fryGiy5QNhJpernVmvnKt0akeRceLuutIY5Z7Rw=;
	b=AE9vcJkGXD6ImUA2rVdhwTO1eYR/Mwele/dlx1qkQo/wUFK4KlPG9n7A9tamzJCMRPC43e
	CZajuebXh3Z5rsAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB5C5136ED;
	Sun, 18 Aug 2024 07:48:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7GtUKDmnwWbIQgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 18 Aug 2024 07:48:09 +0000
Date: Sun, 18 Aug 2024 09:48:51 +0200
Message-ID: <87ed6m1db0.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Yuntao Liu <liuyuntao12@huawei.com>
Cc: <patches@opensource.cirrus.com>,
	<linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>,
	<tanureal@opensource.cirrus.com>,
	<tiwai@suse.com>,
	<perex@perex.cz>,
	<rf@opensource.cirrus.com>,
	<david.rhodes@cirrus.com>
Subject: Re: [PATCH] ALSA: hda: cs35l41: fix module autoloading
In-Reply-To: <20240815091312.757139-1-liuyuntao12@huawei.com>
References: <20240815091312.757139-1-liuyuntao12@huawei.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Score: -3.30

On Thu, 15 Aug 2024 11:13:12 +0200,
Yuntao Liu wrote:
> 
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
> based on the alias from spi_device_id table.
> 
> Fixes: 7b2f3eb492dac ("ALSA: hda: cs35l41: Add support for CS35L41 in HDA systems")
> Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>

Thanks, applied with a correction Fixes tag (that had 13 bytes SHA
ID).


Takashi

