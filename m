Return-Path: <linux-kernel+bounces-514519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1ABA35807
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3F1C3AB94C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7878021517C;
	Fri, 14 Feb 2025 07:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zWJLrTfd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sicEhh96";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zWJLrTfd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sicEhh96"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365D3215058;
	Fri, 14 Feb 2025 07:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739518848; cv=none; b=SGacS6DfHsLvwBxReayJKouTn+F9QGH2Ws5MmD7DIhNYvu/ra9corgE+DX1ZVOI4nGXLy5jiIFzBVq63ibhIGxBBJwixz5TTVgKbW5oYXVCivVD+VIhHjGGBdDPp//6q8mJl0XBW1UKWB6pCrAXjPZV8teoiaB7qe3VeHLjelQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739518848; c=relaxed/simple;
	bh=Fscm2DnKxcZ7JkSZocJpCyabSuzUogGQBUqYh36yXUk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S2d7HNMTKn4VGv5TB+5cqruoQ+E4IpOOuLQqxFAoDpvx0F3hwq8mloDCmpCOhI6cTab7A+RQ8vqyVXl79Mfb3uA5hztL6vzQbaUhc/F/ieAai0av+QYy2ODZOfZtRi6P6mlNZHSjyZeDD+srsiNMDRLY8LW3hiJ2h4X+FkBIPAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zWJLrTfd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sicEhh96; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zWJLrTfd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sicEhh96; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3A8811F78F;
	Fri, 14 Feb 2025 07:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739518845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=88Y1nS1A2QfT5gFlu1HZuxZ/b065jAtb+T0yyIARB2w=;
	b=zWJLrTfd+vzuPXLGY9aWH8DZBJv1NmZ+Ik9Y44ogzsqG3JNw7nkVwOodYt7o4AL8JpsIOx
	SzBYZgaB+ktBne7GFmS7dMQYw78R2r99ZIT4r9OOWha2vxuC/jeDmQOur0pRqUSekHCVuj
	i7NWSqqXu3Oxb7VO1nmgFqfmjES2EHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739518845;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=88Y1nS1A2QfT5gFlu1HZuxZ/b065jAtb+T0yyIARB2w=;
	b=sicEhh96KfU2TvYGFoDX9Fyqq6X3R+usoecj/dtpK8kuMbixkG+hj8mjpr+aE5H2pM07WH
	UIoXfptXnE9G9kCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739518845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=88Y1nS1A2QfT5gFlu1HZuxZ/b065jAtb+T0yyIARB2w=;
	b=zWJLrTfd+vzuPXLGY9aWH8DZBJv1NmZ+Ik9Y44ogzsqG3JNw7nkVwOodYt7o4AL8JpsIOx
	SzBYZgaB+ktBne7GFmS7dMQYw78R2r99ZIT4r9OOWha2vxuC/jeDmQOur0pRqUSekHCVuj
	i7NWSqqXu3Oxb7VO1nmgFqfmjES2EHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739518845;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=88Y1nS1A2QfT5gFlu1HZuxZ/b065jAtb+T0yyIARB2w=;
	b=sicEhh96KfU2TvYGFoDX9Fyqq6X3R+usoecj/dtpK8kuMbixkG+hj8mjpr+aE5H2pM07WH
	UIoXfptXnE9G9kCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09EA313285;
	Fri, 14 Feb 2025 07:40:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TgCfOnvzrmdCFgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 14 Feb 2025 07:40:43 +0000
Date: Fri, 14 Feb 2025 08:40:43 +0100
Message-ID: <87h64x2cuc.wl-tiwai@suse.de>
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
	<stuart.a.hayhurst@gmail.com>,
	<dan.carpenter@linaro.org>
Subject: Re: [PATCH v1] ALSA: hda/tas2781: Fix index issue in tas2781 hda SPI driver
In-Reply-To: <20250214013021.6072-1-baojun.xu@ti.com>
References: <20250214013021.6072-1-baojun.xu@ti.com>
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
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	FREEMAIL_CC(0.00)[suse.de,kernel.org,linux.intel.com,gmail.com,perex.cz,ti.com,139.com,vger.kernel.org,intel.com,linaro.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 14 Feb 2025 02:30:21 +0100,
Baojun Xu wrote:
> 
> Correct wrong mask for device index.
> 
> Signed-off-by: Baojun Xu <baojun.xu@ti.com>

Applied now with Fixes tag to commit bb5f86ea50ff ("ALSA: hda/tas2781:
Add tas2781 hda SPI driver").

Please put the proper Fix tag at the next time.


thanks,

Takashi

