Return-Path: <linux-kernel+bounces-252645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC3593164B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 420E51F22556
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC44E18E776;
	Mon, 15 Jul 2024 14:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gJpq0wlN"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3C51836D4;
	Mon, 15 Jul 2024 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721052052; cv=none; b=LdBF2xAjH7kYlNBUtCONF7c916O2j9TZJgKEmLQuStI/Mz1jTzEqUA597dJlrfcOLzV0ZTQyrIeJRFeOzejMflDDfO+TKUc3UOU8WysuZy67s8NA2E5kg6a1E5KjccXm5j5J+Ku14xYim4UF4fs8x46+z1CuqhPxHTj3e6v1RRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721052052; c=relaxed/simple;
	bh=pG+ZdbY1Ozpp5+nY8kZjID0lQIZrvEhPTA7pCS5fkXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2kK8wFhfCoo5i1djGwwk+xezohJ7wPMXmoekbhegVo2G6Xp++HQF6nr3GVWbfuSe++VOTJ6E865OJuD8i6q4VIs9GB08dgAZuv9/jhCktQbyOuRvPZbxv4DPpXdL7Uh5NJIqLfGQZK81TTc41fOKMZCz2N6h/ghsAYDEh0Hsyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gJpq0wlN; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721052048;
	bh=pG+ZdbY1Ozpp5+nY8kZjID0lQIZrvEhPTA7pCS5fkXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gJpq0wlNQVGCCiv8i9a6zUjP7ey20eGidyAOkRzKOHWqugF3+y8WUMDm2YMjTXnFW
	 NJs0H6xwO/oKhYRWuITu/9xhgQ30GBzlLbIusqM43PWadfO7+mCiFXTUmZRPzMofyP
	 sLkwh/5aSqcrMJmoUGfwIBQva494XuVDBffoNH7VT0MSso/oHb8EeSWU3DAAOCz0np
	 dZt7/BlBLOo9ANU6P4z2CeloB/P+S9WrD1NKcEqOkXCotSW208cYyNDS6JwdHprLPn
	 +QcbVaGbOh3Yx1zMRz663DoGpC7PoVgMFRO2IvYIMN2mHSZakQ0B1pNWwHHAv4RDU8
	 RdXIjjaFtvHgw==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0790C3782101;
	Mon, 15 Jul 2024 14:00:45 +0000 (UTC)
