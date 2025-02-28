Return-Path: <linux-kernel+bounces-538171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F52A4953F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E11D1895636
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC6B25BAAB;
	Fri, 28 Feb 2025 09:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="f4yUptjd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hGDJHir9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="f4yUptjd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hGDJHir9"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A181B25A33F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735350; cv=none; b=DSTw6QApA7JQBC5p/TFE3v0cn7PEXxAEBNO17qaqoFE0HUWPEbKYgXACuCNHgufJISq/YOH/jxkRMAOz1IiGq4ukdRRbWOz/OTyEiNQFufGGle1vN8PEvAqxcEBt9dIa+Tp+WX/zKm2MhSjxMJGV7unn1I8BVncg9HwJPy1GE4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735350; c=relaxed/simple;
	bh=CJd4zI5DEoGnhGt2ovmxIPHzIsuD5CoyttXqlEUs0H4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o4+kYGtZ0ICgFxC+n441ZoNczSMzDlzu0Ky6LEZOjCwU1scWC/8OF48pWb/moWEu+yHaRop93VEBCQhAkGITQ8v5136oMqZAXyrs+CvS4FxPn/s0464Y42OwoRcVWKkbEpD993TwyDvCG93j/GIVOsDRYXSrhfJQgmLnf9ePvY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=f4yUptjd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hGDJHir9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=f4yUptjd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hGDJHir9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C3E8C1F38F;
	Fri, 28 Feb 2025 09:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740735346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q7oqDkvMYuAbsul1/L1uNlA+Mh9xFj0VGt11HHTnYOY=;
	b=f4yUptjdk4eucsKeWDR2/PTXIc/ful2h6oiflg6anliq0lu5qe4vVTwUuH9IlCeRwATdvm
	CTu316uf7hXSrTP6ZHOvgPJJshiPsAYlrRzVqMDH1/JLZBNXj/O1DMh47yQMPvnT2HmTB1
	KmvR7PuxB7jPkaQo7BbEUVaHI1CG4Z4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740735346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q7oqDkvMYuAbsul1/L1uNlA+Mh9xFj0VGt11HHTnYOY=;
	b=hGDJHir9aemVO2fMdr5CoQ5O8cUEeNtUexZcTNrNrd46lfmNBDBv3jRdbpMionbPG5NUxp
	1G3AL8BOsy3wm0DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740735346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q7oqDkvMYuAbsul1/L1uNlA+Mh9xFj0VGt11HHTnYOY=;
	b=f4yUptjdk4eucsKeWDR2/PTXIc/ful2h6oiflg6anliq0lu5qe4vVTwUuH9IlCeRwATdvm
	CTu316uf7hXSrTP6ZHOvgPJJshiPsAYlrRzVqMDH1/JLZBNXj/O1DMh47yQMPvnT2HmTB1
	KmvR7PuxB7jPkaQo7BbEUVaHI1CG4Z4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740735346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q7oqDkvMYuAbsul1/L1uNlA+Mh9xFj0VGt11HHTnYOY=;
	b=hGDJHir9aemVO2fMdr5CoQ5O8cUEeNtUexZcTNrNrd46lfmNBDBv3jRdbpMionbPG5NUxp
	1G3AL8BOsy3wm0DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 912F21344A;
	Fri, 28 Feb 2025 09:35:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jx3tIXKDwWeoUAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 28 Feb 2025 09:35:46 +0000
Date: Fri, 28 Feb 2025 10:35:46 +0100
Message-ID: <87cyf2csy5.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Charles Han <hanchunchao@inspur.com>
Cc: <perex@perex.cz>,
	<tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ALSA: seq: seq_oss_event: fix inconsistent indenting warning in note_on_event()
In-Reply-To: <20250228033427.7056-1-hanchunchao@inspur.com>
References: <20250227092441.19044-1-hanchunchao@inspur.com>
	<20250228033427.7056-1-hanchunchao@inspur.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 28 Feb 2025 04:34:27 +0100,
Charles Han wrote:
> 
> Fix below inconsistent indenting smatch warning.
> smatch warnings:
> sound/core/seq/oss/seq_oss_event.c:297 note_on_event() warn: inconsistent indenting
> 
> Signed-off-by: Charles Han <hanchunchao@inspur.com>

Thanks, applied.


Takashi

