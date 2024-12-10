Return-Path: <linux-kernel+bounces-439750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B64439EB382
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74EF4162BC8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8164C1B219F;
	Tue, 10 Dec 2024 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="apGYPtk9"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F61C1AA1FD;
	Tue, 10 Dec 2024 14:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841417; cv=none; b=cRkih6HYCPfCaGa706fVBbebf/E1PSlQp1Ki1RM6GJ4fEBRFIuSoV4MBtqSrwmiTFaYWftQKp2bJlGlvvTSpZ4xonLNCsIrxtqcAjp20P/rvO+/8RDnKplaEZxHUjW7Ld0+miPgJXGApBYB2fq03nPft7NUCmA9+zEr2Z6aq+JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841417; c=relaxed/simple;
	bh=Vm/SMvu/8EpKkDOC/meueBC9lfWEJCHJn3wNu3oS+nU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Asl87HwZHhhMZ97wBzIeivOUvyiCGAunmA5X6NoDPsErX/psp2/77boJtoToLmHdiYnn8YHKYali1uRfYyLsyhxl/3J+gcw8wr8JtbVsvTBhWaKWh0b8CKGPBRABqAkjZAHlA+Zgv8ZroX4NbaoBTRQImCeHB+e2WjAKC8bmUtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=apGYPtk9; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Vm/SMvu/8EpKkDOC/meueBC9lfWEJCHJn3wNu3oS+nU=; b=apGYPtk9B8cEHvRnlKnZRfyPlB
	UjU0n9BxnezEUSJl9xr/rIS3CAWGyApMVmPm35fTQfK9Lg1qjH1CqrI3pEIUsgAH3IAqgLHXpIi+5
	1Rn2C4tjKDlVc/d7X34Zq4zZ6HCNJYmUb07z1nntcDroUOFxB3djTFTLeug2S0rRYOYXLX1VKG3d7
	wnlxrVKNe5R4q/9/UANNYjy5aP2n7mEi9uoUgwPSQFTqN5FNCUlgEBz+0dey58QWAUnSOtLtS+W6w
	sowpUyWKnenxm2NVdRvHK4tS7iOstRm1QAWChyc+OKiUkXA6I87nkF1VdHmwPKgZxU/V0Fy5rB84E
	//ZQ2gsg==;
Received: from i53875bc4.versanet.de ([83.135.91.196] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tL1Lk-0006dG-TS; Tue, 10 Dec 2024 15:36:32 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Andy Yan <andyshrk@163.com>
Cc: Daniel Semkowicz <dse@thaumatec.com>,
 Diederik de Haas <didi.debian@cknow.org>, andy.yan@rock-chips.com,
 Laurent.pinchart@ideasonboard.com, andrzej.hajda@intel.com,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, jernej.skrabec@gmail.com, jonas@kwiboo.se,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 neil.armstrong@linaro.org, quentin.schulz@cherry.de, rfoss@kernel.org,
 robh@kernel.org, tzimmermann@suse.de
Subject:
 Re: [PATCH v3 0/3] drm/rockchip: Add driver for the new DSI2 controller
Date: Tue, 10 Dec 2024 15:36:31 +0100
Message-ID: <3104907.xgJ6IN8ObU@diego>
In-Reply-To: <78e7b8e.b5ee.193b09ce46d.Coremail.andyshrk@163.com>
References:
 <20241203165450.1501219-1-heiko@sntech.de>
 <jl5obi7rd4h6ywozeqruxq2vx62sx5yf4wwpksrq3prdleps2k@d3zbr5ttquvn>
 <78e7b8e.b5ee.193b09ce46d.Coremail.andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

Am Dienstag, 10. Dezember 2024, 13:48:12 CET schrieb Andy Yan:
> =E5=9C=A8 2024-12-10 20:32:03=EF=BC=8C"Dmitry Baryshkov" <dmitry.baryshko=
v@linaro.org> =E5=86=99=E9=81=93=EF=BC=9A
> >On Tue, Dec 10, 2024 at 09:54:09AM +0800, Andy Yan wrote:
> >> =E5=9C=A8 2024-12-10 09:45:11=EF=BC=8C"Dmitry Baryshkov" <dmitry.barys=
hkov@linaro.org> =E5=86=99=E9=81=93=EF=BC=9A
> >> >On Tue, 10 Dec 2024 at 03:22, Andy Yan <andyshrk@163.com> wrote:
> >> >> =E5=9C=A8 2024-12-10 09:01:38=EF=BC=8C"Dmitry Baryshkov" <dmitry.ba=
ryshkov@linaro.org> =E5=86=99=E9=81=93=EF=BC=9A
> >> >> >On Tue, Dec 10, 2024 at 08:50:51AM +0800, Andy Yan wrote:
> >> >> >> At 2024-12-10 07:12:26, "Heiko St=C3=BCbner" <heiko@sntech.de> w=
rote:
> >> >> >> >Am Montag, 9. Dezember 2024, 17:11:03 CET schrieb Diederik de H=
aas:
> >> >> >> >> On Mon Dec 9, 2024 at 4:06 PM CET, Daniel Semkowicz wrote:
> >> >> >> >> > On 03.12.24 21:54, Heiko Stuebner wrote:
> >> >> >> >This really sounds like something is wrong on the vop side.
> >> >> >> >The interrupt is part of the vop, the divisable by 4 things lik=
ely too.
> >> >> >>
> >> >> >> This is a hardware limitation on vop side:
> >> >> >> The horizontal resolution must be 4 pixel aligned.
> >> >> >
> >> >> >Then mode_valid() and atomic_check() must reject modes that don't =
fit.
> >> >>
> >> >> We round down to 4 pixel aligned in mode_fixup in our bsp kernel,
> >> >
> >> >What is meant by the "bsp kernel" here? I don't see it being present
> >>=20
> >> bsp kernel means downstream vendor kernel.
> >>=20
> >> >in the mainline kernel. So, if the mode is unsupported, it should be
> >>=20
> >> Will it be acceptable to add this round down in the mainline mode_fixu=
p?
> >
> >I think so.
>=20
> Then I can write a patch for it.

thanks a lot for looking into that :-)


Heiko



