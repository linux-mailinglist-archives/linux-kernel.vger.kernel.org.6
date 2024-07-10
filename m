Return-Path: <linux-kernel+bounces-248193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A4A92D992
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7870C1F22D53
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F416E196C86;
	Wed, 10 Jul 2024 19:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3Q4UuV0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43191197A7B;
	Wed, 10 Jul 2024 19:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720641314; cv=none; b=ci/YGuoZajAgK3+y3jaGV4TBp4Js1zeOUuTSZB8jbtqvbMofXmKLIeUOrZkxjw529zINoYCVh7KPZdY/+KBpP/N/4Ec5Z145ICYRDfXcD3ixpTOW821UP1WnnqsgXffyy9/5JtA4DV/6pzv+feQRmadm1+tFGqWpziBNVFLGVSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720641314; c=relaxed/simple;
	bh=Fc7WfJ8WjVBITAc0LsbpI3K1B9HOodEyCX17XluKf04=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Iu0RM/TLw6aF1m5b2giZRqzUeGJOXclPiBELDe2Rbm5B60asxyjLs5zqArtSMPLW8HxxgH5vDsRMtPH3dtXUNLHzIvFbA/zcnOnu+VrsvjPlecjKlzguQGyPGLXlEmbHAsYF+sl/Jj2A3mn9X70FNpj9xMw+FMBxpBk3sU0BIIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3Q4UuV0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E7AC32781;
	Wed, 10 Jul 2024 19:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720641313;
	bh=Fc7WfJ8WjVBITAc0LsbpI3K1B9HOodEyCX17XluKf04=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=M3Q4UuV0M3RAF8AKCVkJ7WG4OhqbcRfmEvgM8BJ5BJtQy/q/L+Po9Or55IagShd7c
	 lV38juDbgZYUkZu266ZJFYeZZ2DCOskTRdNciD+en3ZMyjEf8A+N3wNNTTjf/6oR9e
	 WREY5qV+y5ynuhss7J1545RALDOSrIzXfi6IalbEWzYGgHRBXFypGtpoURzgACFB5N
	 +ZnHUkcEWpcQwA70wJttVYYZpIyF0rw1pI21wHRcrkUSeIvA94X2FZsS8KjsHD8Lns
	 i4JNmNmuWgiX6NFtGkkY7CGurUeYLGYvxE73ePKi48SN4r2RDMgeMyWMPd48tj4hI1
	 o7qwe2r30DulQ==
Message-ID: <8e10f0736ea87ed3f7cea4cac506fc24.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7f2bf860ffaccd10899b72fdda6a3ca9c50d2107.camel@maquefel.me>
References: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me> <20240617-ep93xx-v10-3-662e640ed811@maquefel.me> <6c5d6c0730698969ef613ec9ec4aa14a.sboyd@kernel.org> <7f2bf860ffaccd10899b72fdda6a3ca9c50d2107.camel@maquefel.me>
Subject: Re: [PATCH v10 03/38] clk: ep93xx: add DT support for Cirrus EP93xx
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
To: Michael Turquette <mturquette@baylibre.com>, Nikita Shubin <nikita.shubin@maquefel.me>, Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Wed, 10 Jul 2024 12:55:11 -0700
User-Agent: alot/0.10

Quoting Nikita Shubin (2024-07-10 03:34:12)
> On Mon, 2024-07-08 at 15:18 -0700, Stephen Boyd wrote:
> > Quoting Nikita Shubin via B4 Relay (2024-06-17 02:36:37)
> > > diff --git a/drivers/clk/clk-ep93xx.c b/drivers/clk/clk-ep93xx.c
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw =3D devm_clk_hw_register_fix=
ed_rate(dev, "pll2", "xtali",
> > > 0, clk_pll2_rate);
> >=20
> > Please use clk_parent_data for topology descriptions.
>=20
> It's look like clk_hw_register_fixed_rate_parent_hw() is missing devm_
> version of this function. Is it ok to provide wrapper for
> __clk_hw_register_fixed_rate() in drivers/clk/clk-ep93xx.c ?

Yes, of course.

