Return-Path: <linux-kernel+bounces-298901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FFD95CCF8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 14:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF50C289199
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48DE188A07;
	Fri, 23 Aug 2024 12:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t6spEVrL"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3703518893C
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724417504; cv=none; b=Tl6QX+gmQxBHvJDzi+ZkwUhS3xCkGchH87uWh04wXKbv89YVt8rZIa9rN5isFIANQIjQ0dRW9DZSSBtCw8BUdr0yKBQlbWBGEmaNWreekFEO7PqmSbxnL9ivbV7JHVZX1LmmbnZiUMPMZXI683UxT4eznOEyMdTZ7gqVpBhnTME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724417504; c=relaxed/simple;
	bh=0GYm2ySTIWpR5t1AhOZzOLn2pSAeaQl/xmm0Un/1iQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hov5snh7HU6VieiQWTeJ8FO8/Jh4Gf7ryRPYdwIujnfmk3xgMlbt4QP9Zf7xklMK3Rqu7eMoLD+1Z6qY22M3iJC2PspHzWOXMNzCDvKEMjUdrkw40pMRwCmqYqfDCbLu4POQ7JlzQhN0r1sj6ab8xrPQZH4DjtfT0J5O2arJPQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t6spEVrL; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4280bca3960so14762145e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 05:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724417501; x=1725022301; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hoe5j+zL5nAbiCIUvREYQpVSE2yifQUHpqXLQ7XWoEA=;
        b=t6spEVrLkloBDjLQeUDFN+MUth0UW8hqeZpFlanPz2oBDR3JDzu/fbfPbXX43b0cOY
         a8BLTtQZSX3u41B/IwylFYhNl2BPxA1K3MT93NS3QD47sCw36DvzJqTGZu3B5hKQaP8m
         5Up9cRi4WJHnUQSEomb3SU1wzHy8x7OPoVxeOph1AXsWs4RdLMScglQZsBBmtiQWYJEv
         bYnzXfk2ZW6YGfw1/HPDbeMJJq9fVsLoIPzlRnCc3n5/pTIEtlqX7ragzk4FKYp01iyD
         VXOWcWYwx+v8dljmchxKr/L5psdvXUxor1baIibjrQ0kM4SxdU25GLpcmEwtPfCVM9Xm
         C1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724417501; x=1725022301;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hoe5j+zL5nAbiCIUvREYQpVSE2yifQUHpqXLQ7XWoEA=;
        b=GnybOvg6p9LAvyC6L5Kw1wr7t6zw5A5DiHFjfVpeRDhleoYrOEqtEkaG/HGv638Ehp
         9K36JniNOMNX5lsQli3cvjd1+ykFDJ7HNtxNWTBXIeMOJWH2d+BtgGBODJ7oSUnGjsjN
         Ndz8omWTVDQJKX3jYqQA3jPqzVmAvGrzK52tUR9IE8thvrqPggntDtwx+Y+U6ja5UDgQ
         1ztRyYZn8gq644x5kE+WraWZv2IG2IbwgB/yn2RwlHhTDdnEipU5+LqtjeQaNd7fSZ4d
         CwZAkoRFvD9g2kABYm1CZUEcVkCGSk0+iE3wBk9hmd0c/aBVb/tKM5aYnviwmKNDG48F
         wVNA==
X-Forwarded-Encrypted: i=1; AJvYcCU0NJZ65UcTE0urjsqaVql634aDduS6HbeGLpSWl3pem73c74tLKU+z8M5t4CP13GfB7hL7Zevt2rIUctw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLCi289vTsp+ZCiVmb1h9Qr6s5uavzrQN7d392ZRvd8BATYI00
	UAYXtKQCsjbXqe4JHNWvynmyjkMnObfY8fiWoRtgYp6BxhhsrzFXVBlxtBxjTfU=
X-Google-Smtp-Source: AGHT+IHkggqQwYF252ozofkl8OYWm3rlLNjamoptyTPU8soyrbqGqbFpghbuhPHDyrmStFxt8rYQdw==
X-Received: by 2002:adf:e54a:0:b0:371:8dcc:7f9e with SMTP id ffacd0b85a97d-37311840e04mr1346482f8f.2.1724417501372;
        Fri, 23 Aug 2024 05:51:41 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-373081ffeb8sm4092416f8f.88.2024.08.23.05.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 05:51:41 -0700 (PDT)
Date: Fri, 23 Aug 2024 15:51:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] powercap: intel_rapl: Change an error pointer to NULL
Message-ID: <fa719c6a-8d3b-4cca-9b43-bcd477ff6655@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The rapl_find_package_domain_cpuslocked() function is supposed to
return NULL on error.  This new error patch returns ERR_PTR(-EINVAL) but
none of the callers check for that so it would lead to an Oops.

Fixes: 26096aed255f ("powercap/intel_rapl: Fix the energy-pkg event for AMD CPUs")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/powercap/intel_rapl_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index d110c5da5cfe..2881687d7900 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -2157,7 +2157,7 @@ struct rapl_package *rapl_find_package_domain_cpuslocked(int id, struct rapl_if_
 		      topology_physical_package_id(id) : topology_logical_die_id(id);
 		if (uid < 0) {
 			pr_err("topology_logical_(package/die)_id() returned a negative value");
-			return ERR_PTR(-EINVAL);
+			return NULL;
 		}
 	}
 	else
-- 
2.43.0


