Return-Path: <linux-kernel+bounces-340552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 453A198751F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB91B1F22F60
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162998248C;
	Thu, 26 Sep 2024 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="gQO8PtmS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="OPWxx9X4"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFCB2E3F7
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 14:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727359760; cv=none; b=s0pngLZTdaYISqBia62OHnWqxx4PNaWy5Nnp4S5DVjUgjT2XUij9PiQWVsXRFsfJefBcYWpXWRbUz1R1OyMC4OXt+XqPoKbzKWA8oTeuAl8i2icGOTIoPB0TUslAJCNpMaiiqH6BKNSw2t3P9YgK37ic90lMYUc79EHFpraiPk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727359760; c=relaxed/simple;
	bh=aU7DhuM0MRl/oleJUgNjJ5QLB7b0wpiBWF3UI3tBfO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kG4vGs7+u9rTfWgb4/cpblH63AusMDtSLzGXoEySpkhygXTrnOGzVMyVExmJ9JJeOVlacOy9rWMLMhutM5eCXPNodo8YtZTVzVVCtyPhnYL14L+y9ADYBYO9Ls/1k7veV0AI/UKsz7d92rNScMJWdyMkMcTAc+lyskrOCXgyyH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=gQO8PtmS; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=OPWxx9X4 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1727359756; x=1758895756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aU7DhuM0MRl/oleJUgNjJ5QLB7b0wpiBWF3UI3tBfO8=;
  b=gQO8PtmSUyyNyCM18jEsr1uenVrnYMemasRy5qTZCYTjXpzelRbRPFII
   Ir3YVL1m1nMtIS2D96Rv3lWbG4myvT3sTBss0qRqqsiUyQBQKlO1WDgXE
   kiNTV3TJDRszjeCTqLMoyhPKtidnqaIJL/4igfz5hy8JOZPjl3uSZ+GPW
   STA0vXYPSTBXrABdv1Qpa2BvHZn/X9Bcr1zKBgbJmoSvLl/lNd0fzn/WJ
   mcWHHNIU1dA+U2ohF79co7J6HCPvPICAUWCnylKv/KUH+nIfYvolkyGgP
   qBLiHMrUeYeebyTFlKXml4Q8+iqH1qqrCeq1g7/5PE/CLRkbb+7eiK4Pw
   g==;
X-CSE-ConnectionGUID: WesfB8g6TUKNOiDFyfVYYQ==
X-CSE-MsgGUID: oLILoqlWRbGX4q8dhpshqw==
X-IronPort-AV: E=Sophos;i="6.11,155,1725314400"; 
   d="scan'208";a="39145675"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 26 Sep 2024 16:09:11 +0200
X-CheckPoint: {66F56B07-1-B62731C4-FB8D8F8A}
X-MAIL-CPID: 52217610F519004650615E3A9DFC3094_3
X-Control-Analysis: str=0001.0A682F20.66F56B07.00CA,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 965B4163464;
	Thu, 26 Sep 2024 16:09:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1727359746;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=aU7DhuM0MRl/oleJUgNjJ5QLB7b0wpiBWF3UI3tBfO8=;
	b=OPWxx9X4ANG+tfcreBmeS7UkQnvUB8Tdyb3lXfCasPbyVNlo51xaTvZixvroKUOUzmSLZt
	Nm7+NU9S8+iOyDJlYY5c9MWNMr+aB9kcNGz+szuokdlhPEg9e+fJz/NyVlZcysPfnTAxCG
	vJ8A/goAltjeIWEB5wUW8hAZLK0BNpTGlS+SErUZcIa+6WMiBKNgDcwdl5hGoyOPK1VvHb
	yVwwrnz3tfNIcdfvv98iPWHJQw8E46dip1xZRbKUCnwZHmhqoHEFyimeIN6azYSLxPTMtz
	DVZvlFI+hrz5tGHoTSVQ9LstuT+rS7979zREacLyehfrn0HJYWU+RmQq2LuV3Q==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Matthias Schiffer <matthias.schiffer@tq-group.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm: fsl-dcu: enable PIXCLK on LS1021A
Date: Thu, 26 Sep 2024 16:09:03 +0200
Message-ID: <2754373.mvXUDI8C0e@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <tosilxaxfg6hejtqs2fslf6ez5pdg5yxj776pohmodja3bn5jp@4jbdprx52fqx>
References: <20240926055552.1632448-1-alexander.stein@ew.tq-group.com> <20240926055552.1632448-2-alexander.stein@ew.tq-group.com> <tosilxaxfg6hejtqs2fslf6ez5pdg5yxj776pohmodja3bn5jp@4jbdprx52fqx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi Dmitry,

Am Donnerstag, 26. September 2024, 08:05:56 CEST schrieb Dmitry Baryshkov:
> On Thu, Sep 26, 2024 at 07:55:51AM GMT, Alexander Stein wrote:
> > From: Matthias Schiffer <matthias.schiffer@tq-group.com>
> >=20
> > The PIXCLK needs to be enabled in SCFG before accessing certain DCU
> > registers, or the access will hang. For simplicity, the PIXCLK is enabl=
ed
> > unconditionally, resulting in increased power consumption.
>=20
> By this description it looks like a fix. What is the first broken
> commit? It needs to be mentioned in the Fixes: tag. Or is it hat
> existing devices have been enabling SCFG in some other way?

We discussed this internally and it seems this never worked, unless PIXCLK
was already enabled in SCFG by a different way, e.g. firmware, etc.

Best regards,
Alexander

> >=20
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@tq-group.com>
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> > Changes in v2:
> > * Add note about power consumption in commit message
> > * Add note about power consumption in comment
> > * Fix alignment
> >=20
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



