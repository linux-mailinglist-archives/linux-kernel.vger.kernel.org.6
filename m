Return-Path: <linux-kernel+bounces-351595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3413999136F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 02:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 667101C22970
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 00:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352EA2595;
	Sat,  5 Oct 2024 00:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jqgsak8Q"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ACDAD23
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 00:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728087251; cv=none; b=lH8KcZVC6cijD4LJ/eweNPA/bwarBNS6c6k38zSBWiCCgVftnBq4gsQl3nO0CTzJPV25aNzQfHi9JYb99tyfxzx4zXdwfJPM2vMfP0SG+PgkWi3y2iSACtLvNkw7VcxtrIrv8umMpnHI1Hw47TJ6PKc3XNP5dMyG/AIrOWwpcAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728087251; c=relaxed/simple;
	bh=T0W0KBZI5DkiCjtxQ7TpePJYH2d/3/oGKPm/Q6dRQDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RnTAJdb2Inx+cTP+xv/uR4tWXFfGFfVpxtnAY11oq79i3R/g7W+0GZzYJ8rMiACzRPy2sVCVQHMe7nQ4rhtSEkNp2d/8q00DJOSG9a9m43khw2Kdyyr3BRD9xBgnXD3pbYXsvlniwESxlzw5FXllljRL07Uf8AinpliA21fxRRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jqgsak8Q; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20b6c311f62so24128045ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 17:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728087249; x=1728692049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sdvgpKhmD14lH5DEz2GjjZadZ28c69PHIkDv34BVtjY=;
        b=jqgsak8QsIQ0alVyGBI3WHFcIA11Y0wF8K1uNNlhSzk9Ab3pinrLVBqoaNx8Xac70V
         f8WQeLptSwLq7RsNFBgNffUXXrHepegJVD0vGcGgLTgV2HjBfU1S003tw/fA8bK7PNxc
         CCg/bAVp4NhVDhrCI7vE4VU4KFUF2iVtH5d18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728087249; x=1728692049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sdvgpKhmD14lH5DEz2GjjZadZ28c69PHIkDv34BVtjY=;
        b=IbecXfAFl9qASt/z5oGj+T8/IRO9R3V3MpnNpKlmuzfshd6qS37W88H+EUY6fZv1c4
         WSIQNBVwBn0IhUo6hEzvUnMF7cT5BNf8X/WbXDfoh71dQRgVK6oR0ytgp8aQObq+eRVd
         z6rOAeCwm8BMzEP6jsGu46cox9xroLmnvvd7darzgf3BH2tfkH3SFDV7z1C76PY7TIaP
         FrPxyoVOpSPU6+3cxw6U9MD5XFxm/xgqur437qvQ6kPDZ1yTXIvQ6aGoQ5Gzy5cu6VyT
         a9ZrTHwS/yMrUAEtW8QjYUYLNbzTpwXNrvKcm3vmIJIBPuLLtKrrolkFtg1r0npkuydg
         eQ0g==
X-Forwarded-Encrypted: i=1; AJvYcCW8vsvlhy445RbkUHYKdLJCQ/uwk17/b/wH/GICEZdDXnNKs5Nj9xKbk++V5IgwZQeaihNkfFK0brYkgfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2LYuVvIeZTi+oTZB0zwZt7zNCUzKRHAMUCzvV6zXlaDG7uCab
	YPKjXtFs+fpgPTXrby4/CpJDNUoU/5MmgJmC8VLke59X3szMNWqnENmBpW9AEg==
X-Google-Smtp-Source: AGHT+IHv9C2jX/9/LO7J+EAweNR0wJaRJh/hpB23twcLNfojV9w8IEn9Gf8JDOL0bDIVCXkQV6JdPQ==
X-Received: by 2002:a17:902:d485:b0:20b:b238:9d15 with SMTP id d9443c01a7336-20bff1a8709mr49363695ad.41.1728087249288;
        Fri, 04 Oct 2024 17:14:09 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:8252:ce4b:5690:56b3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13939c30sm3950575ad.142.2024.10.04.17.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 17:14:08 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Jens Axboe <axboe@kernel.dk>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
	Kyle Fortin <kyle.fortin@oracle.com>,
	Douglas Anderson <dianders@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	Christian Brauner <brauner@kernel.org>,
	Christian Heusel <christian@heusel.eu>,
	Jan Kara <jack@suse.cz>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Ming Lei <ming.lei@redhat.com>,
	Riyan Dhiman <riyandhiman14@gmail.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] block: add partition uuid into uevent as "PARTUUID"
Date: Fri,  4 Oct 2024 17:13:43 -0700
Message-ID: <20241004171340.v2.1.I938c91d10e454e841fdf5d64499a8ae8514dc004@changeid>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Both most common formats have uuid in addition to partition name:
GPT: standard uuid xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
DOS: 4 byte disk signature and 1 byte partition xxxxxxxx-xx

Tools from util-linux use the same notation for them.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Reviewed-by: Kyle Fortin <kyle.fortin@oracle.com>
[dianders: rebased to modern kernels]
Signed-off-by: Douglas Anderson <dianders@google.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I found myself needing the PARTUUID from userspace recently and it
seems like pretty much all of the solutions involve a lot of code or
including some userspace libraries to solve this for you. This is less
than ideal when you're running from an initrd and want to keep things
simple.

Given that the kernel has PARTUUID handling already and needs to keep
track of it for using it in "root=" matching, it seems silly not to
expose it, so I wrote a patch for it.

After I wrote the 2 line patch to expose the UUID, I thought to search
the internet and found an old patch where someone had written what
amounts to the same two lines [1], so I'm grabbing the old patch and
resending as a v2. I'm keeping the Reviewed-by even though I rebased
the patch (adjusted for file moves / name changes) since it's a tiny
patch and the concept is identical to the old patch.

Crossing my fingers that this looks OK to land.

[1] https://lore.kernel.org/r/150729013610.744480.1644359289262914898.stgit@buzz

Changes in v2:
- Rebased

 block/partitions/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 5bd7a603092e..aa54c1f4eaa5 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -253,6 +253,8 @@ static int part_uevent(const struct device *dev, struct kobj_uevent_env *env)
 	add_uevent_var(env, "PARTN=%u", bdev_partno(part));
 	if (part->bd_meta_info && part->bd_meta_info->volname[0])
 		add_uevent_var(env, "PARTNAME=%s", part->bd_meta_info->volname);
+	if (part->bd_meta_info && part->bd_meta_info->uuid[0])
+		add_uevent_var(env, "PARTUUID=%s", part->bd_meta_info->uuid);
 	return 0;
 }
 
-- 
2.47.0.rc0.187.ge670bccf7e-goog


