Return-Path: <linux-kernel+bounces-347336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0965B98D14A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AAE0B22E15
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491301E7651;
	Wed,  2 Oct 2024 10:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="axkgWC/R"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5407F1E6DED;
	Wed,  2 Oct 2024 10:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727865087; cv=none; b=oE4xRmoDx4oGTAIa7rzerAHcjSZSGFJedR4KgE7Bak5mvj4lM2SSE5s5JC2jnx4a7y5XyYVNydTQNTlK2oNTIYBXDLnSUWrWGatjxVU7u/oSghql0DS6LqCLs1UVMJ3RnHSP5faio+kV0/hLWz5QovEMlclxNg26aft+r3cLGSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727865087; c=relaxed/simple;
	bh=Ism0FzYW/hdk3ctkQrIAdiUvCHYC8uyF4djaHrm29IM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RQUrEjwtbbnbeO67s3m+PDExgDUUo2nmRlMQGxdUqveCYTib2I2rRusyhSP8ORZ8gpUqTSi9cLeHJVWWNi42702DfkBa44Nb+KAZgKcfpwYkhea48LLNALwTpAq0vD7UANB0/WG81IEevcDk0XClFAKoUx6KH6n3b1XFODxaNyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=axkgWC/R; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FxaMWJe41HT7TXEryU9BV/26depmbnG+obtSP5eZ8ws=; b=axkgWC/R+tI6DgYDLNpK30IK3+
	QuJ5VDK41tVZp1Affmmq2Xt11aRvbCB70lei7ssuubrf8b+6xwGyMLW1FAliZ8qySDG4niknFIVF9
	3xSQz/zCala/foLETINHBKfsg+bssHwXtyft+Q8Y6iVBEZQpLUG1i1cgD1He59XFdUBxAxrMTFrdF
	6fFGnXt8mmjiz9vNodOhMKSsWmZYAf1047o/SEUx9FjnJBPk2tiWx/Dw9BieeI/CdC08Q9EZXlUZl
	muldrCrgn3y39y5ePAF8A4MWrfFEYCwRo7k+UiCubyYRiq+HieSUI+/NjjdfQcZG7ZWmDNbUgQbxH
	EXD9EZcQ==;
Received: from i53875aa1.versanet.de ([83.135.90.161] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1svwdB-00057r-5z; Wed, 02 Oct 2024 12:30:53 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Sam Edwards <cfsworks@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	linux-arm-kernel@lists.infradead.org,
	Ondrej Jirman <megi@xff.cz>,
	Alex Zhao <zzc@rock-chips.com>,
	Sam Edwards <CFSworks@gmail.com>,
	devicetree@vger.kernel.org,
	=?UTF-8?q?Daniel=20Kukie=C5=82a?= <daniel@kukiela.pl>,
	FUKAUMI Naoki <naoki@radxa.com>,
	linux-rockchip@lists.infradead.org,
	Jing Luo <jing@jing.rocks>,
	Rob Herring <robh@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joshua Riek <jjriek@verizon.net>,
	Chris Morgan <macromorgan@hotmail.com>,
	linux-kernel@vger.kernel.org,
	Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Enable all 3 USBs on Turing RK1
Date: Wed,  2 Oct 2024 12:30:45 +0200
Message-ID: <172786503307.2125927.13838260873338813986.b4-ty@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240930210652.1232951-1-CFSworks@gmail.com>
References: <20240930210652.1232951-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 30 Sep 2024 14:06:52 -0700, Sam Edwards wrote:
> The Turing RK1 contains 3 different USBs:
> - USB0: USB 2.0, OTG
> - USB1: USB 3.0, host
> - USB2: USB 2.0, host
> 
> This patch activates the necessary DT nodes to enable all 3 buses.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Enable all 3 USBs on Turing RK1
      commit: 6d14287746d1b5783ee69b3841838e1af5e44dd1

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

