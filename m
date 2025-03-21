Return-Path: <linux-kernel+bounces-571277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D7EA6BB3F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 460C81B60898
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E19B22A1FA;
	Fri, 21 Mar 2025 12:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ytu8ix9G";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wO0tFybf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ytu8ix9G";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wO0tFybf"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713E0227EBD
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 12:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742561562; cv=none; b=fI90Gs4r0IG56xpWTEnDOaakgMfkj5oYfmTUuLq8kAldyLkhXvSqX9Ggiv3NE+UNzRHpIIkElfOGYvhkgBxU1ElTIFparz1d1r5HN8sFtd0o+JIQqbGvIhXJK8Ztat5uViLZUvqr8nQAoC9FN1kbH0Km1Utb0/ucUs9q7aoI2Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742561562; c=relaxed/simple;
	bh=WVzQIKqX8X1cs2XAcB40Uwq29UZyXlRh+asPDogFY5A=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nnfa61HsmglRTjtGuo6aesRNxjkTX7C4jgcTCitlEaSnm1C1NpgopxqIHThIxeofEUxwRNEG13M2S8et5rSP4RH67kbunp1KEmedg8C6ykytCmpat9HWlcUT5wag8dssFXoKlbt1SzFU246K/8sjFn7DVXeQ/6/kUeaaSdrGue8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ytu8ix9G; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wO0tFybf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ytu8ix9G; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wO0tFybf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8641021AC3;
	Fri, 21 Mar 2025 12:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742561558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+oV33GCYWF6pAm3qJ5WorbLS/zCYWLbh1VJaPrL7yHQ=;
	b=ytu8ix9GZshus5zAaJMtEUP8kBZgdDQgWH7AhiE98bJkL5YzahDpD2Nz75x4NuEkqBh6yB
	UPycV4yw/p8sSMNpXcvNuZXw5MOc2ykdtO+ZOKH6uXLPu3E7fJNJAbIhiHOH2bWq80eXE2
	yTJw7tCR5a2bRjF0qIGuvIapNysx+L0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742561558;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+oV33GCYWF6pAm3qJ5WorbLS/zCYWLbh1VJaPrL7yHQ=;
	b=wO0tFybf1b+14q4uXWe4lgSrDyEJUng4F09pQtJSwBsEftOkLnTBkX1XIhvA2CTR8NR3b2
	/e3hnfonN2nhg2Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742561558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+oV33GCYWF6pAm3qJ5WorbLS/zCYWLbh1VJaPrL7yHQ=;
	b=ytu8ix9GZshus5zAaJMtEUP8kBZgdDQgWH7AhiE98bJkL5YzahDpD2Nz75x4NuEkqBh6yB
	UPycV4yw/p8sSMNpXcvNuZXw5MOc2ykdtO+ZOKH6uXLPu3E7fJNJAbIhiHOH2bWq80eXE2
	yTJw7tCR5a2bRjF0qIGuvIapNysx+L0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742561558;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+oV33GCYWF6pAm3qJ5WorbLS/zCYWLbh1VJaPrL7yHQ=;
	b=wO0tFybf1b+14q4uXWe4lgSrDyEJUng4F09pQtJSwBsEftOkLnTBkX1XIhvA2CTR8NR3b2
	/e3hnfonN2nhg2Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46CCF13A2C;
	Fri, 21 Mar 2025 12:52:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZK6PDxZh3WeWXwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 21 Mar 2025 12:52:38 +0000
Date: Fri, 21 Mar 2025 13:52:37 +0100
Message-ID: <878qoyv94a.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Chris Chiu <chris.chiu@canonical.com>
Cc: tiwai@suse.com,
	perex@perex.cz,
	simont@opensource.cirrus.com,
	sbinding@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ALSA: hda/realtek: fix micmute LEDs on HP Laptops with ALC3315
In-Reply-To: <20250321104914.544233-1-chris.chiu@canonical.com>
References: <20250321104914.544233-1-chris.chiu@canonical.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,canonical.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 21 Mar 2025 11:49:13 +0100,
Chris Chiu wrote:
> 
> More HP laptops with Realtek HDA codec ALC3315 with combined CS35L56
> Amplifiers need quirk ALC285_FIXUP_HP_GPIO_LED to fix the micmute LED.
> 
> Signed-off-by: Chris Chiu <chris.chiu@canonical.com>

Thanks, applied both patches now.


Takashi

