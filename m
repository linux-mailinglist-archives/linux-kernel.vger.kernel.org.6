Return-Path: <linux-kernel+bounces-289931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD51954D72
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDBA41C22924
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B338F1BE221;
	Fri, 16 Aug 2024 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQVmu7j8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B9D1BDAAF
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723821376; cv=none; b=b6u3P5V59xT2A0l0pUIod+Q9ivoRkd8Lh3IsO2mD05lk+T/DHIEYBhLkzFNEwOriqskBFwWj4Jg3QOXbsk6Iaia7B3+64qe51dVaxWNo25iTryLjfDBC2McM2725DHXeH7auJ1VWzju+3LEBYosAVxnR4+5CgM8hqmjRYAzLJk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723821376; c=relaxed/simple;
	bh=/TCiUdpUtUAWWSgqxG0aVXkx54503kY4wFwBTtIoSvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZR6Lv8sd/zO48jqmyjQUt8BECZOxWmCUjgNa4Bpmh2iNzhn86iGpR3rzLYfjhaWHXxeLkTxGHAnYmb88IlUmT9I+A1mjeYN7hwn6BLFymWevQ7nQ9Xz1Y6qMrXDpcG//zF8TF6E2tJE01T+o2CcpQR8d0+jxYFF1ICcYFcdOJ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQVmu7j8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C09EC4AF09;
	Fri, 16 Aug 2024 15:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723821375;
	bh=/TCiUdpUtUAWWSgqxG0aVXkx54503kY4wFwBTtIoSvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qQVmu7j8/ch3SIz6Pi6G+AbNbGw2mnr/W2EhmCm9lPV16QiDS8MxCgfgdxVNcz+CG
	 sO7fG8mCTPGC+BehUrP7Mi0D+ZYVfTLpfDKuA9I6xyZ7h4PpUtqmbRIeQY6Qecdcmd
	 FS6an+D+LdET6TO+dUZ2avOV+MpeGFLePYyKzjA0z51/7UVFhcPOUMPK6V1OgEToMj
	 OaCcWkzEa9rfV3n6XSaBv2Kf4Msc7XaZ2QuGij1UhVR3G3hJ0NNTKSpOh0aZ4/javo
	 gkTSAp6wnGF1+I0QkqGtqs3G2ra7SP8hhnJCRKgB7wYeXPvBJElvUl608gBzBj8ODt
	 eJN6ggO3CFZGQ==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	Anshuman Khandual <anshuman.khandual@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Drop TCR_SMP_FLAGS
Date: Fri, 16 Aug 2024 16:15:52 +0100
Message-Id: <172380389611.1159869.2327634530338895264.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240724041428.573748-1-anshuman.khandual@arm.com>
References: <20240724041428.573748-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 24 Jul 2024 09:44:28 +0530, Anshuman Khandual wrote:
> Earlier TCR_SMP_FLAGS gets conditionally set as TCR_SHARED with CONFIG_SMP.
> Currently CONFIG_SMP is always enabled on arm64 platforms, hence drop this
> indirection via TCR_SMP_FLAGS and instead always directly use TCR_SHARED.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/mm: Drop TCR_SMP_FLAGS
      https://git.kernel.org/arm64/c/6ac96d6f9a8e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

