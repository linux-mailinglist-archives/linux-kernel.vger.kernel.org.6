Return-Path: <linux-kernel+bounces-407626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C30F9C7092
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08A6FB342F7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298C62003CA;
	Wed, 13 Nov 2024 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KSlpAplf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A0e9OSN0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KSlpAplf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A0e9OSN0"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22A41FF7A4;
	Wed, 13 Nov 2024 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731502915; cv=none; b=MqgJ+GvZcc4DeZCn/mnLAKX+PPvkkV0MrNLf8ekLBtuWM+SVtTYjSAOMhy3INZ8l60dH3fJx5NStL//zhJUCM2birWWfI6f+u9/BDWqo99pvVF74a7G4O07llmxLKREVNYxExSguPS+h70R9u6OU8MV3kY6zuuRmUX57eQlIEDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731502915; c=relaxed/simple;
	bh=3VJRKIp3k/Z4TZILX+K/BWjibOQxiArBiomXGhXoJpk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YznIciaYmB7PYtk8x7yODR9Es1gO3BiO7vck5HOxSi+kh/mI/2fJ654Jxc1xSS9PD5SN1mroK74mC5n97p4/LS0pJ2jiRwW7pk9UW6VYd/ykfIlLKTKC1flOcOIrZTLQu4r1FggybF9nCNB67R9e0tYDobOG56CS2NMCIbUTjfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KSlpAplf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A0e9OSN0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KSlpAplf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A0e9OSN0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 38DB71F451;
	Wed, 13 Nov 2024 13:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731502912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PXRL3ztGgJPYKsQQcCrLymb7R+lmhko1t0Gc0UKCor0=;
	b=KSlpAplf4rDyggxBkWjgL13u5cJN+7pSPs9n7ft/L6Kbk1ft35kFlOrM6sh8yJ2sPxf2P3
	KxcpgToUjXHsAyTEB1+ygoHmrn4nMKjwlnimyxCESDiHNDMigg8PwHx+eBiSyxEJTnx4wL
	3jDO5prr3XYRfyuSjYle1gBNE9GFBfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731502912;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PXRL3ztGgJPYKsQQcCrLymb7R+lmhko1t0Gc0UKCor0=;
	b=A0e9OSN0IwBPQpdVww0hXWDmEzeLx9N70HfnTGJVxvSowSu7YYEguggt5VFX3+vs9TMnJN
	ADMDR7QEoxigp9BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731502912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PXRL3ztGgJPYKsQQcCrLymb7R+lmhko1t0Gc0UKCor0=;
	b=KSlpAplf4rDyggxBkWjgL13u5cJN+7pSPs9n7ft/L6Kbk1ft35kFlOrM6sh8yJ2sPxf2P3
	KxcpgToUjXHsAyTEB1+ygoHmrn4nMKjwlnimyxCESDiHNDMigg8PwHx+eBiSyxEJTnx4wL
	3jDO5prr3XYRfyuSjYle1gBNE9GFBfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731502912;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PXRL3ztGgJPYKsQQcCrLymb7R+lmhko1t0Gc0UKCor0=;
	b=A0e9OSN0IwBPQpdVww0hXWDmEzeLx9N70HfnTGJVxvSowSu7YYEguggt5VFX3+vs9TMnJN
	ADMDR7QEoxigp9BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A874613301;
	Wed, 13 Nov 2024 13:01:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LwDfJz+jNGdJPgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 13 Nov 2024 13:01:51 +0000
Date: Wed, 13 Nov 2024 14:01:51 +0100
Message-ID: <87ldxnuw1s.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Baojun Xu <baojun.xu@ti.com>
Cc: <tiwai@suse.de>,
	<robh+dt@kernel.org>,
	<andriy.shevchenko@linux.intel.com>,
	<lgirdwood@gmail.com>,
	<perex@perex.cz>,
	<pierre-louis.bossart@linux.intel.com>,
	<shenghao-ding@ti.com>,
	<navada@ti.com>,
	<13916275206@139.com>,
	<v-hampiholi@ti.com>,
	<v-po@ti.com>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<liam.r.girdwood@intel.com>,
	<yung-chuan.liao@linux.intel.com>,
	<broonie@kernel.org>,
	<antheas.dk@gmail.com>,
	<philm@manjaro.org>
Subject: Re: [PATCH v4] ALSA: hda/tas2781: Add speaker id check for ASUS projects
In-Reply-To: <20241104093138.4819-1-baojun.xu@ti.com>
References: <20241104093138.4819-1-baojun.xu@ti.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -1.80
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[dt];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[139.com,gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,kernel.org,linux.intel.com,gmail.com,perex.cz,ti.com,139.com,vger.kernel.org,intel.com,manjaro.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 04 Nov 2024 10:31:38 +0100,
Baojun Xu wrote:
> +	// Speaker id was needed for ASUS projects.
> +	if (!strncmp(sub, TAS2781_ASUS_ID, sizeof(TAS2781_ASUS_ID))) {

Is this really correct?  The sizeof(TAS2781_ASUS_ID) is 5, including
the terminating NUL.  So this becomes equivalent with strcmp(), and
it doesn't check the sub-string.


thanks,

Takashi

