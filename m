Return-Path: <linux-kernel+bounces-436505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B329E86DE
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 18:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1928528177B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 17:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E78A18B495;
	Sun,  8 Dec 2024 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwqYhAka"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A7818A6AE
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 17:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733677388; cv=none; b=Z5IDD6CPSkRCQlWf5qDTWdj+YBYFC+lUoBSKYt6QgK3rHPT+rr9RA6WCxDThjqE0HcK/oQEo5g4VGyM2QPv07dm1VhxP0NjrtyLoLL7Qf1R7yEGtMYpDBlOabYEH1Jahu/AGXOcJvqwWgOfpOIWSwyy+YA9guWxaK6EHOgGpEeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733677388; c=relaxed/simple;
	bh=ynzwxb8ZUrtmhHbZfYc5diIMVTylkfhhZS14e6rb1u8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rRqUGRiP6W+HkfoeBjUAKZOPMwSQaluJKpcU09+AgdZVTr4/E88VJawG0pufcIBX6gKKXx2cEpE0Vyw4QBsTvb3nGiE8YyHzixxH6ZjiiD+sMZkqa+a/6fnaPsUTJQl8inoQlDod6xk2zsTO05eHV9RFV9l6/i0StdllzszrBLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwqYhAka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF368C4CEDD;
	Sun,  8 Dec 2024 17:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733677388;
	bh=ynzwxb8ZUrtmhHbZfYc5diIMVTylkfhhZS14e6rb1u8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IwqYhAkaiqnfYZVPgJDNxmkxEZkOlvr3cFsFILRAv2kHs9jBbth0d2Vc1PKGuFq1L
	 Q2l/Q345kz/dmuKx972RzB6eyJIZNsSKLAvnhEkbL/YbI4y6HLosWB8wl89KVsbPKP
	 s4xITn9ejX4vmfkI44okF8EhfJXNd4BWLd1jSDdCfCmUtwOM6wzCFu8cuFyvybHYVF
	 tcOXwRgZBrEzuxblvxpDUrWjgkoWsN2TvvKsW7flY5JFTQzAvLhOi84MDk4z+fyCBl
	 QF3OH1F+IicuN0/apsqSxirH/W65Qe28by2Ki9ZGK62jwStlBa4zRFfOo1pFW4fCpK
	 L+XEkxg+bt/yg==
From: Vinod Koul <vkoul@kernel.org>
To: chunkuang.hu@kernel.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: p.zabel@pengutronix.de, chunfeng.yun@mediatek.com, kishon@kernel.org, 
 matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com
In-Reply-To: <20241120124143.132637-1-angelogioacchino.delregno@collabora.com>
References: <20241120124143.132637-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] phy: mediatek: phy-mtk-hdmi: Register PHY provided
 regulator
Message-Id: <173367738439.1042266.5465775023620885336.b4-ty@kernel.org>
Date: Sun, 08 Dec 2024 22:33:04 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 20 Nov 2024 13:41:43 +0100, AngeloGioacchino Del Regno wrote:
> At least version 2 of the HDMI PHY, found in MediaTek MT8195 and
> MT8188 SoCs, does provide hardware support to switch on/off the
> HDMI 5V pins (which are also used for DDC), and this translates
> to this being a fixed regulator.
> 
> Register this PHY-provided regulator so that it can be fed to the
> hdmi-connector driver to manage the HDMI +5V PWR rail.
> 
> [...]

Applied, thanks!

[1/1] phy: mediatek: phy-mtk-hdmi: Register PHY provided regulator
      commit: 49393b2da1cd5b0a6859693369b4fb27df59d3e2

Best regards,
-- 
~Vinod



