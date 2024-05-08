Return-Path: <linux-kernel+bounces-173531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4B88C01D9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3999E2882FB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF41129A69;
	Wed,  8 May 2024 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/6te9oQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2348A12AADB
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 16:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715185223; cv=none; b=nprc6nBN9wr2rg9b2XJpYIxAycZFAsWtKbP+PoafABmDSYk/I72cecXXSR1nXVAZQ3AnTQH2ipbs95keEc+6h/ZOLVjv9NgeAb311BFkygJ4n0kRDlfnHbuwPTnk/3EppDUHT/dSlgrtksBu3MHRlDAi095np3imUM/y1z1BngQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715185223; c=relaxed/simple;
	bh=VFTWjNc7CfBH+j1nLVY9KpvEluTYazFHI8P3hoMa65M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lincjjJh8l8ut5t6sIqJVc2fiedEqDjf7s5AK4I9UQ3imjoT+Et/jn0JtpCfHjSF7xjHoFCX0IIKGAM43uM/CU0dDsschiIYv9gyJN5PEUf++mQvh3PrETIRqoSCabJWbweaq6tDhvNUmnR6pJisDCC4Ehk4ZcXrFVHexnwCeVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/6te9oQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC486C113CC
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 16:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715185222;
	bh=VFTWjNc7CfBH+j1nLVY9KpvEluTYazFHI8P3hoMa65M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r/6te9oQEBUQ64u1jGdLmh+nPW01uTSYTe6pkPFJqn2vSSHre79PGFdXPJsgQvIlJ
	 tQCEPqgcHnczPly1CeGzXOsfeT03PECA6ttd/a7rkEbL0g6SmDyyBXHkAhW+DFP4Da
	 dDx9Ai4fcjuXzjF58J4Z2fegZBPnFuM7su5ClVVqNfSRzsUq84RT0v/n7lCLIRxuSj
	 gtX63iJwehZlpnVDt9pzcwIuI56rxakUM6bq1RXgaFBVzvHLOuuyWOMb3UL72FZ4yc
	 +37e4qBGjKQfu/1Y3wKn6fQ9eKeH9spI+1fuh+0VIBaPfKIwrRd7OxMtMqBhc2azDE
	 WQ71BClBDR6nA==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5b257462fc1so179250eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 09:20:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9XzXeQWM09/LavXWWGvn1GivuVu8PzevzN6wTHggflM3BjR8AWkRcwIo+iL9AHPYEWU0+csVlgYWnywONR1r0j51BN2A9pM9wUTLX
X-Gm-Message-State: AOJu0YzKtiIEBspVfx09KZWVgGRnfHq+2xwRF/vERK2AM2OfiF8C5KMU
	FJsSkqUGIfqU7Oz1q+OKRFBtUPT9tDyU3vPBesRD62SrYrD8yLW2yas47dBoRiedyYiRrRUFeB8
	iMGO85YlhNPjt+7g2bQx+0aILlII=
X-Google-Smtp-Source: AGHT+IGohKM9uTiY3cn/2Db3LYCqThxHpYKA2zM0cCLaTQE+uSugHOwufZZN2WRU8iGn/FY0M6/sUnVRii2rDiARjNI=
X-Received: by 2002:a05:6820:1f92:b0:5ac:6fc1:c2cb with SMTP id
 006d021491bc7-5b24caad211mr2874839eaf.0.1715185221956; Wed, 08 May 2024
 09:20:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2089edf5-0257-47ec-82b8-ee61c9430241@kernel.org>
In-Reply-To: <2089edf5-0257-47ec-82b8-ee61c9430241@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 8 May 2024 18:20:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ivaEgwvK9hbxPCbDNFLLvB+-oo+t=NgNca3YXfdX2reA@mail.gmail.com>
Message-ID: <CAJZ5v0ivaEgwvK9hbxPCbDNFLLvB+-oo+t=NgNca3YXfdX2reA@mail.gmail.com>
Subject: Re: [GIT PULL] devfreq next for 6.10
To: Chanwoo Choi <chanwoo@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 8, 2024 at 6:00=E2=80=AFPM Chanwoo Choi <chanwoo@kernel.org> wr=
ote:
>
> Dear Rafael,
>
> This is devfreq-next pull request for v6.10. I add detailed description o=
f
> this pull request on the following tag. Please pull devfreq with
> following updates.
>
> Best Regards,
> Chanwoo Choi
>
>
> The following changes since commit dd5a440a31fae6e459c0d6271dddd628255053=
61:
>
>   Linux 6.9-rc7 (2024-05-05 14:06:01 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/de=
vfreq-next-for-6.10
>
> for you to fetch changes up to ccad360a2d415447bd6f0de9e873eec05442d159:
>
>   PM / devfreq: exynos: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions (20=
24-05-09 00:30:37 +0900)
>
> ----------------------------------------------------------------
> Update devfreq next for v6.10
>
> Detailed description for this pull request:
> - Convert to platfrom remove callback to .remove_new ops for following dr=
ivers
> : exyno-nocp.c/exynos-ppmu.c/mtk-cci-devfreq.c/sun8i-a33-mbus.c/rk3399_dm=
c.c
>
> - Use DEFINE_SIMPLE_PM_OPS for exyno-bus.c driver
> ----------------------------------------------------------------
> Anand Moon (1):
>       PM / devfreq: exynos: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
>
> Uwe Kleine-K=C3=B6nig (5):
>       PM / devfreq: exynos-nocp: Convert to platform remove callback retu=
rning void
>       PM / devfreq: exynos-ppmu: Convert to platform remove callback retu=
rning void
>       PM / devfreq: mtk-cci: Convert to platform remove callback returnin=
g void
>       PM / devfreq: sun8i-a33-mbus: Convert to platform remove callback r=
eturning void
>       PM / devfreq: rk3399_dmc: Convert to platform remove callback retur=
ning void
>
>  drivers/devfreq/event/exynos-nocp.c | 6 ++----
>  drivers/devfreq/event/exynos-ppmu.c | 6 ++----
>  drivers/devfreq/exynos-bus.c        | 9 +++------
>  drivers/devfreq/mtk-cci-devfreq.c   | 6 ++----
>  drivers/devfreq/rk3399_dmc.c        | 6 ++----
>  drivers/devfreq/sun8i-a33-mbus.c    | 6 ++----
>  6 files changed, 13 insertions(+), 26 deletions(-)

Pulled and added to the linux-next branch in linux-pm.git.

Thanks!

