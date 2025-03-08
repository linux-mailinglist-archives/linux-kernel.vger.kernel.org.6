Return-Path: <linux-kernel+bounces-552655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8946A57C5D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 18:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0623F16BBBD
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 17:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7A81EA7E2;
	Sat,  8 Mar 2025 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="PEDm5aGO"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A111CAA94;
	Sat,  8 Mar 2025 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741455139; cv=none; b=pZf0ZWdd4ecDHvRJPJ0uMnpH16c4WvCykRpjrLIrfrIY7ir6ZJ8O9o+NIUbj89vSCL/9onWhnx23eoR/w2r/AxJa3c+2KfXIXSLT6R5QM3dyi/G68MWqxtag6RlMQrP+bcTx69+ZCjFg5kqBKg1vs+ZJUqD45mdwNRM0EMqIZtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741455139; c=relaxed/simple;
	bh=hXlXA29PuUfVxYDozMXtBhonmjRTiHEvTx9eHFlCPSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mz+G/jnh2vm9gupXLU3VpZz4iIfX2UN316TQI+bTYkbNVjPQRxxH/eMokAbNYwKymMAoR5LjuarLd3prENbeE/Zm2DEfCMYHhGq7Fwn2hHJvFNttIehAvkQTlplp+PxiPyGqic/dB6GVJjB7XIm4SWvKz9U6XuAnz+pFE4A5x6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=PEDm5aGO; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8LXHDhAYB6TjZVmdXZg1UdOS+iXYglhf0itTrkh9AbY=; b=PEDm5aGOAKUXC+zhir1i3ceUY1
	ZymRUIjQyqM5l9Gt75lFhbHM6hNin+IHzWxWECrC4dNo/N0XY3xBounKRE9wQwulzizN1zqNLAs4O
	hrPTczHj5J8YVc0NAxEIoPBFRIt2sr6L/fVqVKw/FCBCm+/bIfR0ly6BrOS+fuQ8DAAHgTIgOt67F
	Vkaz6MWt6jxzEW8VliGi0iwRuiDiEuNb2OE6RPh8NDJxJLvG2Pc440eY0SjWZnGCqkZuJIBIJB9h9
	UgYGv+uz+yUzPFTc231+AYJ7tM79QUGMZGRyS+1xIMrBHYBbyDFZYVmYjqG2+DISUsC1/MQhJGSob
	Ye2F1+2w==;
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tqy1y-0004Tx-Cb; Sat, 08 Mar 2025 18:32:10 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/2] arm64: dts: rockchip: Add rk3528 QoS register node
Date: Sat,  8 Mar 2025 18:32:00 +0100
Message-ID: <174145503569.101861.837767867349168886.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250306123809.273655-1-amadeus@jmu.edu.cn>
References: <20250306123809.273655-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 06 Mar 2025 20:38:07 +0800, Chukun Pan wrote:
> Changes in v2:
>   Improve commit message
>   Add missing QoS compatible in DT
> 
> Chukun Pan (2):
>   dt-bindings: mfd: syscon: Add rk3528 QoS register compatible
>   arm64: dts: rockchip: Add rk3528 QoS register node
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: mfd: syscon: Add rk3528 QoS register compatible
      commit: 19a634195c1abe498798b564cd6b81e6dd4533f7
[2/2] arm64: dts: rockchip: Add rk3528 QoS register node
      commit: 61a05d8ca3030a544175671f5fab7a8f29c24085

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

