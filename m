Return-Path: <linux-kernel+bounces-521219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3A1A3B95F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7E117D54C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436621DF25E;
	Wed, 19 Feb 2025 09:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="um+CXceo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D43A17A2FE
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 09:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956800; cv=none; b=DUWfKHhfk9KBiiJmfJIcaVIqBY9oaSBz9T5lGtyhvxMfffw8tkdeIwbI+5aOov81KABA8BFdI8TPZALJtC4Jh7K9R0GSz1e1pWh7f2t8boPGfLRTp4k6aGKqp+UAB/eE2XjLsKS7U+J2VTFYUL2VcfWcSULRMvklmydwNABr+5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956800; c=relaxed/simple;
	bh=GgomySZeWLFxNbBGw621PvZP7aIPFglKh/2yCe/9CRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+PfjZKWXoVFsrstR3m8UUyy+xSyPp2vLZvWCtMZcgMrDQG7Jgmyz0T1k6JEOsfzFbZ4z2fgNlLVwyULVNvZQVySAtwVGWAbs1bNWsNXLBTSJyPppt57DmXQn/6frYCqvdeRbkYAikC9/c9W0CJHoiCMm2l2OfoAg8ZxUD4wInY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=um+CXceo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9234AC4CED1;
	Wed, 19 Feb 2025 09:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739956799;
	bh=GgomySZeWLFxNbBGw621PvZP7aIPFglKh/2yCe/9CRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=um+CXceoAosY+iDzoAcLX/Gvv/rQUVTxGW/D/FIllUW1/Xtt/ZcLq3JjP/7iBMa6V
	 sn4fuIndsB7k0OrGZcr7TFYHJ/fQy2HJL4nmOiXcQmx5dsGVJ/xTrchO6c37rirl2D
	 FpY24faKQspkY7slXbWMMzU9ymOv3hw8ttfZ96UfDGi6ykw7u1Z71D2kVxzmYpoAMA
	 c4ByAoK602ltzfCP3C6oPrAK+cRR1RvPZKAfLpViVBEKUA6eaIfXh+aa0cJ/K6V6R6
	 jEMjwsA06ggIId/GdPUcdgyNsbaCmlYJzgFhjlGkVp8R40iL9qJbWU8KfsgjvmFGnO
	 KdWRqEzlyDGwQ==
Date: Wed, 19 Feb 2025 10:19:57 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	=?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/10] drm/display: add CEC helpers code
Message-ID: <20250219-fascinating-quizzical-herring-fe7d9c@houat>
References: <20250126-drm-hdmi-connector-cec-v3-0-5b5b2d4956da@linaro.org>
 <20250126-drm-hdmi-connector-cec-v3-2-5b5b2d4956da@linaro.org>
 <ylahtg54vvrpg5rzp3z5oyi37mtblj3hn4pzwylcimfakrzy3m@idqczwb3hvxl>
 <lme4jqksg7djyrxwpo3x363vlsyhld22co3tfsthniistnrm5h@kbygscfa7afr>
 <20250205-smoky-fearless-hornet-cbf422@houat>
 <j2ej27mzia326q6fjqk2c3xui6dhbx2chswjjmgaoxgiajstl2@dcmgdtkzbjht>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="yw42zjrvnoz67ryw"
Content-Disposition: inline
In-Reply-To: <j2ej27mzia326q6fjqk2c3xui6dhbx2chswjjmgaoxgiajstl2@dcmgdtkzbjht>


--yw42zjrvnoz67ryw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 02/10] drm/display: add CEC helpers code
MIME-Version: 1.0

On Wed, Feb 05, 2025 at 05:01:09PM +0200, Dmitry Baryshkov wrote:
> On Wed, Feb 05, 2025 at 03:27:05PM +0100, Maxime Ripard wrote:
> > On Tue, Jan 28, 2025 at 02:17:19PM +0200, Dmitry Baryshkov wrote:
> > > On Tue, Jan 28, 2025 at 11:36:06AM +0100, Maxime Ripard wrote:
> > > > On Sun, Jan 26, 2025 at 03:29:07PM +0200, Dmitry Baryshkov wrote:
> > > > > Add generic CEC helpers to be used by HDMI drivers. Both notifier=
 and
