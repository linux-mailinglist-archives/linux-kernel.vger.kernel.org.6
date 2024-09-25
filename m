Return-Path: <linux-kernel+bounces-338198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E849854A6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35E8C1F21B0C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AD7157A67;
	Wed, 25 Sep 2024 07:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=steffen.cc header.i=@steffen.cc header.b="m5qm48j9"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5811C155CB3
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727250870; cv=none; b=Rs6Rl+uApj0CJMrltu+C0Af28Lswa3YNFFjixSTtS8ZeTmmHj3Z9bFMYYBK2IUqMkSEn3H+8KXV70C6MWSpANG/124OmKpp30krMYMflOD9mMG4cujVGj9HUn9TOGH+281fnEexmPocHyoZFRFJoMtdGCZbziCx2m0i4auxQE+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727250870; c=relaxed/simple;
	bh=lA6/5zwGPFNBcfo1VTOuVyd7se1n2LRgOLgtBRl17jQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DBh8s6X9XU+zN3nd5YLfMLKg9UDoxMUh989NSmkiQfQRAdNIphAWLDwoz5iYpCijh470GQJ29uV3k7pK2GFotcKiqAIBxgXkDMxIG1pMc2XNCTlGaKZrvfdzFTPTmC9U6+5cnFJt4pOF0oBXjBI88PcsXVLcsFFKS2Ult78l6Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc; spf=pass smtp.mailfrom=steffen.cc; dkim=pass (2048-bit key) header.d=steffen.cc header.i=@steffen.cc header.b=m5qm48j9; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=steffen.cc
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4XD8Bm35cZz9v4R;
	Wed, 25 Sep 2024 09:54:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001;
	t=1727250864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ssNsTClmvzZGt7dAiZekgw2sOzzp7SvRTXHsAhVGRrA=;
	b=m5qm48j9NVXvUlqcaEFs1InzyvnLErovyyiYxbLOJMvGrhSi+Ygblqlpzo+flUkc1qaD4N
	O5hPCIPNN2DZJl86hgyWD85IIWtRn5vGbI11Fst2wK+CDFQCD+MDz5iRfoDaYBTfjrcbTF
	aZ6+IV31xFHYV/qT5tCD5gM7DnE/WQ6zB7FQ9xuscjBVpumfzhiJgb1ESidwnl2m7NBQmA
	pRlgWpywZi0EfdSAfxYoR+5+r32bG+R2xnpTLwLtEVwdDZwVmfJ63mITK9obBQ+4/9KmHP
	IFAGHcxINj1MkpH0keea3NMDUtaGg7ZJuKCvNx61YJh/0k0N2bfp6UhR7VM2Wg==
Message-ID: <e4626c1d3b28613d1d219c735bcd8525be0f0d9e.camel@dirkwinkel.cc>
Subject: Re: [PATCH] drm: xlnx: zynqmp_dpsub: also call
 drm_helper_hpd_irq_event
From: Steffen Dirkwinkel <lists@steffen.cc>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Michal Simek <michal.simek@amd.com>,
 linux-arm-kernel@lists.infradead.org, 	linux-kernel@vger.kernel.org
Date: Wed, 25 Sep 2024 09:54:18 +0200
In-Reply-To: <20240924184335.GJ30551@pendragon.ideasonboard.com>
References: <20240923074803.10306-1-lists@steffen.cc>
	 <20240924184335.GJ30551@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Laurent,

On Tue, 2024-09-24 at 21:43 +0300, Laurent Pinchart wrote:
> Hi Steffen,
>=20
> Thank you for the patch.
>=20
> On Mon, Sep 23, 2024 at 09:48:03AM +0200, lists@steffen.cc=C2=A0wrote:
> > From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> >=20
> > With hpd going through the bridge as of commit eb2d64bfcc17
> > ("drm: xlnx: zynqmp_dpsub: Report HPD through the bridge")
> > we don't get hotplug events in userspace on zynqmp hardware.
> > Also sending hotplug events with drm_helper_hpd_irq_event works.
>=20
> Why does the driver need to call both drm_helper_hpd_irq_event() and
> drm_bridge_hpd_notify() ? The latter should end up calling
> drm_kms_helper_connector_hotplug_event(), which is the same function
> that drm_helper_hpd_irq_event() calls.

I don't know why we need drm_helper_hpd_irq_event.
I'll try to trace what happens on hotplug.

>=20
> > Fixes: eb2d64bfcc17 ("drm: xlnx: zynqmp_dpsub: Report HPD through
> > the bridge")
> > Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> > ---
> > =C2=A0drivers/gpu/drm/xlnx/zynqmp_dp.c | 4 ++++
> > =C2=A01 file changed, 4 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> > b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> > index 1846c4971fd8..cb823540a412 100644
> > --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> > +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> > @@ -17,6 +17,7 @@
> > =C2=A0#include <drm/drm_fourcc.h>
> > =C2=A0#include <drm/drm_modes.h>
> > =C2=A0#include <drm/drm_of.h>
> > +#include <drm/drm_probe_helper.h>
> > =C2=A0
> > =C2=A0#include <linux/clk.h>
> > =C2=A0#include <linux/delay.h>
> > @@ -1614,6 +1615,9 @@ static void zynqmp_dp_hpd_work_func(struct
> > work_struct *work)
> > =C2=A0					=C2=A0=C2=A0=C2=A0 hpd_work.work);
> > =C2=A0	enum drm_connector_status status;
> > =C2=A0
> > +	if (dp->bridge.dev)
> > +		drm_helper_hpd_irq_event(dp->bridge.dev);
> > +
> > =C2=A0	status =3D zynqmp_dp_bridge_detect(&dp->bridge);
> > =C2=A0	drm_bridge_hpd_notify(&dp->bridge, status);
> > =C2=A0}
>=20


