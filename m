Return-Path: <linux-kernel+bounces-192126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 551288D18C6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F47E1C22C42
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C5A16B743;
	Tue, 28 May 2024 10:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZibhVsIM"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92166139D11;
	Tue, 28 May 2024 10:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716892856; cv=none; b=qx5esJV2JJSfqzKi97PKvNOpgoMHbq1L5wrFH8L0UvmCgaqq1QvwbXmZQYHZHnxQEkegg9bdpZvJftXiOcUs+0kVplIlKhXiJAFzJh/d3JfQ4BNjgeoZLCXWMdlqv/KfMgWnlI04jIGRu+hfn2NR03sOo+KE9vq4HEj8AGAGLMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716892856; c=relaxed/simple;
	bh=1d292TV1UZbC0yrIP5lgIjFD5KX9pGs+tLaH9de1QPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jjFKsYum6Xf1/mFkFDJp5yRkDsM6ukp7ZyhR4pigT5EO8KtDT0v83PMdVFzf9QwL45JIfd9JNQotHP1moMmoh9RENeY2xoCFIIcOdUYWlku6VDmLFQQUbd/pvzB0WQ46xXV14BmPmyIheu6CRSKKyngtdHePnocHXwVZcApcWOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZibhVsIM; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716892852;
	bh=1d292TV1UZbC0yrIP5lgIjFD5KX9pGs+tLaH9de1QPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZibhVsIM0j6+d8yRGB4i00nDw2ZXCwWnVLzOMnf3FgTDEPhfnkFaeQ9NnP8x0E7wJ
	 RGxh9+DG3YD1Lv2WgKopodGETHAhZFXJMLmMltZkwGbCMV1J9NI6o26c5kyaRNzuf3
	 ZZNJbpw0lI9lcoMIofYzRj94RWj1VvWAy0WdEfMo6Qnoqg0uXs69WO+Nng+bQpvFP+
	 Ly2rjb3IphffDl87hp4xMAERLbOuNRRFtD58AFwmweDE11OvozK12wKm1nXVv1WqU7
	 rV+5VW16jHIuPtsMxh7uLHr4lvBawupE4Qse+EgI4N6c1WZHjn5hM6ajjWjNmU7JH9
	 RugBuIt+iF4fA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2F9E83782113;
	Tue, 28 May 2024 10:40:52 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	Pin-yen Lin <treapking@chromium.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	linux-mediatek@lists.infradead.org,
	Hsin-Te Yuan <yuanhsinte@chromium.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: mediatek: mt8192-asurada: Add off-on-delay-us for pp3300_mipibrdg
Date: Tue, 28 May 2024 12:40:36 +0200
Message-ID: <171689282917.117648.357380073276142240.b4-ty@collabora.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240502154455.3427793-1-treapking@chromium.org>
References: <20240502154455.3427793-1-treapking@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 02 May 2024 23:39:51 +0800, Pin-yen Lin wrote:
> Set off-on-delay-us to 500000 us for pp3300_mipibrdg to make sure it
> complies with the panel's unprepare delay (the time to power down
> completely) of the power sequence. Explicit configuration on the
> regulator node is required because mt8192-asurada uses the same power
> supply for the panel and the anx7625 DP bridge.
> 
> For example, the power sequence could be violated in this sequence:
> 1. Bridge on: panel goes off, but regulator doesn't turn off (refcount=1).
> 2. Bridge off: regulator turns off (refcount=0).
> 3. Bridge resume -> regulator turns on but the bridge driver doesn't
>    check the delay.
> 
> [...]

Applied to v6.10-next/dts64, thanks!

[1/1] arm64: dts: mediatek: mt8192-asurada: Add off-on-delay-us for pp3300_mipibrdg
      commit: 476d7adf84deb884e0f8f74417bf5249ab9a95b3

Cheers,
Angelo


