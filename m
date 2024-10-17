Return-Path: <linux-kernel+bounces-369261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E87449A1AFA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B59BC283D6B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 06:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24AA19409C;
	Thu, 17 Oct 2024 06:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="hQV5lt5m";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="YkO6znv3"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3404192B93
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 06:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729147859; cv=none; b=TKLJdgugUxUj4GK04WhO+X9+X0mCUCHPeY4t7WT9m+vU44OR/5WtJ02lMPNmqRlHhI9EyfyYJMzQKHGNC8crQZgMo0QNNeQz3fhz9HQIPaNNVfx0EUvO47o7auCHhoZJ8ieIKrqoN6HDGoHIHL3/s6678x6V9UL/9JSrboebOW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729147859; c=relaxed/simple;
	bh=14TXucqNvD7mQKvyCwt2zhHYdFZ3+y+5soiHU1J4lT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kxftCJQGGIK/PE9RrnC+dBAKr+lHSpVfDiO05i2SwYt8DN8Rjs0SL71+fZ5Y+rnU8oFuhG4SdxwVEUH4pUEM07Guy1nypIjmOcg+f45vL6qtCN2fe//W+nRp1cmFknY41ZwpGhX8NVjP9zBnNsQTLmgsEH7GK1xbyGh3U+Hkhds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=hQV5lt5m; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=YkO6znv3 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1729147854; x=1760683854;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=14TXucqNvD7mQKvyCwt2zhHYdFZ3+y+5soiHU1J4lT0=;
  b=hQV5lt5maD0Jod7YK0OwY9LKVa28bzd2apSMzXWINztFcGqmEtGRzyB/
   2MahtjlXfAiF6geZRIcB5f4qH6pFLj3qajX7t7OxVkJvpCF3SBzpHY3iO
   l5EkF0Lqh+z6lfJyxM/ygclpQqq1yFqJZL+irYbMUGtMIJwd0USFyeD4q
   ppuqlzTNS093A3VbRUVb5sUgP4B6aoT8B7qvYi3AB1BdRs+D6vbelopPe
   GCbEg2LBhHSCTyD+d7njcCfO6jwNWBq8EtpW4RG7q9qDHWnOmkGvcoXHX
   lyG+X3zHF7CyApb9mComXICAD37KR52Nq5w7MyB5ZtJtly0GnHhPOo3iQ
   w==;
X-CSE-ConnectionGUID: kI8spMonTD+xfmfeFZmDSQ==
X-CSE-MsgGUID: BnRGMezhSU+NRhwUTYGmvw==
X-IronPort-AV: E=Sophos;i="6.11,210,1725314400"; 
   d="scan'208";a="39508951"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 17 Oct 2024 08:50:50 +0200
X-CheckPoint: {6710B3CA-3D-8E59014-E6F31237}
X-MAIL-CPID: 9E28EFEFEF3BC99ED9E1708D756FE10F_1
X-Control-Analysis: str=0001.0A682F27.6710B3CB.0034,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EF256170036;
	Thu, 17 Oct 2024 08:50:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1729147846;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=14TXucqNvD7mQKvyCwt2zhHYdFZ3+y+5soiHU1J4lT0=;
	b=YkO6znv39zDavTSnnLppwOnFNgjBSQQGrdSbDLxqIOU5vsYHgxm4LQcY7L3bpmjW3wTUml
	aY1iRhZI7nUBuT7dOdJPnXgpfNqBAzY+4NXQM6gg9bL2BpE+LBxMNwOIsbO/Ssd186zId5
	ixqpFd9CGsNxpPa5E7YCFKMNhsQQ2M8HU/rC9kBeTlxdOBzPjq64Jy8UMXIFtZbKebvvOO
	7Wkdvmg6KrPSsmxcBRMEN642TnTcTUxcQ3Ok8j63KExQSnx8l5jy7MENFdpzPOwB07/Aan
	biSTf8myNOUw7iV9lbeHpwkOC6Nsdw3d+gN9ZfEDxubDZnoyn2agQ/OwTqHggg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>, David Airlie <airlied@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Daniel Vetter <daniel@ffwll.ch>, Matthias Schiffer <matthias.schiffer@tq-group.com>, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm: fsl-dcu: enable PIXCLK on LS1021A
Date: Thu, 17 Oct 2024 08:50:43 +0200
Message-ID: <2007957.usQuhbGJ8B@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <ovzeljss5uv6rymlbdfjolnjox3dklcv3v2km73gqnh6vejxvg@afhyhfwmt3nf>
References: <20240926055552.1632448-1-alexander.stein@ew.tq-group.com> <2754373.mvXUDI8C0e@steina-w> <ovzeljss5uv6rymlbdfjolnjox3dklcv3v2km73gqnh6vejxvg@afhyhfwmt3nf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi everyone,

Am Freitag, 27. September 2024, 01:13:57 CEST schrieb Dmitry Baryshkov:
> On Thu, Sep 26, 2024 at 04:09:03PM GMT, Alexander Stein wrote:
> > Hi Dmitry,
> >=20
> > Am Donnerstag, 26. September 2024, 08:05:56 CEST schrieb Dmitry Baryshk=
ov:
> > > On Thu, Sep 26, 2024 at 07:55:51AM GMT, Alexander Stein wrote:
> > > > From: Matthias Schiffer <matthias.schiffer@tq-group.com>
> > > >=20
> > > > The PIXCLK needs to be enabled in SCFG before accessing certain DCU
> > > > registers, or the access will hang. For simplicity, the PIXCLK is e=
nabled
> > > > unconditionally, resulting in increased power consumption.
> > >=20
> > > By this description it looks like a fix. What is the first broken
> > > commit? It needs to be mentioned in the Fixes: tag. Or is it hat
> > > existing devices have been enabling SCFG in some other way?
> >=20
> > We discussed this internally and it seems this never worked, unless PIX=
CLK
> > was already enabled in SCFG by a different way, e.g. firmware, etc.
>=20
> My bet was on the firmware, but I never touched Layerscape platforms.
> Anyway,
>=20
> Fixes: 109eee2f2a18 ("drm/layerscape: Add Freescale DCU DRM driver")
> Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Any additional feedback?

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



