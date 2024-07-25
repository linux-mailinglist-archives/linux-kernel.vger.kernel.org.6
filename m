Return-Path: <linux-kernel+bounces-261662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE93093BA75
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 03:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56951F222FB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 01:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B019AC8F3;
	Thu, 25 Jul 2024 01:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="WRMoVOAf"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781764428;
	Thu, 25 Jul 2024 01:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721872751; cv=none; b=fV+n8lh3lo+iwxp+VbD3fTo5PPnAX+b+q8jlWo9q8YpfiOQAh7Lj9C+GEqdCUwadzSoeC0kgDwqsm5N1i+vMs7qJOIoOMhXafo2jVjU1QjdFjKkYjlBHgCKDFYEEywgrJpqXdBjSCxLjsNu3Y85jcE8vcHRPpOzN3K6P561qlT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721872751; c=relaxed/simple;
	bh=qBhaZMviwHZ43OK4gVFL/py0L1GUd1txby0hMg+0/WQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lktYgGEYBfDYZA6h7QGKbS+i1lRPsTkvYvzXWwmj1ObUrl5KsVO6DkLbMMukNqp09m4cba3l5pZKp/3Ouwpsrv8gncGdMjLL3PEQjZQ8tB/Jdw2NctSP7ZUcIdXhHRich0BmYCmD7q0Ec7zc7DHjTP9+4Si0/odtNA9DVjU8ETw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=WRMoVOAf; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1721872329;
	bh=Z3ooCPkfUhbJkl7PxDObcq/dMiqmdHgfLl7Tb+HWoe4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WRMoVOAfRkT90uvkWi0GHYSYwFda8xGZaEMIPhM+q5x/OYIc7J873svet3gR6Vy2s
	 4yUmDgCQN5bS/6gm55jN4ZIpyzBXKMqUT+as8TABn7pXyWMme18tyq0B1gFxNMbVQh
	 TrTJ59vnDApwxk+iaokaA4Vu39+AzmGXH+oDaV29oi26zH4BQDoB573ddb3RVcYYpj
	 Wd7Y1DykOjTPtt1r6sf7VNiDfAGZVJiraMemxmEz80XTCAlzMY8NuEMEQLAJJ449E/
	 vEYTCgQ4sjAwbZjcilQy0oDrfVzl6skZqK0Tvuyg4a/Chkd+mzvDuGFsVm5T9gSGxn
	 e15eA84pfxOFA==
Received: from [192.168.2.60] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id ED42B66AB4;
	Thu, 25 Jul 2024 09:52:07 +0800 (AWST)
Message-ID: <3483626b81037205679c4d38678f2e3529d53e14.camel@codeconstruct.com.au>
Subject: Re: [PATCH 2/2] i3c: i3c-hub: Add Renesas RG3MxxB12A1 I3C HUB driver
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Steven Niu <steven.niu.uj@renesas.com>, "alexandre.belloni@bootlin.com"
 <alexandre.belloni@bootlin.com>, "linux-i3c@lists.infradead.org"
 <linux-i3c@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, 
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,  "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
Cc: "zbigniew.lukwinski@linux.intel.com"
 <zbigniew.lukwinski@linux.intel.com>,  Alejandro Gonzalez
 <alejandro.gonzalez.wg@renesas.com>
Date: Thu, 25 Jul 2024 09:52:07 +0800
In-Reply-To: <TYTPR01MB109893062FB3F0D4141444219BAAA2@TYTPR01MB10989.jpnprd01.prod.outlook.com>
References: <20240217131412.4145506-1-steven.niu.uj@renesas.com>
	 <20240217131412.4145506-2-steven.niu.uj@renesas.com>
	 <bae054d217aa577838593244eda02b008e3749a5.camel@codeconstruct.com.au>
	 <TYTPR01MB109893062FB3F0D4141444219BAAA2@TYTPR01MB10989.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Steven,

> Apologize for the late reply. I am out of work for a long time
> because of my personal emergency. I am back at work now.

No problem at all; Sorry to hear it, I hope things are okay now. Thanks
for getting back to me though!

> We are working on the following items after the first submit of the
> patch:
> 1. Modify the binding file to make it focused on the device
> description instead of driver description.
> 2. Fix the codes which doesn't following the kernel development
> rules.
> 3. Re-implement the SMBus Agent function with IBI mechanism instead
> of polling.=20
> =C2=A0=C2=A0 SMBus Agent function requires the driver to check the status
> register of the I3C hub. Polling the status register over I3C bus
> exhausts too much bus resources. I3C Hub supports reporting status
> changes with IBI. This shall be supported in the driver.
> 4. Remove the i2c slave-mqueue module.=20
> =C2=A0=C2=A0 The slave-mqueue module is used to provide a user interface =
for
> SMBus Agent slave function. But it has not been included in upstream.
>=20
> The first two items have been finished. And we are working on the #3
> and #4.=20

OK, sounds good. I have a few structural suggestions; some of these have
been covered by others' reviews too, but to summarise:

Specificity: it looks like you're proposing this as a generic i3c hub
driver, but I don't think that's the case; as far as I can tell, it's a
Renesas-specific design (and IO interface), so you want to reflect that
in the naming & config options.

which leads to:

Binding: the driver cannot match on the I3C hub class BCR, as that
doesn't specify any sort of register/behavioural interface. If another
hardware hub was implemented, using the same class BCR, this driver
would conflict. You'll need to match on vendor/device IDs instead.

Existing infrastructure: you're re-implementing a few common bits of
kernel infrastructure with this change; for example the LDO settings can
use the regulator devices instead. Is this included in your (2) point
above?

Configuration: as you've noted, the run-time configuration of the device
doesn't belong in the device tree binding in most cases. In fixing
those, there are a couple of approaches:

 * when moving to existing infrastructure (for example, the regulator=C2=A0
   and/or pinctrl devices), the consumers of those devices can request
   the correct configuration anyway, so you don't need to worry about
   the specific configuration chosen

 * for other runtime things, such as the downstream port configuration
   (in i3c mode vs. SMBus Agent mode) may be better exposed via configfs

 * for things that do belong as new properties in the device tree, you
   want numeric values (with an appropriately named property) rather
   than strings.

 * there may be other configuration settings that don't sit well in
   above categories, best to discuss those here.

SMBus Agent i2c interface: the controller side looks fine, but the
device side should be implemented as i2c_slave_event() events on the
same controllers rather than the i2c-mqueue device (which isn't
upstream, and doesn't look likely to be).

Happy to provide specific feedback as you go, but it's the maintainers
(Alexandre and Krzysztof) that will have the final say in design and
style decisions.

Cheers,


Jeremy

