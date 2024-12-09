Return-Path: <linux-kernel+bounces-437144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB67B9E8F99
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B69E4161F56
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB1E174EDB;
	Mon,  9 Dec 2024 10:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="B//pY+Pk"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B2B2163B5;
	Mon,  9 Dec 2024 10:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733738612; cv=none; b=O1uLZgKnzjHcPlRDnh89pf2DbV4oI56SoPB3/vcWxJJR881kgCEz08iGzA3n8XEhIQ+kS8dHzL2pZ0oPCF++6LRjXvfpjBpX/yhy61wzodyvGVjz4nLWfUht3bmLfdZiPqB/ZX1zE8YcgP6YFMjxUyhDf8+1578f/ZNgaGo1xzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733738612; c=relaxed/simple;
	bh=oaTmLKIHySx3/9EefzNryOtdd/dq9AOA4njTX7YdfcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sbFMRmsTC9GcVW9ICTRVbcrGEOUC9uQ3enkS7RCYTLMjVdHt1tVivIGGOqgj23X98qQN9J8RxQW88l7kd5Id9r7w6u6DxAawFzHN8w+oH+2HPFB2dKJ6wM1+RCEhg5Dncl9JcX/smjr8dC8WSScMGnFdz2VpzuB7vCTFEbmvolo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=B//pY+Pk; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=U7R121uLFrazzqIE+a0MoWJrf13NWyWmaYCtY6uatv8=; b=B//pY+PkLMx7uqCuQT4hTHfnFH
	YJf+jXvz3rzmN1+7IJdFyD6t/kPAuSUbhyXLNJtHKuPj2jTfVKXJXuW1iIpJv+Mj2QUDRINThkG3O
	r3C7gjyw/b8nGBE81bp9cRgmB37fSEA4nlDOHyck/YfxATfB6ZlTg155H+fNtwy3C4piNA06rzH6M
	D3yh/8JG1Mpz7GbjGbjKeLOe6o5kzfUBC+FNdWCBiMGWDGTz0JOaFrgk5VpdpxAiJJF80vc6y1t2k
	ILIyHyLHygoT2YG6ayVtcfmIL+pdaNm0y3sdcMHysq1nyngeNHNGmCP3mWJP5HWUYqNDkmjG9IVre
	1I4EVRPA==;
Received: from i53875bc4.versanet.de ([83.135.91.196] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tKabd-0006NH-7H; Mon, 09 Dec 2024 11:03:09 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Kever Yang <kever.yang@rock-chips.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-rockchip@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] dt-bindings: vendor-prefixes: Update rockchip company name
Date: Mon, 09 Dec 2024 11:03:08 +0100
Message-ID: <10907239.zapYfy813O@diego>
In-Reply-To: <kwx76ihsftsgw3u53l33z4kodihyfcvpqpl2a2nk7aedgnr6e6@2324w7s7zmio>
References:
 <20241205082258.857018-1-kever.yang@rock-chips.com>
 <kwx76ihsftsgw3u53l33z4kodihyfcvpqpl2a2nk7aedgnr6e6@2324w7s7zmio>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Montag, 9. Dezember 2024, 10:42:50 CET schrieb Krzysztof Kozlowski:
> On Thu, Dec 05, 2024 at 04:22:58PM +0800, Kever Yang wrote:
> > Rockchip company name has update to below name since 2021:
> > Rockchip Electronics Co., Ltd.
> 
> Some reference would be useful. Wikipedia says:
> Fuzhou Rockchip Electronics Co., Ltd.

I did go digging a bit:

their main english page [0] at the very bottom (in "very readable"
light gray on dark-grey ;-) ) says:
  "Rockchip Electronics Co., Ltd. All rights reserved"

Similarly their about-page [1] says:
  "Rockchip Electronics Co., Ltd. ("Rockchip", stock code: 603893)
   established in 2001 ..."


Heiko

[0] https://www.rock-chips.com/a/en/index.html
[1] https://www.rock-chips.com/a/en/About_Rockchip/About_Rockchip/index.html



