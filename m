Return-Path: <linux-kernel+bounces-392163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CD79B9072
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17FAE282803
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7D219B586;
	Fri,  1 Nov 2024 11:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="PWBHOkBe"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8F119ABBD;
	Fri,  1 Nov 2024 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730461302; cv=none; b=oSyOX3VCMnZD7OyHxjQushB7QqNeC03cveQDMR4Yih8Nc2CxUE5/NduMEHxLygkngu8yh2n7HNgObgCF3hh/fCqdTEn52j159puAK2+U5S3blwszVWKKw58b3zFekMH3691Xe7hDKcuBy8UREJ0dya5/9uymeKqZYDE3Q48xqR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730461302; c=relaxed/simple;
	bh=UpIhy6ONjO+Fga90pjXdn+xEmrcqSSZ/ILq/5/r2IW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXhkhQBfNPRd7ek0fMhbvQpXbRquhJ/SRKiZlZBbg7QYCuJ4pmsQdXv2vCiCI6GLh/Mc6holWNvn0gioo9ZpCuMiiF5MnTG9BUreM+sHOgWQ/4100FC88qQJ7iVDnjuLKiqmtfXuLgNDDZ5H9z7Jx1YlcQQrbRxWWEwFHxAWE70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=PWBHOkBe; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=c+ww708aRc0qAteUCkjthXfj1VPpWdpi32cBrs7jx40=;
	b=PWBHOkBeUaF7mXHNKxJLf+YgphM25RjX5LqSCZLkCvuMz5RQTODLV+3SIEUMem
	vWWdt5Xxr9lFpGM+3Wh88y4mPHmOjr+CfR8zcJHXGOS7Sh5yukjMRjTkKBTUcXgH
	u/0gyluq3eZs9QSbBZgBRWGtzTmFei0Z9moJZKXVst09g=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgCXvSdGviRndu1qAQ--.14047S3;
	Fri, 01 Nov 2024 19:40:56 +0800 (CST)
Date: Fri, 1 Nov 2024 19:40:54 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	"open list:TQ SYSTEMS BOARD & DRIVER SUPPORT" <linux@ew.tq-group.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] arm64: dts: imx8mn-tqma8mqnl-mba8mx-usbot: fix
 coexistence of output-low and output-high in GPIO
Message-ID: <ZyS+Rm8rRkPX6L8S@dragon>
References: <20241023210313.1390767-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023210313.1390767-1-Frank.Li@nxp.com>
X-CM-TRANSID:Ms8vCgCXvSdGviRndu1qAQ--.14047S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF45ZF47tw47Zry5uw13CFg_yoWfKFXE9a
	sYqw4xJ348Crn0kwnxCwsY9rW29r1xWrnIqr1Sg398KFWFvanFyF10vrySqFW5CF4jyr9r
	G34ktw1UXrWF9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8EoGJUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAgeKZWckfBi+WgAAsp

On Wed, Oct 23, 2024 at 05:03:13PM -0400, Frank Li wrote:
> Fix the issue where both 'output-low' and 'output-high' exist under GPIO
> hog nodes  (rst_usb_hub_hog and sel_usb_hub_hog) when applying device
> tree overlays. Since /delete-property/ is not supported in the overlays,
> setting 'output-low' results in both properties being present. The
> workaround is to disable these hogs and create new ones with 'output-low'
> as needed.
> 
> Fix below CHECK_DTBS warning:
> arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx-usbotg.dtb: sel-usb-hub-hog:
>    {'output-low': True, 'gpio-hog': True, 'gpios': [[1, 0]], 'output-high': True, 'phandle': 108, '$nodename': ['sel-usb-hub-hog']}
>        is valid under each of {'required': ['output-low']}, {'required': ['output-high']
> 
> Fixes: 3f6fc30abebc ("arm64: dts: imx8mn: tqma8mqnl-mba8mx: Add USB DR overlay")
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!


