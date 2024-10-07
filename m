Return-Path: <linux-kernel+bounces-353744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EBF993201
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 175991F254D3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23D11D86D6;
	Mon,  7 Oct 2024 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvftFzmr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509E91D5ABA
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316159; cv=none; b=mnOGySfJsyIcEXcEIMNhXMbNnv7EG4Ca4AVk91Q4OwIRvqlXtkKST+/gEd+u6dyng4KyBtrZ40Zp1gAkj1VLKyr5ajjFcEMHsvcl3VV/XCMTdTQNraU5ZXGvihd3qE385kpK6XP/pkOtjgCTyabgILV6UYHfh5QQTEDEb04OQ20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316159; c=relaxed/simple;
	bh=JZaodJsdbrVJ1iauYiNFyzN1+/9kUcGmGPzolkN7gTI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cO3IYj1Iru2cDe6KEtnjek9plC9Za9NL1kWZni7K379mbjgxV4WmaiZQJIBtaXTBKqhax30rysQ9+reR8dsCAXufFR+HBNnvMGYGV3YcDdv+aFydfHmZ0PRkVFUfRliHOdYI2KFOPX+4M0XJq298XFk1K925/wsjO6iWlJ+ufIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvftFzmr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE2EC4CEC6;
	Mon,  7 Oct 2024 15:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728316159;
	bh=JZaodJsdbrVJ1iauYiNFyzN1+/9kUcGmGPzolkN7gTI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nvftFzmrpfdug87BcW+9XOkVMBjgc5z2GWWHwvyj5o+l0MFwZzHd3PpRQKO1NxlJs
	 OlywJD6AkjfI7gif2jVIhWVfgQ5Tv/ogS9yEw45LOXW5CpNRLpJD3xRNsQe55StllM
	 RJlC7ZWLYcJ05IRp4MPImZz5lwDNmvEu0ktgaKCKPb1M9tvFXLRAcrRm+DGs9J/yqU
	 hI40BsM9WanCZ+/6ZnIFdU1N7lM6FFViwEq6TjbXxt0aKyGvWbzjiCkV0gMxi3ulSX
	 QjFbImwzbMnBy1DKYdUiU+ZRQ0hK0X9vhB2TcaEiHVH77PY4nTAqfUsLCpJnKlh0hy
	 vPT+eNQ83gQWw==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Aswath Govindraju <a-govindraju@ti.com>, 
 Swapnil Jakhade <sjakhade@cadence.com>, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Bartosz Wawrzyniak <bwawrzyn@cisco.com>
Cc: xe-linux-external@cisco.com, Daniel Walker <danielwa@cisco.com>, 
 Bartosz Stania <sbartosz@cisco.com>
In-Reply-To: <20241003123405.1101157-1-bwawrzyn@cisco.com>
References: <20241003123405.1101157-1-bwawrzyn@cisco.com>
Subject: Re: [PATCH] phy: cadence: Sierra: Fix offset of DEQ open eye
 algorithm control register
Message-Id: <172831615566.134651.5873217062618720618.b4-ty@kernel.org>
Date: Mon, 07 Oct 2024 21:19:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 03 Oct 2024 12:34:02 +0000, Bartosz Wawrzyniak wrote:
> Fix the value of SIERRA_DEQ_OPENEYE_CTRL_PREG and add a definition for
> SIERRA_DEQ_TAU_EPIOFFSET_MODE_PREG. This fixes the SGMII single link
> register configuration.
> 
> Fixes: 7a5ad9b4b98c ("phy: cadence: Sierra: Update single link PCIe register configuration")
> 
> 
> [...]

Applied, thanks!

[1/1] phy: cadence: Sierra: Fix offset of DEQ open eye algorithm control register
      commit: 2d0f973b5f1c369671d0c59e103d15f4f6f775c9

Best regards,
-- 
~Vinod



