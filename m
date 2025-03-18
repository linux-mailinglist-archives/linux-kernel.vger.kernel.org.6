Return-Path: <linux-kernel+bounces-566739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B68AA67BEB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A99E176F75
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EEB212D67;
	Tue, 18 Mar 2025 18:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIEnPSXS"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDEE15573F;
	Tue, 18 Mar 2025 18:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742322634; cv=none; b=mEpmWUHEF7FL2jMgAjMZiZvpjdHJFy0nUv0TlIf4EGoNOVJLcfB7oWMZbkrUo/S3KgyZuebGpGLdNc0l11Q5MerDqqVDDaAv/ZiNjJyFkmwoIvNG0qmuDqvHwWxFmT8dKiv5immm17vHpPBoALW4mMLW4lh6+UbwB7NWoaLGfkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742322634; c=relaxed/simple;
	bh=jtPd6L3WPVafuKL/M/pP21GaWG+ZlzZExDbdGNjwH0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pg0Q+HvUlZFqgRbbwzR2No0DdcReESudtRF4HQVw8UuS9z58Fl2CS63zv6cGB4ilIoVrFXbZ9tHTL03aCuGTA/qEcIv2WtsgZpiXmKE4RuCJjCciidp9KpYhp+biEEK13JZL8LFv1Anz3f3d/1HBI89EK+nvXMr7XeEUlT9CTn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIEnPSXS; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6feafc707d3so49942217b3.1;
        Tue, 18 Mar 2025 11:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742322631; x=1742927431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7dHZIJ+1QQf0s+w5mDsBJ5Q7CgPW+8y1ul/VglaOsY=;
        b=EIEnPSXSuwFA3jj9OT1pKE8Ex89v62mG0f99az784xPJVYxfTcASvGNzl2iJc338fz
         LjTzYHScyEQvbAGi8yNNSeGStiGWsvPCIDY3eAdKLEuX5uXfk0wy3gcyN3rpe/sZksvT
         IUePcva+dtrLbzt9e0sO+NRIvMf30x7feizpyTzxeGjJ6I9HLlGi52jFmt+Toz4e7H3f
         +0cVLAqs/C4y/6ZeWaFm9RhSR19aqRjREeOTCPijRVV4yAWr6tg39ZWZPlf3L+Y01ApV
         Tot/1S9s1ZtAaXtLSPN+aFqnZHC3wqML6VA0otcjmUBblEoLYo6pktwwQRIl28eg0AwZ
         sy6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742322631; x=1742927431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7dHZIJ+1QQf0s+w5mDsBJ5Q7CgPW+8y1ul/VglaOsY=;
        b=Y4L9a9rE1E1jslihnf5YWdLo1ptB09E++4fAZFEyi4+slxWMEJTiG4IO11LENn6qV1
         dgVhuQcczNAt7qGYLrPkMt8qt9ZEw7Q27fJm+Oml3DZpXjgyx+Co/IuO7r0hgYWmes7K
         LOsevTuGWbAOwebc6ASJGXr+TPPA/iswbsuA3tb2YPDLxfinRkpf1N+8qYoIloDBrxaI
         TvWgtbDuqSc1RhfOaVRiT4kt59pC3LB9FIP+cbB/+NzKjl7nA/90R7t++dcZbJw47bQi
         TDkjzQ9d3L9Hiyzdb9+2fgI2KaZUTRB5zXhzh7B+N3aXwFPoRunnV5wUoSUGwVcw2eKl
         gH2A==
X-Forwarded-Encrypted: i=1; AJvYcCUM3drCgWWYqlbuKC1qfpHa22eWpchikpFhs+qaVFVqNjNpD47cZso8cxGKOauTCaU7KCT7blLemm4=@vger.kernel.org, AJvYcCVqMuLOLbVWwfo3sDOAowdogqORqmqIf87D5Y4bUuasiEO4vhgnIZ0iLjh47Iom0GnLvgyJ7t9kxdAXc3Mv@vger.kernel.org
X-Gm-Message-State: AOJu0YxFYqy5svtzZmG/Z9MC+LjgHHltNpi26WaUvSKaFMYDwDdy7Ca5
	YwUTS1H/1P2Pe93mivChntO6UC2180OTcIKKygBEXWxHrPslMs6o
X-Gm-Gg: ASbGncvtsH2XI049Z0P4NJGNgloLIo5h6hQMwey9/x/sAfea59/CEsrcS0DCZzIERo7
	9v1RdSEu9o9heX5G7cRfksq6Axbun1z9UzcBm/zsPh/3LaF32WNSnfqhkVQSWgWbmm34xFGht3+
	KR50uNYjQnwc0XckX92kYMYuh2PWOO1Qhxh43HUACHb3wis2w6tG9/hIghXFvzN+IpC/Tsy1RHH
	LatbQ7htjKsh4fntRINdLb2HGilu93AhbB5/d3sUc8H4/50T/gEnJCWen8AwniNQVvmZpLsw7Z2
	4lcA+LBK9mZYV93jd4MlNvb4QvSSLJFYJ2Rcq/QzNKG95UM=
X-Google-Smtp-Source: AGHT+IHzVcio/RehLS+OJa+pt9OmpDqftnHs1DTMVg69hwSaI3nwUmwUTpUpvJoIntd97Ze/CrCzjg==
X-Received: by 2002:a05:690c:3613:b0:6f9:a8e7:430 with SMTP id 00721157ae682-6ff45e687aemr204575987b3.4.1742322631486;
        Tue, 18 Mar 2025 11:30:31 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:71::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ff32c80f2esm27165887b3.90.2025.03.18.11.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 11:30:31 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: sj@kernel.org,
	corbet@lwn.net,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	damon@lists.linux.dev
Subject: [PATCH 2/2] Docs/mm/damon/design: document active DAMOS filter type
Date: Tue, 18 Mar 2025 11:30:29 -0700
Message-ID: <20250318183029.2062917-3-nphamcs@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250318183029.2062917-1-nphamcs@gmail.com>
References: <20250318183029.2062917-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document availability and meaning of "active" DAMOS filter type on
design document.  Since introduction of the type requires no additional
user ABI, usage and ABI document need no update.

Suggested-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 Documentation/mm/damon/design.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index aae3a691ee69..f12d33749329 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -656,6 +656,8 @@ Below ``type`` of filters are currently supported.
 - Operations layer handled, supported by only ``paddr`` operations set.
     - anon
         - Applied to pages that containing data that not stored in files.
+    - active
+        - Applied to active pages.
     - memcg
         - Applied to pages that belonging to a given cgroup.
     - young
-- 
2.47.1


