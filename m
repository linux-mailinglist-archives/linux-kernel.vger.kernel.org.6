Return-Path: <linux-kernel+bounces-420882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 102899D83F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8095281D58
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89506192589;
	Mon, 25 Nov 2024 11:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gXaf1hur"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB7115383D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 11:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732532421; cv=none; b=prHBIzGVs20sXCoqM1CB32BmzeSox9eiIfi1HpjI+UkcOUsJQ3qx+11/4h3WhrYCswv256aDu2T+K0gi+a8ba764kvUL4KcdiDz3YFLq95It1c80zyfXsmVCATGLZyV/0vwQXxMYKXH6SEROj8y1TkyrTuYZYKFjL9yitu6vfx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732532421; c=relaxed/simple;
	bh=3d6UyV6U+9wQgJBtBnwExDF3o1uhmm9VscgFbOGYwg8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ToivMS/1PmXrPkHhC9jWSVeYeRMXnYDsVn7wgoAJRl/vRF509sDbriaMxoAT/7nbsvhgN+Ie8K+cd7YPE+u2oB+B/KUA89wZybefg2bXGJsKLwYvFNLF+Op9gFp3ZImqgeCxZKP64ThQbT7zvFA79rU1BR/PaUG2AS5QpiVBaU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gXaf1hur; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2eade1cad26so3374912a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 03:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1732532417; x=1733137217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=96MYJ9KaXB4pjcRmFCY5IfRMfIhiUGPcMDlrjury5qo=;
        b=gXaf1hurlNIKtd+yXH1hHhqkxzBBdgrTuyIXMTMapPhe8vMaByYJKY3LUo4yuPx0oy
         GaEnwASwwk4fB8wqTeSLVQUH3ZZ8DmuWgiD6vm/WSFer/O8ZZIRkFf5yaNLRd/1VqsTI
         PQBK4jl5qkTKBZufY3H4O9nO1YdAOBBnRM3ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732532417; x=1733137217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=96MYJ9KaXB4pjcRmFCY5IfRMfIhiUGPcMDlrjury5qo=;
        b=j74bbpEWHyT6pD6i/2yVD2iC/3Ev4iRnQL/xU8HtvMMz+FDmfZWYxqPQQwrBK2Tadx
         NWeqp6hkp1hL1abaOhzP33BmVzcjpdwR6YvVDc6L8HLa9AOzDi8TpxcveGxgxQZLQa43
         dOVSgkqsoSiC0+DKKpGyoWsOfW03++4wOA7zM5s87klY2Qvhn2wAHw3sUZCF3JMO+nf4
         GJa4Ql+PJBzXS4EUNR8fBW/y2+HGEIGsnJiTpjPTLO9S+P9fOAmeiX/ipHCoFg3+QKMW
         x5N/7l65WpDe3N5mfSg5vhzmX0HSGdJOi80W9sKYGWMs6ueHKPHYI4MA788f8G1d0sNL
         WBJQ==
X-Gm-Message-State: AOJu0YzuVcFuHWAO7c87B2hx/MJ+xHZbTFYrk9Rb0MU06zJDKS7C1Gp4
	S0pf28XQvCdtMISycmBSDcnMvidPq70XwRl6V2isOytHCzyN3x32DSY9jiEHJg==
X-Gm-Gg: ASbGncukQCSZix8LOpj1Rrgi0y0h+Fai0KZ6TMLrMv956MTLw62+ZIgurLXgFqA7V5Y
	QFwN7w7wOClJXzIYUI4uvwnRad5yvYcx6pe4mS23NuILfUv8hJeVzmjUmg6l55lNav7FpVx08ZP
	k5DVyJLVfAQOvbzKlbCIWex8u8jbvQroFAxvWn4d4fd7O+wZcNQND7k7kKUWq2XaGPZkTqtB4MT
	rTbWnxaVCxyp0RmhXIVo37oyJE9YoTPqG6Iyo6Uzcs7iTxHob8+juRNuL6aJ11dpmwxt6mXJs+4
	4pM=
X-Google-Smtp-Source: AGHT+IGOFYLZpRNxLdZHD1TVQKl4mUNs8aee25A9C8cycK7Rs+PtYbJTRnxLEvS3pDQwf57usVWQww==
X-Received: by 2002:a17:90b:180f:b0:2ea:696d:7341 with SMTP id 98e67ed59e1d1-2eb0e527de1mr13709469a91.22.1732532414441;
        Mon, 25 Nov 2024 03:00:14 -0800 (PST)
Received: from photon-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead04fbcd7sm9972779a91.53.2024.11.25.03.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 03:00:13 -0800 (PST)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: richardcochran@gmail.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	nick.shi@broadcom.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	florian.fainelli@broadcom.com
Subject: [PATCH]  ptp: Add error handling for adjfine callback in ptp_clock_adjtime
Date: Mon, 25 Nov 2024 10:59:54 +0000
Message-Id: <20241125105954.1509971-1-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ptp_clock_adjtime sets ptp->dialed_frequency even when adjfine
callback returns an error. This causes subsequent reads to return
an incorrect value.

Fix this by adding error check before ptp->dialed_frequency is set.

Fixes: 39a8cbd9ca05 ("ptp: remember the adjusted frequency")
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 drivers/ptp/ptp_clock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index c56cd0f..77a36e7 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -150,7 +150,8 @@ static int ptp_clock_adjtime(struct posix_clock *pc, struct __kernel_timex *tx)
 		if (ppb > ops->max_adj || ppb < -ops->max_adj)
 			return -ERANGE;
 		err = ops->adjfine(ops, tx->freq);
-		ptp->dialed_frequency = tx->freq;
+		if (!err)
+			ptp->dialed_frequency = tx->freq;
 	} else if (tx->modes & ADJ_OFFSET) {
 		if (ops->adjphase) {
 			s32 max_phase_adj = ops->getmaxphase(ops);
-- 
2.39.4


