Return-Path: <linux-kernel+bounces-322165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B199972533
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 00:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 140311F24AA7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FA918D620;
	Mon,  9 Sep 2024 22:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOE/e8gS"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C348318C928
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 22:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725920396; cv=none; b=D6w2+sjbjN1B+N2zYgPRGU+yZu9JiO0x/h+o6X7M3KZcYoNud4Ipow10WMncsUt5TymhZ6mu5JJfoZvriWHIUAbvcUtM/rKOHYvcWYxsB3b0//26WqR1q3v36uBAoSTYD+um+uSisc70Fo53jA0k4Bw+olAilbmGRuKdf0I4+Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725920396; c=relaxed/simple;
	bh=yIfTgD1oTsrdpiM/rP7Fctv+1/IYOaeQQBb0GKjPILE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dku5jMJDhSTa3ihNW2jHKO2Zfyy1A318v0NAfAKS1GPpd2jyec34kqbSkrhVV5YvEGsksoP6FukVwKwBatd2+ArMZmhJHmzugSP+lDaCvfC0goXFMHfVjGtc+XEOAWEAlsq0GNZYiK2TvcOnSn8G9LSMvEbuBn5QviwXidyqKK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOE/e8gS; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d8a7c50607so3185842a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 15:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725920394; x=1726525194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ju9SGTU3qrpQt9b2K14pzpemAOmcwhjJLKLVpOR2qY=;
        b=hOE/e8gSn5aISy0FLYxrUV/4CGIc0ZjpjUm4cQVikmu+4qDVZByNiPSgKFmWS9fYbP
         muiifuWca/dR6Jod8A++VAEW2umT1Vi3Tf50hn+f91BEii5/SDYZ9qVUY8ApuE3BT7kd
         DHfDDHVqwBrJcTGzDBe4qxMn05doqEB3b+YgtgqL8gTLalonhDMd9gunHsQ+F+ZDOOAj
         AaH5wWTraZrrJutSFe9ST/9DHGUQ6fSTUPLGrhmnu2246fXuAXY7DZ2YQ8G8/ixpB8/a
         xSMWHh5hfW/4JbHX4Kr4nIXt4HIJ2IpLYYbLnA8Jy/cnYwgj9Gxu0t6jxRbcJPfCHot1
         zDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725920394; x=1726525194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ju9SGTU3qrpQt9b2K14pzpemAOmcwhjJLKLVpOR2qY=;
        b=MeoKfLcrVm2SYuKB+cTjh5WBKpW54/lZ1hI3+XzO1lrD4byyqMiCvj/ll1FxvOVynG
         V649IFZqTdMRlG4K3bPzWHXmMkhPiHKgFKh4PKKKT5pjPHD1fKemXq76HtMZy6UqjHHJ
         1VBzVsv6DueA3BduoKcJgVul1vdfd5Fz5YMORP4EWh3XA4YeN5ud9MosUTlCuf7dytBw
         1euCRxEyfhIsnmssY2d4HKe4F13r1nAs70CH4OYhZa4h8sseuow2KL8cSJE5IRdeYSYr
         hXu84cA7DzNaR4wZ8fe37nPlb2RSJjmTPy90ENjqfqId6JRh35yAFQwM18O2X/ToeZY2
         TeGg==
X-Gm-Message-State: AOJu0YyLtLZm/UsVOciqPMiQHhyIea5M7bx2cpKdPjutiv3criGDLy71
	TRCtYRKwPiyEpdK9m3IkDusD2WPdOJChRvCTk1ynftl/QrXkxsTrVTA0Iw==
X-Google-Smtp-Source: AGHT+IEiweGW9x3af6N5AmUP+sYWfEa5idVX2NKd9Gi5tR4l5i+m0dhJU50vaHHcEmOfeF3QpFpMLg==
X-Received: by 2002:a17:90a:f16:b0:2cc:ef14:89e3 with SMTP id 98e67ed59e1d1-2dad4ef808cmr14005403a91.15.1725920393685;
        Mon, 09 Sep 2024 15:19:53 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:ed56:14c3:db02:6c66])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db04988470sm5016840a91.54.2024.09.09.15.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 15:19:53 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2 3/7] f2fs: add reserved_segments sysfs node
Date: Mon,  9 Sep 2024 15:19:42 -0700
Message-ID: <20240909221946.2004046-3-daeho43@gmail.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
In-Reply-To: <20240909221946.2004046-1-daeho43@gmail.com>
References: <20240909221946.2004046-1-daeho43@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

For the fine tuning of GC behavior, add reserved_segments sysfs node.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 6 ++++++
 fs/f2fs/sysfs.c                         | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 9165f617d216..deff703035e1 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -771,3 +771,9 @@ Description:	Controls migration window granularity of garbage collection on larg
 		section. it can control the scanning window granularity for GC migration
 		in a unit of segment, while migration_granularity controls the number
 		of segments which can be migrated at the same turn.
+
+What:		/sys/fs/f2fs/<disk>/reserved_segments
+Date:		September 2024
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	In order to fine tune GC behavior, we can control the number of
+		reserved segments.
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 66d15609d5ad..761d1abd46a8 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -974,6 +974,7 @@ SM_INFO_GENERAL_RW_ATTR(min_fsync_blocks);
 SM_INFO_GENERAL_RW_ATTR(min_seq_blocks);
 SM_INFO_GENERAL_RW_ATTR(min_hot_blocks);
 SM_INFO_GENERAL_RW_ATTR(min_ssr_sections);
+SM_INFO_GENERAL_RW_ATTR(reserved_segments);
 
 /* DCC_INFO ATTR */
 DCC_INFO_RW_ATTR(max_small_discards, max_discards);
@@ -1144,6 +1145,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(min_seq_blocks),
 	ATTR_LIST(min_hot_blocks),
 	ATTR_LIST(min_ssr_sections),
+	ATTR_LIST(reserved_segments),
 	ATTR_LIST(max_victim_search),
 	ATTR_LIST(migration_granularity),
 	ATTR_LIST(migration_window_granularity),
-- 
2.46.0.598.g6f2099f65c-goog


