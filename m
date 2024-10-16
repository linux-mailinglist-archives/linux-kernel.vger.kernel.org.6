Return-Path: <linux-kernel+bounces-368791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C8D9A14FC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DB3528657C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2321D2F4A;
	Wed, 16 Oct 2024 21:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5q2MDBe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE601D175F;
	Wed, 16 Oct 2024 21:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729114855; cv=none; b=dp33s5hj5rqW1U3farhX2U9c4YCi3Q1sya8QahwW2wf9qbdNXdA0h0RN2qtKpD5esTHyIZRgLNeZGOf0ju4spXK2bUHmSWAP//LDzjoSwfeKKbhRwr6/gA82rs6ThEk2GXyPiFd2TiUdZzluA9r1RmiIsjxpos0/94ZU+w4K2pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729114855; c=relaxed/simple;
	bh=xVn4o4rGOsQXlA0r8hXlilg0V9t/iR/PfJwTgU4wtds=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=hAbThqDD4xdZGRPD4SXyTEhs/xDIro1FzO9+UQjVtFQkGunNqGrdq8INh85Haw2X8kfpffq3JhACrnecga19y8tjfbNm0n3ram7FmhYa+Po0CkQ1synZPHfYIuQCQs1SShK8AeCamD1Gu1nfdxeT8csRnQhteM0uOplH4L++IF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5q2MDBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB452C4CEC5;
	Wed, 16 Oct 2024 21:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729114855;
	bh=xVn4o4rGOsQXlA0r8hXlilg0V9t/iR/PfJwTgU4wtds=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=E5q2MDBeJ3AZEty7jlfuBZlXwHvH+1m7Z9dZd0BIzU0s53rKiwi4JhM4716FlxplO
	 /ewjFWULDN1R2tGN/ui3NteZZucqNUBwhgb6sdP5H6FNCJBq2hIyD45FRoOart/LnH
	 S7ntzFtD0B7EakHcbUIIllC/0nnMc3HKMhWllxw9Ex9sANIZlPlkjavIysCjs8lHyW
	 K0gVnndTZTxQa6IFzw2AlLqoEHCrnN2n5mstdm7XjluqsRnDIM0aUfGAAHjtuhkk6G
	 T8VwWxAx6rS8MPXTobD6SBiu6E/m7EpMjmXNNEO9Co8eptzQUZGSGzqKFV87Q5lHL2
	 aH0GkEG0+EOmg==
Message-ID: <85a4214a67d69a2cd458a9e2bcca7338.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241016022658.2131826-1-ruanjinjie@huawei.com>
References: <20241016022658.2131826-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH] clk: test: Fix some memory leaks
From: Stephen Boyd <sboyd@kernel.org>
Cc: ruanjinjie@huawei.com
To: Jinjie Ruan <ruanjinjie@huawei.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, mripard@kernel.org, mturquette@baylibre.com
Date: Wed, 16 Oct 2024 14:40:52 -0700
User-Agent: alot/0.10

Quoting Jinjie Ruan (2024-10-15 19:26:58)
> CONFIG_CLK_KUNIT_TEST=3Dy, CONFIG_DEBUG_KMEMLEAK=3Dy
> and CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=3Dy, the following memory leak occurs.
>=20
> If the KUNIT_ASSERT_*() fails, the latter (exit() or testcases)
> clk_put() or clk_hw_unregister() will fail to release the clk resource
> and cause memory leaks, use new clk_hw_register_kunit()
> and clk_hw_get_clk_kunit() to automatically release them.
[...]
>=20
> Fixes: 02cdeace1e1e ("clk: tests: Add tests for single parent mux")
> Fixes: 2e9cad1abc71 ("clk: tests: Add some tests for orphan with multiple=
 parents")
> Fixes: 433fb8a611ca ("clk: tests: Add missing test case for ranges")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---

Applied to clk-fixes

