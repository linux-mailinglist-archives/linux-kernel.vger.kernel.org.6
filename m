Return-Path: <linux-kernel+bounces-565293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 232E8A66556
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 02:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C71217C0BA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 01:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D92199E80;
	Tue, 18 Mar 2025 01:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Ihrb2a48"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B52D176ADB
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 01:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742262069; cv=none; b=UxXWRzNuezWO3JmCGhAA8z7mKE4msxbbrEInArRf5oWJwsi9+QWMceD+D280Uqflsvt34qwd4XGJhgOgNXPh87yX/HvVtOYJC/BG2K8TSm/ScZgjnr04QVRt4xbZp158JFhJa6dvsGyKr8o13YA3Ss2i167aAIsvTYpeA16gtOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742262069; c=relaxed/simple;
	bh=F7vNJswYuDrJOUluc+iKV+B1IKtUBw6UmYPNXP+K7Ko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EqXLEpScis7v/VRFvmcGi5Lk5pLRdJFNVIVnuB+G5P0OnCAF3O3juJEsUogZhKP7Jogc2JxuCD5Q5l7IaemZN37VYBJ4W7x6ud0VqhiTYY4OBGpyBzoYudZVQHBvvabVMuMVzXc3+OPK3kIOsTu4qz7+8UqDgFvl1zhrfKehcbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Ihrb2a48; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3913cf69784so4262176f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 18:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1742262065; x=1742866865; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UXngeC+tXo23/X0d6ycLIiWXJIi25bwb8m4uszQOeoc=;
        b=Ihrb2a48NGteG0Of2cXK80V0THfsDrqwQ8S7TgnA6Qd7FqCq/L0RwX4EJmT2n3Me9Y
         xPY31qkruLVLojFQL1y1vS5IVqo6OnboWfmiozcREwK7CeuiRceUQa1GIxg1yX26za9p
         YqNvDBHQ/Bl/KDfsxLkOLDtbHz6Y7xkyU5llIHOJ/rPu75LsIKc+v/MZyLw9eBG1X/JL
         7z4+sZGWQJlUlld8p+mUmHSEoQZrB1+Hq/P2toW6WkXv+hkXniPyIhNi9sZjXSwjKB6O
         v2MwiptLQvb3Dh3Tk/IYg8xKg3+5mTwdLWx0yjoyxxkwFUcHizADeMgaISjsBDP3Hq1b
         Xkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742262065; x=1742866865;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXngeC+tXo23/X0d6ycLIiWXJIi25bwb8m4uszQOeoc=;
        b=EqHqfWhsozPibrnbTZULR87ySQMMD8++ytFe264lhP0CioHnEJLtR1nJizl2KYWWcC
         d6RQb7WV9GApngc/U4698JMDTPg/2YU7AuRHGitvMejiXlDouwdmK//7Mn+gG7yT8uxB
         SYJr52oomT+cgoyH1N132PE2TqBQ6VNp/MkvZ5hjaXOeCRaadRKOqEdH+KI0GwzI2bFt
         c6zVxTTMQmgO1ZHaMrInCnoQ9P1gW1ImIAgniweLfRJUKm2XG3FpBzpIShSBIUesY9Af
         4OGxRqrBbHmEaUHrkmTLtK9b3sDG6P90EB7BfMRvtKZH1hP+jnwZ8wERUMw0EIBQeyXo
         dJKw==
X-Forwarded-Encrypted: i=1; AJvYcCWzr2OJTfcLyiox8j0ltcHBoMDrd4Y9soKP9V07vVQgpzfJvFObKRQ8eVSEmAir2G1gXNQgD7KZEOwanWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4XNpPHjhnnosnowGk7ZfDGp/nMFz1l54R5NH8kPwTzKM/7W5T
	3vjJf9xJKgRdaBeIWPkCLTReXmcPm9ma/1G66tFwkeCyqg5Af/arWcMG3Ur4zBbu6wtVay+WkuF
	U9aRgyE92V1bnxaPEuDq1Jh3Yzo5xkv6qac/a6XurC4aQfsuEGorTZrM=
