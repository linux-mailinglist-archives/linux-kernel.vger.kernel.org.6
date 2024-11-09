Return-Path: <linux-kernel+bounces-402970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D94A9C2F1F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 19:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE7F2B2178D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 18:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2F21A9B5D;
	Sat,  9 Nov 2024 18:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="1i/N6t2h"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFA31A257C;
	Sat,  9 Nov 2024 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731176860; cv=none; b=e+ITBA0V9jD4fe5g9bNvOKBlCw7860WwqKxjmt+/AYr/ZxNYFsjnU0wLvV+1K7ZR/8HneJbJi3eFhGoldyFhMDivjM87CrC3kUquWsKk7fu6LYvxeKIQHFdDifOhDbr93MEmnWBWKTzdg+vXd/nV3PZlBbJfohVJw+X9AVPSJHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731176860; c=relaxed/simple;
	bh=ZMwyKOFUwZKVV41D4JHsnCytnrAkFeNfsseptah3wuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KkCZsB6PGJF5CVJEyGd88gz9/El/jtqso2faABi8Y2IY4FlHoEuJQMsjSfcFjsoX+FzZ3ujOajS3vNZ9LwREbQKZkHCwPoD0Sjx5QhF5gChLFOZExaJlOms7XI8UcN5LAeJ2GdGqZnu/AviArqyl7+Woxq0JuWiGxFSFnPo8PpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=1i/N6t2h; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=X/XdLrRd9Xd5DGjwhoQSHywlLvR9zYSL5LpMBZ+yZro=; b=1i/N6t2h3fOqaP9hkFbNDoJWMf
	KJvkZpYgollEVkfKc1GmgqfPTJgDrSSkem3Uj60m9EYYprTRrNXq8x1ROqNYzkF6ouqDkAnuM7Xjv
	7rDs4g76fsEX+9LrtCDQ79dzDpy7B6r5bJtqBZV+dT+3bjFT0o13kOTK4AIspPG6fdNWqOXlDlKsg
	fHM1j4XTeYNxjK/LUNTDcxQPhO/ZXbK4Ef/rwptswZ/xAXGH7uODPj9E5lBXML1Wcy5La7NNSLRSU
	lHLXGckHnJUVmfE+A7/hVIM/s5kPX8KjoF6H08CduldyaqCiUYoeZZOgE4gDFxu0qp19grCz+3jtr
	1/IOKPTg==;
Received: from i53875b28.versanet.de ([83.135.91.40] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t9qBI-0007Km-H3; Sat, 09 Nov 2024 19:27:32 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Jonas Karlman <jonas@kwiboo.se>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: dts: rockchip: Enable GPU and HDMI on NanoPi R6C/R6S
Date: Sat,  9 Nov 2024 19:27:14 +0100
Message-ID: <173117675954.1131306.14516383583715120601.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241107212913.1322666-1-jonas@kwiboo.se>
References: <20241107212913.1322666-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 7 Nov 2024 21:29:08 +0000, Jonas Karlman wrote:
> This series add the necessary DT changes to enable GPU and HDMI on
> NanoPi R6C/R6S.
> 
> Runtime tested and working with video=1920x1080@60 cmdline on a
> NanoPi R6C.
> 
> Jonas Karlman (2):
>   arm64: dts: rockchip: Enable GPU on NanoPi R6C/R6S
>   arm64: dts: rockchip: Enable HDMI on NanoPi R6C/R6S
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: rockchip: Enable GPU on NanoPi R6C/R6S
      commit: 573a4faab675cf00851273f29feae02d224d2c21
[2/2] arm64: dts: rockchip: Enable HDMI on NanoPi R6C/R6S
      commit: 437fa141ab6509256fca21f0630c5fa57c34dbd1

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

