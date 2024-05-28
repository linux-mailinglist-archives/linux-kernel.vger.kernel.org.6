Return-Path: <linux-kernel+bounces-192091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AD18D184C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F5EC1C22738
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F8316C858;
	Tue, 28 May 2024 10:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="0NvcXBhC";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="Ilk39Xq+"
Received: from e2i187.smtp2go.com (e2i187.smtp2go.com [103.2.140.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1962816C693
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 10:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.140.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891393; cv=none; b=RzFlgcJ5izu/AY0fKGfyZty1T082wMy5pUbd0pkv9RGrNo8MdnaCaW0TeTQIELjv1uL8Qx05Svm+tkOTcpV7AUi9tlJfbpXD6OpigDv58Ru1V6yzUd7wjvwMATO6kG4Ei+qAyIHRyP9VYi85bcr50Oo/KIQegFH2/0WuKpB+Aio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891393; c=relaxed/simple;
	bh=FxzUFMdru4osktFl89QiRJttKIRmQcse+pcZI7VhhWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p9W+xIZ4G9rhMFTjKR1wuWPCFeADV7wg4t8YABv8h8uFjuCa5z/NHvqLKGEMLod7nBWjonkT8cWMKjIQUDmidk2f2pf1BjXvim1V6beAn6obfi0wegQes8B5UgtUVGfU4pJ0VlvFTJ/Gg3Wje1Pois7YL1ea7mfa3vv6Hp242Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=0NvcXBhC; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=Ilk39Xq+; arc=none smtp.client-ip=103.2.140.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpcorp.com; s=a1-4; h=Feedback-ID:X-Smtpcorp-Track:Message-Id:Date:
	Subject:To:From:Reply-To:Sender:List-Unsubscribe:List-Unsubscribe-Post;
	bh=WTJGKszru6/8OXc1XDAhsOOFXU+bGmBkM3qo5s6aOGI=; b=0NvcXBhCHgX0qY4z9UKfyayV8r
	QCi1ONHSZVwV4Gf78b0Xv2zbaggrizIjPneHx6XVRBnYKfbW9J5rS9tPZqBGWrtzKBR+cOwRpx4u4
	Pi9a7ThkmC3xycpdo+tsoG7Xoxo/4wHIXYU7dUVnY3cNLAQ9IYUy+OrEw4ITGWvUzA1SppwpJdCJe
	BHJAkYAoTUVggydq08wOtAV1g78upWFk4ME7bmkYBZMe8JI/gsB5NTXYxsnI1Xg2V/l3Vba4H3gzs
	Bll/fDwCZ9wyuFhET3U0OMS1f+TY+x5rTDjiBuN/W6CkEzBstdpDu+TrAMoAIGmvDuS0Pc3DkGrAB
	aSKQBS0w==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1716891392; h=from : subject : to
 : message-id : date; bh=WTJGKszru6/8OXc1XDAhsOOFXU+bGmBkM3qo5s6aOGI=;
 b=Ilk39Xq+L+1Vt+hBlk+McAP+tSmzEvnHzsdiAIWAuQF6Jc8UJ8iCympgUlm5unLEf5VOL
 UzQCZdZbdPEhIUyM6xeanc+V3ujuCcD+NaD9jxQLXy24isRs2QzjF13+zuQE8yageR4CiN0
 Lzue9e54s1QPHFX4912LqElZpU21fBUI7vYsQb8h7ql+g3AIlD4nhP7ngT4w0UvdaMQ9Z62
 SgDPM8sny0PxhR9M9cJoYbUgY5n/gVFeNIHuxFHIvNvZPYOW98lsEoBnfAZLjE+mKtC92qR
 usPEQJqdGTV6r30I/asXVbokDFM+wIbSccSioVtHYLx5vStwI6XZQHXY/g7A==
Received: from [10.45.56.87] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <f.suligoi@asem.it>)
 id 1sBtsV-Y8PCjN-MG; Tue, 28 May 2024 10:16:23 +0000
Received: from [10.86.249.198] (helo=asas054.asem.intra)
 by smtpcorp.com with esmtpa (Exim 4.97-S2G)
 (envelope-from <f.suligoi@asem.it>) id 1sBtsT-FnQW0hPuHwL-dxGp;
 Tue, 28 May 2024 10:16:21 +0000
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
Subject: [PATCH v4 3/5] arm64: dts: freescale: imx8mp-verdin: remove
 tx-sched-sp property
Date: Tue, 28 May 2024 12:15:51 +0200
Message-Id: <20240528101553.339214-4-f.suligoi@asem.it>
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
X-OriginalArrivalTime: 28 May 2024 10:16:14.0294 (UTC)
 FILETIME=[12124760:01DAB0E8]
X-Smtpcorp-Track: ooOpExDEZqc5.8xJmNg2Fghn5.NS0F6A7aRlX
Feedback-ID: 1174574m:1174574aXfMg4B:1174574s7KWN2naAj
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

 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
index aef4bef4bccd..222521f116f5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
@@ -276,7 +276,6 @@ queue4 {
 
 	mtl_tx_setup: tx-queues-config {
 		snps,tx-queues-to-use = <5>;
-		snps,tx-sched-sp;
 
 		queue0 {
 			snps,dcb-algorithm;
-- 
2.34.1


