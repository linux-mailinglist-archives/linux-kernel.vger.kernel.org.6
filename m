Return-Path: <linux-kernel+bounces-444292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3F39F0435
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 06:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A6CB1626FB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 05:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBB6188A3B;
	Fri, 13 Dec 2024 05:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="RABT6iUr"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22F01885BD;
	Fri, 13 Dec 2024 05:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734067713; cv=none; b=XixXIK9mhnaFgNI1N7OvsS6z39BjiqbasB0DE38MU4Mcut/zDUxO2ahdoFOj7cTL5PTh34edZ7bFMl6O02VqfT9UI4q1VpjhwvC0quvrACgrpCz3HYqJazh8T0VNLSS2TDkSPbMmbGmXukMl6CLghSh04croLyfQTaihxu1l5q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734067713; c=relaxed/simple;
	bh=XedtNYb0vFCscpjSM9Xc2nrG3kPnFTOBPoEb9djnsBw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Y6E7qfrZOtKmf8gYNYIIacvAXTVDj6R9bCnxw3WKpUruENPUkq1xxxGsbFOq/OVOHI5YsboXOTKpoVxQiF+UyGqWWtsDC+oQSp9aGcU2iZQfmujjXVMypX7zP19Zn5ztFS/DMvn1ivIWJlUEblHueT4McYMd0r2HObAdC9IALac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=RABT6iUr; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1734067709;
	bh=nD0sOR12WYgd7zNnRDb+Fa3B5asY+3ux+m3WDu2HAKk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=RABT6iUrzTl2BIniPxxi7HRX7TTQnO84EHOkzY2A7mKbGGFTfQHSgCTIem2/ICF0j
	 yVg1PPKG6vT2exDF5kAmrG0/VYhN7Gku0+eRGLfaUJeNd+w4idR+8EXV9hoiWfruGc
	 egThsSDasfF1WM0WmcK6Bfksn7cR/g8Vnxg0T5G+F1Ir5Cuy1WL1XqWlZ4BYsAVMWK
	 XbySBkGWrgD8nj+qk/uaSIF9UhQKjWujaIs6mq6if0TFVzrKo4Rc+ZJI9U0TIPYUu1
	 hTK/XW3J0ywWiRrq31OCrG2tyu4GmIVQwNdnSMgOMJzf3PHgsl7Qwydzzjdbn6jn3k
	 aTkWJNrEmUpbg==
Received: from [127.0.1.1] (203-173-6-153.dyn.iinet.net.au [203.173.6.153])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D83736E54C;
	Fri, 13 Dec 2024 13:28:28 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 conor+dt@kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, patrick@stwcx.xyz, amithash@meta.com, 
 Yang Chen <yangchen.openbmc@gmail.com>
Cc: Jerry.Lin@quantatw.com, yang.chen@quantatw.com
In-Reply-To: <20241212133226.342937-1-yangchen.openbmc@gmail.com>
References: <20241212133226.342937-1-yangchen.openbmc@gmail.com>
Subject: Re: [PATCH v1 0/4] Revise Meta (Facebook) Minerva BMC
Message-Id: <173406770843.422541.3788323988670647121.b4-ty@codeconstruct.com.au>
Date: Fri, 13 Dec 2024 15:58:28 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 12 Dec 2024 21:32:22 +0800, Yang Chen wrote:
> Revise the linux device tree entry related to Meta (Facebook) Minerva
> specific devices connected to BMC (AST2600) SoC.
> 
> Base on:
> https://lore.kernel.org/all/172722509817.374662.7338401100529556748.b4-ty@codeconstruct.com.au/
> 
> Yang Chen (4):
>   ARM: dts: aspeed: minerva: add i/o expanders on bus 0
>   ARM: dts: aspeed: minerva: add i/o expanders on each FCB
>   ARM: dts: aspeed: minerva: add bmc ready led setting
>   ARM: dts: aspeed: minerva: add second source RTC
> 
> [...]

Thanks, I've applied this to be picked up through the BMC tree.

--
Andrew Jeffery <andrew@codeconstruct.com.au>


