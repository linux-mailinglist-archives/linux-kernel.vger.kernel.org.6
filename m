Return-Path: <linux-kernel+bounces-441182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C439ECAB5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD620169B44
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334C11EC4EA;
	Wed, 11 Dec 2024 10:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kweNVhfr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wCHSz1pl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kweNVhfr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wCHSz1pl"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4B3239BC4
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733914537; cv=none; b=E1dT8DQGtm0wVj0mqaGh0m11wEvoog0IUm9rQKY+DkQx4T5Q7Nyl75uWCMeMBqpxdrKhf+9NcHFuStjVTDv4X7zQnrxL3/+7Og8SH+LlgFIyHcoIlUAOHP20HhuYRIXqX4eBrzaBm/MIjyYv0BVZyLJ4NjAgfrkezXGKMluT/Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733914537; c=relaxed/simple;
	bh=8ubElFPwjHycNjFrW9z0XYAiigHs4ZcryCq1r3llRow=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EBNojF09/MmNVWt5YZqiuSFczEZqofncQVtMtaLqMbOfqRGnbQXFwdkixPN69QVoO8DZJJPn5nTHEDRQPdBBQqug2OxPWf3fAYw8seaW/ASnuiE51qnJr72OhZ4pkzLnOoaKOZblSSfcX572nU0ImTBUUqRRKpJ/NfmeHW4/coo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kweNVhfr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wCHSz1pl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kweNVhfr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wCHSz1pl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D63C721114;
	Wed, 11 Dec 2024 10:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733914533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DFHwJAzUaJg9vLlBzM9HuaXQrGkjzqZF6G6iw21/CnM=;
	b=kweNVhfrz1/Xz5hwZz84ok40l/5GrD4eLrgEHYGVAueVt41yly1P0/Q8ZjCQYklWuaZNx2
	1omDjHGLTOgIrlNWy4A7vQUVn5RYnsk8xOjUXxedNJprz69VYs2Wno70FmC7Fz69JiOP3a
	On4weW7CYHv3law4xPc3AcLUqdwjj94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733914533;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DFHwJAzUaJg9vLlBzM9HuaXQrGkjzqZF6G6iw21/CnM=;
	b=wCHSz1plVREcbIMmYJ5rc8+Iz0scQ4QlUmwfPwqfZSBcw400PLoljvnEV+oFRnr5XWFQmB
	Aq/JqIb2Lq0sNyCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733914533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DFHwJAzUaJg9vLlBzM9HuaXQrGkjzqZF6G6iw21/CnM=;
	b=kweNVhfrz1/Xz5hwZz84ok40l/5GrD4eLrgEHYGVAueVt41yly1P0/Q8ZjCQYklWuaZNx2
	1omDjHGLTOgIrlNWy4A7vQUVn5RYnsk8xOjUXxedNJprz69VYs2Wno70FmC7Fz69JiOP3a
	On4weW7CYHv3law4xPc3AcLUqdwjj94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733914533;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DFHwJAzUaJg9vLlBzM9HuaXQrGkjzqZF6G6iw21/CnM=;
	b=wCHSz1plVREcbIMmYJ5rc8+Iz0scQ4QlUmwfPwqfZSBcw400PLoljvnEV+oFRnr5XWFQmB
	Aq/JqIb2Lq0sNyCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5BB31344A;
	Wed, 11 Dec 2024 10:55:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HN0nK6VvWWdiZgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 11 Dec 2024 10:55:33 +0000
Date: Wed, 11 Dec 2024 11:55:33 +0100
Message-ID: <87frmu32vu.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mike Lothian <mike@fireburn.co.uk>
Cc: alsa-devel@alsa-project.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 30/37] ALSA: seq: Automatic conversion of UMP events
In-Reply-To: <CAHbf0-HuzfubZiLBsPhc24HrmS54sAsoDd_DVHPj+nTFqtuFAQ@mail.gmail.com>
References: <CAHbf0-HuzfubZiLBsPhc24HrmS54sAsoDd_DVHPj+nTFqtuFAQ@mail.gmail.com>
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
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Wed, 11 Dec 2024 11:35:09 +0100,
Mike Lothian wrote:
> 
> Hi
> 
> I'm not sure when this first appeared but I see the following when
> compiling/linking with Clang 19.1.5
> 
> vmlinux.o: warning: objtool: cc_ev_to_ump_midi2+0x5a5: return with
> modified stack frame

Could you figure out which line corresponds to this?


thanks,

Takashi

