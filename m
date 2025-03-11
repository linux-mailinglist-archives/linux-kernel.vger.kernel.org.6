Return-Path: <linux-kernel+bounces-556147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C3BA5C185
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E991918843EF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED06D25B669;
	Tue, 11 Mar 2025 12:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NsLYiDJZ"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3197525A2DD
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696628; cv=none; b=eZqt0/VlWPrYP+16hM2LXKK7TtwhXHwujJcwQ2p5fzVY6cX8htAogXPSwFuvHvCZ9+EOxn6p06LdXnj+vgiUcduF+rvYaWmbkXbvYSUhnxbCeot/zBSpxeav0OQ7EBuisS2NCDcqK+NXgXjc7VkUcWneKdN4JTjYFboRTSjSmOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696628; c=relaxed/simple;
	bh=zNk+oVMzTrxJrAV3YPS/mCKpQLRaGo/5NfuNYVLO0DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s5zEZg1kN+qt+dyjl8cKCKS91NTpJnj17CISIgsFEIG0E3MSt0BNn3bO9pcQZycev13TCb0MLDsOlzzqYa22NBPeTCZykNZskZuwXC56G26K3i6fsHdksha01iXUyQrLTjGRfFQ9TqzMAI7BOro8Uwpl7l1eVoayy/pt/jejkrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NsLYiDJZ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-391342fc1f6so4179813f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 05:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741696624; x=1742301424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOohSrQvPqKoJS058lh6ERBfYfFVZu79WxTYWxna9iQ=;
        b=NsLYiDJZXlp7X/saeDGXIS/Eaf+BKJNGesltZPBd8n7nt3ewjAG1USbmbfviciduEl
         sKGNWnhT1w4L1QLII2a2/uDNltVybXrv5eki9+Y4wEEAsqX0oyOgIJZcL8A6mmydItE2
         9UzKt3FhDdPAJUvm2sdwVV/ehIcVTRHtYe/MGvsT1qYtivvYqkXCsNnE95qUt1P1uVjW
         IO8+aTFlGyAJdW6n/SjUE5wOzTHxZUrUfHoRsyrNzuJVaVkm3GtJ4XDh04/VhzlwgpYR
         oA5LIMjNm0Jpat1DUiLsFg/bjQZQrPd0ddW9KQDbxc5bRDE3rfyCEf0n/2JX3yMhaZnf
         7yQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741696624; x=1742301424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOohSrQvPqKoJS058lh6ERBfYfFVZu79WxTYWxna9iQ=;
        b=dt6Oy2ft5o4kYj8XeMcuWo0hIr0pYzHmg67tNgyrcIyVQl/VpMdk+8mjPX95dyoxpy
         ZUt4wF/ouGh/BqtpHLElOnGSYLDEU1jERzDkPxDDJHcRGg2Ibp8AJQ+65EP04A1J6Qr9
         bJojHoFry6MR6X7aepzQ0nhtXqEJDHbZQ6cJGHYU0qW+JNNGU5V3JXd4b9rhhQkWJV4Z
         jCdVXEGAGB1iro+8fQ5hrt9yEXnmWWzpDzdZ/7Cp7SoUKtwA4tzLEBfcRCewoDbbHNJz
         093vgXZZAXYyft/p0t0Yux+8lvU5Ucu7eRVDZi44A9jl/aIirP1Zj9G5NIwiTZk8dcmk
         9blA==
X-Forwarded-Encrypted: i=1; AJvYcCXYR2sNGmBiYQd2iIIeUdKXe1UORT1Uh5/b4bXoIGn6IJrC5uDIlDzF95I1r5zNGhRf+mRLf0HB1tHoicM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwExbPSQ3ihBYtPOGRYC7kOtPmwUh3gKLKejO9sVcOPRx7XntW+
	fM3pXv4q2sU/+iizxi1WzXTW421hNiNdZqbW5syrzPOGy8vjIgwfWhTA/ddhdjU=
X-Gm-Gg: ASbGnctRZVGg6CBe6ek2RPWuPrdBXyXgFADrVFXPzgSWQq9pOjfOS7ohR+dQASm9Fi9
	dfQBIyM9PrtndDmSFIryKXAb/Fg3UpgV5N4zse1TBpbQHpo5k/URQzHxqwhddC2+t6D/ggsR9xu
	ckGBGfBsfWYLSOClKoppKttJtU4gXI5anvSzzLw8KZssYT1np3AxmOS50GQU/b4JlACgEJaQN5p
	76AGQcPssMXv3CgWC2IZz5I5aHf8LTBQd2MyxcfFAwfmL/ffzZkyb++cdHgjwga/TEPfCaDMZzs
	Vf0/WWsTflLl2rDpdwwB04YY9KY8nYTkHShu4IqftcgV+iihsIAz93Ae1w==
X-Google-Smtp-Source: AGHT+IHTfCuQAPhrYhY9GiB9gvVm9rN3p4h2znVxLV21KfH9P21dIalFWV0Oc3AwmyqXz7qhPMYuCg==
X-Received: by 2002:a05:6000:144d:b0:391:139f:61af with SMTP id ffacd0b85a97d-39132d8c768mr12227318f8f.32.1741696624554;
        Tue, 11 Mar 2025 05:37:04 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d04004240sm9742265e9.3.2025.03.11.05.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:37:04 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 09/11] cgroup: Add deprecation message to legacy freezer controller
Date: Tue, 11 Mar 2025 13:36:26 +0100
Message-ID: <20250311123640.530377-10-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311123640.530377-1-mkoutny@suse.com>
References: <20250311123640.530377-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As explained in the commit 76f969e8948d8 ("cgroup: cgroup v2 freezer"),
the original freezer is imperfect, some users may unwittingly rely on it
when there exists the alternative of v2. Print a message when it happens
and explain that in the docs.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 Documentation/admin-guide/cgroup-v1/freezer-subsystem.rst | 4 ++++
 kernel/cgroup/legacy_freezer.c                            | 6 ++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/freezer-subsystem.rst b/Documentation/admin-guide/cgroup-v1/freezer-subsystem.rst
index 582d3427de3f8..a964aff373b19 100644
--- a/Documentation/admin-guide/cgroup-v1/freezer-subsystem.rst
+++ b/Documentation/admin-guide/cgroup-v1/freezer-subsystem.rst
@@ -125,3 +125,7 @@ to unfreeze all tasks in the container::
 
 This is the basic mechanism which should do the right thing for user space task
 in a simple scenario.
+
+This freezer implementation is affected by shortcomings (see commit
+76f969e8948d8 ("cgroup: cgroup v2 freezer")) and cgroup v2 freezer is
+recommended.
diff --git a/kernel/cgroup/legacy_freezer.c b/kernel/cgroup/legacy_freezer.c
index 074653f964c1d..039d1eb2f215b 100644
--- a/kernel/cgroup/legacy_freezer.c
+++ b/kernel/cgroup/legacy_freezer.c
@@ -430,9 +430,11 @@ static ssize_t freezer_write(struct kernfs_open_file *of,
 
 	if (strcmp(buf, freezer_state_strs(0)) == 0)
 		freeze = false;
-	else if (strcmp(buf, freezer_state_strs(CGROUP_FROZEN)) == 0)
+	else if (strcmp(buf, freezer_state_strs(CGROUP_FROZEN)) == 0) {
+		pr_info_once("Freezing with imperfect legacy cgroup freezer. "
+			     "See cgroup.freeze of cgroup v2\n");
 		freeze = true;
-	else
+	} else
 		return -EINVAL;
 
 	freezer_change_state(css_freezer(of_css(of)), freeze);
-- 
2.48.1


