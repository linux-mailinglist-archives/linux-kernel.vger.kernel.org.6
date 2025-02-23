Return-Path: <linux-kernel+bounces-527839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81192A4105E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 18:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF57B3B6C86
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 17:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB5EB644;
	Sun, 23 Feb 2025 17:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gIkQ6i6A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+IvhCl0h";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gIkQ6i6A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+IvhCl0h"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2435E1BC3C
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 17:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740330969; cv=none; b=b+Dq35AwfWhck92ksvz5D13xWj+9H6HhhNamD0Jff8pjdB/K8nyudzoEj8jHkS8A3PbFAweVS4DKAJ0sYrTmqN1wySPtysnjsEQvqD95DA5mszrjaEdkwyfudi8OY1R/tbpf9X2J/ITtbQrh0gkt4fFudhJr1jRqoj+pdyYAYH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740330969; c=relaxed/simple;
	bh=M5pgP1bN6qBtfo3sR6fQ82Rlj0cf53KcExt4eoDeXbQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yzn1Nmb+OXIrn0VkT5UoRXGtjTuUuj8yPdISYmqDKPAgnCiks9w63bd7gVnF20cvKgtYlWckhrK7XzwW533OF2cu04P68zOPc15p/2C+Vhhr9bAqLlTNw1J4gVzxUSHT4TIulBJO9GvWTO6jcyjVuuS2nQS7yQP5c+BwyZej16o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gIkQ6i6A; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+IvhCl0h; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gIkQ6i6A; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+IvhCl0h; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 21E0E1F383;
	Sun, 23 Feb 2025 17:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740330965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fiAikQSOSk3s/Fif0Xp5rDIilzpBMg+58DLENFRdZFY=;
	b=gIkQ6i6AY6HzdFuZ68tk/okSaJJKL3z/NBMxG7pMPWnJQ6uPylH3+qJv6NrLNhvpQsZ1Nl
	xuU4uJRWx+mwl7/IOHSroe6RHq9WRm0F7uJRqFvHUR1IrVj77825sBhlhT44Hi0823CB3q
	07MGB++Ng67vyDJISRj3BoICzK7MMjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740330965;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fiAikQSOSk3s/Fif0Xp5rDIilzpBMg+58DLENFRdZFY=;
	b=+IvhCl0h+IoiiM0dcTHlOdrqzdnay2fHWj1tqdamBaP/bxUbHeI2/xHKoNE5BskhuQ9HSt
	szrkfZIZXMnDH1Cg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gIkQ6i6A;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+IvhCl0h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740330965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fiAikQSOSk3s/Fif0Xp5rDIilzpBMg+58DLENFRdZFY=;
	b=gIkQ6i6AY6HzdFuZ68tk/okSaJJKL3z/NBMxG7pMPWnJQ6uPylH3+qJv6NrLNhvpQsZ1Nl
	xuU4uJRWx+mwl7/IOHSroe6RHq9WRm0F7uJRqFvHUR1IrVj77825sBhlhT44Hi0823CB3q
	07MGB++Ng67vyDJISRj3BoICzK7MMjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740330965;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fiAikQSOSk3s/Fif0Xp5rDIilzpBMg+58DLENFRdZFY=;
	b=+IvhCl0h+IoiiM0dcTHlOdrqzdnay2fHWj1tqdamBaP/bxUbHeI2/xHKoNE5BskhuQ9HSt
	szrkfZIZXMnDH1Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A62A213A53;
	Sun, 23 Feb 2025 17:16:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WIn9JNRXu2dtcAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 23 Feb 2025 17:16:04 +0000
Date: Sun, 23 Feb 2025 18:16:03 +0100
Message-ID: <87plj8zing.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: arm: aaci: Constify amba_id table
In-Reply-To: <20250222114129.162794-1-krzysztof.kozlowski@linaro.org>
References: <20250222114129.162794-1-krzysztof.kozlowski@linaro.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 21E0E1F383
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
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, 22 Feb 2025 12:41:29 +0100,
Krzysztof Kozlowski wrote:
> 
> 'struct amba_id' table is not modified so can be changed to const for
> more safety.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied now.  Thanks.


Takashi

