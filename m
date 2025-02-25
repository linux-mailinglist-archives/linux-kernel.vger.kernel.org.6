Return-Path: <linux-kernel+bounces-531599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9B1A44281
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1DB3B14D9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C99026981F;
	Tue, 25 Feb 2025 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VS2zEWd3"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04722267AEA
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493140; cv=none; b=NPssI1PlKY8r7wXfnJt+sdwecEzY8+4Wsrj8m355+oOZpC+VIQblLVPp8P2XYkaa/JNEdoUNUZz/YRGQm780WVZuPI0bsPkF/g4TRhH6blSEH10H1Z3y5sGADLgj7GlxDkheifPsTNMMOgHSfs/uQDpmQ5oa8QNFnK169g+LAnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493140; c=relaxed/simple;
	bh=1u8TmiDL1+9v+qezBeYui2cnPPMk8pv3NB12bWAHPb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TR8we9EqxWVK3Kh6ycM40BedDpI2C3NW4U2UoR5LBtHS0pcNV5Sf8QHBmII6LkverzTErBSPJ//VcP9l7I/GD9XohTJ7g1O22i6vk5MIAekbh2Q8d/ElAZefpTtrBuIbiEH6G65G6tKRvoi0+mo2k8c7+IskfIRVAPSlRpc89sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VS2zEWd3; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A59841F764;
	Tue, 25 Feb 2025 14:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740493137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KUG7GiC+NoSlu5vBYCzR4y1saIDfKTsXhfWSzsPrF8Q=;
	b=VS2zEWd3vOtIWUqiMJKdEJ4VC/jGkUTDgQ7JOTpnviJ3cBJG5pPl66WTWGcRjXsbfRWqT6
	ZVM8ui70cY2Bev20U1rTPelYowNGHi5i5PeoWRUzVTMESPD3+nLL+FQMNmbnyIkCG/jWxd
	QNQsZYLVGU7kTxz2VFfDHWNNas+qjS8gWLrqwsBakQiVkbcNdHqlmpr6gVpsxvaR1RhQrk
	8yGfi5a9b4GzU02hX1Mf45raF4FuYkDeMrNXILaGEsOAGOJ7soYYiU5tWSt2bZ+/m6IU6s
	2JLEIMrHR7sp1VeqzMPCNGyBmdtmrsRBSl4pSZDX7EePvgCzA8PVHLNqtpoPrg==
Date: Tue, 25 Feb 2025 15:18:54 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org,
	jbaron@akamai.com, gregkh@linuxfoundation.org, ukaszb@chromium.org
Cc: intel-gfx-trybot@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com,
	ville.syrjala@linux.intel.com
Subject: Re: [PATCH 18/63] dyndbg: add/use for_subvec() to reduce boilerplate
Message-ID: <1a0034df-292b-49f5-bc90-709bcd5af9a9@bootlin.com>
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
 <20250125064619.8305-19-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250125064619.8305-19-jim.cromie@gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudelvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefnohhuihhsucevhhgruhhvvghtuceolhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepudeiffduffeivdejgfejheeuudekkedvjeeuffegfefghfffkeelgffgieevudejnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohhuihhsqdgthhgruhhvvghtqdhlrghpthhophdpmhgrihhlfhhrohhmpehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedugedprhgtphhtthhopehjihhmrdgtrhhomhhivgesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjsggrrhhonhesrghkrghmrghirdgtohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnr
 dhorhhgpdhrtghpthhtohepuhhkrghsiigssegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehinhhtvghlqdhgfhigqdhtrhihsghotheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtoheprghmugdqghhfgieslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrgh
X-GND-Sasl: louis.chauvet@bootlin.com



Le 25/01/2025 à 07:45, Jim Cromie a écrit :
> add for_subvec() macro to encapsulate a for-loop pattern thats used
> repeatedly to iterate over a boxed.vector of N elements.
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

Hi Jim,

Do you think it is possible to move this patch earlier in the series, so 
you can use it when introducing class_users.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

Thanks,
Louis Chauvet

