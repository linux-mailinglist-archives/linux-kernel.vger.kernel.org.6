Return-Path: <linux-kernel+bounces-192090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 958408D184D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C49531C223E1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C53116C859;
	Tue, 28 May 2024 10:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="FSd9uuvp";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="Ahzt0D6B"
Received: from e2i187.smtp2go.com (e2i187.smtp2go.com [103.2.140.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195DB16C692
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 10:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.140.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891393; cv=none; b=eCXvsvVsKSw7Vnja18/pRn/0EpRRPQT+h3BW29DB4ZiTFHI+lQggtHqw8X1XngLjwQB4t2AGyIDXxaWXQM0GA5AjRyyD5iZBQaJ9G3dis9+pBLUvhs30qu+/pRJmtsJx/vUb6KbVD0Mft7QdoRekFK6lU4Fk4X+sR6uTiE8c8VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891393; c=relaxed/simple;
	bh=tXx6p7BbCuL55D0qt9hWOFE+RgKNnMzF+7tb9TnuI98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IkO3olpdeFu0lHGnB9VvIHTzb/1hUxOYw9eue75DIBJNC3plttkBGhZpvma/a1rbtwIIku4C+sV1k1M6DruQ/ufwZHVfR5S8wdUUIQP4mzZhFdYVzvn4L5yunw7jqcBLSdnFwi58HFDqnoUQ1hxbaaEYHsFaV+y1922kSecnCqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=FSd9uuvp; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=Ahzt0D6B; arc=none smtp.client-ip=103.2.140.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpcorp.com; s=a1-4; h=Feedback-ID:X-Smtpcorp-Track:Message-Id:Date:
	Subject:To:From:Reply-To:Sender:List-Unsubscribe:List-Unsubscribe-Post;
	bh=BBch9oN1usl9P0mIN17UyeXOwYlWmbIz0xSKtVbo3H4=; b=FSd9uuvpACEqmHW+L7wowhnBvo
	wDJiJefBMUwp+6gc4f2SE/BYZo3qOsPoWKw3WhcAlJN4JwrJFk1EGFVYV4VIcfmSMqKOYeJ2IIc8l
	yPLp12kHtr63Ix7B/A735h269dF0xhnknFkToKQnXfVpOSd4VVDCzNcp5RmydQgBNwsOTSC+huui3
	lygFXkTyhFKT3bzEazC1Ek/mgH4dctTIlvTDZWRffWKZeqxHHm7gcdbm91y+mcw1vapb+gA4HQhCt
	EZzIaxgfk6oynvvjvrEjZ/u9hVIVXR9oJnjQ64CoEj4d2JjvxJIpv+R384+DyBHF/TxvS0wMZr3Xi
	5ETWAowg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1716891392; h=from : subject : to
 : message-id : date; bh=BBch9oN1usl9P0mIN17UyeXOwYlWmbIz0xSKtVbo3H4=;
 b=Ahzt0D6B/M4GQxMFxAsAGpUtwe19MnnZ5UcyrNY2pClluSPWCvla3KFTD6dmsMQFvUqC0
 SbHqlhtG2dnt5+adjtdvAf/kk7Zon7SG7b77kzhhmxBSVw3PRxWF9tlOFiE7EndPhmp62lJ
 d6rj/tE3SS2qKMz3pgz0iUF9FU1e3J0WlKSMd4ulmNAvKAm4UFAZI8SsxFNfJ2TBU6aCqyt
 HfixSXvsIcwmQgXduNNsdL/0V3d6N1g9ZyPS8EcXG88SdcUHsAUr4oixb6fkw42yHe//5zI
 my1aCw+sShVjA8V78dcU3cH5nw8Ylkrx3xGjfz6K9SnqbqjcwFeIgS9+oqtA==
Received: from [10.45.56.87] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <f.suligoi@asem.it>)
 id 1sBtsT-Y8PCdf-Vn; Tue, 28 May 2024 10:16:21 +0000
Received: from [10.86.249.198] (helo=asas054.asem.intra)
 by smtpcorp.com with esmtpa (Exim 4.97-S2G)
 (envelope-from <f.suligoi@asem.it>) id 1sBtsR-FnQW0hPuHwL-fOl7;
 Tue, 28 May 2024 10:16:20 +0000
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
Subject: [PATCH v4 2/5] arm64: dts: freescale: imx8mp-evk: remove tx-sched-sp
 property
Date: Tue, 28 May 2024 12:15:50 +0200
Message-Id: <20240528101553.339214-3-f.suligoi@asem.it>
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
X-OriginalArrivalTime: 28 May 2024 10:16:14.0278 (UTC)
 FILETIME=[120FD660:01DAB0E8]
X-Smtpcorp-Track: Ot26mkQmDhAc.A6OnEBASYnxV.lKQRZw9taPN
Feedback-ID: 1174574m:1174574aXfMg4B:1174574sgakE8KTJm
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
     dt_binding file

 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 8be5b2a57f27..bb1003363e3e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -251,7 +251,6 @@ ethphy0: ethernet-phy@1 {
 
 	mtl_tx_setup: tx-queues-config {
 		snps,tx-queues-to-use = <5>;
-		snps,tx-sched-sp;
 
 		queue0 {
 			snps,dcb-algorithm;
-- 
2.34.1


