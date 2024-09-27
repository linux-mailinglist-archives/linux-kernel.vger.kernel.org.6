Return-Path: <linux-kernel+bounces-341236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06611987D12
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 04:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65289B240F2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 02:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CB2169AE4;
	Fri, 27 Sep 2024 02:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="AeYZcT02"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D29C8475;
	Fri, 27 Sep 2024 02:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727404493; cv=none; b=oJmiqVP6heS4v5FRSUpDwy9kspLDw6Pld/7mojw1tldxM2Ab+HwsrlVBMN8w6zQb+2/xxddAxzqkglvsor7AlOR9YIgDHsGop/jjeoiCPrdg7WoBKmzjD6Pp5oMlOYCQIgvgsChwz1BAfu4fMPgynnwAMVYeSQDSpAsB6xRTDi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727404493; c=relaxed/simple;
	bh=cMEsYJh4m+cup0mCLgLYh1SAKv6UOZYHDFedqTkwY4o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kaQ2cSJIqXmof+z+nbWJU7Xk2BuEW2s9GWoRmBtgrnfYQkxNj/WeEFOHwip4/DN6miTagPZZBv7HFSPtD8RFZ6ZgG78ZS8+hBdXSeNTO551oHghlajJzmzsp4jmM6cBMWjUX+h41ssULhNSRVibrIUx8N4RHu23ITSsEC271Clo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=AeYZcT02; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1727404482;
	bh=/Bt3CxeZRt+0nxxDBDZb8DllYxljljqK1Chhgqs4kUs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=AeYZcT02ar1DLIsdGiOaELWrURhKKgrWfy9kB+ZRL1iUbmXna0k+hDdgQ9Aqobwf6
	 NUpF0eB74md7+svmKMzBiq7PvsVSxJPp5lM5hhYVPr7s3sqsP+n4BYAnEIciAuFPxe
	 eR/zf6OB9PczuHPy8JAs67lFH67u9by76AIyBmC691qmC/eytYcKb6b5vYPF4WNc7e
	 wiXXuBwMZ0/jGTt94gUc7nKaDq0xxtjsLLsP6Pe9DISmmaNFVVulRgS2uxV3Pmn5yS
	 aqHAaVgsYMg3Y9CGN6dyAys6XlA5eRZWqKgz+mqO4Rc7pZsELAGqBZDaX50lqrUeI5
	 OXirtgkUh69Mg==
Received: from [127.0.1.1] (ppp118-210-187-73.adl-adc-lon-bras34.tpg.internode.on.net [118.210.187.73])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7B7826502D;
	Fri, 27 Sep 2024 10:34:41 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Patrick Williams <patrick@stwcx.xyz>, Potin Lai <potin.lai.pt@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Potin Lai <potin.lai@quantatw.com>
In-Reply-To: <20240926-catalina-evt-dvt-system-modify-v2-0-a861daeba059@gmail.com>
References: <20240926-catalina-evt-dvt-system-modify-v2-0-a861daeba059@gmail.com>
Subject: Re: [PATCH v2 0/3] ARM: dts: aspeed: catalina: dts update for EVT
 and DVT schematic
Message-Id: <172740448141.53211.18338631248150691317.b4-ty@codeconstruct.com.au>
Date: Fri, 27 Sep 2024 12:04:41 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

On Thu, 26 Sep 2024 15:10:43 +0800, Potin Lai wrote:
> Update Catalina devicetree based on EVT and DVT schematic changes.
> 
> 

Thanks, I've applied this to be picked up through the BMC tree.

--
Andrew Jeffery <andrew@codeconstruct.com.au>