> > > > > and adapter are supported for registration. Once registered, the =
driver
> > > > > can call common set of functions to update physical address, to
> > > > > invalidate it or to unregister CEC data.
> > > > >=20
> > > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > ---
> > > > >  drivers/gpu/drm/display/Kconfig               |   5 +
> > > > >  drivers/gpu/drm/display/Makefile              |   2 +
> > > > >  drivers/gpu/drm/display/drm_hdmi_cec_helper.c | 209 ++++++++++++=
++++++++++++++
> > > > >  include/drm/display/drm_hdmi_cec_helper.h     |  61 ++++++++
> > > > >  4 files changed, 277 insertions(+)
> > > > >=20
> > > > > diff --git a/drivers/gpu/drm/display/Kconfig b/drivers/gpu/drm/di=
splay/Kconfig
> > > > > index 8d22b7627d41f7bc015decf24ae02a05bc00f055..49da9b768acf3e5f8=
4f2cefae4bb042cfd57a50c 100644
> > > > > --- a/drivers/gpu/drm/display/Kconfig
> > > > > +++ b/drivers/gpu/drm/display/Kconfig
> > > > > @@ -82,6 +82,11 @@ config DRM_DISPLAY_HDMI_AUDIO_HELPER
> > > > >  	  DRM display helpers for HDMI Audio functionality (generic HDM=
I Codec
> > > > >  	  implementation).
> > > > > =20
> > > > > +config DRM_DISPLAY_HDMI_CEC_HELPER
> > > > > +	bool
> > > > > +	help
> > > > > +	  DRM display helpers for HDMI CEC implementation.
> > > > > +
> > > > >  config DRM_DISPLAY_HDMI_HELPER
> > > > >  	bool
> > > > >  	help
> > > > > diff --git a/drivers/gpu/drm/display/Makefile b/drivers/gpu/drm/d=
isplay/Makefile
> > > > > index b17879b957d5401721396e247fa346387cf6c48a..2cd078e2b81c1a9e6=
b336c4187b444bcb8a50e51 100644
> > > > > --- a/drivers/gpu/drm/display/Makefile
> > > > > +++ b/drivers/gpu/drm/display/Makefile
> > > > > @@ -16,6 +16,8 @@ drm_display_helper-$(CONFIG_DRM_DISPLAY_DSC_HEL=
PER) +=3D \
> > > > >  drm_display_helper-$(CONFIG_DRM_DISPLAY_HDCP_HELPER) +=3D drm_hd=
cp_helper.o
> > > > >  drm_display_helper-$(CONFIG_DRM_DISPLAY_HDMI_AUDIO_HELPER) +=3D \
> > > > >  	drm_hdmi_audio_helper.o
> > > > > +drm_display_helper-$(CONFIG_DRM_DISPLAY_HDMI_CEC_HELPER) +=3D \
> > > > > +	drm_hdmi_cec_helper.o
> > > > >  drm_display_helper-$(CONFIG_DRM_DISPLAY_HDMI_HELPER) +=3D \
> > > > >  	drm_hdmi_helper.o \
> > > > >  	drm_scdc_helper.o
> > > > > diff --git a/drivers/gpu/drm/display/drm_hdmi_cec_helper.c b/driv=
ers/gpu/drm/display/drm_hdmi_cec_helper.c
> > > > > new file mode 100644
> > > > > index 0000000000000000000000000000000000000000..a6ed5f0fc3835b013=
a83308f5285ea0819c5702c
> > > > > --- /dev/null
> > > > > +++ b/drivers/gpu/drm/display/drm_hdmi_cec_helper.c
> > > > > @@ -0,0 +1,209 @@
> > > > > +// SPDX-License-Identifier: MIT
> > > > > +/*
> > > > > + * Copyright (c) 2024 Linaro Ltd
> > > > > + */
> > > > > +
> > > > > +#include <drm/drm_bridge.h>
> > > > > +#include <drm/drm_connector.h>
> > > > > +#include <drm/display/drm_hdmi_cec_helper.h>
> > > > > +
> > > > > +#include <linux/mutex.h>
> > > > > +
> > > > > +#include <media/cec.h>
> > > > > +#include <media/cec-notifier.h>
> > > > > +
> > > > > +void drm_connector_hdmi_cec_unregister(struct drm_connector *con=
nector)
> > > > > +{
> > > > > +	cec_unregister_adapter(connector->cec.adapter);
> > > > > +	connector->cec.adapter =3D NULL;
> > > > > +
> > > > > +	cec_notifier_conn_unregister(connector->cec.notifier);
> > > > > +	connector->cec.notifier =3D NULL;
> > > > > +
> > > > > +	connector->cec.funcs =3D NULL;
> > > > > +}
> > > > > +EXPORT_SYMBOL(drm_connector_hdmi_cec_unregister);
> > > > > +
> > > > > +static const struct drm_connector_cec_funcs drm_connector_hdmi_c=
ec_funcs =3D {
> > > > > +	.unregister =3D drm_connector_hdmi_cec_unregister,
> > > > > +};
> > > > > +
> > > > > +int drm_connector_hdmi_cec_notifier_register(struct drm_connecto=
r *connector,
> > > > > +					     const char *port_name,
> > > > > +					     struct device *dev)
> > > > > +{
> > > > > +	struct cec_connector_info conn_info;
> > > > > +	struct cec_notifier *notifier;
> > > > > +	int ret;
> > > > > +
> > > > > +	mutex_lock(&connector->cec.mutex);
> > > > > +
> > > > > +	if (connector->cec.funcs) {
> > > > > +		ret =3D -EBUSY;
> > > > > +		goto err_unlock;
> > > > > +	}
> > > > > +
> > > > > +	cec_fill_conn_info_from_drm(&conn_info, connector);
> > > > > +
> > > > > +	notifier =3D cec_notifier_conn_register(dev, port_name, &conn_i=
nfo);
> > > > > +	if (!notifier) {
> > > > > +		ret =3D -ENOMEM;
> > > > > +		goto err_unlock;
> > > > > +	}
> > > > > +
> > > > > +	connector->cec.notifier =3D notifier;
> > > > > +	connector->cec.funcs =3D &drm_connector_hdmi_cec_funcs;
> > > > > +
> > > > > +	mutex_unlock(&connector->cec.mutex);
> > > > > +
> > > > > +	return 0;
> > > > > +
> > > > > +err_unlock:
> > > > > +	mutex_unlock(&connector->cec.mutex);
> > > > > +
> > > > > +	return ret;
> > > > > +}
> > > > > +EXPORT_SYMBOL(drm_connector_hdmi_cec_notifier_register);
> > > > > +
> > > > > +#define to_hdmi_cec_adapter_ops(ops) \
> > > > > +	container_of(ops, struct drm_connector_hdmi_cec_adapter_ops, ba=
se)
> > > > > +
> > > > > +static int drm_connector_hdmi_cec_adap_enable(struct cec_adapter=
 *adap, bool enable)
