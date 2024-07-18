Return-Path: <linux-kernel+bounces-256254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B659934B7A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 12:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DC711C21DF4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DF085285;
	Thu, 18 Jul 2024 10:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="WlMNGhyW"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20023A267
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 10:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721297282; cv=none; b=cAC/qamBUbaab1lCcvVfJEBM5tT4BTLwCqWMku9/1WX4uVVN5L7hel5UcdDfAku2FBrZlFn+V/JoYH57CCB9qF0VTBA3JnNNuGNL4GCQdcYQxV5g8T0kpmCTs9t7P//Tn4hd7PiaQNs6ffoneaOiNjNm5FToiyQazBuEllqEGe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721297282; c=relaxed/simple;
	bh=tZP1fkWEB1ULarjCH9v62tNcZ5x7nHm75Ee94zSsPf4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PDB6PSW0aFZyMLU8bvuxUbjzTu2VLAaniwfwvnfkB0ODvvTxxdo0aAmk4fyjx5D27GBptBBo3Xz1iMtOiRnum0N0fbqhEJzBM57XrXokIo/UpdePN5bB2ev/kBDwhCNEwWUa8f9O5YZw4IiJGu4pOA037a95Ht35vu9MabC+Gns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=WlMNGhyW; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1721296368; x=1723888368;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tZP1fkWEB1ULarjCH9v62tNcZ5x7nHm75Ee94zSsPf4=;
	b=WlMNGhyWNv2J+Dezx9UoiRaBPc4hSCBqHsIjyJ3jcmlf+w9m7m5uIU+huTa92Rhi
	FNED6k+CX5n/jGDBua6zzzJttI+HnrnjeO4EDxxdKxi0m9BclMrgK9FdJ8x2oVU5
	xzx3ptFFNZ1dQl7mr2X0a6jk0bRyxtUHFKnP42rQDVM=;
X-AuditID: ac14000a-03251700000021bc-f8-6698e5f0fd96
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 87.32.08636.0F5E8966; Thu, 18 Jul 2024 11:52:48 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 18 Jul
 2024 11:52:48 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <quic_bjorande@quicinc.com>,
	<krzysztof.kozlowski@linaro.org>, <geert+renesas@glider.be>,
	<dmitry.baryshkov@linaro.org>, <shawnguo@kernel.org>,
	<neil.armstrong@linaro.org>, <arnd@arndb.de>, <m.szyprowski@samsung.com>,
	<nfraprado@collabora.com>, <u-kumar1@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<upstream@lists.phytec.de>
Subject: [PATCH] arm64: defconfig: Enable PCF857X GPIO expander
Date: Thu, 18 Jul 2024 11:52:39 +0200
Message-ID: <20240718095239.922641-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWyRpKBR/fD0xlpBpv3aFj8nXSM3eL9sh5G
	i4nnf7JZzJ09idFi7+ut7BabHl9jtbi8aw6bxdojd4FKdt5itPi6+QWzRePjGYwWL7aIW0zb
	O4PZovudukXLHVMHfo8189Ywevz+NYnRY8fdJYweE8/qemxa1cnmcefaHjaPzUvqPfq7W1g9
	Ju6p8+jbsorR4/iN7UwenzfJBfBEcdmkpOZklqUW6dslcGVcn7WAveA/S8X6p3eYGhhXsHQx
	cnJICJhIzJg4AcwWEljCJLFssXUXIxeQ/ZhRYv/1U2wgCTYBdYk7G76xgiREBA4wSUybeYEZ
	JMEskCEx689rsG5hAXuJtivrmEBsFgFViXsTT4A18wpYSDQfvMcIsU1eYual7+wQcUGJkzOf
	sEDMkZdo3jobaqaExMEXL5ghLpKXeHFpOQtM77Rzr5kh7FCJI5tWM01gFJiFZNQsJKNmIRm1
	gJF5FaNQbmZydmpRZrZeQUZlSWqyXkrqJkZQrIkwcO1g7JvjcYiRiYPxEKMEB7OSCO8Exmlp
	QrwpiZVVqUX58UWlOanFhxilOViUxHlXdwSnCgmkJ5akZqemFqQWwWSZODilGhhzIqVX7VRk
	VHvkectrDc/Hfbeq1zYW2rzTfvIwnsVde7LA5IIvDI/2PVvz4nnKReecA5PnLbpcwB37xKT1
	mfm9efU7d8eIpc/+Grnlw72VtxjWKkqEKIuys/9+F7zftKOnW1rh3KTHNsWL/0vY6h2dv+/c
	vG9Hgj4zzdFi1Lr3Lkv1g3XBr811SizFGYmGWsxFxYkA0gOb+KMCAAA=

Enable the PCF857X GPIO expander which is equipped on
the PHYTEC phyBOARD-Lyra AM625.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ef2235838c44..0c7d3f7717ff 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -655,6 +655,7 @@ CONFIG_GPIO_XGENE_SB=y
 CONFIG_GPIO_MAX732X=y
 CONFIG_GPIO_PCA953X=y
 CONFIG_GPIO_PCA953X_IRQ=y
+CONFIG_GPIO_PCF857X=m
 CONFIG_GPIO_BD9571MWV=m
 CONFIG_GPIO_MAX77620=y
 CONFIG_GPIO_SL28CPLD=m
-- 
2.34.1


