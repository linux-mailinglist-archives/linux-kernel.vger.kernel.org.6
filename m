Return-Path: <linux-kernel+bounces-343823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E63989FF5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32571F23B65
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638CE18FC9F;
	Mon, 30 Sep 2024 10:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="SpquXQY0"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AF418F2FF;
	Mon, 30 Sep 2024 10:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727693771; cv=none; b=RHqvLAokc4Vdoh1NrWU3AuDfY2RrBm6hUDiUIphnC/2DOf/BNYW0KsWAVpPLmIhzTIekUICuOpFhGzzG3EptBAmuvk/SV+yWDHygjfv5TTKkOwaUzKT/8pTk3dI1XEcDwhiKno6mkdxaArMcHoTVxPTXuqOPcYphXA/gHzT6PD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727693771; c=relaxed/simple;
	bh=53HRX36aefiWlhPc5bAgq08xw8MiIAJICsef8nm4y/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lSxewvEQ7oOdxtPQV7hHTVJrjs6Hs6lQ8HCKfTh81SDPe40TWuwSJ11yaf9uyHmiCfTxaF5Fo0l8uSnbpgTsdkn7hkM574O6lOn9KjGWwp4SGZn2RXS5KShzaM7rOf517GqZuvhXR4JmJANwTJ9U9DYuDf4VvNKMtbvjtnipRws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=SpquXQY0; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=INDTdnrCf1u784zafFghMqBMITRgyNFRnhbK4dqaT1E=; b=SpquXQY015daZBfHeG9ZJ8QhNm
	CIg3BdKnhvJ8YGF3MbXK0c6M+t1tIDXLSrkj9SNMgb/ZIDsvSFZerOQ9ZTP9byCBxGkuuQQxaq9rz
	EVF0I1KHzf0p90R8IMexqRo4k8FkiF+RCIc4LxnBQDJMuAi7p4aA7ak7TTfWsOFSrQCKBb9DEamto
	FApq5RubKIjvRetgGLxFSgfLr5Ws0ljYNvndJ5ManuPVNLUBnDv5MfUNHoQ50wDb2eCMa+RVAI9EH
	FWC2BihFWFOCd6Ruuw6/ll4WggGswPO5dCN7lDI0eZ1c4AQ6l7senK3cJhRrWIWWlNxGV2uQAmLkP
	g7R6jqSQ==;
Received: from i5e861925.versanet.de ([94.134.25.37] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1svE4G-0004Xd-MM; Mon, 30 Sep 2024 12:55:52 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Sven Peter <sven@svenpeter.dev>,
	Jacobe Zang <jacobe.zang@wesion.com>,
	Hector Martin <marcan@marcan.st>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Muhammed Efe Cetin <efectn@protonmail.com>,
	linux-rockchip@lists.infradead.org,
	asahi@lists.linux.dev,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	nick@khadas.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v14] arm64: dts: rockchip: Add AP6275P wireless support to Khadas Edge 2
Date: Mon, 30 Sep 2024 12:55:40 +0200
Message-ID: <172769365137.1880381.6159894918709660365.b4-ty@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910-dts-v14-1-82b39bd91257@wesion.com>
References: <20240910-dts-v14-1-82b39bd91257@wesion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 10 Sep 2024 11:07:47 +0800, Jacobe Zang wrote:
> Khadas Edge2 uses the PCI-e Ampak AP6275P 2T2R Wi-Fi 6 module. The
> pcie@0 node can be used as Bridge1, so the wifi@0 node is used as a
> device under the Bridge1.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Add AP6275P wireless support to Khadas Edge 2
      commit: 44b149fe1cfb18d1b7391c4115a3385f255f9a91

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

