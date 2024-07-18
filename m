Return-Path: <linux-kernel+bounces-256717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C94F3935271
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 22:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73C161F223C4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 20:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1301E145A1D;
	Thu, 18 Jul 2024 20:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVQ5dy3s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7021442E8;
	Thu, 18 Jul 2024 20:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721334802; cv=none; b=GADqzaCgE9HvWqbehThsXGjnTiqGp4btpvFtTME4Kh3gI2umhY9SJOvvM/qHzkFW6etuL6NGaPBdzsUZvxOEdrxhzQpNmU/36l8neb5Hp4oBl1ZYE78VFz+JfVDyUSSFt+zYa7bZtb0DP4HNjm4MO/dGGkp6PrN7+66OMEnxz2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721334802; c=relaxed/simple;
	bh=+2jZ1FJdayxI/jeTGQsq55tA4N3XqDyXQ5ATmDJfZ+k=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=YQKlbU+BIcjwxpTtY+dVGmp9Yi+xv/Ee4Dulybb64J4kDXd8o9E2QxISgcgNr1nSUsTrxkXXYAAtQDzuXKueKYklp/8f/y9hO3mCs+VlRUExelrS4M8xLrfEwtMlKEe4bm04+WuArYl51BiZ+3eDzm7xcm5NiTlNmSDcCb5NYnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVQ5dy3s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF17C116B1;
	Thu, 18 Jul 2024 20:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721334801;
	bh=+2jZ1FJdayxI/jeTGQsq55tA4N3XqDyXQ5ATmDJfZ+k=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=kVQ5dy3sUROdJgrzfzIKIyurjWhSjo+iSL7S3vTnCFYPDrzyDcZ6phNPnVUz5En2O
	 cN/W5uQgpRavx1lCOD7BAavesj5ws1CUVlD49rOoox8qK0lIaBvafm8ekpq/Y2yhLT
	 HllHKokSN+DleMU7GZNfX37ROZYoEALy1IgbGu0byti8ka9oPTKuXGqAcY99dFsCUs
	 5Ktu0EMVIA6lwb3155yoMBAWKmdK7gKE7Ow8xM4oXscdykdOQE0JDsHgnC/d6en00Q
	 qrI8+p/T+Ti3/q+g6XOGewxjD3c1BLEf0whilmeQGbvCNR0fmVN+//fSvRRD+sYWS4
	 iOWZ3KtizWQBw==
Message-ID: <7c554c6ec0d24bffdfc9ea55de5c8ff7.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <baf0a490-d5ba-4528-90ba-80399684692d@stanley.mountain>
References: <baf0a490-d5ba-4528-90ba-80399684692d@stanley.mountain>
Subject: Re: [PATCH] clk: sophgo: clk-sg2042-pll: Fix uninitialized variable in debug output
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Inochi Amaoto <inochiama@outlook.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
To: Chen Wang <unicorn_wang@outlook.com>, Dan Carpenter <dan.carpenter@linaro.org>
Date: Thu, 18 Jul 2024 13:33:19 -0700
User-Agent: alot/0.10

Quoting Dan Carpenter (2024-07-17 19:25:53)
> If sg2042_get_pll_ctl_setting() fails then "value" isn't initialized and
> it is printed in the debug output.  Initialize it to zero.
>=20
> Fixes: 48cf7e01386e ("clk: sophgo: Add SG2042 clock driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---

Applied to clk-next

