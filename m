Return-Path: <linux-kernel+bounces-383584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3349B1D9B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 13:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CBA21C20ADF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 12:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B29153803;
	Sun, 27 Oct 2024 12:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Llv92SaQ"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9EB2FE33
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 12:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730030897; cv=none; b=idXC6SgBMqqDmPJY5C8+YhtfHYD92mx4kqRQgvOyic4OMAhUT6m7IJEtmKMtOK8keBr9JMVg/eZzKFuUfBg75Pb8kbsWIrbDwXtjXtbWBq33iyy81lZE3ZPJ2ZliDRqAHAnKS/tQeX/dMpDDZSbxTsa22pCbB1A0td1au5KUQB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730030897; c=relaxed/simple;
	bh=noerynl66xmn1/JdRnnTuWpbOb+XLii/WxKOh7vhuC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eVotf4Ohk8dEIxcsKNyZVl/NUbIGeNTnwey1T0+8zO6iyDo+p/GGmssS/uLQnPmxty0jXXZX/LCy9ZHhliJqonThnkYmuOrRCcT1nLeEEmxc0fJ7iWsZx8exZTGTbyTKowmvoZIclHZrWnKaHt9uNtOA1UKXevgHwZCO7yiPPds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Llv92SaQ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c805a0753so32570265ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 05:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730030895; x=1730635695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gcz/4DTHqvkCQ2LiM7SD+jbXbuoBvYH2o1veBs5pO+8=;
        b=Llv92SaQ7twyV0/sSxOZCYoIlCtB+e85ICcMr+K/GDuLARow3Nnwd5RZd1jXQSZ7nm
         FMt5gTYZhiCOAuoKhcoSf4PpWKrvDdVtc3I5DqBux3JN0uO87gn+82AAQbC/f+cLvKzF
         8SLJdg6wA6LHmNMQ/l8hutkmOYOJxfXzIggo1Am6e9kHNWDp4v8nDwYIw1anxKJkqdsa
         aqqZYYn5fGuzVxNdXXGqy3mPBIRq0kVcVY3QixPYzJMhrREtykWzBUXaG6iooxLJXJfN
         N97UZjiBuWxnVUrcQyeu5Uii7FozWHPRIbrc3Xrd0jOvjEnlehRjZa95/ajszupIyJsS
         h+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730030895; x=1730635695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gcz/4DTHqvkCQ2LiM7SD+jbXbuoBvYH2o1veBs5pO+8=;
        b=Hn98VN0fOYF+X3XRDVj1oxoGolDuToqh3+J7F44Phc4wCXP34b1/hVkcQUHkMKz+SJ
         08jpWYYxvjYx3AXZ2wtIlqRZRlypGxXtZHPAwVV209XHBujQK908XC4MFeAmn8dueJkf
         yf8kauFxniRRbY/KgHanhHc3ku1qRF+/m5d7I96t1v2mWfYS5I0LXkLzuQvWN2f19B60
         oq2/lvlrLEit5kHuTCvabgpO9NuVuiV+wUvzegUF0+QLayC3wXUXKiGGG86uFrwd+0y+
         PpYTEXmXsS93PwYpdf++UiSd/ChDBy9Sn0OSwd0Nhb5y8BWLYHLXE88+LU6l9paecR3X
         OI9A==
X-Forwarded-Encrypted: i=1; AJvYcCW8d5wakPeG1eZR68nlQSxRuz3+731gcfDkedZ6PacbHXpA4H+60jc2yJKnCvEkrRnIIKsCqg5Hu8PJP9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOE2ZlStde5H6D5G4xAde/rN0y8K2pMZkq2XsSfE63HsJBlJpk
	9eN/Qo8YB/FqEQjOxZPqbNnb7JwaOUlJXtACBGau57fL7oXHtDev
X-Google-Smtp-Source: AGHT+IH6GX4gkYg2kA0Tkg8+/vZtagN6VHGAmt/oPfHaEmQBn1qj5oF3us/Xvv8X3TiTXVP4n/K+vw==
X-Received: by 2002:a17:902:e851:b0:20c:94f6:3e03 with SMTP id d9443c01a7336-210c6c6a272mr62768785ad.47.1730030895066;
        Sun, 27 Oct 2024 05:08:15 -0700 (PDT)
Received: from localhost.localdomain ([124.156.216.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf43476sm34897435ad.24.2024.10.27.05.08.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 27 Oct 2024 05:08:14 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: dj456119@gmail.com,
	cunhuang@tencent.com,
	leonylgao@tencent.com,
	j.granados@samsung.com,
	jsiddle@redhat.com,
	kent.overstreet@linux.dev,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	david@redhat.com,
	ziy@nvidia.com,
	libang.li@antgroup.com,
	baolin.wang@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	joel.granados@kernel.org,
	linux@weissschuh.net,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH v2 0/2] add detect count for hung tasks
Date: Sun, 27 Oct 2024 20:07:45 +0800
Message-ID: <20241027120747.42833-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This patchset adds a counter, hung_task_detect_count, to track the number
of times hung tasks are detected. 

IHMO, hung tasks are a critical metric. Currently, we detect them by
periodically parsing dmesg. However, this method isn't as user-friendly
as using a counter.

Sometimes, a short-lived issue with NIC or hard drive can quickly decrease
the hung_task_warnings to zero. Without warnings, we must directly access
the node to ensure that there are no more hung tasks and that the system
has recovered. After all, load average alone cannot provide a clear
picture.

Once this counter is in place, in a high-density deployment pattern, we
plan to set hung_task_timeout_secs to a lower number to improve stability,
even though this might result in false positives. And then we can set a
time-based threshold: if hung tasks last beyond this duration, we will
automatically migrate containers to other nodes. Based on past experience,
this approach could help avoid many production disruptions.

Moreover, just like other important events such as OOM that already have
counters, having a dedicated counter for hung tasks makes sense ;)

---

Changes since v1 [1]
====================
 - hung_task: add detect count for hung tasks
   - Update the changelog (per Andrew)
   - Find other folks to CC (per Andrew)

[1] https://lore.kernel.org/linux-mm/20241022114736.83285-1-ioworker0@gmail.com

Lance Yang (2):
  hung_task: add detect count for hung tasks
  hung_task: add docs for hung_task_detect_count

 Documentation/admin-guide/sysctl/kernel.rst |  9 +++++++++
 kernel/hung_task.c                          | 18 ++++++++++++++++++
 2 files changed, 27 insertions(+)

-- 
2.45.2


