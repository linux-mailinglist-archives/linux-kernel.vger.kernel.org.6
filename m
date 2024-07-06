Return-Path: <linux-kernel+bounces-243398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9041B9295C7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 01:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BE171F2198E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 23:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667E545BF3;
	Sat,  6 Jul 2024 23:13:07 +0000 (UTC)
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9225200B7
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 23:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720307587; cv=none; b=gsz7RBVSXTw1b/E9NjdbPuHqmSzaBlY0GJy8cLMia4WX78GeRx1fREqDBUQIjzlO7heqp6Xab4V/PR7As1kCRDtU1hAQNdDjRY8+jHnau2l6ikx3IxpYyouZmrL1VIQOqf7rkZ414Z2F+jkFzVwEBWNCS4EjmsAe+NofSz/bhX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720307587; c=relaxed/simple;
	bh=LdbwVRuzCUE4z7TVpnl/KLnOa3dbAYT+P+vSk0ghpB4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BCXNYsHyihRalxpz4JnptexEB+mUgKoeioA9Aco+7VqixldgzX+Yo9O0bNaYWHzdWv5kLo0T9ifE06HKkZ5GxEarY3X9GUYcdPx8Bo96PHwh22pfwnwxEPO7F7BWkeSOuCmC1GmI2sXSGTslFcWrbZS+j/Go/rj5of1warle0WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WGmPy3kcNz4wbp;
	Sun,  7 Jul 2024 09:12:54 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Krzysztof Kozlowski <krzk@kernel.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Esben Haabendal <esben@geanix.com>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240530-fsl-ifc-config-v3-0-1fd2c3d233dd@geanix.com>
References: <20240530-fsl-ifc-config-v3-0-1fd2c3d233dd@geanix.com>
Subject: Re: [PATCH v3 0/3] memory: fsl_ifc: Make FSL_IFC config visible and selectable
Message-Id: <172030740436.964765.1139338200184408064.b4-ty@ellerman.id.au>
Date: Sun, 07 Jul 2024 09:10:04 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, 30 May 2024 16:46:35 +0200, Esben Haabendal wrote:
> While use of fsl_ifc driver with NAND flash is fine, as the fsl_ifc_nand
> driver selects FSL_IFC automatically, we need the CONFIG_FSL_IFC option to
> be selectable for platforms using fsl_ifc with NOR flash.
> 
> Fixes: ea0c0ad6b6eb ("memory: Enable compile testing for most of the drivers")
> 
> Changes in v3:
> - Refresh arm64 defconfig.
> - Link to v2: https://lore.kernel.org/r/20240528-fsl-ifc-config-v2-0-5fd7be76650d@geanix.com
> 
> [...]

Patch 2 applied to powerpc/next.

[2/3] powerpc/configs: Update defconfig with now user-visible CONFIG_FSL_IFC
      https://git.kernel.org/powerpc/c/45547a0a93d85f704b49788cde2e1d9ab9cd363b

cheers

