Return-Path: <linux-kernel+bounces-558445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DEAA5E5EB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4477D19C0FBD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC19211A38;
	Wed, 12 Mar 2025 20:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="e1t+P6jG"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6241E20F085
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 20:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741812898; cv=none; b=LO85T42uOB/5ttI1Ek06RMmxFjghJqa2/LPsW0Ii+xlSCXEO6dszq3VdEanzo5Bb75Z+atF7szw+pM1g1zPoA2OKFK5wArm/1gQ+7rLjDeyUJyHawrL2r9efBpD5bwhK5yGLKjPUGwkrKy5UOwQDGBMKH1gRA1RQYR9OekmyPwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741812898; c=relaxed/simple;
	bh=Dpo86dcLuQHi+/ffLApLvGiDvMqBLBDHjZmNUI8Fgv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fOXSqCUOd+lbamfYJvwy22c/LBZt8skDaEUqVv46YjU4pAmeg27/8iAqbnk44wbmSIAdMWe9iHcZW1od+uiyXx9gzvIptaKyTdeIDkcq4TFA6SF6gPOANtcih1XJG2wJDy0QkbDyDz8iJnvjdCJYi0VlqykHlXh5zhUevdkYbUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=e1t+P6jG; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43948021a45so1864975e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741812895; x=1742417695; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7513MgPTWzlFUV4A94AszGTBKoC1WXOdZLnItud/+rw=;
        b=e1t+P6jGl3wMF5FSlXvgvVF0Iss/Fc8mWhTMw15HmWXgDLwOhM+QcYDHI0i0KdmTDv
         SQYcBokGzwM8tJ7YVp1g1umE+IUZblWjzD8J3t+BnOZH5dr9MYgCkar+oRDuGIGe2X+B
         aSVhBMNTe2R7jSrQeMFM25r6jYcePuibOgXLMmZTslpjJa0oFb+Wz/XkPr2JsygTGPRA
         8YVgdN3ESySQH75pyfK04wlUuMh8D1Dr43WL/yxFn0hgmvE1NwEd8E4zy31CyThhEcPS
         6UvqAONpfryfjpO71kgsIYQfD0FWwUUhnLmf3784v1miVbmIbty5gGmeivVZjZQMXtlm
         XLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741812895; x=1742417695;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7513MgPTWzlFUV4A94AszGTBKoC1WXOdZLnItud/+rw=;
        b=LeNy2GjU1tYPfCpG+OnvSMrBR9EGIEY5emK5ksdE3AcgeyCPKJgfeLUcPGaAML0e2B
         uJKS+DbtnLFTRzINY/yCLOaNbuqFZyZB/s4Qe/y+6Fe5QhgTmqOqNCuS7NoR075pfVzO
         JOwRD7v98LLICmetiVICPt1sNt7ZhXCaBp6+/YAdLgq1AYfZ75D5S9/NN/Z50hzqvpd0
         SQnT43gVe4k89+/trcvEtdobKkfYG0tIVQ5IXkM9ZQx24dA96d9E7OMtWxhcv9UD+q/m
         CSozqYVMlGorEzDNUXfX61v7Q3ODBLIiLyV9z2DPV7gpGfPlqUNTRTZwDkYWI6clSER7
         1C/w==
X-Forwarded-Encrypted: i=1; AJvYcCUpPkcH8J5FQD/DqBVWnXkrstvnDiw4YpNS64Xgm6LSRfpou4MhrdySJXhNGaeRSGG9nYQ4UAEUiC/5hBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMKXTRQp1brEBS1KHpKZ8nI0uEG5lyf/3qqMz7s7lDu/Eyk0db
	uGKDjysUC+jp4WBUWWh766OXzNaMa/npk/Coc5r9Ki0rjAEI1f83Wt0JtNPIGB4=
X-Gm-Gg: ASbGnctrqgZIuH1MqJjt6ejVtBTJdNxHhPggpAUUFdjdMK4FnDEEQ5PMCC0JwQuquQi
	Nw1KqEaxoWyTQx8gBRUjmZTR77AqT+KFekV+80BYpDuMCpvQQaT/+FCSByTLXmQ+uvko507jePI
	P+cIPw1/W/Dchbv9YvkfbfIRtdJO+yP1xe3nF1EJwNcrf6DPOQIkIBaq/LTNXg1XjLKf1MsgJRU
	kDmUM86mYqa1XkNrdqr16FCqv9aAsjyOWe/Cwxen2H0+onQmILxgyZMndC0ExRAQNcY1ikyotIZ
	xfmkI8E3OrllmHroxArWtKol9yyhh4Vzkf6j6k78yw==
X-Google-Smtp-Source: AGHT+IH/kshgwzxglJPwKrAa1snS3ry8t4cWbkAAgcEd/xr0yk1+5VRw6rILu3zf7gRip6TZlWajDA==
X-Received: by 2002:a05:6000:1842:b0:391:2d61:4561 with SMTP id ffacd0b85a97d-39132d32074mr15972310f8f.6.1741812894759;
        Wed, 12 Mar 2025 13:54:54 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:a42b:bae6:6f7d:117f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c10437dsm22481393f8f.99.2025.03.12.13.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 13:54:54 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 12 Mar 2025 21:54:31 +0100
Subject: [PATCH net-next v23 22/23] ovpn: add basic ethtool support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-b4-ovpn-v23-22-76066bc0a30c@openvpn.net>
References: <20250312-b4-ovpn-v23-0-76066bc0a30c@openvpn.net>
In-Reply-To: <20250312-b4-ovpn-v23-0-76066bc0a30c@openvpn.net>
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
 h=from:subject:message-id; bh=Dpo86dcLuQHi+/ffLApLvGiDvMqBLBDHjZmNUI8Fgv8=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn0fR8aqSB7lx1HJwyJKqqQs2g7lFa+Z1BOkSus
 EuHYvqszTaJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ9H0fAAKCRALcOU6oDjV
 hxKvCACkR93Kaizq6szy04ebmeFBuVC792qFUfBO/SrBK9k9STsuN79Rp5V9jCLB5wA+W0SEC8G
 zC1TWi0YYCW4MuRB++3yCv7IV3CAusX9vBondr6Hqtk3WlofpPGiS1ZViUGukDZAs87G/pME0VZ
 bWQVa7ZL1/7NEr6/LW+B3WEL8sBxCO+MEH5+6Zmes+voybxNntW1yeUlv1b6947ot5PATcc9xYS
 rLZrmbk72va0fCnzsut3avujRAEBXXF5gUnySFUNQK69Uj1eT31WRa9zxkcBRXoAkSvw/npDwCQ
 ZxTVEwY+b0vG7JlL9qK9qSXM1T2BIjKL42NY/aCgl0zzNHuf
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
2.48.1


