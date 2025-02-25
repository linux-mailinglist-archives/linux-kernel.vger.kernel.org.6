Return-Path: <linux-kernel+bounces-531596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5565AA44288
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6E5D19C4595
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D94A26B0B6;
	Tue, 25 Feb 2025 14:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KCXZaeAm"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED4B26B0A2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493066; cv=none; b=YuaEKSnVzJlSe68yWFq3D+WDKkz9KBetA5E6sga752z8vp28O4Laf/nby07CXA1jCHX3Q8uG30hZFYBzKtGR34fUngoka1hy/8XPUjYUl37HWaw4W1ReXI9FUmz0v5psRsc7VtXRyfn2aA7XgPpuv/uyt7Pg3KVXXQgqpEfFmbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493066; c=relaxed/simple;
	bh=lo3+cbd6dYJ5eg3PHIuyiAb/5v6vgRiC8GZKvU9kk0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAEk0TKQyrKIbsBj0LykSc0F4rqavBNkUTiR9UOQMt/Y8CYUa/tn8CODcmMPM+gtTza3oz1/TRmY6yLvwvJ9xau21MPKs48DbL2+qCJJOt30OR2LLmGWKZEK6c60rVNTOfbZh8CNL4fDK2d+kpA2wfFG/16+YBsEjjYja8NySc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KCXZaeAm; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6FD9C44280;
	Tue, 25 Feb 2025 14:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740493063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ngybRTkc4Ma7pkH5YlW7U8BggN94fh6wjcbQZdI+hvg=;
	b=KCXZaeAmRCKEY3wCI5qXmG3E8oXXOA7mBd4a8am1/VBIYqTIW47xfzDAwF2R661XZcqXBs
	5o9ZP9g9TH+U6SPFZN13pcP1ze98Re+EK+2my1wYejaKE6lR1NlGaSP69jVu/kKREzRgoB
	9my1O71pITSNMPsHCXptMGRHeBbX146zXF39dsHPcO8Sqwm2uFRX6pIEzgq2e1OXgYEUTq
	9kNmVT8uhkAUdNOvCiqmN5xpC/UdSAMOaCxdGE73LDEC+/wtyymbewb339U58AspSO808r
	3uZIA1ceneXIXQebaxzRCLBzRCTcnVrZhlzvc3nPs9CuvtZQ1Y6tBwpqBQZ10w==
Date: Tue, 25 Feb 2025 15:17:40 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org,
	jbaron@akamai.com, gregkh@linuxfoundation.org, ukaszb@chromium.org
Cc: intel-gfx-trybot@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com,
	ville.syrjala@linux.intel.com
Subject: Re: [PATCH 17/63] dyndbg: check DYNDBG_CLASSMAP_DEFINE args at
 compile-time
Message-ID: <29ca1dc2-3a21-405f-a9b6-06bea7bd75ae@bootlin.com>
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
 <20250125064619.8305-18-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250125064619.8305-18-jim.cromie@gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudelvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefnohhuihhsucevhhgruhhvvghtuceolhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepudeiffduffeivdejgfejheeuudekkedvjeeuffegfefghfffkeelgffgieevudejnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohhuihhsqdgthhgruhhvvghtqdhlrghpthhophdpmhgrihhlfhhrohhmpehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedugedprhgtphhtthhopehjihhmrdgtrhhomhhivgesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjsggrrhhonhesrghkrghmrghirdgtohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnr
 dhorhhgpdhrtghpthhtohepuhhkrghsiigssegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehinhhtvghlqdhgfhigqdhtrhihsghotheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtoheprghmugdqghhfgieslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrgh
X-GND-Sasl: louis.chauvet@bootlin.com



Le 25/01/2025 à 07:45, Jim Cromie a écrit :
> Add __DYNDBG_CLASSMAP_CHECK to implement these arg-checks at compile:
> 	0 <= _base < 63
> 	class_names is not empty
> 	class_names[0] is a string
> 	(class_names.length + _base) < 63
> 
> These compile-time checks will prevent several misuses; 4 such
> examples are added to test_dynamic_debug_submod.ko, and will fail
> compilation if -DDD_MACRO_ARGCHECK is added to cflags.
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
> - split static-asserts to __DYNDBG_CLASSMAP_CHECK
> - move __DYNDBG_CLASSMAP_CHECK above kdoc for DYNDBG_CLASSMAP_DEFINE
>    silences kernel-doc warnings
> ---
>   include/linux/dynamic_debug.h |  9 +++++++++
>   lib/test_dynamic_debug.c      | 11 +++++++++++
>   2 files changed, 20 insertions(+)
> 
> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index dc610a12b91c..2b0c943af330 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
> @@ -99,6 +99,14 @@ struct ddebug_class_map {
>   	enum ddebug_class_map_type map_type;
>   };
>   
> +#define __DYNDBG_CLASSMAP_CHECK(_clnames, _base)			\
> +	static_assert(((_base) >= 0 && (_base) < _DPRINTK_CLASS_DFLT),	\
> +		      "_base must be in 0..62");			\
> +	static_assert(ARRAY_SIZE(_clnames) > 0,				\
> +		      "classnames array size must be > 0");		\
> +	static_assert((ARRAY_SIZE(_clnames) + (_base)) < _DPRINTK_CLASS_DFLT, \
> +		      "_base + classnames.length exceeds range")
> +
>   /**
>    * DYNDBG_CLASSMAP_DEFINE - define debug classes used by a module.
>    * @_var:   name of the classmap, exported for other modules coordinated use.
> @@ -112,6 +120,7 @@ struct ddebug_class_map {
>    */
>   #define DYNDBG_CLASSMAP_DEFINE(_var, _mapty, _base, ...)		\
>   	static const char *_var##_classnames[] = { __VA_ARGS__ };	\
> +	__DYNDBG_CLASSMAP_CHECK(_var##_classnames, (_base));		\
>   	extern struct ddebug_class_map _var;				\
>   	struct ddebug_class_map __aligned(8) __used			\
>   		__section("__dyndbg_classes") _var = {			\
> diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
> index 1838f62738c4..b1555b0a2bb1 100644
> --- a/lib/test_dynamic_debug.c
> +++ b/lib/test_dynamic_debug.c
> @@ -123,8 +123,19 @@ DYNDBG_CLASSMAP_PARAM(level_num, p);
>   DYNDBG_CLASSMAP_USE(map_disjoint_bits);
>   DYNDBG_CLASSMAP_USE(map_level_num);
>   
> +#if defined(DD_MACRO_ARGCHECK)
> +/*
> + * Exersize compile-time arg-checks in DYNDBG_CLASSMAP_DEFINE.
> + * These will break compilation.
> + */
> +DYNDBG_CLASSMAP_DEFINE(fail_base_neg, 0, -1, "NEGATIVE_BASE_ARG");
> +DYNDBG_CLASSMAP_DEFINE(fail_base_big, 0, 100, "TOOBIG_BASE_ARG");
> +DYNDBG_CLASSMAP_DEFINE(fail_str_type, 0, 0, 1 /* not a string */);
> +DYNDBG_CLASSMAP_DEFINE(fail_emptyclass, 0, 0 /* ,empty */);

Hi Jim,

This test is nice, but can we move it in the *_submod.c directly? They 
don't need anything from this file.

Tested-by: Louis Chauvet <louis.chauvet@bootlin.com>

Thanks,
Louis Chauvet

>   #endif
>   
> +#endif /* TEST_DYNAMIC_DEBUG_SUBMOD */
> +
>   /* stand-in for all pr_debug etc */
>   #define prdbg(SYM) __pr_debug_cls(SYM, #SYM " msg\n")
>   

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


