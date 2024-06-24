Return-Path: <linux-kernel+bounces-227015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C256C914733
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45A52284913
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3107913699B;
	Mon, 24 Jun 2024 10:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q1PUwlGG"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C005C45007
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 10:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719224260; cv=none; b=V+4Nzff0XkWUU8pHQ/LP75oXOUeHtovLiHF+5u5UbgZgLwbBUPWMi400oif0D2ffBmhMZlGbyyRXVsLXz8VrNzy9lopRvnYeo951SqFXjDN5EYTFf5C4Zf7iEH0EmEZ8eYdSw4WyZFIwgu1PpgRriaBfd2j+aTYwfrBFPJNT2rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719224260; c=relaxed/simple;
	bh=1tFkxCOl2AtRnMPljD72E4KvTy6798xk6vqR8AzvDaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkvYgefOyWj1PgCnHcgq3kKnDMOFXKjfHRaNaSWJOMM4Co//uSVoALimgnRMebf40XGKN6PfM1DPqQcs8MPuT72fy5x85gVPcp1HmDYiF/cBecHvf+TMAFyCMu8hoTcNycOJH3bEk4Yd7Eh0eRU5TH4gLTFDA3e9UqIR+D2WAXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q1PUwlGG; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso4234917276.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 03:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719224257; x=1719829057; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vUnYL6350uvLvpXQOz7TGB6F6PC3tYw8CCvE8SQ6B6w=;
        b=q1PUwlGGq7iw5HxDtDi9R48oaAQybnK06Rf97nVGyDTDUK0b+ptRu8W3rL+5VTvu83
         a+90RCxjxF5E4/agXSiyIL4VSZKi7VWDE1i4AdIRNeUvJAcpQhJfHdfXPzLYm3lCe7t2
         w+OkJ1feu4OF+XYsCoy1KT8+V4XKt9P5BAFVhogLvSh6Uymp1+goO8WQqyqs+/XoL994
         ed/NxNsBshVVUV4c6YBaLjFRO12m7e+quMcVTr6ueWLpDqpwqO3naYMatE0J7fzHBNmz
         dS2l+dvwyptAoBy3N57keleIQl9G1AIigXg/cRUjCU5+a2JjH9qmLZcA9mrntRV0TcoV
         9cSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719224258; x=1719829058;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vUnYL6350uvLvpXQOz7TGB6F6PC3tYw8CCvE8SQ6B6w=;
        b=SiHHZPtTRUS+pZpkirMILrwyR24NkRLJOO89r4fONCTXjMqfGpdnNxLN6QbC9hwyZV
         0DRDrFBISvO/va/Mhm2lCSwxVeDksiiH+YB5sA/9WJXcJ8bbveunHTe9jxPKS7cGxQZ4
         BYYZJV14N6BX5AV1gp3RB76Nn7LoOuySFKYuPfpRqnqVyqznZe212/fEveePFT0c6p/A
         sougbUFeIefM6h78cn7RbsmOb10whWTi8ObYF6Qncyo+wiY766+A4wnGZ3/ALcISVAyl
         j0wm320z2xeigQEpBGqssXVi56MDrb++8GqxycSIkQXIm3wdwCbAL9JYnbE2sBuvCl9I
         SYXA==
X-Forwarded-Encrypted: i=1; AJvYcCVeqY34Z4g3D7EbSjISNMqgTJyB77MP/f5NOPPq5O7CQXh+WFf69lSw8N2pBaSz83M7BZNz0raQtTqfONUXuqdJPlhgX+eisofHtThx
X-Gm-Message-State: AOJu0YxxLkNnh/A+lMUPCB+cU1xCnxgh4pholYc2SGi0oV4pAO+Pnm8E
	2J5bTg51+rhJI1tLoSSZL2x6ksniHMTVuZ+MSsWZID6ZvMF2A1Do5nhszCoLS0de4OgRhqzHGa0
	oGIBZ4XSJAmdLP2LsE9HlhDfWPErl+o28fDQ+cA==
X-Google-Smtp-Source: AGHT+IGHCrsaJn4UJSwOAywZ6sIOs5EfneQ7TVv2PZFVPwWMgY8MyAP5KeyCgl4NOrBBkLjhx4ku/+cii2XWsg663dQ=
X-Received: by 2002:a25:2104:0:b0:e02:6efa:a434 with SMTP id
 3f1490d57ef6-e02fc34f31dmr4025494276.43.1719224257573; Mon, 24 Jun 2024
 03:17:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f6af46e0-aadb-450a-9349-eec1337ea870@ti.com> <b221c978-2ce0-4d31-8146-ab43a9f86a1f@ti.com>
 <st6vgd2k6dxo4vd3pmqmqlc5haofhbym2jeb2eeh2pa2n6zcca@tradpzxrzexl> <2469374.jE0xQCEvom@steina-w>
