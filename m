Return-Path: <linux-kernel+bounces-259087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A4B93910A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 16:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 634DC1F220F6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 14:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51E716DC3B;
	Mon, 22 Jul 2024 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QE6SvFrZ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814C516DC29;
	Mon, 22 Jul 2024 14:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721660026; cv=none; b=n7v+qJvG+inVCTn7wKlfgxHWAkOSP0Oq4PAZocLFX4iTJr1C205BjybwvWgCxPGgK1E6HrO+pHDWfoOjwrwxSiJ6M/qvuNu3J+DyES3P0ByuHCWnHL/iCHKFD9L4hePxn8oUfJYSrrv7aXcnBl561IJIOrsqpYZlqJdB64t320M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721660026; c=relaxed/simple;
	bh=ReJ6PIw4rNKKvjtKFWY7U3j9FDNjTAGJ375FqNKVD1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YysU5x1ja8VCNzMajPnFj7gIUPT13tsssgUAyxHbZECz7RQiqySube2QQFR2DvABNFsMI1S+eqJ/HIbLoxVIfM9EnZaNGFFwP5LP0HJqFHJSjV4+heRmmvoq7T43nVn8O9+iw8g8mCx5peWHVscZfdKiXOfvZqIuetjYPvdbvqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QE6SvFrZ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721660022;
	bh=ReJ6PIw4rNKKvjtKFWY7U3j9FDNjTAGJ375FqNKVD1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QE6SvFrZXY9RlL7OIqqF0pMEBZndfkhJcS49Wvl3dyWdMPjVDqoWFPTnE6C452FEP
	 ZRe+0qzLzTJKR1XuZbZbiXzunsc/SiyBL0AsygI5DMztO2nxLHtQji0JgtG6juH/n7
	 yhY4feI+mVqEZdxMMc/GDrUX8j4qLpXn9xy2oGY8sPqU0HiaOs6N18Mk6yqt138M9A
	 LCnR7UacjOIcQRwXsaHpLt7Y+f/6zmErQCJhnp09ypYfFQuRbYICX+UGiSP217mep/
	 zSSoOQFcV5WwAcEWihxAo0qaqwKur74BpWYPB5W49T9aFc36+KT+mpw0BUz7YblgUE
	 L2x6ncpUeYHjQ==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6B6783780523;
	Mon, 22 Jul 2024 14:53:40 +0000 (UTC)
Date: Mon, 22 Jul 2024 10:53:38 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Macpaul Lin <macpaul.lin@mediatek.com>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com,
	Chen-Yu Tsai <wenst@chromium.org>,
	Bear Wang <bear.wang@mediatek.com>,
	Pablo Sun <pablo.sun@mediatek.com>
Subject: Re: Probe failure of usb controller @11290000 on MT8195 after
 next-20231221
Message-ID: <fab8e144-e5ef-4ce8-a74a-89024cd95100@notapiano>
References: <9fce9838-ef87-4d1b-b3df-63e1ddb0ec51@notapiano>
 <064935d8-fbda-4eda-b013-8c8fc63b561c@collabora.com>
 <375b2345-657a-4b8f-b5e3-dc16784ffde9@notapiano>
 <da27d957-866f-f055-9e83-cdc362d98dc7@mediatek.com>
 <2dba1638-f155-463b-8f87-421101b8f4f2@collabora.com>
 <521df3a8-5bc2-4e81-a819-02b755c88d3a@notapiano>
 <ac0d1ba5-1ed0-4d4d-a287-1d3e6efadc0a@collabora.com>
 <ea97fb15-684e-4009-b312-f39c2acdde5b@notapiano>
 <9f12777b-b8b6-4d34-b336-7637e551b552@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f12777b-b8b6-4d34-b336-7637e551b552@collabora.com>

On Mon, Jul 15, 2024 at 02:04:54PM +0200, AngeloGioacchino Del Regno wrote:
[..]
> Besides, I also noticed that the CLK_APMIXED_PLL_SSUSB26M is missing from u2port1
> and the reason why it works is because other u3phy0 should be enabling that before
> u3phy1 inits and/or before the USB controller using U3P1 tries to initialize, so
> while you're at it ... if you can please also add that to the u3p1, I appreciate.
> 
> 			u2port1: usb-phy@0 {
> 				reg = <0x0 0x700>;
> 				clocks = <&apmixedsys CLK_APMIXED_PLL_SSUSB26M>,
> 					 <&topckgen CLK_TOP_SSUSB_PHY_P1_REF>;
> 				clock-names = "ref", "da_ref";
> 				#phy-cells = <1>;
> 			};

I'm not familiar with the clock topology on MT8195, but I noticed the
CLK_APMIXED_PLL_SSUSB26M clock is currently only present in the USB3 phy nodes:
u3port1 and u3port0. You're suggesting to add it to a USB2 phy node here. Is it
needed by all USB2 phy nodes (u2port0, u2port1, u2port2, u2port3) then? 

Thanks,
Nícolas