X-Gm-Gg: ASbGncvf8pTzJHDnHL4mI+w/uZO6y2NrR4TCvq8hY1GkjBDgXOIG7aflr7IlUpRwk6u
	IbXoYA+41y19PjppdGgPshgBOs37/zzdZe/9TIoiS17a1T1bJitSS5pfEmTLLXWcXfuQOVk4N0K
	YpYz6BEaZ0B2HGAyxs5msN/O24MvFJp+AXD8lyhu+JHxAtkZ3XfvyuI8mPeSRN6AIXtv2A/ALU7
	EITr5TcJuhlaIs4qElJTs+QG49Z2u06b4HLYO2ZloeNgNWZ7U2vNHet8apEqC9TS6+AyLwqcJ0c
	8127VPifNV8GE0rH5z0G77RLx5jet1XdgEOUbZLYFw==
X-Google-Smtp-Source: AGHT+IGPV96tVaakTrMyHpMtxyYA5qx1H34HcVZaOckFeaODwHUP6905nL8TnMaH8rYevbGhVEGPTA==
X-Received: by 2002:a5d:584b:0:b0:38f:577f:2f6d with SMTP id ffacd0b85a97d-3971ddd4b07mr16061612f8f.2.1742262065663;
        Mon, 17 Mar 2025 18:41:05 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:3577:c57d:1329:9a15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6b2bsm16230838f8f.26.2025.03.17.18.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 18:41:05 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 18 Mar 2025 02:40:39 +0100
Subject: [PATCH net-next v24 04/23] ovpn: keep carrier always on for MP
 interfaces
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-b4-ovpn-v24-4-3ec4ab5c4a77@openvpn.net>
References: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
In-Reply-To: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1204; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=F7vNJswYuDrJOUluc+iKV+B1IKtUBw6UmYPNXP+K7Ko=;
 b=kA0DAAgBC3DlOqA41YcByyZiAGfYzymirIzQuk8H74N4mh1CgwsPz8MeddaklCb468hrTOUt4
 4kBMwQAAQgAHRYhBJmr3Gz41BLk3l/A/Atw5TqgONWHBQJn2M8pAAoJEAtw5TqgONWHc2QH/j+y
 zNppsiM7jdqhypjIPvZ7xdfmivRXMpc3lLTcFv3pwZvxrmbxvGgtGF+C3JdCaKINm1RGQRblsEq
 qrMmJanRAyEtc6twQMKtnKdZljzXyuNkeVxKPXiMeVSa6NPosHEROHIk5WxgvnLctN/XDeRIrjU
 zikbJIQfUX36ILsq6TuMOkVD0cLzvghbjQlPd9n4MBN9WuhdjdjSePnQSG/h/PDic6EGfqkBeCN
 H4uL4ykVMoVlY+BTiW7WSdxMlHTbwfEf6h+lo6LJyYKmyGo3SzfdaBraU8vNwghqQQt/rVQ14r8
 u08z/5vTQ7GGTdEiH79WJMJ50mVaZWi+bJqUBfM=
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

An ovpn interface configured in MP mode will keep carrier always
on and let the user decide when to bring it administratively up and
down.

This way a MP node (i.e. a server) will keep its interface always
up and running, even when no peer is connected.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index b19f1406d87d5a1ed45b00133d642b1ad9f4f6f7..15802dfd26fcbcad42c387d42f665b8b47604e8a 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -21,7 +21,22 @@
 #include "io.h"
 #include "proto.h"
 
+static int ovpn_net_open(struct net_device *dev)
+{
+	struct ovpn_priv *ovpn = netdev_priv(dev);
+
+	/* carrier for P2P interfaces is switched on and off when
+	 * the peer is added or deleted.
+	 *
+	 * in case of P2MP interfaces we just keep the carrier always on
+	 */
+	if (ovpn->mode == OVPN_MODE_MP)
+		netif_carrier_on(dev);
+	return 0;
+}
+
 static const struct net_device_ops ovpn_netdev_ops = {
+	.ndo_open		= ovpn_net_open,
 	.ndo_start_xmit		= ovpn_net_xmit,
 };
 

-- 
2.48.1


