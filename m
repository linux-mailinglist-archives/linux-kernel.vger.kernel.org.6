Return-Path: <linux-kernel+bounces-362656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95ACE99B7C0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 01:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 404021F21D5D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 23:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D24199934;
	Sat, 12 Oct 2024 23:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=batbytes-com.20230601.gappssmtp.com header.i=@batbytes-com.20230601.gappssmtp.com header.b="Bmg4o//l"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7674142A8E
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 23:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728777347; cv=none; b=VFMpX/jTeoOv0EsLSh7STyofjEWKC6Oh+6H54jcJQ/b3FACr7dvJMCKD7Ptjd+1wle5lhE6inQqlcPeysIGGDkavIYY3zsjrKPPVP9INGON9Xxuo0yzk7lppqVrU48YcIfgmCvvkODJ9RLzHrDPphnFbiexZsycep1HsoOTaq5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728777347; c=relaxed/simple;
	bh=Rs0WhVYlqwQ9GIF9wqpRbWP2+E5Qn796AkiW/OgXwcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sUl5yberjh/vgh5eUJzORn1mi9YGAM4Ga5kM5fnvR+i7cE8CMzvQiOpxREYUdg097Iwjqf3IAKevppSvHXUO7coyKFa6fYVPfOkopFZ/UJ6bjo8sYHxPDYq19KHFd/jJRHkeTc0UW4EwkaDiAPf1R9qExebTuX8dVt0q5fUOJcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=batbytes.com; spf=none smtp.mailfrom=batbytes.com; dkim=pass (2048-bit key) header.d=batbytes-com.20230601.gappssmtp.com header.i=@batbytes-com.20230601.gappssmtp.com header.b=Bmg4o//l; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=batbytes.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=batbytes.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-46042ee22a7so28658521cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 16:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=batbytes-com.20230601.gappssmtp.com; s=20230601; t=1728777343; x=1729382143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+sk6LUiLeleXUsSllRpsc5OH3Y6ZTlzg70lgLuDUR68=;
        b=Bmg4o//lsNVigdXFCWLLM1H7fGmb4Fvzfno3G8QVRU0+7J/qRxsmQm385h/A5YJ1ma
         34wz8G5pJogkwEV6bR5fEG/wAkOy0g70JNXIRftEf0trR7rDqJyskav+yPRagnaySJTS
         TzHrL4PS9K75H7UqhkFiV1VbEuet5urZpSJChF+Gr+yKDhb1IOb7DQkiGEMq/QvjMkDy
         Gj0IupEqbWdgPGFIkpD/RNi4ZMmp0MP+ueuiBx6+mEznmvaKJ3Lptk+m/kCOhUniCgWE
         ors2nme+QnmNkU0UsDkaA3zqhCHN6MMIwwt6R6ZA1K3DOBVgSma1hyi6jTfYK+c7IQr9
         z4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728777343; x=1729382143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+sk6LUiLeleXUsSllRpsc5OH3Y6ZTlzg70lgLuDUR68=;
        b=k61rPPxLlflnGYAAYvBX3Pg9EMnzGBRqENLGAzgJ/uoamOpOZ/d/WoyTwaJUd+m7uY
         O+TO1J429B8QYEllOhCHs240G2UxuuOBTPqegXXP0dlOiRWCt/OQzkYj5vvorxh2JzcU
         QKSOAt2SoE4iDFknPuG7aaqySfK8xmHwm+hT+/SIuLFjfmKJaONoEwkXOAo6vjgG/y2l
         gp+tcyEEBoHhC9aonFeKRmVyoBDX9vg3BNfCNqxFkOA4ySoSvdUuRLC1uKqlX60k6Vv2
         8xvdTy3Oyk7lCuiXcKylPkIKBW1X+DcnHRlzgQn5UUuC5Q+FxLgqE/XXzOcJrUKIxMTU
         Ndtg==
X-Forwarded-Encrypted: i=1; AJvYcCXaNhAsoY83rTbx8GsDGXMUSKpx2a5fI0bBH/ROje5YuB53tjSud0gOdbqu4DbdRx0/xlR3M+JtZjr35Yk=@vger.kernel.org
X-Gm-Message-State: AOJu0YziZRB5hyDQYse5qfVODTJzORK63PY5+p1+k+VDAj404tX/raFn
	ccCvMEZ8FYVswlzNATSXyUw2/RN/DzGHESHZJ2b7Pwacmv54wtULUZi9Q/Kxhw==
X-Google-Smtp-Source: AGHT+IHk5YHd59N8jAKWL+/oKO+RM0w7kbYnSajqFt83qDlUq2bDjS287Ot2L2/6nIQoY78Ym5jFQg==
X-Received: by 2002:a05:6214:460d:b0:6cc:9:3205 with SMTP id 6a1803df08f44-6cc00093482mr40916936d6.45.1728777343295;
        Sat, 12 Oct 2024 16:55:43 -0700 (PDT)
Received: from batbytes.com ([216.212.123.7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe85b7772sm30477966d6.49.2024.10.12.16.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 16:55:42 -0700 (PDT)
From: Patrick Donnelly <batrick@batbytes.com>
To: Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Cc: Patrick Donnelly <batrick@batbytes.com>,
	Patrick Donnelly <pdonnell@redhat.com>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ceph: correct ceph_mds_cap_item field name
Date: Sat, 12 Oct 2024 19:55:25 -0400
Message-ID: <20241012235529.520289-1-batrick@batbytes.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The issue_seq is sent with bulk cap releases, not the current sequence number.

See also ceph.git commit: "include/ceph_fs: correct ceph_mds_cap_item field name".

See-also: https://tracker.ceph.com/issues/66704
Signed-off-by: Patrick Donnelly <pdonnell@redhat.com>
---
 fs/ceph/mds_client.c         | 2 +-
 include/linux/ceph/ceph_fs.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index c4a5fd94bbbb..0be82de8a6da 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2362,7 +2362,7 @@ static void ceph_send_cap_releases(struct ceph_mds_client *mdsc,
 		item->ino = cpu_to_le64(cap->cap_ino);
 		item->cap_id = cpu_to_le64(cap->cap_id);
 		item->migrate_seq = cpu_to_le32(cap->mseq);
-		item->seq = cpu_to_le32(cap->issue_seq);
+		item->issue_seq = cpu_to_le32(cap->issue_seq);
 		msg->front.iov_len += sizeof(*item);
 
 		ceph_put_cap(mdsc, cap);
diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index ee1d0e5f9789..4ff3ad5e9210 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -822,7 +822,7 @@ struct ceph_mds_cap_release {
 struct ceph_mds_cap_item {
 	__le64 ino;
 	__le64 cap_id;
-	__le32 migrate_seq, seq;
+	__le32 migrate_seq, issue_seq;
 } __attribute__ ((packed));
 
 #define CEPH_MDS_LEASE_REVOKE           1  /*    mds  -> client */

base-commit: 75b607fab38d149f232f01eae5e6392b394dd659
-- 
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D


