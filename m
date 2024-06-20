Return-Path: <linux-kernel+bounces-222199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C89CD90FE1E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E44AB212D6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 07:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E13151016;
	Thu, 20 Jun 2024 07:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eSI3kgrX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="U0TFmWih";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aiVC72NL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GD3Cmcsr"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F951C6AF;
	Thu, 20 Jun 2024 07:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718870321; cv=none; b=clNoi5reY62QppAwO+9+kQ5gZultsY75b1+Q8XdaR+s11xlSKguUE7KKl/YSf9f/ku4m6uU+X/O4ih9+e32zscTc79NDTlc80Jm2sqJRohROldNJMMhpc9Vr2q+3DwuSmWT3NtC1sfncICgapw6ewzzCHTEwSKz1Tbl6/S4jBUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718870321; c=relaxed/simple;
	bh=ss1+EZEKro2sZjXPDmzIZh1iD2THxjhpN0tqtg7dODk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GXbnPP9EeVgribjhP1wbX+Pv3rl0xrpVelFrWh62SxWwFXqafmJGO5qfh0zfwKYXePhFIR5SzcAKeDWtTrR6Bf6DpTVWj4JsQ+ssKq5O3a293gQozy4tV+uF4WiBZeTRlOIu6GDWFPLoN4ZZus/A497y3mciUwld48F1Kwo9kOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eSI3kgrX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=U0TFmWih; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aiVC72NL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GD3Cmcsr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E662E2175B;
	Thu, 20 Jun 2024 07:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718870318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EyrXaIdP3ULci40nIjouHmuwVCbTd4pFecrGu85K7I8=;
	b=eSI3kgrXJleHkiIdP/2m6XxnZcWfn+zH0RKAHxObCYQqi4LGMg9iKlzaMxWBdclGF1+sku
	FxyU2GUEdb2WLUTzm1XhV4TO6WwpBB4sxs/KaTaym16EUAAGHoytYgfhaaPZHnTgNIr7br
	+zXzlWqd9Cce1IU5ZWdkMyQS/zmnxL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718870318;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EyrXaIdP3ULci40nIjouHmuwVCbTd4pFecrGu85K7I8=;
	b=U0TFmWihW0QiE6iZQPyFE6bYxQQB1y4OOkh9m0tkg8VNKxBxyoSMB1Sk95kHaSDjV26kyl
	dCILQw3AF17rhFCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=aiVC72NL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GD3Cmcsr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718870317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EyrXaIdP3ULci40nIjouHmuwVCbTd4pFecrGu85K7I8=;
	b=aiVC72NLOzdGINgU/hGK0xP8yZ1gPt2Gan3xdvs9EYVFUj23O+srdI0Tvzvs6RHaX6eTwE
	PKD/EOMM9qxz1oKFbX8ywJ63oouEQTm3psi+fbglHCC8HNL3TuRCmOh38FBXfaq7B7H94U
	NHb2QE8bJGNoXaD+i90F8aPm2P9o7PE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718870317;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EyrXaIdP3ULci40nIjouHmuwVCbTd4pFecrGu85K7I8=;
	b=GD3CmcsrZfgWqdJD7aPewrr5fZ8GgdFjogIdMrQMhqWI3DZMHWkqkkIJXZkuy3YJ3/lgME
	G9U3YwCQ6WDZd6Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A702B13AC1;
	Thu, 20 Jun 2024 07:58:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8ontJS3hc2axVwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 20 Jun 2024 07:58:37 +0000
Date: Thu, 20 Jun 2024 09:59:03 +0200
Message-ID: <87cyoc2gfs.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Simon Trimmer <simont@opensource.cirrus.com>
Cc: <tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH] ALSA: hda: cs35l56: Select SERIAL_MULTI_INSTANTIATE
In-Reply-To: <20240619161602.117452-1-simont@opensource.cirrus.com>
References: <20240619161602.117452-1-simont@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: E662E2175B
X-Spam-Score: -5.50
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-5.50 / 50.00];
	BAYES_HAM(-2.99)[99.96%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Wed, 19 Jun 2024 18:16:02 +0200,
Simon Trimmer wrote:
> 
> The ACPI IDs used in the CS35L56 HDA drivers are all handled by the
> serial multi-instantiate driver which starts multiple Linux device
> instances from a single ACPI Device() node.
> 
> As serial multi-instantiate is not an optional part of the system add it
> as a dependency in Kconfig so that it is not overlooked.
> 
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>

Applied now to for-linus branch.  Thanks.


Takashi

