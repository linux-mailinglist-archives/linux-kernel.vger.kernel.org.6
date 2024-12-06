Return-Path: <linux-kernel+bounces-435673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D60B79E7ACB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9165B28298D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069E222A1E0;
	Fri,  6 Dec 2024 21:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Zne3Ld4o"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1314227562
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 21:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733519952; cv=none; b=TDe3fdsrtO9CvRn7U6PoyOGXl/4MrrDEhBXzs577Il26JNQBaGFnhcEcAsAB49xi1qsH/6bb0hUR1i4XsPA4ISCRb3gO9OK3lebQe64NdJOcmrhzYTgy2aWzsym7qjDIjQzavOaQ/TlreLV8q5BnRvj9lQBVruveSZjlb5Usl9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733519952; c=relaxed/simple;
	bh=W5T+iVYKaPmO/gOfKB0RnKXCUMfDvh3g/zI0cvgMIlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZIO4SYmFyZHWIPLvEBo8kb12nerd6ha6kOjwbtAfFqmJQ1V5hLPeBwXFpUJyg0LLnARp0WKxlYqK2wAeprUFL21l00Z5lmI4H8jhrrZUtSQ4xsb28bnw9HJReJJqX0ZpJi4JM5HD36XpVvcRQ5AUhCrFD+2hLAF+VqpPn59++VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Zne3Ld4o; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385e2880606so2141630f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 13:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733519948; x=1734124748; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jb7KHSQUPGhy5o0HEst1Kbqk3ULde1AaGrsUDUj2wbI=;
        b=Zne3Ld4omp0u1ceXyw8A35ex74usasrP5gPYSoT4Q7bqaA96jPkbJnVh4iqfD7WbJI
         zIgS1EMp41wtZ9a7964cHfUFpE6D/YHdT+esDb4PLo38ZyZn4fE62d7Tsg/hsOEiYUN5
         HPc2M7smr47LhwcurPRUtxIlADHaxtcgAKyGKWAnTx400nNuO1hTJX0E3nKBVn/1LZb9
         C0fW4vBIbAC2qUgeZrQkDFoX94rFWVraAQ7aFv8oL1g0bZ88qhcNcdDMMQAKA/QdY53g
         i4f9KEbhdpzFSZid+I3ckcim/TNnYXxubOnVcOw+xi1CudtIXNxops9Cpq8Aoi6DIIyU
         PVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733519948; x=1734124748;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jb7KHSQUPGhy5o0HEst1Kbqk3ULde1AaGrsUDUj2wbI=;
        b=IG6VKEn1NgO7gYbjmCo5t9fO0EAyWF+Cs1YxUvpVRFaKUfNM8KqLB0ghZwaMcFx9os
         V/+2veXe1wW8WIJe3E0q4yqZXXEBmIZ3ibPKguiIg133xRbot/qczn20lkI835vIOBZe
         Xhe60+0+daTCmhZFcU86UQw4Mg+4J4EKD0vZp1R884COKQYaPaP2xyr4eTVyk28M1Rkp
         6I8tQmVcdmbzsN8OMjBpEZ/vgClQzsKeryNBCdCjcL9p+7HPs7zXOh9trdtuWuqDEhmo
         wD4+luzIHLxW4FGWRqgCYDHfKsyW9K5sM9CvPgGUY7VyVcrNXw9QOlxROVIc7HlKcCXd
         WLqw==
X-Forwarded-Encrypted: i=1; AJvYcCX9fjsrGcbBcb8pTosGa2qzZgojxJ88UxChnbENLxj3vZBtZBJkhKe5soHuTD/6dINcQzcUtnXPFstADdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQfbZCFsyLH5J5EN/5Gq2xzwvsSEx39FQYEzEcM5EtIWzjy/sg
	Srofq9eRWG917LPM2SxE6pCZ9wr1geFFds+BBXLQNf+PKil8KQes5LBwtGq/djM=
X-Gm-Gg: ASbGncs1gijVwOE9sw2UvB3C3fq5TXOMc1jMzxj2rV5IaTgz1OjKFjCS6a+WKswDQ80
	U0tOXi5PiFpGjxaSvE31FClXRDPYvmXY5BdojQ2PLV33oHwP/KMXmCgEFO51rpj+YIAVDcEhYai
	oz8CZKTuGqfUk3nAnRm1ij1PJyCD9H/OYygHdjc327DQpuYZH3VdU6YXK5HVf9Mh3McJRzdaMZf
	1gI5MCUiJG3zGiM18yQCn9whBtUJc+8YCe4NRRHub4Gy8DP9lPPnHuDwXBqCA==
X-Google-Smtp-Source: AGHT+IFUtBqb3ICYhyZa/SFeIsmZYtiFaEEpUP7mRnVfVvusILtWZUJ97EnWxcGKIqTG8boUZd0yKQ==
X-Received: by 2002:a5d:6da8:0:b0:385:ef8e:a652 with SMTP id ffacd0b85a97d-3862b3e30fcmr4466988f8f.56.1733519948055;
        Fri, 06 Dec 2024 13:19:08 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3cee:9adf:5d38:601e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861fd46839sm5441302f8f.52.2024.12.06.13.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 13:19:07 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 06 Dec 2024 22:18:46 +0100
Subject: [PATCH net-next v13 21/22] ovpn: add basic ethtool support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-b4-ovpn-v13-21-67fb4be666e2@openvpn.net>
References: <20241206-b4-ovpn-v13-0-67fb4be666e2@openvpn.net>
In-Reply-To: <20241206-b4-ovpn-v13-0-67fb4be666e2@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1699; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=W5T+iVYKaPmO/gOfKB0RnKXCUMfDvh3g/zI0cvgMIlg=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnU2pYBycUwK6W/nE4hHdW5xggEUD8kuoUUo8gu
 9HG8BxqBl+JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1NqWAAKCRALcOU6oDjV
 hybPB/4k9l+J3Qty9sNx9W5Y2YX/fymwpsUVnPDgaDRnZtPee0VGl3vRei/dAAn6ualWkoOXe79
 BRUs/eZSjNSzsFe0rQctYAx87mdYLv+vU/0dCj+mSNtNTffTUvbOYopXvFJNMMM76cy9dK8LVUm
 9CbsbvMM1ZXPct2BG8jTFJgTuLN2atJSXUZjjEH7ytvaEpYjNFUw2MbOWdpeivblIhlbZ3sAB7f
 VFRC3aLA5YB8MxFGXdiHUcJHH9JkOxkSrc/HOFs5KQqwOtiYlBNTnN3uSi9fc3LFMhJbuAfVf60
 1wiTXMUJH+hHZvMPaPAzCG+CrFUdF9wb2LmMTMO+6cZmOCGS
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


