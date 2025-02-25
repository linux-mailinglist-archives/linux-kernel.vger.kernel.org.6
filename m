Return-Path: <linux-kernel+bounces-531567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E01A4420A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A09E17897F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C3126B096;
	Tue, 25 Feb 2025 14:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OjThLzy5"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D879126981F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492552; cv=none; b=IsxiJymt9A+vL/28RBs5DeMJkcsf6vmSfj7KareCzpbroaU8Bsxo7E7mP3uR24M2OMoR6mLx/9Qe63bPdy7dKSRCim2hHhXtMuIYqv+drXbGkGLuZMNwYNhl2kXtbkaD/D+0io5ftrb3EmxVWFEJ9Eg50fZOryYUEMA1CpTC1dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492552; c=relaxed/simple;
	bh=5Ctxwht3/DxKJMKk2G5+AnJmp+vFAiwN+0BjLw5uiXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kD4Eep4rGHBAzSQC6Qd+ISN50H/TG9Z54bOJsz4tXDSetksFI3KuI7xngrVs1sXmQj/8TW+6ERdQqQzhW7m3jar8dSLStGPpDARMF+khBihCo1J26CTYg0pqQsJRjB8HwprOHBNCb9cmqchYi3Nbun/9IfsGc7JTSxSpGb3Yjt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OjThLzy5; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 97080442E6;
	Tue, 25 Feb 2025 14:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740492548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XR8tPEF4JOD9Mewu8g7MXiYm4y2vVcFBMc945e+Xaoc=;
	b=OjThLzy5VcjM3qOMCD67MOdey5Qx8Yae/mVFboetJAbwrXhmrzLBuU5OLz+eg6x1Wi2aO7
	P6kq0b9oTTdd0bIrdTCOFK9hVBFIfhHBPot6L5Vo0vOCwniqN3R1PUwwLap1hmsPd4lz4L
	13BZfdrtlBEX3NOgZuTym12yYnXdW+NnNr860GrqoV4+qPeXRLh01I9GAdZ7xh4w6xelZU
	lXvqz/16OymMcniPjqqv1HTZveXJvDRq8MiMm3vQQHpQXNp3uIdiLWlFgrXU3hDO+ZQUaP
	WEzJ6jYHMlzyRebRnedHsgrwjraw19rqhOWK1OZNI5isbkXPqkx+lgm2Os3GHg==
Date: Tue, 25 Feb 2025 15:09:06 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org,
	jbaron@akamai.com, gregkh@linuxfoundation.org, ukaszb@chromium.org
Cc: intel-gfx-trybot@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com,
	ville.syrjala@linux.intel.com
Subject: Re: [PATCH 06/63] dyndbg: ddebug_apply_class_bitmap - add module
 arg, select on it
Message-ID: <4ba7ad6f-c1dd-40e3-abcd-547635ff43da@bootlin.com>
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
 <20250125064619.8305-7-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250125064619.8305-7-jim.cromie@gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudeltdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefnohhuihhsucevhhgruhhvvghtuceolhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepudeiffduffeivdejgfejheeuudekkedvjeeuffegfefghfffkeelgffgieevudejnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohhuihhsqdgthhgruhhvvghtqdhlrghpthhophdpmhgrihhlfhhrohhmpehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedugedprhgtphhtthhopehjihhmrdgtrhhomhhivgesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjsggrrhhonhesrghkrghmrghirdgtohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnr
 dhorhhgpdhrtghpthhtohepuhhkrghsiigssegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehinhhtvghlqdhgfhigqdhtrhihsghotheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtoheprghmugdqghhfgieslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrgh
X-GND-Sasl: louis.chauvet@bootlin.com



