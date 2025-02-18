Return-Path: <linux-kernel+bounces-519102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B31A3981A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B05EC7A54D1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E9C233D88;
	Tue, 18 Feb 2025 10:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="NxiIsn1b"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431501B415E;
	Tue, 18 Feb 2025 10:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872869; cv=none; b=EYbIBySCO1j6MuTSho4ifU978589UbDw1FNyDzRHF+zUumO8KcOZG+R549SBcwMLzqVBwVRjGZRx5e2W5ZSfAYAjk3PO47W7iKFCLafn8x6/fZolY72cGWWKkKYW/7UIi4XKwJNLDdmz2RzfJNOw5kscPruVoAeCSg4wyIzPIis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872869; c=relaxed/simple;
	bh=l5Ts+b7yVQJqhwAyf007dWGYtYu9ssBgiRKvaW+pf6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AUWZ3ywYYcr9z3jZ9oGM0uGVfXneZchvOtkhjC4mC7HaDG4sV2mmsDT6b5OfH/AqfR+oXJMsgxMv7o1SXEZXAsYIu2npQDD7z79/51N6PeqQtZYcBB7g457QeaG6V5NG2p5FHcz00gNLETqZRmvBNwOnwUSlPjZPoKH14kLbSsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=NxiIsn1b; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XqV/29FN8TAKwZ9jAVPZuJgB96iWFCzrBQyx4X5GjRI=; b=NxiIsn1b7FykEg6OCLh5DpDtTw
	RDjum5Qx4uV2nMLbl4A6rKayYGAtYmRYhAH5mPNiqN74w7AOyScXoApT0M3CIAtB5pfTCduRV84jd
	8Y9wbfTlYPWDx+tG8n52sNCelLFypuJUEOv8RXNXELnwatmIl5F2DkL7iHY8TDhbx8bWA+EMZkzWV
	awy1oAO/ET4dDzpyQfTxmlkpCH5DD/0t5BSkPOJVNP06R7088+J5tbrXKad7fHL5iEhgRrswiU0aD
	P/xjDk3UO+AdXFAGXt0t8pbE8CJWS6djYfLefPC+snPPRg5SpASruOXsCRX6Fcqmmj6HbjXD424EU
	wvqiQjNA==;
Received: from i53875bc0.versanet.de ([83.135.91.192] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tkKPS-0003jc-4g; Tue, 18 Feb 2025 11:00:58 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: cristian.ciocaltea@collabora.com, Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: airlied@gmail.com, andy.yan@rock-chips.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 hjc@rock-chips.com, kernel@collabora.com, krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, liujianfeng1994@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, robh@kernel.org,
 simona@ffwll.ch, tzimmermann@suse.de
Subject:
 Re: [PATCH 3/4] arm64: dts: rockchip: Add HDMI1 PHY PLL clock source to VOP2
 on RK3588
Date: Tue, 18 Feb 2025 11:00:57 +0100
Message-ID: <1919367.CQOukoFCf9@diego>
In-Reply-To: <20250218095216.1253498-1-liujianfeng1994@gmail.com>
References:
 <1b3234ce-4526-4735-b9c0-c242e6cc3cf0@collabora.com>
 <20250218095216.1253498-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 18. Februar 2025, 10:52:16 MEZ schrieb Jianfeng Liu:
> Hi Cristian,
> 
> No matter one or two hdmi ports the rk3588 boards have, most of
> devicetrees in mainline kernel only have hdmi0 supported. After applying
> this patch their hdmi0 support is broken.
> 
> So I recommend moving the vop clk part to board level devicetree.
> Then support of hdmi0 won't be broken, and board maintainers can add
> HDMI1 PHY PLL clk when they are adding hdmi1 support. I can add support
> for orangepi 5 max and armsom w3 for reference by other developers.

better, fix the VOP2 driver - both for the existing hdmi0 + this hdmi1
please.

I.e. the clock is optional, and the error you are seeing comes from the

       vop2->pll_hdmiphy1 = devm_clk_get_optional(vop2->dev, "pll_hdmiphy1");
       if (IS_ERR(vop2->pll_hdmiphy1)) {
               drm_err(vop2->drm, "failed to get pll_hdmiphy1\n");
               return PTR_ERR(vop2->pll_hdmiphy1);
       }

part. clk_get_optional is supposed to return NULL when clock-retrieval
causes a ENOENT error. Seemingly going to a clock controller in a disabled
node returns a different error?

So I guess step1, check what error is actually returned.
Step2 check if clk_get_optional need to be adapted or alternatively
catch the error in the vop2 and set the clock to NULL ourself in that case.


hdptxphy0 + hdpxphy1 _are_ valid supplies for the vop, so their reference
should be in the soc-dtsi and the kernel code should just figure things out
correctly. Wiggling with clocks in each board will cause headaches down
the road.


Heiko



