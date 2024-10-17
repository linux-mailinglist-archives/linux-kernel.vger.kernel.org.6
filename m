Return-Path: <linux-kernel+bounces-370064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC3C9A26E3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B30F283A0C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909331DF72F;
	Thu, 17 Oct 2024 15:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I43IDB33"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7781DF721;
	Thu, 17 Oct 2024 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179346; cv=none; b=ZRHW/ENnwRASuW/NVPXmVGkrt6tZnc16bL29w3H67P+Dw6/zSQ7w39t8c3re9TJEYplUeccxlDWp/j1gY70jtfiEyhzCoX7TTWip0ed7ZfrlSBgzZ0cdFQr8jcjTRXLoI94tpemUQlcnP+l0CcUTtNZ6Gc0bHERkLr/RZ32udw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179346; c=relaxed/simple;
	bh=B+abq4J2qxeK8JBY/cAF42RFyKzjO6n4dj5krRyRfkg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DtBrGEwfXT9amSZqD5JbmuIyHkttfAB0z5E708S9O/vwhfS11iPET5w8b814mtHUBMvx7DVQApXbbvFmktTJ2wl8YnW7hE3wb8Qs0p8mg2Fwcan9/EPyc66CyaGMeYwpJs93mgN9Ir0b05qUhHob6hJAbi8GEmoeglF75AmXBvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I43IDB33; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A864C4CEC3;
	Thu, 17 Oct 2024 15:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729179345;
	bh=B+abq4J2qxeK8JBY/cAF42RFyKzjO6n4dj5krRyRfkg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=I43IDB33AoTqRiUwxSTauBr0Juo9Zh2yfZW8Kf89blTuRYUucR78nXaU3DxnZKPmY
	 CDgeo9Pdu/S4lLAKof2KECZ/43tboTN9x15xcR0OGYGbRs0hmt/gSIxKsiQ21m2xRf
	 K2hoQktDHD5i+RJ+VvLNVZaubXFuQmErUo3mKMdekiJKUH8ktiM+sAbn5sUB+ZNI2e
	 iugqRknpdqV6JEsRg5I+wcDLieV4jG9ObKU4eAIeTwn6tpYdC48XPYqIEhNeMfoUPm
	 z2qT2mBP3YW/qzkaFFRlNqHKRW+at4v1nuHsK7oPxbcKYQrcO2ayZ2EnJUsmhzkqFe
	 LoeQYTWTz3LyQ==
From: Vinod Koul <vkoul@kernel.org>
To: kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, heiko@sntech.de, Frank Wang <frawang.cn@gmail.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, william.wu@rock-chips.com, 
 tim.chen@rock-chips.com, Frank Wang <frank.wang@rock-chips.com>
In-Reply-To: <20241016073713.14133-1-frawang.cn@gmail.com>
References: <20241016073713.14133-1-frawang.cn@gmail.com>
Subject: Re: (subset) [PATCH v6 1/4] phy: rockchip: inno-usb2: convert
 clock management to bulk
Message-Id: <172917934187.288841.9418215937562601531.b4-ty@kernel.org>
Date: Thu, 17 Oct 2024 21:05:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 16 Oct 2024 15:37:10 +0800, Frank Wang wrote:
> Since some Rockchip SoCs (e.g RK3576) have more than one clock,
> this converts the clock management from single to bulk method to
> make the driver more flexible.
> 
> 

Applied, thanks!

[1/4] phy: rockchip: inno-usb2: convert clock management to bulk
      commit: 86e2ed4e9a9680013ec9ab7c0428c9b8c5108efe
[3/4] dt-bindings: phy: rockchip,inno-usb2phy: add rk3576
      commit: 0217f4aef0b07a57086baeed9c0ac05160435a45
[4/4] phy: rockchip: inno-usb2: Add usb2 phys support for rk3576
      commit: 3d7de6e870ece5a32153382df9df6fb87613335e

Best regards,
-- 
~Vinod



