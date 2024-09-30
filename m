Return-Path: <linux-kernel+bounces-344625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A54C298ABF4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DBAAB21AAA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D19E1991D2;
	Mon, 30 Sep 2024 18:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsNOohaw"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77611991D8
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720380; cv=none; b=bbMNB1J1Me5gwBQDU/kBOoS8flazuQNI9wIqv14avc0CVHfK+TRAm14AHkxvAfvKGNrm4BKggUKSpgfRovsUwdYyB2KWloz4GY55PXpaEXnG1wzYN0YS5bnr5uWQwjBr30tcOZFbM2Kk84zQ6klKgMvU1wjcoungrApyjT7Cguc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720380; c=relaxed/simple;
	bh=Ht+B30gRVS9a5pXbHqCQQoXXKnvU9e/fBuCln1uzGho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OwulFeSHf9GmZUfEl2v3iWywsLeddKzpTB9KRqn7G0x8Ht+tBUI63pETrFzEKlbeBaS5239CZuWuJ/V6LD+SSl1VCuNHaKwZB7aZKxyxlHftvS+g2rk56KwuKI2Z3Y/B9Fsl7UTfqKAIBLguH1CcSbapQLjSoHe/UxjVbiDN+Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsNOohaw; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8d0d0aea3cso719733966b.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 11:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727720377; x=1728325177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=58o476mm8VPQl0lc9LNWht+iwynEoA3d0CfqUnAlDT8=;
        b=LsNOohawmb8nrOVBJvjK27JIdfH7W5CX8cf6UbOOsVMAoAqssxLvTfGTjtxDZtiLlg
         0nsD82sJR4HamaGuaq6mLFlupg1Spa+yq0RA3XRP+yh05TLJpVOWZG5/sstJVVMlq2ry
         4vYpl6bziPhs5/uA8VbfQ027VzRZGVfEkYdE6iV2ch03SyO4Neo/XxBzpz1GIINCQmrg
         gAn8/Ute2DIEK+WDyFSW+AdEPDLgkpvBl75HQlCeA/isBhe3zBMGMTLW+sJnpTBBOtbO
         Z8k/jVyyonUhno5eXwurfq6rmX+awkvgGNLasLqu/jXkqVeSognugtwA0/SLHijpz/sn
         NGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727720377; x=1728325177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=58o476mm8VPQl0lc9LNWht+iwynEoA3d0CfqUnAlDT8=;
        b=AShczb/Vu2fc3dpSbK4OhcdmLCq0CVAIddQz7l9jwvXhC9/CTtF/lrHYLa6OGQQyC3
         U9QOCiljCojiWTWAy1nz1TZK1wocVFtszbcp76RAsMxp66uMX/VCdjY/NTYNaXavVaNc
         d9xPnggVuZfLvxAvElFFAjLsygaqyvxUtFknbWogj4SHPf9CJb4Sz1EAzrRcvDSFNzx2
         233PYH9aGRkH428T8/fHn87sQNAEmmrIFClcG1XgpvVt8e0XCBa+Jli3XYJBgJXDGT41
         klkRSqGbAHjGSa1ALnHp0mTFeRgUJ1uvngpxVRwrheRaFvNumbHvW/sGzs8MV0H+CWpK
         hiNg==
X-Forwarded-Encrypted: i=1; AJvYcCXCIV0rx08pX/BDltE4BSScd3cdIKGb4/dg8/LUDIS3dFVzGSPuFDTdz/gaWlRpNie39GR53YN5wewHIFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCAzz44F/Matkzwby1iFXLmjXLM7Mpr79QXin35/Z/RVhSQIsY
	2+bzdJQsX4jdHbts5/Jeb0P07zssRJqn14VF8TIVmwXuLA89tIez
X-Google-Smtp-Source: AGHT+IHDYr+m3motx2ha4HGHm3GFngwLHemvsfw+Undb5BRIKubrpXTYLldtsQcFnqmnO5z8AMGGpQ==
X-Received: by 2002:a17:907:2dac:b0:a7d:e956:ad51 with SMTP id a640c23a62f3a-a93c49194bamr1366306866b.21.1727720377024;
        Mon, 30 Sep 2024 11:19:37 -0700 (PDT)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c297bdeasm567225666b.167.2024.09.30.11.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:19:36 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH] include: linux: Fix flex array member not at the end in bpf_empty_prog_array
Date: Mon, 30 Sep 2024 20:16:53 +0200
Message-ID: <20240930181700.22839-1-philipp.g.hortmann@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Struct bpf_prog_array has a flex array member at the end and needs
therefore to be last in struct bpf_empty_prog_array.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 include/linux/bpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 19d8ca8ac960..1ce319045048 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2018,8 +2018,8 @@ struct bpf_prog_array {
 };
 
 struct bpf_empty_prog_array {
-	struct bpf_prog_array hdr;
 	struct bpf_prog *null_prog;
+	struct bpf_prog_array hdr;
 };
 
 /* to avoid allocating empty bpf_prog_array for cgroups that
-- 
2.43.0


