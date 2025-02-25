Return-Path: <linux-kernel+bounces-531568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBADA44212
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67261179773
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B6626157A;
	Tue, 25 Feb 2025 14:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RPz1VEhl"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA04D2690C8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492591; cv=none; b=qzazFe4TCqaxCPc5V8CTidXnYs9ZyNQoRg3tBksI7YKIYpiJlnI7tBQ07jtdJT+0XyzaQBQ1mVQqcY1v8u0V1zMxe7LJ7pVxuoZR0VAAaEwUYk+lzuC0NXgmoUuiBu1xIksYCeD7LzQ60mYQYSmhQqSh7BHAK4xokCuN5L2Kqgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492591; c=relaxed/simple;
	bh=7qWa4AFgXv69ZV9Sn74YmFO5iaOOmc13a8YPu/JoznQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPKuBb5ocWxjmOOOHkbVHhnntD8aEK9fM2gW7NdvyKqv/U7MZr0SZKQmAlEV88g3R4B1OMdtez2RpJxObjnkWKBmSoKotBkxfz7mFe5R9tL3GZGVXbE71+evM8fCo0BynvZDFRylSY4dX1eN7ZTp/vj5LoYSR6z2p3wIlvxS3CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RPz1VEhl; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 54ACE432E9;
	Tue, 25 Feb 2025 14:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740492580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jboJZxaLiwbQZxHEn/1o4Rkr4gtd5yONqbc5i6dqnAI=;
	b=RPz1VEhlrjOesLe5sFyYR+XELdmz+YE9fkFCkHuMYEcVo4ufkeh6mZPrM06ulm/ODSgB74
	otwC7cvbjkDeR9MSiYOJIXzF0tgnwJPiAjJmiZV6dVymqp8wdwp2U7RcRvXGatcVuGH0DG
	NDZPZnPsUwVTdTTJDhpsX2fACpu1gBczFbxzjre/SFJV7dY/UetHu5FV2jsaDct9eLaxlZ
	7mJpUBjVuJa4Z+WD2cB6zvuz4M7jDRK6QFEeceErJEEYSHrcZzjKz1eGBzlKzTsTMwKtPB
	1BGUzb+/nhQBK1z+jLNDhvxgZE5bQxTy9HC2anQruTVqUWVbTDwj2Z4Yb57zWg==
Date: Tue, 25 Feb 2025 15:09:38 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org,
	jbaron@akamai.com, gregkh@linuxfoundation.org, ukaszb@chromium.org
Cc: intel-gfx-trybot@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com,
	ville.syrjala@linux.intel.com
Subject: Re: [PATCH 07/63] dyndbg: split param_set_dyndbg_classes to _module
 & wrapper fns
Message-ID: <b1db3b24-958e-4be8-b979-7c4954a3a678@bootlin.com>
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
 <20250125064619.8305-8-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250125064619.8305-8-jim.cromie@gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudeludcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefnohhuihhsucevhhgruhhvvghtuceolhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepudeiffduffeivdejgfejheeuudekkedvjeeuffegfefghfffkeelgffgieevudejnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohhuihhsqdgthhgruhhvvghtqdhlrghpthhophdpmhgrihhlfhhrohhmpehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedugedprhgtphhtthhopehjihhmrdgtrhhomhhivgesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjsggrrhhonhesrghkrghmrghirdgtohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnr
 dhorhhgpdhrtghpthhtohepuhhkrghsiigssegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehinhhtvghlqdhgfhigqdhtrhihsghotheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtoheprghmugdqghhfgieslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrgh
X-GND-Sasl: louis.chauvet@bootlin.com



Le 25/01/2025 à 07:45, Jim Cromie a écrit :
> Split api-fn: param_set_dyndbg_classes(), adding modname param and
> passing NULL in from api-fn.
> 
> The new arg allows caller to specify that only one module is affected
> by a prdbgs update.  This selectivity will be used later to narrow the
> scope of changes made.
> 
> no functional change.
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
>   lib/dynamic_debug.c | 37 ++++++++++++++++++++++---------------
>   1 file changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 8adb81e75a16..9adcb9fa7110 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -711,18 +711,9 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
>   	return 0;
>   }
>   
> -/**
> - * param_set_dyndbg_classes - class FOO >control
> - * @instr: string echo>d to sysfs, input depends on map_type
> - * @kp:    kp->arg has state: bits/lvl, map, map_type
> - *
> - * Enable/disable prdbgs by their class, as given in the arguments to
> - * DECLARE_DYNDBG_CLASSMAP.  For LEVEL map-types, enforce relative
> - * levels by bitpos.
> - *
> - * Returns: 0 or <0 if error.
> - */
> -int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
> +static int param_set_dyndbg_module_classes(const char *instr,
> +					   const struct kernel_param *kp,
> +					   const char *modnm)
>   {
>   	const struct ddebug_class_param *dcp = kp->arg;
>   	const struct ddebug_class_map *map = dcp->map;
> @@ -759,8 +750,8 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
>   				KP_NAME(kp), inrep, CLASSMAP_BITMASK(map->length));
>   			inrep &= CLASSMAP_BITMASK(map->length);
>   		}
> -		v2pr_info("bits:%lx > %s\n", inrep, KP_NAME(kp));
> -		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits, NULL);
> +		v2pr_info("bits:0x%lx > %s.%s\n", inrep, modnm ?: "*", KP_NAME(kp));
> +		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits, modnm);
>   		*dcp->bits = inrep;
>   		break;
>   	case DD_CLASS_TYPE_LEVEL_NUM:
> @@ -773,7 +764,7 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
>   		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
>   		new_bits = CLASSMAP_BITMASK(inrep);
>   		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
> -		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, NULL);
> +		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, modnm);
>   		*dcp->lvl = inrep;
>   		break;
>   	default:
> @@ -782,6 +773,22 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
>   	vpr_info("%s: total matches: %d\n", KP_NAME(kp), totct);
>   	return 0;
>   }
> +
> +/**
> + * param_set_dyndbg_classes - class FOO >control
> + * @instr: string echo>d to sysfs, input depends on map_type
> + * @kp:    kp->arg has state: bits/lvl, map, map_type
> + *
> + * Enable/disable prdbgs by their class, as given in the arguments to
> + * DECLARE_DYNDBG_CLASSMAP.  For LEVEL map-types, enforce relative
> + * levels by bitpos.
> + *
> + * Returns: 0 or <0 if error.
> + */
> +int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
> +{
> +	return param_set_dyndbg_module_classes(instr, kp, NULL);
> +}
>   EXPORT_SYMBOL(param_set_dyndbg_classes);
>   
>   /**

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


