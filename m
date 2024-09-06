Return-Path: <linux-kernel+bounces-319082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A6496F785
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28621F25ED4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CEA1D1F4E;
	Fri,  6 Sep 2024 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="XI42mrDW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E1A1CF5F3;
	Fri,  6 Sep 2024 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634564; cv=none; b=kbShKMZ+I53ZhQcm08ztWw9b4anISqn9aWDJyOgzgD3zMafrx5QTqQYlPl1Oy2kVe1BgvjNZDDrshL8Gdhb+EpfuRu939hVmSmcLyyxG6p64wjlWZ/V5g3o1grrRLtw8Z0+I9pnXfUZ9JkeGUZILO2W23ho5A9JdP9XDsE02+Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634564; c=relaxed/simple;
	bh=LGnZDMfJU884B2YPkVPeudaYSKIzukkErVdTwkER1r8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Sv8VbkmKruqZlnHBT2O4vyV1nG7rim2mKgaR4AyI8J3MEGxdGZLtR7MFlpF+ljimL7xyaI2W540NbEPFc05oTlfkLfi0irEjqQgWdEYOeLvZfE4Wm3og9Sp9ayZmRSLxsaGu/lcnqkzK+JW3DWIRp41PJ03JUUbqD/X5b1aee6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=XI42mrDW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D28C4CEC4;
	Fri,  6 Sep 2024 14:56:02 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="XI42mrDW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725634561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=LGnZDMfJU884B2YPkVPeudaYSKIzukkErVdTwkER1r8=;
	b=XI42mrDWgxG4+GGrNaLclZ2jvIdN/SsSWelDdUSEcxWg9YzPEpcOHm0WjKDOgicpF2pDpA
	TsS2lgB67NhGC6sFXtfK7jf5eEBsf2DKHrX47sqk3TAKK/Dza38SIoSin+lVEIVuBwIeJN
	8k+F9hSQ5ezexArMKhJCdYEpO5SZSnI=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 82d7cc8d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Sep 2024 14:56:01 +0000 (UTC)
Date: Fri, 6 Sep 2024 16:55:58 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: maobibo <maobibo@loongson.cn>, gaosong@loongson.cn,
	jiaxun.yang@flygoat.com, qemu-devel@nongnu.org, thomas@t-8ch.de,
	xry111@xry111.site, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, Jinyang He <hejinyang@loongson.cn>,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: LoongArch without CONFIG_ACPI and CONFIG_EFI
Message-ID: <ZtsX_tcEuOjktUl9@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

It appears that as of QEMU 9.1, it's possible to boot LoongArch machines
that don't provide EFI or ACPI.

Would you consider removing the `select ACPI` and `select EFI` from the
arch Kconfig, so that kernels built for this minimal QEMU environment
can be a bit leaner and quicker to build?

Jason

