Return-Path: <linux-kernel+bounces-366936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BB099FC6C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 01:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59313281DC5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFACC1E32AB;
	Tue, 15 Oct 2024 23:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="HOb511sW"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32C11B0F1A
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034612; cv=none; b=pCvXscg2dNwHCfArKfivuHA29drsyRpFqaDqC2wfkLsIZcAn0klXHXEJUI4nB7ygU7dHkbBcMRf3wZESahKYvSR/9IOOny1jQbcvdFba4KVt8J9JktjEsh8glcxZyc8ddKXgdSQAanPTovp5VpkMTwCvvTUfOGxgYtHrvi4EtgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034612; c=relaxed/simple;
	bh=MxdmhjCxj6LiiZVUxifESDviq01IPYVB95t3KqW5Mt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O1ts/2brT4XFEb0yHFCakEJqLLhhzCOJ2s6phTioGHAYw9By5rao30rSp0ApMbykqDlujILElOxsVsEXeJumKHMn5izaJmnk6jQvET+SUqwZfpfXiWpYCMZAZzKOopx5iRaUB8XjKsJxtMErGOliKiZLwvSr7Gnv6L/SGuSp7mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=HOb511sW; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c805a0753so48838025ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 16:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1729034609; x=1729639409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fDDXRG1a8a8p6wsQpSeuY48H+wQjbIigs/w/koYWqjQ=;
        b=HOb511sWNUWm7CZRto3Jl9TULdy3sO2C4Um732xL7Egn9uFcOAJQwA2uQgSAsOXRbx
         SOr/LFFhWvGKDBy4w95I9Gw9+aYSLEIqmgNBgCpKtMlLMeqvqG/7elVczv3/hYO+rW54
         76HOZYle0Xkyp0RnwMpr24U1nNMMF6thDsxMakzPAjC5Xf50u/Yn6AY51MiP/ChM8hui
         tkQAp2i435NtBowYhQmQ21lakUzcZAJR3P+6Efg052/BBJUvGEI/y9V4x/3KyAYnuAHA
         LQXO2IekgtjXx3YGXQcfjWuolObUzv+rH3IkYCBVa0kcgQ1R3UGNMkyYfNp4h08HMbRE
         9Vjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729034609; x=1729639409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fDDXRG1a8a8p6wsQpSeuY48H+wQjbIigs/w/koYWqjQ=;
        b=j0g/NQ/O9sodkOntz9P3Ks3iFHGmJ7J9Wln7m1R0qU54VnAL3uYVQ9wO7jo7JxL1I/
         FsUSMQhbHyP2jiaAlKqq9rJA9ek2aT5AqommW1nv8xa+YnOt4nZ4TbGkRmla0PQdzfRb
         RsbMevpG9KUY8xe1yysik8DFJOCMyyKeZXlRJClT8O3qogRnYe6WoiFFIlndomkkGawN
         uibuqwucXsBgyV0lKsNxuQ7CXZ7zFbP8O1YlLWrCCAGLAXeTpmyOPqK1ye84xgjYuI9i
         n7ywA65/SN2u6kyjzvNDFeQeLCTRGkCI1dyLqWtP8DFmHHMUmT1/qTj9sMQkXuoaprr6
         KfPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpJF4zcKLKVdHxheGCKk+bWLfMz11vPCK477EORch84mTZpufRhMAvmd44JSc509PahcFp7wsUBo7W2YQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN0c5uNATjf/rz6Y1WjouKEUwLVq0ZVyC52de4fpKjx9Kydqh+
	ztPMR1ciTmDPI3PrYg2EZGZtk8xz1LzMstrP7+QVc0yDibRQuRfuq3rVME5bYtA=
X-Google-Smtp-Source: AGHT+IHQxjs3tD7xHQ8tLAnTy4Z6hQCKOP3SL8p5ic3MCYz2+5uKvajxBaK8fp9urUvp8985lajYtQ==
X-Received: by 2002:a17:902:f54e:b0:20c:98f8:e0fa with SMTP id d9443c01a7336-20d27e4669emr29774405ad.11.1729034609025;
        Tue, 15 Oct 2024 16:23:29 -0700 (PDT)
Received: from localhost.localdomain ([81.17.122.160])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7ea9c6c1948sm2022927a12.27.2024.10.15.16.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 16:23:28 -0700 (PDT)
From: "Everest K.C." <everestkc@everestkc.com.np>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	skhan@linuxfoundation.org,
	dan.carpenter@linaro.org,
	kernel-janitors@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4][next] Bluetooth: btintel_pcie: Remove structrually deadcode
Date: Tue, 15 Oct 2024 17:22:05 -0600
Message-ID: <20241015232212.19242-1-everestkc@everestkc.com.np>
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

Fixes: 5ea625845b0f ("Bluetooth: btintel_pcie: Add handshake between driver and firmware")
Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
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


