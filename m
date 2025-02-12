Return-Path: <linux-kernel+bounces-511132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D30A32659
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E08B5188910F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B66320DD5C;
	Wed, 12 Feb 2025 12:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="bNQmCJ/E"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60855271824;
	Wed, 12 Feb 2025 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739364996; cv=none; b=Hpzv8qiMu0Bq6mpbFzxiGO1ztSEO9b+Bvhsxzwa52ZMlOFxtLV4bfMVbGMUSi77THcFR4bngtDrI959wcLboYXhsKVuIgMSBIbJ9LkNDpafg5l2S5RC9ZUcQA6ItpN2II2BBkqeC8ijrhWkyD3AyMQC7j9R+z1Yz60WXJNrc8dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739364996; c=relaxed/simple;
	bh=z8cG5NpqhAGB5dmpzplqKZTanH2XS01ETPIpQyDG6Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lYoijHGqarYknyvhsOTET6XJ3iSRCOPNnZgTeN8NmrVt7IMoC01Tf5d/jCkF5j2sSB5kYlMeyvJKcquA22ncYOcnCB3NR+pr3IRpbxjNxOghrDUW/dqq9EBWgF4pouky+NCN4LVZL+6cvwgVsv8lkqvGFTzFgm7u3lFKZHwYsb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=bNQmCJ/E; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=P6iyi8LYf2Q9nhUpNA4gW7Tp0oyXZ3Nz5g0u6VN9kfw=; b=bNQmCJ/EraMnyAIhwDcPnCGe+1
	V/g+yJrQjMHOKoLvOHESl16Zg6JPZ+yzVFSaiJMfZFL0JfsZNrjKR5Ud9fTeRUmu4e4FypJ/c8OEe
	abmtxosmPCFTN+WXsOuEK4I0A6ZPOm/Xgk6ggqNTFk9UlVDCgt2FCrXdsu6hL7el7N0kG4jGr8vzU
	4gGFR5ylsgbPJ/i6Xb4YHiOKqIrPJk4O9PX+mOTqPG81mTYjxuX4FCeVqOnGI3YjSxCWu9EreX6Qd
	MwRW3HM7sdXqD18e9d4Qt/JPLycBKn0G3wOyiRkuKQ4wocm9BT01jZHE4ZZO+gEMzk0L9rEUeTDnu
	MTMUVunA==;
Received: from i53875bc0.versanet.de ([83.135.91.192] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tiCHz-0004Kn-Va; Wed, 12 Feb 2025 13:56:28 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: srinivas.kandagatla@linaro.org, linux-rockchip@lists.infradead.org,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, detlev.casanova@collabora.com,
 sebastian.reichel@collabora.com
Subject: Re: [PATCH RESEND v2 0/6] RK3576 OTP support
Date: Wed, 12 Feb 2025 13:56:27 +0100
Message-ID: <2965867.ZfL8zNpBrT@diego>
In-Reply-To: <5943191.DvuYhMxLoT@workhorse>
References:
 <20250210224510.1194963-1-heiko@sntech.de> <5943191.DvuYhMxLoT@workhorse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Am Mittwoch, 12. Februar 2025, 13:44:15 MEZ schrieb Nicolas Frattaroli:
> On Monday, 10 February 2025 23:45:04 Central European Standard Time Heiko 
> Stuebner wrote:
> > This enables OTP support in the nvmem driver for rk3576.
> > 
> > I expect to pick the clock patch (patch1) and the arm64-dts patch (patch6)
> > myself, after the nvmem-driver and -binding patches have been applied
> > (patches 2-5).
> > 
> > But kept them together for people wanting to try this series.
> > 
> > changes in v2:
> > - fix register constant in clock definition (Diederik)
> > - add patch to set limits on variant-specific clock-names
> > - use correct limits for clocks + resets on rk3576 binding
> > 
> > 
> > RESEND, because I messed up my git-send-email which caused it to include
> > the list of patches 2 times, duplicating everything :-( .
> > 
> > Heiko Stuebner (6):
> >   clk: rockchip: rk3576: define clk_otp_phy_g
> >   nvmem: rockchip-otp: Move read-offset into variant-data
> >   dt-bindings: nvmem: rockchip,otp: add missing limits for clock-names
> >   dt-bindings: nvmem: rockchip,otp: Add compatible for RK3576
> >   nvmem: rockchip-otp: add rk3576 variant data
> >   arm64: dts: rockchip: add rk3576 otp node
> > 
> >  .../bindings/nvmem/rockchip,otp.yaml          | 25 ++++++++++++
> >  arch/arm64/boot/dts/rockchip/rk3576.dtsi      | 39 +++++++++++++++++++
> >  drivers/clk/rockchip/clk-rk3576.c             |  2 +
> >  drivers/nvmem/rockchip-otp.c                  | 17 +++++++-
> >  4 files changed, 81 insertions(+), 2 deletions(-)
> 
> Hi Heiko,
> 
> for the entire series:
> 
> Tested-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> 
> OTPs show up on my Sige5 RK3576 board and read fine. Also compared the OTP 
> nodes to downstream and the values look consistent with that. The OTPs aren't 
> documented in the TRM I have, so unfortunately I can't cross-reference that.

thanks a lot for the testing :-)

> NB: patchwork's "Series" download for this series somehow lacks patch 2/6, 
> which tripped me up at first. Not sure if that's a problem with patchwork or 
> with how you sent the series out, but I thought I'd let others know who run 
> into this.

It looks like patchwork had a bigger hickup with my series.
Looking at the cover-letter in the Rockchip area of patchwork, it is
missing _all_ patches attached to it [0].

At least on the mainling list, everything seems to have arrived ok [1],
so would assume that's a patchwork thing.


[0] https://patchwork.kernel.org/project/linux-rockchip/cover/20250210224510.1194963-1-heiko@sntech.de/
[1] https://lore.kernel.org/all/20250210224510.1194963-1-heiko@sntech.de/



