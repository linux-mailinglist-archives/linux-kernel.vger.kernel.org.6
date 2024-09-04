Return-Path: <linux-kernel+bounces-315801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D0E96C728
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFC791F240CA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B30C1E4131;
	Wed,  4 Sep 2024 19:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="jhLp3WHs"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332281E412D;
	Wed,  4 Sep 2024 19:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725476850; cv=none; b=hapQLYPlo39cd0GU/0++NfCA9uUXcR9MouQ5qjzgus2jOAsT1vLo6vFWuke5j3vs5BznZeg19GMV4P1zkjQwN5DjYyzJhVkcWAc7PLlrPGrx1e6wKu4ZQR/+dwq/7CABElFxyeUzMouFXZ2H15Z94nZvXMIsK/I3P4OfApZWhA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725476850; c=relaxed/simple;
	bh=I7+cgrE+rn4bBBFXLPig4HthUyuVfUv7TFU7VBXdYK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rgLCkbR9cg4NTNIwVYDQnJRbvedjQwBIBgfw9D9ZJM1c7AmdQvTl3YzNBlJT27tyDX+dHxekU5dCNzHoYdez+NFSWvR3mbRepZ5c9d9fHcHQ0bTGNPVo17lqrnuO137u0ekWHs+XdIXxxVi51xQW1X1MOoulkvOdulX+t3OglI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=jhLp3WHs; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YLYNjnT/IKCKvjMfxNgrcLACsIljWuuAqppXEoSA080=; b=jhLp3WHsxJv+bA8hQ7QijhyMsi
	JSqQkzGb2x4zr/eujOXTcxTSPNHs5COFt/Kp5mspKLCM/837+Mp2SSMmnvJ7ytuEUnqD7HRDizIqs
	vAZRUwQCAo9hfF4GsKweU3oY4dKXMoEQb1GYSYU06csphLoke4TZQH0a5InJN8P5p6ivebJkRyO+4
	t0Q4doz1cNpTcKVXbB2DN0OTF1ayG2o6+QYTZ6/hR+GfIHX2Jatqid+S0g9XyGD9vHcsAiWudw6yH
	aZ29bPJ28URCVKVtJ5njXRMihG7ANKMzJ0iGQaamUzKv9DSUhRV/tDngV96ELtUsRia4t8X5q7ezO
	lUOgSvmA==;
Received: from i5e860d0f.versanet.de ([94.134.13.15] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1slvLY-0002Po-D9; Wed, 04 Sep 2024 21:07:16 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Jianfeng Liu <liujianfeng1994@gmail.com>,
	linux-rockchip@lists.infradead.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Diederik de Haas <didi.debian@cknow.org>,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 0/1] media: rockchip: rga: Add rk3588 support
Date: Wed,  4 Sep 2024 21:07:01 +0200
Message-ID: <172547678275.2721598.8597776431776777488.b4-ty@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240831182424.758816-1-liujianfeng1994@gmail.com>
References: <20240831182424.758816-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 1 Sep 2024 02:24:23 +0800, Jianfeng Liu wrote:
> This enables support for rga2 in the RK3588 base devicetree.
> Dt-binding of rockchip,rk3588-rga is already merged to v6.11.
> 
> Changes in v3:
> - Rebase commit to next-20240830
> 
> Changes in v2:
> - Sort node by bus-address based on next-20240604
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Add RGA2 support to rk3588
      commit: 13066fc101ca2deec1c9619e2f82ca437f38a6da

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

