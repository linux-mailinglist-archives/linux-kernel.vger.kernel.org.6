Return-Path: <linux-kernel+bounces-347236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CDB98CFCD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949B21F25325
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B5119CC27;
	Wed,  2 Oct 2024 09:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DwCVwIfJ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B2719884A
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 09:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727860090; cv=none; b=CnNAAYWtJPm+rCwW6upvpkGT/NU1barnya+B5BIsWiwlzRvbah+i2Cnap2HW9HkJXwsYbPokeHKI8LtwVyh/ZnKgTYNGG9uOC26l45X5Sk9vjuApgViQvXXNBL7BDkYVx/DY1/7oHDK64NJIMBzKSM9US8lW6LFUHxFvJ3CD7tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727860090; c=relaxed/simple;
	bh=Uv+gg59I1MzsZycm8h9V1Q3hkVJAqt42K2Jf7dWAjn4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZnUTeOcx5vjO5rva+8cvWyFfBnfGrtVVo2kEk8uZXw1Dm1j6OGdtenSnOSoY/xgBSSeaTkvVIWJQKRmAhp5Zlz9mlELSbnM9pesGCgTnCPoN1wGUmIlC4OTsU46c7s6riAhHiRCWjYl7ly7y70qNfDGl1v/JwGCLRon9wuNDRHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DwCVwIfJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727860087;
	bh=Uv+gg59I1MzsZycm8h9V1Q3hkVJAqt42K2Jf7dWAjn4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DwCVwIfJA1qP4RmRK4wpk0QmCXyp+gA7qqrYBIIWQmT4KuLvBg96v6dj1b+lTOiGe
	 BKo9G2ZksMLz4aBfRdRftjplnLLZ1GFTU6dP1EpOKM2JtT5wWH0TjdQ47GWlbPZtrS
	 nXebW6YSstcTre7R/HbbURdRZfPT7A4i7YgzGUZD8zY3nqFpt2VCW2pIMwGZzr9F8R
	 mxAcgKvI+sIeAgo0FM5E/uoJWW6YTBa5abws/y7G1Msr0yY0d8hKAfb37412gKl9S6
	 wp+Zp4UKTOICebRymM5MmD/Nto7ItYrUofrBs+NOJPafXyj9FArKAXr0NjlU6HQ8om
	 U99ZQ5F8W+FHA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C445617E1167;
	Wed,  2 Oct 2024 11:08:06 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: matthias.bgg@gmail.com, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
In-Reply-To: <20240918100620.103536-1-angelogioacchino.delregno@collabora.com>
References: <20240918100620.103536-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v1 0/3] soc: mediatek: mtk-cmdq-helper: Various
 cleanups
Message-Id: <172786008674.33539.15432336067797076322.b4-ty@collabora.com>
Date: Wed, 02 Oct 2024 11:08:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Wed, 18 Sep 2024 12:06:17 +0200, AngeloGioacchino Del Regno wrote:
> This series performs various cleanups to the MediaTek CMDQ Helper lib,
> reducing code duplication and enhancing human readability.
> 
> This also avoids double initialization struct cmdq_instruction as,
> in some cases, it was stack-initialized to zero and then overwritten
> completely anyway a bit later.
> I'd expect compilers to be somehow smart about that, but still, while
> at it ... why not :-)
> 
> [...]

Applied to v6.12-next/soc, thanks!

[1/3] soc: mediatek: mtk-cmdq: Move mask build and append to function
      https://git.kernel.org/mediatek/c/2400e830
[2/3] soc: mediatek: mtk-cmdq: Mark very unlikely branches as such
      https://git.kernel.org/mediatek/c/21ab3dae
[3/3] soc: mediatek: mtk-cmdq: Move cmdq_instruction init to declaration
      https://git.kernel.org/mediatek/c/66705b89

Cheers,
Angelo



