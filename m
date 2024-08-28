Return-Path: <linux-kernel+bounces-305562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4B396307E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E7A61C20964
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3319B1A7AF9;
	Wed, 28 Aug 2024 18:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVzGpo5R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75404328DB;
	Wed, 28 Aug 2024 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724871267; cv=none; b=KkpTLT6NF0oYSraW0kISBoOmStOCTwCb+s9lSEDVKpfuNj0/jTV4CZue1CdgmmzBA8qZHHB0zka42/FaDQOluF7I9Mcs1vp7sNYk2C7HqzcZjJGaRX+lV9Pr/IY5kenIGT6xavAMUg3H6GUvFvRzDdFjrVSUKneM2zSPrqTBMRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724871267; c=relaxed/simple;
	bh=o3Aqa/YmH5CMEPH5VTyeE5UC76LCBuu8UWYtjDGLyRE=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=THhRM2E0xnTkikVWs6FnWvmkBwqeGcUcEB/mUFxFk0SijqwTmK+mAPI5r1u3mAR3Oat+UIqc9BGsx7jU58UHtfSnGSAkVQ1KgDNDNgDRiqV/lHEFFnUrQNO2hzBEGDtEBhKx5KAMqMkB4cAVM0Sn4mlD1gC8necGAVidK8A0itM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVzGpo5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E655C4CEC0;
	Wed, 28 Aug 2024 18:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724871267;
	bh=o3Aqa/YmH5CMEPH5VTyeE5UC76LCBuu8UWYtjDGLyRE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=RVzGpo5R7+qjSTKHHtzRDscn+LbPceWsiUhqlr3l3cdJtGhELKgQkurI+sFEoy4IY
	 CPlSDklh72Pt4n81AojXnc95z1UW0gARaoGY8r4shu3yZgdQyGNHwfntCHKs/32Ozr
	 C01eukbwx3MRF3YCqlLQexanMBLi+tDVx3hdOZEawJPwFxIQzXSiu26OgkBTvHS5KA
	 60xkopnSMyAYDuRcKUQGtxSBIxFryrgcihj5uGCOyhbNYg8SXVwKHFTRunC+FoUxpx
	 T9WNRarYNESkFzEElXXT+1CCMkTzwwZojaZ9lgRJiECCKtJUGv4pn5gaI8HJi3wgGT
	 TFn6DeMNOPnsA==
Message-ID: <29cda960bebe1c034d53ace2f57731c2.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240826065801.17081-1-krzysztof.kozlowski@linaro.org>
References: <20240826065801.17081-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] clk: bcm: bcm53573: fix OF node leak in init
From: Stephen Boyd <sboyd@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 28 Aug 2024 11:54:25 -0700
User-Agent: alot/0.10

Quoting Krzysztof Kozlowski (2024-08-25 23:58:01)
> Driver code is leaking OF node reference from of_get_parent() in
> bcm53573_ilp_init().  Usage of of_get_parent() is not needed in the
> first place, because the parent node will not be freed while we are
> processing given node (triggered by CLK_OF_DECLARE()).  Thus fix the
> leak by accessing parent directly, instead of of_get_parent().
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied to clk-next

