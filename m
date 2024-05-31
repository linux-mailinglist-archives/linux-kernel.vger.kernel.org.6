Return-Path: <linux-kernel+bounces-196888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CAD8D6311
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6514628BD5B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4785A158D95;
	Fri, 31 May 2024 13:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="IW4IgK+v";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="m4BwLR/F"
Received: from mailrelay5-1.pub.mailoutpod2-cph3.one.com (mailrelay5-1.pub.mailoutpod2-cph3.one.com [46.30.211.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F2C33CF1
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 13:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717162478; cv=none; b=BhQIJSRqViaUd0Iytp5TngnFyKUT/J7jYcwFtCAVacaV6oaaF+iEYbV9dily19BnfRyDn0xNGnoRMFRuejAUrQwxlqh4mNQIFLxU+p41svkSHGowESlb1bla3xrEIIkeA1ffURBgKuEYhgTQTRgdxVSDT+Gyl4R6ODMzXGvvmag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717162478; c=relaxed/simple;
	bh=pm5XWq85ofI0ZiiAAhQazU+EXRbmq43J0rqYOWTvjSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JU1z+YuMjyApuqClHlsdf0gd2rHDuJyxHxCglkGb5lY3xfjiEDa7Wz6H+O38/JanVHhDCYR4EnwRiqNhdsKioC/RLugDXWF7qkUbuesC3bxY72YoRLDmRUmlBpYviwYgvg5Vx1KzP6llMS/nUyfas6rfUKidBnXksbVuB92JdUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=IW4IgK+v; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=m4BwLR/F; arc=none smtp.client-ip=46.30.211.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=KnLBkmGVK+Mze45aQJhkynNz/NaOQLWFZL8uozaU7LA=;
	b=IW4IgK+vKRlYYnKwovgqCnj3TvBdlAzVSMtWU8mUdBVU8J6Rvf2vh0yD/j0BUyPO9L9PqmoFTzvhA
	 VePw5r44xg5xsbKYPQTlWIgrHL5XuP4q5ZCmBMSUhh4nsvdz1Qvk6dd8oSgTlzVrEFj18xrKATDoVD
	 oiLAkN20nKbjxWaI8Wk9tR6+Gjpk7KU3csEl7HIj7fc+ADuK3aCmEP+o3pv02CJG7v0gaW5uB7BY7l
	 Oyjqgty7Uj8DoslRJu6sbvZoGhR183HokRL8qXyJR5w8q0LEyhHHbCgu60I3yiSpCszWlKWi/oDeBX
	 TTuslA1CH+hbPTpUaLA6Dc0Wa+SkPDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=KnLBkmGVK+Mze45aQJhkynNz/NaOQLWFZL8uozaU7LA=;
	b=m4BwLR/F0FHK1XL7SfH6omLlaMI4VtEMHgFTamYSyyDmHt6/4e3SgffntQNRBhmgSdrt1vQ/vP5Oy
	 dDp6wFHDQ==
X-HalOne-ID: 5ad6a8be-1f52-11ef-8959-edf132814434
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay5.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 5ad6a8be-1f52-11ef-8959-edf132814434;
	Fri, 31 May 2024 13:33:25 +0000 (UTC)
Date: Fri, 31 May 2024 15:33:24 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Sui Jingfeng <sui.jingfeng@linux.dev>,
	Jayesh Choudhary <j-choudhary@ti.com>
Cc: Jayesh Choudhary <j-choudhary@ti.com>, linux-kernel@vger.kernel.org,
	dmitry.baryshkov@linaro.org, andrzej.hajda@intel.com,
	neil.armstrong@linaro.org, rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com, mripard@kernel.org,
	jonas@kwiboo.se, jernej.skrabec@gmail.com,
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
	airlied@gmail.com, daniel@ffwll.ch, a-bhatia1@ti.com,
	dri-devel@lists.freedesktop.org
Subject: Re: [v4,1/2] drm/bridge: sii902x: Fix mode_valid hook
Message-ID: <20240531133324.GA1715839@ravnborg.org>
References: <20240530092930.434026-2-j-choudhary@ti.com>
 <e5ce13e6-1007-41c9-bedc-2045d6f75480@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5ce13e6-1007-41c9-bedc-2045d6f75480@linux.dev>

Hi Jayesh,

> > +
> >   static const struct drm_bridge_funcs sii902x_bridge_funcs = {
> >   	.attach = sii902x_bridge_attach,
> >   	.mode_set = sii902x_bridge_mode_set,
> > @@ -516,6 +529,7 @@ static const struct drm_bridge_funcs sii902x_bridge_funcs = {
> >   	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
> >   	.atomic_get_input_bus_fmts = sii902x_bridge_atomic_get_input_bus_fmts,
> >   	.atomic_check = sii902x_bridge_atomic_check,
> > +	.mode_valid = sii902x_bridge_mode_valid,

As you have the possibility to test the driver, it would be nice with a
follow-up patch that replaces the use of enable() / disable() with the
atomic counterparts.

enable() / disable() are deprecated, so it is nice to reduce their use.

	Sam

