Return-Path: <linux-kernel+bounces-391985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B27909B8E35
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 10:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 567EEB2141B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 09:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259E715ADA1;
	Fri,  1 Nov 2024 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jwQ3JUgC"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F0A158870
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 09:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730454911; cv=none; b=FW71hiB7y0yiOl6pwp1pBIje202qX6Yyt1mUKEIoF26HK3xuQGHeMMULub9O6ZPr7sl/OPzWgugDb6+hXJnUADURRiXk58PN/xyQVbOrJPhzRK0F5+rzXPxcd97QCsut9d1wdsBtQL2AehBzPeeIibGH7Xk8UZ8BId/gpBBoglw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730454911; c=relaxed/simple;
	bh=fk7KTD9fgJ7VH4wLOaICJs2JRX5gZLgDAq+3FdiAnMI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=XZoSCzfFotH2sCpdip3awx1O1h6kN7xNqHRODWNydKQOPzwYI93NHHlo40/DrmxWapQnoWR+O7Uz6VCCFc6V8HZjjm+Xs+bOlpNsiEHLfq7TsRPmDMX5+KDC1g+gXLM2vIDLSDysTRY3ul0vpaArpT6nDhJ/dvBGZlxG8PLwpf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jwQ3JUgC; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20c9978a221so18592585ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 02:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730454907; x=1731059707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QUcSqKxh8PfJmGTPunCdl9RD0jnPfoQbCentgp/YDs8=;
        b=jwQ3JUgCdgbZNlvRd5/DgE15O+4x9kfVYDH9u9YXLbWyyvdN3SksugwQByIDFA5o6k
         ST45w5HMAGw2mxVtAfvifdxozIn5XNc4zcA+7gVSlOv4eOK9Cw00qDoapTFRDELoVNt6
         i8ggMuWHkMhfWrCV5wt7C0kyDQIoEV95FwRmBrqpdYDNLXUfoxruvxnjm0FEeY+BH8Va
         GU+qL4DKMy+2qZxaK/mwVYASL0D6BwGObHhcYDYR94wJL+i8IFqjEHmyhKypkORJZtIV
         MA2IYREL+LNMkcBltk8TCp/NEk7BSRZGn5Gk67EJvANYJR7JaMqHY14ZrjaoBhLkhuLl
         5HXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730454907; x=1731059707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QUcSqKxh8PfJmGTPunCdl9RD0jnPfoQbCentgp/YDs8=;
        b=CISYCepMVvhaz3kp2p7BfxbjNx630jgyqdB384+ZTg+AWnpuNsi82WiXVwGjZpBC5+
         SM/kBW6nBxPkpk66uEALBTtyMuUzZUWJNFoKIUtQT0lkb8CC/1UvZ8BnV1zJZowqSkwI
         fUOrMIx3OrnRQF69ppXXpbrGNahoRLXktCRV1PuVQfhh/lZKHR1CyBvPpnQoNXzR9Lcz
         J30jguyt2t9P+BlKIlIphoTaFTtoV0uiIBOCGWXeT7KfJQLVKsktlnOd6yyrlCWg/BYO
         w6BjpYxnPbvzM6/JZkdTMnFORpk66jjQZy14O/8Q52V1R3NcAThKdgtMOlDgp1Wtpb2O
         XE9A==
X-Forwarded-Encrypted: i=1; AJvYcCWFFomTNWGQY9mdOcxEkSbjuDTgX5s6kl7MZ1OzYPuxN1SMhZ//xR5ET080dvvS7VI4y8qPQVk9OBdFRiw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5op2fa7wjsnfV9hnJ/HfIMhUiaVXKhrWlrYVAzLOZg540SV8I
	dYQecvbOoswuYoSZ8DkMYPR9MwpngwUnr79KSq9jWgtWKywSF4e9SBbO4yyOzIs=
X-Google-Smtp-Source: AGHT+IGZ6s2M4wWBQ7i971qYJE8UZ1/VrrNCrsq9Yr/YMhPj/FzgAq7VPvy8g3uqSUyc/PE4fWA34g==
X-Received: by 2002:a17:903:2b03:b0:20c:5e86:9b68 with SMTP id d9443c01a7336-210c68a1a99mr333797045ad.4.1730454907228;
        Fri, 01 Nov 2024 02:55:07 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d99besm18962975ad.286.2024.11.01.02.55.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 01 Nov 2024 02:55:06 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	longman@redhat.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zefan Li <lizf.kern@gmail.com>,
	Zefan Li <lizefan.x@bytedance.com>
Subject: [PATCH] MAINTAINERS: remove Zefan Li
Date: Fri,  1 Nov 2024 17:54:09 +0800
Message-Id: <20241101095409.56794-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

From: Zefan Li <lizf.kern@gmail.com>

Not active for a long time, so remove myself from MAINTAINERS.

Cc: Zefan Li <lizefan.x@bytedance.com>
Signed-off-by: Zefan Li <lizf.kern@gmail.com>
---
 CREDITS     | 3 +++
 MAINTAINERS | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/CREDITS b/CREDITS
index d6cbd4c792a12..a00efbebc3369 100644
--- a/CREDITS
+++ b/CREDITS
@@ -477,6 +477,9 @@ D: Various fixes (mostly networking)
 S: Montreal, Quebec
 S: Canada
 
+N: Zefan Li
+D: Contribution to control group stuff
+
 N: Zoltán Böszörményi
 E: zboszor@mail.externet.hu
 D: MTRR emulation with Cyrix style ARR registers, Athlon MTRR support
diff --git a/MAINTAINERS b/MAINTAINERS
index 32a63c456aa0d..e6db40f53784f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5664,7 +5664,6 @@ F:	kernel/context_tracking.c
 
 CONTROL GROUP (CGROUP)
 M:	Tejun Heo <tj@kernel.org>
-M:	Zefan Li <lizefan.x@bytedance.com>
 M:	Johannes Weiner <hannes@cmpxchg.org>
 M:	Michal Koutný <mkoutny@suse.com>
 L:	cgroups@vger.kernel.org
@@ -5693,7 +5692,6 @@ F:	include/linux/blk-cgroup.h
 
 CONTROL GROUP - CPUSET
 M:	Waiman Long <longman@redhat.com>
-M:	Zefan Li <lizefan.x@bytedance.com>
 L:	cgroups@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git
-- 
2.20.1


