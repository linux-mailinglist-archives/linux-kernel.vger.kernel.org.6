Return-Path: <linux-kernel+bounces-243092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D686592918A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 09:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A011C21962
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 07:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A691CD3C;
	Sat,  6 Jul 2024 07:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qoo/AWeM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qUdprI2x";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HDGJX9L1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qGKo3fbp"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F7DFBE8;
	Sat,  6 Jul 2024 07:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720251424; cv=none; b=F28ULPPJMMnXORKFt6tKyVl0Cq2r8FgwhyiQGHQzU59rCMonkGsNqZfMdcOE7nn7tSSANrCkDRin1IIln0L+3utGfPeowMGbNCZ6GFGiO+J1J+Ygn+0paV2OWLR+N33zHpupS3olhQgVATKqkQEYF5G6n2H+8XbWbCOJ24yNagQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720251424; c=relaxed/simple;
	bh=BxnbgakI9ZYWUG1CT4WikmdI2VPddd0xi4IIypGmETE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j5pKEh1bEHUi9lZ+ZywN/+5lJLa4No3RfqMlexUPwdNnibku31sQMS8wv+FG5Xc74I3xvd0b6DuAck8b6P/E4A13sK00AzPm0Kv8grJ33yhnzMuaPacTNLHnJRByzhY6ro1NXuSbunh4v6+6Wm2u8A4eeaI1vSyNJr1s/th9eBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qoo/AWeM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qUdprI2x; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HDGJX9L1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qGKo3fbp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E230321A5A;
	Sat,  6 Jul 2024 07:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720251421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JaEfGl+0YW/A8oCHv2vnSklitd9PDmAIAgFBfvowXsk=;
	b=qoo/AWeMGw0PkFVi7fxZmO/EiH+OnoWucvk1eaUr1owQMx9vcNCPxNDt9cdNmf2/SY5W6V
	eYwRxln2nmep+ToSsuHgg5vLzcu94S4lkYanpQ4zL8EKppOo0W58jkaWPr6vNRQvwrjzAR
	9KVbg/3hrpi8RJI+qSpUiM6U/bukVfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720251421;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JaEfGl+0YW/A8oCHv2vnSklitd9PDmAIAgFBfvowXsk=;
	b=qUdprI2xfZdtHY50mpmoajce5wov0YNJ8GC9MofYtor960+49FPt44wBfgeGyjNEzBtEgL
	dKKMmuhjD3jAcfDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HDGJX9L1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qGKo3fbp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720251420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JaEfGl+0YW/A8oCHv2vnSklitd9PDmAIAgFBfvowXsk=;
	b=HDGJX9L1nGsDNQOWAdVL0z5bNHrfkV5IcYn0fngmYO4zAyB+v0X7u9EQE3aavXiIszFfC6
	bvDWdISLTqvI1xPKodIoZPlCDnCEa9TxZB+5vkcS9x/GpYmIY+IljkMqxTIexUKjnUdiJW
	WTeEqb+V9w+fjoTRnNPc4mJ5g55k8rw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720251420;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JaEfGl+0YW/A8oCHv2vnSklitd9PDmAIAgFBfvowXsk=;
	b=qGKo3fbpsEuZspTpM+GDH6oEZTqz4T5wfHz7AseUod7E+moewWh706pfnSpeMzZQ+w/m5u
	0AV0zCHGoHWSSAAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 951A212FF6;
	Sat,  6 Jul 2024 07:37:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4v/MIhz0iGYqDQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 06 Jul 2024 07:37:00 +0000
Date: Sat, 06 Jul 2024 09:37:31 +0200
Message-ID: <87jzhzynr8.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
Cc: tiwai@suse.com,
	perex@perex.cz,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	shenghao-ding@ti.com,
	simont@opensource.cirrus.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Limit mic boost on VAIO PRO PX
In-Reply-To: <20240705141012.5368-1-edson.drosdeck@gmail.com>
References: <20240705141012.5368-1-edson.drosdeck@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: E230321A5A
X-Spam-Score: -2.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Fri, 05 Jul 2024 16:10:12 +0200,
Edson Juliano Drosdeck wrote:
> 
> The internal mic boost on the VAIO models VJFE-CL and VJFE-IL is too high.
> Fix this by applying the ALC269_FIXUP_LIMIT_INT_MIC_BOOST fixup to the machine
> to limit the gain.
> 
> Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>

Thanks, applied now.


Takashi

