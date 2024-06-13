Return-Path: <linux-kernel+bounces-213716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CEE907972
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D5D71C22BF0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C66149E01;
	Thu, 13 Jun 2024 17:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSLLD7t0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA04149C5A;
	Thu, 13 Jun 2024 17:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718298595; cv=none; b=jmfb8FTZo0804pc8cQfvaQGLrHb/raZ6qlJlwuZiFqlw6I9jUgkb/gnuYz9c/9DyjYPCZCpVwWXda/1MKuY4DQOQ2mOzWU8Hzvh1jLwXIfPtrDltsxKdQcJuINuXaMj72UDoxb8jJlHdP817lheh+/Bgrai3nD9vBveivW0IOnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718298595; c=relaxed/simple;
	bh=sawuofgiTla22xNeYJ7qMOaw4kLeel2V7h6pjTPcsy4=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rlCY80xnw9f68x1KTOGDw3gPitMzr5zpl6P2mhTSGk7R6sQg22iMJRRAMwnPcL+duanyfvA4vdqv3BACkx7sXa+kmNy7kCzc9CYuwueyS4ck0p/bLXrqIQDFZqTuB3iov3xlPv6MI3fvwXyP8kkTgoog8uYn1uyCwRgnYISrAFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSLLD7t0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E585AC2BBFC;
	Thu, 13 Jun 2024 17:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718298594;
	bh=sawuofgiTla22xNeYJ7qMOaw4kLeel2V7h6pjTPcsy4=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=uSLLD7t0C1sZaoqbsr/ALoQz7x5p/xxV5cigTZ7XYHqwypv5JZvPJFYSwZkP2FL9N
	 8uC65AYK11K2EKbEz74W951XcmEeJkVd2sc5Odf0zviaBSyQ3/FeUq+p2u6CJfp0Ax
	 3JqYIHeMZrdY0QyZQNysWBTYl75mLuSAF4D4uz7efP9PzRgT2WxRIYsUdcefM+CpcE
	 FIr2Y9Y7GnlV6nK6W8749oTAB6sFzTu6Nozt050HrZ/5gZbK5xxhik4XXzKfPjpx2r
	 rlR7T3ZNbpntTiCOG6ODOfKMRzLkghYwA2Ds1ALeoUN3LMEw2FoMgAsaJoEH3UmSlb
	 TlUiENI91I4xA==
From: Lee Jones <lee@kernel.org>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, patches@opensource.cirrus.com, 
 llvm@lists.linux.dev, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240606143648.152668-1-krzysztof.kozlowski@linaro.org>
References: <20240606143648.152668-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/3] mfd: max14577: Fix Wvoid-pointer-to-enum-cast
 warning (again)
Message-Id: <171829859167.2724644.8244967741458502000.b4-ty@kernel.org>
Date: Thu, 13 Jun 2024 18:09:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Thu, 06 Jun 2024 16:36:46 +0200, Krzysztof Kozlowski wrote:
> 'type' is an enum, thus cast of pointer on 64-bit compile test with
> clang and W=1 causes:
> 
>   max14577.c:400:23: error: cast to smaller integer type 'enum maxim_device_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
> 
> Year ago this was solved, although LKML discussion suggested warning is
> not suitable for kernel.  Nothing changed in this regard for a year, so
> assume the warning will stay and we want to have warnings-free builds.
> 
> [...]

Applied, thanks!

[1/3] mfd: max14577: Fix Wvoid-pointer-to-enum-cast warning (again)
      commit: 9d1e745c2dc06fed0eb6e3b549b75669f9da77be
[2/3] mfd: mxs-lradc: Fix Wvoid-pointer-to-enum-cast warning (again)
      commit: a377d89e5064e787deecfb87d9464ea18f5f067e
[3/3] mfd: wm8994: Fix Wvoid-pointer-to-enum-cast warning (again)
      commit: 05bb1fb09b523136acb58421361a259127de68d4

--
Lee Jones [李琼斯]


