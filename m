Return-Path: <linux-kernel+bounces-357212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52674996DBA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8414E1C22922
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D74019CC28;
	Wed,  9 Oct 2024 14:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=steffen.cc header.i=@steffen.cc header.b="htxa8GaF"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3816199223
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 14:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484124; cv=none; b=T2Zwf1DnfuemssW73iK9XEbwpKYKR4RHzOKoHM3eub7nBM0iTScJpz1pN4FFMKDD1iyAcggnGO/lPE3HNgqsRbPC7MqlBi//4ZvWQagd0Q9IUhAnPG77GGt57CYLmropSZEtV2Qydb4qxjFotyL/wStLbVbIoZtgVbAMp7mvDHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484124; c=relaxed/simple;
	bh=p1+zJOK0RySBpmFxUzGGyR7IdTkkXdAdLhpirbgDoTM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AtGl2zKYKOrx8MCE7hG9e+WB0udlbL+77Hir5KSLDTdKNfsRTfaMtmtb+NQQnkt0k9UO9rhz+9yogDYaXnNv1Dx7lACwY2F8nUJxkP3k2c2Qd69vo54Di/q09noNvSwMcOraPA/gTavjZHsyuYmnv0iNJZsTGivzjufLiozTvlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc; spf=pass smtp.mailfrom=steffen.cc; dkim=pass (2048-bit key) header.d=steffen.cc header.i=@steffen.cc header.b=htxa8GaF; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=steffen.cc
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4XNwH45pCSz9tq8;
	Wed,  9 Oct 2024 16:28:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001;
	t=1728484112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S9X+8ZyEQbtZszzxAfza7S2bdTj+xeELPNcL6Rxa/6Y=;
	b=htxa8GaF6d3gam0/0BEsS0285p/vTzFi318zjTLhoC6ezinB/nGZusCoeG7XQvKu8OEEP4
	9jTAdAz3YzoUMCT9DL6RxRK8FOt9+eTZ9sPJz/CP0+4zDtMTM+ioq4p1LGdx4YLU8P84rc
	Nh+pCICsNb5D80wv52jYHzBm5eCkm/roAnggmoVPl8MBIXhBEvQSJnTfmO+da34ay4sgy8
	eWS+9inIAaPytDl9HME8AdsEvysUmR7Q0/NTzaDrOiI9RKwNlm92J//3WsamogqHFzm2JW
	cTomXrv+IEUrRXuKK9ICkz2rkCJomzYenOVFvdcITYcRzkYpiBaK+XQneJ4mbg==
Message-ID: <6cea659387e14f0436105053416a42c4729923b3.camel@dirkwinkel.cc>
Subject: Re: [PATCH] drm: xlnx: zynqmp_dpsub: also call
 drm_helper_hpd_irq_event
From: Steffen Dirkwinkel <lists@steffen.cc>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Michal Simek <michal.simek@amd.com>,
 linux-arm-kernel@lists.infradead.org, 	linux-kernel@vger.kernel.org
Date: Wed, 09 Oct 2024 16:28:26 +0200
In-Reply-To: <20240925163609.GD27666@pendragon.ideasonboard.com>
References: <20240923074803.10306-1-lists@steffen.cc>
	 <20240924184335.GJ30551@pendragon.ideasonboard.com>
	 <e4626c1d3b28613d1d219c735bcd8525be0f0d9e.camel@dirkwinkel.cc>
	 <20240925163609.GD27666@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Laurent,


On Wed, 2024-09-25 at 19:36 +0300, Laurent Pinchart wrote:
> Hi Steffen,
>=20
> On Wed, Sep 25, 2024 at 09:54:18AM +0200, Steffen Dirkwinkel wrote:
> > On Tue, 2024-09-24 at 21:43 +0300, Laurent Pinchart wrote:
> > > On Mon, Sep 23, 2024 at 09:48:03AM +0200, lists@steffen.cc=C2=A0wrote=
:
> > > > From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> > > >=20
> > > > With hpd going through the bridge as of commit eb2d64bfcc17
> > > > ("drm: xlnx: zynqmp_dpsub: Report HPD through the bridge")
> > > > we don't get hotplug events in userspace on zynqmp hardware.
> > > > Also sending hotplug events with drm_helper_hpd_irq_event
> > > > works.
> > >=20
> > > Why does the driver need to call both drm_helper_hpd_irq_event()
> > > and
> > > drm_bridge_hpd_notify() ? The latter should end up calling
> > > drm_kms_helper_connector_hotplug_event(), which is the same
> > > function
> > > that drm_helper_hpd_irq_event() calls.
> >=20
> > I don't know why we need drm_helper_hpd_irq_event.
> > I'll try to trace what happens on hotplug.
>=20
> Thank you. Let's try to find the best solution based on your
> findings.

There's just nothing registering for hpd with
"drm_bridge_connector_enable_hpd" or "drm_bridge_hpd_enable". I'm not
sure what the correct way to implement this is. In
"drivers/gpu/drm/bridge/ti-tfp410.c" the driver registers for the
callback and calls "drm_helper_hpd_irq_event" in the callback. I guess
we could also do that, but then we might as well call
drm_helper_hpd_irq_event directly? Some other drivers just call both
like I did here. (drivers/gpu/drm/mediatek/mtk_hdmi.c for example)
For "drivers/gpu/drm/msm/hdmi/hdmi_bridge.c" I also can't find the hpd
enable call and it just calls drm_bridge_hpd_notify.

>=20
> > > > Fixes: eb2d64bfcc17 ("drm: xlnx: zynqmp_dpsub: Report HPD
> > > > through
> > > > the bridge")
> > > > Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> > > > ---
> > > > =C2=A0drivers/gpu/drm/xlnx/zynqmp_dp.c | 4 ++++
> > > > =C2=A01 file changed, 4 insertions(+)
> > > >=20
> > > > diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> > > > b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> > > > index 1846c4971fd8..cb823540a412 100644
> > > > --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> > > > +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> > > > @@ -17,6 +17,7 @@
> > > > =C2=A0#include <drm/drm_fourcc.h>
> > > > =C2=A0#include <drm/drm_modes.h>
> > > > =C2=A0#include <drm/drm_of.h>
> > > > +#include <drm/drm_probe_helper.h>
> > > > =C2=A0
> > > > =C2=A0#include <linux/clk.h>
> > > > =C2=A0#include <linux/delay.h>
> > > > @@ -1614,6 +1615,9 @@ static void
> > > > zynqmp_dp_hpd_work_func(struct
> > > > work_struct *work)
> > > > =C2=A0					=C2=A0=C2=A0=C2=A0 hpd_work.work);
> > > > =C2=A0	enum drm_connector_status status;
> > > > =C2=A0
> > > > +	if (dp->bridge.dev)
> > > > +		drm_helper_hpd_irq_event(dp->bridge.dev);
> > > > +
> > > > =C2=A0	status =3D zynqmp_dp_bridge_detect(&dp->bridge);
> > > > =C2=A0	drm_bridge_hpd_notify(&dp->bridge, status);
> > > > =C2=A0}
>=20


