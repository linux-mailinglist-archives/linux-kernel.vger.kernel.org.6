Return-Path: <linux-kernel+bounces-402972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4889E9C2F20
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 19:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0211F22634
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 18:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3B81AA1D3;
	Sat,  9 Nov 2024 18:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="AfL4v7pR"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59981A3020;
	Sat,  9 Nov 2024 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731176860; cv=none; b=On0gvYbKbR4qeGRchbmh9MPhrRTYjAlj0mJzgBWxiz3vVxyCSGDVqK2dmikYOO3RXvkVK/BdQIeYTu3nEzY1jyrvEvq1lXMSTOvRM1bZVqnnD0TBiPzw2UO0PHxHN1UnVKzAB2DRkAMgDTnb8vQEEK5wPmGFM4Ug2n+AmiqVyZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731176860; c=relaxed/simple;
	bh=A9htlU0NbKnX/HY9W4yW3cjX7a5EY21X2xhqYR1H/6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K+l+kfxgdm/i9YVyClpsiOJBqLJNvb9veqoppVADDWxw1Uvjenk8+tiQsuJD5xH6iLRJVAPsMBETTvVOc/+QL7tFAd80Z6egoHgNNif1TcwGAKniVsYsr2g2Sk030g/puHz6QFVd2M52z4JEyJYhexdJ24ufpCsWnvSY+t6j2u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=AfL4v7pR; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FgIG6VFXhAny1bqWlSHICx+VLNUGSni3L7C8KK4UjRI=; b=AfL4v7pR1ibSLkCxVQqYpbITpf
	S6i/UZysRmfKiWFA6fW4aCKMCDlR/xgKDUT/B2Bk28lLlb2yPb2gT3OHIhAKYNL38MSGrmJInbah4
	+hH9J88yuO/6B1aJCIR5NcQEU45T6BIMilL1WgrRKUXA4RrwvMIaWd8/J8DaP7e7MyB7XBXYcfABd
	oine8eRjcX1EXKKHNbcTuNoktnUqvlIeW07PAo5NixZcnmG9XTaj96iX84B3TGQafkOnJmaIPyqSU
	5rDZ9jzqKhTzc9YF/VA9z3adRikhCke0kdzhCdLc/yJEZ8eHjEiSythbE70UOuHtwKP4d1+Z38xWQ
	EuWldHwQ==;
Received: from i53875b28.versanet.de ([83.135.91.40] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t9qBI-0007Km-VB; Sat, 09 Nov 2024 19:27:33 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Enable HDMI0 on FriendlyElec CM3588 NAS
Date: Sat,  9 Nov 2024 19:27:15 +0100
Message-ID: <173117675954.1131306.10474212584108457519.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108171423.835496-1-jonas@kwiboo.se>
References: <20241108171423.835496-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 8 Nov 2024 17:14:19 +0000, Jonas Karlman wrote:
> Add the necessary DT changes to enable HDMI0 on FriendlyElec CM3588 NAS.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Enable HDMI0 on FriendlyElec CM3588 NAS
      commit: 6f846fe4d07a1b16e769754c5101c2e5a039d729

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

