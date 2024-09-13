Return-Path: <linux-kernel+bounces-328727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C129787EE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 20:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C938DB22B5B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1530384A3F;
	Fri, 13 Sep 2024 18:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="tLPnMM/r"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46AA7B3FE
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 18:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726252404; cv=none; b=clfKKVnI22cF1SVM79WZPoHEyJmn94zl496hziMJCafyRR9Jjb8TrYenz5WxAvdd5nIHimo15EBE7w9pdUVAcpnOHQjsf+MR+5vLfTnqf6LtiYbBHwQ5fInNbvSImd97HmX5raAclfyMTg7HvzoUrYUHI7IIE8a4LfYUNHElDkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726252404; c=relaxed/simple;
	bh=NND0V9zwpZ9XBN49kNHvsHEKD6qn2VhcX6V5P1HaAeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=brp9gN6grPttNAKn4D6pV3z6lJ/mJ2sRr1n5KjXKDlv8zaXPz+xzFmmCOVQzXVi3E1BlfgIC1Yw6C74qoqbnyR3bBY18GjWKS63zcjQ+Br6i12c1kxk9wp5Hjr2Ok64kyg3Jsb2xS/ru74Ico2UpGqIOoK1eafWa+WEr4GyhT6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=tLPnMM/r; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6c359c1a2fdso9752786d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 11:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1726252401; x=1726857201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j+MSLPUwLhZTQZUn622ey25pLdlzBaTeBrT+c96fv7g=;
        b=tLPnMM/rA9nHR6Z9i95MoJbHTdpql/Wqe1m2eCHha4vugm0u0njgSYoVZwxCcktfwC
         6IMkHsdi1sg7lVlyuB8bkT0S/fKBh6FYKwdJSO9TMvosrx2Ldh2e3zSpC5MgNALuXcD/
         bErHgBrr8yNUUk6w42BeGchdAx5LZO9JJn8dz6X1ECK1UI2T3vwtklO7H1xKSW/Avt5g
         CqVU/cfSn9iJlrjh7RmVu+q5EDBLyxlaq5kOIJDrxgltSe9WLiVUIrNDiqapPQmIHo9s
         AiHhDax49D4OOWrjAvNZlkuRhXkvpXT1vWyf03lXui10LVbOaMdEExStTq87NIRBXoyc
         GdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726252401; x=1726857201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+MSLPUwLhZTQZUn622ey25pLdlzBaTeBrT+c96fv7g=;
        b=FnbYL3/E1wAu7prwzZak4cbAvll8mIvsodYF2RycA+eY7NLBb11S8s4TYhcR6pPQAO
         mb1x98MOdg1f2nHce/RdmGzB8D1oyvB+OcEh1SND271jZUvpMRp6S5T+uhcMS50P/PcZ
         O3eZTOaDFc6u1aJCDyF6t02UVh5LO7zPlBPNiPrvR8Jk0k71g23t5p61/AVeBDxgblR4
         eJKqmsWxYj4HqFwSHZRmER/vcDHKgbOHG5fSEdGDBaT0ncnkrZsmaZ9OTtBJ7lo6Wc2O
         A18DCoX/4V/WWjEn0KGPsHSTNgIslJE76RD6ZQD9QOzAiBmkI0ewxPqnryF/TuzgoQLe
         Qt3A==
X-Gm-Message-State: AOJu0YzzOmMN9Dqp5N8tUKljPE7GZpUQD+4L0wB6Y4LKJKTnVzGgiArR
	DPEh0ViM/esux1sY7BpwBLgDHnaHsEJZSjxhXDAmhdIF0ME0NCCJFFeborzcoNt53vTdBJVWNGd
	6
X-Google-Smtp-Source: AGHT+IEtf29vOcJbTdnkyw9MhU6TEzWslLOhmIOOSID2g8h0qEnBTldMRg/iO9ZQASlfDku7n/b1jQ==
X-Received: by 2002:a0c:f411:0:b0:6c3:5c75:d2bc with SMTP id 6a1803df08f44-6c57e0d6734mr56796156d6.47.1726252401543;
        Fri, 13 Sep 2024 11:33:21 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c534339987sm70416046d6.33.2024.09.13.11.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 11:33:21 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	rrichter@amd.com,
	terry.bowman@amd.com
Subject: [PATCH] cxl/core/port: defer probe when memdev fails to find correct port
Date: Fri, 13 Sep 2024 14:32:34 -0400
Message-ID: <20240913183234.17302-1-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Depending on device/hierarchy readiness, it can be possible for the
async probe process to attempt to register an endpoint before the
entire port hierarchy is ready.  This currently fails with -ENXIO.

Return -EPROBE_DEFER to try again later automatically (which is
what the local comments already say we should do anyway).

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1d5007e3795a..d6bebf70d142 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1553,7 +1553,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 		 */
 		dev_dbg(&cxlmd->dev, "%s is a root dport\n",
 			dev_name(dport_dev));
-		return -ENXIO;
+		return -EPROBE_DEFER;
 	}
 
 	parent_port = find_cxl_port(dparent, &parent_dport);
-- 
2.43.0


