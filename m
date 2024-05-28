Return-Path: <linux-kernel+bounces-192088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3F18D1848
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EB0C284A95
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9313616C685;
	Tue, 28 May 2024 10:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="DhE1b/ye";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="lGWlM9AN"
Received: from e2i187.smtp2go.com (e2i187.smtp2go.com [103.2.140.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4524E16B75D
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 10:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.140.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891390; cv=none; b=cJDiO8xYxXRoUk8ucHALdQMoYaox3pIubtCWhqAN/0Qk03UtNHi/iKPiwMAkos8SQAKlMRj7xpRev9WUEUW1NX+hEIh+g8WEXiOJKBFr9chX5u874GJVlVlDtD7b9vyTLcUZXjuhT4+4Az9HRLxK5SYUTq6cH9med/s2VEpIDts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891390; c=relaxed/simple;
	bh=bK8clUyAHSzXZLRJypon/9/cndNSHirh31wv3eY35Ac=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ot4CeEDNbr+5ya5X5ROyGQSNgAmaRbfTyM9rW6hbjveno7+2qc2btGyIz5StKirdhE/8EJJJ5+QKcRIUNTzu02FeTUY62L8ObVEPr14GPUuHPs0cTFs6t4nYf01+mEjh4qdjtTAel0qEtr+AiYIzGV0v6LePcAzX86J0pM7aPQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=DhE1b/ye; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=lGWlM9AN; arc=none smtp.client-ip=103.2.140.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpcorp.com; s=a1-4; h=Feedback-ID:X-Smtpcorp-Track:Message-Id:Date:
	Subject:To:From:Reply-To:Sender:List-Unsubscribe:List-Unsubscribe-Post;
	bh=w4ZAWZTNg1euJmLaEWbFNw2s9ni8efmSIaUdOd2VsbQ=; b=DhE1b/yetBHHFRLmxGbLVU/Mmx
	MX7GYetXCdITIXKkFLNpEULcDTO/Oex9mcphwQa1x4nsvWiFDEtOBy0zCbnTMSXytLBAyO+7HwOmw
	raQU4eeGEvojbEJ/eFcJMGAtEL4v+NLKr48h7z6UBAxOvpov4upvJttLpsbCvuszTgGK4VfOcYgmg
	gtT7J7WxdtHg6d5C301/iPSykkcwtOwdzrJGzf4aHJoarQGSlEtjd70U0+Po9uhLBBnet6YCSrvuu
	fL+uai2Q16PRL0G9Xr5TSV91o44050K2Rd2rBKNrKwWE8U4RWnvS5pGXx65YVMkg/xG2pWyMHgHKJ
	fGmDZ1kA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1716891389; h=from : subject : to
 : message-id : date; bh=w4ZAWZTNg1euJmLaEWbFNw2s9ni8efmSIaUdOd2VsbQ=;
 b=lGWlM9ANQ1P70EPvOLAEJb8ggLcgj6+/uaREnVTvNmlI1B7qrQpDc4wI/1BL2tebVQ8PW
 gnml0npxu+kqT4xJzL899QGCsExx5S2Q487Tm2FnvpqImi5UHxDvZPbJlk0o0l8zQb4rj0H
 L3ktStbdG3E1guS9Jdf5raBSx8LYdX5QmR7Hmvfs5GYryhZD+JzIQe4rBbGo058ROqltu0Y
 qE7I5SRL7NKPSkQsxzP3dKlWvagKg2iK31s4fqdBo5LQlUpm74lM7z6Y77nOcSYHgJymU//
 kD7qv1dg/3MXU0qpUfQJ0Qyx7f7IAc1mkwLb+PoXu2FjUBEFm4GdkfVGINeA==
Received: from [10.45.56.87] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <f.suligoi@asem.it>)
 id 1sBtsQ-Y8PCFe-L6; Tue, 28 May 2024 10:16:18 +0000
Received: from [10.86.249.198] (helo=asas054.asem.intra)
 by smtpcorp.com with esmtpa (Exim 4.97-S2G)
 (envelope-from <f.suligoi@asem.it>) id 1sBtsO-FnQW0hPuHwL-dstN;
 Tue, 28 May 2024 10:16:16 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with
 Microsoft SMTPSVC(10.0.14393.4169); Tue, 28 May 2024 12:16:14 +0200
From: Flavio Suligoi <f.suligoi@asem.it>
To: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Jose Abreu <joabreu@synopsys.com>, Adam Ford <aford173@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH v4 0/5] arm64: dts: remove tx-sched-sp property in snps,dwmac
Date: Tue, 28 May 2024 12:15:48 +0200
Message-Id: <20240528101553.339214-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 28 May 2024 10:16:14.0231 (UTC)
 FILETIME=[1208AA70:01DAB0E8]
X-Smtpcorp-Track: q4lhSraF7qzx.p2TOe8zgkmwd.xArrvAqGSu2
Feedback-ID: 1174574m:1174574aXfMg4B:1174574s6j27gZQMC
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

In the ethernet stmmac device driver:

- drivers/net/ethernet/stmicro/stmmac/

The "Strict priority" for the tx scheduler is by default in Linux driver,
so the tx-sched-sp property was removed in commit aed6864035b1 ("net:
stmmac: platform: Delete a redundant condition branch").

This patch series remove this property from the following device-tree
files:

- arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi
- arch/arm64/boot/dts/freescale/imx8mp-evk.dts
- arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
- arch/arm64/boot/dts/qcom/sa8540p-ride.dts
- arch/arm64/boot/dts/qcom/sa8775p-ride.dts

There is no problem if that property is still used in these DTS,
since, as seen above, it is a default property of the driver.

The property is also removed, in a separate patch, from the corresponding
dt_bindings file:
- Documentation/devicetree/bindings/net/snps,dwmac.yaml

**************************************************************************
NOTE about this v4 patch series: resending this v4 version of the patches,
     I omitted the word "RESEND" in the subject line, since I added a new
     tag in the patch num. 5/5.
**************************************************************************

v4 - Resend after some weeks and added the tag "Reviewed-by: Krzysztof
     Kozlowski <krzysztof.kozlowski@linaro.org>" in patch num. 5/5.
v3 - Removed the tag "Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>"
     in patches num. 1/5, 2/5, 3/5 and 5/5 (it was added by mistake).
     Added history in each of the patches, as well as in the cover-letter.
v2 - This patch is the 2nd version of a previous patch, where both the DTS
     and the yaml files were included toghether. Then I split this 1st
     patch series in two, as suggested by Krzysztof.
v1 - Original version of the patch where, in addition to these DTS patches,
     there was also the one related to the correspondent snps,dwmac.yaml
     dt_binding file.

Flavio Suligoi (5):
  arm64: dts: freescale: imx8mp-beacon: remove tx-sched-sp property
  arm64: dts: freescale: imx8mp-evk: remove tx-sched-sp property
  arm64: dts: freescale: imx8mp-verdin: remove tx-sched-sp property
  arm64: dts: qcom: sa8540p-ride: remove tx-sched-sp property
  arm64: dts: qcom: sa8775p-ride: remove tx-sched-sp property

 arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi | 1 -
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts         | 1 -
 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi     | 1 -
 arch/arm64/boot/dts/qcom/sa8540p-ride.dts            | 2 --
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts            | 2 --
 5 files changed, 7 deletions(-)

-- 
2.34.1


