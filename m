Return-Path: <linux-kernel+bounces-347268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2036998D04C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D41B12822A0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E4E1E4924;
	Wed,  2 Oct 2024 09:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZcGORcVI"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C0E1E1303;
	Wed,  2 Oct 2024 09:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727861617; cv=none; b=hDvcO+WA2AYXN0L+bH5WY8PvlIzIQtQzQJkJqFd+lr9+qJOgZgm/xxjjmBdwnMxjwsRQmTk+jWjl7yqBKBDvIDaGgNW7jyZujmN+ZQWgHGdx6E/CaMB1hlW3q+G8VcNpzDrstRLrTP2nKN6l9f46i0jkm2Tbm/vQ8hAgwRibRMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727861617; c=relaxed/simple;
	bh=73Y1hofBdzftE9emw1h4sgSdtWbw3t5KD4Ae+00mWZ8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=haFf/EksfR7iVDJfMZKL+fuPyeUdhVNZCMTCeWhxW9RcmFXfQz84Abwx/l28Wmw9cfNfCKP/jy3gMstjjHksuwOIWmT/F5ChleucQVvNd3hI2b/IlTB1evJOMHO74J9XBfbzoc4276CvjhyPvbKLUnvgOwJ89lJ2jviJcbCL9rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZcGORcVI; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727861611;
	bh=73Y1hofBdzftE9emw1h4sgSdtWbw3t5KD4Ae+00mWZ8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZcGORcVIoEv/QucTxE9d6FFbQpEv/unJlHYP6JXDtWZGBuQ3Q3nkwOmKNSEXy+USi
	 +iIg9y3t3ie2k3TcjD8riUyFXUjV6Xzk9lhKYyad8wwhPZf/ArBAt1iif/Li5PPGXu
	 cAY1RHZo0OA69oRlQxKWW99Ij0+FpZwc0BtNl85S1nAUxCmtQwDAf3JN/Z8R8i0k1c
	 O5YIzOGzA8pfu2KQ1keF0g+a5dn1ArU0ZSH5csYeGIpsJNhAnL36KC26FfSFO6ll7x
	 qrG0bUJ8/o83es1/USqO3qMnQlOe+u3bRC/bCGlLHZuGlrJCk9gSKc4gfivKuET4j9
	 1nzMDEts0XvYQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9727717E1227;
	Wed,  2 Oct 2024 11:33:30 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-kernel@vger.kernel.org, 
 Max Weng <max_weng@compal.corp-partner.google.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 matthias.bgg@gmail.com, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20240924101559.879167-1-max_weng@compal.corp-partner.google.com>
References: <20240924101559.879167-1-max_weng@compal.corp-partner.google.com>
Subject: Re: [PATCH v3] arm64: dts: mediatek: mt8186: add FHCTL node
Message-Id: <172786161056.39477.7674013877665193650.b4-ty@collabora.com>
Date: Wed, 02 Oct 2024 11:33:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 24 Sep 2024 18:15:59 +0800, Max Weng wrote:
> add FHCTL device node for Frequency Hopping and Spread Spectrum clock function.
> 
> 

Applied to v6.12-next/dts64, thanks!

[1/1] arm64: dts: mediatek: mt8186: add FHCTL node
      https://git.kernel.org/mediatek/c/43a9d9ea

Cheers,
Angelo



