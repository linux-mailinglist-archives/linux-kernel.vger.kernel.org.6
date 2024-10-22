Return-Path: <linux-kernel+bounces-375984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF37F9A9E33
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607721F24222
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8725D19995E;
	Tue, 22 Oct 2024 09:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fsd1JyMo"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF3317B51B;
	Tue, 22 Oct 2024 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588574; cv=none; b=s+JxksK5SNt/hxEfh93QedTLrFfziuBCA9QWNvjwmqTifl6yNCAVEEDJMfhuTQvcN6dHYIb8GDLMmwElC+dqc62L6664my0l8Bmg29O2R1LvCoE8UpYdUB5sJ9maRaNfyVn11G2YN0M50qiv0PX5tvRtzIy3UKByTlo8wmaOvFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588574; c=relaxed/simple;
	bh=8I1J+Ow2u6TaDaq3YClWuoQ4+wuldxjkbbLHsfWOIOI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n50gnYqE58jQjIHsaknq/xNbzNR1LOLIT435iK6pGANg+gv3FXshVjeHCVy1wLKxVm5IltDwTypZpW3qWSMJSUEvKFk2OC+UjdrdAjA1OHkGR4gR69Be7Uv/WNg2Urlfr9sl634vh26JAyYNbw0Qpwh+KIZxeiwqktFqMgHfMZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fsd1JyMo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729588571;
	bh=8I1J+Ow2u6TaDaq3YClWuoQ4+wuldxjkbbLHsfWOIOI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fsd1JyMo0inTZbf/lAH97EXxZxpTJpitc/x4HavJUZTAt1HnAYyIxAH6Pdrn44LtR
	 k4/QyQTR/zMkyxJlVEAkUIjqV+9QB2ERlN3LL+jmdTdTpGP19b52qLLqoORYUuLW3K
	 mnEW3XoE6VBXH8f/6JHhxUwb5ZGa9q7Xk88va/rnA1m1FGK+ImaoH9HwvfghHEQ5rs
	 0chn5pnDUPipDSqfKm0S0hEoouCsKCB5pbQsS4y0Gr7yn3lV5q6W1rT/2ZV5MkKrPc
	 4rK4ofl+M3uWt3/bXHEpDGk+gtmAPN0CIAjepx0h1Mrl7jhTj9xi43rL7DWqU7MPmX
	 xtaulbxExcGGg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2CD8217E12D6;
	Tue, 22 Oct 2024 11:16:11 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
Cc: devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241018082001.1296963-1-wenst@chromium.org>
References: <20241018082001.1296963-1-wenst@chromium.org>
Subject: Re: [PATCH v2] arm64: dts: mediatek: mt8173-elm-hana: Add
 vdd-supply to second source trackpad
Message-Id: <172958857114.72613.13256249212455678116.b4-ty@collabora.com>
Date: Tue, 22 Oct 2024 11:16:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 18 Oct 2024 16:20:00 +0800, Chen-Yu Tsai wrote:
> The Hana device has a second source option trackpad, but it is missing
> its regulator supply. It only works because the regulator is marked as
> always-on.
> 
> Add the regulator supply, but leave out the post-power-on delay. Instead,
> document the post-power-on delay along with the reason for not adding
> it in a comment.
> 
> [...]

Applied to v6.12-next/dts64, thanks!

[1/1] arm64: dts: mediatek: mt8173-elm-hana: Add vdd-supply to second source trackpad
      commit: f766fae08f6a2eaeb45d8d2c053724c91526835c

Cheers,
Angelo



