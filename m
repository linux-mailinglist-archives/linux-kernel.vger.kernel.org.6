Return-Path: <linux-kernel+bounces-304601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F40A96225A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29786281E0F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769D815B971;
	Wed, 28 Aug 2024 08:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mtncNZ6F"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054148288F
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 08:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724834163; cv=none; b=LWPyX4hJFzfbOuNi2KKMlgPABdPOhY+NHsjjWgcRuwhLfA2aQnTKXNwz/EREBFQ/WKCCamJarXJxtP88DoDq9IzTFBqueP0gOJKbwx4PcIaU8XU+YUJYIqsRjWj1tlWa/cDI6ibQweqXODeiMqLFIs/KEUjFjq2hfUL5nCMLX0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724834163; c=relaxed/simple;
	bh=gizPOTp7IDSjb6kUrZDKwYTy4pO6ej/HLu/OaGGmw2M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZMdQdJCEsThH4NMPTq0y9mtOOGK7O7gMdBynO0C5DD4QvlhL0xqr3ohuj+WVkwOmorl5abia3WRm22DBo2DRuPT4Rwuz7A6Dh1nO7mtt8l4q2avTL9hyr4e4zVhwZaCuy2kyEFpXODGBlKAVYBatrc6oHCDFhTiQ60gUKp0FYOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mtncNZ6F; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724834161; x=1756370161;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=gizPOTp7IDSjb6kUrZDKwYTy4pO6ej/HLu/OaGGmw2M=;
  b=mtncNZ6Ffzj2ZHbsM5NHlRp2Npnek3hxa3pWfuXJH7uPtppTmfZcQRiA
   zohWLwMel9I/zr72xhygWIX3bzTZPcEHnnvwWTbiY3ihUU0Bmhd1wVMs5
   qrSKV/+TcDqQzSj812zASV7gEzlKDFwaQRZ/finMNmvTO3+Vv8C1eP84E
   R+5CA2bkuyM0zBhWYICYcnX5BzBIPW1C30ig45pm90XwxlqBhJZqJsVr9
   xlrEsnz131wTOHV1IvfsixfyKO7IMYatf25DQb+AEC2QqWZnFG/L/0X9t
   /6JlLZO2XMFXoGqujONFyum1v8Hpy2fkruCQmwFdvGz24EG6mtcbstRjY
   A==;
X-CSE-ConnectionGUID: HrG4zG5SRm2bDO23jzPopg==
X-CSE-MsgGUID: fMKkCwksTL+fWFtGFnEfgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="23512091"
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="23512091"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 01:35:56 -0700
X-CSE-ConnectionGUID: +4WDI96SRaSN52XLKOcOug==
X-CSE-MsgGUID: Dv6d161JQlCWjkDgTXxWMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="63193476"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.110])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 01:35:49 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>, Maxime Ripard
 <mripard@kernel.org>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, Melissa Wen
 <melissa.srw@gmail.com>, =?utf-8?Q?Ma=C3=ADra?= Canal
 <mairacanal@riseup.net>, Haneen
 Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net,
 linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 seanpaul@google.com, nicolejadeyee@google.com
Subject: Re: [PATCH RFC 11/15] drm: writeback: Add drm_writeback_connector
 cleanup
In-Reply-To: <Zs3z7tx4dMBfY_DX@louis-chauvet-laptop>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240814-google-remove-crtc-index-from-parameter-v1-0-6e179abf9fd4@bootlin.com>
 <20240814-google-remove-crtc-index-from-parameter-v1-11-6e179abf9fd4@bootlin.com>
 <20240827-solid-adorable-coucal-c3e0d1@houat>
 <Zs3z7tx4dMBfY_DX@louis-chauvet-laptop>
