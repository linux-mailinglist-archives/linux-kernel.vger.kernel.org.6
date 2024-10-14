Return-Path: <linux-kernel+bounces-363807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3233199C751
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5870FB246D1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B7B17BECA;
	Mon, 14 Oct 2024 10:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DuC3PmSc"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2FC15855C;
	Mon, 14 Oct 2024 10:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728902481; cv=none; b=fK4bc8xZ7YBoLubQnE+oGUyO3ftOPEtNu99OYR3c1LKWsiqwnIOap62TBh5UOxnTwZXV2hWjZkhEseWoL3g0Ij3VPYMuAR8ui0lstaVsgbvWIDHZLrEpk3p66kwrqO7xQ9C062drWIUu+jD5cjOebTukK0eFNBxncaamPgrCZBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728902481; c=relaxed/simple;
	bh=XmwBEieipqI98EXzozIfgzSqZkvtvNI1ertavm/6D7Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rMmMZOpPVA+tQhtGthRspFzENeLacFxHm4RVMSZzGOKo23gTvn3IZcAOj22jTfH8VGmZf0mG3wKHm8qc66o1ajysaKgCrC8uwm8DdfRLC2DSK6MhSOu2TzVkubYhwkz216Mx+cQPA6iJEYex2S1K4wIuvU7L8cFGj1vivfEcZs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DuC3PmSc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728902477;
	bh=XmwBEieipqI98EXzozIfgzSqZkvtvNI1ertavm/6D7Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DuC3PmScZZNXT0jjO3PVBPdoaDsbC4eXLWd0JvfIR9FrSRyDD+LerT8n67kCflzgx
	 zdQv+ta5yjdbZZ0ufqSQ8f1c8Q5q3/zfWBshOfVhisrBTBwv1MSOXSe+mxZRMinfF6
	 +GYMsnIbTF9lQvErGnF2muaoAXVUu2a+Pa00ey/A7l/FGxWK2HS5msza5nTqXlQ+wO
	 FEu69GRl08tqL1FMWuAwkmPUaNLr7JRAopCQe3pNwh7/+XRMlqjvkRdwEAdvGt3AE4
	 co5/ztMsPAbErIcfV9+DiiFdO+avy9bJZ2z8Cz62F5+pxEEH98rwOLck/6qRhdfjk/
	 wpmSe9QV1a6PQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3043417E1394;
	Mon, 14 Oct 2024 12:41:16 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Jieyy Yang <jieyy.yang@mediatek.com>, 
 Jian Yang <jian.yang@mediatek.com>, 
 Jianguo Zhang <jianguo.zhang@mediatek.com>, 
 Alexandre Mergnat <amergnat@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>, 
 Macpaul Lin <macpaul@gmail.com>, Sen Chu <sen.chu@mediatek.com>, 
 Chris-qj chen <chris-qj.chen@mediatek.com>, 
 MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
In-Reply-To: <20241007100749.6657-1-macpaul.lin@mediatek.com>
References: <20241007100749.6657-1-macpaul.lin@mediatek.com>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8390-genio-700-evk: enable
 pcie
Message-Id: <172890247611.118422.12613533040969688519.b4-ty@collabora.com>
Date: Mon, 14 Oct 2024 12:41:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Mon, 07 Oct 2024 18:07:49 +0800, Macpaul Lin wrote:
> Enable PCIE, PCIEPHY and related Pinctrls for mt8390-genio-700-evk
> board.
> 
> 

Applied to mediatek-next, thanks!

[1/1] arm64: dts: mediatek: mt8390-genio-700-evk: enable pcie
      (no commit info)

Cheers,
Angelo



