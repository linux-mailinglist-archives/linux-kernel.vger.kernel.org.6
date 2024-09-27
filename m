Return-Path: <linux-kernel+bounces-341296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD2C987DE8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 07:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D12280FB8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 05:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC053175D48;
	Fri, 27 Sep 2024 05:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="GH08yYRf"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83931155C8C;
	Fri, 27 Sep 2024 05:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727415599; cv=none; b=MAys9QXQWH9Dh2MGkAAjNKISHA4t0WPQ/TZGj/jCdwkrxzBHSqzz2TvJzgcFJ+VPLIeR6VBf+z8/08RYvF9UwRAUq3SHqr6WAf6W4P4Wh4x1JN6oUHePrnorgEHmfW5HK/1ALR7YWkYCjyMmYW/4DVf6CNCqwFqrOwp+gK7kv8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727415599; c=relaxed/simple;
	bh=+C9iEirer7WWTDLVeOU+IBm0fmDJCqg7sBx473BMwp0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cGU5KVcQttjs86KUTPwKS/a8AQ8T+H1HISOnrwrCfuIDfXsbH+X0wE/x1mXg1rCQdcI9/hUAsEdlQ39NZEfM5GYJsYBkW0gwLTbsw2wDCt6HjWhVnwbkJEpXklDNiURva/NL+Wij+esxRReIdatj5FM4C+xUtVisGrkOJzF4HFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=GH08yYRf; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1727415595;
	bh=m5OUpOetzsXoAqOByKCFgjROaGZzuqPSQlQ6mVDbpaE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=GH08yYRfIQqnc5tujy9F27me68bYTRmq2TOWuRaRmtfIhMUFZvgxGrgEekI7VjM90
	 SttVZaQqaInQ3IO2f37UvZw1C2OIwBqzclSurwhJDExm41AK6AXwN4xxrD7NJ8SRan
	 TH8KF6pJ3RZiPbAMlfn1BEWtndS4F5y/+vVFsge2ROcxRZh/7KLopgJU+aSq6Zzi3d
	 dXpdrqqeErxQAwXwuNIIVmHXpL9KmEZGqmQOx6ZOL0vYCeyScBfhKU1DlmX5RYSHT6
	 nCod4poQorxkFpfGNVXRMTFtxq5LuckHlCMauB3TA+DU70TFBOH6LPoyRhVFmH3gm6
	 kpp6Wl92cUvpA==
Received: from [127.0.1.1] (ppp118-210-187-73.adl-adc-lon-bras34.tpg.internode.on.net [118.210.187.73])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8B84265013;
	Fri, 27 Sep 2024 13:39:52 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: patrick@stwcx.xyz, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240926033534.4174707-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240926033534.4174707-1-Delphine_CC_Chiu@wiwynn.com>
Subject: Re: [PATCH v1] ARM: dts: aspeed: yosemite4: Add i2c-mux for
 Management Board
Message-Id: <172741559101.63677.6738786477314974380.b4-ty@codeconstruct.com.au>
Date: Fri, 27 Sep 2024 15:09:51 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

On Thu, 26 Sep 2024 11:35:33 +0800, Delphine CC Chiu wrote:
> Add I2C mux for Management Board to separate the I2C bus 35 for
> updating CPLD firmware and I2C bus 34 for the other devices.
> 
> 

Thanks, I've applied this to be picked up through the BMC tree.

--
Andrew Jeffery <andrew@codeconstruct.com.au>