In-Reply-To: <2469374.jE0xQCEvom@steina-w>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 24 Jun 2024 13:17:25 +0300
Message-ID: <CAA8EJpraKjBZRLL5U+BVQRf98_EBa5b=nSPxZATU+yvvq9Kfmw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm/bridge: tc358767: Fix DRM_BRIDGE_ATTACH_NO_CONNECTOR
 case
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Aradhya Bhatia <a-bhatia1@ti.com>, dri-devel@lists.freedesktop.org, 
	Jan Kiszka <jan.kiszka@siemens.com>, Marek Vasut <marex@denx.de>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Jun 2024 at 13:07, Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Hi,
>
> Am Montag, 24. Juni 2024, 11:49:04 CEST schrieb Dmitry Baryshkov:
> > On Mon, Jun 24, 2024 at 03:07:10PM GMT, Aradhya Bhatia wrote:
> > >
> > >
> > > On 22/06/24 17:49, Dmitry Baryshkov wrote:
> > > > On Sat, Jun 22, 2024 at 05:16:58PM GMT, Aradhya Bhatia wrote:
> > > >>
> > > >>
> > > >> On 17-Jun-24 13:41, Dmitry Baryshkov wrote:
> > > >>> On Mon, Jun 17, 2024 at 07:40:32AM GMT, Jan Kiszka wrote:
> > > >>>> On 16.02.24 15:57, Marek Vasut wrote:
> > > >>>>> On 2/16/24 10:10, Tomi Valkeinen wrote:
> > > >>>>>> Ok. Does anyone have a worry that these patches make the situation
> > > >>>>>> worse for the DSI case than it was before? Afaics, if the DSI lanes
> > > >>>>>> are not set up early enough by the DSI host, the driver would break
> > > >>>>>> with and without these patches.
> > > >>>>>>
> > > >>>>>> These do fix the driver for DRM_BRIDGE_ATTACH_NO_CONNECTOR and DPI, so
> > > >>>>>> I'd like to merge these unless these cause a regression with the DSI
> > > >>>>>> case.
> > > >>>>>
> > > >>>>> 1/2 looks good to me, go ahead and apply .
> > > >>
> > > >> Isn't there any way for the second patch to move forward as well though?
> > > >> The bridge device (under DPI to (e)DP mode) cannot really work without
> > > >> it, and the patches have been pending idle for a long time. =)
> > > >>
> > > >>>>
> > > >>>> My local patches still apply on top of 6.10-rc4, so I don't think this
> > > >>>> ever happened. What's still holding up this long-pending fix (at least
> > > >>>> for our devices)?
> > > >>>
> > > >>> Neither of the patches contains Fixes tags. If the first patch fixes an
> > > >>> issue in previous kernels, please consider following the stable process.
> > > >>>
> > > >>> If we are unsure about the second patch, please send the first patch
> > > >>> separately, adding proper tags.
> > > >>>
> > > >>
> > > >> Thanks Dmitry! I can send the patches again with the required fixes
> > > >> tags (or just patch-1 if we cannot do anything about patch-2).
> > > >
> > > > The problem with the second patch is that it get mixed reviews. I can
> > > > ack the first patch, but for the second one I'd need a confirmation from
> > > > somebody else. I'll go on and apply the first patch later today.
> > > >
> > >
> > > Thanks Dmitry!
> > >
> > > However, would it be okay if I instead add another patch that makes 2
> > > versions of the "tc_edp_bridge_funcs", say "tc_dpi_edp_bridge_funcs" and
> > > "tc_dsi_edp_bridge_funcs", that have all the same function hooks except
> > > for the .edid_read()?
> > >
> > > The dsi edid_read() will remain the same, and Tomi's patch - patch 2/2 -
> > > will only fix the dpi version of the edid_read()?
> > >
> > > The bridge already has the capability to distinguish a DSI input from a
> > > DPI input. This can be leveraged to decide which set of functions need
> > > to be used without any major changes.
> >
> > I'd prefer if somebody with the DSI setup can ack / test the second
> > patch.
> >
> >
>
> Now that my DSI-DP setup works apparently without issue I could test patch 2.
> Since my setup does not use DRM_BRIDGE_ATTACH_NO_CONNECTOR (running on
> drivers/gpu/drm/mxsfb/lcdif_drv.c), I can only say
> there is no regression.

Let me send a (non-tested) patch, switching to drm_bridge_connector,
then you can probably test both of them


-- 
With best wishes
Dmitry

