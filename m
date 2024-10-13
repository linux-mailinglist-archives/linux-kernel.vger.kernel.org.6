Return-Path: <linux-kernel+bounces-362668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E969B99B7DB
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 03:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23A0A1C2117B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 01:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9935479E5;
	Sun, 13 Oct 2024 01:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=batbytes-com.20230601.gappssmtp.com header.i=@batbytes-com.20230601.gappssmtp.com header.b="lXSXnZ2o"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F3F10E0
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 01:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728782211; cv=none; b=GvGyTOqi66OOabXCLYIK56Z0e8zviQE/zv32RN0jkB8yoMER3fBqTsYjCdl6sLZqQS0EA4DzkpcGL5tufAFSXLepfjBfZIqVRkJ3Xq9KHgA7w8QbEVpSJzVz/nmFVAYIxXCwNVxIMGLc1uDS3Ia3xJviyqwgoog11cTJgdVyRng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728782211; c=relaxed/simple;
	bh=Rs0WhVYlqwQ9GIF9wqpRbWP2+E5Qn796AkiW/OgXwcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mwaQXJ1+8Zz3CX+dpnpoo5cYF6Qh4fa64IbM9IFBRzpKdW1yzq3JCgkUYBN6dnSnVgYJrkWgjytDZ4KVNDK4oug2Q04sFLxgMeuQUfkf4iRtntPyV6LkGGHe/7VpFNbue84zD8TViq3E2PptTQYtR9I8xqx847u584XZYZLJYaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=batbytes.com; spf=none smtp.mailfrom=batbytes.com; dkim=pass (2048-bit key) header.d=batbytes-com.20230601.gappssmtp.com header.i=@batbytes-com.20230601.gappssmtp.com header.b=lXSXnZ2o; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=batbytes.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=batbytes.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b111003738so261959485a.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 18:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=batbytes-com.20230601.gappssmtp.com; s=20230601; t=1728782208; x=1729387008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+sk6LUiLeleXUsSllRpsc5OH3Y6ZTlzg70lgLuDUR68=;
        b=lXSXnZ2oS7w0xrt7652xlz9ebLAnqDITGQe1ymKSSx6HzDMyuITsS6HMdMaHEYoHGr
         usDy6s0nC+LRzSOogPKpn3/aCFRBeFdOjUCtBE3k75JPRpnnowoGWjrRhk5QeTKsOFna
         cUrLeGFrcQ5Ud3weqtZn8ZGAoiWC4CewJvyGyYCp3IiVRxvhFsA4CCO/am5oko+K/b1C
         YI8+PS/0nScNip2+Oj7bC/nCl58fGrD/GTTZVu5vpwvQnbpjdcM8K8W/bIrr5AhPGsZX
         HzGhAqvjKnTQuKsUxNdbrNBd7MLU6nnvgS9wPeVyKa8eS9IzVwixGBIPSyyCFb/aeqRE
         r9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728782208; x=1729387008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+sk6LUiLeleXUsSllRpsc5OH3Y6ZTlzg70lgLuDUR68=;
        b=hKNw+gpzQSoyBtxuSnkgxwkXdfra7kTFC70peu+4vtfcFp3KzfKibTqI1qXYAeoIqg
         5xuTJpapv7Gzivh6zEyUWTmF2+OaFZq9erhvD3gHBx8BzalqTJivVEoU/krjf7yjWJiu
         vv2U+wgN33n/mM6WKUe1y9Z+mnTgYrHnIRHhXz5S5rqCHFFnOjAf8eFt6X7ZCiX6C01g
         vpdsJM8gKN3VmVGFOdS5AISBATWIsnCsHJwM2RF22ogUwEBmd25MfgcciSovAGZG+YUV
         +KrSg4/Ce5r6ECDC7Qs9gb2scqa4yjBVr/m3f4ap7vdH1ZBiQx9mFGqY5pemSLGbk+Ns
         Jtxg==
X-Forwarded-Encrypted: i=1; AJvYcCXE/sUciqKz/DUh4cxx23W1t3lWaOpNSEGLN5PUaUNJ7DzGO/koFM+z5ZG7NhrOpbcCl3NVVMH3vI6cF+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8cnR+E5/ju5srcDBvuIQKd4qjw0a3NlLx/cyiymGdo3jOZlS+
	Sh+KHMSbRHMLDXvuqdW2nxuf3g7Nad6LPUEjw/nI7GRLH0pgCGUIe47d79xT/w==
X-Google-Smtp-Source: AGHT+IGTmQ1sCNGvxvKC+B7rM8+rg2NN9YCFVlNQ5vOIyaUhlkwDzZptdz/WbPjvm/E9Ssohsb2QKQ==
X-Received: by 2002:a05:620a:2950:b0:7a9:db7d:11f5 with SMTP id af79cd13be357-7b11a36f4d9mr1209601585a.25.1728782208407;
        Sat, 12 Oct 2024 18:16:48 -0700 (PDT)
Received: from batbytes.com ([216.212.123.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b11497704dsm273414185a.101.2024.10.12.18.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 18:16:47 -0700 (PDT)
From: Patrick Donnelly <batrick@batbytes.com>
To: Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Cc: Patrick Donnelly <batrick@batbytes.com>,
	Patrick Donnelly <pdonnell@redhat.com>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ceph: correct ceph_mds_cap_item field name
Date: Sat, 12 Oct 2024 21:16:36 -0400
Message-ID: <20241013011642.555987-1-batrick@batbytes.com>
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


