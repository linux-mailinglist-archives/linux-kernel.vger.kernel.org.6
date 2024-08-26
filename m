Return-Path: <linux-kernel+bounces-301076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A826295EC0C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61B9A28221F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDE7145B07;
	Mon, 26 Aug 2024 08:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qn/XSsLN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MSE3AMmN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qn/XSsLN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MSE3AMmN"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBA5144D35;
	Mon, 26 Aug 2024 08:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724661117; cv=none; b=bKQElU770EXeJDA8MgppxABbvjH/lCys906FyEWSXALZWI86t3mRGp96a/0slTzXa2JUGdt0hfmg+MSoKmic2AI4p0kwWUXsI08qFKrPKbucaPiirT77lYmIzJqVdQZ8dOsQ2njTUkI76CSBGMFaatt9rNeIG7c45C8GIgMkTkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724661117; c=relaxed/simple;
	bh=+AVueriv5FElSjwGii+KGAzsL6WnvTGG5xaIGuyYKkE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=upaE7eoOkDvumA/VSJtqVGo4+wSwp3rg3Wc0LyTP6Y9tcuQHTjfa1vFonZFuuG473KTXGjtXjVzgDgKXx+CCS3f0M3Rekrm77wN3ZrFuU0btgSyPku2DtFuuwmeI3wLiTji35fxDeXEwcjCedEfyLBhuO81TyDlyF/Y47S7EKNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qn/XSsLN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MSE3AMmN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qn/XSsLN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MSE3AMmN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6D1DA1F842;
	Mon, 26 Aug 2024 08:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724661114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wYlsB9uxCuChUsqkDlGDGT6I+W12en2CVJQ622VxvQ8=;
	b=qn/XSsLNLoEjdP3HIDCdU5Um717bR2KV0Drbzld8nQELhP6BsG2+bDunDR/Mb+PBV0pgfS
	WAs4phKI/HnR9kRDGsUgbRR5BqBaXO2B4ketjM4aREVzXjwQKY/vdMUERSaHulNrJ/uPft
	0zUle6WDebNlppJIy8o0ls4ZkXtyr4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724661114;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wYlsB9uxCuChUsqkDlGDGT6I+W12en2CVJQ622VxvQ8=;
	b=MSE3AMmNHPbfRw0qpUvQY9nXxRfz9MDwPsQJKLluhR2+3yhkNzZzzVF1mAH1vaDqyL54iK
	CkcgO1H5oECXEtAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724661114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wYlsB9uxCuChUsqkDlGDGT6I+W12en2CVJQ622VxvQ8=;
	b=qn/XSsLNLoEjdP3HIDCdU5Um717bR2KV0Drbzld8nQELhP6BsG2+bDunDR/Mb+PBV0pgfS
	WAs4phKI/HnR9kRDGsUgbRR5BqBaXO2B4ketjM4aREVzXjwQKY/vdMUERSaHulNrJ/uPft
	0zUle6WDebNlppJIy8o0ls4ZkXtyr4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724661114;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wYlsB9uxCuChUsqkDlGDGT6I+W12en2CVJQ622VxvQ8=;
	b=MSE3AMmNHPbfRw0qpUvQY9nXxRfz9MDwPsQJKLluhR2+3yhkNzZzzVF1mAH1vaDqyL54iK
	CkcgO1H5oECXEtAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44B6513724;
	Mon, 26 Aug 2024 08:31:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wkEtD3o9zGbjXAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 26 Aug 2024 08:31:54 +0000
Date: Mon, 26 Aug 2024 10:32:38 +0200
Message-ID: <87le0jit09.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Shen Lichuan <shenlichuan@vivo.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ALSA: usb-audio: Use kmemdup_array instead of kmemdup for multiple allocation
In-Reply-To: <20240826043454.3198-1-shenlichuan@vivo.com>
References: <20240826043454.3198-1-shenlichuan@vivo.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.24 / 50.00];
	BAYES_HAM(-2.94)[99.75%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,vivo.com:email]
X-Spam-Score: -3.24
X-Spam-Flag: NO

On Mon, 26 Aug 2024 06:34:54 +0200,
Shen Lichuan wrote:
> 
> Let the kmemdup_array() take care about multiplication
> and possible overflows.
> 
> Using kmemdup_array() is more appropriate and makes the code
> easier to audit.
> 
> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>

Thanks, applied now.


Takashi

