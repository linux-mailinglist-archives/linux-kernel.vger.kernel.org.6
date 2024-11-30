Return-Path: <linux-kernel+bounces-426360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CF39DF21B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 18:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA6FFB2155E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 17:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162081A2574;
	Sat, 30 Nov 2024 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJB4A7gb"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8DE8468
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732986188; cv=none; b=BSMiSbQcvWPh3VPRJFXCOEU082SAumxF0vw+j5sYafikIKxoCDXFtU+CRyBQgUKiHch4A15+p1ca3ucKC2ldSzxLJBoDXUWu/GaNvv+rBte1rQMXJQd2PDjXr7oShhgC6GEUj3frsaNfdcloP4kQeKBD0QeMQReJqEfjlISbWYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732986188; c=relaxed/simple;
	bh=Zw1sBRqcwlHgAA4AYzEtDzFNIg/E1q5FbDk3YLmW27w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fNUiv+w4TdTXspWNn7BIwE9RMTbnQC/p4f7yQm1c1uzcC5uhFdZHLw5/ruum8wYEADfbMLJZpkY2iRzaMNBdb1Zr/aX8/BEZvuX4b69MuNlRRovCJBdADZVQtsXVTL+vNvF4sas6f57oZlZObfgQ1ueyIlM7DiXZjMUl3wwADa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJB4A7gb; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7251331e756so2701477b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 09:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732986186; x=1733590986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R0AaYkKFQsr+kvv/7MjgBXXDtojf1j/34zDnDrr0iLo=;
        b=OJB4A7gblnWGshSatkhO0zH46/pLaqUipMA8vfPA2gsvhYi7ncR2N2bbW8poDQuikJ
         jAjHKu0ygIW6W0OsJvR3KsEV4SJLMkbwt2uhBWVu8jkvAvDtIfz8+o0SLRqNqmn3Sn6t
         A7MtlzL4Xa1Kkj5ov8jlDJPwnRFNoFGHxAnbI3TbbubODKdgZcOda48jM0ThHgOPK0b/
         Xa+2XKv1wbXEHfOGw4m3tlhUpxgkWGpFxrnP4yxfgMcTFhMvKXWqmxZSXNewWcjsxuDl
         TuUj3aua7UnBhXJvlqdUib1hWDg9iGJMsUEYB59lEnKaVRDEzbUIhsGFmhsLVDIFjziq
         5dQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732986186; x=1733590986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R0AaYkKFQsr+kvv/7MjgBXXDtojf1j/34zDnDrr0iLo=;
        b=W2S9DkqvsWjO2dHVZeCwsEZSFIUS8ANeZre6s6Cw0C4jRecM9JfNT+eBz5WPqJ/cM+
         XvtTflmk7A4MTjPLUXQSWPMgtZz8020ywMhTXAUk74BJpzXOWkDf5WRHPkgDoGKhbYxi
         TdLNrPB4u0Kh8efZmNTUR+xcHY7qBn1LJdmo6vD+5ZDP2qQgrFcQ8NkL59FneFl+hWKm
         37ZOF5+3VyWkJ4nLQMplBicJABeP9htO4QfQpBbiugqzrfscV2WYhMAYzgddtgOjIcvG
         QxQNG9/9yqvpUwvcAJdXxoJLPt9M0cvateiimHcX5KmrJkqefnMC/0izdZTkPjScc95r
         LY5A==
X-Forwarded-Encrypted: i=1; AJvYcCWLjEgnEaygp5V3smNsabXIRODpIymgNoLf2SIlYBM8zAIBaQ37NCIMxgwcID/+XJ5SIpClTgHguQehIbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBNAl4meR743/HLAMGjqJ8H1HGQ0PTwQ17SGV8t/JvLKXnHecQ
	RlqazauMYL7kGHut5SYM26oNyady9pE3hrQvJhkQQ/LA1NF966Xh
X-Gm-Gg: ASbGnctoqpsO0hEbtGiLC4oTJoCTtgHYvCJ1KhU6F70omKzJuEOzUJJv6NC9eH+Yj0M
	RHiwe0+bw0QxNAsYQGwzPxbjfI6lhPdShYXAu4hEweRRLSyM793oCzCBLpHEH3bgA70PuTbkEf5
	FB/EMKipbedAsmhmwbH4I5o/iRawF3zfUyJsbjsRYUq2dM0o/G5DIH1EsXZyQsE+vTjzqcVu2C2
	E/mTszOzR+78Py+X9aw9ohTDHYkEByjisn654yqts+ahz2ztL+aSu8=
X-Google-Smtp-Source: AGHT+IHQKp97T17O74v5McT9T0BT8I/76CwyQ8bY2zWeqhgmq05Cw932j8Sn1yhdnHCSU0pyiULZTw==
X-Received: by 2002:a05:6a00:410b:b0:725:31f2:5d0f with SMTP id d2e1a72fcca58-72531f25d78mr25094931b3a.8.1732986186262;
        Sat, 30 Nov 2024 09:03:06 -0800 (PST)
Received: from eleanor-wkdl.. ([140.116.96.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725442c086csm5319466b3a.189.2024.11.30.09.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 09:03:05 -0800 (PST)
From: Yu-Chun Lin <eleanor15x@gmail.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	visitorckw@gmail.com,
	jserv@ccns.ncku.edu.tw,
	Yu-Chun Lin <eleanor15x@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] nvmet: replace kmalloc + memset with kzalloc for data allocation
Date: Sun,  1 Dec 2024 01:02:58 +0800
Message-ID: <20241130170258.103954-1-eleanor15x@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cocci warnings: (new ones prefixed by >>)
>> drivers/nvme/target/pr.c:831:8-15: WARNING: kzalloc should be used for data, instead of kmalloc/memset

The pattern of using 'kmalloc' followed by 'memset' is replaced with
'kzalloc', which is functionally equivalent to 'kmalloc' + 'memset',
but more efficient. 'kzalloc' automatically zeroes the allocated
memory, making it a faster and more streamlined solution.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202411301434.LEckbcWx-lkp@intel.com/
Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
---
build test only.

 drivers/nvme/target/pr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
index 25a02b50d9f3..90e9f5bbe581 100644
--- a/drivers/nvme/target/pr.c
+++ b/drivers/nvme/target/pr.c
@@ -828,12 +828,11 @@ static void nvmet_execute_pr_report(struct nvmet_req *req)
 		goto out;
 	}
 
-	data = kmalloc(num_bytes, GFP_KERNEL);
+	data = kzalloc(num_bytes, GFP_KERNEL);
 	if (!data) {
 		status = NVME_SC_INTERNAL;
 		goto out;
 	}
-	memset(data, 0, num_bytes);
 	data->gen = cpu_to_le32(atomic_read(&pr->generation));
 	data->ptpls = 0;
 	ctrl_eds = data->regctl_eds;
-- 
2.43.0


