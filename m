Return-Path: <linux-kernel+bounces-517094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56356A37C08
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 571B116D9D3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 07:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE2E1A3150;
	Mon, 17 Feb 2025 07:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="XoLh2itd"
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5D3199E8B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 07:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739776741; cv=none; b=XP0C4FbOe7dPGvItYruxPkIz2moapVMPZ+hbCvQMaLXktHVUi3zk9ZSAbzi4D6itUU8K6bKSmAasgxsiYObIuajxz5mndNTG6Rtr6U7l7r566jCzfuWiTV3gUJ7sytCdOf0A/RB4dF1LjAk/hXgw3TSPbgzVqoKkFbOzpr+24j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739776741; c=relaxed/simple;
	bh=dnDgHpwmNAM4El0fmPzxiQAyrovPX9sKfPKrFaww9hI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mmeeG31KIuR9Rhr7PGTAtJI6inyQ17ZxQwCNdQ1ORt/e8LiH7E3m5Xo0cY9ZP0CL+DDL4ES1qeS7r9qGctCXoKalaVn5gu0JC9W5fmlI/ksATUpFxwgt0cqqsGqkcI1+uaMOu/F8Q5uUcK65eEXaHC2D8+OhEQ6bGqgmm9Nu1gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=XoLh2itd; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-2f833af7a09so5814721a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 23:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1739776739; x=1740381539; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8cBmh37uPVBcmhlXxEMy2GuaEBsjFiFq6M7nLH4l7tQ=;
        b=XoLh2itderA3sMcYcj1lLrEEPxV/68549ZwNitqYoJ5slUHqym2f6FxFodgfYI/Soc
         p0b1exURBbKWNgdo1bSNrd5/99+DJoh6BJgKDSyK0GLFUtH/WqpOXRx/kkxxoy3Gv3xX
         3RXoSI8I8044G7/9Z9ZOkm6JmyTmwztHJ8XnNWpXB/uX1H4D7JjFAsYVOZveOVErt/tD
         2X7Ta/qrqdIgghs0vJGTUfG/Ogj8Y/R+QVoif+4SjfQppsRzlXl/1OG6Ygzh7+oTR1XG
         q5q6Zh3XifwmhFeZRTD93s2o68ArWgFNiubXnQPOW71rPKqZ53udrPied4HkXxCZuU1p
         0GBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739776739; x=1740381539;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8cBmh37uPVBcmhlXxEMy2GuaEBsjFiFq6M7nLH4l7tQ=;
        b=LnfJHZT0Ik68dFBRNVf8EREhIWyAhn0n3w//yXo2FrUlGSdFqenc7tcAHhfd0OgthD
         kohIjnHq3vDEgq7vBHAN6OHYsxd5VbuHItwn6jmidmRJnJ8KkqM4mBOCZoObHywnBDQ8
         VxJeScxbTY0slpXDeTT6SDTnVu6kYAXiEPWwNASNL6uvM05JA9zow7emO3uWEdfc0wyR
         FxM2tq199rB6aKNXU/xBcTYddDsVBfnxY8h2E/RT3DVC87pUpZJWE8VeRMdpiSVduK3s
         lWkfUaxmw3yqte6IdeK/fNmMZAc/x+vTNmGWIXlW18pn1ltXpBNUPhjs/l9nAil79nEA
         7rAg==
X-Forwarded-Encrypted: i=1; AJvYcCXcdU2KDGAao3qSp17LLn4vjHGcWucopVbThPcHTJNgcfh/jn7HLhgQtxrO4peFqRDEOAZ2RfUn5cslvNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjfqtRM/cPK2vodYE6reeupcq8Iv0WjH5Vao7emQqNtqamPc68
	8kW25ltO7HVO4RNtFrG4huyO9Cq5ckzfn0H193gGKnfNJDm1Yn1Wp1zQEXZasq5+r0y0ncnrM30
	Riz+pqZZ9isdvi25KZUshTNCd7BhXk3PFk3VYwVr/JaFXv8U8
X-Gm-Gg: ASbGncsD0HoYcRJ15pvjeNphVYPMvbkcxFr3kSzGy8rtIZ6LkE5kcsbNEV4ZjEeEebe
	wIyFgNo4+z2buIR2jFnOcX6cogDmpFDbo6rblyL9r8Ix+RCMXpX+2cFA80OeO5n2jkHrALbuChA
	4fstqkeinA7oCe9WQ1gvSp5oO0kt/c3Zeqb66siSmThNYkoneIKVIh8owJ0OOIerDR2ysPJeOMy
	N2fQ6vRDyT3iYCzMazf4oLdPE0K6bUPg7MHPILAIQIhxE/tb30n1JSLz3YVz4RzmbeI+K3NBj8w
	As6MYAizA0C/kuL2xS0PZECW
