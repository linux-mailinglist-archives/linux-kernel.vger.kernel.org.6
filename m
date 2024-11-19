Return-Path: <linux-kernel+bounces-413952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AEB9D20EA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 08:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9545D1F21E6C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 07:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D967215535A;
	Tue, 19 Nov 2024 07:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Y2FymSWN"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7334D146D59
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 07:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732002180; cv=none; b=pH4LfdPoud8q+Q4FJbavSBA9VA0LbaFs4qrPZBMAD9p5nRiWEiqD1SOMjuAhTGxuJRWE0xIqU0Lue0hm0dbh13uXfYh2UmTPIHXd0skcnb851Z0O9EgFP+x+NXzkxXX8hvY4a6IvKilhDul8yKePifisrooIyX5d89fAUEf8awY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732002180; c=relaxed/simple;
	bh=MK1mRBvffaxWaWW0lCYjKmPrzl8K+sbcDqiVDd0556I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V0lhg2rFLHzYUUYgEftCPyWfBBPM/mcXsU/j3RJpOcoWi2VdT7QrArWvIf3NIIn0gPQMzBZcd2nxkUziZSPJZ20ZkBrxjLJXzE7NqMRLzY4FIUtZAWt42DtEUjO6J5ntQcYYLXJoDSaljMNYI2q2soU9Y3FL6jMiENxYJOBTJ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Y2FymSWN; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e5130832aso2162347b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 23:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1732002177; x=1732606977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rHWWXvo/zk8M+CGH2I3FftTehJA8J+eqWoqCr9hesl4=;
        b=Y2FymSWNeGHIGiK22KyNLCqvhKRxNaQWr9e50Jxpr/btyEoGMcGJpJ0NxoLS5E6u0Q
         sPunLP+bEXuFWoaYEyYK/PLBKekiOa8FFCmBlacE3hYSzsVt+tLqy5o9I4u9qV1lbolq
         43a0YK6wg/PhkPTlS6+Yf6Jzl9msUIDUTLdM/eroasQfinPjjWmtQczCbRZsh7pAW++K
         VjNacbyo60Ar75sYdmLeISZv3GKVTYGyvmwpATIGrnvnSIGSNgF2xAEAanmn9Zs17tpR
         eeDrCOoTAtRx4ens4SZ/3JBk5xjdRybQ5JWIttrJ+TRoi/sODpsaWirlYuz1bbrQDGmi
         uT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732002177; x=1732606977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rHWWXvo/zk8M+CGH2I3FftTehJA8J+eqWoqCr9hesl4=;
        b=vSjYwM/nURJg2slSxypXTWEO31zrUmwl3QwmFL0HXN7X5VVNV35qxbZibujy1xg+Qu
         hycrBdGxkFnGiRVRp1nmfxa6A1QVJ7UK44YIF1U2gbZekP1LTm5xGPyDf1oEftCSAuK9
         hbnNdtOYLJozooxLgXLpc0/s+vRg5PUqP4gbDvXaIE/4HMt3JI4kURHh89apCAXrJL9T
         UcHbPTeckrwbFwLtMpA1TjQ7EQlClqP9KJy7l1WVtsbXuLU0myA4/Y7+UQu+AhOrdfUC
         X1aWPM6jPeSfmNKP4M44FfEL8D+Nldg2XnT1lWVWMmQCgGwow3R4K+0GVrcZ/s7Ao238
         jLng==
X-Forwarded-Encrypted: i=1; AJvYcCWR3/ViFounfr9LLIEb9f9TvRLIqny0amOGNEbIe8XjKNe8ykcje3cPE6UUMqFXX+FtZRPQ6vTLHZ3bqMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNk6TaOJ47sHEb3rMEARGJ6tLRFiwq0azSmfIe3pntKvfeE2Lz
	K1aRMmwNcaa/tHBj2rtolLAZF2QP63F8M3tCESe2Vxomk64DNS3tvwpS+WaBig==
X-Google-Smtp-Source: AGHT+IHXZvtTF/LYtsNOFe/pkAQ3byRvJRiS2/xU3quIwdhkPrqMzJ5N1wzpXuwG6lnYMnziCuq9Qg==
X-Received: by 2002:a05:6a00:194d:b0:71e:4ba:f389 with SMTP id d2e1a72fcca58-72476b98496mr19972325b3a.10.1732002176830;
        Mon, 18 Nov 2024 23:42:56 -0800 (PST)
Received: from QYWQT0394W.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72477200a99sm7664609b3a.182.2024.11.18.23.42.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 18 Nov 2024 23:42:56 -0800 (PST)
From: Yongji Xie <xieyongji@bytedance.com>
To: maxime.coquelin@redhat.com,
	hemant.agrawal@nxp.com,
	mst@redhat.com,
	jasowang@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vduse: relicense under GPL-2.0 OR BSD-3-Clause
Date: Tue, 19 Nov 2024 15:42:38 +0800
Message-Id: <20241119074238.38299-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dual-license the vduse kernel header file to dual
GPL-2.0 OR BSD-3-Clause license to make it possible
to ship it with DPDK (under BSD-3-Clause) for older
distros.

Signed-off-by: Yongji Xie <xieyongji@bytedance.com>
---
 include/uapi/linux/vduse.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index 11bd48c72c6c..68a627d04afa 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
 #ifndef _UAPI_VDUSE_H_
 #define _UAPI_VDUSE_H_
 
-- 
2.39.3 (Apple Git-146)


