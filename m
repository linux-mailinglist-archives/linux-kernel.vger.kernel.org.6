Return-Path: <linux-kernel+bounces-185175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0E08CB192
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 17:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AA7D1F212FE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66D6147C8B;
	Tue, 21 May 2024 15:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="JuM6Mlq6"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7943F78289;
	Tue, 21 May 2024 15:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716306140; cv=none; b=HTerAZO6BsO8MMzxQlicLfVhRtXHyQaWCfTDEp0PYIyiqpxOAvQTlYl1hb4Yu/72myirwD+yGjbffXzWd4Jz/LbxdygIk9+W9H7jJ3DkIEI/axY6OI0VrdXbT0ihzXsbZOnzWhlg3j2LwXo6gsVaZfuhgTpfqpdeFZQHG6XxiwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716306140; c=relaxed/simple;
	bh=Wzp8U0x/I8sGmZ5v/VZqkhRsn4w7093y01qjtT5BQdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upfO6ciahF3SgS7lDo64H2eBY1KI80vK5HmaKEb/xABNqHyx8L0wHdSf9VlB9iWHCdXZ0EQq3oT7T9yuXZigplBoWynJQmuG5bl9oVRSO/tcKLXlqRs74tjqnym3YFV9ZZWVpbaU6wKfA6FzhkBQqRn0uU/lHsy9ZFut1yAZq10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=JuM6Mlq6; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 79F6B150E;
	Tue, 21 May 2024 17:42:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1716306123;
	bh=Wzp8U0x/I8sGmZ5v/VZqkhRsn4w7093y01qjtT5BQdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JuM6Mlq6qkbWUBlomT3fhYWQw85C4s/iyTLpdoHctqBE+5nX7ed3B7ex5fQaTH4JP
	 Jil01J72OrOnEQQ04CD/Oh3TZ+6njSW2CUb0ELZHyladV5LGdOqrdovSGvJ/1Is/AI
	 wzx5/eY0MIlhDJQ3SJJXwCG0gFrvC8TFkrz2vKTs=
Date: Tue, 21 May 2024 18:42:06 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Alex Bee <knaerzche@gmail.com>
Cc: keith <keith.zhao@starfivetech.com>, andrzej.hajda@intel.com,
	neil.armstrong@linaro.org, rfoss@kernel.org, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	daniel@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, hjc@rock-chips.com, heiko@sntech.de,
	andy.yan@rock-chips.com, xingyu.wu@starfivetech.com,
	p.zabel@pengutronix.de, jack.zhu@starfivetech.com,
	shengyang.chen@starfivetech.com, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 02/10] drm/bridge: add common api for inno hdmi
Message-ID: <20240521154206.GA1935@pendragon.ideasonboard.com>
References: <20240521105817.3301-1-keith.zhao@starfivetech.com>
 <20240521105817.3301-3-keith.zhao@starfivetech.com>
 <58ddfc8f-1995-4f41-9d63-35a00c6f92b9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <58ddfc8f-1995-4f41-9d63-35a00c6f92b9@gmail.com>

On Tue, May 21, 2024 at 05:36:43PM +0200, Alex Bee wrote:
> Hi Keith,
> 
> thanks a lot for working on this. See some general remarks below
>
> Am 21.05.24 um 12:58 schrieb keith:
> > Add INNO common api so that it can be used by vendor
> > drivers which implement vendor specific extensions to Innosilicon HDMI.
> > 
> > Signed-off-by: keith <keith.zhao@starfivetech.com>
> > ---
> >   MAINTAINERS                                   |   2 +
> >   drivers/gpu/drm/bridge/Kconfig                |   2 +
> >   drivers/gpu/drm/bridge/Makefile               |   1 +
> >   drivers/gpu/drm/bridge/innosilicon/Kconfig    |   6 +
> >   drivers/gpu/drm/bridge/innosilicon/Makefile   |   2 +
> >   .../gpu/drm/bridge/innosilicon/inno-hdmi.c    | 587 ++++++++++++++++++
> >   .../gpu/drm/bridge/innosilicon/inno-hdmi.h    |  97 +++
> >   include/drm/bridge/inno_hdmi.h                |  69 ++
> >   8 files changed, 766 insertions(+)
> >   create mode 100644 drivers/gpu/drm/bridge/innosilicon/Kconfig
> >   create mode 100644 drivers/gpu/drm/bridge/innosilicon/Makefile
> >   create mode 100644 drivers/gpu/drm/bridge/innosilicon/inno-hdmi.c
> >   create mode 100644 drivers/gpu/drm/bridge/innosilicon/inno-hdmi.h
> >   create mode 100644 include/drm/bridge/inno_hdmi.h
> > 
> ....
> 
> > +	drm_encoder_helper_add(encoder, pdata->helper_private);
> > +
> > +	hdmi->connector.polled = DRM_CONNECTOR_POLL_HPD;
> > +
> > +	drm_connector_helper_add(&hdmi->connector,
> > +				 &inno_hdmi_connector_helper_funcs);
> > +
> > +	drmm_connector_init(drm, &hdmi->connector,
> > +			    &inno_hdmi_connector_funcs,
> > +			    DRM_MODE_CONNECTOR_HDMIA,
> > +			    hdmi->ddc);
> > +
>
> I really don't want to anticipate bridge maintainer's feedback, but new
> bridge drivers must not contain connector creation. That must happen
> somewhere else.

You're absolutely right :-) Connector creation should be handled by the
drm_bridge_connector helper. The HDMI bridge driver should focus on the
HDMI bridge itself.

> Also I'm neither seeing any drm_brige struct nor drm_bridge_funcs, which
> are both essential for a bridge driver. I don't think moving a part of a
> driver to .../drm/bridge/ makes it a bridge driver.
> 
> > +	drm_connector_attach_encoder(&hdmi->connector, encoder);
> > +
> > +	return 0;
> > +}
> > +
> ....
> 

-- 
Regards,

Laurent Pinchart

