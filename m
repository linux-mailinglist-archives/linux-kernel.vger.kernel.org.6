Return-Path: <linux-kernel+bounces-348619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758AB98E9BF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B701CB23938
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 06:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6B953363;
	Thu,  3 Oct 2024 06:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="rX+AuNwg"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2072CA9
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 06:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727937421; cv=none; b=Mp/rtB8feF//93pQwjQUJvfC9X1mpaOCHUFjzAbDuHYG555AsrFs550SbpJ8AdpVnVj8SrHKNihCrj8uGuCsIGJNYmaw4UPfdbgz20hVI1yiVQXsaji2GNPiGoJMOFAmw3zLuK1b8Vg01eDub7JPMYPTvvXxEY2HSjGyEIjQOZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727937421; c=relaxed/simple;
	bh=JSgxxqYvFzDUt9CkhFjXnnd2JCfbHclnrEmKmKvqGKY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V16bXlEuW32fjgdU6beejpjQx52VF3SiTy9233OslNLPuD3J7IwGfd3pK8TnlbgKAtafNnalz0G+hCYIAe6HC6+qWZqC0RuulvHde6ujtYxxDvlfNlQWH9a+vvXxHzPhEIFuOzyMsPQFhBynLOp0xg+FMq0jtx0b4US7uBbxHqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=rX+AuNwg; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1727937410; x=1730529410;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JSgxxqYvFzDUt9CkhFjXnnd2JCfbHclnrEmKmKvqGKY=;
	b=rX+AuNwgdQYvLG9nU7W4Bk90vrmwPS9eEJ2/1QksCFzg/bpXRCnUwMv6oAUkOM0v
	GAAnjZgOZfMq+cyyl0wsB4upcfXY4DWD95y42fo+uFkuxbgKgcK8LHLgAAC3A893
	t9yqku1yeAmiNvQCF5TWEPpiwkp5RWBJPxUkb3B/R/w=;
X-AuditID: ac14000a-4637f70000004e2a-51-66fe3b816a76
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 1F.74.20010.18B3EF66; Thu,  3 Oct 2024 08:36:49 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 3 Oct 2024
 08:36:49 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <catalin.marinas@arm.com>, <will@kernel.org>
CC: <quic_bjorande@quicinc.com>, <geert+renesas@glider.be>,
	<dmitry.baryshkov@linaro.org>, <krzysztof.kozlowski@linaro.org>,
	<neil.armstrong@linaro.org>, <arnd@arndb.de>, <nfraprado@collabora.com>,
	<nm@ti.com>, <vigneshr@ti.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
Subject: [PATCH v2] arm64: defconfig: Enable PCF857X GPIO expander
Date: Thu, 3 Oct 2024 08:36:42 +0200
Message-ID: <20241003063642.2710384-1-w.egorov@phytec.de>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42JZI8nAo9tk/S/NYPZxdou/k46xW7xf1sNo
	MfH8TzaLubMnMVrsfb2V3WLT42usFpd3zWGzeL/zFqPF180vmC3e/DjLZNH4eAajRfc7dYv/
	Zz+wW7TcMXXg81gzbw2jx+9fkxg9dtxdwugx8ayux6ZVnWwed67tYfPYvKTeo7+7hdVj4p46
	j+M3tjN5fN4kF8AdxWWTkpqTWZZapG+XwJVx+GQjY8EB1ooZHY9YGhhvsHQxcnJICJhIzDx+
	na2LkYtDSGAJk8Tx1b0sEM4jRomWjlY2kCo2AXWJOxu+sXYxcnCICBhIbDqqBlLDLHCBSeLQ
	hp9gk4QFnCR29T0As1kEVCQeNnwBs3kFLCXWvngFtU1eYual7+wQcUGJkzOfgMWZgeLNW2cz
	Q9gSEgdfvACzhYDiLy4th+uddu41M4QdKnFk02qmCYwCs5CMmoVk1CwkoxYwMq9iFMrNTM5O
	LcrM1ivIqCxJTdZLSd3ECIosEQauHYx9czwOMTJxMB5ilOBgVhLhnbf9b5oQb0piZVVqUX58
	UWlOavEhRmkOFiVx3tUdwalCAumJJanZqakFqUUwWSYOTqkGxujXbS3tMhe0F4rP5m8WEA02
	vqfe1BNyZ//Rqa5znHJdZn1U5tnsOnvH2jV5Lvcsym4q/tXzWSS7379q6zo/BbN3lxTsVjJ5
	yhfk39f6YR0sILbvj/xqwents3kS/9gePPPnsND1FREbZ4gfOxm+qyGp8kXtv/j+OyeEH8j7
	tfJO3XyR8QPLOyWW4oxEQy3mouJEAKCmi1KaAgAA

Enable the PCF857X GPIO expander which is equipped on
the PHYTEC phyBOARD-Lyra AM625.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
v2: Rebased on current master
    Resend with correct Cc's
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5fdbfea7a5b2..4baad778a735 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -659,6 +659,7 @@ CONFIG_GPIO_MAX732X=y
 CONFIG_GPIO_PCA953X=y
 CONFIG_GPIO_PCA953X_IRQ=y
 CONFIG_GPIO_ADP5585=m
+CONFIG_GPIO_PCF857X=m
 CONFIG_GPIO_BD9571MWV=m
 CONFIG_GPIO_MAX77620=y
 CONFIG_GPIO_SL28CPLD=m
-- 
2.34.1


