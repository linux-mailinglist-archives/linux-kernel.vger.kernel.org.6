Return-Path: <linux-kernel+bounces-249526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0430A92ECCE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 854F21F22D0F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6032B16D324;
	Thu, 11 Jul 2024 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jXJ52lc5"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5282616B752;
	Thu, 11 Jul 2024 16:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720715638; cv=none; b=E95aMw547WcikQJXy2y6fHZ8r10UiXt53ZlMi9r3hGD2myQdFlYpt4XKTyjkJwyPgKgzZl2h2FPSP228MdogNScGx2J+h3x78dvZpyDmhmDuKEkLlPMLZbnDzaFUQ1KW1XmtbhSuxn/kgps8J8iHEaXtsisIt9qOPH0eJCKkiJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720715638; c=relaxed/simple;
	bh=zNn+b1gpGkgoJRO/dIyT9eGNRhFkmKlz5P/syX7WOo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fAH5c5v0m4tsKVOY7VGZ19xDZ2XQt5JR9lqFUL0mPazLSfJrzIAkF1LmpvlmtuA5zzdSNm+m9guM4X6xX/XYSBjLItaiIGho91X9+R2QFdphmYIGxZppU1aPZIyaX1yOczSoThLzbN7pAjWUeDATgSTd6A1OX1GqeqkgcRlZFIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jXJ52lc5; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720715634;
	bh=zNn+b1gpGkgoJRO/dIyT9eGNRhFkmKlz5P/syX7WOo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jXJ52lc5kzEGKKmX7UgUeCeA92dHLFg4LHejBdhoTye3vvn1kxMI+1lQ0NjabzczG
	 9vv8eJbiPPxevoCZ1zgV+Pu321WkvT+hmRjY9iSm28Evmhu8QOJ0gib14WE+QR2Sia
	 Zc89eg9oRSctqLl1FOOwBpI8YHP4NRGWqv0k68ko+JtJPgEzOsLXFVrJ4UZ+sPvS6y
	 QiNkv9ZRP0JkxmA7JG9mCDM40JHsBbneqt/qo+pWOQbLhnsKnd1YMex4cAIwEqxSab
	 WMpN+K/5ovpqrIwra3bYYYEz+D+BUYnHcCgPa9EcsTwZLr3bQ5jr7dNVlRUa0rgJ4S
	 YX2+6NXbqaS2g==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DE74737821DB;
	Thu, 11 Jul 2024 16:33:51 +0000 (UTC)
Date: Thu, 11 Jul 2024 12:33:49 -0400
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
Message-ID: <521df3a8-5bc2-4e81-a819-02b755c88d3a@notapiano>
References: <9fce9838-ef87-4d1b-b3df-63e1ddb0ec51@notapiano>
 <064935d8-fbda-4eda-b013-8c8fc63b561c@collabora.com>
 <375b2345-657a-4b8f-b5e3-dc16784ffde9@notapiano>
 <da27d957-866f-f055-9e83-cdc362d98dc7@mediatek.com>
 <2dba1638-f155-463b-8f87-421101b8f4f2@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2dba1638-f155-463b-8f87-421101b8f4f2@collabora.com>

