Return-Path: <linux-kernel+bounces-347045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7861B98CCFD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 08:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06151C21468
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 06:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED3E83A06;
	Wed,  2 Oct 2024 06:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MunWeazZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Y5myFH1P";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MunWeazZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Y5myFH1P"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678A41805E;
	Wed,  2 Oct 2024 06:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727849643; cv=none; b=JEtrGIExVChR2sDgv9iuaDoFVC1ufQk2e99qSRkYBGrMC7YWWanfFR63yt5nLLsHHBTc3YX1B09QjPajt7+46JmIg1Xc4VhExEa927lnpcAKBE8ZkvDRtyF6VbQk5F6bO6ntBxCEc0U7CqoMdDsByg9JKtz6/XOBO6iyQvtHWcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727849643; c=relaxed/simple;
	bh=+NVwRKtiLvrc04KvJbGiJgOdO+R3E0k1g7vbnYFWwss=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lvjN8CEjJ+QeRPXRPhtW43WKqDhhprmm6qmU7nM3MsrmYE+Kj5xUuGWumv2v4ptKJ9eghzlDeRfygxDzQQhoHW/bRgIQ/4MCU08FsFP6asmoTYX7sMGkvPw86yuGNcXtl3tPzTpX2bYmBwULI7Ta6bV0AItdXu/yvEnYJ2QNmT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MunWeazZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Y5myFH1P; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MunWeazZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Y5myFH1P; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 29E0221B67;
	Wed,  2 Oct 2024 06:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727849639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MerGsnCoxXExT44McdzyHQ7nut4uy9hwav+k4GQZkIE=;
	b=MunWeazZiRDRyLhGFFXmKKexzeWlUMiH0U+RpJXMA0QMHVZn1Q0LZQyv4gLEGXv9uS+dKw
	cJbjH34L11BdNXneWEHdw3qjjRutzXFRgPgtGDUEXNIFyB7NIESMc9tk6Dwd2snlG8qDg3
	KUrmKqdJLtTZosbj7j4ni3KiWaP/f9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727849639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MerGsnCoxXExT44McdzyHQ7nut4uy9hwav+k4GQZkIE=;
	b=Y5myFH1PQMxSX9hqHW8OuDon0Uy96bNkGxIi2hUC9QPw8Ki1fN6HM/fO2H45IXM4GS1N4T
	vu3K64NQWQrMQVCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727849639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MerGsnCoxXExT44McdzyHQ7nut4uy9hwav+k4GQZkIE=;
	b=MunWeazZiRDRyLhGFFXmKKexzeWlUMiH0U+RpJXMA0QMHVZn1Q0LZQyv4gLEGXv9uS+dKw
	cJbjH34L11BdNXneWEHdw3qjjRutzXFRgPgtGDUEXNIFyB7NIESMc9tk6Dwd2snlG8qDg3
	KUrmKqdJLtTZosbj7j4ni3KiWaP/f9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727849639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MerGsnCoxXExT44McdzyHQ7nut4uy9hwav+k4GQZkIE=;
	b=Y5myFH1PQMxSX9hqHW8OuDon0Uy96bNkGxIi2hUC9QPw8Ki1fN6HM/fO2H45IXM4GS1N4T
	vu3K64NQWQrMQVCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE3B613974;
	Wed,  2 Oct 2024 06:13:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /zGuLKbk/GYOFAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 02 Oct 2024 06:13:58 +0000
Date: Wed, 02 Oct 2024 08:14:52 +0200
Message-ID: <87msjnm3oj.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Abhishek Tamboli <abhishektamboli9@gmail.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	simont@opensource.cirrus.com,
	josh@joshuagrisham.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	skhan@linuxfoundation.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: hda/realtek: Add a quirk for HP Pavilion 15z-ec200
In-Reply-To: <20240930145300.4604-1-abhishektamboli9@gmail.com>
References: <20240930145300.4604-1-abhishektamboli9@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,realtek.com,opensource.cirrus.com,joshuagrisham.com,athaariq.my.id,linuxfoundation.org,gmail.com,lists.linuxfoundation.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Mon, 30 Sep 2024 16:53:00 +0200,
Abhishek Tamboli wrote:
> 
> Add the quirk for HP Pavilion Gaming laptop 15z-ec200 for
> enabling the mute led. The fix apply the ALC285_FIXUP_HP_MUTE_LED
> quirk for this model.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219303
> 
> Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>

Thanks, applied now.


Takashi

