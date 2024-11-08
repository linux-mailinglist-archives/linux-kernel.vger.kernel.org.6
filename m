Return-Path: <linux-kernel+bounces-401124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2953D9C162E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 06:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C4028217D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 05:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA311D0147;
	Fri,  8 Nov 2024 05:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AUBfkMSJ"
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEC71CF7AC
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 05:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731045095; cv=none; b=HmoIGXL23PM3bq12104bN0gFVrmgJoiTlcLZTIdV2mx4OH7vH4riYT3/rR1MqwHiSnkm9y8IzegCb7LywKAQRYA9CRbEyrvADkxHRjIfhLuEsJOuOttbbEtTwGyQv8AGjJzugdeQqOQzGbUyWpDZtAWHVO3IWGMaEQhQQ5vBcpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731045095; c=relaxed/simple;
	bh=3vbUbHP3RjVNF/eStAv3W8UE8Y6oF0o0dTPSOT9ZVVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjdmlX7r5seodvivs/4AiIhctG3kjiiwkOFi5gmoG5kExYH+Wz3ZTxqEWpIMrTn16Z8Z0uDiQ8jeKbacZHDK5/YWa/IF7pZO05xEe8QattRqCYg5hfM74ftFQAHNg2R6fYrabJewOtlMbw4OYsl0mCYtSPZ71CGMKe88IUzALkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AUBfkMSJ; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-43155afca99so16152335e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 21:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731045092; x=1731649892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+onabwK/GEA7qFD3DQ/amWTwTwQjZzmNsqbuusTpvE=;
        b=AUBfkMSJanzJnskVjiCqxbnudE0ZKDidFEKtllRdXp8MBASe2b0rRpRPa0Ybr46Xm2
         RsriwMnmIX7dnpDSduPDV6sX2EAj6gtuV8mtekthWEbZ4Q2McFzZy6fvEyeraTfwKV0d
         /PndzE/kLZPOTcYbgwetWfl699Hnunwv4mAD0Vq3KUWHi8sl5b2UvCTD/Q7l4l3ENZaC
         DeAG5Pb7HfRdDwcJZbFTigeCC++3HWRk2yE5phkxjQ9Q8Ke80Y7/BNkpmVEsxHdXNPlt
         10WJlXBUmNcrhhHy7MY++jksKa4Las7w0YdV2tNcPtYKBSaW6u+33LGOQEKyZUmve7kL
         5UtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731045092; x=1731649892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+onabwK/GEA7qFD3DQ/amWTwTwQjZzmNsqbuusTpvE=;
        b=Ug9svK4H5m9zMI5bb9ul01JoO7kVqI89LtWjOUwFOYaC0jN/e5F4OCFuW5UL7qHmbj
         Z/U4eDVwWSDjOQQ4BNC6ndU2xHCNZzmgr8vsVT5betCWNb4ZFkWeq0Og9rlkWKqzPBzD
         TjwJ+uFR2uU69uTTufUJqEOPuWHdEbUl2GxwnKDVGToweI9DKTg0j4MyA9w05+qNXyJq
         4ufrirK+6MyquVDTrVjcE0eWuuj6UPq6uQnXb0Ofl/PcYE7PqU0MNocK2t+/j8+PfnvU
         AvQq5mK4WuNXUqT6CIsIb1zhxPvwLoSZMFjvtSszkx3WmRUdhWP9Au7M9bf6Fd1iUhWg
         BmFg==
X-Gm-Message-State: AOJu0YyM+drWyCnec2jMc5jNc2VbEDa2kFPgaus7DOMA57ONxCDzCLYX
	DZHvTJQ/O8aBHZlcLhdOKQnhAIteK+1IB9jsnGOFVqrfT0WYRmgEtQnaqY0ePks=
X-Google-Smtp-Source: AGHT+IH4wJ5eg9/Q+yF9Q7pbDXzsp4HwUqCQuYd7fFj7rw2BJ5+U5A1uGyMbFqqDRo3grAZ/Zd9m6g==
X-Received: by 2002:a05:6000:1a85:b0:374:cee6:c298 with SMTP id ffacd0b85a97d-381f0f7f27bmr1639543f8f.21.1731045091828;
        Thu, 07 Nov 2024 21:51:31 -0800 (PST)
Received: from localhost ([2401:e180:8800:eb21:7695:a769:ff9c:3830])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785ffc2sm2853278b3a.25.2024.11.07.21.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 21:51:31 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: cve@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH vulns 2/2] add a .vulnerable id for CVE-2024-50063
Date: Fri,  8 Nov 2024 13:51:14 +0800
Message-ID: <20241108055118.28631-2-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108055118.28631-1-shung-hsi.yu@suse.com>
References: <20241108055118.28631-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link: https://lore.kernel.org/all/tcb3xez6spzcrbv3umgbrjzfrskekjsylwswchrvvzsekfjyfx@okljgt65srjr/
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 cve/published/2024/CVE-2024-50063.vulnerable | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 cve/published/2024/CVE-2024-50063.vulnerable

diff --git a/cve/published/2024/CVE-2024-50063.vulnerable b/cve/published/2024/CVE-2024-50063.vulnerable
new file mode 100644
index 00000000..bbc04154
--- /dev/null
+++ b/cve/published/2024/CVE-2024-50063.vulnerable
@@ -0,0 +1 @@
+f1b9509c2fb0
-- 
2.47.0


