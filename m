Return-Path: <linux-kernel+bounces-268765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 229CC942908
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA6F2832D2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51581A7F88;
	Wed, 31 Jul 2024 08:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pXEd/Tc/"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E041A71F7;
	Wed, 31 Jul 2024 08:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722413994; cv=none; b=m/Q21kb3HQ7z9hgEK+F4A6Rt9cxb0o6JuF1HeufjztEJeAvzccKm5PljuXI/hER8AXt7ZW4MEHBfu6B0qO259HHOvbuNx36isAqwxniuAdww1LswAOV93xvj6c6vHTqckWHE3QqPfoe8JDlRgfjrIhudYVcPSY8InU12D64BI2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722413994; c=relaxed/simple;
	bh=KLZUCxzeOJ7bmWokWFva6t7JItSJeH9Na9Ou99VElKo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WnpFsUkDHpN1xtT14+7J9b6piPjd7JGfX8igUIiI2n5YNZnLk7k8yYH2ju8FCQt+Q37ToVW122iCgyTBkHb3W4hVCCKWfdKF7Ivcf7B89sv7Ygts8aNAEWYmE2dtHyGAeVyruo+pZ5fNxNsXL1l0E71uTfhuzCmwzE7kRC8mkEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pXEd/Tc/; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722413984;
	bh=KLZUCxzeOJ7bmWokWFva6t7JItSJeH9Na9Ou99VElKo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pXEd/Tc/d44O5iXg1PN+3/mP91j0XIABoTKN5Ng/BuNkTB6sdOo0og8Lj1RHQPw5k
	 TIuW9bQseNthbgIPNxWLP2yd6ppMfQOifVUkUF0KxAlHggs1K2ASm6WIAEBZqB06Hr
	 OUi+6dJyYYTvU0rRYEYE57U9tO+M6VdwjDu5uplHuCF6QdGyKR7/I1L/vFyLqVk0li
	 O5nyaO3D31cUpLyQvf8Ke7Z8I6Erehzxvv0cJTwjoU2SHD0Es3GbrmUEzqRypFCISW
	 D/wTwC1NGEs8TQrjmI3UevVs+oV/f8qf8KdrLTTeUUXZwoB7Iuf3OVBceU7EF8iRgH
	 nnfq6+icpUiuA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2A011378000B;
	Wed, 31 Jul 2024 08:19:44 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>
In-Reply-To: <20240731034411.371178-1-wenst@chromium.org>
References: <20240731034411.371178-1-wenst@chromium.org>
Subject: Re: [PATCH 0/3] arm64: dts: mediatek: mt8195: Fix and clean up
 xhci1
Message-Id: <172241398409.37591.6997026723129845017.b4-ty@collabora.com>
Date: Wed, 31 Jul 2024 10:19:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 31 Jul 2024 11:44:07 +0800, Chen-Yu Tsai wrote:
> This series fixes and cleans up the representation of xhci1, whether
> used in USB 2.0 only or USB 2.0 + 3.0 designs. This work is a result
> of discussions from the original Kernel CI report [1] on xhci1 failing
> to probe, and subsequent patches [2][3].
> 
> Patch 1 explicitly disables USB 3.0 on the Cherry design. The super
> speed pairs are used for PCIe instead.
> 
> [...]

Applied to v6.11-next/dts64, thanks!

[1/3] arm64: dts: mediatek: mt8195-cherry: Mark USB 3.0 on xhci1 as disabled
      commit: 09d385679487c58f0859c1ad4f404ba3df2f8830
[2/3] arm64: dts: mediatek: mt8395-nio-12l: Mark USB 3.0 on xhci1 as disabled
      commit: be985531a5dd9ca50fc9f3f85b8adeb2a4a75a58
[3/3] arm64: dts: mediatek: mt8195: Assign USB 3.0 PHY to xhci1 by default
      commit: fe035fa6f56c5b8146fcfe4253edbb9e9399ce2d

Cheers,
Angelo



