Return-Path: <linux-kernel+bounces-324052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9043297474E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 02:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01488B23E90
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 00:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9E56FD5;
	Wed, 11 Sep 2024 00:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="FtovG+4u"
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE7D184D
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 00:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726014233; cv=none; b=BOVehoYrpyBMwlTYXuqRXcxAlB1upf5dob8wXp4fKToWFz5nVzfc4ZRMz31hDzaVt9Vo8Aqh662J3kv4VfRDOEYj3t4su9cHvwjRxauuW3DeJ7Bq07+QCLCe54CgMAx4on12yE1XpzEZrt/L8Jjc+XNeCRfLr/efHwYZpPOltJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726014233; c=relaxed/simple;
	bh=cSBsfCHK9nPfzACDzVdM/MKB8zB/zy5hqepkOz5E+kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MG9M+rTw1+yNwVuWKoqdUhU+n/5TaHL3whSmcpFams3liS7tRsWaIM+EbqlARiZx4YNVHfnqKq6Xey/PIdSDsFKUIuH2t0O+ASL4ofS3wZyE4iD9ZQLSz9u7Ppeg1w0YCgXPqr9iN1NvrvIyIkxgz7ibQno7XlocYEpqf3y7T7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=FtovG+4u; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=FtovG+4u;
	dkim-atps=neutral
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 155B55D3
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:23:45 +0900 (JST)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-205428e6facso77350855ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 17:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1726014224; x=1726619024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xWAl5lGM4zIiLjsv0PKGGyk+U6ZWLatC9GMlGoP1sOY=;
        b=FtovG+4uCHEpXUdDM8Vt89AQK3Ip8Kp2+uYX+9JopqABKP9cg6Magn+Dqv758pyrdU
         U7D83AVVVyfXoWHBuCi2BPhofIn/eU/fSmWryVC/wLirdtcgaNiZmgE4wvRqZy2Fl12f
         aBrMNYjoUs34f28yja4cqdt68VeJ5kslL1UWh9Vd5rEGgLzjzThQxdvVD6azvj4UdOkg
         gLKkvA3jZmKdrUblec6uYqVG9k3ttsDNajZX148L0HyAqaq+Fxpm/IqsYkuq3ooBCcJJ
         GovL6/FOEfHdJB/zYs+BwVw11wfuBxJ9kPlcMZSR09ZwbDZmIhWd4miV2S+/aTNOSFHW
         +YHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726014224; x=1726619024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWAl5lGM4zIiLjsv0PKGGyk+U6ZWLatC9GMlGoP1sOY=;
        b=soxDgQuRxZj5aCdv9FHdCcjN6fIHwFMM0MIov5PVPed6D0qNVHV3SJ+tIzoKzY125c
         ilKYo3twt0izGokRDl+U51N4OPjGhiLognwrt5y8Ei2PMgbMEdNO6FnKg1WZnH2IEDH6
         /WsJo73QXHoYkhJVqflVzrlGYeGq/7F03j8067tB2tjjnHiS56O14vI/R+aJUGBM94mP
         +epWkuhMjZBaBRkunCV9Jx8bD5uLvwAIyz2j4MprJ9iS+lP7o/kGfiVQvP1tM3xoHaJj
         qkGKafJuRZRVEdkYH925E84Vzw2dqQEJWI+qzEM2U7BtiX7M9kMzec6v0g1yNoNoRLuv
         cLYg==
X-Forwarded-Encrypted: i=1; AJvYcCWWso5uFv2U3ZgzeudiyFwmIJCzZlyPg2wy4miVDFqIok8cFih2bMfyAsEUJMhW8YC7LMv9yKRnB5y/flM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+kAc6gZZWGVI/8K4oL9LX9Ladjcc1i75y6B88HZFUA0Y8y6qG
	FRmhFWtpuSDrzSyc9YeMCklNtJtzxPCj6wtphhL3IamFE6/TSEQj1Dh0CCXbWXZYNxftpnTDGIR
	85ohrL6HWBQ1hgNO90ccuuzKtjoi5s9cKkSM0MAymEYjkdsim/I/N55uTvp8+exk=
X-Received: by 2002:a17:903:41c3:b0:205:68a4:b2d9 with SMTP id d9443c01a7336-2074c70ec52mr32126195ad.48.1726014224075;
        Tue, 10 Sep 2024 17:23:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6qhOJonASH42vWnoWDp8Di47y4f4/0X2Q+DYlOavyzi2Fm4h1OKvu1K9Sn/u2x1rhAnod7g==
