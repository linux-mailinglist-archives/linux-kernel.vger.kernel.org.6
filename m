Return-Path: <linux-kernel+bounces-537423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD67A48B9D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6761D1682E7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB22D80BEC;
	Thu, 27 Feb 2025 22:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3NYbx5b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596D92777F6
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 22:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740695482; cv=none; b=hmpMthv6GVo7zZDt7dwUY9ESjyP4F6u6B82RPDljmx3sPdT00aJnVEH/TmPiLVksr1qUnnoh9Ua9+Sj+gjXxbeUDepA6m86tjVb/w1IgBu5SX+jRjTnl72FDlYbibUz89LRAD01Dw44EQDAdeLZTU226EZJGiwHyv2XJr8gYnfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740695482; c=relaxed/simple;
	bh=pqx/dBna2gN0mw5vkh78oJYeK4NjZT83W5IVrSFD3mM=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=CjTwXQlRBeVAtOS5jKiZlK5+XodDrcyKjS0qgsIEL3ek013sqq2Uvg56w1OcV9Kj+xBEi6P/aWrPgnCdFY8WKppSNoznsnTAjMo2AaGypDKREWM28RWVgTL8/xggKEngJ+7EJV6WNmjX/STAxEn0MXvcv2xBVvr71ubPtPtfUKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3NYbx5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D34C4CEDD;
	Thu, 27 Feb 2025 22:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740695481;
	bh=pqx/dBna2gN0mw5vkh78oJYeK4NjZT83W5IVrSFD3mM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=A3NYbx5bEmuOOSWoV8+Iw0WM21wGKV13eIIey1L6jkBedQBPEddimUVy3bTo2jSSy
	 yTxFmSpXEsUslBiWnkkhcw209oiZdBmCtE8v6ZlIHufTFH6vfxpJAxxUK38MlS8NoH
	 UHTCU+0fu7FGiMNDpLr5ulumjil9ytttk86XwmyDfPAIFJ/zcxzdHqatQuwacReIGy
	 IiWOUJz9s47QWLa8SqzwFzoelXuzmk9NNTvOMnNTIDUtvxfeDw9LuWqmOjOWZjbYUs
	 L94tdltVm9ge8WOdwOn7df9tuQaaBk8PBl7ANPeDAhedHHUEKcG4wBpG1Q8pKbYoTL
	 i9Iml5c8EsYnw==
Message-ID: <5ee4cd3e3e5b31c674b37e39be14a214.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <23BAA675A75EF4F5+20250218050552.57711-1-wangyuli@uniontech.com>
References: <23BAA675A75EF4F5+20250218050552.57711-1-wangyuli@uniontech.com>
Subject: Re: [PATCH] spmi: Only use Hikey 970 SPMI controller driver when ARM64
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, mayulong1@huawei.com, mchehab+huawei@kernel.org, zhanjun@uniontech.com, niecheng1@uniontech.com, chenlinxuan@uniontech.com, WangYuli <wangyuli@uniontech.com>, Wentao Guan <guanwentao@uniontech.com>
To: WangYuli <wangyuli@uniontech.com>
Date: Thu, 27 Feb 2025 14:31:19 -0800
User-Agent: alot/0.12.dev8+g17a99a841c4b

Quoting WangYuli (2025-02-17 21:05:52)
> SPMI_HISI3670, the Hikey 970 SPMI controller driver, is only
> required to use the Kirin 970 SPMI bus.
>=20
> And the Kirin 970 is an ARM64-based SoC, it cannot be used on
> platforms of other architectures.
>=20
> Link: https://lore.kernel.org/all/b4810f476e41e7de4efdf28b42472ae4ffe7def=
e.1597647359.git.mchehab+huawei@kernel.org/
> Reported-by: Wentao Guan <guanwentao@uniontech.com>
> Closes: https://github.com/deepin-community/kernel/pull/604
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---

Applied to spmi-next

