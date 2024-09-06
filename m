Return-Path: <linux-kernel+bounces-318839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1C696F40A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F78E28709F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD911CC163;
	Fri,  6 Sep 2024 12:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVwsgXZi"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32161C8FC7
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 12:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725624618; cv=none; b=uigp87jKM/zn0Y9hAoiN5UioGMaa6w8zYq/DDAUWDEQ69iIZSJFQ9NpjxasujxsrqO8O88Dvasr+PmH/Y9+r8Hxxxqs+ewmpaqGh8/K1C9ZX55HKjEbnGQlrDpoCxg8woEAYV6KrZsU42HFEHsVjASs4y+l2zGUfmD31lDlVrqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725624618; c=relaxed/simple;
	bh=WUhh0363X9fGW20lVIYg0li96cLsPACT84mpj2/Mo9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oJQbs4OhHY8EgPoWFRZ1ioTMEFoNuGGAcOjeYSRMeYyOxReo0+uizfmFjhZMB88FeFK1GCrF9eUzFvlw3efRZLW96/sNwblWxsGGAriLLznRm43obn4Zp4YBvbdapYUQe+69NQZbd72354OrLurWSCeHBR8JINALtrmR1djsEi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVwsgXZi; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2055136b612so20597445ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 05:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725624616; x=1726229416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3iym/A1qepyuDR+homydvaj92B4Me7ezUdanrsLJlHQ=;
        b=EVwsgXZi8J330ysk/g8Z1KYZHqXdctsEWTKjejv1eSgRiB97gafSYA4Q2gNIcJ6LpW
         IQUm2pfhNR/BgFjXq+xCwcNpb3JZgLbEurdXcBDQ5vzhrpxgNi0vcOG50nvgjC+whHjg
         AXcBVfMzbAfo6x0LAm8mK8uy8TV/qqIaxnSvtvPEglJDfZZ/ASkvHMy1X154ZN6P+z1k
         +hAxyFAv+fym8Ntlldbhtoyt7n63ahKKc9wn7Z8vlzDz+Q8SaMf+lIc2yAwJ6WkWhu8E
         /8sv3FUExJweU1Uxr5ptERm9CNPTX+G3zWMe+THV6MnFkCTPmHWQXF4gk1vKDMl1JDaT
         fw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725624616; x=1726229416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3iym/A1qepyuDR+homydvaj92B4Me7ezUdanrsLJlHQ=;
        b=YahcbehzuT4bvh0XLWgYK7xRvOzl6IjglDfKsOKkSM+56jYRedTlV/aj/LE4hvkawQ
         dlzojQVa+/M/b7QDfwyEqV2Iap/sM2qNRGP42q1U8w2Zvuzt24qIENiKpmEseABReN96
         NLS44CwLo6v2/FKsx/KIaTI6foAijI6dMi7i/Q+8vMtEeXo2fEwsUy8A2/5qqBO3sZyw
         Q1oxkhAjrxLbjhOOQvzEvji2XW24a9CtaYMlivv2Fw7wMom2sqi2IkMOY8ClIgvtDIhN
         cYFcY+vvj5xwfr+LYudxbZbWMKSdAsKBeLCcZ5RWtKA8/Y0si8aOoIU6pHv5cZCjHyyi
         BdcA==
X-Forwarded-Encrypted: i=1; AJvYcCXOI93ea1tq4PubpT4rpiaTMzpPdTWnYFvCS4n3sc5hgAztOPBBxPuwQ/MsDPqpmHMP1un9cJTrtENAyAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3KPZf3RY3JUgBJZX3CpibeVBOO1kU9gK0EXyftqeQ9QCNmcaL
	QyWWxi/weQjahkJ0LAebB7ia3haitlrSAc+Ck0tYUoDpOwbSPefk
X-Google-Smtp-Source: AGHT+IEdvyyWB7iHuQG+BvOy103NKCj4HYsLON3n1fBoLTFdnoMe4wW9dnKq5lrgL78jgOwq8bM8BA==
X-Received: by 2002:a17:902:e848:b0:202:3a49:acec with SMTP id d9443c01a7336-206f04c9d8emr22730015ad.11.1725624615948;
        Fri, 06 Sep 2024 05:10:15 -0700 (PDT)
Received: from localhost.localdomain ([175.112.156.113])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae951bb5sm42212255ad.78.2024.09.06.05.10.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Sep 2024 05:10:14 -0700 (PDT)
From: Ruffalo Lavoisier <ruffalolavoisier@gmail.com>
X-Google-Original-From: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>
To: Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ni_routing: Check when the file could not be opened
Date: Fri,  6 Sep 2024 21:10:08 +0900
Message-ID: <20240906121009.73799-1-RuffaloLavoisier@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>
---
 drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c b/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
index d55521b5bdcb..892a66b2cea6 100644
--- a/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
+++ b/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
@@ -140,6 +140,11 @@ int main(void)
 {
 	FILE *fp = fopen("ni_values.py", "w");
 
+	if (fp == NULL) {
+		fprintf(stderr, "Could not open file!");
+		return -1;
+	}
+
 	/* write route register values */
 	fprintf(fp, "ni_route_values = {\n");
 	for (int i = 0; ni_all_route_values[i]; ++i)
-- 
2.43.0