On Thu, Jul 11, 2024 at 11:21:14AM +0200, AngeloGioacchino Del Regno wrote:
> Il 11/07/24 06:13, Macpaul Lin ha scritto:
> > 
> > 
> > On 7/11/24 03:15, Nícolas F. R. A. Prado wrote:
> > > On Fri, Jan 19, 2024 at 10:12:07AM +0100, AngeloGioacchino Del Regno wrote:
> > > > Il 18/01/24 19:36, Nícolas F. R. A. Prado ha scritto:
> > > > > Hi,
> > > > > 
> > > > > KernelCI has identified a failure in the probe of one of the USB controllers on
> > > > > the MT8195-Tomato Chromebook [1]:
> > > > > 
> > > > > [   16.336840] xhci-mtk 11290000.usb: uwk - reg:0x400, version:104
> > > > > [   16.337081] xhci-mtk 11290000.usb: xHCI Host Controller
> > > > > [   16.337093] xhci-mtk 11290000.usb: new USB bus
> > > > > registered, assigned bus number 5
> > > > > [   16.357114] xhci-mtk 11290000.usb: clocks are not stable (0x1003d0f)
> > > > > [   16.357119] xhci-mtk 11290000.usb: can't setup: -110
> > > > > [   16.357128] xhci-mtk 11290000.usb: USB bus 5 deregistered
> > > > > [   16.359484] xhci-mtk: probe of 11290000.usb failed with error -110
> > > > > 
> > > > > A previous message [2] suggests that a force-mode phy property that has been
> > > > > merged might help with addressing the issue, however it's not clear to me how,
> > > > > given that the controller at 1129000 uses a USB2 phy and the phy driver patch
> > > > > only looks for the property on USB3 phys.
> > > > > 
> > > > > Worth noting that the issue doesn't always happen. For instance the test did
> > > > > pass for next-20240110 and then failed again on today's next [3]. But it does
> > > > > seem that the issue was introduced, or at least became much more likely, between
> > > > > next-20231221 and next-20240103, given that it never happened out of 10 runs
> > > > > before, and after that has happened 5 out of 7 times.
> > > > > 
> > > > > Note: On the Tomato Chromebook specifically this USB controller is not connected
> > > > > to anything.
> > > > > 
> > > > > [1] https://urldefense.com/v3/__https://linux.kernelci.org/test/case/id/659ce3506673076a8c52a428/__;!!CTRNKA9wMg0ARbw!jtg5drII8WUPwTiL4sWZiSRPXN-EBN8ctTGI85sirqvkmaUbA5z-wrLqPPfxlZZkQ7NItOWDT97OSdENT5oGHKY$
> > > > > [2] https://lore.kernel.org/all/239def9b-437b-9211-7844-af4332651df0@mediatek.com/
> > > > > [3] https://urldefense.com/v3/__https://linux.kernelci.org/test/case/id/65a8c66ee89acb56ac52a405/__;!!CTRNKA9wMg0ARbw!jtg5drII8WUPwTiL4sWZiSRPXN-EBN8ctTGI85sirqvkmaUbA5z-wrLqPPfxlZZkQ7NItOWDT97OSdENi-d0sVc$
> > > > > 
> > > > > Thanks,
> > > > > Nícolas
> > > > 
> > > > Hey Nícolas,
> > > > 
> > > > I wonder if this is happening because of async probe... I have seen those happening
> > > > once in a (long) while on MT8186 as well with the same kind of flakiness and I am
> > > > not even able to reproduce anymore.
> > > > 
> > > > For MT8195 Tomato, I guess we can simply disable that controller without any side
> > > > effects but, at the same time, I'm not sure that this would be the right thing to
> > > > do in this case.
> > > > 
> > > > Besides, the controller at 11290000 is the only one that doesn't live behind MTU3,
> > > > but I don't know if that can ring any bell....
> > > 
> > > An update on this issue: it looks like it only happens if "xhci-mtk
> > > 11290000.usb" probes before "mtk-pcie-gen3 112f8000.pcie". What they have in
> > > common is that both of those nodes use phys that share the same t-phy block:
> > > pcie uses the usb3 phy while xhci uses the usb2 phy. So it seems that some of
> > > the initialization done by the pcie controller might be implicitly needed by the
> > > usb controller.
> > > 
> > > This should help to narrow down the issue and find a proper fix for it.
> > > 
> > > Thanks,
> > > Nícolas
> > 
> > 'force-mode' should only applied to the boards which require XHCI
> > function instead of a PCIE port.
> > 
> > For example, mt8395-genio-1200-evk.dts requires property 'force-mode' to
> > fix probe issue for USBC @11290000.
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/mediatek/linux.git/commit/?h=v6.10-next/dts64&id=666e6f39faff05fe12bfc64c64aa9015135ce783
> > 
> > 'force-mode' should be no need for tomato boards and the behavior should
> > be the same as before.
> > 
> > Another possibility is the firmware change on tomato boards. I'm not
> > sure if there is any changes on tomato's recent firmware for tphy of
> > this port, which could also be a reason causes this kind of failure.
> > I don't have tomato boards on hand.
> > 
> 
> Hello Macpaul,
> 
> it's just about the usb node missing a power domain: as the PCIE_MAC_P1 domain
> seems to be shared between USB and PCIe, adding it to the USB node fixes the
> setup phase.
> 
> I'll send a devicetree fix soon.

Hi,

As I replied to that patch
(https://lore.kernel.org/all/20240711093230.118534-1-angelogioacchino.delregno@collabora.com)
it didn't fix the issue for me, but I have more updates:

I confirmed the pcie was doing some required setup since disabling the pcie1
node made the issue always happen, and that also made it easier to test.

I was able to track the issue down to the following clock:
<&infracfg_ao CLK_INFRA_AO_PCIE_P1_TL_96M>

Adding it to the clocks property of the xhci1 node fixed the issue.

I'm just not sure from a DT perspective what's the right way to describe this
clock. The node doesn't have the frmcnt_ck, is this that clock? Or is it
another clock that currently isn't described in the dt-bindings and driver?

Thanks,
Nícolas