X-Google-Smtp-Source: AGHT+IGTZ3Pw8uBs5dET/+qPFQerIYgP72QZp+sbHdWicZ0OeWZxKgm7kdMPv1hA6BlZzyPlOmeJ0DZjY9YI
X-Received: by 2002:a17:90b:2248:b0:2fa:b8e:3d26 with SMTP id 98e67ed59e1d1-2fc41154ca5mr12278543a91.30.1739776737254;
        Sun, 16 Feb 2025 23:18:57 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-2fbf98d473bsm695853a91.9.2025.02.16.23.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 23:18:57 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 8E6A93406EA;
	Mon, 17 Feb 2025 00:18:55 -0700 (MST)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 7D4AEE40402; Mon, 17 Feb 2025 00:18:55 -0700 (MST)
From: Uday Shankar <ushankar@purestorage.com>
Date: Mon, 17 Feb 2025 00:18:44 -0700
Subject: [PATCH net-next v4 1/3] net: Add non-RCU dev_getbyhwaddr() helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-netconsole-v4-1-0c681cef71f1@purestorage.com>
References: <20250217-netconsole-v4-0-0c681cef71f1@purestorage.com>
In-Reply-To: <20250217-netconsole-v4-0-0c681cef71f1@purestorage.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Berg <johannes@sipsolutions.net>, Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-wireless@vger.kernel.org, linux-doc@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>, kuniyu@amazon.com, 
 Kuniyuki Iwashima <kuniyu@amazon.com>
X-Mailer: b4 0.14.2

From: Breno Leitao <leitao@debian.org>

Add dedicated helper for finding devices by hardware address when
holding rtnl_lock, similar to existing dev_getbyhwaddr_rcu(). This prevents
PROVE_LOCKING warnings when rtnl_lock is held but RCU read lock is not.

Extract common address comparison logic into dev_comp_addr().

The context about this change could be found in the following
discussion:

Link: https://lore.kernel.org/all/20250206-scarlet-ermine-of-improvement-1fcac5@leitao/

Cc: kuniyu@amazon.com
Cc: ushankar@purestorage.com
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/linux/netdevice.h |  2 ++
 net/core/dev.c            | 37 ++++++++++++++++++++++++++++++++++---
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index fccc03cd21646fdff257a4b440d60d44ce575053..d41c5bca896e9f463b539ee8ce6b48d29b656265 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3276,6 +3276,8 @@ static inline struct net_device *first_net_device_rcu(struct net *net)
 }
 
 int netdev_boot_setup_check(struct net_device *dev);
+struct net_device *dev_getbyhwaddr(struct net *net, unsigned short type,
+				   const char *hwaddr);
 struct net_device *dev_getbyhwaddr_rcu(struct net *net, unsigned short type,
 				       const char *hwaddr);
 struct net_device *dev_getfirstbyhwtype(struct net *net, unsigned short type);
diff --git a/net/core/dev.c b/net/core/dev.c
index d5ab9a4b318ea4926c200ef20dae01eaafa18c6b..19c3eb015f2a5a19faa0a1afd6c74f7e12546a75 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1122,6 +1122,12 @@ int netdev_get_name(struct net *net, char *name, int ifindex)
 	return ret;
 }
 
+static bool dev_comp_addr(struct net_device *dev, unsigned short type,
+			  const char *ha)
+{
+	return dev->type == type && !memcmp(dev->dev_addr, ha, dev->addr_len);
+}
+
 /**
  *	dev_getbyhwaddr_rcu - find a device by its hardware address
  *	@net: the applicable net namespace
@@ -1130,7 +1136,7 @@ int netdev_get_name(struct net *net, char *name, int ifindex)
  *
  *	Search for an interface by MAC address. Returns NULL if the device
  *	is not found or a pointer to the device.
- *	The caller must hold RCU or RTNL.
+ *	The caller must hold RCU.
  *	The returned device has not had its ref count increased
  *	and the caller must therefore be careful about locking
  *
@@ -1142,14 +1148,39 @@ struct net_device *dev_getbyhwaddr_rcu(struct net *net, unsigned short type,
 	struct net_device *dev;
 
 	for_each_netdev_rcu(net, dev)
-		if (dev->type == type &&
-		    !memcmp(dev->dev_addr, ha, dev->addr_len))
+		if (dev_comp_addr(dev, type, ha))
 			return dev;
 
 	return NULL;
 }
 EXPORT_SYMBOL(dev_getbyhwaddr_rcu);
 
+/**
+ * dev_getbyhwaddr - find a device by its hardware address
+ * @net: the applicable net namespace
+ * @type: media type of device
+ * @ha: hardware address
+ *
+ * Similar to dev_getbyhwaddr_rcu(), but the owner needs to hold
+ * rtnl_lock.
+ *
+ * Context: rtnl_lock() must be held.
+ * Return: pointer to the net_device, or NULL if not found
+ */
+struct net_device *dev_getbyhwaddr(struct net *net, unsigned short type,
+				   const char *ha)
+{
+	struct net_device *dev;
+
+	ASSERT_RTNL();
+	for_each_netdev(net, dev)
+		if (dev_comp_addr(dev, type, ha))
+			return dev;
+
+	return NULL;
+}
+EXPORT_SYMBOL(dev_getbyhwaddr);
+
 struct net_device *dev_getfirstbyhwtype(struct net *net, unsigned short type)
 {
 	struct net_device *dev, *ret = NULL;

-- 
2.34.1


