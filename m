Return-Path: <linux-kernel+bounces-556030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758D7A5C008
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD8E47A9B05
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA962571C7;
	Tue, 11 Mar 2025 12:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="bkWyEfZk"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A2F222572
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694590; cv=none; b=K7z8FFzYKP7YBtJTFU22qWhIaHGVwSFDWX1UA6H5fa7J9twF1uFF6oZG2EuMvFTs9clk0LRiokpQv12gTR1qo6Go86SDpq5FQz8OSF7OidS6EbAqNliNEnDfwKxF4mrp2a3jNt8YkUcUusA9BQR9B0bT7FFrwHzdwv1jZ9We5mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694590; c=relaxed/simple;
	bh=nC6lwDPb3zbItVdYhexRf+7PoutRMPw8aLJAIMgqJRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fX/3TDLGKum2HLh8sEXHiijA4qQQrydgp+sBIY4aTfplldIEN+oaA66MYeuy/tUqc9nnKdQ5NrgRLZFikVlAmvs5gIVI5CNP2zeROWrerHNMtBA/0GEqF/kRiIoDoXKxdT8C/zGV1vD1t9Cmd8svyq3YygXLnuTjaxILf3i6i7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=bkWyEfZk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43690d4605dso33050565e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 05:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741694586; x=1742299386; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1eyDA70luy030ManbvwItVlUHe7jfQdxQkjt6FQ5RE=;
        b=bkWyEfZkOoiQ50NPvJZZV7Vn1lsHJV727+G3UfyPuNDd943mYhfZgKU/dg2CMQB6zd
         hUpfq4NXOdcLYnWQ7ofaSYGBUi1KvLaGxkqmqfXw8Pd/5P/3PheFrVCTaIcyXRDCwh8P
         sNeY3A1ihLr3hYPsH10AtgYtaVXveibMmFnjQbmsBRmnntXfjAC2vDEzjZFAvoSkMg+l
         nvlHvR4ClP7KX5ia+xanyTKFfN1YUlahRlNNGpsQZOJdu5xzTACNbRphoOYeG3CohcjS
         goHhoD6i25imXz6vOr8wREW2pcxgPZZxngknUsmvdf/cJxBeF3rz8HaMIkZR7MEKoWww
         Jm0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741694586; x=1742299386;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1eyDA70luy030ManbvwItVlUHe7jfQdxQkjt6FQ5RE=;
        b=GV6yAzA3T/R59C56BFPPCXzEi7AtOK0l5zNPgn7HeLzQNXKRJ0a+MPeuk+BHR6PeDC
         i53GKe8Y98FG8fxJ1yA5t+LOwju7TfY0ov7jTs112O5F8ZhbrWBTCerWJYdo8ivt65aU
         0JMWRkdyXGGKaduRnLtzceBvSanHA6izf+9naGAHzcxyIrcZMsCpQ6bgYB4oxVR/yAlO
         VY/tide5hZWh3IrPSjkte4tBnJtqnJ2PDmZ/sJ4UcioujJMw3KPPq2M0qyyPxTX0XOPK
         1QxtuHREWJjBYzjPUr1vXt0+1FvoG7eGg6iWZ+T/4Pu32TMb7QVzaBnaZ4P1c3rzl5xz
         jOAw==
X-Forwarded-Encrypted: i=1; AJvYcCVLqGuo2NdKZrZZ2+dZiW9SlcqroSWutnj5+vvNJoTT10JyENdF9A9M8CeTc0AS878EWTQnCgAP7skt9QA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Bc/OFYJuk6FRYHgw2pxBZ4FTzW1AyQwLHuAuYDI/VT5j2yUx
	/3jJxsrUG2u5l5VF+1p3dW/OhCo+VcmY227z5vn3xyK1ezFsgIb2bZKrfhNqbId3h2cTNIQAO5d
	F
