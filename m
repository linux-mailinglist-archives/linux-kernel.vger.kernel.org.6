Return-Path: <linux-kernel+bounces-295582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 534D3959E8F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A8851F21A39
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59D419994D;
	Wed, 21 Aug 2024 13:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W7+IgBwk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="isDNqMZ2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W7+IgBwk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="isDNqMZ2"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7BB1531F7;
	Wed, 21 Aug 2024 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724246619; cv=none; b=WOk60WqpVf+tIOtTXimsppffZT1tnJvG3c7W+whuZuIcxToCgc5/AvqxPquPdNKUTOheI1Rmdegem3jCoPQE8lis89ZOrueh2pjAKQYJMwQ1DNkExqGQQL6Zo4WRoxu9q6lEbwN6aR4KCIPGfmUnKCzhxZ7XosBr4XLsppyR5R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724246619; c=relaxed/simple;
	bh=KFtZZeysOpPwQD8LLbTxJARdZc2ToQqHVD6VrZ17nEA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a1/ANZfKfXdjunGO3qdE1KvhYzhsIu/BiYd8xeovBsHg/baijGkh1A75MAtEj2msaofTXCwwI/a4kI/wcbLRieOPuzM6uJSQ8Rk3lw1EL0yAsrZHIFU3yKEPsJnMKIilShsOEWSH9/Elu9dV7b56TLD/D/voCvdJYtxyFyHnE2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=W7+IgBwk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=isDNqMZ2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=W7+IgBwk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=isDNqMZ2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2604A20082;
	Wed, 21 Aug 2024 13:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724246610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ENyx53nwWY4QDIHm9+/8SrdUl3xu7tCqIX8WtYMFeg=;
	b=W7+IgBwkgv+pf7apqqu60mFHZD2WCnlgk1xkN4QHSggmcDxlyQ10n2H5SAXokoNQAd9vyZ
	4rargG0+fSsA9xQJm4gyo0dkkCDKtpQAZ1ShnANxd4hHYcBOvkxPz5UBPrAkUdXuCxzU0F
	ud/FZAnXxa3BrNxGkF1o+CJFXeMx5WI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724246610;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ENyx53nwWY4QDIHm9+/8SrdUl3xu7tCqIX8WtYMFeg=;
	b=isDNqMZ2ZRuobvL9j6iy2g81VHSDrT8xBoepg16Blm0aapznOVp4REZuBnGBfOqtKKjlcJ
	1DXcb2HvX1+oIvDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724246610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ENyx53nwWY4QDIHm9+/8SrdUl3xu7tCqIX8WtYMFeg=;
	b=W7+IgBwkgv+pf7apqqu60mFHZD2WCnlgk1xkN4QHSggmcDxlyQ10n2H5SAXokoNQAd9vyZ
	4rargG0+fSsA9xQJm4gyo0dkkCDKtpQAZ1ShnANxd4hHYcBOvkxPz5UBPrAkUdXuCxzU0F
	ud/FZAnXxa3BrNxGkF1o+CJFXeMx5WI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724246610;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ENyx53nwWY4QDIHm9+/8SrdUl3xu7tCqIX8WtYMFeg=;
	b=isDNqMZ2ZRuobvL9j6iy2g81VHSDrT8xBoepg16Blm0aapznOVp4REZuBnGBfOqtKKjlcJ
	1DXcb2HvX1+oIvDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9F7013770;
	Wed, 21 Aug 2024 13:23:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kpnYN1HqxWZbIAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 21 Aug 2024 13:23:29 +0000
Date: Wed, 21 Aug 2024 15:24:12 +0200
Message-ID: <87r0aiovpf.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Simon Trimmer <simont@opensource.cirrus.com>
Cc: <tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH] ALSA: hda: cs35l56: Don't use the device index as a calibration index
In-Reply-To: <20240821124711.44325-1-simont@opensource.cirrus.com>
References: <20240821124711.44325-1-simont@opensource.cirrus.com>
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
	BAYES_HAM(-3.00)[99.98%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 21 Aug 2024 14:47:11 +0200,
Simon Trimmer wrote:
> 
> The HDA driver cannot assume that the order that the devices are
> specified in the cirrus,dev-index matches the order of calibration
> entries.
> 
> Only a calibration entry with a matching silicon id will be used.
> 
> Fixes: cfa43aaa7948 ("ALSA: hda: cs35l56: Apply amp calibration from EFI data")
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>

Thanks, applied now.


Takashi

