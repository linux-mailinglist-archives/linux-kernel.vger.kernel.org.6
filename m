Return-Path: <linux-kernel+bounces-516056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA66CA36C7D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 08:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DEE87A4EE6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 07:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E4A198E63;
	Sat, 15 Feb 2025 07:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qqFqp0qK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xfIh23c2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qqFqp0qK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xfIh23c2"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4CC17BEC6
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 07:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739605229; cv=none; b=PhT6UdgZzWJ10rpV4UQApsr8fkwqn9eYF1TiSA3aAMFUOm1bxNEsve/HD297DGltwxpMYiV7UCsVgb6zkMB2/ytkd8COsjjr2V4kN+qIvlikctaphJYfsC/CUWTKHr4f3kISiPErIvmKeqxAlsMS5NeohhqfHCOkNnGs3dd/t78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739605229; c=relaxed/simple;
	bh=Wq2FdLDDQU4Q4XhQ/ytlo46V0/wxP5QsCCK0tYSiyzQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/VEDhCaeNDGnPzl01sgojmQGeo1eNIZTjVq9o4cEQ+tJd4Di/OZxHXOvO2LHLD/8QUmvOepvLcQB6ZjH+SQTRkM8EuqXANLVibsIu7ZGNImE1Yfizo0/igAjsO/zXGVvz4NyVPpJL5ttEOqf9nI/TUzOJYb6slveepO8FrNgR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qqFqp0qK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xfIh23c2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qqFqp0qK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xfIh23c2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 31A711F381;
	Sat, 15 Feb 2025 07:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739605226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=89GOzecJWJ5fth28wmJfBX2Crh6E0LoclWly+ExUfUc=;
	b=qqFqp0qKK/y06BVGRhpXpupplRKuoJaD7DjqYhgpa6iojc/+hdGOgerVmML0WtzjrlIm0X
	IWQNMlhrQzPgJ6QyY2Fo6GiFU2YI1HgJxLVn7bHoB88btHq136WGHnUfd4z2XLAKaQh7I+
	dNqHdG9ojHBLtxaLYkXQpx3xd0VM8t4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739605226;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=89GOzecJWJ5fth28wmJfBX2Crh6E0LoclWly+ExUfUc=;
	b=xfIh23c26XOmwcHMONfD9I1lbKYexFlb3BGzm+kEsKQXSY6404XWHe8ltUOpTejPxzq2+u
	N5r1BrIR0sYZ+rDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739605226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=89GOzecJWJ5fth28wmJfBX2Crh6E0LoclWly+ExUfUc=;
	b=qqFqp0qKK/y06BVGRhpXpupplRKuoJaD7DjqYhgpa6iojc/+hdGOgerVmML0WtzjrlIm0X
	IWQNMlhrQzPgJ6QyY2Fo6GiFU2YI1HgJxLVn7bHoB88btHq136WGHnUfd4z2XLAKaQh7I+
	dNqHdG9ojHBLtxaLYkXQpx3xd0VM8t4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739605226;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=89GOzecJWJ5fth28wmJfBX2Crh6E0LoclWly+ExUfUc=;
	b=xfIh23c26XOmwcHMONfD9I1lbKYexFlb3BGzm+kEsKQXSY6404XWHe8ltUOpTejPxzq2+u
	N5r1BrIR0sYZ+rDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B75AB13782;
	Sat, 15 Feb 2025 07:40:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jMhbKelEsGf0PwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 15 Feb 2025 07:40:25 +0000
Date: Sat, 15 Feb 2025 08:40:24 +0100
Message-ID: <87tt8vpsev.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH 1/2 v2] ALSA: hda/cirrus: Correct the full scale volume set logic
In-Reply-To: <20250214210736.30814-1-vitalyr@opensource.cirrus.com>
References: <20250214210736.30814-1-vitalyr@opensource.cirrus.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 14 Feb 2025 22:07:28 +0100,
Vitaly Rodionov wrote:
> 
> This patch corrects the full-scale volume setting logic. On certain
> platforms, the full-scale volume bit is required. The current logic
> mistakenly sets this bit and incorrectly clears reserved bit 0, causing
> the headphone output to be muted.
> 
> Fixies: 342b6b610ae2 (ALSA: hda/cs8409: Fix Full Scale Volume setting for all variants)

It should be "Fixes" :)
Also, the tag should be in the form of
  Fixes: $ID ("$SUBJECT")
with quotes.  I fixed and applied now.


thanks,

Takashi

