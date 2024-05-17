Return-Path: <linux-kernel+bounces-181943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 530578C83D3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 11:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76A1E1C22B08
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 09:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AC22260B;
	Fri, 17 May 2024 09:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HpS+DvDw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="i0Dq/yNX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2Dk2NLHk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ynBkPNpE"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF55317BBB
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 09:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715938592; cv=none; b=AhAAhkIpwmBXto7w+dPf4Z+ZDcOqlVuyA/ans+bStRmtmBVJVug9ILsvfU9QSGrHqycjogQKSwcJIZbGOugPxIqE1HVApXwG48T9roi6D65L9oWKZGDyvDtan6hJjpV8ZKVAyVOkrA07MX2koh5NLMjy3p97DJxAmMi14UOgyVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715938592; c=relaxed/simple;
	bh=uY3bUq+e3lxa4vHrJlyjRfMSTQosZevDA/L1XSfHsLM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F8hN6RYLq1NxQ4Oj4p8VUBAoPxFs111qFCd1pKoey6sIeumIx57PJz00QnwQRvECOklV356GtwYJiDr/KGIZqUcYYB3j0w/hqvHQUMgcNKW34/9eZqGzTadB4b9F6yEnKIeUUT4NqR88PeRIFv8teX/jUyqAogCSmaD2DhvuFuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HpS+DvDw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=i0Dq/yNX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2Dk2NLHk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ynBkPNpE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D98005D1E7;
	Fri, 17 May 2024 09:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715938588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UPzBXPSRlnHCmqCWOcUK/HIW7wwc5Ae979hc1NuTveU=;
	b=HpS+DvDwLJydjr2Dk6+btSO9Gl2VnqSFPCMD00uKbDoNsRVYJTip4MU3dewE5TobuCKqL+
	dsm7Bn/tulAZ/gOETw0hc69BLr+Hsx3bpwikvgVWTBn/AZ5DXpXCqq02Mm5a61zuHCKQje
	ROcdtJh0WwRJ6lFJ0MtpiPP3tX3rf4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715938588;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UPzBXPSRlnHCmqCWOcUK/HIW7wwc5Ae979hc1NuTveU=;
	b=i0Dq/yNXDMjnTCnsEBdTCIK4MpvK7YJQjar2FYDV7f+5OGAb0y7PFEoEZl0XOw4iOMYOQd
	1O5w+nstIC8MPQBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715938587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UPzBXPSRlnHCmqCWOcUK/HIW7wwc5Ae979hc1NuTveU=;
	b=2Dk2NLHkjjlt6sDLEzCbd+uuXNGULV6QS8hIeJfTrzxUnisqN++eOcq9dH/nVmfzPZ6AOA
	2a+vaS6sXYE6y99UB59Hl+oeQdec9BI5N6IA5B37eApL7a5dr0geuFkuuXyopilMmqa6EK
	m5WdL09RdB/GD6heeb2TOsG0cYUoH2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715938587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UPzBXPSRlnHCmqCWOcUK/HIW7wwc5Ae979hc1NuTveU=;
	b=ynBkPNpEfsmD4/SSns6GXbYHKwuK2tMuIycCDYTh97oaH6Wq2RIZf9sqqs0/BGZS2l3qY3
	jG3il5+AdcmsETCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7352E13991;
	Fri, 17 May 2024 09:36:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qJj2GhslR2Z/fwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 17 May 2024 09:36:27 +0000
Date: Fri, 17 May 2024 11:36:44 +0200
Message-ID: <87seygzsnn.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: <broonie@kernel.org>,
	<andriy.shevchenko@linux.intel.com>,
	<lgirdwood@gmail.com>,
	<perex@perex.cz>,
	<pierre-louis.bossart@linux.intel.com>,
	<13916275206@139.com>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<liam.r.girdwood@intel.com>,
	<bard.liao@intel.com>,
	<yung-chuan.liao@linux.intel.com>,
	<kevin-lu@ti.com>,
	<cameron.berkenpas@gmail.com>,
	<baojun.xu@ti.com>,
	<soyer@irl.hu>,
	<Baojun.Xu@fpt.com>
Subject: Re: [RESEND PATCH v5 1/3] ASoC: tas2781: Fix wrong loading calibrated data sequence
In-Reply-To: <20240517092039.688-1-shenghao-ding@ti.com>
References: <20240517092039.688-1-shenghao-ding@ti.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[139.com,gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,gmail.com,perex.cz,139.com,alsa-project.org,vger.kernel.org,intel.com,ti.com,irl.hu,fpt.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -1.80
X-Spam-Flag: NO

On Fri, 17 May 2024 11:20:36 +0200,
Shenghao Ding wrote:
> 
> Remove declaration of unused API which load calibrated data in wrong
> sequence, changed the copyright year and correct file name in license
> header.
> 
> Fixes: ef3bcde75d06 ("ASoc: tas2781: Add tas2781 driver")
> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

First off, this breaks the build.  You are removing the function that
is still called.  You will remove the caller in a later patch, but
it's still there at this point.  That's what Andy suggested for the
whole time.

Try to apply only this patch and build module.  You'll get a compile
error.  This must be avoided.

Second, it makes little sense to split the patches in that way.
A copyright year change can be folded into the same patch.  If any, a
patch to correct the ifdef as a separate patch, as it's completely
irrelevant with the fix itself.


thanks,

Takashi

