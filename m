Return-Path: <linux-kernel+bounces-173219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 402818BFD35
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638F21C21F23
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB2343ACA;
	Wed,  8 May 2024 12:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="blEmAoso";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xOCJ4Q86";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="blEmAoso";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xOCJ4Q86"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9B52134B;
	Wed,  8 May 2024 12:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715171636; cv=none; b=U6pdKD4lIuiKLGRV3qB6Fi9gc/DBuWScAScNVJ0VTi/BZdMcYRZpOpQDCjEQLcUY+wyLhVKOjvNBWdpGW5ujwZOYFNMK/QkNfypfnaG2mJ3irhfn1LCJVXHuCAJlxememTL2r5TxqfP5TarDZX92zhkI/+a/35SXbXsGCF5AHIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715171636; c=relaxed/simple;
	bh=esIqw22Sxp3Shgj+vmXrJg6z4djBqtaf5dv6kUOAiUk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G+oC3WBfuyODAXRUfsEWAgFyUeW0qLq+kbQMtFbOa7ZNo+zrOO9DyXIMPiwnYtOUXJPDQcgKUG9VCQAMFD8fuKsw6XZVz1YFZHKVh8qmwfweZr4+cTAy40aVOKjvTsQPWMorqc6iOkt4zzprN2Tr1qJ9+kiB8SS0w7M9tjFcles=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=blEmAoso; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xOCJ4Q86; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=blEmAoso; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xOCJ4Q86; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CA5503511C;
	Wed,  8 May 2024 12:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715171632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FVSKu4W4KVhMzXX4xEofx0YfF4EXa9Q6R7TG5QsoFWM=;
	b=blEmAosoEOEvDPaRgVdZsQkytu7HHdLplEmQ7f+kJazSNKD82quV44oIwN03KpYL6+Pg3j
	OXeCVO3Nou55SSDpWXzyBomeZdCNyJTBcCjg1Rh6RrNpOJHp5B8z99Dpiue+5k6qgICZLf
	y4IoqseV6xQSAdqwIeClOJpEz9X+jOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715171632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FVSKu4W4KVhMzXX4xEofx0YfF4EXa9Q6R7TG5QsoFWM=;
	b=xOCJ4Q86BPQYzp2+QfaR+WtC69VDdb74TTsatjoVvupUxbDIuq5zYkLMYxmGNxalSjoEST
	J0Px1HwWaEhPIUAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=blEmAoso;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xOCJ4Q86
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715171632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FVSKu4W4KVhMzXX4xEofx0YfF4EXa9Q6R7TG5QsoFWM=;
	b=blEmAosoEOEvDPaRgVdZsQkytu7HHdLplEmQ7f+kJazSNKD82quV44oIwN03KpYL6+Pg3j
	OXeCVO3Nou55SSDpWXzyBomeZdCNyJTBcCjg1Rh6RrNpOJHp5B8z99Dpiue+5k6qgICZLf
	y4IoqseV6xQSAdqwIeClOJpEz9X+jOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715171632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FVSKu4W4KVhMzXX4xEofx0YfF4EXa9Q6R7TG5QsoFWM=;
	b=xOCJ4Q86BPQYzp2+QfaR+WtC69VDdb74TTsatjoVvupUxbDIuq5zYkLMYxmGNxalSjoEST
	J0Px1HwWaEhPIUAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9DC941386E;
	Wed,  8 May 2024 12:33:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1AR1JTBxO2YmXQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 08 May 2024 12:33:52 +0000
Date: Wed, 08 May 2024 14:34:07 +0200
Message-ID: <874jb8cwjk.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: <tiwai@suse.com>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>,
	<alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>
Subject: Re: [PATCH] ALSA: hda: hda_component: Initialize shared data during bind callback
In-Reply-To: <20240508100347.47283-1-rf@opensource.cirrus.com>
References: <20240508100347.47283-1-rf@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.50
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CA5503511C
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-2.99)[99.97%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]

On Wed, 08 May 2024 12:03:47 +0200,
Richard Fitzgerald wrote:
> 
> Move the initialization of the shared struct hda_component array into
> hda_component_manager_bind().
> 
> The purpose of the manager bind() callback is to allow it to perform
> initialization before binding in the component drivers. This is the
> correct place to initialize the shared data.
> 
> The original implementation initialized the shared data in
> hda_component_manager_init(). This is only done once during probe()
> of the manager driver. So if the component binding was unbound and
> then rebound, the shared data would not be re-initialized.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Fixes: fd895a74dc1d ("ALSA: hda: realtek: Move hda_component implementation to module")

Applied now.  Thanks.


Takashi

