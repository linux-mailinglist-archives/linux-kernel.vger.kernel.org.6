Return-Path: <linux-kernel+bounces-575155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC685A6EE56
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FE7B16E344
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0694255230;
	Tue, 25 Mar 2025 11:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jRijtrPT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BsmPQsBG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jRijtrPT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BsmPQsBG"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765A91C84A7
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742900455; cv=none; b=byPWDosTREFf323atkFmTz+UBIwsY4KJ623rNUKZWjpkPiarlUjVMqa4rcJSppO9fI1lKjN1Kv6EYz0/uHNr3c8nUZ0YYEYAt5JpK7JIjmsFcKekgEIRoM07l4u4qIaAkwj5OqEuanRffiyO2MSAKaSaYnXrpJlz06xa4rJAa1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742900455; c=relaxed/simple;
	bh=K+Qm5s99BiookgFqyHsQ3xbrhto8zTMxLczHLgto38g=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MzeU5lfyQ76slga9qfbAR7CPnAri/4z8iBuBgfDKBME356tfeAE5KGx+tvRbNw4+XPJIs3ATinBC/NqKfcMphCPTrjg4uATWuSyEhgNkcMYH1FBEN0jBtrCSIfL0uaG72xzhgb4Al49z2NLYjafMhqSZsjGRorqih5vUXykCcQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jRijtrPT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BsmPQsBG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jRijtrPT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BsmPQsBG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 22EDB1F445;
	Tue, 25 Mar 2025 10:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742900121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BBGjReOIHwTMmOdNljRlZa/Y+OoQWPz7d+9KqfFh1Y8=;
	b=jRijtrPTH7jwcUW3ZLeBQ3h2hFB+n5mza2ViDzKLwjaXi33+8xeWyVGhheQcZFrRo3Eiuw
	MkT3eGzvC1XIYP/D094JuSgR1+WchM1gmciVtzIn+Xy3EkUCpLFHzNOnuugwAjq1NKnDWT
	duhJ1kipYfQKS2VN/R+ROTNFABkzRVY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742900121;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BBGjReOIHwTMmOdNljRlZa/Y+OoQWPz7d+9KqfFh1Y8=;
	b=BsmPQsBGEjylYhwhHsyVk3B48bgVoecMUmw+VIq5rsKU4SDomtowFTIuRKc1mldNiDMPhT
	46n0AEZ+u7zHjwDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742900121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BBGjReOIHwTMmOdNljRlZa/Y+OoQWPz7d+9KqfFh1Y8=;
	b=jRijtrPTH7jwcUW3ZLeBQ3h2hFB+n5mza2ViDzKLwjaXi33+8xeWyVGhheQcZFrRo3Eiuw
	MkT3eGzvC1XIYP/D094JuSgR1+WchM1gmciVtzIn+Xy3EkUCpLFHzNOnuugwAjq1NKnDWT
	duhJ1kipYfQKS2VN/R+ROTNFABkzRVY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742900121;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BBGjReOIHwTMmOdNljRlZa/Y+OoQWPz7d+9KqfFh1Y8=;
	b=BsmPQsBGEjylYhwhHsyVk3B48bgVoecMUmw+VIq5rsKU4SDomtowFTIuRKc1mldNiDMPhT
	46n0AEZ+u7zHjwDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE6D9137AC;
	Tue, 25 Mar 2025 10:55:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B0MUNZiL4mdsUgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 25 Mar 2025 10:55:20 +0000
Date: Tue, 25 Mar 2025 11:55:20 +0100
Message-ID: <87jz8dcrc7.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: shenghao-ding@ti.com,
	kevin-lu@ti.com,
	baojun.xu@ti.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: tas2781-i2c: Remove unnecessary NULL check before release_firmware()
In-Reply-To: <20250325084939.801117-1-nichen@iscas.ac.cn>
References: <20250325084939.801117-1-nichen@iscas.ac.cn>
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
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
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
X-Spam-Flag: NO

On Tue, 25 Mar 2025 09:49:39 +0100,
Chen Ni wrote:
> 
> release_firmware() checks for NULL pointers internally.
> Remove unneeded NULL check for fmw here.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Thanks, applied now.


Takashi

