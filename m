Return-Path: <linux-kernel+bounces-542988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52718A4D03D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8B371895902
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5601FAC40;
	Tue,  4 Mar 2025 00:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="fdJRy+bm"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51151F8BDC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 00:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741048502; cv=none; b=bmvBLVUTUIVRZRyLRBlurV7zX7vz5VESzNvUIYURWEymbAKsoBE5PKQpAKdyeXfATA9xJ9x8XLc5cJg1wWzkflD1VJNDdE9AxA0BNOjIpOoK6mNH+t70E0YJvYM2PWMX5wXjVadiEaxVG8/rMHpNLAVIcpd5EnUE7iojp1pTt6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741048502; c=relaxed/simple;
	bh=BYLORm4A7rlyB0uoL8wRITWNqD/++CVET8EMPQpW32U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QWfRRqW48CBNoIBbpKC/MdOCF9sDM1mTKBgl+GwmU7oswSLx0pWfD5bv1w2AWmRumqQ9H7XgN97EXY0k0dbyNzR0Z6CyNbyUDysTCIFY8ZEro1bgJcmqEpcVsxpU7T/xgHjiM7CMd6xPS9kkC/VOCn5Q73hrDHximfszeYM9qc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=fdJRy+bm; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-390ec7c2d40so3333140f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 16:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741048498; x=1741653298; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4JsGlr6Iur8i/UJC3VdCm/PIJhARIB9iZF0up1yoAd8=;
        b=fdJRy+bm+HZbsuBjgtVuAqgoiS90sO8tkw2NzvJ9+nptEtes1iUKdid2ytJE3Vpnqs
         oI5OcKV6Dlp8ujHxbKsIuo5UjlvkRSBB55Y7HzzL6/2Fy8bvBW9dW09SfLRQqY4C7CGq
         b2d1xD8A4xHp7LsJij5OumsAkMPOid2uKPqe5Xzn5s3OOhSh5SQfJpvvevhV8jZnrgpV
         1GSCVxlvhr3wyO4Gho7khHcaoXud4Zl0QJmvAX6HubYzisikZ0nmA9021rP9YVyBmOcI
         a+etQ6IaD2qReWVJj4jzqZ4GyrcpPbehYRMYEgwRIqYskxuibBs34L91GIuqb+qMgDuu
         fCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741048498; x=1741653298;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4JsGlr6Iur8i/UJC3VdCm/PIJhARIB9iZF0up1yoAd8=;
        b=m+ktppClgfASgl42OPYlrudkBa0evPr7edsGyOgys88tbZHdcv9b1TEFxImLJRU7Rf
         5icbO7T8DjCf1v2BViSBoomJmpQ4/opAowXKPnBz6J6QE4IPugF5lr4lqATcxUG2LkyZ
         7PXQkxlCpTXy0Br0s4B6NS+zbmWRe/5DlcCz+ZIGw04oMd21256vPFi5mgtrIis7gzT6
         GpNnPrBrS1rWdfpx2imMygQ6moGEnkMZGgxd4JsUChBZQJa7gWQtY6rWj9EWKu4ZnUvL
         RvyYPJQ4AfPa1x7Jkg47/CK+D02/vYYc5k1aS+cPmbnHy3/7gjOIfSbxhMhXUc1EAAWj
         jEdA==
X-Forwarded-Encrypted: i=1; AJvYcCVfvA3RnaucvCPKa8taTI7NCRicMmSSuCnldxzK0ye5pOV4nl9ksLgELoVpZb7KocMFEvS/ISFvrBETOkY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxeu1JZ1KUUYiRhsEkq7PTD8o+b0CbmddgE63PMQDy8kWkhhX/z
	+HjbKwQb5xKI81DJYuRdjIFVFUxDo6HrGyJixB2Bqx5X2miO5Jj28tRaiN8gVC8=
