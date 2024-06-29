Return-Path: <linux-kernel+bounces-234993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6097391CE13
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 18:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 141BE1F21BA0
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 16:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F0912DD8A;
	Sat, 29 Jun 2024 16:18:29 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CCD42076;
	Sat, 29 Jun 2024 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719677908; cv=none; b=eiRxLkUr4g2uHyIDaeCdXKwuKL194iB4OgWCI1nbD6Mo37QFDN+82EVb5kvmV6KeUsviaItSn1sNzPLvJWVy0twya5NO7YAWBN17p8lXTymTlb0IJ8nqp862TevZRHJ43EuDh9nAOsNslRgW72r0aAz22tfpZbBihKX+VRzSmIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719677908; c=relaxed/simple;
	bh=Zf1livi2LZmggYiyIiKrtpXTMV3WXPPRSTbJ3YtIJEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=falTddw5lpjE6gS8pNWOhfnfK0GXr3I5OV8GaMPSRoCkDYZmY8fMJ/NJ6yTplMbjfMPBAG7MNhlXHzYxYsKEu3dP5gyBTY1AFrJPNYGjRrVZjKruBEkDMtFZ1v0ZrVOIdEcSiviqWq/7vaZeA7SQXp+/4IfOhe2Bhs2JJ66Vu/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6a.versanet.de ([83.135.91.106] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sNam7-000796-8Q; Sat, 29 Jun 2024 18:18:07 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org,
 Diederik de Haas <didi.debian@cknow.org>, Jonas Karlman <jonas@kwiboo.se>
Subject:
 Re: [PATCH] arm64: dts: rockchip: Add optional GPU OPP voltage ranges to
 RK356x SoC dtsi
Date: Sat, 29 Jun 2024 18:18:06 +0200
Message-ID: <9297854.CDJkKcVGEf@diego>
In-Reply-To: <36170f8485293b336106e92346478daa@manjaro.org>
References:
 <446399362bd2dbeeaecd8351f68811165429749a.1719637113.git.dsimic@manjaro.org>
 <f10d5a3c425c2c4312512c20bd35073c@manjaro.org>
 <36170f8485293b336106e92346478daa@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Samstag, 29. Juni 2024, 17:39:34 CEST schrieb Dragan Simic:
> On 2024-06-29 17:25, Dragan Simic wrote:
> > On 2024-06-29 17:10, Heiko St=FCbner wrote:
> >> Am Samstag, 29. Juni 2024, 07:11:24 CEST schrieb Dragan Simic:
> >>=20
> >>> +#ifndef RK356X_GPU_NPU_SHARED_REGULATOR
> >>=20
> >> is there some reason for this duplicating of opps?
> >>=20
> >> The regulator framework should pick the lowest supported voltage
> >> anyway, so it seems you're just extending them upwards a bit.
> >>=20
> >> So I really don't so why we'd need to sets here.
> >=20
> > The reason is improved strictness.  Having the exact GPU OPP voltages
> > required for the boards whose GPU regulators can provide those exact
> > voltages makes it possible to detect misconfigurations much easier,
> > just like it was the case with the board dts misconfiguration that
> > resulted in the recent DCDC_REG2 patch. [1]
> >=20
> > If we had GPU OPP voltage ranges in place instead, the aforementioned
> > issue would probably remain undetected for some time.  It wouldn't be
> > the end of the world, :) of course, but the resulting increased power
> > consumption isn't one of the desired outcomes.
> >=20
> > [1]=20
> > https://lore.kernel.org/linux-rockchip/e70742ea2df432bf57b3f7de542d81ca=
22b0da2f.1716225483.git.dsimic@manjaro.org/
>=20
> On second thought, after seeing that the RK3399 CPU and GPU OPPs
> already specify voltage ranges, I think it would be better to drop
> the distinction between the separate strict voltages and the voltage
> ranges in this patch,

yes, that was what I was trying to say :-)

Also it makes the OPPs less cluttered. Also dt is firmware, I do expect
people to be reasonably knowledgeable if they mess around with their
boards OPPs ;-) .




