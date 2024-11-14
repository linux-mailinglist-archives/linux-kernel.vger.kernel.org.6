Return-Path: <linux-kernel+bounces-409384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE149C8BFD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AE081F22128
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCA91F60A;
	Thu, 14 Nov 2024 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BPulQSx/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LZchN8cx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BPulQSx/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LZchN8cx"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B927208D0;
	Thu, 14 Nov 2024 13:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731591590; cv=none; b=L0wp5zcPA4x7qznGZ6eX60cUc182JdRVsJR8Q8Py8UsF4/VjTkpdOb2LwHjy6+K+tGaPGVSiJqDWq/93JxTComhJyOJZWTyuauIYWJp3aFCy36bdKuJ5a6hytNcf+jHMyUdJcZTJc3bOq8fcxmH7sXhEP8BJSm87uR6gx0Wgmu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731591590; c=relaxed/simple;
	bh=kAVXCO4+80dleUyX1FwTfq4PaTIyTBIsVGRFMOn/TDU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AEEcX/1lOKsRUk/d67102YoGLqf5ahAF4+NvculUNFGdcw8M5dCw1IGHgOb5Rh77gK2eew7Hd+pNR4iwzqREdzqeZxhFbh8JPqSsV5ij+Td6vP+kLys8+q1fBk3ZKXKXLrwiTk+4iU71yX6URWCfcTo9x9tjCcncG3w5dzX50SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BPulQSx/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LZchN8cx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BPulQSx/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LZchN8cx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B906C1F37E;
	Thu, 14 Nov 2024 13:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731591580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kEFh0cqvzuNDxJOUZ89n6di3lYHEXClsHrlSh5rliPc=;
	b=BPulQSx/cEpFyVLEFf5OHS53j1keLfXiHmp44wBA39DZVN44Cc280pR1Qjo2tB+SW27ji3
	88j1cqcKUkVFkz+wfqusHTAFFujTQColTJt7PHR3nH0RPoq/uUXMcsTsql8uceQQcOv7ly
	qSvXFuDqcIBgOZ90z5Gehuf2Br50zMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731591580;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kEFh0cqvzuNDxJOUZ89n6di3lYHEXClsHrlSh5rliPc=;
	b=LZchN8cxLmCobHeHyVqjPQlqY+t7gjh0M61OT+eEFCaOLTLnsT8WstXrF9QZ25wfEJ1+5a
	zyd6Nch2o/oN6hCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731591580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kEFh0cqvzuNDxJOUZ89n6di3lYHEXClsHrlSh5rliPc=;
	b=BPulQSx/cEpFyVLEFf5OHS53j1keLfXiHmp44wBA39DZVN44Cc280pR1Qjo2tB+SW27ji3
	88j1cqcKUkVFkz+wfqusHTAFFujTQColTJt7PHR3nH0RPoq/uUXMcsTsql8uceQQcOv7ly
	qSvXFuDqcIBgOZ90z5Gehuf2Br50zMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731591580;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kEFh0cqvzuNDxJOUZ89n6di3lYHEXClsHrlSh5rliPc=;
	b=LZchN8cxLmCobHeHyVqjPQlqY+t7gjh0M61OT+eEFCaOLTLnsT8WstXrF9QZ25wfEJ1+5a
	zyd6Nch2o/oN6hCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8007513794;
	Thu, 14 Nov 2024 13:39:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h5qAHZz9NWf4YgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 14 Nov 2024 13:39:40 +0000
Date: Thu, 14 Nov 2024 14:39:35 +0100
Message-ID: <878qtmszmw.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: ump: Fix the wrong format specifier
In-Reply-To: <20241114075822.41614-1-zhangjiao2@cmss.chinamobile.com>
References: <20241114075822.41614-1-zhangjiao2@cmss.chinamobile.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Thu, 14 Nov 2024 08:58:22 +0100,
zhangjiao2 wrote:
> 
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> The format specifier of "unsigned int" in snprintf()
> should be "%u", not "%d".
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>

Applied now, thanks.


Takashi

