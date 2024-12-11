Return-Path: <linux-kernel+bounces-442165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B23CF9ED8DE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10E60188C921
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5197C204585;
	Wed, 11 Dec 2024 21:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="M7mbb5+x"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AAA1FFC74
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 21:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733952796; cv=none; b=kD0AJDq2ZEINao6H4it4wZbs3b771GptM0kImF904NrNUzGl0ZRgXKbQ8rdjbHrTzjTvrjzlz4Rjlw/NXaz7DlIqvVraKNpTXvmYJw/M9SQvqulrcHhnej9EFrszai1767rYTf4xWFnbBEKFgUGNIuEyGsesQnT0pSw7ypiK/9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733952796; c=relaxed/simple;
	bh=W5T+iVYKaPmO/gOfKB0RnKXCUMfDvh3g/zI0cvgMIlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uc8+LD+MKeI6/dIYxIv1Iu7vWaSMecjhk8K2FJI3KLY93Zc5jdsYUO0rHrTT3iUwNgU7GMqmm9eyqlCRALrAOO9lW8PeH3CI75A/00ttkxZ4fAw2ak31tDdDqL68DSQsDuC9h7whcObLtp2WbeQzbTB+oppRRNiNE4Nfh+x7Vc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=M7mbb5+x; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43623f0c574so247315e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733952792; x=1734557592; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jb7KHSQUPGhy5o0HEst1Kbqk3ULde1AaGrsUDUj2wbI=;
        b=M7mbb5+xRt7lgrWvQoymuMAr0sAxHLDDlmTuGID82vdbXtLsILdhlbTDtgB59R2dvc
         UaJONjx/5ITIFISBXuXkBqjPydhL/SYoyeK0oW4rLzjDV8QwQ/tL1/t/gqFpszAj6Xij
         5alMFQSe0b1UbS6hphb3VMin6IExuHKX5yRG1as6KFEAwrAGSGpTShdeeM6EQivcLGvv
         CmNAen8croWJFXSg/sgM5NLdWRyfRChk5ZGhQCHVtV9wWPTrQ9MDTRJ1TrT7Uq944hxK
         DQ1ij/lSaTL+5hP5vDS7PmQuH9Yj5ATN4/ofYvOEC9eTTdZVShDAwCsjo/QsV2u9M1Zs
         Ns6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733952792; x=1734557592;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jb7KHSQUPGhy5o0HEst1Kbqk3ULde1AaGrsUDUj2wbI=;
        b=XE2aZEnb/nEKS2yIgsF95456wxZ2oyYk8zczepHcrSg8ADPwHmAbUPMl198nPHE23s
         jn2Hq+NKJ/00vAPv55Zc/7bNTyeJQNKNjQfEfb+SYK2kM17ORox6G3zVW0Ko1b+8kTWT
         UB9z6MytafP+/IsdMpQHJql/lJZXCrDLDvNxDfouejWVJUVmJlQuJ2jINS8GuZ/LMe8q
         6TxpqFZR5aW1vp6qPgVtwDx9eeWFr+IiGDJQvZFp6tLgEA2xoZRhzAjOJK6myDXujJd2
         AoKnpZvmqz9JDYEb8kNxWCC9QZ+v4MuMj+OfYsQFG9qMcnfa2HlJ+d/dKXizkHvXHmL+
         QavA==
X-Forwarded-Encrypted: i=1; AJvYcCUN0a1MgrwX0JlIltBGXNTGqtrwwZINI0jMWv0GK+JSdINARoIjIdrzkKy/kyhGwCmaj4LuUOesOmdkqjM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywikl6OIF/sWdVVKR7tKtzkeoWCFKpraU+XX68FuXXRBbDv3Nc
	40jrKqQZlyqdq8eM6EO0rShXcNnqCfjaktz3o2Wp89GtZzgh1DH+WUHRoonzUUc=
X-Gm-Gg: ASbGnctpmS2clV8/wcSmwe4ywGOof87zswvVeEZbg15hGdVmP2oIysJqp6gRx9Z58+u
	+1n1/zfLcQ4BFOWDkfHFCa2BDmm2XU0uoPppaubOHfnE32T9upudp1UCDPk7DhVbl6UDyes/M+1
	o/XEq5qo7QOMkvrZq/VSj18e0fPYmHfFfEyvmN775LRUEWled+GMr1mypUTvhkeKuLEQCL3ISh3
	wZWZmNXglLdI7AIq02X3Yd119ci6HMyy5TGSXGADNfmyenxnCnuyChzrDCqs+mc1w==
X-Google-Smtp-Source: AGHT+IGJ7suUDj6Z1NJdGOjPyyYIc8vYELxukzBuQrivTkK/7/QboQsQXKwY9N9oaOGHmLD/Lihq5A==
X-Received: by 2002:a5d:64a1:0:b0:385:e105:d884 with SMTP id ffacd0b85a97d-3864cec583emr4039605f8f.46.1733952792431;
        Wed, 11 Dec 2024 13:33:12 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3115:252a:3e6f:da41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248f5a0sm2136252f8f.13.2024.12.11.13.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 13:33:12 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 11 Dec 2024 22:15:25 +0100
Subject: [PATCH net-next v15 21/22] ovpn: add basic ethtool support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-b4-ovpn-v15-21-314e2cad0618@openvpn.net>
References: <20241211-b4-ovpn-v15-0-314e2cad0618@openvpn.net>
In-Reply-To: <20241211-b4-ovpn-v15-0-314e2cad0618@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1699; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=W5T+iVYKaPmO/gOfKB0RnKXCUMfDvh3g/zI0cvgMIlg=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnWgUnxlhYxePqNft3sn9hS8m+EGz+elik0rcEM
 ZGKsMwRQhuJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1oFJwAKCRALcOU6oDjV
 hydWB/94V95L/EN/+b/96zCxcdN/3V8wNf+Hh/MNun2+yxX0rW/71S2DK1QbVtSvqC00DhexXEb
 /vF8ORs7HKo/tGAoVimcvRilRfumegk/itHjoGVX283RXnxaNY/Kp0UoP+NX1zgUki5nivRJbFc
 S4jN5RmLz7GojPZSiBcd8Jy8KJslxzHXbjCLfWutzRSuQ6Kp5I9pkvhs3emMNPx3ZS2CD7Ihhpk
 pLXUgyj5lJaRHQjL4W4xBStgR0asf4xSr/IAZ7u3Ue+AxhtXgpkgznF7m/kdfwxAGnv90SA4ZVd
 OXZDrdg4ak8zeV1SsyakpW8T3SvfSJF3AzeKvU1bwYnJv8o/
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
index 6b3a59e75e5aa918b28957c073990be9fb1d2124..6a828728d4f98f84e39ea429a8b76069c6d83e69 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -7,6 +7,7 @@
  *		James Yonan <james@openvpn.net>
  */
 
+#include <linux/ethtool.h>
 #include <linux/genetlink.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
@@ -94,6 +95,19 @@ bool ovpn_dev_is_valid(const struct net_device *dev)
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
@@ -104,6 +118,7 @@ static void ovpn_setup(struct net_device *dev)
 
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
+	dev->ethtool_ops = &ovpn_ethtool_ops;
 	dev->netdev_ops = &ovpn_netdev_ops;
 
 	dev->priv_destructor = ovpn_priv_free;

-- 
2.45.2


