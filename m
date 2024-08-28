Return-Path: <linux-kernel+bounces-305251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D849962BDB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92866287B2A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B0F1A7ADF;
	Wed, 28 Aug 2024 15:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="AY8RAbwZ"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22CF1A76A0;
	Wed, 28 Aug 2024 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858067; cv=none; b=ILv/aoge8n3O1zHlVtDqaqLXXTcR6vsdCghV5F2fvJpnXNlVATX/q5G4y9rRwH4Erg2dkmbbFUSLrmcjXaiuuI6WtYXYeu6UY8d931c3oGFOJNhr0HMUx+lM5ityKByNmbXaX7xx3iqj8k7vZvOWPz9tGpgW35TxOY9gHsVnaUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858067; c=relaxed/simple;
	bh=8EthxOsfGxdQCEmlXPeX4p2+5W4+kVruhL4DcCQIvgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rqgptb6o3DfhxCqKGTxQSiL8BbY4jWd5B6p/nRWjYiu9Z/Z21r38NW7TDjrHKpf04OWbgK2YAnWcAd0snxjlysx7adRtZXHlf3Yn7AItRb4orViyYFNj/pVDXvmauO7SWReThv+sPDSbm0kWA2uV9H+OebYs4N4EFvzYZvqHMbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=AY8RAbwZ; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CaMto9+ekOB1e7eQ23ls3XbcJMytz0kzG4RJf+yXRwg=; b=AY8RAbwZ1O5HI6LmpZdFNSlLyv
	p/dGW/au1byDBnKwHyXt65zOz/e5TolgDqp4uD6jTc6Or8WIYpgyVCczAL0hnSxBHXjZeOhl8m4pM
	JB8y2rRHD9mpkZW8nUOFZp5yTPelxoAVycXamqLUq2bjYvN7iQXweEUh3Fzl9VZ5YK84jfNe0ENb/
	j1Ob9lbz6kqBMK41odJkq9aC/2iJtTPwmfndGpjixdRST9aMPfCkZY+fBY1O+lilk5zNppq6HVY31
	0Mk0WidVJZsw0JOFjj2llR1JUS/4/Jewe4i+mS5IiA9dEdKTT6aN93UDo6GGcDWdlY1RySvbKiz2k
	Ql1nF7jw==;
Received: from i5e8616cd.versanet.de ([94.134.22.205] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sjKNF-00065f-SK; Wed, 28 Aug 2024 17:14:17 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Junhao Xie <bigfoot@classfun.cn>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-rockchip@lists.infradead.org
Subject: Re: (subset) [PATCH 0/3] Add support for LCKFB Taishan Pi RK3566
Date: Wed, 28 Aug 2024 17:14:10 +0200
Message-ID: <172485421376.1511809.9579701048070229226.b4-ty@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240826044530.726458-1-bigfoot@classfun.cn>
References: <20240826044530.726458-1-bigfoot@classfun.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 26 Aug 2024 12:44:10 +0800, Junhao Xie wrote:
> LCKFB Taishan Pi is a SBC based on the RK3566 SoC.
> 
> This series bring support for:
> * UART
> * RGB LED
> * AP6212 WiFi
> * AP6212 Bluetooth
> * SD Card
> * eMMC
> * HDMI
> * Mali GPU
> * USB Type-C
> * USB Type-A
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: vendor-prefixes: Add Shenzhen JLC Technology Group LCKFB
      commit: d6ec4fefbe9eac0363e9d05c05010686d6790428
[2/3] dt-bindings: arm: rockchip: Add LCKFB Taishan Pi RK3566
      commit: 4d4b28ba3a0f84f641febc9de4252ba0bad2238d

Patch 3/3 was sent as a v2 separately in
https://lore.kernel.org/linux-rockchip/20240826110300.735350-1-bigfoot@classfun.cn/T/#u

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

