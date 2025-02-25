Return-Path: <linux-kernel+bounces-531614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6216A442B3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57F223BE3CC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7342698BB;
	Tue, 25 Feb 2025 14:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fLlZS8+L"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7463596D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493621; cv=none; b=WzmlXTLljDNAHy0V0El8AxB0zrDNHL0/Ym/SUuZbzfVvowa1v0U663e/ouQkRlvX3Fw4+egSZipt0deKUo3ILagj1+tuCoY3HA8UBQt1y5QYU6XrdNcJeYAVYnFWmgIM6Jg9sO92Bo/faN1d2poucUpOgZ4BFC+HSaGHWvOY0UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493621; c=relaxed/simple;
	bh=ueeupAqqWq/b0kDXbDYUsg2W9f6w1Xkv3nCar4Y1smk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbdOMcvUbj9X7G7ORa2hWIJfn/vGyIOmbZ80xpN8Nk240izRv1GpNgitBUXOYPH63oIp0+uNgeU5QpuMf/o4LYbhlPJMRdcpmADhI8SUh+kdMsd1aIvLCSFZYG1QBnu8EqtAnGbaNvCHAsTA/CZa9YzGM5gO7OAp0tEV6rcaL6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fLlZS8+L; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 90E8D44437;
	Tue, 25 Feb 2025 14:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740493616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A7Eg31zR/qOe6wncGHWOwy7uXg8md/BtbFoukUsY25k=;
	b=fLlZS8+LVOmQll/hIxjfLrKOKeX9Zx+ohI9QXGEfgVbDuPV0gZ1RGtcHc0pAl6QRph9WDD
	vEkzYUH6ydvklQvphAwfUqOC/SM8vJEQxkPpzXNJkjiszxR9bA63cNFP7f949gsCZAHdvs
	0IlPjGKV3op3OZusTpUb59i9jnWRy9AymCtTM2p0KmBBaf9nUeUi0gJSsw+27ulT9EB8kz
	5vfbp7MQ9cKip2hv9d0OdzksN07UBfsIkj2ZSQlDw8OzPI/VN5j9TtBFwPboKx46ciIAXy
	rOTIVNzi8OSVn/mxFGDzWoOIXlDrnH8NdO5AXYrp8YnXILUDjOCy02VZqp9hrQ==
Date: Tue, 25 Feb 2025 15:26:54 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org,
	jbaron@akamai.com, gregkh@linuxfoundation.org, ukaszb@chromium.org
Cc: intel-gfx-trybot@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com,
	ville.syrjala@linux.intel.com
Subject: Re: [PATCH 21/63] dyndbg: allow ddebug_add_module to fail
Message-ID: <497016b0-9e72-4374-a19b-967df8ed9b44@bootlin.com>
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
 <20250125064619.8305-22-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250125064619.8305-22-jim.cromie@gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudelfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefnohhuihhsucevhhgruhhvvghtuceolhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepudeiffduffeivdejgfejheeuudekkedvjeeuffegfefghfffkeelgffgieevudejnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohhuihhsqdgthhgruhhvvghtqdhlrghpthhophdpmhgrihhlfhhrohhmpehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedugedprhgtphhtthhopehjihhmrdgtrhhomhhivgesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjsggrrhhonhesrghkrghmrghirdgtohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnr
 dhorhhgpdhrtghpthhtohepuhhkrghsiigssegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehinhhtvghlqdhgfhigqdhtrhihsghotheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtoheprghmugdqghhfgieslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrgh
X-GND-Sasl: louis.chauvet@bootlin.com



Le 25/01/2025 à 07:45, Jim Cromie a écrit :
> To prep for failing modprobe on classid conflicts, upgrade the
> call-chain around ddebug_add_module(), in 2 ways:
> 
> 1. in ddebug_add_module() add local reserved_ids to accumulate
> reservations, pass it by ref to ddebug_attach_{,user_}module_classes()
> so they can examine the reservations as they work.
> 
> 2. return int from both ddebug_attach_{,user_}module_classes(), up to
> ddebug_add_module(), then to ddebug_module_notify().
> 
> No conflicts are currently detected or returned.
> 
> TBD: This is updated further by hoisting the reservation-check, which
> obsoletes part of 2, creating churn, maybe squash it away.

Hi Jim,

