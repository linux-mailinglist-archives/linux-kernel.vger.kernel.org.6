Return-Path: <linux-kernel+bounces-266876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4B59408F0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849C31F2423E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 06:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D179918FC6D;
	Tue, 30 Jul 2024 06:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tilapin.org header.i=@tilapin.org header.b="wgFkAPfH"
Received: from carotte.tilapin.org (carotte.tilapin.org [80.67.176.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999DB190479;
	Tue, 30 Jul 2024 06:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.176.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722322516; cv=none; b=FaEdvKi3Vcf0e7/3fAjiz3IAcVDyv/xfu+fC2pULbRIjEYxXsEZkibH2WLArKYSsZEJEvprotGSqXWGyd90DOJaUUeXWLhbbfnkaptig8IdF9pi3nseKdQ2kGa8F8LZ9jrfe8o6Sgx3iF7yp/87POkqb7u2zgTB/lg1Whs8pC4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722322516; c=relaxed/simple;
	bh=grl2JzMV7lSnkB8+s1ZBfa2Q/v7Qx0DD3xdWYehgEY0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UpYjKHRurrZKpgFimrioL8R2vJ1y4tB2ckUart+e2qSXRWqd1V5zBka81x5LTkHY/Vb5ULHgudeh6cZLjwsw/leWCJnCXom9ELRw8hlaBzRLDYn3kvA5AmNNkII8PzAH1oBE5kuLkPSL6fuBQwEEGFA90BBoIDO5jKBrc/1pSSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tilapin.org; spf=pass smtp.mailfrom=tilapin.org; dkim=pass (2048-bit key) header.d=tilapin.org header.i=@tilapin.org header.b=wgFkAPfH; arc=none smtp.client-ip=80.67.176.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tilapin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tilapin.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tilapin.org
	; s=20181003; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Tz2OFxBPk7BVnpANL2dPikezT8te41CN5a7QlW8xAx4=; b=wgFkAPfHaQRd3CIUK7v7dBTFM4
	D4hM25A5xzPBHgA/hsD2AUGvLzUzlstpOqChg0aK4hEXKvyszwQxJ+z15Ql5fvZ9Y7hDbw5GtMLnZ
	dN6MY2ik+RjYq7ybdzcidjiC7/BakMziOF3pKoqU+nQDStnJvl3xaRBqWc3iZKBreoclzHUOs4lyW
	y+EuptiUiLI2GgsQQ7QyOiCmHuJa6X3cDtdjlVK1cyDHfp+CQGNbAJ7c10FlEAlhgdur7W4ITiDrN
	pps9WhYE0nkgrGJzXmAOqYoAQyliY8jQnat2NTCMKB3piq8S4Pyy7pwNjDHNtrfKWEgYgueVFprKO
	7aNQYAYg==;
Received: from [116.89.172.29] (helo=ca74a6ee468b.debconf24.debconf.org)
	by carotte.tilapin.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <david@tilapin.org>)
	id 1sYgdd-001QLf-23;
	Tue, 30 Jul 2024 08:47:14 +0200
From: =?UTF-8?q?David=20Pr=C3=A9vot?= <david@tilapin.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	helen.koike@collabora.com,
	taffit@debian.org
Subject: [PATCH] staging: rtl8192e: style fix - alignment to match parenthesis
Date: Tue, 30 Jul 2024 06:47:07 +0000
Message-Id: <20240730064707.914-1-david@tilapin.org>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fixed checkpath Alignment should match open parenthesis

Signed-off-by: David Prévot <david@tilapin.org>
---
This is my first contribution to the kernel, thanks in advance for
pointing me any mistake done so I can improve.
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index e38cd0c9c..dfdb7a7dc 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -188,7 +188,7 @@ static void ht_iot_peer_determine(struct rtllib_device *ieee)
 }
 
 static u8 ht_iot_act_is_mgnt_use_cck_6m(struct rtllib_device *ieee,
-				 struct rtllib_network *network)
+					struct rtllib_network *network)
 {
 	u8	retValue = 0;
 
-- 
2.20.1


