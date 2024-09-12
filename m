Return-Path: <linux-kernel+bounces-325823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4086F975EAB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 03:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B2DF1C22786
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 01:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212EF2BB1B;
	Thu, 12 Sep 2024 01:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Q5A+Vg9x"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E94257D;
	Thu, 12 Sep 2024 01:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726105948; cv=none; b=alXTMmqzQF/GKrfvXK8jYxZ+GpnaAFAYmxlPv7YjkWr8CFjoOPxubouHy3g4IdMfqosLJx9uiX4pvb4m9R+kOUGT2w+WYGSFRcq0sYlITHFh38j4D8Q4l3Wp+AtYRhJEDjTstAjay9nPbWKc3bEnJSe2Vi/7nZH86M5mGgT476o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726105948; c=relaxed/simple;
	bh=KOHru+WDJgBP+lLpgOajPKUPOkGltXyKZvX+5Qs0kKw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Tg0COvkYYy0GgnJ4cGvQXgx7+CAGxybE7gcQ0oivLV7PH5SOZrF1Xx3nZxIJSOy71SlBEzsKXxafbi7SZAptZ2HIjATcz8/RFoh+JkORg1LFXy++gSOuTH73jbJWEDaxO6/Cnu16W7Jyj67iacAnqNboFqC6i0g4saH8kePVwKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Q5A+Vg9x; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1726105943;
	bh=1GeFB29HWhumDKOdV+Pt4PnPumW3p49ZFqKR/fUZIws=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Q5A+Vg9xklu9nGYZwwkrRoivoF07C5SpEOD7nQh1keYfvyWHQAMfi+ne5k7vYwaw0
	 w8SWXZa5JQr+BbbPvwM3zVXLVdUxQhgAhA8l+g39H5QO2gAyDU8C7IgBkKDo1nkm3E
	 OfWIhzwEN+LY70Pjo0xQuT1KS2ddh5R1kLB/OyRghSC5+4/Vs0x4bDcNFYnfBzFcxz
	 GUvLGSfn1MF3+3TV4Xq58EsKFKm+kLsMIou9PpooLmLyixdI92llR8wLhNJznKAfWb
	 nNbAeJ2NxBFwCpbf13S93dID4Dl2A3ml0G6ELXruHz7EWRf6bpZEOMH6F5HgjwTypU
	 VEJMJkvGmUSfQ==
Received: from [127.0.1.1] (ppp118-210-89-8.adl-adc-lon-bras32.tpg.internode.on.net [118.210.89.8])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E1FD3650D6;
	Thu, 12 Sep 2024 09:52:21 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: patrick@stwcx.xyz, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240910080951.3568594-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240910080951.3568594-1-Delphine_CC_Chiu@wiwynn.com>
Subject: Re: [PATCH v2] ARM: dts: aspeed: yosemite4: Enable watchdog2
Message-Id: <172610594183.699144.11293347477612952253.b4-ty@codeconstruct.com.au>
Date: Thu, 12 Sep 2024 11:22:21 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

On Tue, 10 Sep 2024 16:09:50 +0800, Delphine CC Chiu wrote:
> Enable watchdog2 setting for yosemite4 system.
> 
> 

Thanks, I've applied this to be picked up through the BMC tree.

[1/1] ARM: dts: aspeed: yosemite4: Enable watchdog2
      commit: 38534704e809d3f253ba131ae1ee8dfb79969166

--
Andrew Jeffery <andrew@codeconstruct.com.au>


