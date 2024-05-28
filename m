Return-Path: <linux-kernel+bounces-192089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEF08D184A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 181DAB223DE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709E41667F5;
	Tue, 28 May 2024 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="zzZR+sPb";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="G6unpIZK"
Received: from e2i187.smtp2go.com (e2i187.smtp2go.com [103.2.140.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254F316C444
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 10:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.140.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891391; cv=none; b=MvckG/L6P1phNTqVyEqIWEgzvL5QfkPXZIgmm6w+7C2W4ix1vSQP+oCBgWWAJgWYMzzeE3yaHfm/cGyuxSKdJN8lNtrMPWfN0Lghmg5pZC4qxLc8z1lFJt4xN4vPrUcKV9mbhMWyZMzUeMb9bCGEtxTziLVugIcA6hWNz6b5Nbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891391; c=relaxed/simple;
	bh=6oC0Iuu393khyKlVI9xXwwcZLOlRA27Y75uOzGSXvFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jGHiccIMIip6JDdUnYJmsR+ZRm4DASfjs9+wSNuvzyV8xnFv91aF6y07SioSsrzdgqflq2skZyUkUJHVGPGvgeRve+jrumNwIoAsvwV0HOeuDmjSdvTOXYWDiDl2R4MJvKYgB/I/5dRTCX0b1dCP745J3AMSc9BTMd5gT0r+av4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=zzZR+sPb; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=G6unpIZK; arc=none smtp.client-ip=103.2.140.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpcorp.com; s=a1-4; h=Feedback-ID:X-Smtpcorp-Track:Message-Id:Date:
	Subject:To:From:Reply-To:Sender:List-Unsubscribe:List-Unsubscribe-Post;
	bh=AuGU9ww0mJkm0U99Qi0nDaMfje+KtX6V7T19eN68Ao0=; b=zzZR+sPbpPQPNFMNMZTPJRThQC
	15oEG/RwZF6xyrqmNpMhGjOUKTmplfdwMjKOrIRDZ0lSWIa8qBzWHh9kczc34Dcus1EXNuwzvZL5k
	7VRAi28HSSwhdtrLpTZ+Arlx9MEIRqZ4zIcBIqZpQBYe7SLD22knZYH91n3DpfSJFBgBnCv9IzmkO
	5ZarTe847dFfL0BVf+YIN4/Av7tjNcEnLM41C06besnY0zFvayA/14tDU7kk0QmVaIgiD2WyaOTmZ
	ca6S/UjbVbGDVIamxG4wTjH3f35nIvggr6SzVzPi9xgyWTzMZ/p9RSN7rJCxI5fKgmvhxGQ2MvQB8
	4d+3vZiA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1716891390; h=from : subject : to
 : message-id : date; bh=AuGU9ww0mJkm0U99Qi0nDaMfje+KtX6V7T19eN68Ao0=;
 b=G6unpIZKoMaSVydN3Rfi9U56z6w8kkM3w142CTjsNnyofbGCmyGhlWxh79PHhLeoBNVe3
 VZGYYGf8K8fG6ORNkjP4KfXN6byOqJEErX83hb4fQJF+ZWRt2YE6UHOyW7XQkjfzFy0cBHS
 VizGf3m4Cm3xQbVhDY/GvnHI6IHpJ/nxl3ybdsrLEsqa/h6q11DFaS3zr49XWeTLufqZWiC
 7637wLOIQgwvVVE1Mluky2g+pEEzs66+V+z6rRP1knqGe6raSdvcKkawcej3UYPzQLHdonN
 751/FkGzoKDtzS79FWKbyMZ0VPYUhg4S2xzumMTWUksCGvLs2U9cu6/dstXQ==
Received: from [10.45.56.87] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <f.suligoi@asem.it>)
 id 1sBtsS-Y8PCR4-9O; Tue, 28 May 2024 10:16:20 +0000
Received: from [10.86.249.198] (helo=asas054.asem.intra)
 by smtpcorp.com with esmtpa (Exim 4.97-S2G)
 (envelope-from <f.suligoi@asem.it>) id 1sBtsQ-FnQW0hPuHwL-cTe3;
 Tue, 28 May 2024 10:16:18 +0000
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
Subject: [PATCH v4 1/5] arm64: dts: freescale: imx8mp-beacon: remove
 tx-sched-sp property
Date: Tue, 28 May 2024 12:15:49 +0200
Message-Id: <20240528101553.339214-2-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528101553.339214-1-f.suligoi@asem.it>
References: <20240528101553.339214-1-f.suligoi@asem.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 28 May 2024 10:16:14.0263 (UTC)
 FILETIME=[120D8C70:01DAB0E8]
X-Smtpcorp-Track: ucud31kcZPX3.6wabVuvtskvw.lXkulQ6OEHj
Feedback-ID: 1174574m:1174574aXfMg4B:1174574sk39EAmvT5
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

Strict priority for the tx scheduler is by default in Linux driver, so the
tx-sched-sp property was removed in commit aed6864035b1 ("net: stmmac:
platform: Delete a redundant condition branch").

So we can safely remove this property from this device-tree.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---

v4 - Resend after some weeks (also added the tag "Reviewed-by: Krzysztof
     Kozlowski <krzysztof.kozlowski@linaro.org>" in patch num. 5/5.
v3 - Removed the tag "Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>"
     (it was added by mistake).
     Added history, as well as in the cover-letter.
v2 - This patch is the 2nd version of a previous patch, where both the DTS
     and the yaml files were included toghether. Then I split this 1st patch
     series in two, as suggested by Krzysztof.
v1 - Original version of the patch where, in addition to this DTS patch,
     there was also the one related to the correspondent snps,dwmac.yaml
     dt_binding file.

 arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi
index 8be251b69378..34339dc4a635 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi
@@ -106,7 +106,6 @@ queue4 {
 
 	mtl_tx_setup: tx-queues-config {
 		snps,tx-queues-to-use = <5>;
-		snps,tx-sched-sp;
 
 		queue0 {
 			snps,dcb-algorithm;
-- 
2.34.1


