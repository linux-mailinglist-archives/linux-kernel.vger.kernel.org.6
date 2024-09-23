Return-Path: <linux-kernel+bounces-335347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE7F97E467
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 02:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39E87B20D2F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 00:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144642F44;
	Mon, 23 Sep 2024 00:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="TCpJPEX1"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092F2372;
	Mon, 23 Sep 2024 00:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727052134; cv=none; b=AEmhi3GNai0p8ST5M2uvwnVJ4sEudG0n1XtDPvDiBt/L2xUtRvD2M1dIuQYC2pbhfn4ZFWVFvm9hcy36BJnD6wPl5Yq3uaSzcYZEqo4F50YkrMF4WlYGWriJEPXZUR/GamgheiRfFjvpvOrF5ZCZEheyZqMhBd1NptgfpLJN2r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727052134; c=relaxed/simple;
	bh=+Cqa531dLRfbqft9CD15H+Nq3B3CJgHSvH4o/2n74xA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=troO+FQL2H6E5XNWNt2CxvNhmuoX4HhPCKScZrRRfZjFImPtIy9xHY7VngMmamMND5R2Ebbyo7CIOu92QpENvxa2PXU0wr+x3ld85CIKWOUwpraBrE6heXRZGTl7LmC7n+1By84UY9T8sTzpu4+OVtUkrkhhtaVbBBSlTpNrMQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=TCpJPEX1; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1727052130;
	bh=vBTcWXfAX/Of7UXHfGEZxY/8XoDeqqNxmQWzQQsQ7uk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=TCpJPEX1xFhafjbEHITGVvsxf3aoLQBHm7eczRdT5C6SflAs8JBEKr2HXyFRgF9QH
	 FL3bpkEU92HSY0/ZWhPXmPk6k1d/EKm5/EZ5i3qDs3LvIrTw8cMI1jqwRd4MuHtADS
	 3Fb3qy6DfrJva9SaxrOuPHeyXTNB3JF9jCsaYKpKkgAzFz11LF2kha621YZokyAQhP
	 u3wU27oPCb/NFLabXdxOU2e5FeykX4hszKtJ729eXJoV26li4w4MazR8Z2iwbjg9wm
	 HRBOXOH7O1Bvk81FdiCBtHaHUzezFDd8xXZNsotS6jXHupc3TdwuLzVVzfRxMuWX/5
	 ZaJSIhyuIhZdA==
Received: from [127.0.1.1] (ppp118-210-177-92.adl-adc-lon-bras34.tpg.internode.on.net [118.210.177.92])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E8820640E8;
	Mon, 23 Sep 2024 08:42:09 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: patrick@stwcx.xyz, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240920085007.1076174-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240920085007.1076174-1-Delphine_CC_Chiu@wiwynn.com>
Subject: Re: [PATCH v1] ARM: dts: aspeed: yosemite4: Revise adc128d818 adc
 mode on Spider Board
Message-Id: <172705212979.81175.5974392458583781139.b4-ty@codeconstruct.com.au>
Date: Mon, 23 Sep 2024 10:12:09 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

On Fri, 20 Sep 2024 16:50:07 +0800, Delphine CC Chiu wrote:
> Revise adc128d818 adc mode on Spider Board according to schematic.
> 
> 

Thanks, I've applied this to be picked up through the BMC tree.

--
Andrew Jeffery <andrew@codeconstruct.com.au>


