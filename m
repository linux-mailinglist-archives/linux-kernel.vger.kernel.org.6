Return-Path: <linux-kernel+bounces-343821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 851CC989FEF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 243FC1F222E4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C9418EFEB;
	Mon, 30 Sep 2024 10:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="uDiOCCuk"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC7F18E35E;
	Mon, 30 Sep 2024 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727693764; cv=none; b=anKQVYzXI6eZSA0nohIOk1GHR/rkAxvB8EWyI7mrEg7v21YGaTWfmfzj5TBX4WnaGhz4TH+ryp3hYlhZ5FxcgWPQKDHnzpelqx8d/T5+jDKtykbGYq7RAa8l35pQBNwG8C/6bglh/NjFfAfDSqWyvVjfvDKfn6Zz1jKE7C6ACMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727693764; c=relaxed/simple;
	bh=k69xGgr1nqOF791BUk+jQBK4yn/fJWHYr3/8ZvLSXDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c4ix1hvfp4PUjQ6HixuZZ8cQmBAnNGmHd39/q4XfE0lwnE8VlWQq3dFd1dJCqvcj14IzCeA6yNTKS0S3TERmpKLV2k0QQpby4RnEijtNmLAELwW7DfIcxM0UsEU/RjVCtkBlLTlDS+875Cu+BpI+5wiUfdex+rd9abheyJElMS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=uDiOCCuk; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ybdvb92Phm6D+uBlGvpnoJ2oPo1jS/ZzdaGM8Mw1jt0=; b=uDiOCCukxfAZjMuvePWJKPr/1T
	tDMiBYmw/4DoG6TFS6zNFOwq4hdICeA+1O9urdaNlz9HrGsS8lbbmY3ONcLC3Lv11r1lEtWtcNSGa
	GVFxApeUCvgwX3MNHvcDvHeZwk5bELn7Wezo1cb7vfXhT4O//jec7Z8E0d7uKLFdP5uu1By+brKwv
	HABEVY90/0Ui5MCPp3XwrHkZGhusQU0AUoogcLQbn+hmJsYLcFHJqDdmlsFMuCFmIg1KvMoCqHhXw
	FWsEMtzd6j7Ewk5H93P9QTddlZWjE+kGyGklF3DNUCOh+3Um9qjSOZ0xZ5dfYtuMXaPiNC1XExq06
	0eumh0Qg==;
Received: from i5e861925.versanet.de ([94.134.25.37] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1svE4C-0004Xd-Iv; Mon, 30 Sep 2024 12:55:48 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Sam Edwards <cfsworks@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	Alex Zhao <zzc@rock-chips.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Daniel=20Kukie=C5=82a?= <daniel@kukiela.pl>,
	Ondrej Jirman <megi@xff.cz>,
	Dragan Simic <dsimic@manjaro.org>,
	Sam Edwards <CFSworks@gmail.com>,
	linux-rockchip@lists.infradead.org,
	FUKAUMI Naoki <naoki@radxa.com>,
	Jing Luo <jing@jing.rocks>,
	devicetree@vger.kernel.org,
	Chris Morgan <macromorgan@hotmail.com>,
	Joshua Riek <jjriek@verizon.net>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: rockchip: Designate Turing RK1's system power controller
Date: Mon, 30 Sep 2024 12:55:33 +0200
Message-ID: <172769365136.1880381.1018618867387854027.b4-ty@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240912180148.205957-1-CFSworks@gmail.com>
References: <20240912180148.205957-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 12 Sep 2024 11:01:48 -0700, Sam Edwards wrote:
> Currently, the Turing RK1 board reboots when told to power off.
> 
> Resolve this by designating the RK806 as the system power controller, so
> that the relevant driver can handle system shutdown requests.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Designate Turing RK1's system power controller
      commit: ab3cf1ab3fdbf1d05f23c810d767a3ddde4ef177

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

