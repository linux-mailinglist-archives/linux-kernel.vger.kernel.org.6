Return-Path: <linux-kernel+bounces-531569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DB3A44217
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E55517A93A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6F826A0DA;
	Tue, 25 Feb 2025 14:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bXvMIfYC"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E883F26A0D9
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492603; cv=none; b=o36btzbrO3F402QVu3CiSkcBfgK694pbXAzJfD8Hu2zcttJFzpXFrz/Y8aUb6qJ1kWvux0KK1GpDJWRhDvjmRDyv0bZCKsTKHr3kpAlL+9C/yv2ApynFxyNrNg/UxeGYA7lLux+2E4BTvYWuncLULWlOHvyAyU3VXKjkQ6XRdaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492603; c=relaxed/simple;
	bh=F2ZtTpzKOTo0loLz7JVZp+k+qUtfNzcd5c9WAyRr+BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQhi2cY0Jsk/lgVq4TJkEHmaXWVTPDyVXf9d70Df/GQoSIHlARMyotVXUK/FuWlk9lQh17UDxq3gMV6Jj5WhFNWxlexDPMbDupLLXCarWFGBKtQ1SxX1I6Gf8lV/7WLfp4J26DyhK9II3K8fLwi6D9koaGI+QsBEhG9yGgXN3yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bXvMIfYC; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 28C3D441B4;
	Tue, 25 Feb 2025 14:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740492600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uytzOtSSVbGCsPo9JFb4lZ5tAcQbIsTS1AThWYB6ruk=;
	b=bXvMIfYC3LugBAoKz5rha+iAQN2q+C3w7N4cDkVzq/br0cJOmjLVdzrcBYrJmxQaeF+XBY
	N8Mv1QIRVYhjS/6ibfT7D4qBCdJc4oSaJlKdrI1ZSuYEBagtknSaq4Y4aOI2zvNf5qf3vf
	F/ZX7q44HYD8zh3m/s/ZyxENiE8Sp1gl8ACCaJ69MB4FogoDNorcOl+w7zYutodshevj6D
	hr1m+M5yQUnnXG7gewtN6VYg1DYPNeE00cPp5kCtDQSydioQu2kpGg2RabSl3iybxAQItQ
	lBnTLZCesE7epFY7WrKfjm8Jyv/B4dldHgVIOqNDtHW8hVKbXt9EPhbMU0WLXQ==
Date: Tue, 25 Feb 2025 15:09:57 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org,
	jbaron@akamai.com, gregkh@linuxfoundation.org, ukaszb@chromium.org
Cc: intel-gfx-trybot@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com,
	ville.syrjala@linux.intel.com
Subject: Re: [PATCH 08/63] dyndbg: drop NUM_TYPE_ARRAY
Message-ID: <ff609f47-f39d-454a-9222-0efe6ee8a9b3@bootlin.com>
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
 <20250125064619.8305-9-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250125064619.8305-9-jim.cromie@gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudeltdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefnohhuihhsucevhhgruhhvvghtuceolhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepudeiffduffeivdejgfejheeuudekkedvjeeuffegfefghfffkeelgffgieevudejnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohhuihhsqdgthhgruhhvvghtqdhlrghpthhophdpmhgrihhlfhhrohhmpehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedugedprhgtphhtthhopehjihhmrdgtrhhomhhivgesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjsggrrhhonhesrghkrghmrghirdgtohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnr
 dhorhhgpdhrtghpthhtohepuhhkrghsiigssegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehinhhtvghlqdhgfhigqdhtrhihsghotheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtoheprghmugdqghhfgieslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrgh
X-GND-Sasl: louis.chauvet@bootlin.com



Le 25/01/2025 à 07:45, Jim Cromie a écrit :
> ARRAY_SIZE works here, since array decl is complete.
> 
> no functional change
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
>   include/linux/dynamic_debug.h | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index 2b0057058ecf..e458d4b838ac 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
> @@ -106,11 +106,9 @@ struct ddebug_class_map {
>   		.mod_name = KBUILD_MODNAME,				\
>   		.base = _base,						\
>   		.map_type = _maptype,					\
> -		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
> +		.length = ARRAY_SIZE(_var##_classnames),		\
>   		.class_names = _var##_classnames,			\
>   	}
> -#define NUM_TYPE_ARGS(eltype, ...)				\
> -        (sizeof((eltype[]){__VA_ARGS__}) / sizeof(eltype))
>   
>   /* encapsulate linker provided built-in (or module) dyndbg data */
>   struct _ddebug_info {

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


