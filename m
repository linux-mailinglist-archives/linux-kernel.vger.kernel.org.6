Return-Path: <linux-kernel+bounces-324266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B087D974A6D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD511C25BA7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 06:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83386139D19;
	Wed, 11 Sep 2024 06:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m+oaTMRo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xdlzR4DS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m+oaTMRo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xdlzR4DS"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2254F135A69;
	Wed, 11 Sep 2024 06:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726036190; cv=none; b=RKU7Z25ul6HWelHZu6BbMcC+CcRROYEmUKo01BNTJ7Ju6vD0i3Yvgm9v78mVTOVUx5nIRDIgBEOnV8eNYz9nO0I6ew/5rsw+9R5puJC2E2ejaI1vdxe5zda4iXXkwdNewwdL/M1dIaDg0Kpo8AYeulcBDZF9hTVaQOALfEFAGoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726036190; c=relaxed/simple;
	bh=BTzW+Qsl5tWVVIEohJPwQ4s8s6HaUPRnNkTGy5ZtgRY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f0Vrg2ijDAwsdppbBmdiS6HCl7zeFzgDQpATBjDNwZp1YH4XL0pZhQWHtuOwJKxluN56H5wcGKqbfE8lastHIL/VjWuJ1kQzZ4ZIY2gaoM2irXdPUIj+eN4XzY49A9y93ssOjF+BHl1UFK89AU/qhPG41zPeU4CgL/L7aIWJRBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m+oaTMRo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xdlzR4DS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m+oaTMRo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xdlzR4DS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CEA1B1F871;
	Wed, 11 Sep 2024 06:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726036180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n+BaOvHAmKNC/Hnzen2jnP0lk48cwXnLiIUKZq4cmpQ=;
	b=m+oaTMRocw9scPlXM1B27iDp+Oi1b9kzkerZKFXabRV6HqYZhSn3RBTcz+cWHA0hnLGCfP
	8KAxR4ILrYJTswedpbZn4aJT9VWQwTh3w/DvAvahvQ9uvj/1R3D+rg9TmOLpLc53nSsi/X
	iCEdI8O6c5J7UnKf2v+A6/yCZG5dM+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726036180;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n+BaOvHAmKNC/Hnzen2jnP0lk48cwXnLiIUKZq4cmpQ=;
	b=xdlzR4DScBgV9ERptSuR7st0T3P4UzL+tg9qQYsrFEQM0Zch//5OEAoXcspXBAE595m+kw
	tS5jQKONLPCHvTDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726036180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n+BaOvHAmKNC/Hnzen2jnP0lk48cwXnLiIUKZq4cmpQ=;
	b=m+oaTMRocw9scPlXM1B27iDp+Oi1b9kzkerZKFXabRV6HqYZhSn3RBTcz+cWHA0hnLGCfP
	8KAxR4ILrYJTswedpbZn4aJT9VWQwTh3w/DvAvahvQ9uvj/1R3D+rg9TmOLpLc53nSsi/X
	iCEdI8O6c5J7UnKf2v+A6/yCZG5dM+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726036180;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n+BaOvHAmKNC/Hnzen2jnP0lk48cwXnLiIUKZq4cmpQ=;
	b=xdlzR4DScBgV9ERptSuR7st0T3P4UzL+tg9qQYsrFEQM0Zch//5OEAoXcspXBAE595m+kw
	tS5jQKONLPCHvTDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F653132CB;
	Wed, 11 Sep 2024 06:29:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D0mZJdQ44WaxOAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 11 Sep 2024 06:29:40 +0000
Date: Wed, 11 Sep 2024 08:30:28 +0200
Message-ID: <87ttem4s8r.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Leo Tsai <antivirus621@gmail.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	leo.tsai@cmedia.com.tw,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PATCH v3]ALSA: hda: Add a new CM9825 standard driver
In-Reply-To: <20240910065542.6534-1-antivirus621@gmail.com>
References: <20240910065542.6534-1-antivirus621@gmail.com>
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
	BAYES_HAM(-3.00)[99.98%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Tue, 10 Sep 2024 08:55:42 +0200,
Leo Tsai wrote:
> 
> The CM9825 is a High Definition Audio Codec.
> There are 2 independent stereo outputs, one of the stereo
> outputs is cap-less with HP AMP, and the other is line out to
> connect the active speaker. The inputs can be Line-in and MIC-in.
> 
> Signed-off-by: Leo Tsai <antivirus621@gmail.com>

Applied now.  Thanks!


Takashi

