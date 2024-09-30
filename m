Return-Path: <linux-kernel+bounces-343515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E187A989BEC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 838ACB214FA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0342F16F27F;
	Mon, 30 Sep 2024 07:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z/fqHy4u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uVggnxor";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z/fqHy4u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uVggnxor"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5071C208D0;
	Mon, 30 Sep 2024 07:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727682718; cv=none; b=UQJmTzeEJ1uleEp2a3sifLlQF7h0E7af395apabbeCriyahdubTmvnj1zQQt6xjPR88fQ9DyJqXJfAyZatm5JYj74KUK7WJei5CrFqQxkMwfMSSDelRC1Cn597uOkm0cPP1KwNnOaNDiYIxgll1oy4tk3H/jdRQGrKofiaexetY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727682718; c=relaxed/simple;
	bh=0lZGkMbvK4eW7PhLpxdSQPbY8tL3Zs56wzN308/AjFQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+6gGawZeQZ63uW1Wu7ilTtzAy1mWXf4JMpmxFmzW8/HsVpIgYogIeX+pyttxVM+dNimpdlaFS7vMwgRnZbfwO3+glMWVRQfPielIHLAtv1GX1ALeQed1XqWfgVkn7wyV4qXwzEVR7+fAdKkKGBpz5IwPBOwzrnuo/Wve/PiE+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z/fqHy4u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uVggnxor; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z/fqHy4u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uVggnxor; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BC47721A3A;
	Mon, 30 Sep 2024 07:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727682714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SJVAb+BuJivyGAGxd+xpSwRXJE6u71PNtHQgXRC8H+w=;
	b=z/fqHy4uKxjlmJ1+fOZv6xdwVcRP6aGTYEWtPaPw32QYLa1zLa2wI2XdcxVSyA5hPfB+DL
	6ZpgDsTi0m/OAgoo2XAq6+OoDTP1jL6/+oiO7eHL7ENpfOpHDBGLeDnIh4baCmUg4remox
	4pdTWiPxOO6sT3isMg0A4QChh0+u3F0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727682714;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SJVAb+BuJivyGAGxd+xpSwRXJE6u71PNtHQgXRC8H+w=;
	b=uVggnxorqSGIY1KzgMATKKbqyxiDQxYVjdwwvC5aKAGK1yYIwdRKp/iuRYHs+Fi4cCXtP2
	jfbsgT0E0w/YOACQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727682714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SJVAb+BuJivyGAGxd+xpSwRXJE6u71PNtHQgXRC8H+w=;
	b=z/fqHy4uKxjlmJ1+fOZv6xdwVcRP6aGTYEWtPaPw32QYLa1zLa2wI2XdcxVSyA5hPfB+DL
	6ZpgDsTi0m/OAgoo2XAq6+OoDTP1jL6/+oiO7eHL7ENpfOpHDBGLeDnIh4baCmUg4remox
	4pdTWiPxOO6sT3isMg0A4QChh0+u3F0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727682714;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SJVAb+BuJivyGAGxd+xpSwRXJE6u71PNtHQgXRC8H+w=;
	b=uVggnxorqSGIY1KzgMATKKbqyxiDQxYVjdwwvC5aKAGK1yYIwdRKp/iuRYHs+Fi4cCXtP2
	jfbsgT0E0w/YOACQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FF0813A8B;
	Mon, 30 Sep 2024 07:51:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GzYWGppY+mahDwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 30 Sep 2024 07:51:54 +0000
Date: Mon, 30 Sep 2024 09:52:47 +0200
Message-ID: <87frphk27k.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Yu Jiaoliang <yujiaoliang@vivo.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Christian Brauner <brauner@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Pavel Hofman <pavel.hofman@ivitera.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v2] ALSA: Fix typos in comments across various files
In-Reply-To: <20240924041749.3125507-1-yujiaoliang@vivo.com>
References: <20240924041749.3125507-1-yujiaoliang@vivo.com>
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
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Tue, 24 Sep 2024 06:17:45 +0200,
Yu Jiaoliang wrote:
> 
> This patch fixes typos in comments within the ALSA subsystem.
> These changes improve code readability without affecting
> functionality.
> 
> Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
> ---
> v2: Update commit message.

Thanks, applied now.


Takashi

