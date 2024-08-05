Return-Path: <linux-kernel+bounces-274306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FDA947656
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F22281036
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 07:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BC3149E0B;
	Mon,  5 Aug 2024 07:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="P9cK75WJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5u1MD5jp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="P9cK75WJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5u1MD5jp"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F0B149DE3;
	Mon,  5 Aug 2024 07:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722844158; cv=none; b=rmFyNqlWx8W4wNFG3sH9KuMtMDd2sbD6jIG1wKvAxeG6QMXLSivwpH5+SHk/9icHLU+8zisBlSEb3X8hU8H7N/9bxM5DOWBuP+tKnCmDjSutXw0ZqB8kVrwsHovdpApge1JhfWiZUmxmSJvG6wsVGoHZki15cevHrYrNJdCMQgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722844158; c=relaxed/simple;
	bh=8ovik4tZwzi1xl97ga7M/9sRpiNXu3A2yAVl/ALhG40=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZMCjzAMYCkr1OReiSAu3RCy9tnMzpFec8CY0RERXPcDGJ/FOEHDL+yyUxIS+h0k72MRwpGKjmDCkjPdtaAw+s4H5LElwF9X5YsDwj9UhZN2fmRQilSUa2cFozQRaaAsdPfv7LKxgxKJc4IrQZHD57tZlVKkN7ME0vCfUxHmybc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=P9cK75WJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5u1MD5jp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=P9cK75WJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5u1MD5jp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1AF7321B7A;
	Mon,  5 Aug 2024 07:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722844155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R/oIjTtOdQZC83coUM4LDj6b9/ldcdBlQly3TQ8twlU=;
	b=P9cK75WJTVLY7jAaqJwg2JYjwN1+9HoYIQ3nNDhMZiRHQVAUxKYfpYbUe9WAGFR3waWWZ/
	XciNlVa3zPjw0K+91q0TveO3o/Q2ysXGXV37Ba4Da/Jjm5+qP3ZF1NafJY4q4+tpZ34Lyu
	c3v5AF4TcUYy5rwFqZU9udU9LaIAQy4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722844155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R/oIjTtOdQZC83coUM4LDj6b9/ldcdBlQly3TQ8twlU=;
	b=5u1MD5jpy2NQA/TjpU0Fh/cpYudF7dqSwf6MAl2a5IwrXl5L4S66yVnhxg/LeG9zO1oD0u
	pAi2hkY0wjLyOgDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=P9cK75WJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5u1MD5jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722844155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R/oIjTtOdQZC83coUM4LDj6b9/ldcdBlQly3TQ8twlU=;
	b=P9cK75WJTVLY7jAaqJwg2JYjwN1+9HoYIQ3nNDhMZiRHQVAUxKYfpYbUe9WAGFR3waWWZ/
	XciNlVa3zPjw0K+91q0TveO3o/Q2ysXGXV37Ba4Da/Jjm5+qP3ZF1NafJY4q4+tpZ34Lyu
	c3v5AF4TcUYy5rwFqZU9udU9LaIAQy4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722844155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R/oIjTtOdQZC83coUM4LDj6b9/ldcdBlQly3TQ8twlU=;
	b=5u1MD5jpy2NQA/TjpU0Fh/cpYudF7dqSwf6MAl2a5IwrXl5L4S66yVnhxg/LeG9zO1oD0u
	pAi2hkY0wjLyOgDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF3A113254;
	Mon,  5 Aug 2024 07:49:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cztJNfqDsGZ9UAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 05 Aug 2024 07:49:14 +0000
Date: Mon, 05 Aug 2024 09:49:53 +0200
Message-ID: <877ccvl87y.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Stefan Binding <sbinding@opensource.cirrus.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	<alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH v2] ALSA: hda: cs35l41: Stop creating ALSA Controls for firmware coefficients
In-Reply-To: <20240801155047.456540-1-sbinding@opensource.cirrus.com>
References: <20240801155047.456540-1-sbinding@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Rspamd-Queue-Id: 1AF7321B7A

On Thu, 01 Aug 2024 17:50:44 +0200,
Stefan Binding wrote:
> 
> When the CS35L41 loads its firmware, it has a number of controls to
> affect its behaviour. Currently, these controls are exposed as ALSA
> Controls.
> 
> These controls were never intended to be exposed to users but the
> firmware doesn't mark them hidden, so make the driver ignore them.
> 
> Any changes in the coefficients handled by these controls needs to
> be matched to the individual system by SSID, which is already handled
> using the tuning file, when firmware is loaded, so UCM should not be
> setting these controls anyway.
> 
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>

Applied to for-linus branch now.  Thanks.


Takashi

