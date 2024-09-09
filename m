Return-Path: <linux-kernel+bounces-321775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B89B7971F4C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62AA31F23FE5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADE316DEB2;
	Mon,  9 Sep 2024 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ObFN8+UA"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3584C165F02
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725899550; cv=none; b=RrEnedUd3PqtqHyYm+8hpqzANCKrDXqjzwuz/ehsp1SK8E45KSYnIMcoPkc4Of4ECtayTlATcSU0kpG5VXHLe3q+1BhxRT3f5vzhIpCKte604uUDF4w1MiDxvx4NjZkw2zhYwpDJf66MY+EE7gD6hsYuxKl2sL7rtz7uEu+9un0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725899550; c=relaxed/simple;
	bh=2dl50MWEQzC24F83Se6WYTJB2+6Ho7Nrx7KziWZ9PfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BKMm8aRUXY5ckUrEZbjP/yZUJ+zlts6u5Jmv6EU6Hh/5x7puiYvabGY6W2m5GtLIEpfUXiI0AGdBQIASGISr4DkaE9Ij69EHGaLFpZ/FwRk9YKEt2LWztdSBAd/unBbWSpD3PSgyRmiRn9eDd2BkrCFdviCZwOnlsB08Jf3YvgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ObFN8+UA; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cb58d810eso8001065e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 09:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725899545; x=1726504345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=01TvFQ8Q33lZ5OEXLtjKixrpDvHdGUhYpWD+3boosg0=;
        b=ObFN8+UA/cOYbahX9w7VMKtcrUNj8MwbCEcOEDk975Zos4MI9CdAlrZ0Qs3+xAYaLj
         ElaWQ20WbCstXDFQqD4wcsxypjNF6RT8/yg53YllAXpYv1xo+PDxnneUwNfGYAJ8qHOJ
         uAfRMr/eaFMQBE15b2yST3DAI5IZM4Y1z9NKTsj1ePqeaM8Iq+x8wYrNo2c+wjZ0GhZH
         0ZigccmrPL59vl6FgUbvMmomHFNbfcAZbhLf93LRRMvvSTGCc1pVjyeQxcezg677/fyz
         aXb9qgOqHdA+AzkIePO4liMP96LF8NWSKNXlx6o/Hs5CR7oz5mUrDWXx9AJe2T2YAOm+
         0X6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725899545; x=1726504345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=01TvFQ8Q33lZ5OEXLtjKixrpDvHdGUhYpWD+3boosg0=;
        b=ldyRp++Xe3WgspneOqss5HYa8Avl4aZk4j6PN25mpK1NFQxIDA24Y7V+Tnnu1fn8rQ
         Jnfvyy0d1FsLEU4oUOCGLmo5nNkqRTU17zyfhEhCiGQaaG/cll2L+gz1Akiv09KwoE25
         FF2QZDnNjcwx4zX6QkdDtD7lXrIOh6ttsAo6uZoMkNhaM3aVyeuJ0SDKrY3JQi3k46rx
         gLIA3gP4a34HzFyF4KYWH8XPWQV75eglT83X29Lqk8s+PpxFrRoqWmyI9QFJL1ZZ04O8
         VWBMHRIfuuAu+CO1bCDdYrLZ5q7UtwiDAWkkdFcXT1K+HGkH1etL7fYGcH0StfIGEQyv
         pirw==
X-Forwarded-Encrypted: i=1; AJvYcCU9Osi3LXMSmIKj4EU4LcrHdGP1adFzJqsg44kppKmymGU2cDcGl10SKeuC8NlrhsyfvCu6ZangpEIdVh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb7Z2IDOBHZajFRxTsTlspGWEzH7TZEM9jPY3O+ZIQXlN1Fqd4
	e2gKLUSQaJwdZ+rWVn/ZmDpXsB519JFaXSKLPZZm9dDWSpcums+Ga10BXk4ywqVK3OFVfN+IkaA
	a
X-Google-Smtp-Source: AGHT+IEoB20U25poJ8OoF6N2TSMoqHcMm3X67rhrGHHhO2tZ7wzs4+DbWWaBCovC49KP4Vwd5vxErg==
X-Received: by 2002:a5d:4ec9:0:b0:374:bd00:d1e with SMTP id ffacd0b85a97d-378a89e6350mr137262f8f.3.1725899545364;
        Mon, 09 Sep 2024 09:32:25 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789564a072sm6478606f8f.2.2024.09.09.09.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 09:32:25 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chen Ridong <chenridong@huawei.com>
Subject: [PATCH 0/4] Followups to controllers' v1 compilation
Date: Mon,  9 Sep 2024 18:32:19 +0200
Message-ID: <20240909163223.3693529-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The group of patches builds upon recent dissection of memory and cpuset
controller v1 code to under a separate configuration option. The goal of
them patches is to produce behavior that appears to v1 controlelr users
same like if the controller wasn't compiled at all (and no change to v2
users).
Plus there are two preceding patches with cleanups I came across when
looking at the new code.

Michal Koutný (4):
  memcg: Cleanup with !CONFIG_MEMCG_V1
  cgroup/cpuset: Expose cpuset filesystem with cpuset v1 only
  cgroup: Disallow mounting v1 hierarchies without controller
    implementation
  cgroup: Do not report unavailable v1 controllers in /proc/cgroups

 kernel/cgroup/cgroup-v1.c | 17 ++++++++++++++---
 kernel/cgroup/cgroup.c    |  4 ++--
 mm/memcontrol-v1.h        |  2 --
 3 files changed, 16 insertions(+), 7 deletions(-)


base-commit: 8c7e22fc917a0d76794ebf3fcd81f9d91cee4f5d
-- 
2.46.0


