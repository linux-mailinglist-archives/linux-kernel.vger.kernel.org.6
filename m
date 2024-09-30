Return-Path: <linux-kernel+bounces-343388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01710989A65
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284001C2133A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 06:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EB414375C;
	Mon, 30 Sep 2024 06:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="XLQdj67u"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6424C153803;
	Mon, 30 Sep 2024 06:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727676128; cv=none; b=Kp1brDQre3IxckNOgNwZZuJtVmR1JVlWg6a0Y+qxYxpTYZqz/qfSNjXX2fcmKoC8bgHYkkHjxwlb/ka6elUKPA3FnpEaj4YApjGUqWlF8yGW97NkoRrGaB1yA60wMuZp1fPd0hQs8+FNdXGJ8GPcPv3OuoJld4yZDYUddaxqUfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727676128; c=relaxed/simple;
	bh=0FIVczdjZnCRLTZ3CDy6YJYArxaNWoYo7j0LdVqWlTs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lSdyJq7dSFXcwR5Tuh5y7lQWKOjAug+H6FsOXQ9sKZqAsWhsibSYA4/wLK1iXz6KGNLV5jYUsOKHi9spnshkqOQaIfWr77rh3zDmq0PgKzeW5+9y0CstWGL+fM1dy9sDxRVumHOPMyAbX6YRlKHckiX1zXQ81JGxKroQHMe3jhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=XLQdj67u; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1727676125;
	bh=0FIVczdjZnCRLTZ3CDy6YJYArxaNWoYo7j0LdVqWlTs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XLQdj67ubHBsQPOaEGpb9XFb3TW3Q0pRmnam5ggOpYNaYCaEzpUVSFchAkT9RZTXw
	 6ooxsvRM2k1wmby0nyBhsjGbQysYXi7gpn7pPUaPKm52IDsv5/sasjdqWxOxl4uCDp
	 BloCEd5jneNt8BKMYAbMUYnJEKlRxFRqIHBdFd3+1GqdCFTgh5Y7ABJpHKmHFR9Yxz
	 PFMdNyD2XZKAqYPWxDqRtIg9GPEAvp+W1NDO1PQ8KT2v694TnCvyutaUuqavt/zGTd
	 PU/bcP1sNHkd4JbyMiTuNkoAuFg8TcEfTC7uZotIAEoTcqrZDWbkZVSaW7h9dSb8Gl
	 h3yDFIDwSqpbA==
Received: from [192.168.68.112] (ppp118-210-73-17.adl-adc-lon-bras32.tpg.internode.on.net [118.210.73.17])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E9EFC6511E;
	Mon, 30 Sep 2024 14:02:02 +0800 (AWST)
Message-ID: <81b9916f299bbf29583aba610c0147c8b8afd092.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1] ARM: dts: aspeed: yosemite4: Add i2c-mux for CPLD
 IOE on Spider Board
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>, Patrick
	Williams <patrick@stwcx.xyz>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Ricky
 CX Wu <ricky.cx.wu.wiwynn@gmail.com>,  "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
 <linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Mon, 30 Sep 2024 15:32:01 +0930
In-Reply-To: <TYZPR04MB5853D743126A23AD41BE3E0DD6762@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20240926024133.3786712-1-Delphine_CC_Chiu@wiwynn.com>
	 <fbdc9efe87a1bed9fea7d0abaf955aa1a3dc24ac.camel@codeconstruct.com.au>
	 <TYZPR04MB5853B51141F3D0610D970265D66B2@TYZPR04MB5853.apcprd04.prod.outlook.com>
	 <Zvdq7o6NFXRVCJqX@heinlein.vulture-banana.ts.net>
	 <16c89a7b9b85d21f1f23aa0d67742c6bde94a295.camel@codeconstruct.com.au>
	 <TYZPR04MB5853A70A99CEDE8EB64A317DD6762@TYZPR04MB5853.apcprd04.prod.outlook.com>
	 <ef0e0be6cbdcf410ca7854884f32da0e3cf6b295.camel@codeconstruct.com.au>
	 <TYZPR04MB5853D743126A23AD41BE3E0DD6762@TYZPR04MB5853.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-09-30 at 05:55 +0000, Delphine_CC_Chiu/WYHQ/Wiwynn wrote:
>=20
> I have one more question that if I need to add the DTS based on the patch=
es that
> have been applied but haven't been merged in torvalds/linux.
> Should I also based on the branch "for/bmc/dt" from amboar/linux to creat=
e the
> patch?
>=20

You can do that, yes. We can at least then be sure your work won't
generate conflicts when I try to apply it (unless you've
inappropriately split your series).

Cheers,

Andrew