It could be very nice to squash when possible yes!

> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
>   lib/dynamic_debug.c | 40 +++++++++++++++++++++++++++++-----------
>   1 file changed, 29 insertions(+), 11 deletions(-)
> 
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 16c9b752822b..0ef243e30663 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -1216,8 +1216,9 @@ static void ddebug_apply_params(const struct ddebug_class_map *cm, const char *m
>    * modular classmap vector/section.  Save the start and length of the
>    * subrange at its edges.
>    */
> -static void ddebug_attach_module_classes(struct ddebug_table *dt,
> -					 const struct _ddebug_info *di)
> +static int ddebug_attach_module_classes(struct ddebug_table *dt,
> +					const struct _ddebug_info *di,
> +					u64 *reserved_ids)
>   {
>   	struct ddebug_class_map *cm;
>   	int i, nc = 0;
> @@ -1230,13 +1231,14 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt,
>   		}
>   	}
>   	if (!nc)
> -		return;
> +		return 0;
>   
>   	vpr_info("module:%s attached %d classes\n", dt->mod_name, nc);
>   	dt->info.maps.len = nc;
>   
>   	for_subvec(i, cm, &dt->info, maps)
>   		ddebug_apply_params(cm, cm->mod_name);
> +	return 0;
>   }
>   
>   /*
> @@ -1244,8 +1246,9 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt,
>    * means a query against the dt/module, which means it must be on the
>    * list to be seen by ddebug_change.
>    */
> -static void ddebug_attach_user_module_classes(struct ddebug_table *dt,
> -					      const struct _ddebug_info *di)
> +static int ddebug_attach_user_module_classes(struct ddebug_table *dt,
> +					      const struct _ddebug_info *di,
> +					      u64 *reserved_ids)
>   {
>   	struct ddebug_class_user *cli;
>   	int i, nc = 0;
> @@ -1266,7 +1269,7 @@ static void ddebug_attach_user_module_classes(struct ddebug_table *dt,
>   		}
>   	}
>   	if (!nc)
> -		return;
> +		return 0;
>   
>   	dt->info.users.len = nc;
>   
> @@ -1275,6 +1278,7 @@ static void ddebug_attach_user_module_classes(struct ddebug_table *dt,
>   		ddebug_apply_params(cli->map, cli->mod_name);
>   
>   	vpr_dt_info(dt, "attach-client-module: ");
> +	return 0;
>   }
>   
>   /*
> @@ -1284,6 +1288,8 @@ static void ddebug_attach_user_module_classes(struct ddebug_table *dt,
>   static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
>   {
>   	struct ddebug_table *dt;
> +	u64 reserved_ids = 0;
> +	int rc;
>   
>   	if (!di->descs.len)
>   		return 0;
> @@ -1306,16 +1312,23 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
>   
>   	INIT_LIST_HEAD(&dt->link);
>   
> -	if (di->maps.len)
> -		ddebug_attach_module_classes(dt, di);
> -
> +	if (di->maps.len) {
> +		rc = ddebug_attach_module_classes(dt, di, &reserved_ids);
> +		if (rc) {
> +			kfree(dt);
> +			return rc;
> +		}
> +	}
>   	mutex_lock(&ddebug_lock);
>   	list_add_tail(&dt->link, &ddebug_tables);
>   	mutex_unlock(&ddebug_lock);
>   
> -	if (di->users.len)
> -		ddebug_attach_user_module_classes(dt, di);
>   
> +	if (di->users.len) {
> +		rc = ddebug_attach_user_module_classes(dt, di, &reserved_ids);
> +		if (rc)
> +			return rc;
> +	}
>   	vpr_info("%3u debug prints in module %s\n", di->descs.len, modname);
>   	return 0;
>   }
> @@ -1400,6 +1413,11 @@ static int ddebug_module_notify(struct notifier_block *self, unsigned long val,
>   	switch (val) {
>   	case MODULE_STATE_COMING:
>   		ret = ddebug_add_module(&mod->dyndbg_info, mod->name);
> +		if (ret == -EINVAL) {
> +			pr_err("conflicting dyndbg-classmap reservations\n");
> +			ddebug_remove_module(mod->name);
> +			break;
> +		}
>   		if (ret)
>   			WARN(1, "Failed to allocate memory: dyndbg may not work properly.\n");
>   		break;

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


