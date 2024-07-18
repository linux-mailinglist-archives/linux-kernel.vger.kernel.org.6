Return-Path: <linux-kernel+bounces-256493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC8F934F46
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 16:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88597283EBC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364681422BC;
	Thu, 18 Jul 2024 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UKlKyYdU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hY0dVqsb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="px51OBcg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9R066FqY"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41EA12C7FB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 14:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721313801; cv=none; b=eo/m6qz9uu781QWe2Syp975y0GhcQE2pDKOzbwbXDBW/6Z5IydRMu4AFYlXwPlsKIomnBpUsVi62cBXk12nR/5ztGGded8o2Z5hWZeme+rwEfqiOtylnReT3W+LXwb6pDbv9zuH+VouUW0PWM3z4WiCWfsXR0LlmxTxL7enkX8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721313801; c=relaxed/simple;
	bh=KEzro45JPQUxyEbETooDeOw9wctjrPSE1URuVYN7hhQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=STsJB4n+4Bvw/1237kJZuWY/TsCrFqVW9EMw6NX+9rB1z17c5uOfQsojndP6QvtenI/UCzNOQRlSlvHv7ZaNjr7XA7f2COOkpA8kejACJo5mTEqPjRa7aB2PJJt5I3bg39Mkz+6k2EHRJz7Ksu8EhFspw4wEKIAt6CNJwxcIa38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UKlKyYdU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hY0dVqsb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=px51OBcg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9R066FqY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D58B61FBF0;
	Thu, 18 Jul 2024 14:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721313798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uQVxlYZDNnpoZuZqFLdbgZdvvnZ80n+SMjdtam38h0Q=;
	b=UKlKyYdU3JqAOj/r7NR7HEZlmdhEyn4WngzbiknP4LJNhefGNPyn5a+NmrkNcLq2sy8Zhf
	qn60Q/jOMju8fHosubPsM2p0OyzgdmSVYezXMzVet6F0PXtxAfr4UmzBY4LB3uz3dSfJJa
	0Y7jXSZSACnkXZpbVDy8C86MuRc11/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721313798;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uQVxlYZDNnpoZuZqFLdbgZdvvnZ80n+SMjdtam38h0Q=;
	b=hY0dVqsbCMV7L9IROgrzgDgI91WomrOsm1lbGnAGJxC2sF/e23ukKF9/mZ67PQEl4Lms9C
	zvSr08it7vZ3g+AA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=px51OBcg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9R066FqY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721313797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uQVxlYZDNnpoZuZqFLdbgZdvvnZ80n+SMjdtam38h0Q=;
	b=px51OBcgIDAy0oqYocKXLMfHo55QE5PGwYsn4Kmf+4er29z7hxL4deoa2hdXkODRdN26jF
	gMnQzgjUFtE/CiLXbSOlttIr77xAnq1M94zCnG6/gKowcXNOlp5MX2shvAbYBsQ026ILIa
	hg7v1//JUHcCt0ZlEli3Wr7flc1Ep+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721313797;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uQVxlYZDNnpoZuZqFLdbgZdvvnZ80n+SMjdtam38h0Q=;
	b=9R066FqY6sGGMzsfSo/SH/4QSLZETDEiUn/xJ+2PQriCs2YIYlcrz8JAOO1MhHU4icyegp
	0bI8VyP5YmjwZNAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5506D136F7;
	Thu, 18 Jul 2024 14:43:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YQYKEwUqmWaLHgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 18 Jul 2024 14:43:17 +0000
Date: Thu, 18 Jul 2024 16:43:50 +0200
Message-ID: <87o76uvjyx.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: <broonie@kernel.org>,
	<andriy.shevchenko@linux.intel.com>,
	<lgirdwood@gmail.com>,
	<perex@perex.cz>,
	<pierre-louis.bossart@linux.intel.com>,
	<13564923607@139.com>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<liam.r.girdwood@intel.com>,
	<bard.liao@intel.com>,
	<yung-chuan.liao@linux.intel.com>,
	<cameron.berkenpas@gmail.com>,
	<baojun.xu@ti.com>,
	<soyer@irl.hu>,
	<Baojun.Xu@fpt.com>
Subject: Re: [PATCH v1] ALSA: hda/tas2781: Add new quirk for Lenovo Hera2 Laptop
In-Reply-To: <20240717115305.723-1-shenghao-ding@ti.com>
References: <20240717115305.723-1-shenghao-ding@ti.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: D58B61FBF0
X-Spam-Flag: NO
X-Spam-Score: 1.99
X-Spam-Level: *
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.99 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[139.com,gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,gmail.com,perex.cz,139.com,alsa-project.org,vger.kernel.org,intel.com,ti.com,irl.hu,fpt.com];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Rspamd-Action: no action
X-Spamd-Bar: +

On Wed, 17 Jul 2024 13:53:04 +0200,
Shenghao Ding wrote:
> 
> Add new vendor_id and subsystem_id in quirk for Lenovo Hera2 Laptop.
> 
> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

Thanks, applied.


Takashi

