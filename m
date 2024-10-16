Return-Path: <linux-kernel+bounces-368792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0059A14FE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87F27B23658
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19611D2F70;
	Wed, 16 Oct 2024 21:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="qByNn6x7"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F721D2F42
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 21:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729114875; cv=none; b=rBQFqDoSLjL+ix01idTtHferKXOhAX3M7ybRcD6g3yi1GcGwa62RN5N2z1RMHHvWB8p1Rzd58in2aIFL3tN5IxzdyemNX5fpQsiF7cDHNxSJ7fvtXWda3v0KhpC8fwbYm5yZQeDUiw4sh/tCN+pkDeQFOKxs87H6y3rbcg9qi/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729114875; c=relaxed/simple;
	bh=1ODZFGWN7pG3n1mrOfsCXSzGx7bHoac/SNo+CnFKsyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s4jrPZCL7zrnVrt5y6t/sgufJFyhQ6p3lhsvarvHRgWWOUJVEc5om6DiLjoYhFdPrdIHZhGrOWi1mVWvt9HGSVsHTnqve3wBnRnK10Uz8zPfVVnIxy2VcBqFQJpNf3NjTzn44o8nYZSq+8ZmIuRvq2veqBPCfnGM2vI/Jz3OFE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=qByNn6x7; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20cb89a4e4cso2024405ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 14:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1729114873; x=1729719673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ddbb9e6b0S7Fxkl43VzMGVnKoYlm5P/BdVV+4+ie3dI=;
        b=qByNn6x7+VE6G0xxJ6eWlk4mtx0amqo+Yho1ksm4+FGZi0jqre1Xa6D3kbqXQ26y4k
         sjk4tER+B04oFHKb9Q9+xl1cmsoJJl/8IYhPReLIQX/yrWUhUDYviaHVtlDQWzjzK//m
         UX04TknoLs487fl/sNjtCeRT2qfhR84kWgH4rGVLfY7tFn57XzYfT6ZIy8HynIF8shOa
         MukiOe9nrBoZNDiBwBjnjT+pbxet70wXiyMnY3OHiD5cXK9KAmA8mrA6Mz0tp0cLkkug
         FNNQo6A3R7yL8I+niZ6oqNKaq1ZUFRlk4W4k49G1v5asXxfCtB6pBsa3RTvRuPrVzn8r
         Yfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729114873; x=1729719673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ddbb9e6b0S7Fxkl43VzMGVnKoYlm5P/BdVV+4+ie3dI=;
        b=dCw0h6o2t6f8zgXN6ZPdyZpgdHF7tlQ66PUSVhXox/LwC4NLCypjjvNj+uTZ7Mf7Qq
         d0U5ZQPDjS0RYyogtYgO8f20d4DVMdfUkTq/I+48EB9zF/4h2RGBnCGChNWbcOueyd//
         n9ZPNSdW3QWZ7iq4nmBgqgX0crmu0K6ReZ2j3+jonKNXotCU23ZCSk8u8JybY/+PZHg+
         4iwt5AjVA/0qphwirdvvmZJ4/6v8D2k3o1Net2XXxOtEWl3fDBtB7UeI7ejpcgfMdkmR
         c1tyggoYSpETFcPAtJ4ANY3AVp/04ExKgeW1XFcADhVGkmFdd2oy8amzNRllaB2vGVfT
         RIYA==
X-Forwarded-Encrypted: i=1; AJvYcCVC8Sqw42TcldW7ckSmwUwda2gvkD43bV+7eULYqO5groD7qr/iXPZ+MzJ8mUY1yi6dUgWXwjWhmZ9JUMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuLiFH36nFoRkQWOIZ2sJmh0Kb1AmEZpXEGDgUk9UBqOVtUKZn
	eei2mIAZkIYO2CbN9HTzQIxb+hhS6OnRxmEcM13k3FD3M056Nh7pfyTILYVgUzY=
X-Google-Smtp-Source: AGHT+IFF5kLMoC48OD87DALfa7jzhyotOgHNJHe9KbQ38evTLDmZB7LvV5xXD/UpoPr9cQJIkq3/ww==
X-Received: by 2002:a17:903:2347:b0:20c:6bff:fca1 with SMTP id d9443c01a7336-20d27ead21emr78451595ad.23.1729114872979;
        Wed, 16 Oct 2024 14:41:12 -0700 (PDT)
Received: from localhost.localdomain ([81.17.122.236])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20d17f844c7sm32999215ad.46.2024.10.16.14.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 14:41:12 -0700 (PDT)
From: "Everest K.C." <everestkc@everestkc.com.np>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	skhan@linuxfoundation.org,
	dan.carpenter@linaro.org,
	kernel-janitors@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V5][next] Bluetooth: btintel_pcie: Remove structurally deadcode
Date: Wed, 16 Oct 2024 15:39:55 -0600
Message-ID: <20241016213956.4508-1-everestkc@everestkc.com.np>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The switch case statement has a default branch. Thus, the return
statement at the end of the function can never be reached.
Fix it by removing the return statement at the end of the
function.

This issue was reported by Coverity Scan.

Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
V4 -> V5: - Fixed typo in the subject
	  - Removed Fixes tag as this is a code cleanup
V3 -> V4: - Fixed typo in the subject
V2 -> V3: - Removed that the change was successfully built
	  - Removed the link to Coverity Scan report
V1 -> V2: - Changed "Fixing" to "Fix" in the changelog
          - Added that the change was successfully built
          - Added kernel-janitors mailing list to CC
 
 drivers/bluetooth/btintel_pcie.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index e4ae8c898dfd..660496e55276 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -391,7 +391,6 @@ static inline char *btintel_pcie_alivectxt_state2str(u32 alive_intr_ctxt)
 	default:
 		return "unknown";
 	}
-	return "null";
 }
 
 /* This function handles the MSI-X interrupt for gp0 cause (bit 0 in
-- 
2.43.0


