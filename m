Return-Path: <linux-kernel+bounces-261887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C09FE93BD63
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C2312834CA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 07:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC11171E73;
	Thu, 25 Jul 2024 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFJxiI/k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C1C339A0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721893967; cv=none; b=fZ02gV79wB8aZ2IJ4pgRUZkPEqc8ZQ/m/Kans9ESwNZGZIR8mZEkZ+qhBFEwG5v5eQcWxB+AQoyJrVR/83A+r9sTKJaeO72zvix3karUfDccqQqK/kqo6X0fUm1/aNu33Pdjw6VHKpV7MHaiJhArR7nxMLmJnVlINF3G/WUcS34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721893967; c=relaxed/simple;
	bh=A7CLgRbWMZ+cFvBw/N3DfWwnkk5FgFwxgjnz1Tvfi9c=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+L5qFhdXuopVMGK9iTRMlJi9x4Rk+UdmibhuMdvSVx4hzdoYWXZSyCpTYdStCllOY1efp2o4M4yY9qSGaW6vmxYvVrmu9e+IimtO8wbWO6c6sMOUqj3L5iioopZOfD6C2a35WChrTeqFym6dF3GsvQzT/EpehSU1SY8U2ptyZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFJxiI/k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999BBC116B1;
	Thu, 25 Jul 2024 07:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721893967;
	bh=A7CLgRbWMZ+cFvBw/N3DfWwnkk5FgFwxgjnz1Tvfi9c=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=mFJxiI/ke/2sho6ai4rYz7tIZTZLgYAE7ZlslLw6iMArNY3O+bSLBoi9bDzHajo5L
	 fvpG2qRC33U8w3RwVyrASlWrB/sz23I0jp5YhYtIYqxM3p1cCUvQC0Bl9TKbdwQGE1
	 T4ZDgLWeZGxOIvR/gBBTeiKJ4S11Lpf7ftBeUAYeHAYeMmxPRlPAmMc3iu7nU79/9l
	 mtyas+Xn2hVcnqbb23CByAM3u4yoVm4B4CO9pvPDrM5ZX0a0hA4WuHw7zpbqNY9Nkv
	 uaxS88ez9a1yoF8nbsrcLm6U87mvodmDUTaPhbS8PDgYwC1NzTFne07qVf1tl6Z7+7
	 tsZO3xuPRaJmg==
Date: Thu, 25 Jul 2024 08:52:42 +0100
From: Lee Jones <lee@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] mfd: mt6360: Simplify with cleanup.h
Message-ID: <20240725075242.GA501857@google.com>
References: <20240707114823.9175-1-krzysztof.kozlowski@linaro.org>
 <172189384152.837660.3590109373140262352.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <172189384152.837660.3590109373140262352.b4-ty@kernel.org>

On Thu, 25 Jul 2024, Lee Jones wrote:

> On Sun, 07 Jul 2024 13:48:22 +0200, Krzysztof Kozlowski wrote:
> > Allocate the memory with scoped/cleanup.h to reduce error handling and
> > make the code a bit simpler.
> > 
> > 
> 
> Applied, thanks!
> 
> [1/2] mfd: mt6360: Simplify with cleanup.h
>       commit: 05dd1b4a8d71b5c422bff8bf6ad22baf5722c2a2
> [2/2] mfd: syscon: Simplify with cleanup.h
>       commit: c80c7dfec9d8514f1fcc34402124026e59d2e2cb

Not keen on using the includes filename as a description.

Changed the subject lines of both of these to:

  "Use scoped variables with memory allocators to simplify error paths"

-- 
Lee Jones [李琼斯]

