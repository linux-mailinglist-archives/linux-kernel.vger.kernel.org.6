Return-Path: <linux-kernel+bounces-404482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CB79C44E7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07AC6B2B477
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AE61AA7BA;
	Mon, 11 Nov 2024 17:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j35eEDs5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7602D1AA1E6;
	Mon, 11 Nov 2024 17:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731347541; cv=none; b=eecEAIjjHfMiXLhqUt7lQb+czQ54An+V7yY181DPEel/tVBypE4DWC8/3EKpKsAUSsHYCyRnbVdIt/lWkRF/SpC35vz3cS6vB56//+iQJNUU4NAHTuECVKi96RCQAOaJK5wOTXv9TXl1jBhmdcNaQLMAtQzwU7850MHGaIDyX3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731347541; c=relaxed/simple;
	bh=VQ3nNusYHzEI8YTJVKStGSz7nddYAaf2rVedbG7mlus=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h8GEf5A2eGOJogFnFcfLMIdJiAfPvEbrgW7sfr6c8UMxjONkSV+Pr8EwCeALka7hllUvQVon8DX1S1zckuiz85Eyv439pGU9/kNsd3/KH5CJ3aUAS0BdDXdQpfIHx3lyRueY4ds8MW/s4m6eJTYauBvZPjY68yiwHFAxYZORTAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j35eEDs5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14378C4CECF;
	Mon, 11 Nov 2024 17:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731347541;
	bh=VQ3nNusYHzEI8YTJVKStGSz7nddYAaf2rVedbG7mlus=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j35eEDs5zoylRnjM/ihp7nFgSW4WyPyh65metA8KW2BXFuyEDCebHbFQtlV897cPw
	 jl30nNdI0+j0VUex17zGw2ScrIOLx1oZu12bXVXuV1a6z40xLRcqydkTFjMK18UVVt
	 0Oj9h+OSPOj6bR1AwqzXOLl7TKobv2AwSd3YjbyFe+sFi5HuzhOETIIyVaTzl9Pjv0
	 h8rO4h/scMckLlRt6Q2cTbHYFYALaVGM74IE2wuvBG49F+G7/+fb3cfoYaguehoDAP
	 hvS9HxztQZaN3YoFJbtiD/Iov1PDXXmtDib/w8ac4LAl78Qz35LBBCaBWZU2eI88EE
	 fbbbqysrHl+eQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tAYaI-00Bw8B-AD;
	Mon, 11 Nov 2024 17:52:18 +0000
Date: Mon, 11 Nov 2024 17:52:17 +0000
Message-ID: <86o72lzmi6.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: will@kernel.org,	qperret@google.com,	broonie@kernel.org,
	mark.rutland@arm.com,	keir@google.com,	vdonnefort@google.com,
	kernel-team@android.com,	android-mm@google.com,	Catalin Marinas
 <catalin.marinas@arm.com>,	Oliver Upton <oliver.upton@linux.dev>,	Joey
 Gouly <joey.gouly@arm.com>,	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,	Ard Biesheuvel <ardb@kernel.org>,	D
 Scott Phillips <scott@os.amperecomputing.com>,	Andrey Konovalov
 <andreyknvl@gmail.com>,	Ankit Agrawal <ankita@nvidia.com>,	Wang Jinchao
 <wangjinchao@xfusion.com>,	"Madhavan T. Venkataraman"
 <madvenka@linux.microsoft.com>,	=?UTF-8?B?UGllcnJlLUNsw6ltZW50?= Tosi
 <ptosi@google.com>,	Bjorn Helgaas <bhelgaas@google.com>,	Ryan Roberts
 <ryan.roberts@arm.com>,	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,	kvmarm@lists.linux.dev
Subject: Re: [PATCH] arm64: kvm: Make nvhe stack size configurable
In-Reply-To: <CAC_TJvd=fNRx2VOcEEgjdkY53MwpR0Xa4dX1KTy=nNew7dg9Mw@mail.gmail.com>
References: <20241108211446.3304809-1-kaleshsingh@google.com>
	<86r07jz6uh.wl-maz@kernel.org>
	<CAC_TJvd=fNRx2VOcEEgjdkY53MwpR0Xa4dX1KTy=nNew7dg9Mw@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.4
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kaleshsingh@google.com, will@kernel.org, qperret@google.com, broonie@kernel.org, mark.rutland@arm.com, keir@google.com, vdonnefort@google.com, kernel-team@android.com, android-mm@google.com, catalin.marinas@arm.com, oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, ardb@kernel.org, scott@os.amperecomputing.com, andreyknvl@gmail.com, ankita@nvidia.com, wangjinchao@xfusion.com, madvenka@linux.microsoft.com, ptosi@google.com, bhelgaas@google.com, ryan.roberts@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Hi Kalesh,

On Mon, 11 Nov 2024 17:10:18 +0000,
Kalesh Singh <kaleshsingh@google.com> wrote:
>=20
> I tried to be conservative with the configuration only allowing only
> up to 2 pages. Your points are fair concerns, I can see how this still
> may not be ideal for upstream. However, I think introducing
> NVHE_STACK_SIZE as a refactor still has value, similar to how
> OVERFLOW_STACK_SIZE is handled. If there are no objections, I=E2=80=99ll
> resend a v2 of the patch, dropping the configuration parts and
> focusing on the refactor to introduce NVHE_STACK_SIZE.

I'd be OK with the refactoring on its own, which is a nice enough
cleanup.

Thanks,

	M.

--=20
Without deviation from the norm, progress is not possible.

