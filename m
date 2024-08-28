Return-Path: <linux-kernel+bounces-304140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EED961AE9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 02:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91EBE1F247A9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 00:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C476010E0;
	Wed, 28 Aug 2024 00:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mX/d4KP9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AC918D;
	Wed, 28 Aug 2024 00:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724803400; cv=none; b=iqiaJeZCPzAhZ3mYODrZNd3d40Am3ZCjtA2MAUSWn7lDVWDWbQk31hIhnsgSU54Gd5O9DCCwE8duZY0gDsMQUgfaW7f/V1YJ0WfDnl8eKNXbUnO46ec+l1PODmRGPqea7rUr+pom7mhBynUhCNEASr4Qcp2SmHmCgKfZY1wrQ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724803400; c=relaxed/simple;
	bh=AXFMU7dyxQavGYoKqhr4/agJ6FNxyJ/te/YY9h3sqDA=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=P1Fu4WldJt0Hi0Lkc1LhtqTcIWmiB5tDfd3NMSS7v034NSYJc3RM+6O+oheWT7tKB7WpZC1mjTHr+XRod5P4CjkQ6IeZM38m54s0CcpRxZs8EdNT9Sn4wepn8+bhto4l1EI7jCgynufKBk9wiRf+wTCky2PsiWX5dTNuxMEni/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mX/d4KP9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C788C32786;
	Wed, 28 Aug 2024 00:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724803399;
	bh=AXFMU7dyxQavGYoKqhr4/agJ6FNxyJ/te/YY9h3sqDA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=mX/d4KP9oNMlnIoqPzKCrO1FRbz7vOnXtNaiSKMCijyb90y2IJ4URCjntaULvihW7
	 OCnfS9nvHmCKCTTsr6Ax9N6Y6IZKeJizoxaPkgmPsSyOUSAyzztXix3tGhLniDAK97
	 rjxBXw/Vm/SvYuVzv4tuRseg5QYF4zySchJalTYLTtouoLn3B1E7DePMir0igXzqnc
	 UTJZGSfOh5h9BU98AmuHeJXWCccuq0RC/aExVVADVT5XHQ4OeivdPOLjMNsOmFa07f
	 TCFN0dgHGln8kIIWx/ljIQq2xwsB3DJ5CJwrxhRi+vDPafeKfdUgKaTN2gvaKE8z3N
	 Hott+vPFQVmkA==
Message-ID: <66c0550553cb5d9d332d48d9fb80d4f9.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240821010739.15293-1-david.hunter.linux@gmail.com>
References: <9b1107439ffd3fe3cf4945a500a881c8.sboyd@kernel.org> <20240821010739.15293-1-david.hunter.linux@gmail.com>
Subject: Re: [PATCH 1/1 V2] Driver: clk-qoriq.c: replace of_node_put with _free improves cleanup
From: Stephen Boyd <sboyd@kernel.org>
Cc: david.hunter.linux@gmail.com, javier.carrasco.cruz@gmail.com, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, mturquette@baylibre.com, shuah@kernel.org
To: David Hunter <david.hunter.linux@gmail.com>
Date: Tue, 27 Aug 2024 17:03:17 -0700
User-Agent: alot/0.10

The subject should be

 clk: clk-qoriq: Replace of_node_put() with __free()

Quoting David Hunter (2024-08-20 18:07:39)
> Use _free() to have automatic cleanup instead of calling of_node_put()

__free()

> manually.
>=20
> Compiled without errors or warnings.
>=20
> Signed-off-by: David Hunter <david.hunter.linux@gmail.com>
> ---
> The following commit has information on _free(device_node):
> 9448e55d032d99af8e23487f51a542d51b2f1a48 =20
>=20
> V1 --> V2
>         - Improved message body=20
>         - Use change log to give more information about _free()

Please don't send the next version as a reply to the previous patch.

> ---
>  drivers/clk/clk-qoriq.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
> index 4dcde305944c..941a0372db4b 100644
> --- a/drivers/clk/clk-qoriq.c
> +++ b/drivers/clk/clk-qoriq.c
> @@ -1065,11 +1065,8 @@ static void __init _clockgen_init(struct device_no=
de *np, bool legacy);
>  static void __init legacy_init_clockgen(struct device_node *np)
>  {
>         if (!clockgen.node) {
> -               struct device_node *parent_np;
> -
> -               parent_np =3D of_get_parent(np);
> +               struct device_node __free(device_node) *parent_np =3D of_=
get_parent(np);

It seems the __free() comes after the variable name declaration if my
grep skills are working today.

Also, please include linux/cleanup.h at the top of the file for __free().

>                 _clockgen_init(parent_np, true);
> -               of_node_put(parent_np);
>         }
>  }

