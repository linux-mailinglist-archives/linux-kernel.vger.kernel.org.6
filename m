Return-Path: <linux-kernel+bounces-364149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5E899CBD0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2461C22C24
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CA01AB50D;
	Mon, 14 Oct 2024 13:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=batbytes-com.20230601.gappssmtp.com header.i=@batbytes-com.20230601.gappssmtp.com header.b="xHeT880M"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46621AA790
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728913596; cv=none; b=cXTKS3MKVKG6s6+PUJfIzaXS2kSvLJIU+4IipTrlNySrcH7l62VPZjyp5d5OG7TRyvtdox+ZGQfQT+Cu6b1aGx7Q73PgaKN/E5y9MudvAYG1nWM8fl7tKaAth0qTtO+v7cuNtdMvEVJgzeZubVk1vycK9xp21E5EkTbPrOXxo3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728913596; c=relaxed/simple;
	bh=hXB/C5cfukY2a2WKHkPhfQHVJ+hWk/5yyFbXvCtVRjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egeDj5NPsUESDf/JnY8Rgi8zi7CHCu0WYOLYJYUucGAmh4GXjqrH/8c8u5y3cioh7FK52l78pYtZR90uextxMGboDxNBw6Hh78VLQCAWipQBub6Cz7QpbmlE9Tk+uskG6aay1/OD2rOQTaqX9fp0V+5J9FfHvOW1FAKkgV9Ym6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=batbytes.com; spf=none smtp.mailfrom=batbytes.com; dkim=pass (2048-bit key) header.d=batbytes-com.20230601.gappssmtp.com header.i=@batbytes-com.20230601.gappssmtp.com header.b=xHeT880M; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=batbytes.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=batbytes.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cbceb321b3so35413376d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=batbytes-com.20230601.gappssmtp.com; s=20230601; t=1728913594; x=1729518394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ko3jW5Cl6F4biBXzgYlOkyez2QUIpC8KdqLdRC76G2Y=;
        b=xHeT880MBBsaME/gWtr+dHzxQSon9R0Q4Sagpqd9+n46QcZ2fTpQI8e3t6OQYZUgMl
         /ENN753Wihv+im2VWMdYnDnoCm/OKMC37NKFPkIBlbaaKL+saTzXvKvVvQHj+Z45hHHd
         2gyHxzIFId7Ury/CiB4kmQHe3UNWOv70NUCSh4vJ9mPxXJqfIdT7lX0GgIpfclpI7HRD
         t3UEv0NEcPIooZ5Dhdf3GQRwY73fiPBCojMNAFJeyuRk5M6L1O0Bsqo1qmJPok3ppONl
         MMgBQHm4Zwbb4wvya8eha5OMzZXCYkvcKAYn+9eXjPQ+uYMegk5Cxa5KAvX0heZrl2MG
         S+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728913594; x=1729518394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ko3jW5Cl6F4biBXzgYlOkyez2QUIpC8KdqLdRC76G2Y=;
        b=Y4+NPBlcahwy821J0NRASVGwzeBrWyVbuMZNzfKFuE3kGhk92m0c3QmhUgzmDcJSeX
         D+YSneWB0n5Htdxt9pNbP18kYEs8zMbX0Xl7XnnQPn9Ee1/pJfr80dpBDx7NDdSuMZsd
         k4m3AXOQuIVnU07AoNnyBWS7rTMrZ1OfWb3iVNRhrX7iEbXJ0fd1OhpWyHOQsE7gI5dE
         wwoHmfw2K13iJBSKiRUuJ0+zc+FehLK1WXq1OWthGBQq4lWRGpCr4jx63oFimnrTXM3v
         29OUYYlQbpagIwi+Z2tfiqxQVRTCvQqUTCMvdEJnlIKgtMbBdarheUw51BHRQQCHFPay
         HRyw==
X-Forwarded-Encrypted: i=1; AJvYcCVY5xYXFq+Sivep7V3wL/U1h84ucXAuPgOcCj0CWxDqr4FLrdsVBJimCnPm/sBogmnH7/b+LG/TfHXccWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YytodUZuvCNhdXaEy+npjovo8Ljlp5jZEE6ApfIvFcKh5Mrb5VU
	0HrVyhee92em6PPLXAqZAdLr08wFuHN89VpTAkdqpeTsCqB5kXOkDEdjdQjyaA==
X-Google-Smtp-Source: AGHT+IECjyFa7lqpkKz9WnA88loVkpaciMaBusV2OtD0lFCtirhYVtvs6EezQ5JzX+waow9Y789YcQ==
X-Received: by 2002:a05:6214:4b04:b0:6cb:eea5:69e0 with SMTP id 6a1803df08f44-6cbeff63b34mr210563056d6.27.1728913593824;
        Mon, 14 Oct 2024 06:46:33 -0700 (PDT)
Received: from batbytes.com ([216.212.123.7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe85a7700sm45584966d6.7.2024.10.14.06.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 06:46:33 -0700 (PDT)
From: Patrick Donnelly <batrick@batbytes.com>
To: Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Cc: Patrick Donnelly <pdonnell@redhat.com>,
	stable@vger.kernel.org,
	ceph-devel@vger.kernel.org (open list:CEPH DISTRIBUTED FILE SYSTEM CLIENT (CEPH)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] ceph: extract entity name from device id
Date: Mon, 14 Oct 2024 09:46:24 -0400
Message-ID: <20241014134625.700634-3-batrick@batbytes.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014134625.700634-1-batrick@batbytes.com>
References: <20241014134625.700634-1-batrick@batbytes.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrick Donnelly <pdonnell@redhat.com>

Previously, the "name" in the new device syntax "<name>@<fsid>.<fsname>" was
ignored because (presumably) tests were done using mount.ceph which also passed
the entity name using "-o name=foo". If mounting is done without the mount.ceph
helper, the new device id syntax fails to set the name properly.

Cc: stable@vger.kernel.org
Resolves: https://tracker.ceph.com/issues/68516
Signed-off-by: Patrick Donnelly <pdonnell@redhat.com>
---
 fs/ceph/super.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 42bdbe5b7ef9..de03cd6eb86e 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -285,7 +285,9 @@ static int ceph_parse_new_source(const char *dev_name, const char *dev_name_end,
 	size_t len;
 	struct ceph_fsid fsid;
 	struct ceph_parse_opts_ctx *pctx = fc->fs_private;
+	struct ceph_options *opts = pctx->copts;
 	struct ceph_mount_options *fsopt = pctx->opts;
+	const char *name_start = dev_name;
 	const char *fsid_start, *fs_name_start;
 
 	if (*dev_name_end != '=') {
@@ -296,8 +298,14 @@ static int ceph_parse_new_source(const char *dev_name, const char *dev_name_end,
 	fsid_start = strchr(dev_name, '@');
 	if (!fsid_start)
 		return invalfc(fc, "missing cluster fsid");
-	++fsid_start; /* start of cluster fsid */
+	len = fsid_start - name_start;
+	kfree(opts->name);
+	opts->name = kstrndup(name_start, len, GFP_KERNEL);
+	if (!opts->name)
+		return -ENOMEM;
+	dout("using %s entity name", opts->name);
 
+	++fsid_start; /* start of cluster fsid */
 	fs_name_start = strchr(fsid_start, '.');
 	if (!fs_name_start)
 		return invalfc(fc, "missing file system name");
-- 
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D


