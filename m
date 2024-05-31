Return-Path: <linux-kernel+bounces-196806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0EB8D61FC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0C2B287C4E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE2115884D;
	Fri, 31 May 2024 12:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ouPDBjzw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0hRp0J1l";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ouPDBjzw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0hRp0J1l"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E318B1581ED;
	Fri, 31 May 2024 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717159128; cv=none; b=clqC6WBl8e64BmbbE1xvo7jXMhv6JJNqitD8NfQrWVd09ZLtofR48Ghy4/67zmXTG9fGwYOIPWC7awl8dniB+qPzm+zWtsx0EF9gneMZJDwUmAXq+cxB+A8h1PyWnXmMXepwaoXpFiGLHrTxyrftni0XRYNwvSFTw4P2McgL1sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717159128; c=relaxed/simple;
	bh=4MiyUforjyB3VfuRbKh44YTCsg7n4QA1jPNVui+GC3w=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OtOvf5nL7wabih3GzyRchQ2+awtUHfon5JXDgFiXGIIW1H60ObpXwokEHkcVvXRlT/OjOlADF1RezXjauN/+lGS4Q91pMUNiJAOWseXOjA5icvq9wOcTEsd0DDNsGN+OrQqveDsPabi1iVLuyLtSuyWJJFznA0UlvWltjTYHaIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ouPDBjzw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0hRp0J1l; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ouPDBjzw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0hRp0J1l; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 08FE221BCB;
	Fri, 31 May 2024 12:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717159125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P5BzJwpGnxTW/HqgTgsLDeSdFdC9YNrVOg8pJXtP7aQ=;
	b=ouPDBjzw2s4BW9b24KvY0QnKPV1QSAqto123uhFPmCO5TON1K6ZmUVO21548Ia1hKrgirw
	oJNRol4KSBz5bKTQvNXyXC93xovvRJBRFARwhCeFSg0XaJkdfZk0I03PwvestE0kAytGQz
	rI1ysyJ/RVnut1XZTsf8wZuLvWxZrro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717159125;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P5BzJwpGnxTW/HqgTgsLDeSdFdC9YNrVOg8pJXtP7aQ=;
	b=0hRp0J1lxEnwNk20tou4WnZAWy3w8Vb/bdPAKBrJJOBMhxePyiVGXnUR9eM9En50dsisdH
	tFJ77Lyp+TvtPIDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717159125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P5BzJwpGnxTW/HqgTgsLDeSdFdC9YNrVOg8pJXtP7aQ=;
	b=ouPDBjzw2s4BW9b24KvY0QnKPV1QSAqto123uhFPmCO5TON1K6ZmUVO21548Ia1hKrgirw
	oJNRol4KSBz5bKTQvNXyXC93xovvRJBRFARwhCeFSg0XaJkdfZk0I03PwvestE0kAytGQz
	rI1ysyJ/RVnut1XZTsf8wZuLvWxZrro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717159125;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P5BzJwpGnxTW/HqgTgsLDeSdFdC9YNrVOg8pJXtP7aQ=;
	b=0hRp0J1lxEnwNk20tou4WnZAWy3w8Vb/bdPAKBrJJOBMhxePyiVGXnUR9eM9En50dsisdH
	tFJ77Lyp+TvtPIDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C30E9137C3;
	Fri, 31 May 2024 12:38:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LvouLtTEWWbOVQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 31 May 2024 12:38:44 +0000
Date: Fri, 31 May 2024 14:39:07 +0200
Message-ID: <8734py40lw.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Simon Trimmer <simont@opensource.cirrus.com>
Cc: <tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH] ALSA: hda: cs35l56: Fix lifecycle of codec pointer
In-Reply-To: <20240531112716.25323-1-simont@opensource.cirrus.com>
References: <20240531112716.25323-1-simont@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.21 / 50.00];
	BAYES_HAM(-2.91)[99.62%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.21
X-Spam-Flag: NO

On Fri, 31 May 2024 13:27:16 +0200,
Simon Trimmer wrote:
> 
> The codec should be cleared when the amp driver is unbound and when
> resuming it should be tested to prevent loading firmware into the device
> and ALSA in a partially configured system state.
> 
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>

Thanks, applied.


Takashi

