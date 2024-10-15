Return-Path: <linux-kernel+bounces-365087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC77799DD58
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE99F1C2141D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 05:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA11C172BB9;
	Tue, 15 Oct 2024 05:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="g2C4DFKy"
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D30416D9B8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 05:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728968412; cv=none; b=MJrXH4fLu7h1B8nHQ0L5Ntzzo0zEH/JyfAb2e5ZNbvWXM9pfeRT6Dm1nMJddIycLfrlfiXwZFXIKlWkZbOC3yZsZq5zznzF0QSJGW3RW7oGwkyVV2Ihzm79geHx3eResWuXEfXvabeeOp/bEcbvidR5qGKE6mhB2uKbbUwM6vnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728968412; c=relaxed/simple;
	bh=nMXhqh4HzokCG/i4LxOBg3hOYxhW1ngv6Tb8E8kN4Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eed32JvDrjNoKOuteg0sVVisMSh02CcFrJH35EgxxfVftGmA+1L5RszbUkiu5egD409+Lovpm055bEmvY9Fa6AyVvj0amO+F7EQ03Y4cjowBbEk41XHzcchfz/MgfTw6LXaSYjGrAkRJ8sQDw5yBR+jN+C90jEMUgdvJtBrIZwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=g2C4DFKy; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-71e49ef3b2bso2293279b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 22:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1728968410; x=1729573210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UDE8ae4KGAACvTonZkpDinm//oEQtAd/MtLLCfcVh7M=;
        b=g2C4DFKyDe3l+Fzyu7zFErMJ3To8sKhu16V1BPylJQ7vw5WY4FNcCZQ2/YYYsZuCdo
         aY/6Sd04H4QxEYNKi2+PuZ4AmcHq9Y8Kd3HFnuWg+3OjeghaoOnFYOd9Q30Np7Jg54h4
         iTvf9otptP1Q+NOlBC5CgC9rE4vqh3BMAgDwqKSrWlsh6/Bk9xoBJZScKebIe8uzK17u
         pxobPNjJyvNXXU6k3/nB8/3Xx0otXeV/Ib7V3to3yOVVzMKTUe5KU0IqpBD7T/tkt15Q
         0xsUv5+WR7+nKpgr+Exv2UyS1QnYqr1ELsKLXtF6xecpWistpmXRnm7+U0wNPyUZ6BSY
         Tk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728968410; x=1729573210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UDE8ae4KGAACvTonZkpDinm//oEQtAd/MtLLCfcVh7M=;
        b=ts83g3eu5iFxpYa0BlT2Dh23fQ8i3tHk6WRHSlmpjANpTapBYjAY52EzR+OWb8tvWP
         2p/jJuRhaztsYCr/K5Rwr8TlRcAhRwZ59Sm4tyUWxNbEh6VOygVEO8XsBgfZcd4QrGf2
         17V8ZX7rCCGxWnM1tJABfJjXialGeGSqmDn0hFfTzlEMKE7c8VziQaHRMgWwLP8mt8Q8
         W0+yx1uUL9yEZ+8LvDQTOTewdsAriYUfaAIv92GS8lWGK5T6MTG7f/zYPAuEVUP3xTaz
         QCnnYSx6NToyHFhvGr6al5vIVkWxdYtS1B6GiZcGLj/7L6jtA9pEIw9nN3Nrkig5MaIi
         kL/w==
X-Forwarded-Encrypted: i=1; AJvYcCVnGey1CJnK/NwaPiSuXcn90xXqACc1w9nT4CvNugDeJGGe5fDeDHlxfDapiHPqJUfvQo6oF54ZmAdb9UU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJM2UW66PCN/cRTHAMIjcapJDM3WLKG6dZaSUi+AWPqUcrglPO
	fQe+FqlH39dNvybdEXTR73BoeHi6HZbEksuKCCOkbbVwG673deGo/1lQCrbm9ss=
X-Google-Smtp-Source: AGHT+IGPdj8U1y9DYvRNnq4n+Baw1Zig5U/2Z3A5zNqzr6z2E57ek3/4AKtQDKOOKtFDMh3GKw4CrQ==
X-Received: by 2002:a05:6a00:3e25:b0:71e:6489:d06 with SMTP id d2e1a72fcca58-71e6489127amr9511479b3a.0.1728968409796;
        Mon, 14 Oct 2024 22:00:09 -0700 (PDT)
Received: from localhost.localdomain ([138.199.9.153])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7ea9c61c839sm439758a12.0.2024.10.14.22.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 22:00:09 -0700 (PDT)
From: "Everest K.C." <everestkc@everestkc.com.np>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	skhan@linuxfoundation.org,
	kernel-janitors@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2][next] Bluetooth: btintel_pcie: Remove structually deadcode
Date: Mon, 14 Oct 2024 22:58:41 -0600
Message-ID: <20241015045843.20134-1-everestkc@everestkc.com.np>
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
The intel bluetooth module was successfully built after the change
without any errors.

This issue was reported by Coverity Scan.
https://scan7.scan.coverity.com/#/project-view/51525/11354?selectedIssue=1600709

Fixes: 5ea625845b0f ("Bluetooth: btintel_pcie: Add handshake between driver and firmware")
Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
---
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


