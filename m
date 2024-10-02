Return-Path: <linux-kernel+bounces-347263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E3198D042
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD0FC28903B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900611E1A04;
	Wed,  2 Oct 2024 09:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HTH+6koB"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D561E0B93;
	Wed,  2 Oct 2024 09:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727861615; cv=none; b=qWARleDo+/4GV7hf5Bmpo8xs5kzitY8fTH+HIpyE/zeJK/YOA3iai8zRupopWuRfTtXi64yr/2L3WP1kf9unwcqqhSxBjTXIhbSVK2ExNjJ12Loy7OQOKtZPhF4+bgpR4Dwf9xRY7jJ1+4nxCDjLmjoqWZjEo9XfXxi5OzL3s5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727861615; c=relaxed/simple;
	bh=0S93rWEfjMVEo/fyh9wrlblnAUV4pqcHsyVbNmBMAyg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XNNpkyMlOMZTQrOG/ZK6/wfGdPNSlvqqCMxA/y+zUucq6vZKudUPzrpyQW0mWz+GCvEvi5WYozaNr4SzEEG6nVkUSJGwGWI/XU9Wu3ZHanPxyAwoWME1uqrT7srJ1KeYWDJhcJ7/mA/j1c6shM7EOdVRbl10oWA+APsl4GYzF00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HTH+6koB; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727861611;
	bh=0S93rWEfjMVEo/fyh9wrlblnAUV4pqcHsyVbNmBMAyg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HTH+6koBsK75t6aQ+zf5bJI5k/OlOXavLmRDyCUrfApe+3TH1vWwKeaH0WX0OP5ug
	 37h46lyOOw02nlbnC9gsu7gSLwrZMDWk9ujGi6OAzNl/bZCLcxajsRugQn0foMu4nq
	 fyMYngtlVsOMNgUVPeEBw6d3ylI7CMBQZJclmUvczUU+tP7nbOIAbXdXgrOJ6N/j+s
	 V49naHc2KjJ7GKErNBuMpfY1FYLOnZWTyzHbrkrgsqTSP2V45enx3PmdAe7p5Ndhnx
	 sw9uSfdqp947ZWbD/QXcLXcuCJFey7hwaHSqCV4LJnOgWS0BhDdV2oxZE3Eq5dMqgL
	 VNjj6bkC35nMA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 247DB17E1245;
	Wed,  2 Oct 2024 11:33:31 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Pin-yen Lin <treapking@chromium.org>
Cc: linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Chen-Yu Tsai <wenst@chromium.org>
In-Reply-To: <20240912154451.3447081-1-treapking@chromium.org>
References: <20240912154451.3447081-1-treapking@chromium.org>
Subject: Re: [PATCH] arm64: dts: mt8192-asurada-spherion: Add Synaptics
 trackpad support
Message-Id: <172786161109.39477.14598458914282754770.b4-ty@collabora.com>
Date: Wed, 02 Oct 2024 11:33:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 12 Sep 2024 23:44:29 +0800, Pin-yen Lin wrote:
> Some spherion variants use Synaptics trackpad at address 0x2c in the
> I2C2 bus with the generic HID-over-i2c driver, and this cannot be
> distinguished from the firmware compatible string.
> 
> Support both trackpads in the same devicetree by moving the trackpad
> pinctrl property to i2c2 and adding the node for Synaptics trackpad.
> 
> [...]

Applied to v6.12-next/dts64, thanks!

[1/1] arm64: dts: mt8192-asurada-spherion: Add Synaptics trackpad support
      https://git.kernel.org/mediatek/c/925ebc0c

Cheers,
Angelo



