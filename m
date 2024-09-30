Return-Path: <linux-kernel+bounces-343815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8C1989FE2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A37FB24D33
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CB818D64B;
	Mon, 30 Sep 2024 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="0RTURJFC"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E39B65C;
	Mon, 30 Sep 2024 10:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727693756; cv=none; b=QvjcYtyNBX1algaNkv9wlPl4Vi4d9/3sWnZeaEURSMnI6qltiqYg1+EFbI2kNp2om7uAkTJHkWcKuaPMEL2qyQGdVm8H6ogndtA0Q6xXrDs6cCoxz7JnQzRMK/a/WtQk+UXLISW8HPwwcBp7MoWGvkVuh9EVRU8yBk4lWCkuP7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727693756; c=relaxed/simple;
	bh=plfk4tiNLPORCgudw5IDCoZR5TJeKxYUo7XlwVBEY5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lcPkxnPVKVYvMVCBaMghiGB3tTKosGosR1Ee7+bhhgcoUn+CYZ/6Fn5DbQeiXfDn7b8AQU1ujYVIGh6TaVPWQ0pJyx+Kr4+7y5eQM1SF7wYvM5gHdkhReapVW7BCarIdCzxJKUaM1iv03asvw75LG3AMLXScP5f1xPdB8ESYnRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=0RTURJFC; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fZdmT2Y0FjWQhc/Q7mHALrHHviCf4Pz3Rvc6tuz0lCM=; b=0RTURJFCOln+oQC65hFfTKgsZx
	9xAnSvWF7QNxOzC0oijqiFwQi9gbnQW9ULoNY2Dfyt7Z9h8ddQ/iXw27RsGuOFTiwG9ZLd6FGQXy4
	eaxjsIN1pFgbfstbL37HkW8dAK7MHbxNccXQq1+gpmYLdqSWlsOxZ/mjONbC+68m3j+WiJD74JRpn
	9n6tUzIFDE7Hk5a6FNGDQD2ZN6XBx7XBqvrotcLJoXf25AAbeEQ9lv7j2QLP5OvWBT0QylT/nk9ZQ
	RE8VHpVAinI92upi9QYhpGd7n7MjsNy9aCYdl5BFq+XPGF1AzR1cBqvcQiTHyXanUKrxzzcvshbtP
	JzhY51ZQ==;
Received: from i5e861925.versanet.de ([94.134.25.37] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1svE4E-0004Xd-BF; Mon, 30 Sep 2024 12:55:50 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
	Dragan Simic <dsimic@manjaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	robh@kernel.org,
	alchark@gmail.com,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Start cooling maps numbering from zero on ROCK 5B
Date: Mon, 30 Sep 2024 12:55:36 +0200
Message-ID: <172769365132.1880381.2922815232409278625.b4-ty@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <335ecd5841ab55f333e17bb391d0e1264fac257b.1726954592.git.dsimic@manjaro.org>
References: <335ecd5841ab55f333e17bb391d0e1264fac257b.1726954592.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 21 Sep 2024 23:39:05 +0200, Dragan Simic wrote:
> The package cooling maps for the Radxa ROCK 5B were mistakenly named map1
> and map2.  Their numbering should start from zero instead, because there are
> no package cooling maps defined in the parent RK3588 SoC dtsi file, so let's
> rename these cooling maps to map0 and map1.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Start cooling maps numbering from zero on ROCK 5B
      commit: 6be82067254cba14f7b9ca00613bdb7caac9501f

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

