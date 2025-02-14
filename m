Return-Path: <linux-kernel+bounces-515764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B229AA368A7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 23:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77B851888803
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDD51FCF60;
	Fri, 14 Feb 2025 22:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="z0yihNX5"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB0519CD1D;
	Fri, 14 Feb 2025 22:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739573133; cv=none; b=WVBfXX9dhuG3/ghzPOXGLFKS/L44rTNGiufgDS4544OnJOdNmsxdWeH6SeJcS1qkFQ8m3+kUDDw5LF80jTvgpC6BtuYGsCMdtY4U2E+QAOqDJjASlapXB3AnHVkWC7w+DjQ++2p88r8tszNWIOuOSp6AMk/taW3GMF4Rc9CHD60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739573133; c=relaxed/simple;
	bh=W/22sjmQtfW+T3HAcTny5XzHcRdyfDXjRP+3YymyzAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DeXTmU5JcAKyhx3qO24U3iN1bZA8heDK+qMb1FpZN3IubJppq1T+pRMSvK4E9FLQM9oPUStyj3/fLPwtAltVMpvxnSJXHy5BcEHkxoK6GszrF/xSpFVgeEyKNihJa6bxH08CXdgrXlffd7p7G0NdwDfNQjnQK0C7o7A1SNG5868=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=z0yihNX5; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EiUZWzQCMS5pWAnVUksUZCQH8mtcpOOBDIuqxWtAVy4=; b=z0yihNX5H/PiP34II2rBN1l5Fb
	imItSSpqqg7SQsP0Rn0wEYMsniGGRARDXao/1Vxg6O3u837AbJxKFSJqNn2SAkzEOJURBzimts6VL
	0nvynPs+LZBM9+XzDxIOXN+JvkckXgY1PeIscObhwFGWGXWxXdBU7Ph/wCZrI/pN3xb5qP1ytK1nB
	Ko3Vqc/uFEtsCq0oH5NxZvw33MQxwOPZM5NUnmlrsRlyfDZQk/25XjGtmHAKO51g/zfthV0MGBMi/
	fBW71GPQ3Y8vydgUm3ruGFcS23LIjKhtI6N2qAWDC5ARkdCrdbVgwt9G4i3zOv9DBtAgWEoWbW85w
	fIRR1XnQ==;
Received: from i53875bc0.versanet.de ([83.135.91.192] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tj4R6-0003TH-4h; Fri, 14 Feb 2025 23:45:28 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Heiko Stuebner <heiko@sntech.de>
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jonas@kwiboo.se
Subject: Re: [PATCH v2 0/2] Rockchip - add Firefly ROC-RK3576-PC board
Date: Fri, 14 Feb 2025 23:45:16 +0100
Message-ID: <173957310724.1747676.2795519057451074241.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250210205126.1173631-1-heiko@sntech.de>
References: <20250210205126.1173631-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 10 Feb 2025 21:51:24 +0100, Heiko Stuebner wrote:
> This adds a second board based around the rk3576 SoC.
> 
> changes in v2:
> - add Rob's Ack on the binding
> - move ethernet-phy-reset control into the phy-node (Jonas)
> - some sorting cleanups
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: rockchip: Add Firefly ROC-RK3576-PC binding
      commit: 2be4a4171401761cb5fb02225d8b18351f6807c0
[2/2] arm64: dts: rockchip: Add devicetree for the ROC-RK3576-PC
      commit: 887ff17cdd8f088a52e2b61e71f2b6c9b9678de6

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

