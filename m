Return-Path: <linux-kernel+bounces-237717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8839923D1A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB1291C227ED
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077021607B8;
	Tue,  2 Jul 2024 12:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Kmu+FjaM"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1569515D5BE
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 12:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719921730; cv=none; b=lVMpDZITM4AvXdNjvOJyPLuZGZ4FI+QUxYbtVnQ54o7W5o0ctgDYdZyXLGbGotSv/LjObkDlWX8bk8pscwS22Qcq+ohenwJzYCMOHSmRfuy/U8ceGffzRliP8i0qzss8Yw8SyidoEasvfEi4EGdxrX1nwv9NrbVd425sOkqUP14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719921730; c=relaxed/simple;
	bh=UFSYmtBuaXKRPipjsLJRmYY5gjEWB/YBSAGHtG/6S/U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZBxedSQV85dgNn+6wTFxG/UzdX69KVEH8Ag3lWcTk6Ls4gTt77xgupVECOPyIiumIxDMnEnuXZzcM92s93SsczYi1DnTrZYTtSlMUSjSXRlKltELWPzaNXqgp3JKwh1LZ+8avSq7o7wxvGeB4QBV1HJhdzxDk9FeKndoc6QblDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=Kmu+FjaM; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1719921721;
	bh=FXwb3NDkOXba4t5aP3C9g00gzWbtwMStp3ogpDj4GB0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Kmu+FjaMZERhRfktDqkks74plxvjyoFLsSJvWsb0Nge/HXsLlzHBYtPYdiNo2BxTJ
	 8HRfkJzZXvErLi9BgRPoJ1tltiojXBQ2G4GTmHJGmTFjBSLAEgTddJV9pDOuhG049l
	 2vTAwgis/bp9h4cQVwK7PraMeJT7QNWNqLC0ygfuPGvUVV9ZVwYuiPaAuNRnOfDs3X
	 /rYRv4LlwLS5bFLTrPxWJNAlbJgEkTJoEB66+3nDsX5AeQw/4vP4NYmKjgheo4qrVF
	 ioObEliwijeZ5NVR/Bw35UwDMnwD+dH9/fNXyD98M8ztr5gJAInnpZXNaQi4bwfIIv
	 dnCWXznUN+uyg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WD1jf61Dfz4wc4;
	Tue,  2 Jul 2024 22:01:58 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Krzysztof Kozlowski <krzk@kernel.org>, Esben Haabendal
 <esben@geanix.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush
 Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, Miquel
 Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Naveen N. Rao"
 <naveen.n.rao@linux.ibm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/3] powerpc/configs: Update defconfig with now
 user-visible CONFIG_FSL_IFC
In-Reply-To: <d203dd45-fe69-48dc-aa36-d9870065f2e9@kernel.org>
References: <20240530-fsl-ifc-config-v3-0-1fd2c3d233dd@geanix.com>
 <20240530-fsl-ifc-config-v3-2-1fd2c3d233dd@geanix.com>
 <d203dd45-fe69-48dc-aa36-d9870065f2e9@kernel.org>
Date: Tue, 02 Jul 2024 22:01:57 +1000
Message-ID: <87v81oj93e.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Krzysztof Kozlowski <krzk@kernel.org> writes:
> On 30/05/2024 16:46, Esben Haabendal wrote:
>> With CONFIG_FSL_IFC now being user-visible, and thus changed from a select
>> to depends in CONFIG_MTD_NAND_FSL_IFC, the dependencies needs to be
>> selected in defconfigs.
>> 
>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>
> Anyone is going to pick this up?

Doesn't it need to be merged along with patch 1?

cheers