X-Received: by 2002:a17:903:41c3:b0:205:68a4:b2d9 with SMTP id d9443c01a7336-2074c70ec52mr32125895ad.48.1726014223636;
        Tue, 10 Sep 2024 17:23:43 -0700 (PDT)
Received: from localhost (178.101.200.35.bc.googleusercontent.com. [35.200.101.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2071a6109cfsm48806255ad.175.2024.09.10.17.23.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2024 17:23:43 -0700 (PDT)
Date: Wed, 11 Sep 2024 09:23:31 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Frieder Schrempf <frieder@fris.de>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	Vinod Koul <vkoul@kernel.org>, Adam Ford <aford173@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 0/2] Extending PLL LUT for i.MX8MP Samsung HDMI PHY
Message-ID: <ZuDjAwPxHeJTvXAp@atmark-techno.com>
References: <20240910181544.214797-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240910181544.214797-1-frieder@fris.de>

Frieder Schrempf wrote on Tue, Sep 10, 2024 at 08:14:51PM +0200:
> [2] https://codeberg.org/fschrempf/samsung-hdmi-phy-pll-calculator/src/branch/main/pll.py

Great work! Thanks!

I was curious about the existing table entries, recomputing existing
values doesn't yield the same values. For example, the first entry is
{
        .pixclk = 22250000,
        .pll_div_regs = { 0xd1, 0x4b, 0xf1, 0x89, 0x88, 0x80, 0x40 },
}
but computing it yields
{
    .pixclk = 22250000,
    .pll_div_regs = { 0xd1, 0x4a, 0xf0, 0xef, 0x10, 0x81, 0x40 },
}

I assume there just are multiple ways to generate the same frequencies,
which is fine in itself, but it'd be great to be able to "back-compute"
the entries as a sanity check.

I've played a bit with your script and spent more time on it than I'd
like to admit, but something like this seems to do the trick, plugging
in the regs from the kernel:

---
pll = FractionalNPLL(freq_ref)

regs = [0xd1, 0x4b, 0xf1, 0x89, 0x88, 0x80, 0x40]
# assume fractional
if not regs[0] & 0xD0:
    print("reg[0] missing 0xD0")
    sys.exit(1)
pll.freq_frac = True
pll.params["p"] = regs[0] & 0x2f
pll.params["m"] = regs[1]
pll.params["s"] = (regs[2] >> 4) + 1
pll.params["n2"] = ((regs[2] >> 3) & 0x1) + 1
pll.params["n"] = (regs[2] & 0x7) + 4
pll.params["lc"] = regs[3] & 0x7f
if regs[4] & 0x80:
    pll.params["lc"] = - pll.params["lc"]
pll.params["k"] = regs[4] & 0x7f
pll.params["lc_s"] = regs[5] & 0x7f
pll.params["k_s"] = regs[6] & 0xbf


f_vco = int(pll.params["m"] * pll.f_ref / pll.params["p"])
if f_vco < 750000000 or f_vco > 3000000000:
    print(f"f_vco {f_vco} out of range")
    sys.exit(1)
f_calc = f_vco / pll.params["s"] / 5
pll.freq_int = round(f_calc)
print(f_calc)
sdc = pll.calc_sdc(pll.params)
frac = pll.calc_f_frac(sdc, pll.params)
print(frac)
freq = pll.freq_int + frac
print(freq)
pll.print_reg_driver_data(freq)
exit(0);
---
yields this back (comments added manually)
---
22500000.0 (integer part)
-250000.0 (fractional part)
22250000.0 (summed)

PHY Driver Table Entry:
{
    .pixclk = 22250000.0,
    .pll_div_regs = { 0xd1, 0x4b, 0xf1, 0x89, 0x88, 0x81, 0x40 },
}
---

so if I find some time I'll whip some loop to check all other values...




That aside, I see no problem with this, just one meta-comment about
adding a link to the script in an external repo: I see some other
drivers have python scripts in their trees e.g.
drivers/comedi/drivers/ni_routing/tools/*py
drivers/gpu/drm/ci/xfails/update-xfails.py
drivers/gpu/drm/msm/registers/gen_header.py

would it make sense to commit the script here instead of linking to a
repo that might be lost in the future?

I'm not quite sure what policy the linux repo has here, so leaving that
as an open question.
-- 
Dominique

