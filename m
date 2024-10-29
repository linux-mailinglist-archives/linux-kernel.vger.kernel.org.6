Return-Path: <linux-kernel+bounces-387291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B74309B4F16
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C9B4283970
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520381D86ED;
	Tue, 29 Oct 2024 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3aZv97J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A942D198E9E
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 16:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730218533; cv=none; b=nl7dHMIzdp+xqUE55XzgLfr2XJXAFJH8KnygGvYqMWxwHnGFBvgfK80MTczD5a1bHTMHlUm208tkOgm9bpXwn5HTiMewX3cO4YL6hTe3a7jmoNqErA2tbBtTw7Kw/Ha5zbbbgnDNmnOClJW1+/n1iOyBraBHE2qRIDL4zwB+wrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730218533; c=relaxed/simple;
	bh=vsyWoTwbsiRwsb9EYXxM+GmOQGioC2wxUoNjmlnpZ7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P/xl9Yy3Q/qz2jvoDX8dCPojASMsi6oLj0uizZrKrvT0OD/IXUa2DVwJuKBDEy7BR9Eu58NdYcYFwREE366Byxrl3aSuiBnBCpCzok/9QLpWGJIVENWjNWK1FjItYsmSlUVAl31/B6XZBorb6pA0ced1FFWKuys4cTv/R9GiPDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3aZv97J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75B2C4CEEB;
	Tue, 29 Oct 2024 16:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730218533;
	bh=vsyWoTwbsiRwsb9EYXxM+GmOQGioC2wxUoNjmlnpZ7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k3aZv97JusL09VW1UTsVJVdg/QpFlLRqjHiiIveXEkXQrrF4LPp7Z/2ZLuMcumsh3
	 3Ve1OTTJYhmlHYWtxSKUUmD/+vgRwp14hnO5EpcfH4D39sWfkxGZVAx/U7oxljWtlc
	 8hwT8NsIFNpOH0N0MzmcJrMEHjjLLJqv7LywZZHiLxlApI4h1L3WjDFaA4cxZaeWef
	 uYBsFbusOxn83i2oE5Sk3mon2C51Mdkdet7xIGx4DkYCaKhWWKssFZsU+YE10i9zpF
	 KY0tEfiUxi/p/92rZs06NsFxFpiioW/WaaJm0tUoiSf8i75HhNij9oHoRTXnR2bsoo
	 NjtXqopSboMWg==
From: Will Deacon <will@kernel.org>
To: Russell King <linux@armlinux.org.uk>,
	"Rob Herring (Arm)" <robh@kernel.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: pmuv3: Add missing write_pmuacr()
Date: Tue, 29 Oct 2024 16:15:15 +0000
Message-Id: <173020672798.2294098.11077870064387450759.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241029120602.4061566-2-robh@kernel.org>
References: <20241029120602.4061566-2-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 29 Oct 2024 07:06:02 -0500, Rob Herring (Arm) wrote:
> Fix compilation on Arm by adding missing static inline write_pmuacr()
> declaration.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] ARM: pmuv3: Add missing write_pmuacr()
      https://git.kernel.org/will/c/bdc9a64c8b20

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