X-Gm-Gg: ASbGncuZro/mhKFYarn910W9VUlK/btwhNqhW3B0eFfBiFuEe5N6zpo2spl2ySCzINe
	uurZEjBNVdQSLuxDoMTKVnpbywGgnS4SjaWv4hkJ2e29WKtSqiG39zoHB8gEScsvI8bgS1xTJvq
	qfe8L3R5y1uOdmJmMtPIvJs9wGkFC+8nz2EXwyJ0JSXJ3a01yYWT2/cWy+W2QZEE4AKQVqJOSb5
	d0vuRDOSjfHWIkCEDdFDHvWkRxpDQxM4ORtQHZTKmokB8eTPn6CS9xojyiYw0SnFaJrsn8BD0vn
	4/9+x0daUxjeRTpliPGuXhr+/U3qDuAQbSoa5NP2UA==
X-Google-Smtp-Source: AGHT+IF5Oo7ynV4zn15KpEF5SclpF0q1nhddvqL39d6+0oc4qsE5O4EOq80dEkoLXRYlbh12HUukaA==
X-Received: by 2002:a05:600c:46c9:b0:43d:4e9:27f3 with SMTP id 5b1f17b1804b1-43d04e929a7mr18641155e9.9.1741694585585;
        Tue, 11 Mar 2025 05:03:05 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:52de:66e8:f2da:9714])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ceafc09d5sm110537605e9.31.2025.03.11.05.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:03:05 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 11 Mar 2025 13:02:05 +0100
Subject: [PATCH net-next v22 04/23] ovpn: keep carrier always on for MP
 interfaces
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-b4-ovpn-v22-4-2b7b02155412@openvpn.net>
References: <20250311-b4-ovpn-v22-0-2b7b02155412@openvpn.net>
In-Reply-To: <20250311-b4-ovpn-v22-0-2b7b02155412@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1056; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=nC6lwDPb3zbItVdYhexRf+7PoutRMPw8aLJAIMgqJRQ=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn0CZwjPCNQ3jPkMYrshxLF11tMJIC8IFKY8uqo
 8c4v1Ee4XmJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ9AmcAAKCRALcOU6oDjV
 h5eIB/9+ocw/boPzPAVjRI4bTypw4HVhVXUvlyFkjE2M0rfcW98avYxJ2aU2tuCcjS2CTBY5G9w
 fFhMy9eIhx/362GyVRc3QZtfCE6WxrVd6ulpmRWWiq84X1XhOn9+GqqC4/HbuVwGESisCLHII5Y
 mAQhjFAG1LTxQLceMmhqBPNiom5VH9zuaJS1vT70lAfKX1ORpf50cMDCBonMf7/oNAv8kaw93vW
 qDFoNI6ptXGPX8/33wwOeJsFxE0DnYAIn8Rvy1P8uUEAEwokb9iLmJZ52hShExhfq/e2Al4htWd
 Zc3yqxO889Y73xGOMsoe4ROindoYfZk+Kg2r56swrE2i88Cf
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

An ovpn interface configured in MP mode will keep carrier always
on and let the user decide when to bring it administratively up and
down.

This way a MP node (i.e. a server) will keep its interface always
up and running, even when no peer is connected.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index e71183e6f42cd801861caaec9eb0f6828b64cda9..c5e75108b8da5eabde25426c6d6668fb14491986 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -23,6 +23,15 @@
 
 static int ovpn_net_open(struct net_device *dev)
 {
+	struct ovpn_priv *ovpn = netdev_priv(dev);
+
+	/* carrier for P2P interfaces is switched on and off when
+	 * the peer is added or deleted.
+	 *
+	 * in case of P2MP interfaces we just keep the carrier always on
+	 */
+	if (ovpn->mode == OVPN_MODE_MP)
+		netif_carrier_on(dev);
 	netif_tx_start_all_queues(dev);
 	return 0;
 }

-- 
2.48.1


