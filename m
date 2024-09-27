Return-Path: <linux-kernel+bounces-341544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0196988178
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 11:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69FB31F229FF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2D01BAEC0;
	Fri, 27 Sep 2024 09:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="wWkJ8JfG"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80C516B75C
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 09:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727430001; cv=none; b=IQAehel14PGq/HERtk60gmlB/frC8tHrTymb3S3d9/5IDj1f/JATuvWbn6VMS2UGmha3t9rBVVZLSYbO+fUeImS1In/+mCo2X9sCkYsCd+XpFU8YyuKTgEqEctTcq2DMbeLW9BIHc1zAi6n7TWcX7Ih2xquXj5evMj4osWxljRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727430001; c=relaxed/simple;
	bh=c3rDj6pBhQHIXVdX4ihZqufP9PL/KRZKAWitxrODIpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XZrBhcvA9FoQ4uX2/UNUjX4E/Po5t8SF8tLWKEzjMNIGrGmuDQD9eh0n57rh6TZ9ZXQ8ty0YHPCnU8urL0kT4hjJOJ5LK6Ykgy5ciKUdscwnxLpvtO4eE1Ih5DskEly95hTMcCLZUaA+cm3vGRyqynh0HEAdQo46q07VD/ys0xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=wWkJ8JfG; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2cWhXr6AROsolgkQ2supnsF0SMEDxH/xJbk04hs3JOA=; b=wWkJ8JfGUqJeuSR1vg/HSR6UjT
	ls1EHMln/amI1/Jn6vbGnqNl2NfYYp2/9SMN13Al2xKUAxbxZLxT6wEbTeXPGyjPA83jCAK8O7LCw
	MxXza+mXGq9PD23ic2G/tsgO7wmvCj9H1YJRY1D6W0PGwU87wncj2h/xyyCwPRpEDbaQpVvmRhcDm
	lqIdADkamvti+VIm+tUGXXMA/XSFEF3JZIsWo0hcgaYesnMR2cPhMJB3BqjlYz84WHzA+g95JhPkq
	ijaSSoWchztneE0cPf66XvjeO/EBkvbjv9oAJgfE1/USDpkAChObIvSqs/FszB3Ltdup/z8PYswNq
	NhXx4Xnw==;
Received: from 85-160-70-253.reb.o2.cz ([85.160.70.253] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1su7S3-0001cH-0H; Fri, 27 Sep 2024 11:39:51 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Jakob Unterwurzacher <jakobunt@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
Subject: Re: [PATCH v2] arm64: dts: rockchip: add attiny_rst_gate to Ringneck
Date: Fri, 27 Sep 2024 11:39:49 +0200
Message-ID: <3885598.FjKLVJYuhi@phil>
In-Reply-To: <050724b3-aed6-41d3-b2b4-18b90fbf0ad3@cherry.de>
References:
 <69f79284-b52e-496e-a286-d7e5ce3d90ce@cherry.de>
 <20240926132028.21910-1-jakob.unterwurzacher@cherry.de>
 <050724b3-aed6-41d3-b2b4-18b90fbf0ad3@cherry.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Donnerstag, 26. September 2024, 15:24:03 CEST schrieb Quentin Schulz:
> Hi Jakob,
> 
> On 9/26/24 3:20 PM, Jakob Unterwurzacher wrote:
> > Ringneck v1.4 can contain (placement option) an on-board ATtiny
> > microcontroller instead of an STM32. In normal operation, this
> > is transparent to the software, as both microcontrollers emulate
> > the same ICs (amc6821 and isl1208).
> > 
> > For flashing the ATtiny, the SWITCH_REG1 regulator of the board's PMIC is
> > used to enable the ATtiny UPDI debug interface. If the STM32 is placed, or if
> > we are running on an older Ringneck revision, SWITCH_REG1 is not connected
> > and has no effect.
> > 
> > Add attiny-updi-gate-regulator so userspace can control it via sysfs
> > (needs CONFIG_REGULATOR_USERSPACE_CONSUMER):
> > 
> >    echo enabled > /sys/devices/platform/attiny-updi-gate-regulator/state
> > 
> > Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
> > Tested-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> This is a candidate for backporting to stable branches as well I assume, 
> @Heiko?

That is more on the darker side of gray here.

Looking at the stable-kernel-rules [0] the criteria is
  "It must either fix a real bug that bothers people or just add a device ID"

This change instead is adding a new feature to allow said flashing from a
running system.

sidenote: please don't post new versions as replies to previous versions,
as that confuses tooling a lot.

Heiko


[0] https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html



