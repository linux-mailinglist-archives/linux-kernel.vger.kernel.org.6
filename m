Return-Path: <linux-kernel+bounces-519019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2F3A39724
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9839E170D72
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA83522FAFD;
	Tue, 18 Feb 2025 09:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fjG+SX4u"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4E522FAE1
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870959; cv=none; b=nwvKf/3Ky5QnR837Jy8kQlPKmN7rh2GywWAhpkK7rGNeSeNaX2Re9DpP0Ld4ryugRru5FGNadRuhjTyMgyJm0HlBUPyjsk7UNztrgM2yXA56kXkWtlF6iAYdDbAC2NfsX/zQSCUTDdcwA2JrFZm0KbgqE2z7T6gb1WfqSKIIuj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870959; c=relaxed/simple;
	bh=yQlBwEetNAXy1+J71TlsSNNeiqeKL1aRYliDQ7TohCs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Svxm2Ts42AQcC5rCW/j6V4tI0sCestUTrwsT0Ezr4oPRSjcpSTBIEZ9Vnb7elBJfyyVgO5cmwtmDHF0xNAJqMLk+cRtpeI8TvlxSOm/gWaFNA0uyy7eq/4iRscR5yHVe+cO4kawxdP980h2weWrv20hwk0jCW3i15HrSkCaZc04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fjG+SX4u; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739870955;
	bh=yQlBwEetNAXy1+J71TlsSNNeiqeKL1aRYliDQ7TohCs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fjG+SX4uSZwOGJWlQQAcOjH8oiGU8nmGlgm4SJDaKTO5Pnq1BVy+s/7nTtpBMJGDR
	 QvlZ98DxAUx5hfByzWyyIJmqa4pYrTN8YBJLdJjvO0wMqm2Gflq5qDqfb7yYp3TPbI
	 qnj5uUBGrqyfeaAY4cMuJkQzYeCnm1eUJ8KEwrNmvbtzBdYS0JBuWGqKkqAiZ6CDGp
	 o87Nsu91rkqvdNbJYt1wqdAxmuNDJKy9z9FYCZCjvuCLXNORsOjHUTQIt5ZYDQcZWB
	 3EpWnb66rGla+/BgFwTGvrjFs0aajrqIrpNfWYtakAuiM0FSEz5C/rupklAsbFx5Ra
	 VYFmVdC9/+hDA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5A7F017E0391;
	Tue, 18 Feb 2025 10:29:15 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 Fei Shao <fshao@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <20241219113411.3999355-1-fshao@chromium.org>
References: <20241219113411.3999355-1-fshao@chromium.org>
Subject: Re: [PATCH] soc: mediatek: mtk-socinfo: Restructure SoC attribute
 information
Message-Id: <173987095528.24486.1591525974990532719.b4-ty@collabora.com>
Date: Tue, 18 Feb 2025 10:29:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 19 Dec 2024 19:33:50 +0800, Fei Shao wrote:
> So far, the MediaTek socinfo driver populates the SoC information as
> follows:
>   - family:  "MediaTek"
>   - machine: "<marketing_name> (<soc_name>)"
>       e.g.,  "Kompanio 1380 (MT8195)"
>   - soc_id:  <null>
> 
> [...]

Applied to v6.14-next/soc, thanks!

[1/1] soc: mediatek: mtk-socinfo: Restructure SoC attribute information
      commit: da77c2d3d06c6fa36ed26a5a48490b80e4f94753

Cheers,
Angelo



