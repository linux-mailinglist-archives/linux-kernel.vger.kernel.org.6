Return-Path: <linux-kernel+bounces-357947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 619D099784D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 00:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 919D31C21565
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 22:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FDD1E32A4;
	Wed,  9 Oct 2024 22:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ap+DBXU1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60665192D67;
	Wed,  9 Oct 2024 22:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728511928; cv=none; b=soveY/msZm/akYO3FzqvR/MWLEnvzBUoHD5s4aB3JqhBdDgbR9GVyFdzkDjXTYKbDWL/6eIVXG16CUnxsPGreeTGw5Yrmw9tcc5R6aMv/khz94eQYMAO7678UVVJ1yl26UUedrhq9YSNcNhNN2mqmON6zdVpGBKCoZXa5XL6Sm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728511928; c=relaxed/simple;
	bh=mic4kLDFoaAZ7m9cY8h1MJRqUyLn4kBRyWUWJec0Oyc=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=lDdayXzP1FZ9PwpfDAujzhRJmXIEbImhD+cNRtm8Qk8zV40tGhzgH0EpKdrypSfc1zEQ7QiBzNtcWIihiHSpgf/wzGBnrTMpSGhIjy8JkMR9H0nigWVHQrZwFpFYQhjkl/FBXDFJJiF1uaj48EI2QqMrri54uy8ymHaT5Vkbrrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ap+DBXU1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE2AC4CEC3;
	Wed,  9 Oct 2024 22:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728511927;
	bh=mic4kLDFoaAZ7m9cY8h1MJRqUyLn4kBRyWUWJec0Oyc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=ap+DBXU1kxzMb80p5bu/JCN2p36kjsRudyRzFXlGdRr58VcQRB/n5nUJTLTqDr6xH
	 dDfWQIQFfZIX4lj8Noy1b/WpODOgAcm7sh6bwLyhgKvRxBb7CINi59wA+gP90myEsa
	 IRRRZFK/RDsF7biY7upDDNYrcrjly12Nx7ZEsixPrgdT0wUqZjkrtjoHuIsr8F2o7S
	 7XZiWC+jpVlnjXwwwqcfxyvuGNk8Q1azFCOmFqpegnysVuNunclvbhSYPbj2awheln
	 cCtbWuEinyFDzJaHNdtu5VOapHfdHOdYkhVtW4Hcolyr7/27SlWuitSbzf6fX5PAa3
	 GFbqrlaNO6Lag==
Message-ID: <5a328b39f3f61371badc8d08de3dcab8.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241009014950.1979424-1-ruanjinjie@huawei.com>
References: <20241009014950.1979424-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH v2] of: Fix unbalanced of node refcount and memory leaks
From: Stephen Boyd <sboyd@kernel.org>
Cc: ruanjinjie@huawei.com
To: Jinjie Ruan <ruanjinjie@huawei.com>, davidgow@google.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org, saravanak@google.com
Date: Wed, 09 Oct 2024 15:12:05 -0700
User-Agent: alot/0.10

Quoting Jinjie Ruan (2024-10-08 18:49:50)
> diff --git a/drivers/of/overlay_test.c b/drivers/of/overlay_test.c
> index 19a292cdeee3..e95b1152612c 100644
> --- a/drivers/of/overlay_test.c
> +++ b/drivers/of/overlay_test.c
> @@ -73,12 +73,12 @@ static void of_overlay_apply_kunit_cleanup(struct kun=
it *test)
> =20
>         np =3D of_find_node_by_name(NULL, kunit_node_name);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, np);
> -       of_node_put_kunit(test, np);

Thanks for the patch. This should be

	of_node_put_kunit(&fake, np);

so that the node is put before the overlay is removed.

With that done you can add my

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

