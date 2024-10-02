Return-Path: <linux-kernel+bounces-348195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A3998E3ED
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D78FD1C223E8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8C3216A22;
	Wed,  2 Oct 2024 20:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=batbytes-com.20230601.gappssmtp.com header.i=@batbytes-com.20230601.gappssmtp.com header.b="HeNjkTsb"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADA32141C5
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 20:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727899702; cv=none; b=cipevQxAsKFMYONM2p/0HqKH+vZEioujIuzzMNacy2fq+vCNUnhgCCuPC2S4iQ9MV6QGv8TdWxKPpylWG7av//xC59hxKJX7Kzlv4n9VBzI3eraIPeYHV+TkFdJpAn+EK3gjuYyc6pGVrZi8mTJUzu03zBEMi3qti8laz8nnpXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727899702; c=relaxed/simple;
	bh=/l8x0C5y2PsMjSoG8BupX97mLktXgFfrnegJFlrn0f0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iLgjuO8+tNnU0pzpja1ZGRfxMt2P0zQq4Gpgt+mNhSruI6kGyDFGWkXaMsVs4pyGT+cUYAn++kCQXIDX7W3hG9kOU0MzqkMQamW/0NnBGW4QcaAhwVgNuhwFYN3Lsw4dlOAn419hhO6Bw7DBH+4yDDY8ecSaJNNy8MdaHQdrs6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=batbytes.com; spf=none smtp.mailfrom=batbytes.com; dkim=pass (2048-bit key) header.d=batbytes-com.20230601.gappssmtp.com header.i=@batbytes-com.20230601.gappssmtp.com header.b=HeNjkTsb; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=batbytes.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=batbytes.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-45aeef3ce92so869381cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 13:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=batbytes-com.20230601.gappssmtp.com; s=20230601; t=1727899699; x=1728504499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JdrIcDotBJl1qT8iyU6P6JS+Nsv6cgpYiBCs53eRkjc=;
        b=HeNjkTsbB0trdatJ9la117Zg+n28JfchSIB5jQmlCdYpxKaD/TJ97/JWEkH7njYzTk
         kN2atoFQw4wh1esv+GSzrDPj5qvu3oY7mJ60YIDh9+eW5k4RNQNL4Gj+2jeKXVc/5qXb
         GLjNAeEiquApHPnxuWkO7K5DMfx/aC8FCPy+VPj4HKlphGgtFB9MtVBYbVS9exT4IDWl
         Y1nYVtCIESqdq28bugYYOE1qYbnjhazD96qOBI5eGbYhXblTedHk3WwBloejftaeMoxF
         AsXhILQOdzeDv3+Q+JvV2Xx6s+UQEIuhNTviFLJ2LWTfh+PaI77PaP/Hu0eCTYGTZ/lI
         jivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727899699; x=1728504499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JdrIcDotBJl1qT8iyU6P6JS+Nsv6cgpYiBCs53eRkjc=;
        b=pePnUvZ1krfym6Z3CjoRAZjQXvkp2LSRyzC3N9tDT0ZV0xbMesCt4QmGtp50CtmtS7
         TNTPIC6toObbOec88jKeZON/6g01W1SdjmGNvPfUjodWasJ1SFEaKVPQ9N4wFW+cLM/K
         BTYIisvZQ5ujqKT6DxIuKJmdy4n9CyuknS9p9G5WZ5YdziBLxrb/MoE1Yhi90i02FyB9
         3XTUkr3uLn+lCdc4dg9c+J4HEPqHXvcNEmWeo9LgP6mswMSti8T3QckfMeSBGGsJWthp
         /c4RgLMSguXrr7bx14YEnyQVDgLTKtqK5OXJlJhD2AQKxqVvg00OSQneyZnJQ3FK94h8
         2gVw==
X-Forwarded-Encrypted: i=1; AJvYcCXTvdwtyTospaKaKVX595m+g9oaD1WUplM9PoSOnkSkbE1Oz1ewJfdCilT4L07WiHp1UgSJMsNdwbSPix4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrs0xf2P+D9nEcKTRDPSip6R48QXUOu8KTT19JPzug7Hy2KCBX
	Bk3tQctbNzANEEe7pFrMuuWARiEHjbPFdhGpZ+WmQwA1xw/JoBHWDvWj+BeMmA==
X-Google-Smtp-Source: AGHT+IGkjQYOtn2pKwHHuzmH8OBvWnuVydeXrYv2H1wgm0A5PmgFPA3jP9FiD/IZ+W10APNfcN6SLQ==
X-Received: by 2002:a05:622a:48:b0:458:532e:59d8 with SMTP id d75a77b69052e-45d804f8d60mr62923861cf.36.1727899699335;
        Wed, 02 Oct 2024 13:08:19 -0700 (PDT)
Received: from batbytes.com ([216.212.123.7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45d7aad57c5sm18352291cf.63.2024.10.02.13.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 13:08:18 -0700 (PDT)
From: Patrick Donnelly <batrick@batbytes.com>
To: Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	David Howells <dhowells@redhat.com>
Cc: Patrick Donnelly <pdonnell@redhat.com>,
	stable@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ceph: fix cap ref leak via netfs init_request
Date: Wed,  2 Oct 2024 16:08:04 -0400
Message-ID: <20241002200805.34376-1-batrick@batbytes.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrick Donnelly <pdonnell@redhat.com>

Log recovered from a user's cluster:

    <7>[ 5413.970692] ceph:  get_cap_refs 00000000958c114b ret 1 got Fr
    <7>[ 5413.970695] ceph:  start_read 00000000958c114b, no cache cap
    ...
    <7>[ 5473.934609] ceph:   my wanted = Fr, used = Fr, dirty -
    <7>[ 5473.934616] ceph:  revocation: pAsLsXsFr -> pAsLsXs (revoking Fr)
    <7>[ 5473.934632] ceph:  __ceph_caps_issued 00000000958c114b cap 00000000f7784259 issued pAsLsXs
    <7>[ 5473.934638] ceph:  check_caps 10000000e68.fffffffffffffffe file_want - used Fr dirty - flushing - issued pAsLsXs revoking Fr retain pAsLsXsFsr  AUTHONLY NOINVAL FLUSH_FORCE

The MDS subsequently complains that the kernel client is late releasing caps.

Closes: https://tracker.ceph.com/issues/67008
Fixes: a5c9dc4451394b2854493944dcc0ff71af9705a3 ("ceph: Make ceph_init_request() check caps on readahead")
Signed-off-by: Patrick Donnelly <pdonnell@redhat.com>
Cc: stable@vger.kernel.org
---
 fs/ceph/addr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 53fef258c2bc..702c6a730b70 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -489,8 +489,11 @@ static int ceph_init_request(struct netfs_io_request *rreq, struct file *file)
 	rreq->io_streams[0].sreq_max_len = fsc->mount_options->rsize;
 
 out:
-	if (ret < 0)
+	if (ret < 0) {
+		if (got)
+			ceph_put_cap_refs(ceph_inode(inode), got);
 		kfree(priv);
+	}
 
 	return ret;
 }

base-commit: e32cde8d2bd7d251a8f9b434143977ddf13dcec6
-- 
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D


