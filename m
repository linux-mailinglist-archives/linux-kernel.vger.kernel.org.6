Return-Path: <linux-kernel+bounces-307309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ACD964B95
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A712282884
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5E11B4C49;
	Thu, 29 Aug 2024 16:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BdotlAeI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Tegg2S6s";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WhyHXXT4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X08BLpck"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DEF38F9C;
	Thu, 29 Aug 2024 16:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948575; cv=none; b=TRV2V6HxmJ3zVi0zw6jxkj7EGZA6/UIR+Po+l56MloQlyIVS3ZA5CZV66WfXWmXy+w8s/1XjyyFrzL8AY+3IgGW+0kRGVrxwrkBCwLL3MwlCNOSIgy/HBCcMGOyWnHXga4fqrQyGy2Th8pscoSFwNkLYpiByFBch74RvC9IF0C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948575; c=relaxed/simple;
	bh=xCJMHOX25QOgtyzPIKPwJ4McoZCcuj2+xMof2qIuWgU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PbbPSI6koq92yS36vV8TufGEhfmAd8MEri25MD+nBAs9t34o7zTCKjAKHvEHcOaBRSyVmhNJyBhPJApznusw1oGgTl1hatLOfWd7T3fVYq6uX1DzjYfGf+2nL1ZCfi5kp790r76hB8GeB0qCN4TR1N3cGnm43TDDkRs0PEGOOZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BdotlAeI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Tegg2S6s; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WhyHXXT4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X08BLpck; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DA8C11F449;
	Thu, 29 Aug 2024 16:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724948572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lqxE3wVAnc67PfYzr6H1KIHv1Iy/FY0+ZzpQO2C1mxI=;
	b=BdotlAeI0VSdcxvGLRC7bygesEtHqHnR6XWaqk5mHPusCdqYwSaOp2jVXUv2m86de9Rpoj
	sEQvqufbCYGhZe6gXPojVz9JR3Xl0HUkM8A5rmo6llYuXrO/ea8xSPr4Dp8Uo/4cSlvwgm
	deO0GTfuDHxcX8oEZn2Yv1Oufyo6X1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724948572;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lqxE3wVAnc67PfYzr6H1KIHv1Iy/FY0+ZzpQO2C1mxI=;
	b=Tegg2S6s91p1Ak43LJHtRTZuJlc0H03bdO+XGa3KShtg4wItYLorPL9yVkCVIsdCnRhKdB
	7DpmAJsS6gRV21BA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WhyHXXT4;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=X08BLpck
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724948571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lqxE3wVAnc67PfYzr6H1KIHv1Iy/FY0+ZzpQO2C1mxI=;
	b=WhyHXXT47Nmzdddu3hmBPFwDW3NyK5FrysR+qeabrhhpU1CLD7kBR/2zBSVly+O9CC/DAK
	O/IYBayw34IuMbgrZZZxQiaWEmjsAReP3bvxNQY2oqUeKFrYg9WNzc2LMYODCHRuZti/VH
	8rtPDi4UkwRxXM3FQWUl8m+BzKY7mu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724948571;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lqxE3wVAnc67PfYzr6H1KIHv1Iy/FY0+ZzpQO2C1mxI=;
	b=X08BLpckludQQ+MOsb/Rt+EkPS09ZuJFKIb/TWSsQPxWABMFAnB6YTUVOlp9YiqiGbwqAq
	ff1kcSFma9pKQ4Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC5AC13408;
	Thu, 29 Aug 2024 16:22:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0RzXKFug0GZUeQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 29 Aug 2024 16:22:51 +0000
Date: Thu, 29 Aug 2024 18:23:36 +0200
Message-ID: <87wmjzl2lz.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Simon Trimmer <simont@opensource.cirrus.com>
Cc: <tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH] ALSA: hda/realtek: Autodetect Cirrus Logic companion amplifier bindings
In-Reply-To: <20240829161114.140938-1-simont@opensource.cirrus.com>
References: <20240829161114.140938-1-simont@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: DA8C11F449
X-Spam-Score: -5.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cirrus.com:email,suse.de:mid,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 29 Aug 2024 18:11:14 +0200,
Simon Trimmer wrote:
> 
> We do not need model specific HDA quirks to construct the component
> binding details of Cirrus Logic companion amplifiers as this information
> is already present in the ACPI.
> 
> Quirks are then only required for special workarounds not described in
> the ACPI such as internal configuration of the Realtek codecs.
> 
> The codec pointer is now initialized in hda_component_manager_init() so
> that we can detect when companion amplifiers are found in the ACPI but
> the SSID invokes a quirk that also attempts to create the component
> binding.
> 
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
> ---
> v1 - This patch applies to for-next with this additional patch:
>      b1faff28a2bd ("ALSA: hda: hda_component: Fix mutex crash if nothing ever binds")
>      which is currently only in the for-linus.

OK, I now merged for-linus to for-next, and applied yours.

>      We're looking to do the same for the CS35L41 devices, but that will
>      come later because there are many more quirks to work through.

That's understandable.  Thanks!


Takashi

