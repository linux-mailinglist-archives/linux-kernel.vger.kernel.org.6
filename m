Return-Path: <linux-kernel+bounces-388785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D829B6459
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267A01C20E1E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4B61EABC9;
	Wed, 30 Oct 2024 13:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vG3zkCCM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BsxwbcBB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vG3zkCCM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BsxwbcBB"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004581E411D;
	Wed, 30 Oct 2024 13:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730295649; cv=none; b=kZtsDOJ1btYGG2JGONtcxh5sWVf83vrYNO4fGTVxpaTDnHAMHbrmn/UAjR51GvZUUDcQ2GorTm8PKvgj258wxWPY/Ve/Js4K0KynBUaMAoRdsGiLJsl5Sc5/F3fcL894Dv6LN5MtL8YoojJXwsCroJ4PAB9t1vze41t8dcnhY9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730295649; c=relaxed/simple;
	bh=OXuyPS2ux3aICdvcFgZSw99lMxgdGxpOT6EJ4MwHCQE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cAR9CTCEV29woGxd5bszLhhBQ0RKwDyzqFbuQrwUrg2oo/qYojQnceHGnPDsi6j6cvJoNPgu+WlDCyffTqJu5dRYAHHXUyniX3TxlKzukUvJ1mMR8B1hazlpEY/DvIV4sixBdlWje4Au0eaOm/QXix/8Fer9HrhG3S6uFL35AOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vG3zkCCM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BsxwbcBB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vG3zkCCM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BsxwbcBB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0747C21D4E;
	Wed, 30 Oct 2024 13:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730295645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BYg+D4uOU1PUiPo6jLbMQ4uKMdoi00EvLXys6ceFE4Q=;
	b=vG3zkCCMFh2XzeBCP8UwokY3FSvdo6MlSBLfcxE9E+v8AjI3JK+kZBjyCjjpStG7JnbpTj
	qwqYxreppmpC078O37yjcVyvYwx5V1llATroMJBiUpLVTZr4XL4E9su8zrhwrH8ss0wu40
	DA1XY1DvIch33qnO0bWk9hU2FGbcTZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730295645;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BYg+D4uOU1PUiPo6jLbMQ4uKMdoi00EvLXys6ceFE4Q=;
	b=BsxwbcBBfwluDK6KQMJfewHtkm7fCXxJM93bi4v/YIE+H7WcpHDt4CyVGaTlnGcNbyyj1x
	bd8tUisKqFgTSNAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vG3zkCCM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BsxwbcBB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730295645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BYg+D4uOU1PUiPo6jLbMQ4uKMdoi00EvLXys6ceFE4Q=;
	b=vG3zkCCMFh2XzeBCP8UwokY3FSvdo6MlSBLfcxE9E+v8AjI3JK+kZBjyCjjpStG7JnbpTj
	qwqYxreppmpC078O37yjcVyvYwx5V1llATroMJBiUpLVTZr4XL4E9su8zrhwrH8ss0wu40
	DA1XY1DvIch33qnO0bWk9hU2FGbcTZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730295645;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BYg+D4uOU1PUiPo6jLbMQ4uKMdoi00EvLXys6ceFE4Q=;
	b=BsxwbcBBfwluDK6KQMJfewHtkm7fCXxJM93bi4v/YIE+H7WcpHDt4CyVGaTlnGcNbyyj1x
	bd8tUisKqFgTSNAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD69A13AD9;
	Wed, 30 Oct 2024 13:40:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aeOfMFw3Imc1dQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 30 Oct 2024 13:40:44 +0000
Date: Wed, 30 Oct 2024 14:41:47 +0100
Message-ID: <87y125yag4.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jan =?ISO-8859-1?Q?Sch=E4r?= <jan@jschaer.ch>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: Add quirks for Dell WD19 dock
In-Reply-To: <20241029221249.15661-1-jan@jschaer.ch>
References: <20241029221249.15661-1-jan@jschaer.ch>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0747C21D4E
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 29 Oct 2024 23:12:49 +0100,
Jan Schär wrote:
> 
> The WD19 family of docks has the same audio chipset as the WD15. This
> change enables jack detection on the WD19.
> 
> We don't need the dell_dock_mixer_init quirk for the WD19. It is only
> needed because of the dell_alc4020_map quirk for the WD15 in
> mixer_maps.c, which disables the volume controls. Even for the WD15,
> this quirk was apparently only needed when the dock firmware was not
> updated.
> 
> Signed-off-by: Jan Schär <jan@jschaer.ch>

Thanks, applied now.


Takashi

