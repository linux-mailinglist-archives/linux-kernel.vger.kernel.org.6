Return-Path: <linux-kernel+bounces-561194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5A0A60E9D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0D1C17EBE4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAA01F2380;
	Fri, 14 Mar 2025 10:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PYuOpvm2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AVrCNw5k";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PYuOpvm2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AVrCNw5k"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948A61EEA54
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947551; cv=none; b=mIraTw4WFtUFH7h/T5cGpHh/zSj+huU28UNs2KHNSEJJrm6ywcVlPxuOrocJx4dwxBYbEWJmoXZZHj0cMhHGkRVPTdwd+PBa3UcZbw3Qvpsugd8HKygYmH4nVjXxTQClupsbr2U9Fau4BHtSVDdIP9xNdeCsvrShOu5DobPn3Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947551; c=relaxed/simple;
	bh=EOgqDjfqM7VBbEiot2b6fCej1BF5paQRm6TKfXdPOkE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4gD3jrPSRNyAkajeGjO7ymj8mdbcDlkfOC/Wbv6hoF7Vu7jhuIm7H2MXJbF3ETZl8kWiIFQ+gsxmzHGebnYJXzBRSrCd8Yd7XlpcWFlB6EyUM7rkOYejTKUFW7UeGzMi0uzJb+SFus7EJ7bogideK4vmrhsXU5QvLbMDs+ZjZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PYuOpvm2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AVrCNw5k; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PYuOpvm2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AVrCNw5k; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B2E9821184;
	Fri, 14 Mar 2025 10:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741947546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DbMEwshk89AHvd1r2trkgy4A2gplprrLPYdXIjP3X4E=;
	b=PYuOpvm2F0T0InLTDlwY1K9pfHmgqk7jIOMM1vt6II290V9jy+pDkMBMKcVZYJlVwlkSbD
	bffEb+Jk2YaMCAQ55C3o3wRmK0PPm4mH+bzRdTO6zwfyLJhGS/ZFow0DehrsRii6Juvn4+
	Tnh8RhWwXkF8n2U/y3uVPn9BfdZcg8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741947546;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DbMEwshk89AHvd1r2trkgy4A2gplprrLPYdXIjP3X4E=;
	b=AVrCNw5kosgSDtykgEyx5E8KCDTWEf/Ja910oqWkrequ7TS/dBmI+yBPPbt51pIC7g3gLB
	VGF65QsTdmrWWNCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PYuOpvm2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=AVrCNw5k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741947546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DbMEwshk89AHvd1r2trkgy4A2gplprrLPYdXIjP3X4E=;
	b=PYuOpvm2F0T0InLTDlwY1K9pfHmgqk7jIOMM1vt6II290V9jy+pDkMBMKcVZYJlVwlkSbD
	bffEb+Jk2YaMCAQ55C3o3wRmK0PPm4mH+bzRdTO6zwfyLJhGS/ZFow0DehrsRii6Juvn4+
	Tnh8RhWwXkF8n2U/y3uVPn9BfdZcg8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741947546;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DbMEwshk89AHvd1r2trkgy4A2gplprrLPYdXIjP3X4E=;
	b=AVrCNw5kosgSDtykgEyx5E8KCDTWEf/Ja910oqWkrequ7TS/dBmI+yBPPbt51pIC7g3gLB
	VGF65QsTdmrWWNCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 856C713A31;
	Fri, 14 Mar 2025 10:19:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /6FZH5oC1GfLYgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 14 Mar 2025 10:19:06 +0000
Date: Fri, 14 Mar 2025 11:19:06 +0100
Message-ID: <87wmcr9ap1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Ricard Wanderlof <ricard2013@butoba.net>
Cc: Clemens Ladisch <clemens@ladisch.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: Fix CME quirk for UF series keyboards
In-Reply-To: <20250313-cme-fix-v1-1-d404889e4de8@butoba.net>
References: <20250313-cme-fix-v1-1-d404889e4de8@butoba.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: B2E9821184
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Thu, 13 Mar 2025 23:16:17 +0100,
Ricard Wanderlof wrote:
> 
> Fix quirk for CME master keyboards so it not only handles
> sysex but also song position pointer, MIDI timing clock, start
> and stop messages, and active sensing. All of these can be
> output by the CME UF series master keyboards.
> 
> Tested with a CME UF6 in a desktop Linux environment as
> well as on the Zynthian Raspberry Pi based platform.
> 
> Signed-off-by: Ricard Wanderlof <ricard2013@butoba.net>
> ---
> The CME UF6 not only sends sysex messages using CIN 0xf which
> in the standard is only intended for single-byte unparsed
> messages, but also song position pointer, as well as ordinary
> MIDI timing clock, start, stop and active sensing.
> 
> The old quirk sent all four bytes of the USB MIDI message through
> when CIN 0xf was received, which caused trailing bytes in the case
> of single byte data, which would be interpreted as zero-valued
> repeats of the previosly received channel message due to the
> running status feature of MIDI. (In practice, this causes
> continuous controllers to be reset to 0 as soon as a new value is
> set. For note messages, it basically results in a note off for
> note number 0, which is an annoyance although harmless in 
> practice.)
> 
> Furthermore, the UF6 can send multiple messages in the same
> packet. Because of this, and the 0xf quirk, we need to parse each
> such message individually to get the length right, before sending
> it on.
> 
> Finally, the UF6 sends messages with length 0 when it has nothing
> else to send; don't forward these useless messages.
> 
> According to the original comment in the code, the old
> functionality was intended to handle sysex messages only, and this
> commit will still handle that case properly, so should be
> compatible with all devices utilizing this quirk. I have only
> tested this with a CME UF6 as don't have access to any other
> CME devices (which are pretty old and rare these days).

Thanks, applied now.


Takashi

