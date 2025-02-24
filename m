Return-Path: <linux-kernel+bounces-528430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8AFA41796
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F29D67A5630
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70AC20D4F3;
	Mon, 24 Feb 2025 08:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzHghznJ"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB4420C023;
	Mon, 24 Feb 2025 08:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740386401; cv=none; b=m7HD1q8gULXtoBeSxlQnHZena7ewFqItwjaR2MI0WZKvDZtbQ8sp2G7yr9do4TgUK+A2LfWH8nv2hJ2K2JUuII3G09MEQJeaEUwTp+490NHDkS4PxeZ2+P9IAz+mMPsQ7qvYfTxYbRCqc8UR/ZWXeitfjp5AQh5IjtGW9zg3vyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740386401; c=relaxed/simple;
	bh=mzRbaEDFD4OYuJd1bGaOG/2PPYgmia+chNPV24BpCxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MLsqbSC1mCPK7kBGWZM9EbS8O0AiiBNzisP2sOI86+a/jmR5p1t3XLnrn6GuMVHOZeSUm+MOeo4aLplK/SAV1sSePy18vPlvml4F5kCJ7LLpj8/BeHbgC/4jdojYrBDEHcWrqVLzdCnfDp9b3AVp8gzuM4mr7jB0lNaDd+9XcdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzHghznJ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220f4dd756eso81355075ad.3;
        Mon, 24 Feb 2025 00:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740386399; x=1740991199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6cKbHN4qfM72wdTSv8VPMRBomnhPqBZxZM0i+T4Gyg=;
        b=lzHghznJmH+5oueoAsrKpXw3aCGXMy6b/bG9KjuqVvZdpfQSmofE6VN9KHTebOLyA+
         2q15wFCq+LHOYG70L2rXR2GvbXw2zGVlz58xwz2yrkGs5RA/hzz0/bUeSQ8y2f6odI/U
         NsrLWzksz65JLE6nbCWu8LHXBtu5S/vNq+qrhUS81gQaTDxhqAP9Jfv5npnE1N9uJNl5
         zSY/KdrUbwRiPOv/SsSwH56cQ890uzm3aWXmaVFU/PY62sGZDVOoEbwfHRH/H4ZMbcJD
         8D7KCWBAJYAboRLfi+7fpv7nvgSr+xj8mWgAoiGNz8PyF2Drdjk8pSJauYDocN2dVNdE
         cmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740386399; x=1740991199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6cKbHN4qfM72wdTSv8VPMRBomnhPqBZxZM0i+T4Gyg=;
        b=IAeNwVcNEG39WgvLEhfm/vKirEId49CqSc7PCFfSRTC/brokBeRJR+UHf1dTLFhCz/
         z8j5QlSwDmaKOmwb8r0InVPYkWRf49wnOR6CjFoQRGsHIV1lge8OlOkYxyvSGHA7gfqL
         Wy9hNf5zGWDfdiH/2vRu+o6xOyKmnRkRwpLl/mkW+qc020VRhyK3uzub0/9P5hWeuLU7
         fMWi/6uJh0OsMqAHQJwq5ss6aEy43NbyISgo3uKLkaQKMmfU03nY9vBl2w8P2tmnngLJ
         c4m/iNYTKfMalKDKTtAGQkY8NQdRHIX/R8hJIuoRZAml8nuE5pUyDwJrdw9tXJYcDTYw
         DkEw==
X-Forwarded-Encrypted: i=1; AJvYcCW9yvQ+9GVXttnXNE0Um0j/ofO56dfgsznLg+E2BFhO7UNjezhnaJk1/SphOIUwZIMRRQQXgj1r5Ivx@vger.kernel.org
X-Gm-Message-State: AOJu0YwStnFfuOOv4gNK6mVNFYgGUR4t48d1VGYGHv3cRgBRWD23zxen
	eiaJ8Mqpp4tNvydeCzfkVrTUHUSLjsDoeS4TfxUUya7g4SC4ZIHPaYXdAQ==
X-Gm-Gg: ASbGnct0AgLP531ueOjOkn+4wjnBe8gyvfy2+LYuGutlPzNIIw0qaiSK8khJ81FMzoH
	I5irGgrLYvTpOUgrffsb4VqFkSAEAuEUS86H+isknZLwR/cIcYvsG/DfDaXIO19BbBHsgzRq2cC
	ClGA1Hzd1OW4gT+G0qY+6tX6J2dNTgrieukoxcWjCUyh4vi2nv8FiTZTfetYVO9pnoQnebthaNf
	OtjVaN0QrYaS3QDpG79ofY4pK//mgPf2lZI1KDVw63vrFtCak43vmNZs+azbjdpCsxZnM124NAZ
	FO1HxR5e3BPDpXc6CSgG09V7gnwIX3c/+d7O
X-Google-Smtp-Source: AGHT+IGdjRXZheSkV3s1DvGyCdmz3tYxghaKg5ParvRKOuHPh2Zz2Irrj+s+VtVp1uXaNHZqFpFNNA==
X-Received: by 2002:a05:6a21:7011:b0:1ee:dd60:194f with SMTP id adf61e73a8af0-1eef3d66471mr21615752637.26.1740386398761;
        Mon, 24 Feb 2025 00:39:58 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:cd02:bc36:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7327590ff12sm14634793b3a.115.2025.02.24.00.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 00:39:58 -0800 (PST)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com
Subject: [PATCH v4 5/5] i3c: master: svc: Fix npcm845 DAA process corruption
Date: Mon, 24 Feb 2025 16:39:08 +0800
Message-Id: <20250224083908.1880383-6-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224083908.1880383-1-yschu@nuvoton.com>
References: <20250224083908.1880383-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Chu <yschu@nuvoton.com>

When MCONFIG.SKEW=0 and MCONFIG.ODHPP=0, the ENTDAA transaction gets
corrupted and results in a no repeated-start condition at the end of
address assignment.

Workaround: Set MCONFIG.SKEW to 1 before initiating the DAA process.
After the DAA process is completed, return MCONFIG.SKEW to its previous
value.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/i3c/master/svc-i3c-master.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 4eb4b8888725..403d625e999e 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1162,7 +1162,16 @@ static int svc_i3c_master_do_daa(struct i3c_master_controller *m)
 	}
 
 	spin_lock_irqsave(&master->xferqueue.lock, flags);
+
+	if (svc_has_quirk(master, SVC_I3C_QUIRK_DAA_CORRUPT))
+		writel(master->mctrl_config | SVC_I3C_MCONFIG_SKEW(1),
+		       master->regs + SVC_I3C_MCONFIG);
+
 	ret = svc_i3c_master_do_daa_locked(master, addrs, &dev_nb);
+
+	if (svc_has_quirk(master, SVC_I3C_QUIRK_DAA_CORRUPT))
+		writel(master->mctrl_config, master->regs + SVC_I3C_MCONFIG);
+
 	spin_unlock_irqrestore(&master->xferqueue.lock, flags);
 
 	svc_i3c_master_clear_merrwarn(master);
-- 
2.34.1


