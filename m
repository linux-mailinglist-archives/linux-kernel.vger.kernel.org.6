Return-Path: <linux-kernel+bounces-305825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 768D79634E6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 00:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FEE41F25421
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628FE1ACE10;
	Wed, 28 Aug 2024 22:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jG2tUbHh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C8D166F01;
	Wed, 28 Aug 2024 22:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724884741; cv=none; b=LTihxoVoMhxQmL44oCSzktF8tPtoLIo/uyvhHBR1XT/v/93+Fsfzq0r+JuK0mPk3s6MxWP1gt5h+n/HalXnIsf31zTHG0JiKU6PESycPyv2+95gw5rnMmPbPp8oQEZPR/RSEMl8+4NHO3PAr7RmTCth/JNE4UqRIU/dWohZfrTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724884741; c=relaxed/simple;
	bh=R+mh8dSyGJUVg39mQaXiKe3BNb686Lv6Lb4N7dr4d7U=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=VXgqOGQeTrum+8RmDI0LUZ+EmjmSLUSiTgktWz5PKqs/r/znf7z1DS4egtr8udy/SRVZQ6iT6K+sdpAgeYXBiP0/+kyV80camdLjObOMYPYBKi4nJN1hk+819exKuEOfTJdLV0tPIvlO+1Zx8a7dsIka5yRHNhIDcGDUqXc0i78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jG2tUbHh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E401C4CEC0;
	Wed, 28 Aug 2024 22:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724884741;
	bh=R+mh8dSyGJUVg39mQaXiKe3BNb686Lv6Lb4N7dr4d7U=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=jG2tUbHhOArCbx3Tggq5OHHhrCpbTBDgd+OfwqA3JPDkv157/3DfTILKf4MoOlvJO
	 GzbQbfbTNMPLWTO/o2yBswmtmXpINVS/2ybN02OuHXeMnOmm9PD4Slv6fdNK6CprRh
	 6BOtC4SoG66klwqnvhPPnrljxpWhQJZokbdQGLwHIk7fW8Pn/dUxJlk35JuJAhLuWm
	 nAcx1zF2cz3DCIm7Vu4Rv79TkKOqLPTqNqWl+RbhdSqc+f9T2wvgnhFqnUN5LsdWKb
	 z4TRT0ynTxu+C4pzOkrkTbJyoM2CyJQUkzLHr+2uPvSfmkcSGZQRZ2YmxahS0OkUT/
	 4aG+GbKn4qS6g==
Message-ID: <196f25e27571de337cc4b887c5e58ade.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1b245182-09db-44a1-bdee-3ec0658bef47@gmail.com>
References: <20240827061954.351773-1-ganboing@gmail.com> <ad33e8561ca236c5f897003fb40bdc09.sboyd@kernel.org> <1b245182-09db-44a1-bdee-3ec0658bef47@gmail.com>
Subject: Re: [PATCH] clk: analogbits: Fix incorrect calculation of vco rate delta
From: Stephen Boyd <sboyd@kernel.org>
Cc: samuel.holland@sifive.com, emil.renner.berthing@canonical.com, mturquette@baylibre.com, paul.walmsley@sifive.com
To: Bo Gan <ganboing@gmail.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 28 Aug 2024 15:38:59 -0700
User-Agent: alot/0.10

Quoting Bo Gan (2024-08-28 14:23:37)
> On 8/28/24 11:52, Stephen Boyd wrote:
> > Quoting Bo Gan (2024-08-26 23:19:54)
> >> In function `wrpll_configure_for_rate`, we try to determine the best P=
LL
> >> configuration for a target rate. However, in the loop where we try val=
ues
> >> of R, we should compare the derived `vco` with `target_vco_rate`. Howe=
ver,
> >> we were in fact comparing it with `target_rate`, which is actually aft=
er
> >> Q shift. This is incorrect, and sometimes can result in suboptimal clo=
ck
> >> rates. This patch fixes it.
> >>
> >> Signed-off-by: Bo Gan <ganboing@gmail.com>
> >> ---
> >=20
> > Please add a Fixes tag.
> >=20
> > Also, your patch has tons of diff context. Why?
>=20
> Hi Stephen,
>=20
> Thanks for the reply. I'll add the Fixes tag in v2. I explicitly enlarged=
 the
> diff to show more surrounding contexts for better readability.

Ok.

> Any other issue
> I should fix?
>=20

Nope.

