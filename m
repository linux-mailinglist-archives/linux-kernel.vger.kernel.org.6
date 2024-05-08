Return-Path: <linux-kernel+bounces-173075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC738BFB32
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF2051C20FFC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694A281729;
	Wed,  8 May 2024 10:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="aX0Pcbz3"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F1D2836D
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 10:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715165004; cv=none; b=cOer8mCcDJaGdpzCEuG7zmz6VIDgQ1Xll7pm2zHgPemTkPMRB80oLO6Xdbb2NMN+iweDPD4BxjltBUpyt9GF3zfRdBSqt3Nl+XxaXHfNSExkX6vDM28gDbYi3Vk3KZriuIW9uZ7ctD2p9vlJ9BpORjxFdXL4eghX+gnO4K8He9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715165004; c=relaxed/simple;
	bh=AdV+B9yUmsPOyuDJKdAkNFoSqAGDd/uKzuOMYP2Y0+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dwQPM2SG0DsKCPn6uuEXOqn8Vq61zu/OBBtWB2P+QKUPvhF2A+6c1/0mnC3CC0AnPSs1/rvFqs8S6O9c0B0elcYqkr9IyiIEJJasDLBCD6TyY30Cwg5I6Izoyq+NEYpxMAUL+9idIKlegU2ZTt+fFgpl8KGZihAzwsFe0a2ye3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=aX0Pcbz3; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59ece5e18bso482773066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 03:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1715165001; x=1715769801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AImnvo1Yv6QQBwBo/PQQOErjpEng1YiXNlTdoFkDN/c=;
        b=aX0Pcbz3cZtlC+JPuc+tv5udwZNr8a+ZCWod4bNrwhjpnrQo3P/VZokOotnZ4x+mub
         KduD1gxBJlib9CH82f3v2k6kzTaD+rcck8xFhXxGsopNg0/Wcs+/WlPQLabt4fQYCbI9
         YyrtpkZr4Kg46dqK/B7s/sHh/ikocit+fWYJFUugPE6MgNNia0bXflrezUKZ95PsYv+k
         nwA0phSYoY7vRPKGY3F6aHt3IfEcT7JM1Q1dXADN51nP47KwE9FpR8kDyugLYwVpElRp
         52vt8uI4uE2FCOnwpDjgY/VOMxkwsIkYWvdo76Rsd5ns7Lp23OdnUwuHQdUcpH00P/ex
         6bUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715165001; x=1715769801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AImnvo1Yv6QQBwBo/PQQOErjpEng1YiXNlTdoFkDN/c=;
        b=rJIk4W4x874+kB7ykd0Fq1nqZ7KTjGDNBvQPUqU3gGITIlSz9pTTm9nH72ChtFElcy
         PwCPcRGNFOXZBHTenxV7CSYpv7GeG6MYjROl6aHcEhNa3yC5zgpUrQ7dUA6BnNXJCTzz
         dn4e8MPH9YHuPj8LWQ2Jb9r3M1VWJ/ymUUg+Gmw4yXPPLLvNgWDfq2z4QeVGuyd2OrFf
         CNZUhwuY0PlBENS7YQg1NpmpjbZvfz30XSWzuRDtYDz8y/z0Cn2FCeYaScJKZP1amvxM
         sKLKI+dpaa5sq/kPWrYOhMmY5EY3XldCu+NeHNzXEvNpdHEud+5fPSbThmMXNyOuomWv
         ooFg==
X-Forwarded-Encrypted: i=1; AJvYcCUqfNGP7A1Nzoe90cgEHWelsVEhLx/9iboWnZTNFr8PU1nO8qHiI4JXBIOjzaPXRaKQZXpllmDt49z+XjqOirh9C16bys/Pri6EXOpM
X-Gm-Message-State: AOJu0YyJr9RTC/VbYuLCwQlomU6yfRzCBNHCuAwHYdIAPMLJDJ06/agi
	bR2v3QKyqRh2F5wKpJpLZtTBk639WPg+a05/tyc+4kp9ZRgNmhJw3aES1dF3Bic=
X-Google-Smtp-Source: AGHT+IFInUoAInvNUg+Pr6feANwga+FXl0TeerqG+DsnNLAldMdb7HKUnSL+Mh0YRl5gYy0rkPm9+g==
X-Received: by 2002:a17:906:f8da:b0:a59:c0a6:25cd with SMTP id a640c23a62f3a-a59fb91fa9emr172899266b.5.1715165001153;
        Wed, 08 May 2024 03:43:21 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id r13-20020a170906548d00b00a59caa028b0sm3877237ejo.225.2024.05.08.03.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 03:43:20 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] platform/x86/amd/pmf: Use memdup_user()
Date: Wed,  8 May 2024 11:46:29 +0200
Message-ID: <20240508094628.308221-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switching to memdup_user() overwrites the allocated memory only once,
whereas kzalloc() followed by copy_from_user() initializes the allocated
memory to zero and then immediately overwrites it.

Fixes the following Coccinelle/coccicheck warning reported by
memdup_user.cocci:

	WARNING opportunity for memdup_user

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/platform/x86/amd/pmf/tee-if.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/amd/pmf/tee-if.c
index b438de4d6bfc..1b53cabc9aa2 100644
--- a/drivers/platform/x86/amd/pmf/tee-if.c
+++ b/drivers/platform/x86/amd/pmf/tee-if.c
@@ -301,14 +301,9 @@ static ssize_t amd_pmf_get_pb_data(struct file *filp, const char __user *buf,
 		return -EINVAL;
 
 	/* re-alloc to the new buffer length of the policy binary */
-	new_policy_buf = kzalloc(length, GFP_KERNEL);
-	if (!new_policy_buf)
-		return -ENOMEM;
-
-	if (copy_from_user(new_policy_buf, buf, length)) {
-		kfree(new_policy_buf);
-		return -EFAULT;
-	}
+	new_policy_buf = memdup_user(buf, length);
+	if (IS_ERR(new_policy_buf))
+		return PTR_ERR(new_policy_buf);
 
 	kfree(dev->policy_buf);
 	dev->policy_buf = new_policy_buf;
-- 
2.45.0


