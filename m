Return-Path: <linux-kernel+bounces-357157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C30996CA5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77ED51C2113C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B1C19925B;
	Wed,  9 Oct 2024 13:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j4fUE0p/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Hrc1cMwg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DUPAP0z0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zVmGkj5h"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1776197A77;
	Wed,  9 Oct 2024 13:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728481750; cv=none; b=jdQuExK7gKPaNMNbKjR0FL3vKI9vj0YETgRz4178hD8W9npiBRAvPmwYKuSpM2dtaQBnk68lzFP1q65JS7GK2gEqsBo+Nt4Vt6UvD4yBPuxNycuHzRhS5LbQ11q/Y8j0YNhfFOiIuwZ+ggrr+Dj4WpIjPZDGKi9elm1McAjhdV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728481750; c=relaxed/simple;
	bh=YXJWvRTh/Yvo7boP2s83WbOz7ucuh8O27BfdTsO8Z5U=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=neIOgRvEdaKseqR7W+qJgCbFSmslSS6n/NCGUE9teb/NLUh4epG7dwrwvRSVOwn0sDwPYnSNdIAFRBCRFyz4FPYAo3Cdj6DMq+x9euVZOSkddT7Wacevgc83GB3QemD0x38SL4vKNnAxSNUJqodCOJuBfAXsO9OnUqjA6c3yads=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=j4fUE0p/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Hrc1cMwg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DUPAP0z0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zVmGkj5h; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CFD1821F70;
	Wed,  9 Oct 2024 13:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728481747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mr/ufbEs3uqbhaatE1ESPsPdrQavlqICG1ghV71HRP0=;
	b=j4fUE0p/4T9otVoYE6NO9Nu49D2lJ5jKuguyXNCU+8YJd7DLLGq+pTOHOiQ4DiEljGSMQ7
	d4v0Txq7kb7B3sidoGJSNLAIZzbBIKZjMBWb7naQxcjNHOT5j8iu6AqERdpFb9sPsoWsOR
	CilDn3zvAbqM0zKpTBA/ffFxBhJxUsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728481747;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mr/ufbEs3uqbhaatE1ESPsPdrQavlqICG1ghV71HRP0=;
	b=Hrc1cMwgKoJhsqfbbL8rXT53Tkm5nmwffynmrX08GxSHDHeMUmdiLqintFrCRWoui0hQET
	7g1CXeQF5Z/mlGDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728481745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mr/ufbEs3uqbhaatE1ESPsPdrQavlqICG1ghV71HRP0=;
	b=DUPAP0z0CKuQuUnTR9tOTyGDHbaawHHvI+Ew2yFqO7nGHdfChoN7gqbKHubN/9uNbQV0A3
	dFVqxP83VTcOarJzSEt4ebzugCtyLcjE+1jzeqXkBqwFbyUR5+s5SDg4RjdnLQQOYZt/rL
	dIh69UBxlEJf9FwvbVMXVJH2mvLZehY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728481745;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mr/ufbEs3uqbhaatE1ESPsPdrQavlqICG1ghV71HRP0=;
	b=zVmGkj5hCma8CTsDr/E1HRohmEyXAahAUcC2r/nf7X/osCgcF4tdpzLP2llbMwMyrineY+
	C1r5w9X/x2J03iAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A31A713A58;
	Wed,  9 Oct 2024 13:49:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id otWjJtGJBmcjNwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 09 Oct 2024 13:49:05 +0000
Date: Wed, 09 Oct 2024 15:50:00 +0200
Message-ID: <87h69ltmgn.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Vasiliy Kovalev <kovalev@altlinux.org>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bo liu <bo.liu@senarytech.com>
Subject: Re: [PATCH v2] ALSA: hda/conexant - Fix audio routing for HP EliteOne 1000 G2
In-Reply-To: <20241009134248.662175-1-kovalev@altlinux.org>
References: <20241009134248.662175-1-kovalev@altlinux.org>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[altlinux.org:email,imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 09 Oct 2024 15:42:48 +0200,
Vasiliy Kovalev wrote:
> 
> There is a problem with simultaneous audio output to headphones and
> speakers, and when headphones are turned off, the speakers also turn
> off and do not turn them on.
> 
> However, it was found that if you boot linux immediately after windows,
> there are no such problems. When comparing alsa-info, the only difference
> is the different configuration of Node 0x1d:
> 
> working conf. (windows): Pin-ctls: 0x80: HP
> not working     (linux): Pin-ctls: 0xc0: OUT HP
> 
> This patch disable the AC_PINCTL_OUT_EN bit of Node 0x1d and fixes the
> described problem.
> 
> Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>

Thanks, applied now.


Takashi

