Return-Path: <linux-kernel+bounces-387213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 657959B4DFB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605AA1F237DB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB625194A43;
	Tue, 29 Oct 2024 15:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DD6+B/Aa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC53193074
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730215776; cv=none; b=IIRsq8yJR+E3+lA5RAHNahEw1Kx80UFrHlj2u3fnANuMbnCCXDZ1levsTt+jJetX/yLc7kAjTs228+TcK2cuyzEuve+uEXL0AqMM/dd1hM8L8qghhEYdYaMknRQFWrRxQbxGqAdOGuYhQE6tOzlefwswkdcZ+vHMX5BLwwTXhHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730215776; c=relaxed/simple;
	bh=h6IT+RVIi2EiBIQas5qph1pu5nvBCYYWrS8/4i28TQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpbFrfU6bJkoT5Qd18KtkCIfdZAuW5zCW0n1+3aALQ/ufbEWE/Sykgfu3Es56tFSwg1cp1SS0XwNUs4kA4U6adAXdC47bGSZGMKCsDHAS2pk/7UxfYc6n9NCih0mKw8PySmB/189fHk9Onku8vW2Yd9AVRgpW71omLl/eoPy+Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DD6+B/Aa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1175AC4CEE5;
	Tue, 29 Oct 2024 15:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730215774;
	bh=h6IT+RVIi2EiBIQas5qph1pu5nvBCYYWrS8/4i28TQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DD6+B/AauYc/wLBkQ+xNoFMHiwkWj6X5sIBzRMeHK1cnGNjaC47cdnFKua7OzUwiK
	 EmgzTxh3Z5DXJO0Y5tz/201vinLaimuLmZjw+bM7DZVNKV/JKGvxfo1dE/5+5Wlxwy
	 FitB71U8/f4JPApNeU4ER18SwcZiZq/aoSx+o5fUIpLQL/3Sw6rub3NHbv5dnxnt5N
	 8JwwJbNJU6PuRYoRvQ1u4Dppn2EwipEtDXgn2m3krBqvbPXRe/bkxvCLz2zek4zpKo
	 +Fg42a89YUu4ao/2ukuxp7jK9Q4WZkj4RtUnbjyCa/12JsTJeSWFKtXeHBpt95Czob
	 TqyHhZa4BdZXw==
Date: Tue, 29 Oct 2024 15:29:29 +0000
From: Will Deacon <will@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, James Clark <james.clark@linaro.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/arm_pmuv3: fix building on 32-bit
Message-ID: <20241029152928.GA4865@willie-the-truck>
References: <20241029152420.3251097-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029152420.3251097-1-arnd@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Oct 29, 2024 at 03:24:10PM +0000, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The write_pmuacr() function is only defined on arm64, so building the
> driver on 32-bit arm now fails:
> 
> drivers/perf/arm_pmuv3.c: In function 'armv8pmu_enable_user_access':
> drivers/perf/arm_pmuv3.c:784:17: error: implicit declaration of function 'write_pmuacr'; did you mean 'write_pmcr'? [-Wimplicit-function-declaration]
> 
> Add a compile-time check around the newly added code, as it is never
> needed on arm32.
> 
> Fixes: 0bbff9ed8165 ("perf/arm_pmuv3: Add PMUv3.9 per counter EL0 access control")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/perf/arm_pmuv3.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Cheers, Arnd. Rob already sent a fix for this [1], which I'll push out
shortly.

Will

[1] https://lore.kernel.org/linux-arm-kernel/20241029120602.4061566-2-robh@kernel.org/