> ---
>   lib/dynamic_debug.c | 30 ++++++++++++++++++++++--------
>   1 file changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 6bca0c6727d4..08b6e4e7489f 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -158,20 +158,34 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
>   		  _dt->num_class_users);				\
>   	})
>   
> +/*
> + * simplify a repeated for-loop pattern walking N steps in a T _vec
> + * member inside a struct _box.  It expects int i and T *_sp to be
> + * declared in the caller.
> + * @_i:  caller provided counter.
> + * @_sp: cursor into _vec, to examine each item.
> + * @_box: ptr to a struct containing @_vec member
> + * @_vec: name of a sub-struct member in _box, with array-ref and length
> + */
> +#define for_subvec(_i, _sp, _box, _vec)				       \
> +	for ((_i) = 0, (_sp) = (_box)->_vec;			       \
> +	     (_i) < (_box)->num_##_vec;				       \
> +	     (_i)++, (_sp)++)
> +
>   static int ddebug_find_valid_class(struct ddebug_table const *dt, const char *class_string)
>   {
>   	struct ddebug_class_map *map;
>   	struct ddebug_class_user *cli;
>   	int i, idx;
>   
> -	for (i = 0, map = dt->classes; i < dt->num_classes; i++, map++) {
> +	for_subvec(i, map, dt, classes) {
>   		idx = match_string(map->class_names, map->length, class_string);
>   		if (idx >= 0) {
>   			vpr_dt_info(dt, "good-class: %s.%s ", map->mod_name, class_string);
>   			return idx + map->base;
>   		}
>   	}
> -	for (i = 0, cli = dt->class_users; i < dt->num_class_users; i++, cli++) {
> +	for_subvec(i, cli, dt, class_users) {
>   		idx = match_string(cli->map->class_names, cli->map->length, class_string);
>   		if (idx >= 0) {
>   			vpr_dt_info(dt, "class-ref: %s -> %s.%s ",
> @@ -1190,7 +1204,7 @@ static void ddebug_apply_params(const struct ddebug_class_map *cm, const char *m
>   	if (cm->mod) {
>   		vpr_cm_info(cm, "loaded classmap: %s", modnm);
>   		/* ifdef protects the cm->mod->kp deref */
> -		for (i = 0, kp = cm->mod->kp; i < cm->mod->num_kp; i++, kp++)
> +		for_subvec(i, kp, cm->mod, kp)
>   			ddebug_match_apply_kparam(kp, cm, modnm);
>   	}
>   #endif
> @@ -1212,7 +1226,7 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt,
>   	struct ddebug_class_map *cm;
>   	int i, nc = 0;
>   
> -	for (i = 0, cm = di->classes; i < di->num_classes; i++, cm++) {
> +	for_subvec(i, cm, di, classes) {
>   		if (!strcmp(cm->mod_name, dt->mod_name)) {
>   			vpr_cm_info(cm, "classes[%d]:", i);
>   			if (!nc++)
> @@ -1225,7 +1239,7 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt,
>   	vpr_info("module:%s attached %d classes\n", dt->mod_name, nc);
>   	dt->num_classes = nc;
>   
> -	for (i = 0, cm = dt->classes; i < dt->num_classes; i++, cm++)
> +	for_subvec(i, cm, dt, classes)
>   		ddebug_apply_params(cm, cm->mod_name);
>   }
>   
> @@ -1245,7 +1259,7 @@ static void ddebug_attach_user_module_classes(struct ddebug_table *dt,
>   	 * module's refs, save to dt.  For loadables, this is the
>   	 * whole array.
>   	 */
> -	for (i = 0, cli = di->class_users; i < di->num_class_users; i++, cli++) {
> +	for_subvec(i, cli, di, class_users) {
>   		if (WARN_ON_ONCE(!cli || !cli->map || !cli->mod_name))
>   			continue;
>   		if (!strcmp(cli->mod_name, dt->mod_name)) {
> @@ -1261,7 +1275,7 @@ static void ddebug_attach_user_module_classes(struct ddebug_table *dt,
>   	dt->num_class_users = nc;
>   
>   	/* now iterate dt */
> -	for (i = 0, cli = dt->class_users; i < dt->num_class_users; i++, cli++)
> +	for_subvec(i, cli, di, class_users)
>   		ddebug_apply_params(cli->map, cli->mod_name);
>   
>   	vpr_dt_info(dt, "attach-client-module: ");
> @@ -1299,7 +1313,7 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
>   
>   	INIT_LIST_HEAD(&dt->link);
>   
> -	for (i = 0, iter = di->descs; i < di->num_descs; i++, iter++)
> +	for_subvec(i, iter, di, descs)
>   		if (iter->class_id != _DPRINTK_CLASS_DFLT)
>   			class_ct++;
>   

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