Date: Mon, 15 Jul 2024 10:00:43 -0400
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
Message-ID: <a3b347fb-7b95-4cab-a7ec-4963cbeaa7f7@notapiano>
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
> Il 12/07/24 17:58, Nícolas F. R. A. Prado ha scritto:
> > On Fri, Jul 12, 2024 at 10:12:39AM +0200, AngeloGioacchino Del Regno wrote:
> > > Il 11/07/24 18:33, Nícolas F. R. A. Prado ha scritto:
> > > > On Thu, Jul 11, 2024 at 11:21:14AM +0200, AngeloGioacchino Del Regno wrote:
> > > > > Il 11/07/24 06:13, Macpaul Lin ha scritto:
> > > > > > 
> > > > > > 
> > > > > > On 7/11/24 03:15, Nícolas F. R. A. Prado wrote:
> > > > > > > On Fri, Jan 19, 2024 at 10:12:07AM +0100, AngeloGioacchino Del Regno wrote:
> > > > > > > > Il 18/01/24 19:36, Nícolas F. R. A. Prado ha scritto:
> > > > > > > > > Hi,
> > > > > > > > > 
> > > > > > > > > KernelCI has identified a failure in the probe of one of the USB controllers on
> > > > > > > > > the MT8195-Tomato Chromebook [1]:
> > > > > > > > > 
> > > > > > > > > [   16.336840] xhci-mtk 11290000.usb: uwk - reg:0x400, version:104
> > > > > > > > > [   16.337081] xhci-mtk 11290000.usb: xHCI Host Controller
> > > > > > > > > [   16.337093] xhci-mtk 11290000.usb: new USB bus
> > > > > > > > > registered, assigned bus number 5
> > > > > > > > > [   16.357114] xhci-mtk 11290000.usb: clocks are not stable (0x1003d0f)
> > > > > > > > > [   16.357119] xhci-mtk 11290000.usb: can't setup: -110
> > > > > > > > > [   16.357128] xhci-mtk 11290000.usb: USB bus 5 deregistered
> > > > > > > > > [   16.359484] xhci-mtk: probe of 11290000.usb failed with error -110
> > > > > > > > > 
> > > > > > > > > A previous message [2] suggests that a force-mode phy property that has been
> > > > > > > > > merged might help with addressing the issue, however it's not clear to me how,
> > > > > > > > > given that the controller at 1129000 uses a USB2 phy and the phy driver patch
> > > > > > > > > only looks for the property on USB3 phys.
> > > > > > > > > 
> > > > > > > > > Worth noting that the issue doesn't always happen. For instance the test did
> > > > > > > > > pass for next-20240110 and then failed again on today's next [3]. But it does
> > > > > > > > > seem that the issue was introduced, or at least became much more likely, between
> > > > > > > > > next-20231221 and next-20240103, given that it never happened out of 10 runs
> > > > > > > > > before, and after that has happened 5 out of 7 times.
> > > > > > > > > 
> > > > > > > > > Note: On the Tomato Chromebook specifically this USB controller is not connected
> > > > > > > > > to anything.
> > > > > > > > > 
> > > > > > > > > [1] https://urldefense.com/v3/__https://linux.kernelci.org/test/case/id/659ce3506673076a8c52a428/__;!!CTRNKA9wMg0ARbw!jtg5drII8WUPwTiL4sWZiSRPXN-EBN8ctTGI85sirqvkmaUbA5z-wrLqPPfxlZZkQ7NItOWDT97OSdENT5oGHKY$
> > > > > > > > > [2] https://lore.kernel.org/all/239def9b-437b-9211-7844-af4332651df0@mediatek.com/
> > > > > > > > > [3] https://urldefense.com/v3/__https://linux.kernelci.org/test/case/id/65a8c66ee89acb56ac52a405/__;!!CTRNKA9wMg0ARbw!jtg5drII8WUPwTiL4sWZiSRPXN-EBN8ctTGI85sirqvkmaUbA5z-wrLqPPfxlZZkQ7NItOWDT97OSdENi-d0sVc$
> > > > > > > > > 
> > > > > > > > > Thanks,
> > > > > > > > > Nícolas
> > > > > > > > 
> > > > > > > > Hey Nícolas,
> > > > > > > > 
> > > > > > > > I wonder if this is happening because of async probe... I have seen those happening
> > > > > > > > once in a (long) while on MT8186 as well with the same kind of flakiness and I am
> > > > > > > > not even able to reproduce anymore.
> > > > > > > > 
> > > > > > > > For MT8195 Tomato, I guess we can simply disable that controller without any side
> > > > > > > > effects but, at the same time, I'm not sure that this would be the right thing to
> > > > > > > > do in this case.
> > > > > > > > 
> > > > > > > > Besides, the controller at 11290000 is the only one that doesn't live behind MTU3,
> > > > > > > > but I don't know if that can ring any bell....
> > > > > > > 
> > > > > > > An update on this issue: it looks like it only happens if "xhci-mtk
> > > > > > > 11290000.usb" probes before "mtk-pcie-gen3 112f8000.pcie". What they have in
> > > > > > > common is that both of those nodes use phys that share the same t-phy block:
> > > > > > > pcie uses the usb3 phy while xhci uses the usb2 phy. So it seems that some of
> > > > > > > the initialization done by the pcie controller might be implicitly needed by the
> > > > > > > usb controller.
> > > > > > > 
> > > > > > > This should help to narrow down the issue and find a proper fix for it.
> > > > > > > 
> > > > > > > Thanks,
> > > > > > > Nícolas
> > > > > > 
> > > > > > 'force-mode' should only applied to the boards which require XHCI
> > > > > > function instead of a PCIE port.
> > > > > > 
> > > > > > For example, mt8395-genio-1200-evk.dts requires property 'force-mode' to
> > > > > > fix probe issue for USBC @11290000.
> > > > > > 
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/mediatek/linux.git/commit/?h=v6.10-next/dts64&id=666e6f39faff05fe12bfc64c64aa9015135ce783
> > > > > > 
> > > > > > 'force-mode' should be no need for tomato boards and the behavior should
> > > > > > be the same as before.
> > > > > > 
> > > > > > Another possibility is the firmware change on tomato boards. I'm not
> > > > > > sure if there is any changes on tomato's recent firmware for tphy of
> > > > > > this port, which could also be a reason causes this kind of failure.
> > > > > > I don't have tomato boards on hand.
> > > > > > 
> > > > > 
> > > > > Hello Macpaul,
> > > > > 
> > > > > it's just about the usb node missing a power domain: as the PCIE_MAC_P1 domain
> > > > > seems to be shared between USB and PCIe, adding it to the USB node fixes the
> > > > > setup phase.
> > > > > 
> > > > > I'll send a devicetree fix soon.
> > > > 
> > > > Hi,
> > > > 
> > > > As I replied to that patch
> > > > (https://lore.kernel.org/all/20240711093230.118534-1-angelogioacchino.delregno@collabora.com)
> > > > it didn't fix the issue for me, but I have more updates:
> > > > 
> > > > I confirmed the pcie was doing some required setup since disabling the pcie1
> > > > node made the issue always happen, and that also made it easier to test.
> > > > 
> > > > I was able to track the issue down to the following clock:
> > > > <&infracfg_ao CLK_INFRA_AO_PCIE_P1_TL_96M>
> > > > 
> > > > Adding it to the clocks property of the xhci1 node fixed the issue.
> > > > 
> > > 
> > > Clocks is what I tried first, and didn't do anything for me...
> > > 
> > > ..anyway, can you at this point try to run that solution on the multiple
> > > devices that we have in the lab through KernelCI?
> > > 
> > > That would help validating that you're not facing the same false positive
> > > as mine from yesterday...
> > 
> > Hi,
> > 
> > I've ran 10 times with and 10 times without the following patch:
> > 
> >    diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> >    index 2ee45752583c..611afe4de968 100644
> >    --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> >    +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> >    @@ -1453,9 +1453,10 @@ xhci1: usb@11290000 {
> >                                     <&topckgen CLK_TOP_SSUSB_P1_REF>,
> >                                     <&apmixedsys CLK_APMIXED_USB1PLL>,
> >                                     <&clk26m>,
> >    -                                <&pericfg_ao CLK_PERI_AO_SSUSB_1P_XHCI>;
> >    +                                <&pericfg_ao CLK_PERI_AO_SSUSB_1P_XHCI>,
> >    +                                <&infracfg_ao CLK_INFRA_AO_PCIE_P1_TL_96M>;
> >                            clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck",
> >    -                                     "xhci_ck";
> >    +                                     "xhci_ck", "frmcnt_ck";
> >                            mediatek,syscon-wakeup = <&pericfg 0x400 104>;
> >                            wakeup-source;
> >                            status = "disabled";
> > 
> > In both cases I also had
> > 
> >    diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> >    index fe5400e17b0f..e50be8a82d49 100644
> >    --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> >    +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> >    @@ -613,7 +613,7 @@ flash@0 {
> >     };
> >     &pcie1 {
> >    -       status = "okay";
> >    +       /* status = "okay"; */
> >            pinctrl-names = "default";
> >            pinctrl-0 = <&pcie1_pins_default>;
> > 
> > to make the issue always happen.
> > 
> > For reproducibility purposes, this was tested on next-20240703 with the
> > following config: http://0x0.st/XMGM.txt
> > 
> > And the results confirm that every run (10/10) with the patch didn't experience
> > the issue:
> > 
> >     https://lava.collabora.dev/scheduler/job/14805738
> >     https://lava.collabora.dev/scheduler/job/14805757
> >     https://lava.collabora.dev/scheduler/job/14805759
> >     https://lava.collabora.dev/scheduler/job/14805789
> >     https://lava.collabora.dev/scheduler/job/14805791
> >     https://lava.collabora.dev/scheduler/job/14805792
> >     https://lava.collabora.dev/scheduler/job/14805795
> >     https://lava.collabora.dev/scheduler/job/14805799
> >     https://lava.collabora.dev/scheduler/job/14805816
> >     https://lava.collabora.dev/scheduler/job/14805820
> > 
> > While every run (10/10) without the patch experienced the issue:
> > 
> >     https://lava.collabora.dev/scheduler/job/14805740
> >     https://lava.collabora.dev/scheduler/job/14805758
> >     https://lava.collabora.dev/scheduler/job/14805787
> >     https://lava.collabora.dev/scheduler/job/14805790
> >     https://lava.collabora.dev/scheduler/job/14805793
> >     https://lava.collabora.dev/scheduler/job/14805796
> >     https://lava.collabora.dev/scheduler/job/14805803
> >     https://lava.collabora.dev/scheduler/job/14805818
> >     https://lava.collabora.dev/scheduler/job/14805822
> >     https://lava.collabora.dev/scheduler/job/14805876
> > 
> > These runs are across different units of tomato-r2. I also tried on tomato-r3
> > with the same result:
> > without clock, fail: https://lava.collabora.dev/scheduler/job/14806546
> > with clock, pass: https://lava.collabora.dev/scheduler/job/14806547
> > 
> > So this definitely fixes it. Whether or not this is the right fix, or how to
> > describe this clock, I'll need your and MediaTek's help to figure out.
> > 
> 
> I analyzed the situation and....
> well, it's right, this clock does indeed resolve the issue, also tested locally,
> but apparently there is no reference anywhere to why this happens to resolve it.
> 
> So, after a bit of extensive research, the only realistic reason here is that
> there is some sort of hardware bug/quirk for the clocking of the secondary XHCI
> controller.
> Whether that is on the clock controller, on the internal paths or wherever else
> is curious to know, but I suspect that this would take a lot of time for MediaTek
> to perform the research.
> 
> What counts is that MediaTek is aware of this situation so that they can internally
> understand what is going on with this and resolve that at a hardware level on new
> SoC models.
> 
> As for what we can do about this, since this is a one-off, we can add that as
> the frmcnt_ck one, with a comment in DT saying that this is a bug, and eventually
> that we don't know if this has anything to do with the frame counter.
> 
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
> 
> Anyway, nice catch! Waiting for your patch :-)

Sure thing, will do. I'll just wait a couple days to give MediaTek a chance to
comment on this. Then I'll send the patch(es).

Thanks,
Nícolas

