Return-Path: <linux-kernel+bounces-214917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C171908C10
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1308B1F24B96
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F84199E90;
	Fri, 14 Jun 2024 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Eg9Ci+UC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dhzwJL1j";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Eg9Ci+UC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dhzwJL1j"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F70195F1D;
	Fri, 14 Jun 2024 12:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718369525; cv=none; b=J7SwfKtWPAcLt/f4POoo+CpYBvDR9aUnfqk5cnuSPH2Mt1sQJoP3UxSIC7AT1yEDXTU9wB3N52Rbb7lyltWM3J8aJEFGi9WpKlmFzRhB3rb8xA50+BEnANV0fquVkwelwGwJfov/aBVBM1BZddlBBuR9NNSBEpPC2bEnMTJ4q7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718369525; c=relaxed/simple;
	bh=axe9h9XJQnqzIl4Osu4Tu67uLt+HRXkbhNrY/mdVmSw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HrOmQfvG7r2FgZSUDOnKdGHXdwz7KhG33TXb2UCNK9UOZhzpC0cKcok31fBwYA33cfLjHUBC8RpvcPlHCpkRzaLWCHD5PLqF1wg+aY+5QiX7UdS49zFZ33sc9cKDEgmFJ3fYxoRON2fm0vsFOiMbeo+ul2SLIDTkr+bpM54CGv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Eg9Ci+UC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dhzwJL1j; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Eg9Ci+UC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dhzwJL1j; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9CC6C33806;
	Fri, 14 Jun 2024 12:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718369522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2xVdax+HP6ifRzg30XsgcfzY2o3oHkgLBqIBm6pxQzk=;
	b=Eg9Ci+UCo2I+U623jvU2SedRezKEdehdDlWHSxLcuzHplJLi8UlzQRzaZGQvJD+4wkBqyD
	Mjqw4mte9LZVAig4fmK+LTYWhlNaczhcPS60N7+DtOELDRPVCNQOZ/c3mcUn/M7A+iiEol
	IBFJtRQ0gvoxY7H+F7zQMVOkh0UKvtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718369522;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2xVdax+HP6ifRzg30XsgcfzY2o3oHkgLBqIBm6pxQzk=;
	b=dhzwJL1jNgsH5HVeOzbLP22qCvW4XMnsRFJtmujDMTRHi1Arr+wcT+EDFL42v5FPdDF4Vj
	8CTDAIlrsR9dG1CQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Eg9Ci+UC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dhzwJL1j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718369522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2xVdax+HP6ifRzg30XsgcfzY2o3oHkgLBqIBm6pxQzk=;
	b=Eg9Ci+UCo2I+U623jvU2SedRezKEdehdDlWHSxLcuzHplJLi8UlzQRzaZGQvJD+4wkBqyD
	Mjqw4mte9LZVAig4fmK+LTYWhlNaczhcPS60N7+DtOELDRPVCNQOZ/c3mcUn/M7A+iiEol
	IBFJtRQ0gvoxY7H+F7zQMVOkh0UKvtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718369522;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2xVdax+HP6ifRzg30XsgcfzY2o3oHkgLBqIBm6pxQzk=;
	b=dhzwJL1jNgsH5HVeOzbLP22qCvW4XMnsRFJtmujDMTRHi1Arr+wcT+EDFL42v5FPdDF4Vj
	8CTDAIlrsR9dG1CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5CC2C13AB1;
	Fri, 14 Jun 2024 12:52:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Rs5vFfI8bGaqMQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 14 Jun 2024 12:52:02 +0000
Date: Fri, 14 Jun 2024 14:52:27 +0200
Message-ID: <878qz78z5g.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Simon Trimmer <simont@opensource.cirrus.com>
Cc: <tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>,
	<soyer@irl.hu>,
	<shenghao-ding@ti.com>,
	<kevin-lu@ti.com>,
	<baojun.xu@ti.com>
Subject: Re: [PATCH 0/3] ALSA: hda: Component should be unbound before deconstruction
In-Reply-To: <20240613133713.75550-1-simont@opensource.cirrus.com>
References: <20240613133713.75550-1-simont@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9CC6C33806
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 

On Thu, 13 Jun 2024 15:37:10 +0200,
Simon Trimmer wrote:
> 
> Small chain of fixes to correct hda drivers using the hda component
> infrastructure so that they unregister their component before proceeding
> to deconstruct the driver.
> 
> These three patches been separated from the chain "[PATCH v2 0/7] ALSA:
> hda: Improvements to hda_component"
> 
> Simon Trimmer (3):
>   ALSA: hda: cs35l56: Component should be unbound before deconstruction
>   ALSA: hda: cs35l41: Component should be unbound before deconstruction
>   ALSA: hda: tas2781: Component should be unbound before deconstruction

Applied to for-linus branch now.


thanks,

Takashi

