Return-Path: <linux-kernel+bounces-219981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 931A690DB17
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A368284C4F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EC41482E6;
	Tue, 18 Jun 2024 17:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="EQtmLmB5"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FAC1CAB3;
	Tue, 18 Jun 2024 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718733163; cv=none; b=SrmuztITD7mlaL5QYgd4/2nYPPHDGFQrg1NUuSb3PEoMyBUIeaC0rhAhNoR4/50X6XG0i7iSA570ANKTkhgeGV5esG4vxJoaamRDMR2NNYOw7Ifi2M05kbNPGvYdaZMCTF2uQYXBe/6Nxw/Hpa4rbeYZGJ/zvcu+eTU00idLVMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718733163; c=relaxed/simple;
	bh=0cexaMOCCe5o8jbSfBi41x60WbuHR244aFJcYgBY7rs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngRMOBbIfiQLhHfnorIHwD34UzBomunl9Xcx4vckEu/tGzFymLACZKfZx4NA3q8UtFf3K9m1MdPaHn64Uktxqqbf/PmTeMfsTzg/x4r3p88V8FRzrxt7KiglYrLW2H9D0gNXrz9ZpwlacSHbSdKPp/YE+4rKYZ5XoY1na1T1eBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=EQtmLmB5; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 61459100016;
	Tue, 18 Jun 2024 20:52:29 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 61459100016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1718733149;
	bh=5TjeYJIhyXVCbtW4EgmHOFsDZbAMP7EgSVrBNOOHR9g=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=EQtmLmB5bWg+RdiajBbBReyay3nqp9amTcITVHIb67cFVUMJ4A98E4o2rHTid60ki
	 rie8Nxts2xJbLTDMyQF8HTYYk26uyG1DjGgww1SSuYAs1ii05wWfTqH/D0NNgW7P7f
	 SAZik9tWWBPOW+6o8gkoOCzK7//aTbf5Z3ljR1LYluQog3za0huJWYtqLBS6baCEEw
	 MygAPEEM4VjdQDmd59pUasIGcGrITG+An3k4HrryRQhXUlRrfPqW55V2kKIj7rQeid
	 UBhxfJS6IiUf1bdoIHa8gRVhD5+lkUisRstIo6AEJoCi46IMMSGvpptdb9breuMRM2
	 yRiXN7HVz1d/g==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 18 Jun 2024 20:52:29 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m02.sberdevices.ru
 (172.16.192.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 18 Jun
 2024 20:52:28 +0300
Date: Tue, 18 Jun 2024 20:52:28 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
CC: Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jerome Brunet
	<jbrunet@baylibre.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Igor Prusov
	<ivprusov@salutedevices.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-amlogic@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: amlogic: ad402: move thermal-zones to top
 node
Message-ID: <20240618175134.bzw22uthyvw55rfc@CAB-WSD-L081021>
References: <20240528133215.2266419-1-arnd@kernel.org>
 <171766520046.3911343.14113541266786791367.b4-ty@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <171766520046.3911343.14113541266786791367.b4-ty@linaro.org>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185993 [Jun 18 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2;git.kernel.org:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/06/18 16:18:00
X-KSMG-LinksScanning: Clean, bases: 2024/06/18 16:17:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/06/18 16:19:00 #25649051
X-KSMG-AntiVirus-Status: Clean, skipped

On Thu, Jun 06, 2024 at 11:13:20AM +0200, Neil Armstrong wrote:
> Hi,
> 
> On Tue, 28 May 2024 15:31:59 +0200, Arnd Bergmann wrote:
> > It appears that this accidentally got added into the spi node, causing
> > a warning.
> > 
> > arch/arm64/boot/dts/amlogic/meson-a1-ad402.dts:119.16-161.4: Warning (spi_bus_reg): /soc/spi@fd000400/thermal-zones: missing or empty reg property
> > 
> > 
> 
> Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.11/arm64-dt)
> 
> [1/1] arm64: dts: amlogic: ad402: move thermal-zones to top node
>       https://git.kernel.org/amlogic/c/6c9b5ba73ca77ef3863cda6560856fdfe7dc237a
> 
> These changes has been applied on the intermediate git tree [1].
> 
> The v6.11/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
> for inclusion in their intermediate git branches in order to be sent to Linus during
> the next merge window, or sooner if it's a set of fixes.
> 
> In the cases of fixes, those will be merged in the current release candidate
> kernel and as soon they appear on the Linux master branch they will be
> backported to the previous Stable and Long-Stable kernels [2].
> 
> The intermediate git branches are merged daily in the linux-next tree [3],
> people are encouraged testing these pre-release kernels and report issues on the
> relevant mailing-lists.
> 
> If problems are discovered on those changes, please submit a signed-off-by revert
> patch followed by a corrective changeset.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

My apologies for any confusion, it seems like these are artifacts from
the merge process...

-- 
Thank you,
Dmitry

