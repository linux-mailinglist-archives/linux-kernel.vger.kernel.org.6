Return-Path: <linux-kernel+bounces-220877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EFE90E878
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF4FD1C21A2A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC01C12F5BF;
	Wed, 19 Jun 2024 10:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ocRLht3A"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D27B8563F
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 10:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718793542; cv=none; b=X2WX/tTS+qnqiDzmMojKEyM1COPhi5v6456nI/lPSR/kO3b78DkDY4CCe+hiAi0L2nVe7UUWjkk3qU+2Vxqh4EcvnRthXVJf+7D2oflUEZkczE61EMEFFo9d6A93wSRpptLZ5/FGeM+O+UetdKgyq01sWwQpsyNpL+NwSsm0rfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718793542; c=relaxed/simple;
	bh=cKytdYt5vbtJnQQRa+4N+SmUx0M/mlzx2FbL2XVPyFg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UI3PhXJGfrKTq7y2WVv7v7H88LHj/xujpqP2DIF3nz65RgLgC9cdPbSqOkMBL5zXHUVotkq+Zb+ikGp3BJ2EXV4+dMVf5ncF0+Q6fD48IT1q/9xK5ZiOUSMgUL2Q8SOBanfE/a87nWyyUToo6mcV3QuHGD4MVCEs4qRkm7J0lFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ocRLht3A; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718793539;
	bh=cKytdYt5vbtJnQQRa+4N+SmUx0M/mlzx2FbL2XVPyFg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ocRLht3A77YH0SAmLdV1Q+YwATWPugN9m56L7mBrTX1rm9juVhrUtny2eT+wwSCEP
	 tN4xtL8tY7TIP5X4AsqTpJSv+aaa8APilFUBZoxesBw/Ao/LuvXrylbtVA+8QJ2fRt
	 60XflptarZdLEw/aJVSXODzLowSspXomCTNxxTPDMQhIbq4gn4swrHLRsEi0Vn+wGa
	 HmVMTEuLrkqLM2oQ7zs386TAxC9/dIgRfzGFCmgiLfWFqBPfoEJLUDGKFlgfEGn16c
	 ic/uZxpnPh38mWiSx6IXeyb1cp82gjtiSm69kiBUp74Bihk2bOisP/Nqqp7qrflXNT
	 h/znlx1c8yFnw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 768263780F7F;
	Wed, 19 Jun 2024 10:38:58 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: matthias.bgg@gmail.com, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, fshao@chromium.org, 
 kernel@collabora.com
In-Reply-To: <20240619103034.110377-1-angelogioacchino.delregno@collabora.com>
References: <20240619103034.110377-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] soc: mediatek: mtk-mutex: Add MDP_TCC0 mod to MT8188
 mutex table
Message-Id: <171879353840.114192.14898547206273336130.b4-ty@collabora.com>
Date: Wed, 19 Jun 2024 12:38:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 19 Jun 2024 12:30:34 +0200, AngeloGioacchino Del Regno wrote:
> MT8188's MDP3 is able to use MDP_TCC0, this mutex_mod bit does
> actually exist and it's the same as MT8195: add it to the table.
> 
> 

Applied to v6.10-next/soc, thanks!

[1/1] soc: mediatek: mtk-mutex: Add MDP_TCC0 mod to MT8188 mutex table
      commit: 30db3d4b28990ad7897d66acc43b4f29e33abb35

Cheers,
Angelo



