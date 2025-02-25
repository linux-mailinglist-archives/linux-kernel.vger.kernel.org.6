Return-Path: <linux-kernel+bounces-531206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31ADAA43D79
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B52AF7AD6F3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6451D26770C;
	Tue, 25 Feb 2025 11:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l4JC/HF2"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC7A266B5E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740482673; cv=none; b=lOvgCz7HibFrsAGGoAz9Arknrwlxwcd1ANBDNqshsodfsyh6w3ctuFtXxRITobD/8XZU6nyUQreXaiaJJua/sMY5rOXMfbEaR72WD6kAeFKi4Qc9XRKS74gX/OQjd4sM1OoZa8W9zl9lce0YbWoBsOEH9HuiWycO0tV+OJEawdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740482673; c=relaxed/simple;
	bh=5SXlyjh6mu8zy1D5TpwY55hiUfHfxqm+OoXcD9n5vUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbFQ9OBP/FvK4EVzWmnAWJELIKvZScuAHRW8/FsYJ1Xhs1LAZpSOHslWxeEojB1Hsqaz7QwEFRgc0QMtqtJ8ybxvRpRHFoH0kr5ASHwfnWonvy95jPEH2kjiCuRNPZLaC25CQ4ntthDu7QdQFvM7GNW04FW1mw6r3xx98g69ijo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l4JC/HF2; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6232D41C15;
	Tue, 25 Feb 2025 11:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740482664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LAaEkGU3fY2hgCB19IgOdEZAdlwzGVDHNxR4949T30k=;
	b=l4JC/HF2kohEwyFKMeN0QY1rZVHWtHBoPl/7Hc82WrMN7rLfi3NdauPjwV07JakgUwKA8q
	k1WTVnl/BGeEoVHG8ESiXrvBBy7cqZuysoqMkaVmnoCZ3QDv/sI8SKM2hMIbI6+OaIpNOM
	BtQnnpNBCjlx+qdtH2sBY6BXVW3rJEUDDNu6x95X4vncHFOGjznoO9n1/U1TN5MMMrOn9H
	lddXnMHkQ5URJ+sfi9SUIwM9MDnVOLtKJnSv3fo1SM/Agirte8Pk5mGs89RJg8IkB4i2Fj
	fbDCAi4kWbtmJuwfIIgKAjcGooxDRtlToGYsyWJyYHio4uZ/zxnxyBrQWgrrOw==
Date: Tue, 25 Feb 2025 12:24:21 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org,
	jbaron@akamai.com, gregkh@linuxfoundation.org, ukaszb@chromium.org
Cc: intel-gfx-trybot@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com,
	ville.syrjala@linux.intel.com
Subject: Re: [PATCH 04/63] dyndbg: make ddebug_class_param union members same
 size
Message-ID: <791c0b1d-6fc2-43b4-b0fe-484eeef613d8@bootlin.com>
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
 <20250125064619.8305-5-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250125064619.8305-5-jim.cromie@gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudehjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefnohhuihhsucevhhgruhhvvghtuceolhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepudeiffduffeivdejgfejheeuudekkedvjeeuffegfefghfffkeelgffgieevudejnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohhuihhsqdgthhgruhhvvghtqdhlrghpthhophdpmhgrihhlfhhrohhmpehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedugedprhgtphhtthhopehjihhmrdgtrhhomhhivgesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjsggrrhhonhesrghkrghmrghirdgtohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnr
 dhorhhgpdhrtghpthhtohepuhhkrghsiigssegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehinhhtvghlqdhgfhigqdhtrhihsghotheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtoheprghmugdqghhfgieslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrgh
X-GND-Sasl: louis.chauvet@bootlin.com



Le 25/01/2025 à 07:45, Jim Cromie a écrit :
> struct ddebug_class_param keeps a ref to the state-storage of the
> param; make both class-types use the same unsigned long storage type.
> 
> ISTM this is simpler and safer; it avoids an irrelevant difference,
> and if 2 users somehow get class-type mixed up (or refer to the wrong
> union member), at least they will both see the same value.
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
>   include/linux/dynamic_debug.h | 2 +-
>   lib/dynamic_debug.c           | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index ff44ec346162..b9afc7731b7c 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
> @@ -124,7 +124,7 @@ struct _ddebug_info {
>   struct ddebug_class_param {
>   	union {
>   		unsigned long *bits;
> -		unsigned int *lvl;
> +		unsigned long *lvl;
>   	};
>   	char flags[8];
>   	const struct ddebug_class_map *map;
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 147540c57154..55df35df093b 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -799,7 +799,7 @@ int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)
>   
>   	case DD_CLASS_TYPE_LEVEL_NAMES:
>   	case DD_CLASS_TYPE_LEVEL_NUM:
> -		return scnprintf(buffer, PAGE_SIZE, "%d\n", *dcp->lvl);
> +		return scnprintf(buffer, PAGE_SIZE, "%ld\n", *dcp->lvl);
>   	default:
>   		return -1;
>   	}

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