X-Gm-Gg: ASbGnctLnBUCTG+nv6AmNacCTkhRDHAYh02zTK7MSwvLaSMXs1OSW+0J2jQ2o5wGzEG
	PbKChlE75xn5BBSsnO+uBO22cXDMS1fHKF25fSG6JaVspWgKHVziNrtB14oaVLo45S12F+M8AZt
	gXpTbTpYCM68+E05ztKgOqgXXxMyAvOtwNErOKu1re+oufAY9iIklgvNrjAEP87sfEBq+1jGFWC
	iYo8t4PaeyEuj614bqQKNC84sG6HTwX7SsU/O2me3rNiy5M7xIHSxntRTi1Ht39eQZi4DA5F0G9
	k4N8f0AwyC757ybqxLJc65V3jQ1LPuTZ3EsN2GomKw==
X-Google-Smtp-Source: AGHT+IF4hh9Veg+IIk58qFi6pjlWS2ZAX5o58ECRQ/L7f6BiUykUti8fmy0ZCXSRrfO7W5yaNMkpjA==
X-Received: by 2002:a05:6000:4027:b0:38f:28dc:ec23 with SMTP id ffacd0b85a97d-390ec7cc23cmr11200866f8f.19.1741048498138;
        Mon, 03 Mar 2025 16:34:58 -0800 (PST)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:49fa:e07e:e2df:d3ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6d0asm15709265f8f.27.2025.03.03.16.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 16:34:57 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 04 Mar 2025 01:33:53 +0100
Subject: [PATCH v21 23/24] ovpn: add basic ethtool support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-b4-ovpn-tmp-v21-23-d3cbb74bb581@openvpn.net>
References: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
In-Reply-To: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1701; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=BYLORm4A7rlyB0uoL8wRITWNqD/++CVET8EMPQpW32U=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnxkqQcek6cbeoSIsg03A+MkCeLuwVCiWKLWHmX
 Mt/2KkXxsWJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ8ZKkAAKCRALcOU6oDjV
 h9GICACjbEYzDHhE0aU6kVbqHnsl8XwqNSHG3ta2xZwGubqlb/z7LvUiu5+oSLaD3dEO4qFjhWA
 erCkkUXciN5JgMZ9f5mykiLvMtZN7+9/Z6bRRGnuX9QlO1cH9tm9x1VNVuvkCO708E2UX09y8fN
 /x0tOMBlkR/t999IxgxzSVKXrKHqjvX3jAoYo8X50JEI5r4x0DkYJ1p8BLyXArOhNuknWwkiOwU
 OPtuVW+hC80a7VT0I18A8dDiiSixvwHF7NmXt2aueicsRasb8ttQtSUdKJkyltECZdUIGSTGZma
 I2Q+cqT8aYiRpwT3a7niQroNki2XF/j4GUJKB2HLMuKXquBz
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Implement support for basic ethtool functionality.

Note that ovpn is a virtual device driver, therefore
various ethtool APIs are just not meaningful and thus
not implemented.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ovpn/main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index dd05d0fe7a2d139bda55ebd68b9e1d78f5c00af9..886601ddaf7bdee4761691d293274a61da204f2b 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -7,6 +7,7 @@
  *		James Yonan <james@openvpn.net>
  */
 
+#include <linux/ethtool.h>
 #include <linux/genetlink.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
@@ -143,6 +144,19 @@ bool ovpn_dev_is_valid(const struct net_device *dev)
 	return dev->netdev_ops == &ovpn_netdev_ops;
 }
 
+static void ovpn_get_drvinfo(struct net_device *dev,
+			     struct ethtool_drvinfo *info)
+{
+	strscpy(info->driver, "ovpn", sizeof(info->driver));
+	strscpy(info->bus_info, "ovpn", sizeof(info->bus_info));
+}
+
+static const struct ethtool_ops ovpn_ethtool_ops = {
+	.get_drvinfo		= ovpn_get_drvinfo,
+	.get_link		= ethtool_op_get_link,
+	.get_ts_info		= ethtool_op_get_ts_info,
+};
+
 static void ovpn_setup(struct net_device *dev)
 {
 	netdev_features_t feat = NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_RXCSUM |
@@ -153,6 +167,7 @@ static void ovpn_setup(struct net_device *dev)
 
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
+	dev->ethtool_ops = &ovpn_ethtool_ops;
 	dev->netdev_ops = &ovpn_netdev_ops;
 
 	dev->priv_destructor = ovpn_priv_free;

-- 
2.45.3


