Return-Path: <linux-kernel+bounces-531572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1B2A4421C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62EFE422EEA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778C8269AE6;
	Tue, 25 Feb 2025 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EsmCl6f0"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC72268692
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492650; cv=none; b=LzyCang/Vw+LahKS5Yje6OL77en663G6B7UCki1tBsAK2HeMOSwdvcM06t0raHvArkz5na/in80mRZYzZ8NVeWuP+tGCuptFVmQ1XID6NwwHxR6VXF4nNADq274E/fINxInAfLQGERdlyMEFF3bNKejkFxy3B5tkZRwbT3oLILQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492650; c=relaxed/simple;
	bh=xP4xQ5oaCLcXsmpSKMBvRzGERqrdlvdNonhusO9jIAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TV4TOLlg0H1hnMSKrQJqPEzHzRLvIlLyGNWrzr/1Rtcq3qZQktiNCR34mtSQLQ/65YGYpEa96/MOXQczg8KKuUwO0cdjyvT9wtKynodEAvPGi0XXsjnMSbkOteSvQCL2/d5ZAgrXug/qFgI9J/Q0+UjhJC60sEonW2Y3Xg8znjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EsmCl6f0; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4B422442ED;
	Tue, 25 Feb 2025 14:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740492647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VSziKazrLQBPC9Hdv4UIzzMr4t3jz3ERJ3wqC34N1TE=;
	b=EsmCl6f0l6xPYu5owmf2u8KWxNkunWYVtQx1OrwBl8xy6o7hdJowsrZVo5l5LEEjZIHoLE
	w26CoBbEJixvm98R2xjryCUDWAAbN3seBMmJxKIQ+BtYOS/8NAkguXIbtSTzc5F4oOhxYo
	Uo+KzayX66uCFTblz/5iFzFzMxZBa1Gb1tLH0/KkrhOdgubZJ1emd/7fUnWItNpDiZtSCx
	Acer8d5Zs5NAwrCorwrcpmGWrZxUMm0l8gPac6m2t7DFN2LcQq/F9H3DhEMbJi+rihNpgy
	VEG1K8AYmx/AKLXSQy66ugTlgdImKBVXtSvxRiGhLVajSZAUR+wlX4JOEk1X1A==
Date: Tue, 25 Feb 2025 15:10:44 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org,
	jbaron@akamai.com, gregkh@linuxfoundation.org, ukaszb@chromium.org
Cc: intel-gfx-trybot@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com,
	ville.syrjala@linux.intel.com
Subject: Re: [PATCH 10/63] dyndbg: silence debugs with no-change updates
Message-ID: <6277e777-18b5-46c0-9f13-ab6b1c61faf9@bootlin.com>
Mail-Followup-To: Jim Cromie <jim.cromie@gmail.com>,
	linux-kernel@vger.kernel.org, jbaron@akamai.com,
	gregkh@linuxfoundation.org, ukaszb@chromium.org,
	intel-gfx-trybot@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com,
	ville.syrjala@linux.intel.com
References: <20250125064619.8305-1-jim.cromie@gmail.com>
 <20250125064619.8305-11-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250125064619.8305-11-jim.cromie@gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudeludcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefnohhuihhsucevhhgruhhvvghtuceolhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepudeiffduffeivdejgfejheeuudekkedvjeeuffegfefghfffkeelgffgieevudejnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohhuihhsqdgthhgruhhvvghtqdhlrghpthhophdpmhgrihhlfhhrohhmpehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedugedprhgtphhtthhopehjihhmrdgtrhhomhhivgesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjsggrrhhonhesrghkrghmrghirdgtohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnr
 dhorhhgpdhrtghpthhtohepuhhkrghsiigssegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehinhhtvghlqdhgfhigqdhtrhihsghotheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtoheprghmugdqghhfgieslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrgh
X-GND-Sasl: louis.chauvet@bootlin.com



Le 25/01/2025 à 07:45, Jim Cromie a écrit :
> In ddebug_apply_class_bitmap(), check for actual changes to the bits
> before announcing them, to declutter logs.
> 
> no functional change.
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
>   lib/dynamic_debug.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 1b2fb6502e61..c27965180a49 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -595,7 +595,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
>   	return nfound;
>   }
>   
> -/* apply a new bitmap to the sys-knob's current bit-state */
> +/* apply a new class-param setting */
>   static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
>   				     unsigned long *new_bits, unsigned long *old_bits,
>   				     const char *query_modname)
> @@ -606,8 +606,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
>   	int matches = 0;
>   	int bi, ct;
>   
> -	v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits, *old_bits,
> -		  query_modname ?: "");
> +	if (*new_bits != *old_bits)
> +		v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
> +			  *old_bits, query_modname ?: "'*'");
>   
>   	for (bi = 0; bi < map->length; bi++) {
>   		if (test_bit(bi, new_bits) == test_bit(bi, old_bits))
> @@ -622,8 +623,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
>   		v2pr_info("bit_%d: %d matches on class: %s -> 0x%lx\n", bi,
>   			  ct, map->class_names[bi], *new_bits);
>   	}
> -	v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits, *old_bits,
> -		  query_modname ?: "");
> +	if (*new_bits != *old_bits)
> +		v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
> +			  *old_bits, query_modname ?: "'*'");
>   
>   	return matches;
>   }

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


