Return-Path: <linux-kernel+bounces-367027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC71799FDD2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6771C27C88
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 01:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0179E187872;
	Wed, 16 Oct 2024 01:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="QsV42jwq"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5178D17C9FA
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 01:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729040633; cv=none; b=L1rg3TMltJwPzGX+Y5kLPSx51h468hqtoetOhnYlim8UQ2XXi4NE1PA4xFOtQUJPpTFj6jLwW1AEMEnZsA7TVNu1Xy3DITXwyPtmzOwjdDiIsUpFnSfdQNP1w38/0e/P/gnLLWqUcYO1sAtEETbyEifXkL5NZrJ0Fv/CjZ8x9xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729040633; c=relaxed/simple;
	bh=fdzF3OOmoZvBMLXtUajHYKsI45JNjgatz8aXU4UpXD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QsPoyHVLovofXe5mr1au7f0QpaBGzlujeWhxwRxqLcL24U9Qe2r3PVUwTaG7PBx5uqfrM1mBVTQOgOcGBBC6rPmXTFK9nEyFmUzlOG9ZMdmMj9I84G+pFzlZbzJSDGJp7MWVlj4HwoyufKBnruUBoRrQUpANwZ3ZMHd+74JBX2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=QsV42jwq; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4311fd48032so33835505e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 18:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1729040629; x=1729645429; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XbrFnZJaX61MB7xNUng7QgrtBfqDJUowzpqh7fH2eTs=;
        b=QsV42jwqCGaFrGox08Yx6k0niJguqMFeqlePDJd+cEUxDD58gnRWfuYmrSe/tvnTda
         RgF6NPd2K5A47VWHoDvCfqMIBedcvOQClhrh2gFwwwnrDP3pr/slgPJzor84NVCLpMLZ
         gynwrqAv+LR7iKKbW2D7veqTUWXhPaVRW8kzIFJmK+6UpsH14O+m1UUhlI4aAFuA5aPR
         ki/wRBJwWZil8v725d6ByPUz0ghZyIoYbyxYwE/qzThfj02qvrfQY78S/cnt2MMTXOA5
         FSBwzGsk1VTxvnDisLWwm5KiFCbtRc63Hon/GipYEXJTNc04fsu5aJhz4oDjUlor6QsG
         MvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729040629; x=1729645429;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XbrFnZJaX61MB7xNUng7QgrtBfqDJUowzpqh7fH2eTs=;
        b=HbhNPJp1axHmiHrKiOH7oNGV81+5fwIURxmyiXDap5Uq4IdAPHcK529OGiWtjc1+By
         xMlN+i3jDg9sjAjPrpj9udRmKlYO6ryYFHUuU9C72sLEgTSl974gZbeOr4G/W7aWs9vY
         jdtpEgu/eZqiqdKHTBS6yIuhQ7ySkynv2fN4rWok4d0IKhUXUBvfzsbvUMKDBvtzBL5L
         dSxYoHeSfwIpdgFwkyeEBsbM/+5qPTK0EgtnC28vxX4vs+pw4M3TymCaOK40RRh+M99u
         3xYQ5uZvRCIoNFE8mlPEKmfU8eofvFjtkfDB7F2JLnUrrR0C13XrqA1k7sWFULWmSRDt
         qZEw==
X-Forwarded-Encrypted: i=1; AJvYcCW3LnckLujY3jrPD2sYlR4IJbE3YKUaW+0YZrJWhZDy6BxoU/B2QY1cCdYCjzHJigWc1YK4jbDBMU2u/90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5YM8G+jCBbl0FagALhnn3uooAxsjoPOV20OyQj0/RdBk94K5Z
	iXqaBYR8RAoLev2b/Wjmqz95yHnzIBtFV8i5dqhPjkJxX4aJtU2RYTfhItudp/8=
X-Google-Smtp-Source: AGHT+IEnmJET+/tKtmD4N3aGzKGV26mdwP3+N26qkziS2iQ4M91Pcy6VsuNDGx9B77czVLSa40BH0g==
X-Received: by 2002:a05:600c:1c8b:b0:425:7884:6b29 with SMTP id 5b1f17b1804b1-4314a301656mr17181865e9.19.1729040629512;
        Tue, 15 Oct 2024 18:03:49 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:4c1a:a7c8:72f5:4282])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa8778csm2886765f8f.25.2024.10.15.18.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 18:03:48 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 16 Oct 2024 03:03:05 +0200
Subject: [PATCH net-next v9 05/23] ovpn: keep carrier always on
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-b4-ovpn-v9-5-aabe9d225ad5@openvpn.net>
References: <20241016-b4-ovpn-v9-0-aabe9d225ad5@openvpn.net>
In-Reply-To: <20241016-b4-ovpn-v9-0-aabe9d225ad5@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 openvpn-devel@lists.sourceforge.net, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1171; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=fdzF3OOmoZvBMLXtUajHYKsI45JNjgatz8aXU4UpXD0=;
 b=owEBbAGT/pANAwAIAQtw5TqgONWHAcsmYgBnDxDvTHnFs08ojTWCIYtTGaDcKU9BD/aiQk8ra
 20+m/SX2X+JATIEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZw8Q7wAKCRALcOU6oDjV
 hxarB/d7snZW+3I30+pGkneDkzXL+PpZTWCt2UX1AmWm1RzSct/CkRq3JNhptlkHNmwZcdaoACo
 FyaW93SsXWDoh8qpAPZ72pW/YZSkVwZftK2urpC6cP7fngRpbcJVxUaVWgT3AEv569LY+EuAObF
 Se0dd04K3S3PX1i4s4hL9cnSv2Jt5nnT9RLIg90G0Cbz7Si9p/4wLDLWbAYUqjZsNIdVIS1kGgx
 O2XA/ituOjrslh/WqIXix2HHqxhjTyIBokcZ6zJuykX6Snn9vSGhcGlHAZdhtCXFabfM79N1mPf
 pKAgpbwThr3UNkOorPKPhxcqqEsvquM7p2glA1OPWgDsBkM=
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

An ovpn interface will keep carrier always on and let the user
decide when an interface should be considered disconnected.

This way, even if an ovpn interface is not connected to any peer,
it can still retain all IPs and routes and thus prevent any data
leak.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ovpn/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index eead7677b8239eb3c48bb26ca95492d88512b8d4..eaa83a8662e4ac2c758201008268f9633643c0b6 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -31,6 +31,13 @@ static void ovpn_struct_free(struct net_device *net)
 
 static int ovpn_net_open(struct net_device *dev)
 {
+	/* ovpn keeps the carrier always on to avoid losing IP or route
+	 * configuration upon disconnection. This way it can prevent leaks
+	 * of traffic outside of the VPN tunnel.
+	 * The user may override this behaviour by tearing down the interface
+	 * manually.
+	 */
+	netif_carrier_on(dev);
 	netif_tx_start_all_queues(dev);
 	return 0;
 }

-- 
2.45.2


