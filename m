Return-Path: <linux-kernel+bounces-205916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC04C900224
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BF2FB246B5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B1318C326;
	Fri,  7 Jun 2024 11:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QJW606xc"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529FB15B127;
	Fri,  7 Jun 2024 11:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717759726; cv=none; b=piSwfIB41EtdoPIxotR4MnCWPKkp3koBYWRoctnqoKFqNyIe3bAaQgU1MSAcykbqLfOR0QGJscIr7gBUZpdhBTomC+T57Q+Y4vv4BnSBFf81IvfJKnUgFZ2E9sLy7RJcPwf7Yv1NRN0x7vPnJpvVGHu71JW7u6tiuwY+JU8Q23k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717759726; c=relaxed/simple;
	bh=8Z5iJEZWYuzdQo1qOjmBdsXY1Ha0sWF1gHheR8vm0Zs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVxNUN/8+0JbchuL+FQSv0EuQBpJQM5BZTeIYATPLFVY7sIS3yXY3+beLul+uQe9qEhHd2tsQt7vGNLE8y9RhnFun83DsgLsFYzAMGxMcJucl10eghc2xO1Idwmbrcp/migdTnZLXz3q3NAXtPO4wYEY0LiJHITeFwO5BvGpggk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QJW606xc; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 457BSa7M091775;
	Fri, 7 Jun 2024 06:28:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717759716;
	bh=WGlF8+GJkHVfeFjfWNrZMjHbi01VWT2jUmPu//YWwwM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=QJW606xcNstiB3bhr1XyeX5ipmThRwBvgcAAn5ydXCT1X6cPK5MdVeDGG4UotoZ9j
	 ENatJ4RBK8rO2+po2Kc3H7nP6AonQNZpdPtcJJrh4NNBxCXR2blFekTifPM3A10HDr
	 0V7WzoHPLDdiBcFMXhNS1ew6qMjwfD7k0Lxcdj6k=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 457BSanu025666
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 7 Jun 2024 06:28:36 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Jun 2024 06:28:35 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Jun 2024 06:28:35 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 457BSZh8108543;
	Fri, 7 Jun 2024 06:28:35 -0500
Date: Fri, 7 Jun 2024 16:58:34 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <afd@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>
Subject: Re: [PATCH v5 1/7] arm64: dts: ti: am62p: Rename am62p-{}.dtsi to
 am62p-j722s-common-{}.dtsi
Message-ID: <902f024a-b0a1-4a0a-94e2-7cec064a91c6@ti.com>
References: <20240604085252.3686037-1-s-vadapalli@ti.com>
 <20240604085252.3686037-2-s-vadapalli@ti.com>
 <92af5f36-0c21-4b6e-adde-fcf21b540291@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <92af5f36-0c21-4b6e-adde-fcf21b540291@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Thu, Jun 06, 2024 at 10:51:27AM +0300, Roger Quadros wrote:

[...]

> >  5 files changed, 10 insertions(+), 7 deletions(-)
> >  rename arch/arm64/boot/dts/ti/{k3-am62p-main.dtsi => k3-am62p-j722s-common-main.dtsi} (99%)
> >  rename arch/arm64/boot/dts/ti/{k3-am62p-mcu.dtsi => k3-am62p-j722s-common-mcu.dtsi} (98%)
> >  rename arch/arm64/boot/dts/ti/{k3-am62p-wakeup.dtsi => k3-am62p-j722s-common-wakeup.dtsi} (97%)
> >  rename arch/arm64/boot/dts/ti/{k3-am62p.dtsi => k3-am62p-j722s-common.dtsi} (97%)
> 
> This is not correct.
> If J722 has different CBASS components than AM62p then we should leave k3-am62p.dtsi
> as it is and introduce a new k3-j722.dtsi with relevant CBASS components.

Roger,

The existing hierarchy prior to this series is as follows:
k3-am62p.dtsi = k3-am62p-main.dtsi + k3-am62p-mcu.dtsi +
		k3-am62p-wakeup.dtsi + k3-am62p-thermal.dtsi + <delta-1>
k3-am62p5.dtsi = k3-am62p.dtsi + <delta-2>
k3-j722s.dtsi = k3-am62p5.dtsi + <delta-3>
k3-j722s-evm.dts = k3-j722s.dtsi + <detla-4>

Based on your suggestion, you seem to propose the following hierarchy:
k3-am62p-{main,mcu,thermal,wakeup}.dtsi = AM62P specific data
k3-am62p.dtsi = k3-am62p-j722s-common-main.dtsi +
		k3-am62p-j722s-common-mcu.dtsi +
		k3-am62p-j722s-common-wakeup.dtsi +
		k3-am62p-j722s-common-thermal.dtsi +
		k3-am62p-{main,mcu,thermal,wakeup}.dtsi +
		<delta-5>
k3-am62p5.dtsi = k3-am62p.dtsi + <delta-2>
k3-j722s-{main,mcu,thermal,wakeup}.dtsi = J722S specific data
k3-j722s.dtsi = k3-am62p-j722s-common-main.dtsi +
		k3-am62p-j722s-common-mcu.dtsi +
		k3-am62p-j722s-common-wakeup.dtsi +
		k3-am62p-j722s-common-thermal.dtsi +
		k3-j722s-{main,mcu,thermal,wakeup}.dtsi +
		<delta-6>
k3-j722s-evm.dts = k3-j722s.dtsi + <delta-4>

Please let me know whether the above organization of files matches what you
expect it to look like. I will post the v6 series based on your feedback.

Regards,
Siddharth.

