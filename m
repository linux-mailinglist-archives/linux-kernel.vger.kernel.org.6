Return-Path: <linux-kernel+bounces-197114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6559F8D6662
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F361C261BE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BDC158848;
	Fri, 31 May 2024 16:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdTrXkOO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850E754784
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717171719; cv=none; b=VkAu4kVQO0aQx9rLA9tJh3TQhHkFfn258rcM754tUc3ajEsM4laJIlzju8YSSWIK944/T/HDQlq9AYM3QbeA4Pfsi9DvsKxq7JvM0F6PYWU4T2RJYz+7RVNfL5QGFLmp0e8Rse92JEevF7922WrVv3G6E9DNI6sdr8NdORKvROI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717171719; c=relaxed/simple;
	bh=xEi5iZJ9Hl8689P4byTA9g1DsfJGBtnSSzg1K+jD764=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kXiYnJ50HJvg9rgR8HREROJfKfx9jZOgN77/hndlhoIpVBQaoOlyl3YN6oHrdvOeLs7G2y/uNMS74e42y+gy0ecsTM7AOSaao3WXIj9hyzq3FEiVpQNCISymRAcyVJnwe35FLv9c7R1KycelIXa8eYquqcuZXUN6KOmvif8G7RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdTrXkOO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8671BC116B1;
	Fri, 31 May 2024 16:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717171719;
	bh=xEi5iZJ9Hl8689P4byTA9g1DsfJGBtnSSzg1K+jD764=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MdTrXkOO3KoS+yxH36W6mXnfbi7S/ML40qTGlO0cDrGo08QFmoUZArD/212pp+fEg
	 Ijbnhh7JkIBsLgf+vhGCo30Gxb80w2phCjWf56aTO+ZZWloPMAE2JrZY52tQufiMdn
	 5nqsVJE4wWiGV3YchuTX/HRIh6rb/sl2WvD7KCu6UWk/SuE4KISZoIrh58fDgCYhoe
	 RMbBUohRGcZzWAnB4Zsv503CJvIBQmG4Slj8VK+mAJrlnxwVnH0ij2qgkcWVX5tAEk
	 1ldKv9+LsTQ5HUkBjAGdfr43ujerP35CtNUFwtRaKBcr7QDElmrIzyvZ5THyHwdXq3
	 AJePuWPtOavKA==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Min Li <min.li.xe@renesas.com>, 
 Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Okan Sahin <okan.sahin@analog.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240529094856.1869543-1-arnd@kernel.org>
References: <20240529094856.1869543-1-arnd@kernel.org>
Subject: Re: (subset) [PATCH] mfd: rsmu: split core code into separate
 module
Message-Id: <171717171729.1180844.1171417974798338130.b4-ty@kernel.org>
Date: Fri, 31 May 2024 17:08:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Wed, 29 May 2024 11:48:47 +0200, Arnd Bergmann wrote:
> Linking a file into two modules can have unintended side-effects
> and produces a W=1 warning:
> 
> scripts/Makefile.build:236: drivers/mfd/Makefile: rsmu_core.o is added to multiple modules: rsmu-i2c rsmu-spi
> 
> Make this one a separate module instead.
> 
> [...]

Applied, thanks!

[1/1] mfd: rsmu: split core code into separate module
      commit: d84bcadf16b103f4a3970f70034e9eb8d53878b1

--
Lee Jones [李琼斯]