Date: Wed, 28 Aug 2024 11:35:43 +0300
Message-ID: <87a5gxyrhc.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Aug 2024, Louis Chauvet <louis.chauvet@bootlin.com> wrote:
> Le 27/08/24 - 16:33, Maxime Ripard a =C3=A9crit :
>> Hi,
>>=20
>> On Wed, Aug 14, 2024 at 04:36:33PM GMT, Louis Chauvet wrote:
>> > Currently drm_writeback_connector are created by
>> > drm_writeback_connector_init or drm_writeback_connector_init_with_enco=
der.
>> > Both of the function uses drm_connector_init and drm_encoder_init, but
>> > there is no way to properly clean those structure from outside.
>> >=20
>> > This patch introduce the new function drm_writeback_connector_cleanup =
to
>> > allow a proper cleanup.
>> >=20
>> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
>> > ---
>> >  drivers/gpu/drm/drm_writeback.c | 10 ++++++++++
>> >  include/drm/drm_writeback.h     | 11 +++++++++++
>> >  2 files changed, 21 insertions(+)
>> >=20
>> > diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_wri=
teback.c
>> > index a031c335bdb9..505a4eb40f93 100644
>> > --- a/drivers/gpu/drm/drm_writeback.c
>> > +++ b/drivers/gpu/drm/drm_writeback.c
>> > @@ -184,6 +184,7 @@ int drm_writeback_connector_init(struct drm_device=
 *dev,
>> >  	drm_encoder_helper_add(&wb_connector->encoder, enc_helper_funcs);
>> >=20=20
>> >  	wb_connector->encoder.possible_crtcs =3D possible_crtcs;
>> > +	wb_connector->managed_encoder =3D true;
>> >=20=20
>> >  	ret =3D drm_encoder_init(dev, &wb_connector->encoder,
>> >  			       &drm_writeback_encoder_funcs,
>> > @@ -290,6 +291,15 @@ int drm_writeback_connector_init_with_encoder(str=
uct drm_device *dev,
>> >  }
>> >  EXPORT_SYMBOL(drm_writeback_connector_init_with_encoder);
>> >=20=20
>> > +void drm_writeback_connector_cleanup(struct drm_writeback_connector *=
wb_connector)
>> > +{
>> > +	drm_connector_cleanup(&wb_connector->base);
>> > +	drm_property_blob_put(wb_connector->pixel_formats_blob_ptr);
>> > +	if (wb_connector->managed_encoder)
>> > +		drm_encoder_cleanup(&wb_connector->encoder);
>> > +}
>> > +EXPORT_SYMBOL(drm_writeback_connector_cleanup);
>> > +
>> >  int drm_writeback_set_fb(struct drm_connector_state *conn_state,
>> >  			 struct drm_framebuffer *fb)
>> >  {
>> > diff --git a/include/drm/drm_writeback.h b/include/drm/drm_writeback.h
>> > index 17e576c80169..e651c0c0c84c 100644
>> > --- a/include/drm/drm_writeback.h
>> > +++ b/include/drm/drm_writeback.h
>> > @@ -35,6 +35,15 @@ struct drm_writeback_connector {
>> >  	 */
>> >  	struct drm_encoder encoder;
>> >=20=20
>> > +	/**
>> > +	 * @managed_encoder: Sets to true if @encoder was created by drm_wri=
teback_connector_init()
>> > +	 *
>> > +	 * If the user used drm_writeback_connector_init_with_encoder() to c=
reate the connector,
>> > +	 * @encoder is not valid and not managed by drm_writeback_connector.=
 This fields allows
>> > +	 * the drm_writeback_cleanup() function to properly destroy the enco=
der if needed.
>> > +	 */
>> > +	bool managed_encoder;
>> > +
>>=20
>> I think we should rather create drmm_writeback_connector variants,
>> and make both deprecated in favor of these new functions.
>
> Hi,
>
> I can try to do it. If I understand correctly, you want to create two=20
> functions like this?=20
>
> 	int drmm_writeback_connector_init([...]) {
> 		/* drmm and alloc as we want to let drm core to manage this=20
> 		   encoder, no need to store it in drm_writeback_connector=20
> 		   */
> 		enc =3D drmm_plain_encoder_alloc(...);
>
> 		return drmm_writeback_connector_init_with_encoder([...], enc);
> 	}
>
> 	int drmm_writeback_connector_init_with_encoder([...], enc) {
> 		con =3D drmm_connector_init([...]);
>
> 		drm_connector_attach_encoder(enc, con);
>
> 		/* Needed for pixel_formats_blob_ptr, base is already=20
> 		   managed by drmm_connector_init. Maybe cleaning=20
> 		   job_queue is also needed? */
> 		drmm_add_action_or_reset([...], &drm_writeback_connector_cleanup)
> 	}

Why add two variants, when you can have one and pass NULL for encoder?
We have the _init_with_encoder variant only because nobody bothered to
clean up existing call sites.

Side note, I'd still like to be able to pass driver's own allocated
connector instead of having writeback midlayer force it on you.

BR,
Jani.


>
> Louis Chauvet
>=20=20
>> Maxime
>
>

--=20
Jani Nikula, Intel

