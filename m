Return-Path: <linux-kernel+bounces-274305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C53AC947654
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31290B20D58
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 07:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FFA14A093;
	Mon,  5 Aug 2024 07:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jpRXDzNE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="d0d7JvI5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jpRXDzNE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="d0d7JvI5"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D3B13CABC;
	Mon,  5 Aug 2024 07:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722844138; cv=none; b=iWicvjf7z9PFPJxoLsXBZbQo3AOBOlMBOZUjN2A7G01eMowzz2iOwPvoQV6nbBoR6jNy/pcPedEKscvK1B6wifKhTMN0uJcGuVO+90UqKZ7L6I94EiKQZtO60ywpJJl34TIXdXyOshZOlZzzi19IwO5+dM/xItfk1YgdbUV22Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722844138; c=relaxed/simple;
	bh=YyFSOnJHA91ZqKPYgMC8/ANKjdXFjr+RU5HyUGYKBNs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mo6F0tGSsIW1sHTYOLC1fcOtoBGIEuYqvK7ugdQoF9L3T2XaTJYZX2mkyljSeekfn7qReZa7oFLjJKL/N7SG8yco4XP9kfEM5z2AK0YV7rPkwu65psutDgOo7RXAJbWue6pK21vEWGhpOyt6lcU1IpolEjWSK/Z9ajizS4uIoHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jpRXDzNE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=d0d7JvI5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jpRXDzNE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=d0d7JvI5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 73E8621B7A;
	Mon,  5 Aug 2024 07:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722844128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lnDcRKh7UoJoVfaHnMiOmNsuVBJYo6i3KK6M1Qku/zg=;
	b=jpRXDzNETYctYtgPfd0Z1YSa6Zo02ZEuL1gYF4Y8bw6nLaupXi94gOusiMs+06RcqzJxgo
	e1E41Jf5RGsOsfipIrwybWZVM4pOrw7j120FjDHJGf0k0bf8ZuwwHL+xfH/l3SrfKLbojg
	vr9ZJDPyleXkcnFDRZtAGxR4FbWfa74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722844128;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lnDcRKh7UoJoVfaHnMiOmNsuVBJYo6i3KK6M1Qku/zg=;
	b=d0d7JvI5MqEI8q4nQQv84OeJuEo4aF6zNvLTonNGlVUBcudX9cBSfM5Ab8WYEP/zG2doLu
	Gdr9en/6kY3fq4Bw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jpRXDzNE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=d0d7JvI5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722844128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lnDcRKh7UoJoVfaHnMiOmNsuVBJYo6i3KK6M1Qku/zg=;
	b=jpRXDzNETYctYtgPfd0Z1YSa6Zo02ZEuL1gYF4Y8bw6nLaupXi94gOusiMs+06RcqzJxgo
	e1E41Jf5RGsOsfipIrwybWZVM4pOrw7j120FjDHJGf0k0bf8ZuwwHL+xfH/l3SrfKLbojg
	vr9ZJDPyleXkcnFDRZtAGxR4FbWfa74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722844128;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lnDcRKh7UoJoVfaHnMiOmNsuVBJYo6i3KK6M1Qku/zg=;
	b=d0d7JvI5MqEI8q4nQQv84OeJuEo4aF6zNvLTonNGlVUBcudX9cBSfM5Ab8WYEP/zG2doLu
	Gdr9en/6kY3fq4Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3805B13254;
	Mon,  5 Aug 2024 07:48:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eZF1DOCDsGZnUAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 05 Aug 2024 07:48:48 +0000
Date: Mon, 05 Aug 2024 09:49:26 +0200
Message-ID: <878qxbl88p.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Simon Trimmer <simont@opensource.cirrus.com>
Cc: <tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH v3] ALSA: hda: cs35l56: Stop creating ALSA controls for firmware coefficients
In-Reply-To: <20240801143139.34549-1-simont@opensource.cirrus.com>
References: <20240801143139.34549-1-simont@opensource.cirrus.com>
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
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -5.51
X-Rspamd-Queue-Id: 73E8621B7A

On Thu, 01 Aug 2024 16:31:39 +0200,
Simon Trimmer wrote:
> 
> A number of laptops have gone to market with old firmware versions that
> export controls that have since been hidden, but we can't just install a
> newer firmware because the firmware for each product is customized and
> qualified by the OEM. The issue is that alsactl save and restore has no
> idea what controls are good to persist which can lead to
> misconfiguration.
> 
> There is no reason that the UCM or user should need to interact with any
> of the ALSA controls for the firmware coefficients so they can be
> removed entirely, this also simplifies the driver.
> 
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
> ---
> Changes in v3:
> - Remove ability to add firmware coefficients as ALSA controls
>   entirely
> 
> Changes in v2:
> - v1 was accidentally the backport version for older kernels instead of
>   the one for v6.11

Applied now to for-linus branch.  Thanks.


Takashi

