Return-Path: <linux-kernel+bounces-386565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AB69B4525
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5787E2831CD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFE91EE014;
	Tue, 29 Oct 2024 09:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m2o11jjn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zk9NTIB9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m2o11jjn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zk9NTIB9"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E25618E35D;
	Tue, 29 Oct 2024 09:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730192539; cv=none; b=l3IXN42FnxNFpz6n0Hr1Apde76gkaUKreqjFyJjlshMWbXuIKNA1gSUd4qzaGirHhhpBvv8orJbCOJkLvTsVcWX0fmDo00npjnEbSeFVl7nmzJzUkBTZpNzbhCD3GKjEz7x6/8PWHNU6QtgP6t9mq6abRO5dcvl+3dbEvON1weQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730192539; c=relaxed/simple;
	bh=NtdFzJOp97394Q4Et/3bYuJRFxfOOMBt1r8lk0rQYXU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ftT4GUc7yTDqrZogWFeb7iplxfie91qF6X5MEsquyMIgUxD4tY2CyPkxXJSMQwewuueQmYbT2xhU0NIgEGqWheQ8yj1SZX9+X9hd6o/40nt9GO2NDWPLluzrut9hiBlMd6w5Uu1Me4MbcbE1sEE2nA2Iq27U7sJZYSp6nYio018=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m2o11jjn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zk9NTIB9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m2o11jjn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zk9NTIB9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 502201FE50;
	Tue, 29 Oct 2024 09:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730192535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2cDfEk7mo7OlH4G2ONhSdrP33D0dS24zcU36TyeVhLQ=;
	b=m2o11jjnjdC9uxt5ob38YJzaiv9nugfA6KS7lpdRP3iLeXw4LQcOgTXXGtZssAj1fROXup
	xyIHs9BCfmLAsXiN8e3km0jrnPLGHeVlfTyHM2KwhDP69COmoOgNx/RPBEwF3JSexMQqR7
	S+6GGwo/Ad+t1Gp9xpCydTTtFFqmJm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730192535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2cDfEk7mo7OlH4G2ONhSdrP33D0dS24zcU36TyeVhLQ=;
	b=zk9NTIB953jKYqkqV4GQ84gfsqk4Nh7saVxOuym46UAvP7EkTr+zJ4mwtEuYYvKtC2tEb3
	GuOuWQVZzj01mIAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=m2o11jjn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zk9NTIB9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730192535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2cDfEk7mo7OlH4G2ONhSdrP33D0dS24zcU36TyeVhLQ=;
	b=m2o11jjnjdC9uxt5ob38YJzaiv9nugfA6KS7lpdRP3iLeXw4LQcOgTXXGtZssAj1fROXup
	xyIHs9BCfmLAsXiN8e3km0jrnPLGHeVlfTyHM2KwhDP69COmoOgNx/RPBEwF3JSexMQqR7
	S+6GGwo/Ad+t1Gp9xpCydTTtFFqmJm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730192535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2cDfEk7mo7OlH4G2ONhSdrP33D0dS24zcU36TyeVhLQ=;
	b=zk9NTIB953jKYqkqV4GQ84gfsqk4Nh7saVxOuym46UAvP7EkTr+zJ4mwtEuYYvKtC2tEb3
	GuOuWQVZzj01mIAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2435B136A5;
	Tue, 29 Oct 2024 09:02:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qCt0B5ekIGdTFAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 29 Oct 2024 09:02:15 +0000
Date: Tue, 29 Oct 2024 10:03:18 +0100
Message-ID: <874j4v2sdl.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Piyush Raj Chouhan <piyushchouhan1598@gmail.com>
Cc: =inux-sound@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add subwoofer quirk for Infinix ZERO BOOK 13
In-Reply-To: <20241028155516.15552-1-piyuschouhan1598@gmail.com>
References: <20241028155516.15552-1-piyuschouhan1598@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 502201FE50
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 28 Oct 2024 16:55:16 +0100,
Piyush Raj Chouhan wrote:
> 
> Infinix ZERO BOOK 13 has a 2+2 speaker system which isn't probed correctly.
> This patch adds a quirk with the proper pin connections.
> Also The mic in this laptop suffers too high gain resulting in mostly fan noise being recorded,
> This patch Also limit mic boost.
> 
> HW Probe for device; https://linux-hardware.org/?probe=a2e892c47b
> 
> Test: All 4 speaker works, Mic has low noise.
> Signed-off-by: Piyush Raj Chouhan <piyushchouhan1598@gmail.com>

Applied now.  Thanks.


Takashi

