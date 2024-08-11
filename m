Return-Path: <linux-kernel+bounces-282098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D66F094DFAB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 04:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2839B2155E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 02:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E98F17758;
	Sun, 11 Aug 2024 02:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="eEDkV/kM"
Received: from mr85p00im-ztdg06011901.me.com (mr85p00im-ztdg06011901.me.com [17.58.23.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7F03FE4A
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 02:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723343154; cv=none; b=gyKSvXrvJpBOsFKAEs+QBQWqNw9br4Gkrs9Xeio3FA5XxNfpNcX7U2uvbP7wLMp88cZOoyzHgy+o8KheBgAqpyy87codTfM2GIg+TeOYdsT6grBNZ3TSpfpy2XZ75LR2g5Cp0S6beTBFjMzkGDdIXTbGfsoHTZkQ/bfxPtb9yiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723343154; c=relaxed/simple;
	bh=JOmzwG3z+rGlgdRckmpfXnsOtybXClJTSiQ00yRbkMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JHtkR91l+NA5XaruZ4DFzYivHjHJy8Ar198WPWnQN+t+Pa5cdWVH6K/kEz2xZCj9ttAwdvSGZNYY5Tb+zqZXaXyESIuEpBCsj2NqkyKzE8I+eri20pg6Fg1QTbWiqAbt15o6SQn0alW3qOtxIc8NgISjiBna2LKth4rRApfpho0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=eEDkV/kM; arc=none smtp.client-ip=17.58.23.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723343152;
	bh=/dLd/Y6678zlMOM9Op5VKFNdLxAGkHjDht+RQn2ZlRk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=eEDkV/kMD/1FJNWHE3QhemHUPOJu2WDIX0JRyu4dIg1h0NNcsQ+nR7h02P1y8s+zo
	 mWn3XLTtuLA7w+sIs92uWntPM3jixRXNNs2Coh6bv37YREG6XcpRx4Xt5f/TGvisg/
	 cWWu92zXqc7fMHDqnInp3J2BEfai7z7bVidh7EciLVBHqu3LsRBOiOMU4v6eUul5di
	 uIFTWGdNcsLgljzULGs24BZwraNOisbluTJyhqDaeBnv9NfnWm7UZh3p5qgoc6whLM
	 piwp0JUHKuNVTN0BR2WFIOoCczlmfrjmj89qu7mOEZI8iHGnFQkzwgnjDLfDg46RJ4
	 cAKkuQHIadr+A==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011901.me.com (Postfix) with ESMTPSA id 69C791349C09;
	Sun, 11 Aug 2024 02:25:48 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 11 Aug 2024 10:25:01 +0800
Subject: [PATCH 10/27] pwm: Make device_find_child()'s match function take
 a const pointer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240811-const_dfc_done-v1-10-9d85e3f943cb@quicinc.com>
References: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
In-Reply-To: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: cyKyr4TbnOSdn46-bOJZeA9VRZF_evui
X-Proofpoint-ORIG-GUID: cyKyr4TbnOSdn46-bOJZeA9VRZF_evui
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_01,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=910
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408110017
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

In order to adapt for constified device_find_child(), make
pwm_unexport_match() as its match function take a const pointer.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/pwm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 8acbcf5b6673..8e58b95d69e1 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -753,7 +753,7 @@ static int pwm_export_child(struct device *pwmchip_dev, struct pwm_device *pwm)
 	return 0;
 }
 
-static int pwm_unexport_match(struct device *pwm_dev, void *data)
+static int pwm_unexport_match(struct device *pwm_dev, const void *data)
 {
 	return pwm_from_dev(pwm_dev) == data;
 }

-- 
2.34.1


