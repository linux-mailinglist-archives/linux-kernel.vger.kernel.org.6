Return-Path: <linux-kernel+bounces-306634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC5196418D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 049362874D4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CA81AC89F;
	Thu, 29 Aug 2024 10:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kcsav2lU"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ED6191F9E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926772; cv=none; b=EgJ1Aby/zHDYidRmLEW1K2BzYVCkpfkg3iNfzCByaLdPqFr6tIUqF1UQvPWcM10uDn3VEYnqHIl6GUeNfT3nFNMoDCUKQyX5Dc3mKfm0i76FB+HJaOM/ThTcPUsCtUPA9BsQODz+Kwl0vPXUZzSV0sFB0BKv/U3H5knke0mppYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926772; c=relaxed/simple;
	bh=5nWr5B4GB85GsqmJ7v3ZXbQ1xAh3wVALIRZsyahieU8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SbAXkqvS5I2o0uB6401k6TXvCa09BK9ODXZsm5TAAFLDFZz35vnJlFA0reKuZ3XGyHJli5Od8F+rL0QeZ6/YMaeYpiZRq2PtYyFt/0FaQfCPCfIj2hN0XGHsbzdI3OguldNMmcnUZ2wRJxloAcOjXi+N+4dYgDEOsOV5YOHVwok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kcsav2lU; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7141b04e7a3so424365b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724926770; x=1725531570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FLZw23XkOzc6bRGw9yd5cNf3epruUgLmmmKcBkgtqCw=;
        b=kcsav2lUrWDyb8LpJPy9Ee941GeoUyUnXpZPm7OMhcj/ULGc799ipXdv2OG1HAxGct
         18Y0wTujY5jzQTPtjObv0LkhscboHIp3HSq47nDG+oHjOGDWvYRutexGGg1da/aXIPco
         8A8MV1ftJuGAG1Ak0KyPBJHSETezczsq0GVxTmPBjEvBQl5WXVWysD83IpaU09M91ykF
         28mtezrZoiKvGN2fWrdmRKBbdnfZiFRvXFWbEnG+JWfZQbKPPaGrvyYBBM5ZGLf/+B6W
         eF9MIEIXs3bRFnvkWr720KQHfJB2OJ3muM1FrZ69hN141XOWT/ACMrXv5AnIC0pxpCoa
         W4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926770; x=1725531570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLZw23XkOzc6bRGw9yd5cNf3epruUgLmmmKcBkgtqCw=;
        b=BSXakAaVyIoCUHfnYHngKIAZhZmgmm0FfAg6I5buzlAVAi8z8lPjieDzYeBCtMxNp4
         nSVj0qFLS/VB7QZ9lCGIowOVafKBdW/L+IcSkeUT2B5P43WwqS0thowVRnJQX9fiqcd6
         H2bKxdhjxJAJEIS4qV4GH9GJz0NsJqxA1WPxGhN+gOp0sJcQR9Gjrnfa+HgL5IJeUI/d
         W/ayYIytJ3PjmCMyTZeQ1B3kAjtMaHHfAUOV63e5XIG5jRfMsJgn4saHPsHtksu0LOhE
         XOdZt8Avotq0lbdFXp054x9qELZPsESRz4sgeqAtuMiV2gocO2l8rhvdQ5ah9oVDpzc1
         PqFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcto/3K7WqiI1CdhVHvkCVjVVxEXi3g1E50O2gnR46otdp9Upc0mR+pPxxHBfsphTrs5EVjLrLlz44tFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTbeQ2riqUbGLpj3lnY7Ic3R32LY1qhQuDdXxrW/chtqi2350x
	Ouw4YRuDMyUaka/CIBpBmWgUClER6fuGzYAMZ4EgxKMp4Ir2e+ri5TtiaMM2A3bz4GHy9+WJgYC
	8
X-Google-Smtp-Source: AGHT+IFIKkW/GME2WB37S6Icf1LvrURHazG/BMTTIoPk3O0B5HuY8rq4leOo17BgMXHb3gk5eadxCg==
X-Received: by 2002:a05:6a20:e687:b0:1c0:e925:f3e1 with SMTP id adf61e73a8af0-1cce10f41f6mr2121458637.50.1724926769821;
        Thu, 29 Aug 2024 03:19:29 -0700 (PDT)
Received: from n37-034-248.byted.org ([180.184.51.40])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9d4ee3sm785119a12.83.2024.08.29.03.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:19:28 -0700 (PDT)
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
To: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org
Cc: roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	lizefan.x@bytedance.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [RFC PATCH 0/2] Add disable_unmap_file arg to memory.reclaim
Date: Thu, 29 Aug 2024 18:19:16 +0800
Message-Id: <20240829101918.3454840-1-hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch proposes augmenting the memory.reclaim interface with a
disable_unmap_file argument that will skip the mapped pages in
that reclaim attempt.

For example:

echo "2M disable_unmap_file" > /sys/fs/cgroup/test/memory.reclaim

will perform reclaim on the test cgroup with no mapped file page.

The memory.reclaim is a useful interface. We can carry out proactive
memory reclaim in the user space, which can increase the utilization
rate of memory. 

In the actual usage scenarios, we found that when there are sufficient
anonymous pages, mapped file pages with a relatively small proportion
would still be reclaimed. This is likely to cause an increase in
refaults and an increase in task delay, because mapped file pages
usually include important executable codes, data, and shared libraries,
etc. According to the verified situation, if we can skip this part of
the memory, the task delay will be reduced.

IMO,it is difficult to balance the priorities of various pages in the
kernel, there are too many scenarios to consider. However, for the
scenario of proactive memory reclaim in user space, we can make a
simple judgment in this case.

Zhongkun He (2):
  mm: vmscan: modify the semantics of scan_control.may_unmap to
    UNMAP_ANON and UNMAP_FILE
  mm: memcg: add disbale_unmap_file arg to memory.reclaim

 include/linux/swap.h |  1 +
 mm/memcontrol.c      |  9 ++++--
 mm/vmscan.c          | 65 ++++++++++++++++++++++++++++++++++----------
 3 files changed, 59 insertions(+), 16 deletions(-)

-- 
2.20.1


