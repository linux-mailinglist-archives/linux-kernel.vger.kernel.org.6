Return-Path: <linux-kernel+bounces-530871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 996EEA43987
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A06673AA80F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2081525EFBC;
	Tue, 25 Feb 2025 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pGC9V+uC"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6E925E453
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740475926; cv=none; b=DTVqbdUkDPEz+4VWjC2f6g8BPdL7QRGHP6t1YeebZZEr3hqG87WVeqEQqYjwCzoH1KL0443v+vPKGQpzXgNAmJr9LAtF5f4lZBXBwaLRphs/PebBtbNhG2fDEMaeF4HCaWw2AyVaimOKfKdta3JpPN1vb+u9nFDKqKr1tcW8xII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740475926; c=relaxed/simple;
	bh=T2+zLZc9kPHqAZ320EL8EGWj+CWbObMmnsE9DJNVjtc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TR2QBBH5FD1uTdrtetCPtwrx6meTT+EuFsqIjaVyzew6TxovCkDG8b8iuIqRnXSyhQU7Zp5ELhaUPPfh5CEA3bhXYkd3jlc0M0eOdOncTxsoi6Tyy5nNp42pRJdjTzPDgIXzttMTop0weMOJhrSIytuXM9kpqMFrIqyDk/7nOp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pGC9V+uC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740475922;
	bh=T2+zLZc9kPHqAZ320EL8EGWj+CWbObMmnsE9DJNVjtc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pGC9V+uCzJStgNnlJ4XZbruQ/EJG3TArcUZOIYy3tAvuk8cTuStqHSWEgfpdg4FfZ
	 NzF5UvAzPt0OJixGh02ie1cKPfYOlG8i3eZWguo0P1SNmjCVNmHP2v0/KIjwUT/Z0V
	 MHW5wBVpnmzeAh5A7uqW6rZ0tRRhkF19P+BHu9yCUC3FgffPd+l9uFYLFHcTaacdFR
	 YmeG7IUHUUw8DBOXiDRblWgsIHYOye7QCaWtLyFu+EPkPzX/n7Sbh3S/yD16HKwM51
	 0SlkLS1jKyPO87Qq9QMjhI2bOrgtc4ZS4IjuU7KO5gTekRQFznVK9il7wf3BVXjkJf
	 DZU6dekKBzL+g==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8AEBF17E00F6;
	Tue, 25 Feb 2025 10:32:02 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20250220-mtk-socinfo-genio-1200-evk-v1-1-a683ad028bc5@collabora.com>
References: <20250220-mtk-socinfo-genio-1200-evk-v1-1-a683ad028bc5@collabora.com>
Subject: Re: [PATCH] soc: mediatek: mtk-socinfo: Add extra entry for
 MT8395AV/ZA Genio 1200
Message-Id: <174047592248.25867.13400134127944507230.b4-ty@collabora.com>
Date: Tue, 25 Feb 2025 10:32:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 20 Feb 2025 16:02:09 +0100, Louis-Alexis Eyraud wrote:
> The Mediatek Genio 1200 EVK P1V2 board has a different socinfo match
> for MT8395 SoC (commercial name Genio 1200), so add it the driver.
> 
> 

Applied to v6.14-next/soc, thanks!

[1/1] soc: mediatek: mtk-socinfo: Add extra entry for MT8395AV/ZA Genio 1200
      commit: 8d1f9fcacf3b502f03ca456164cc7f36dabc1c43

Cheers,
Angelo



