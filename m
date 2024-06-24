Return-Path: <linux-kernel+bounces-227080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5FB914807
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00CBC1F23ED5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99F7137759;
	Mon, 24 Jun 2024 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SALgaivY"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6A1135A7C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719227258; cv=none; b=UDa0TF/gQmbCvkFKenOFKuwBjyx6LO39oBKh/3Da0HxFooCswCg0AHDtWAbdLczXTi4I/xMkCjMM2G9n+XqcwqLGLbr2aaGoRuUZlE/Uu5bJLe+ZloH5Xy6iazJyP33jsBRk9LAdT0uEpD6SkQ2HOpo2yzofdS5Eo7ZqsrEVV0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719227258; c=relaxed/simple;
	bh=jUkxCNENgUVPd8pyabJPEJxAF35Fp5C1O7HiFYerqNA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ciQABI2jtlxFBNN3z3hi5XR71gZCxkANjyQRi23Afc/2XCvQeIuwBZ/W3atLSTyseOZZohGp9UTgF/t1Gst6zjAiERRgU2xSnJPBYvQhAG0s3xcyEYPu0sFYXtTezB4rVtQrHBDU5Xg+RBh7ScHG0vkcsHI+kN8eSJRte2yxz5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SALgaivY; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719227254;
	bh=jUkxCNENgUVPd8pyabJPEJxAF35Fp5C1O7HiFYerqNA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SALgaivYlIrfxj08ago5VvJUTF4htQ5pmRgto/x/GkTs/b8oeZqIjF1WIuHIQLLP9
	 l4MS89h/TCjv2w0WkTqR65wYkRUv6kiUKhqlZ8UHn8G3/vX3MIhvAnQzcHkhy6f7Oh
	 Lz6cvU7n0E5UB0DOgCyeX1iPoaRCMXXJgF/dpw1c5xEFlqEvA2ciXQzAx1Ay6fTJZI
	 QF88Guc0phqiWCo4LM7uvsBK33m+iv+NyssATyEfFp17E0Wh/rQIKsYaLGAAp0adCV
	 qYeN2MP1MyXe1n1Z9NJ52lFO7MmJN9c6oacgrnWiF6CbPzvxCjXrUJZ+i2eYA1vGXM
	 pz+v0vmAPiGFA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 87CA737804C6;
	Mon, 24 Jun 2024 11:07:34 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 Hsiao Chien Sung <shawn.sung@mediatek.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <20240620-9bit_alpha-v1-1-13c69daaf29f@mediatek.com>
References: <20240620-9bit_alpha-v1-1-13c69daaf29f@mediatek.com>
Subject: Re: [PATCH] soc: mediatek: Disable 9-bit alpha in ETHDR
Message-Id: <171922725447.131974.17550647418404472695.b4-ty@collabora.com>
Date: Mon, 24 Jun 2024 13:07:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 20 Jun 2024 00:50:24 +0800, Hsiao Chien Sung wrote:
> When 9-bit alpha is enabled, its value will be converted from 0-255 to
> 0-256 (255 = not defined). This is designed for special HDR related
> calculation, which should be disabled by default, otherwise, alpha
> blending will not work correctly.
> 
> 

Applied to v6.10-next/soc, thanks!

[1/1] soc: mediatek: Disable 9-bit alpha in ETHDR
      commit: eb36ad096818e11d54256570d7d49e26565daf5c

Cheers,
Angelo



