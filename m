Return-Path: <linux-kernel+bounces-421975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5641D9D92CA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 08:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3818285986
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 07:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D883194C78;
	Tue, 26 Nov 2024 07:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oL9BDsRQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WBrV+50C";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oL9BDsRQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WBrV+50C"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB4817C208;
	Tue, 26 Nov 2024 07:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732607759; cv=none; b=XlhV7nYCv4XqHGjarGdEBMMdn9TqNDfWZrsOrC8mHtB6TErzRdH4dRKh5jxV/mxfVSOMm7wSzUtpjbExKAJfWhnaV1VbUt4b7/RWgP36ps8Dnq/sPtuy++OREwH3mvNIk/mq4xTxSA19wEiYkAH/4aiQOFymOQBMJP4tuZN3O2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732607759; c=relaxed/simple;
	bh=pCgORDrA+ZsMpaSR6+BYPqHZw8AuwuBYPuaU5j7g8MQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kV7pIuk4YbODEdtOjMMIk58pHLUQVxFG7sQA/bGUIvfwSYDS1J9gXrPDjZqnYFuZypH4apa8dXYheCCqoyD9Vi/wez4dZm78V3x5GUUZCVnyCitDePNOFCV/B+wuSlvAPZ+4csRLGSESGaaSG1aozZ/bOC9ZuC2iPpjt9msu2Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oL9BDsRQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WBrV+50C; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oL9BDsRQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WBrV+50C; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7AE102115C;
	Tue, 26 Nov 2024 07:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732607755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7dtF3+jSPP5KVlzpwrbNuBsU/vRIuH+ihMnUmxyEKIA=;
	b=oL9BDsRQ489MqEyj0sD5vTZh4JlBLFbkVevAPPixJ1nLgloro7lsR6Ic+QsGps36VaYC15
	vJbVERIPfPE6d5Q32Tw02dWWTIXYdnRwiQ1JDrNKyilip5OBwYzhWY+nR1QYDJGmMvOoTs
	kQF+0L1N/hyGwLPSWUSGp1etX7pIQcQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732607755;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7dtF3+jSPP5KVlzpwrbNuBsU/vRIuH+ihMnUmxyEKIA=;
	b=WBrV+50Cumiw4r4TCc/Qq4Nx3Il1rO+vR7yjEEqOTmv7QepxOVUPzBK0DgGINblxZm5E77
	vK8CvQi8AdmIQOAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732607755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7dtF3+jSPP5KVlzpwrbNuBsU/vRIuH+ihMnUmxyEKIA=;
	b=oL9BDsRQ489MqEyj0sD5vTZh4JlBLFbkVevAPPixJ1nLgloro7lsR6Ic+QsGps36VaYC15
	vJbVERIPfPE6d5Q32Tw02dWWTIXYdnRwiQ1JDrNKyilip5OBwYzhWY+nR1QYDJGmMvOoTs
	kQF+0L1N/hyGwLPSWUSGp1etX7pIQcQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732607755;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7dtF3+jSPP5KVlzpwrbNuBsU/vRIuH+ihMnUmxyEKIA=;
	b=WBrV+50Cumiw4r4TCc/Qq4Nx3Il1rO+vR7yjEEqOTmv7QepxOVUPzBK0DgGINblxZm5E77
	vK8CvQi8AdmIQOAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1DC2139AA;
	Tue, 26 Nov 2024 07:55:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GSpIOQp/RWcuaAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 26 Nov 2024 07:55:54 +0000
Date: Tue, 26 Nov 2024 08:55:54 +0100
Message-ID: <87v7wajunp.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Baojun Xu <baojun.xu@ti.com>
Cc: <tiwai@suse.de>,
	<robh+dt@kernel.org>,
	<andriy.shevchenko@linux.intel.com>,
	<lgirdwood@gmail.com>,
	<perex@perex.cz>,
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
Subject: Re: [PATCH v6] ALSA: hda/tas2781: Add speaker id check for ASUS projects
In-Reply-To: <20241123073718.475-1-baojun.xu@ti.com>
References: <20241123073718.475-1-baojun.xu@ti.com>
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
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[dt];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Score: -1.80
X-Spam-Flag: NO

On Sat, 23 Nov 2024 08:37:18 +0100,
Baojun Xu wrote:
> 
> Add speaker id check by gpio in ACPI for ASUS projects.
> In other vendors, speaker id was checked by BIOS, and was applied in
> last bit of subsys id, so we can load corresponding firmware binary file
> for its speaker by subsys id.
> But in ASUS project, the firmware binary name will be appended an extra
> number to tell the speakers from different vendors. And this single digit
> come from gpio level of speaker id in BIOS.
> 
> Signed-off-by: Baojun Xu <baojun.xu@ti.com>

I applied this now, as it's been cooked for long time and we don't
want miss 6.12 merge.   If any issue is found, let's fix on the top.


thanks,

Takashi

