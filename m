Return-Path: <linux-kernel+bounces-201246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DFE8FBBB7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 20:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3067F1C24DF7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5947D14039A;
	Tue,  4 Jun 2024 18:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6iyf4FY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D04EA5F;
	Tue,  4 Jun 2024 18:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717526261; cv=none; b=oZ+Kfd5jTpVMg3RNDcAN70q8KSs7WqcwGx+Xc3Fj2dhpED5+HVeIF74QgGK8Gz5kYRRKj5+MNhXGzQ64Fx2anGkeW6RKC+550haXJ5sCXnw22H+CnupCI/4kkP5KkFb/X7o80pDvNYA4tEH52Xa4T4UmLw87TquxSsTnbINRV6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717526261; c=relaxed/simple;
	bh=DzYmhCVLTbbGz9nX9THqcZl6MvWkHcmd5Ebv1OCgf3Y=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=huIcuKxbiotonOtrynu9uvdr5IzpKsWLBIlHnReYBzs99+QandFig0xld1MxAyDYQ1rL/X8gvOpOvYart7CX+q0IakMmgiPC1/s6KN38V71ZjtxAf2qfO2G8ZCRuuIK+AevVzEE6v3vG5b0PlVowSa6LrpNdfMhpX/fv2qiJLUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6iyf4FY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3661C2BBFC;
	Tue,  4 Jun 2024 18:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717526261;
	bh=DzYmhCVLTbbGz9nX9THqcZl6MvWkHcmd5Ebv1OCgf3Y=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=H6iyf4FYiijqhDj+kJTlMWo9y2L4Fy87O89QypH1ElA20bzuydlppo2lEH3MBmEhY
	 lo/JMlGvViBnlMmoQ91MVVD88WeeyNPp5rPwdemgjfb+FY+RuT+9r4y63nooFHISj5
	 wThfFw+oErp3KLu8dJUYyLMaBFQAEg54sLkOmeRv3X5lNf4+cKIcbQ3FpXAyKkY17Z
	 d50TDA0PWKWYRETS4m9wKaIgjzOYEicdJGxgFVykXF+pu31R+9yskXHUmelDxHAmTs
	 rzy0q/3O3C107rzBzAQK68vjr5rkkC9xKE2eQ2IeCSHcOglpN1sgRbSq7KXuaRf2zN
	 kJ+kVhL/Lzlcw==
Message-ID: <60ddc90da5b5dc6a4b0eec91b06bcbfc.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240604130531.170371-1-krzysztof.kozlowski@linaro.org>
References: <20240604130531.170371-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [RESEND PATCH] clk: sifive: prci: fix module autoloading
From: Stephen Boyd <sboyd@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Paul Walmsley <paul.walmsley@sifive.com>, Samuel Holland <samuel.holland@sifive.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Date: Tue, 04 Jun 2024 11:37:38 -0700
User-Agent: alot/0.10

Quoting Krzysztof Kozlowski (2024-06-04 06:05:31)
> From: Krzysztof Kozlowski <krzk@kernel.org>
>=20
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
> based on the alias from of_device_id table.  Clocks are considered core
> components, so usually they are built-in, however these can be built and
> used as modules on some generic kernel.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> ---

Applied to clk-next

