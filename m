Return-Path: <linux-kernel+bounces-208071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E83D790203F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6731F1F216FE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5F81B80F;
	Mon, 10 Jun 2024 11:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="OQsKo/rT"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C43D7828B;
	Mon, 10 Jun 2024 11:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718018474; cv=none; b=iyJOPWnIi29dyJWn/qESXGJLE/Sc2ofLXnBdVdnaRoJ380epzzuvfL1mb06XXISZIT5p2dBbpXaedl+wv3o7RqwI8fXsgRq4grQuGoDqAPYKEgqyKNHllVYRAJF90BGzxkMyjkTRU9Z/N9By+/2OPNsiU93m7nT12el/u3Kf2CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718018474; c=relaxed/simple;
	bh=kWUULNz1Xgf34tZRgABSekR4eYplQDSKCgl0s/AEm5A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sn3evCrPua6bBUxzi6tEwjF8JVRnDkqf/lpGmAHfn0gd+GmfQBTpCtV/YnLbuo88P1DiqnAbI7q26RCdMZ5IKLjEWppV8+YtRwha/6/74La3EVjaJXeFZL2/W44q8DAqA1bRY5loHbhCeii4wd3nUQ+sjXW+kuz1fBC5AVM+POQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=OQsKo/rT; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 8DF58100007;
	Mon, 10 Jun 2024 14:21:03 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8DF58100007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1718018463;
	bh=J9OcXtt9zW++X9LHgNZAVJ9fsD37dpJAiH3O1eiJc8Y=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=OQsKo/rTTXlJq948j48RiBhMmMFyqiO7vMdSx1KZnz6CGgRjqhe+DDluZ1Hkrd7tU
	 50WXIYjBR9RaDMoncSIM+wTSssCZ1ShhxymLXk/jVxaS1CPKPNR8yRsvWVosSy6Clz
	 25ETc2zXMlVZ4DFXk7tulcNQYI1TUJn4rNSBKyjYAv6WrWAlzWfKv071awY7pAcOYM
	 g+NBTk5u6MhsNiDY2Y2sYzYIz3FOks7s8k8GifezEHl9Tf8OapFHZ+/XEtiogCYsd8
	 dky4cOJCLj12z1dlVZWieWD4Hk0B7PHLJ7y2bffPPqKYoOZ1OD70BB7NGVB8MwxKsI
	 Zaz49o2bPgnxw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 10 Jun 2024 14:21:03 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m02.sberdevices.ru
 (172.16.192.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 10 Jun
 2024 14:21:03 +0300
Date: Mon, 10 Jun 2024 14:21:02 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Jerome Brunet <jbrunet@baylibre.com>
CC: <neil.armstrong@linaro.org>, <mturquette@baylibre.com>,
	<sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <jian.hu@amlogic.com>,
	<kernel@sberdevices.ru>, <rockosov@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 0/7] clk: meson: introduce Amlogic A1 SoC Family CPU
 clock controller driver
Message-ID: <20240610112102.o6s4ii25jirsegbj@CAB-WSD-L081021>
References: <20240515185103.20256-1-ddrokosov@salutedevices.com>
 <1jed95p0kq.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1jed95p0kq.fsf@starbuckisacylon.baylibre.com>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185831 [Jun 10 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/06/10 07:14:00 #25537945
X-KSMG-AntiVirus-Status: Clean, skipped

On Mon, Jun 10, 2024 at 12:13:41PM +0200, Jerome Brunet wrote:
> On Wed 15 May 2024 at 21:47, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
> 
> > The CPU clock controller plays a general role in the Amlogic A1 SoC
> > family by generating CPU clocks. As an APB slave module, it offers the
> > capability to inherit the CPU clock from two sources: the internal fixed
> > clock known as 'cpu fixed clock' and the external input provided by the
> > A1 PLL clock controller, referred to as 'syspll'.
> >
> > It is important for the driver to handle the cpu_clk rate switching
> > effectively by transitioning to the CPU fixed clock to avoid any
> > potential execution freezes.
> >
> 
> Please group your changes, fixes then bindings then driver.

Sure, thank you for the suggestion! 

-- 
Thank you,
Dmitry

