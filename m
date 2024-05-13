Return-Path: <linux-kernel+bounces-177961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 624978C46D3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 20:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937C81C216A2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6FC39FD0;
	Mon, 13 May 2024 18:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="IGyvOIy9"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26C42EAF9;
	Mon, 13 May 2024 18:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715625020; cv=none; b=kQ3vQtiL9LY82DIN+nFyvlHKnxNFff3WCvUTmdVujD+Wkm8iYLuHzyvFrvafd9kBRTGAP1P/MPN1bT7XJ0uCTj4IT0IQMpB9e0Gj/wLUYrWZBBuvhTGLEBJdfdKz4yN1pXhN5/DwnKw6u6a5ajNnDd6E/oG11kPU3wyuYCbSL7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715625020; c=relaxed/simple;
	bh=VgGXcLWnnMXQFQNobbGLl/kzDnjLyWMMo5USBpwuUMw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvnGMxupTTyqurC/5RzQmDqvrhGaCXuwthWgvOEBHVQEnbwAieAcU4M+FBJ6hDG0LUqILHOMJ0twJTrsQ8dh2WOwTt5NNIz5V3A7XiNepnO6/UNBWpEX8msl5anUa2vBr8UBoqRgaMBqwf09prsUSqBjdAsBgT90CkFiPYmlsYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=IGyvOIy9; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 29E4510000F;
	Mon, 13 May 2024 21:30:13 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 29E4510000F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1715625013;
	bh=MSCcfNbXWZaqZvB3X6GEwhWjmXjAmNyUMbI+WpgElwY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=IGyvOIy9SYouzwG+kAf3q6T1b8wbTz8TTr2Cfx5P4miFmZKykKjTBtblkWilS3cOI
	 ZaUFxM4aIOhikj9T486T2Tuya1L3mIehaLwtMsPhd/gukFAiVPwpRiczI6lBHxq79D
	 OupNDiBwBbN20hqrp7FNptmussy1wFDaGsgWbsHmRvVcON61blhWVxCA8fJOhxT2cR
	 ZKfExdYYmdAzngdzYnI79O+7FoslbC3q7IfP5EhK6YRdKbo0JiTTlmyXj8fKpCitiC
	 bFD8upMp/Jcd7FAur51hqHJCfpulz4jYdY6CR6p6zIlcUJ7VpE9xDN3j/ZAuszCOXR
	 EJwW7+EPflM8A==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 13 May 2024 21:30:12 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m02.sberdevices.ru
 (172.16.192.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 13 May
 2024 21:30:12 +0300
Date: Mon, 13 May 2024 21:30:12 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Conor Dooley <conor@kernel.org>
CC: <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
	<mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <jian.hu@amlogic.com>,
	<kernel@sberdevices.ru>, <rockosov@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/7] dt-bindings: clock: meson: a1: pll: introduce new
 syspll bindings
Message-ID: <20240513183012.652mwhivasqihiqc@CAB-WSD-L081021>
References: <20240510090933.19464-1-ddrokosov@salutedevices.com>
 <20240510090933.19464-3-ddrokosov@salutedevices.com>
 <20240511-secret-barcode-e25c722ddf1d@spud>
 <20240513091735.l3uewwzfrdd6qwbl@CAB-WSD-L081021>
 <20240513-epic-magnifier-8dd83db81c4c@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240513-epic-magnifier-8dd83db81c4c@spud>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185196 [May 13 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/13 16:04:00 #25186646
X-KSMG-AntiVirus-Status: Clean, skipped

On Mon, May 13, 2024 at 04:48:33PM +0100, Conor Dooley wrote:
> On Mon, May 13, 2024 at 12:18:02PM +0300, Dmitry Rokosov wrote:
> > Hello Conor,
> > 
> > Thank you for quick review!
> > 
> > On Sat, May 11, 2024 at 02:08:03PM +0100, Conor Dooley wrote:
> > > On Fri, May 10, 2024 at 12:08:54PM +0300, Dmitry Rokosov wrote:
> > > > The 'syspll' PLL is a general-purpose PLL designed specifically for the
> > > > CPU clock. It is capable of producing output frequencies within the
> > > > range of 768MHz to 1536MHz.
> > > > 
> > > > The clock source sys_pll_div16, being one of the GEN clock parents,
> > > > plays a crucial role and cannot be tagged as "optional". Unfortunately,
> > > > it was not implemented earlier due to the cpu clock ctrl driver's
> > > > pending status on the TODO list.
> > > 
> > > It's fine to not mark it optional in the binding, but it should be
> > > optional in the driver as otherwise backwards compatibility will be
> > > broken. Given this is an integral clock driver, sounds like it would
> > > quite likely break booting on these devices if the driver doesn't treat
> > > syspll_in as optional.
> > > A lesson perhaps in describing the hardware entirely, even if the
> > > drivers don't make use of all the information yet?
> > 
> > Yes, it's definitely the right lesson for me. However, without syspll or
> > syspll_in, we cannot utilize CPU power management at all.
> 
> That's the status-quo, right? The incorrect dts would continue to not
> support CPU power management and the new one with the correct description
> would?

Hmmm, correct. Okay, I see, I will support sys_pll as optional
connection :)

-- 
Thank you,
Dmitry