Le 25/01/2025 à 07:45, Jim Cromie a écrit :
> Add param: query_module to ddebug_apply_class_bitmap(), and pass it
> thru to _ddebug_queries(), replacing NULL with query_module.  This
> allows its caller to update just one module, or all (as currently).
> 
> We'll use this later to propagate drm.debug to each USEr as they're
> modprobed.
> 
> No functional change.
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
> 
> after `modprobe i915`, heres the module dependencies,
> though not all on drm.debug.
> 
> bash-5.2# lsmod
> Module                  Size  Used by
> i915                 3133440  0
> drm_buddy              20480  1 i915
> ttm                    90112  1 i915
> i2c_algo_bit           16384  1 i915
> video                  61440  1 i915
> wmi                    32768  1 video
> drm_display_helper    200704  1 i915
> drm_kms_helper        208896  2 drm_display_helper,i915
> drm                   606208  5 drm_kms_helper,drm_display_helper,drm_buddy,i915,ttm
> cec                    57344  2 drm_display_helper,i915
> ---
>   lib/dynamic_debug.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 41cbaa96f83d..8adb81e75a16 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -605,7 +605,8 @@ static int ddebug_exec_queries(char *query, const char *modname)
>   
>   /* apply a new bitmap to the sys-knob's current bit-state */
>   static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
> -				     unsigned long *new_bits, unsigned long *old_bits)
> +				     unsigned long *new_bits, unsigned long *old_bits,
> +				     const char *query_modname)
>   {
>   #define QUERY_SIZE 128
>   	char query[QUERY_SIZE];
> @@ -613,7 +614,8 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
>   	int matches = 0;
>   	int bi, ct;
>   
> -	v2pr_info("apply: 0x%lx to: 0x%lx\n", *new_bits, *old_bits);
> +	v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits, *old_bits,
> +		  query_modname ?: "");
>   
>   	for (bi = 0; bi < map->length; bi++) {
>   		if (test_bit(bi, new_bits) == test_bit(bi, old_bits))
> @@ -622,12 +624,15 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
>   		snprintf(query, QUERY_SIZE, "class %s %c%s", map->class_names[bi],
>   			 test_bit(bi, new_bits) ? '+' : '-', dcp->flags);
>   
> -		ct = ddebug_exec_queries(query, NULL);
> +		ct = ddebug_exec_queries(query, query_modname);
>   		matches += ct;
>   
>   		v2pr_info("bit_%d: %d matches on class: %s -> 0x%lx\n", bi,
>   			  ct, map->class_names[bi], *new_bits);
>   	}
> +	v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits, *old_bits,
> +		  query_modname ?: "");
> +
>   	return matches;
>   }
>   
> @@ -682,7 +687,7 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
>   				continue;
>   			}
>   			curr_bits ^= BIT(cls_id);
> -			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, dcp->bits);
> +			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, dcp->bits, NULL);
>   			*dcp->bits = curr_bits;
>   			v2pr_info("%s: changed bit %d:%s\n", KP_NAME(kp), cls_id,
>   				  map->class_names[cls_id]);
> @@ -692,7 +697,7 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
>   			old_bits = CLASSMAP_BITMASK(*dcp->lvl);
>   			curr_bits = CLASSMAP_BITMASK(cls_id + (wanted ? 1 : 0 ));
>   
> -			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, &old_bits);
> +			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, &old_bits, NULL);
>   			*dcp->lvl = (cls_id + (wanted ? 1 : 0));
>   			v2pr_info("%s: changed bit-%d: \"%s\" %lx->%lx\n", KP_NAME(kp), cls_id,
>   				  map->class_names[cls_id], old_bits, curr_bits);
> @@ -755,7 +760,7 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
>   			inrep &= CLASSMAP_BITMASK(map->length);
>   		}
>   		v2pr_info("bits:%lx > %s\n", inrep, KP_NAME(kp));
> -		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits);
> +		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits, NULL);
>   		*dcp->bits = inrep;
>   		break;
>   	case DD_CLASS_TYPE_LEVEL_NUM:
> @@ -768,7 +773,7 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
>   		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
>   		new_bits = CLASSMAP_BITMASK(inrep);
>   		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
> -		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits);
> +		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, NULL);
>   		*dcp->lvl = inrep;
>   		break;
>   	default:

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


