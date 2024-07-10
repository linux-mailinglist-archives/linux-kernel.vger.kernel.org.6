Return-Path: <linux-kernel+bounces-248148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9CE92D8E4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B279B25786
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0075D197A7F;
	Wed, 10 Jul 2024 19:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="zz9Kyvc8"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4AA19415C;
	Wed, 10 Jul 2024 19:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720638949; cv=none; b=f21765FVGfw0FbR6gdRN3Q+e8y+v1SyYBGDfWsZKOKKnU0PONcDWvzcVe8IW0yiTn3NPZu7S/ydCHWxWaWXzwIj1yqGrd7K4JcBpX7UpU4xHHhT9b3eR3BrmsixAUqcmPpo9gSzcXh515MNm9r2QDpMD2FZYTlzk3M//21nWQRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720638949; c=relaxed/simple;
	bh=XcRXiDRqA+ir3jqrK/0TX5hqWhgGqVuOsPns1Whd1o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkX96kQtRW+WqtJiuVJIsPs1lvhQ1pOr78kZQyMhJbGk9wns7IBClUPQYJkSCbN5yBftZ8ALUIaGuvIerEx384X+s700k7t0Q5a3czLr+KWvJeN7jRdeQRzVbSGaaml9EdPym93yfv+jENPGDA4pwH2kd+G8b6xmpOU2BCpke+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=zz9Kyvc8; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720638939;
	bh=XcRXiDRqA+ir3jqrK/0TX5hqWhgGqVuOsPns1Whd1o0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zz9Kyvc8n8oCcnls3iEZbvezLgnMdf1CbKfrc+yJMK7zd9luGuMYw5A93UeUydrJW
	 xXU7KD46J7LqS9jwBuwExwP1XPj+p+7FlwWFlF681L2se3YvzYaeL241EAZSYRMgyi
	 CyjsUo3dvRw/KSyo4omFjJ42t1wKkt30FEbjUYFRCMHeKYzIpUNaKaqGkN8LrNsSmo
	 Cx8eiTje1VZ+O7InF+MuPsNqQnCTYXZUB1TdoMwPXtsgyHVzmXdebUJZsSBnTmPmv6
	 AICdiMttq8SN9pVvq3Sz0FhPZ3ahkBWCtNBngmYlFQ9Qj2fNjm2UTfFsVYW7rSfch8
	 bdVLhuXzT4sfA==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E729C37810CD;
	Wed, 10 Jul 2024 19:15:37 +0000 (UTC)
Date: Wed, 10 Jul 2024 15:15:36 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: Probe failure of usb controller @11290000 on MT8195 after
 next-20231221
Message-ID: <375b2345-657a-4b8f-b5e3-dc16784ffde9@notapiano>
References: <9fce9838-ef87-4d1b-b3df-63e1ddb0ec51@notapiano>
 <064935d8-fbda-4eda-b013-8c8fc63b561c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <064935d8-fbda-4eda-b013-8c8fc63b561c@collabora.com>

On Fri, Jan 19, 2024 at 10:12:07AM +0100, AngeloGioacchino Del Regno wrote:
> Il 18/01/24 19:36, Nícolas F. R. A. Prado ha scritto:
> > Hi,
> > 
> > KernelCI has identified a failure in the probe of one of the USB controllers on
> > the MT8195-Tomato Chromebook [1]:
> > 
> > [   16.336840] xhci-mtk 11290000.usb: uwk - reg:0x400, version:104
> > [   16.337081] xhci-mtk 11290000.usb: xHCI Host Controller
> > [   16.337093] xhci-mtk 11290000.usb: new USB bus registered, assigned bus number 5
> > [   16.357114] xhci-mtk 11290000.usb: clocks are not stable (0x1003d0f)
> > [   16.357119] xhci-mtk 11290000.usb: can't setup: -110
> > [   16.357128] xhci-mtk 11290000.usb: USB bus 5 deregistered
> > [   16.359484] xhci-mtk: probe of 11290000.usb failed with error -110
> > 
> > A previous message [2] suggests that a force-mode phy property that has been
> > merged might help with addressing the issue, however it's not clear to me how,
> > given that the controller at 1129000 uses a USB2 phy and the phy driver patch
> > only looks for the property on USB3 phys.
> > 
> > Worth noting that the issue doesn't always happen. For instance the test did
> > pass for next-20240110 and then failed again on today's next [3]. But it does
> > seem that the issue was introduced, or at least became much more likely, between
> > next-20231221 and next-20240103, given that it never happened out of 10 runs
> > before, and after that has happened 5 out of 7 times.
> > 
> > Note: On the Tomato Chromebook specifically this USB controller is not connected
> > to anything.
> > 
> > [1] https://linux.kernelci.org/test/case/id/659ce3506673076a8c52a428/
> > [2] https://lore.kernel.org/all/239def9b-437b-9211-7844-af4332651df0@mediatek.com/
> > [3] https://linux.kernelci.org/test/case/id/65a8c66ee89acb56ac52a405/
> > 
> > Thanks,
> > Nícolas
> 
> Hey Nícolas,
> 
> I wonder if this is happening because of async probe... I have seen those happening
> once in a (long) while on MT8186 as well with the same kind of flakiness and I am
> not even able to reproduce anymore.
> 
> For MT8195 Tomato, I guess we can simply disable that controller without any side
> effects but, at the same time, I'm not sure that this would be the right thing to
> do in this case.
> 
> Besides, the controller at 11290000 is the only one that doesn't live behind MTU3,
> but I don't know if that can ring any bell....

An update on this issue: it looks like it only happens if "xhci-mtk
11290000.usb" probes before "mtk-pcie-gen3 112f8000.pcie". What they have in
common is that both of those nodes use phys that share the same t-phy block:
pcie uses the usb3 phy while xhci uses the usb2 phy. So it seems that some of
the initialization done by the pcie controller might be implicitly needed by the
usb controller.

This should help to narrow down the issue and find a proper fix for it.

Thanks,
Nícolas

