Return-Path: <linux-kernel+bounces-347269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BF998D04D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA1AC1F22327
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FF81E493E;
	Wed,  2 Oct 2024 09:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WqbuubvO"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC091E1A0B;
	Wed,  2 Oct 2024 09:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727861617; cv=none; b=grMrJnT8n+OlO1ASku9EavJWtbxzSLluSP1UoIFVOGDFtWvWWnEhbe7KMMMb3F0Lsc7yJPjWuZ7Ri0olpiKHepifWnIup7aJRpiaqllvpWyY2BU7d0dQGcysZcFS163KSZWI8cJNVOF8AElia5UXRoDng1feCflJk28gfmA22TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727861617; c=relaxed/simple;
	bh=crIeX+1YqBeapyeeVy+SwHw+twfzOe2BPfPN8aW1AzY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=k5PQ3uuJoOuHAe4weZngtTpvyLCk8pkAb6EQvg2+L/5TngXVzn3/LHq/pY+J4CFU5qb9qX7YDEDr0K40hMrSXgQhR4wdC8IfkR6LF4PQye6hSBqD4FDXwfyAf/jBmi3s73fCDGkXjWR0KIeTYGerav4joJyS/upBrifnGz/7Mqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WqbuubvO; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727861613;
	bh=crIeX+1YqBeapyeeVy+SwHw+twfzOe2BPfPN8aW1AzY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WqbuubvOKGFbHKKqknz05MJbkSh4o8kB7ri1/FYxBCfLM/xm87eNdVEHGcWWGDop3
	 a7bGixPsJM++my68sjxNgohGbl17EnBch3UzMtGl9sxADScHiCoGbdx7mtkWBRmNJf
	 T8DUiGCDsa/kvo4DTfa9J81gbNM88B8G7P85vyfPIdQ9LhxZdMDsA34k5egpEWKsBi
	 afG5EU5R5+cDGQJmfa39tDPUHplgZXgT8eTnohHRMluuTsFzXF34otKtgBsNQJWfjN
	 YXysvS2qTNe1bu8gPKMR0rDdDq5Gsp6nQi0EAHWKsQrPZhTehT1pXcNz97pA88iQd2
	 cZYhXhE2pdaJA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 81B8417E120F;
	Wed,  2 Oct 2024 11:33:33 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Hsin-Yi Wang <hsinyi@chromium.org>, Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20240910-one-wire-v2-1-2bb40d5a3cf8@chromium.org>
References: <20240910-one-wire-v2-1-2bb40d5a3cf8@chromium.org>
Subject: Re: [PATCH v2] arm64: dts: mt8183: set DMIC one-wire mode on Damu
Message-Id: <172786161347.39477.13562765698626239218.b4-ty@collabora.com>
Date: Wed, 02 Oct 2024 11:33:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 10 Sep 2024 08:47:44 +0000, Hsin-Te Yuan wrote:
> Sets DMIC one-wire mode on Damu.
> 
> 

Applied to v6.12-next/dts64, thanks!

[1/1] arm64: dts: mt8183: set DMIC one-wire mode on Damu
      https://git.kernel.org/mediatek/c/ca80f750

Cheers,
Angelo



