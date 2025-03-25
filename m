Return-Path: <linux-kernel+bounces-575391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82D7A7021A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 288353BFDF4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7552025D52C;
	Tue, 25 Mar 2025 13:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYKwsjYa"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1932580CC
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 13:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908281; cv=none; b=I22mwZjfHqP2V0vSckngqIlBJ1K7sTI/YAmNS+CKQA4CbSSiZCHWD0WeCGWlEAMR1HyGkzvT9Th15jcTs52ftn6/qJq2WW+Y3dzXnb9za3w9XR6EnsolRpEmI3JJ41XrbP6gmEMSpsNKEy31uwD6dVFMpNEufOZgGBgHvYNop5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908281; c=relaxed/simple;
	bh=edJ4YRNsOE/0C0ggXJSB0i5UyziNkEAhkYdp6Koq6L4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KAGgMatdmT3sCUYfoHlKI+99gBksf+y75UcH1sLDn02FC8HG8b/U2gM9TqTMf0FAlRKqnXW92WL3eQNedP87BjWP3DdXFovRalhq4PkTh0ZqubrEZFUZJFEyzlm6finSK1SvUhPz3+OOUBtS5JOWMRCfdbx5Bnsx/PwJp9k+/Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYKwsjYa; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab78e6edb99so785305266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 06:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742908278; x=1743513078; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zxm3ckLosiHCJw//iFVWkvyQ4kCXQJFNmNppDxHYSU8=;
        b=QYKwsjYauljhJKd4WWpRzwi3KgoyXFNJPBQDEvxhgQERtN0BGWybiwxR0+FNAEGfah
         2eXQb4TSt2MYES1rn4+KZVaACRo64VGG8QP6ABviMzGBpIENvpoXF3HMUmcO8X+dx4gO
         axGF4+K1BcLo5PPKXQUB7efh0jo543q4ako0EWfmlcBMDXKmjd8iODTMKLHjb5lu2oIl
         JGHCL1CMkCcrYMjOLw9alEgMTAiFbdJq4Pn6bx7G792USh5iCM8IquSWwyZxClgQexMw
         mS8NWC8zFkIAX+iWOktJwqjVtTWeTteUBRGyfcMtbT/9BFUQFG0P6sNKGow1vlmGTwC1
         aiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742908278; x=1743513078;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zxm3ckLosiHCJw//iFVWkvyQ4kCXQJFNmNppDxHYSU8=;
        b=Vnyilhq6nzR3gwxeYiE+RjhwnbY1ofVEa4pN+9iIbf+6xN9b1AwZ7VYlNhY94UT4PF
         IDj8Z64L4f43XA6puATJIyF38q0pxfr2PipJagYwF6s4K6Ef4L28ZQKtYNEHp12AVbxG
         3IQGat9OUQRk/vOEAq/D0n1fj6pKSF9qJ9hjopr/puF5QOWXcnJvD4WB3QmwHkuXtw7r
         JxbJZ5C8ZYFLc4WyfWn+vVBMTo8pPjnYgNP2nQS7MFJozEtPKO7DqgP/5Gri6u0hrA25
         6iiSwS1bPOYIeS+RZCbfiiSW8eGJdutk2CqzCXPb4Ik1EezbDDV6WNABM1vjDyrdaJby
         a8vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXoriOJTyaJ6ZatApzIClw9Qb/yTTFt1rkQXrfsMoYVDOeKcNPiLSY+MXCPCM4NPfIxrIjO1W1vJZxKsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvQX+O0ImqgDidmOEDlpSCpHFo67pQKBAtVDkhA0Qcy439J0l9
	jXRbUPj2EQrBVLxmqQx4X1obdJmxLCpd/Qxv0c6XqU3iN59CwNMyn37j2FGO
X-Gm-Gg: ASbGncv0eIHLCqSfr1Shder0ZatmxHTRrzWAhkvX6E+9AvOaH/GE8uVgTTlvXvkFWeD
	5U82N+q8/8cyeKsKb88u5YI03jzwpX80Fff+jMEjbql5Es30tz6TJ88g9tsycf+m7IGsrvHpooD
	43Ky4ZCfOPbe1lE282UyvBHLGjYPU9nw0BHc6haQhUw3xJTxjZPogFee1ZJL7eHKRTjZbOB3ahq
	Ek1SvRvUEg70sFVAEW4EcIprBRmWZo9iAnDRSFVIT8mv+2Yg/22vxbPnKLAc/QGsjQqrWehm7DY
	ajvRD/0echH47MgHNl46dAxzrO7R6RCklN2w5Ws3UXzsW7IVmg==
X-Google-Smtp-Source: AGHT+IG35J5bN+CEAXSSLE8h4t/YPW+a8XkdcaJSWu2ijuFgpXQb9vgmpH546mPppv3DaCUfHTisYg==
X-Received: by 2002:a17:907:ec8c:b0:ac3:84d5:a911 with SMTP id a640c23a62f3a-ac3f224dc86mr1660857566b.28.1742908278079;
        Tue, 25 Mar 2025 06:11:18 -0700 (PDT)
Received: from HP-650 ([105.112.117.141])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efb658b4sm848739066b.118.2025.03.25.06.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 06:11:17 -0700 (PDT)
Date: Tue, 25 Mar 2025 14:11:04 +0100
From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	outreachy@lists.linux.dev, Julia Lawall <julia.lawall@inria.fr>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: simplify if-else block by removing
 unnecessary braces
Message-ID: <Z+KraOo2DfmH5zMX@HP-650>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The if-else block contained braces around single statements, which are
unnecessary according to the Linux kernel coding style.

Remove the redundant braces to improve code readability and maintain
consistency with the rest of the codebase.

Reported by checkpatch:

WARNING: braces {} are not necessary for any arm of this statement

Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 0ed420f3d096..53d4c113b19c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -988,11 +988,10 @@ void rtw_macaddr_cfg(struct device *dev, u8 *mac_addr)
 	if (is_broadcast_ether_addr(mac) || is_zero_ether_addr(mac)) {
 		addr = of_get_property(np, "local-mac-address", &len);
 
-		if (addr && len == ETH_ALEN) {
+		if (addr && len == ETH_ALEN)
 			ether_addr_copy(mac_addr, addr);
-		} else {
+		else
 			eth_random_addr(mac_addr);
-		}
 	}
 }
 
-- 
2.34.1