> > > > > +{
> > > > > +	struct drm_connector *connector =3D cec_get_drvdata(adap);
> > > > > +	struct drm_connector_hdmi_cec_adapter_ops *ops =3D
> > > > > +		to_hdmi_cec_adapter_ops(connector->cec.funcs);
> > > > > +
> > > > > +	return ops->enable(connector, enable);
> > > > > +}
> > > > > +
> > > > > +static int drm_connector_hdmi_cec_adap_log_addr(struct cec_adapt=
er *adap, u8 logical_addr)
> > > > > +{
> > > > > +	struct drm_connector *connector =3D cec_get_drvdata(adap);
> > > > > +	struct drm_connector_hdmi_cec_adapter_ops *ops =3D
> > > > > +		to_hdmi_cec_adapter_ops(connector->cec.funcs);
> > > > > +
> > > > > +	return ops->log_addr(connector, logical_addr);
> > > > > +}
> > > > > +
> > > > > +static int drm_connector_hdmi_cec_adap_transmit(struct cec_adapt=
er *adap, u8 attempts,
> > > > > +						u32 signal_free_time, struct cec_msg *msg)
> > > > > +{
> > > > > +	struct drm_connector *connector =3D cec_get_drvdata(adap);
> > > > > +	struct drm_connector_hdmi_cec_adapter_ops *ops =3D
> > > > > +		to_hdmi_cec_adapter_ops(connector->cec.funcs);
> > > > > +
> > > > > +	return ops->transmit(connector, attempts, signal_free_time, msg=
);
> > > > > +}
> > > > > +
> > > > > +static const struct cec_adap_ops drm_connector_hdmi_cec_adap_ops=
 =3D {
> > > > > +	.adap_enable =3D drm_connector_hdmi_cec_adap_enable,
> > > > > +	.adap_log_addr =3D drm_connector_hdmi_cec_adap_log_addr,
> > > > > +	.adap_transmit =3D drm_connector_hdmi_cec_adap_transmit,
> > > > > +};
> > > > > +
> > > > > +int drm_connector_hdmi_cec_register(struct drm_connector *connec=
tor,
> > > > > +				    const struct drm_connector_hdmi_cec_adapter_ops *ops,
> > > > > +				    const char *name,
> > > > > +				    u8 available_las,
> > > > > +				    struct device *dev)
> > > > > +{
> > > > > +	struct cec_connector_info conn_info;
> > > > > +	struct cec_adapter *cec_adap;
> > > > > +	int ret;
> > > > > +
> > > > > +	if (!ops->base.unregister ||
> > > > > +	    !ops->init || !ops->enable || !ops->log_addr || !ops->trans=
mit)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	mutex_lock(&connector->cec.mutex);
> > > > > +
> > > > > +	if (connector->cec.funcs) {
> > > > > +		ret =3D -EBUSY;
> > > > > +		goto err_unlock;
> > > > > +	}
> > > > > +
> > > > > +	cec_adap =3D cec_allocate_adapter(&drm_connector_hdmi_cec_adap_=
ops, connector, name,
> > > > > +					CEC_CAP_DEFAULTS | CEC_CAP_CONNECTOR_INFO,
> > > > > +					available_las ? : CEC_MAX_LOG_ADDRS);
> > > > > +	ret =3D PTR_ERR_OR_ZERO(cec_adap);
> > > > > +	if (ret < 0)
> > > > > +		goto err_unlock;
> > > > > +
> > > > > +	cec_fill_conn_info_from_drm(&conn_info, connector);
> > > > > +	cec_s_conn_info(cec_adap, &conn_info);
> > > > > +
> > > > > +	connector->cec.adapter =3D cec_adap;
> > > > > +	connector->cec.funcs =3D &ops->base;
> > > > > +
> > > > > +	ret =3D ops->init(connector);
> > > > > +	if (ret < 0)
> > > > > +		goto err_delete_adapter;
> > > > > +
> > > > > +	ret =3D cec_register_adapter(cec_adap, dev);
> > > > > +	if (ret < 0)
> > > > > +		goto err_delete_adapter;
> > > > > +
> > > > > +	mutex_unlock(&connector->cec.mutex);
> > > > > +
> > > > > +	return 0;
> > > > > +
> > > > > +err_delete_adapter:
> > > > > +	cec_delete_adapter(cec_adap);
> > > > > +
> > > > > +	connector->cec.adapter =3D NULL;
> > > > > +
> > > > > +err_unlock:
> > > > > +	mutex_unlock(&connector->cec.mutex);
> > > > > +
> > > > > +	return ret;
> > > > > +}
> > > > > +EXPORT_SYMBOL(drm_connector_hdmi_cec_register);
> > > > > +
> > > > > +void drm_connector_hdmi_cec_received_msg(struct drm_connector *c=
onnector,
> > > > > +					 struct cec_msg *msg)
> > > > > +{
> > > > > +	cec_received_msg(connector->cec.adapter, msg);
> > > > > +}
> > > > > +EXPORT_SYMBOL(drm_connector_hdmi_cec_received_msg);
> > > > > +
> > > > > +void drm_connector_hdmi_cec_transmit_attempt_done(struct drm_con=
nector *connector,
> > > > > +						  u8 status)
> > > > > +{
> > > > > +	cec_transmit_attempt_done(connector->cec.adapter, status);
> > > > > +}
> > > > > +EXPORT_SYMBOL(drm_connector_hdmi_cec_transmit_attempt_done);
> > > > > +
> > > > > +void drm_connector_hdmi_cec_transmit_done(struct drm_connector *=
connector,
> > > > > +					  u8 status,
> > > > > +					  u8 arb_lost_cnt, u8 nack_cnt,
> > > > > +					  u8 low_drive_cnt, u8 error_cnt)
> > > > > +{
> > > > > +	cec_transmit_done(connector->cec.adapter, status,
> > > > > +			  arb_lost_cnt, nack_cnt, low_drive_cnt, error_cnt);
> > > > > +}
> > > > > +EXPORT_SYMBOL(drm_connector_hdmi_cec_transmit_done);
> > > > > +
> > > > > +void drm_connector_hdmi_cec_phys_addr_invalidate(struct drm_conn=
ector *connector)
> > > > > +{
> > > > > +	mutex_lock(&connector->cec.mutex);
> > > > > +
> > > > > +	cec_phys_addr_invalidate(connector->cec.adapter);
> > > > > +	cec_notifier_phys_addr_invalidate(connector->cec.notifier);
> > > > > +
> > > > > +	mutex_unlock(&connector->cec.mutex);
> > > > > +}
> > > > > +EXPORT_SYMBOL(drm_connector_hdmi_cec_phys_addr_invalidate);
> > > > > +
> > > > > +void drm_connector_hdmi_cec_phys_addr_set(struct drm_connector *=
connector)
> > > > > +{
> > > > > +	mutex_lock(&connector->cec.mutex);
> > > > > +
> > > > > +	cec_s_phys_addr(connector->cec.adapter,
> > > > > +			connector->display_info.source_physical_address, false);
> > > > > +	cec_notifier_set_phys_addr(connector->cec.notifier,
> > > > > +				   connector->display_info.source_physical_address);
> > > > > +
> > > > > +	mutex_unlock(&connector->cec.mutex);
> > > > > +}
> > > > > +EXPORT_SYMBOL(drm_connector_hdmi_cec_phys_addr_set);
> > > > > diff --git a/include/drm/display/drm_hdmi_cec_helper.h b/include/=
drm/display/drm_hdmi_cec_helper.h
> > > > > new file mode 100644
> > > > > index 0000000000000000000000000000000000000000..cd6274e4ee9b3e41a=
2d85289c4a420b854340e19
> > > > > --- /dev/null
> > > > > +++ b/include/drm/display/drm_hdmi_cec_helper.h
> > > > > @@ -0,0 +1,61 @@
> > > > > +/* SPDX-License-Identifier: MIT */
> > > > > +
> > > > > +#ifndef DRM_DISPLAY_HDMI_CEC_HELPER
> > > > > +#define DRM_DISPLAY_HDMI_CEC_HELPER
> > > > > +
> > > > > +#include <drm/drm_connector.h>
> > > > > +
> > > > > +#include <linux/types.h>
> > > > > +
> > > > > +struct drm_connector;
> > > > > +
> > > > > +struct cec_msg;
> > > > > +struct device;
> > > > > +
> > > > > +struct drm_connector_hdmi_cec_adapter_ops {
> > > > > +	struct drm_connector_cec_funcs base;
> > > > > +
> > > > > +	int (*init)(struct drm_connector *connector);
> > > > > +	void (*uninit)(struct drm_connector *connector);
> > > > > +
> > > > > +	int (*enable)(struct drm_connector *connector, bool enable);
> > > > > +	int (*log_addr)(struct drm_connector *connector, u8 logical_add=
r);
> > > > > +	int (*transmit)(struct drm_connector *connector, u8 attempts,
> > > > > +			u32 signal_free_time, struct cec_msg *msg);
> > > > > +};
> > > >=20
> > > > Why can't we merge drm_connector_cec_funcs and
> > > > drm_connector_cec_adapter_ops? They look equivalent to me?
> > >=20
> > > Well, not exactly. The funcs is a generic interface. Notifiers do not
> > > need the adapter_ops. And cec_pin (sun4i) would also require a differ=
ent
> > > set of callbacks. Thus I decided that it's easier to subclass funcs
> > > instead of adding all possible callbacks there.
> >=20
> > There's two things here: cec_pin and cec_adapter are equivalent. They
> > provide the same feature, but one relies on an hardware controller, the
> > other bitbangs a GPIO. They are also mutually exclusive.
> >=20
> > So I'd very much expect a different set of hooks there.
>=20
> That's the point. Normal CEC adapters would need to implement these
> callbacks. CEC pin adapter will have a different set of callbacks.
> Notifiers do not need any extra callbacks at all.

Sure, and that's true for most of the KMS entities we support. What I
don't get is why that dual layer func structure is needed in the first
place. We have no other entity that works that way, and we typically
solve this using a helper.

Maxime

--yw42zjrvnoz67ryw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ7WiPAAKCRAnX84Zoj2+
dqRlAYDKyvbMvNU7FFsZ28yYD7pORcOa4Z4LiLUoDzS12cyiRyh7hu3RlFc1hl33
VriqP2QBgJzviPfdCfXFCThN9ctad0eX+ROGSvdzssikdExQvXTokH62FgJYcbJK
OL9THcPlDw==
=tGFg
-----END PGP SIGNATURE-----

--yw42zjrvnoz67ryw--

