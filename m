Return-Path: <linux-kernel+bounces-387239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C70C9B4E63
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20CFA28438B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F301957E4;
	Tue, 29 Oct 2024 15:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WqGnqM0O"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1FF802;
	Tue, 29 Oct 2024 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730216805; cv=none; b=PEndVvSQ4lGVixkhlntP+fvKYLm9ckxH9aXp+7eTqUDKjNQeopYz3vGEd9E+hS4fQ6Ps/hMleWXiJU+DUidObbD7FVoTuPiGqbcVXnh1tTGUFZE4S2Jb62FSYq3jntrG6nKP+keNTJrwZC8Z+UFT453Hhw1ecB9LKVzc+s/uIt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730216805; c=relaxed/simple;
	bh=VUyb5HrZmry7oqJG1jQP6lBC2jd4xEiVawX0wpMtr40=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nq7A3PO/N3PNg8+Nlv3Idf7TX0dsC8A0N51wqJ2EaVZyKS3eRum/bnh5fkmO8jWWygytQbK1yswOOt6WJL6lkW5fQSDu5Qfn9cJVqIV/y+vsqKB+LT0Djo1ziY+vx3NSdNmvod1gsXTpOweYqU0DF0qCj1LCUqCUi8wyYoNSLYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WqGnqM0O; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49TFkRGD106334;
	Tue, 29 Oct 2024 10:46:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730216788;
	bh=vQz8aWNJEQb0hYRI305JSO2GyZ3HgKzHbB2pMhfUiOc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=WqGnqM0OW+qOg617u2qutQsl7mdLk5Ih1C2CBbP9OZhXgJqvjQxcmDB5fKHOAssBF
	 yIez7rAbp4sKl3UgKtFm9eXWos9fxVRO2p7YJHa4GIsRA/JYjDtouJ3/VZEUs/8fsm
	 Et34RLJSDsPtlYIatSoBWV/gnrfv3q1WVWvkCB8w=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49TFkRDO009833
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 29 Oct 2024 10:46:27 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 29
 Oct 2024 10:46:27 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 29 Oct 2024 10:46:27 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49TFkOZm082409;
	Tue, 29 Oct 2024 10:46:25 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: minor whitespace cleanup
Date: Tue, 29 Oct 2024 21:16:22 +0530
Message-ID: <173021674668.3859929.14808047445194901227.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20240905154440.424488-1-krzysztof.kozlowski@linaro.org>
References: <20240905154440.424488-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Krzysztof Kozlowski,

On Thu, 05 Sep 2024 17:44:40 +0200, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space before '{'
> character.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: minor whitespace cleanup
      commit: cf0e756c8d0425f9c4bc739a0506ae4645ff5ba0

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
--
Vignesh


