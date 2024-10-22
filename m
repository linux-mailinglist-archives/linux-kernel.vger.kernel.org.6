Return-Path: <linux-kernel+bounces-375639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2C29A9882
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 884411F240E2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CFD13CFA5;
	Tue, 22 Oct 2024 05:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRJV0um5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C96E14831D;
	Tue, 22 Oct 2024 05:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729575151; cv=none; b=qZ49WUG6cY4WyxVh1bYe805RWcrmcwElCJF5v6eZDloTp+cS/RrPSW3t0Zb6kR266HNguT+LXpaC91wryI8/lpzRKU4lvG+yttXgIxD56fkTW4XM4JgSc+PMRwhWpuRInN9/5DV0jwV72HitczMgYWKs+NcbgA/J0KLVknJqUJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729575151; c=relaxed/simple;
	bh=kSF+9+ajZJQvMRaoOEcOAl1pa3G1ScWHQcL2VdO0LP4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=M9E1KmbQI9jxd4qtIhpOt1eRT1dwmlnnAoca3buUaQyfMaIT3ZGN/ECCaySl70NaxU36YWz2UbWL9peojZmeX/kx6NC/ydTdk2GOTEgGd/Rm0VBX45EmNiU++/pI7jJl1g/rbeQfJBHjfcMqwIQG5gqDC7oU415Gzh+oA+VAuLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRJV0um5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6E5C4CEC3;
	Tue, 22 Oct 2024 05:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729575151;
	bh=kSF+9+ajZJQvMRaoOEcOAl1pa3G1ScWHQcL2VdO0LP4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kRJV0um5j1Vwy/rE73i8oqZeQHRGXEHoJP25oHgNMbBm6kh+L04cJYCRNRP3yvuU+
	 kMU4osyRQIZqidUchiqRxqyE6hvsBUe6QbtMPc6Amw6pJb5z+3DfxldZTdy3ogMtWo
	 FVb1LPFMjfkQ0wzhSGqX5rmonR9TeZfIyvpbtrMO6SM0hvem3rxkMc5Ex/N6B8yt+W
	 xkXIbE+8yukmpadDeBmn6AZGmmQPz1QcgBhtGOcZHdiwB5yOIGFxY4u3BTaS5dKhTf
	 Ge5ndPWB0/cPxs78mn6bEHOsEIYJZarVgY8xAqz2NodbrlkANXiLxjTwZ4T7iK6ckD
	 roBWYpacYc7dw==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Lars Povlsen <lars.povlsen@microchip.com>, 
 Steen Hegelund <Steen.Hegelund@microchip.com>, UNGLinuxDriver@microchip.com, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Daniel Machon <daniel.machon@microchip.com>
Cc: linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20240909-sparx5-lan969x-serdes-driver-v2-0-d695bcb57b84@microchip.com>
References: <20240909-sparx5-lan969x-serdes-driver-v2-0-d695bcb57b84@microchip.com>
Subject: Re: [PATCH v2 0/9] phy: sparx5-serdes: add support for lan969x
 serdes driver
Message-Id: <172957514813.488852.12562116691017295702.b4-ty@kernel.org>
Date: Tue, 22 Oct 2024 11:02:28 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 09 Sep 2024 17:14:40 +0200, Daniel Machon wrote:
> The lan969x switch chip (upstreaming efforts beginning soon) has ten 10G
> SERDES'es which share the same features and data rates as the Sparx5 10G
> SERDES'es. Lets take advantage of this and reuse the existing SERDES
> driver for lan969x.
> 
> In order to do this, we add a new indirection layer to the register
> macros, that takes register differences into account. Additionally, we
> add driver match data for other differences that we need to handle.
> These other differences are handled by a combination of constants (eg.
> the number of SERDES'es), ops and if's
> 
> [...]

Applied, thanks!

[1/9] phy: sparx5-serdes: add support for private match data
      commit: d41bb5e00ec7ac2905ab115ed4bbf971aa593704
[2/9] phy: sparx5-serdes: add constants to match data
      commit: 8e65baf8ccc1fdc72645db15a10bd69209cccfb8
[3/9] phy: sparx5-serdes: add constant for the number of CMU's
      commit: 5206ba966d0b053bcd15e4fcba17284201ca6199
[4/9] phy: sparx5-serdes: add ops to match data
      commit: d61d42a91e322f73b8c68e22347469306b280008
[5/9] phy: sparx5-serdes: add function for getting the CMU index
      commit: f16df057837e06d16b5e5f978d79d80d70784b80
[6/9] phy: sparx5-serdes: add indirection layer to register macros
      commit: c8e4c8b7ea47cb9044c190e6148e994c8e04a34a
[7/9] phy: sparx5-serdes: add support for branching on chip type
      commit: 6158a32b431bc93f35aff03c9889417a7643da9a
[8/9] dt-bindings: phy: sparx5: document lan969x
      commit: c5699055472ead216c38236476c62bf43fcc3ca3
[9/9] phy: lan969x-serdes: add support for lan969x serdes driver
      commit: c0a0a7aec1b142e116c61f3d3facc8c80e97bbff

Best regards,
-- 
~Vinod



