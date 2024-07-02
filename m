Return-Path: <linux-kernel+bounces-238273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9719247BB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 20:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B13571C24FCC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 18:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2070B1CCCD7;
	Tue,  2 Jul 2024 18:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRdeVJpG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9CB1BF31D;
	Tue,  2 Jul 2024 18:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719946723; cv=none; b=DxABgzjuCVZ6BRJuEGjKiUTSv9s2vu9LfsDJWlce19wvAnZ5quq/sB97aw3P5RbP9T9w/0to+p+zwjot1Z6VCCjH/SynaAO7L2Dz66RDaFUiqgpHVI6IPKwP2/ivltLclOHF0MSN1xuPivPsdm3hGicvNh4L0JwgW8rDFegXs1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719946723; c=relaxed/simple;
	bh=Ar3wR6ASOgGCK1m2Gm9pQgjh2S7TBujxoLQT+MNP91A=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=mYTU6u3OrGaWXfPEiwkkUStkmwuQouO1hC1mUo+ojWEBHgGIiDWLtEtVrg5p75XO+VeZ/xH8Mr5rAmL1FKn1m+y/6290GesTjeGIPgUbBJpdamgxspCN/9nGpDczP6NLp8B6NT+k1Sxl1hOG/FrbMSJtbLgCvMVSZIheOs9Akn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRdeVJpG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7113C116B1;
	Tue,  2 Jul 2024 18:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719946722;
	bh=Ar3wR6ASOgGCK1m2Gm9pQgjh2S7TBujxoLQT+MNP91A=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=QRdeVJpGkXLXZJEgLb1vSgrUq0fILUNypj0FCUeD5bapgGZNVHY/zDXNwa7RW5QO0
	 m/RZcgWpXfPOTf+XrS9i5uvdkjI8axpobNWyezOyWiD0p7NI+i40atSXzTHPWBzBsC
	 lzTn1uEm1sueLHmZZaaclbUZHmfLcnTZfWrB6kmTabBDL2jDBGrozp5dZsAB2W6XUf
	 c967mc/EZAbohZrO9lPxo0y8OJnXG4T44LSxzPwLLPbdH8NiqoWO1iqdSlWLJALnmn
	 w938MaezXitd7rn5N6USyPrUuhrYmoPmu7kGoFyLFp0om0E64nPIRBvbCn40lhduOc
	 CXUr+vQljQ2TA==
Message-ID: <217a785212d7c1a5b504c6040b3636e6.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1jikyhp0pc.fsf@starbuckisacylon.baylibre.com>
References: <20240516150842.705844-1-jbrunet@baylibre.com> <20240516150842.705844-9-jbrunet@baylibre.com> <68518f93af68cbc0153c8bd765dc885f.sboyd@kernel.org> <1jikyhp0pc.fsf@starbuckisacylon.baylibre.com>
Subject: Re: [RFC PATCH 8/9] clk: meson: add auxiliary reset helper driver
From: Stephen Boyd <sboyd@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, Jan Dakinevich <jan.dakinevich@salutedevices.com>, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 02 Jul 2024 11:58:40 -0700
User-Agent: alot/0.10

Quoting Jerome Brunet (2024-06-10 03:10:55)
> On Wed 29 May 2024 at 18:01, Stephen Boyd <sboyd@kernel.org> wrote:
>=20
> >
> > I'd prefer we move the device creation and registration logic to
> > drivers/reset as well. See commit 098c290a490d ("clock, reset:
> > microchip: move all mpfs reset code to the reset subsystem") for some
> > inspiration.
>=20
> Ok but if it lives in reset I don't really get the purpose served by the
> auxiliary devices in that case. Why not export a function that directly
> calls reset_controller_register() in that case ?=20
>=20
> I thought the point was to properly decouple both sides.

Yes.

We use auxiliary devices so that the clk and reset drivers are
decoupled. Calling reset_controller_register() directly must return
success, whereas creating a device _should_ only fail if the device
couldn't be created/registered. It's less likely to fail with an
auxiliary device. This also allows the clk driver to be a module and the
reset driver builtin if, for example, the reset framework doesn't
support modules. Another benefit would be moving the probe context to
another thread if it can be async.

>=20
> I don't have strong opinion about it, TBH. It is just how it made sense
> to me. If you are sure about this, I don't mind changing

It seems better to put the device creation in the same file as the
driver so that it's further decoupled from the clk driver and
consolidated in the reset directory. This way, a single API is the only
thing the clk driver uses to create the reset device, instead of putting
the matching string for the device and driver in the clk and reset
drivers and having to know that the auxiliary bus is used.

The downside I see is that the clk driver can't be builtin if the reset
driver is a module. I'm not sure that's really a problem though. If it
is then we can make the registration API into another C file that still
lives in drivers/reset that has another kconfig symbol.

>=20
> >
> > One thing I haven't really thought about too much is if they're two
> > different modules. One for clk and one for reset. If the device
> > registration API is a symbol the clk module depends on then maybe that
> > is better because it means both modules are loaded, avoiding a
> > round-trip through modprobe. It also makes sure that the drivers are
> > either both builtin or both modular.
>=20
> I have checked with the current implementation, if the reset driver is
> missing, the clock part does not fail. Registering the aux device
> succeeds in clock but the device never comes up (duh). So it does
> not crash, the consumers of the aux reset device will just defer.
>=20
> Said differently, the '#if IS_ENABLED(CONFIG_RESET_CONTROLLER)' in
> clk-mpfs.c was not necessary ... it was removed in the changed you
> linked anyway.
>=20

Cool.

