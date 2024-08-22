Return-Path: <linux-kernel+bounces-296710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB5895AE19
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52B981C22B23
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B3E1531F8;
	Thu, 22 Aug 2024 06:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OIVknDTG"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2897D14F9EF
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 06:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724309555; cv=none; b=SeWnrYEdF6z9tBpy5xUMSASSjh/GuoTXPUcfhnTc7kt61wXV72iCZfmnzcKK1wVpF/qzVaD6Slj3/h5wafCtwc2QgAYnnYlGINdXjVSCPLzQYpK1c2lDfWEq1iC1lrT3DPX0Hk010nowfMwzWFHALDocjNzUV0De/C/OLMwj5i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724309555; c=relaxed/simple;
	bh=TukisUcZbsaqnUyQbHFmvX+q4tnh8Zwf4JnTxsNfl0E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OkfC8Vc25NZJfc5PymvXfEIZ0jPhHIRQKEw5pH5MzgMsiCzBMjhbTHxJJe9XcSsXO1kCrNZzdYlSNeAlRZnC2dOxiMm81eKTd8p9fLVnhqgokcD6Hx2MTUkVix4y5a0i8RnmPsI3YnJP9FZOd77RNjLajhHED0ZqGtIj3vbFCYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OIVknDTG; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-201d5af11a4so3838065ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 23:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724309553; x=1724914353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQFqWerFHqQW32XLucYPT25yaWxIWGQBA+zkA6La3Mw=;
        b=OIVknDTGLc/zjr00pPcsgA8czet3u4OYxphuTKjD4CjD0gNwnQMKZxhVynU3+06Qof
         GLo6qBCVPB11+6qM16VbhuphOQkdVzKb48IaRflNSZAR99QuOvs1Ct7a1eT4Z0dXjIX9
         CXDGoatP3+zdLTKH+9+P9gTvO5paquim+lvt5GkvWad+wTNB7TnAqBPfURzAss3P9w5B
         wRjKhfK4HS/ETPZLIRtYeXP9JLLumuCw0Iu6slJG7ECfy6++Ouv4JDf75/MPHC60Nsd4
         BApolAKqkZa92mbRZg69k8PYyw8tFxgGjIcUx4nm0sOZ2KKDznImDh6NWrv6qPCzpRvq
         sLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724309553; x=1724914353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQFqWerFHqQW32XLucYPT25yaWxIWGQBA+zkA6La3Mw=;
        b=wM5xWkcawJGyLlLhGg2J82FT04xrl6dtXPncaVgjZ1+gXqwq+WpNiUh3LjWe/UZL0L
         NFa3C+r8Fz4oKinFOxdReApMDTk+NucFR+jCEcyL2su5L3q6O6MUnLgQUm1cCt38kJcA
         D67dWAN5CD8x8NdkdzQ3D8lATbwqm+yjB5QahjdOhcA1WIBhDDTjwiRVriZ7f6m19XN/
         mWX3W0tJt/sqoeIFprRu0cFY9XTR2hP2CUtKMWxqU8nPAD7960G44oa/Lw7uS/ZIL2Ez
         1co5FxWHg8361MAkJIbpf33FSOQdH5OdXsswAq+CU005A3PkJHh15sUAoOAvaKEXrbvq
         rPiw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ0x4IQtg+mtj0LDcu/XfN31bwT3X+QE+IiY0HFmtDNhdIF3cJXWmt7gUuUS+P0jKzLO9eBscUpyoW7Rg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9mV9aS5lZV815sRkGevZXsn4ZX/jRJCgY1/8IdY0QP2EAK7CY
	dWE+bDoj7RP++IdCLhleghCYsC3sQ42Yuj0LQSQgZ1rE4FqB2ZmInA34QBJMcHM=
X-Google-Smtp-Source: AGHT+IE/bBwaY3/ihXg1+7sSGeF1aevL3H+a7yRXHNu93YQRdLaI38OoIcbKhNtUJ9ynRdtqxwJ/Cg==
X-Received: by 2002:a17:902:db0e:b0:202:671:e5bd with SMTP id d9443c01a7336-20368090376mr53522775ad.42.1724309553443;
        Wed, 21 Aug 2024 23:52:33 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385581165sm6150645ad.88.2024.08.21.23.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 23:52:33 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: zyjzyj2000@gmail.com,
	jgg@nvidia.com,
	leonro@nvidia.com,
	zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 1/3] RDMA/rxe: Use sizeof instead of hard code number
Date: Thu, 22 Aug 2024 14:52:21 +0800
Message-Id: <20240822065223.1117056-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822065223.1117056-1-pizhenwei@bytedance.com>
References: <20240822065223.1117056-1-pizhenwei@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use 'sizeof(union rdma_network_hdr)' instead of hard code GRH length
for GSI and UD.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 6596a85723c9..bf8f4bc8c5c8 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -351,7 +351,7 @@ static enum resp_states rxe_resp_check_length(struct rxe_qp *qp,
 
 		for (i = 0; i < qp->resp.wqe->dma.num_sge; i++)
 			recv_buffer_len += qp->resp.wqe->dma.sge[i].length;
-		if (payload + 40 > recv_buffer_len) {
+		if (payload + sizeof(union rdma_network_hdr) > recv_buffer_len) {
 			rxe_dbg_qp(qp, "The receive buffer is too small for this UD packet.\n");
 			return RESPST_ERR_LENGTH;
 		}
-- 
2.34.1


