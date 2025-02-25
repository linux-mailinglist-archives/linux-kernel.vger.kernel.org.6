Return-Path: <linux-kernel+bounces-531239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A20A43DF5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA1703BCB20
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C95267B84;
	Tue, 25 Feb 2025 11:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXR6XVzl"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6329F267B0D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740483694; cv=none; b=b/jLnm+ewT0/AoCEjkUf3ZVUimMmE7X9qjZ/eldX7LHRkYqEma8zBaxzWkpESgOyYF+eDVNxWpy/CBamBeLJhWfUUwuQahYTGiWU0K7o3g4TdsyBIJoIRIkVz26DLKjUCrbF73wodjUN8nJgk5g4rrPQLVPqo+orVUkr2yzztoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740483694; c=relaxed/simple;
	bh=LyqrPMHbbwSEeTHSIWmWDMQlVx3qdKh1pxO1oEdoWsA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PvycZDFn6inGeY6WQgrEQei27cUUyCTw7UNgnEv8dthPKE4ZDvcpWGqOIut8HDJx3cOifIW5miJu+KpziCP3pCGyHTpsvNuB+BagyKkb6PfjvxppGSyFOpUX/8kymMGAMTeZUB1LybqKAvKP5Ns2EHirpZsvnwQY2e5Kc4WUvpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXR6XVzl; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30737db1ab1so43172901fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 03:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740483690; x=1741088490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8XaDH+/IUdzUxU3rKSG4BJ2f9MD4nYgc4l0NxVp6Pfc=;
        b=MXR6XVzld3sSHPq9XRR/rVLE3tVYHMs0xTcZ+ZfytUEoViGaQv5GoN0dGQV4sZJrlA
         1bvLdSDUZezvL/3iXfOSq/NXdHctYR/OyV02VFd60j9innG4+PW1Dt1fhTZUmAqyttRs
         oqlIKWoQ1Loqxhg2GYtzjGtSvf4XsgcYbE1vQKr3enPVKtmaM0I+7HQ3RbBdGdicqUNm
         /0rI46+UeqvvjQhDOKSehw8GDnkX2X5bq0JivkJWPOoMzCfZs6sDMlguUXgOWb0637ju
         MBOvLZ+IMxfsfeVgWJ+jKGelOUHr5HGYQgfBuxoKIjQRaFjh3kViCg/IX6+UeZi56VR2
         t3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740483690; x=1741088490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8XaDH+/IUdzUxU3rKSG4BJ2f9MD4nYgc4l0NxVp6Pfc=;
        b=CLSA9kD1mTvd/RI/UEVux2quF5FvQj1VfQSBpwSItn39EfyfS8XLOoYOGPw71T1W2y
         qjxGRn0ArHsq3T7875YHo+q0D8ObrNMFxz7ReDXYZRsw0gIq/p5Q8qdoaD9NpT3+EuA/
         mzjFMsH90lqZJpmR54swqA3fkCTBT1X6CIccpllGIINGyY5CTpbvMYSqlrrMQ6/U2ldt
         +TOU+QP3ib+zVkkaAZsnnenSQ2YQI01FmAxE60cH/ZabDD9sMmlIdlEbprQBgQWSzQlX
         5BTMIAc7wv1Cb4lSKySuo93d7Ptcp/0XIXu985dV2Lps+Onxu0gdCxry9LiD6vjE0mar
         jc4A==
X-Forwarded-Encrypted: i=1; AJvYcCUYGq18u45Y2PFTrb3gENOEmDkbN9/5gVQO7C291aGU5FOY6KofIDn7/ovZ9Tu22Nykfq1eGLSMIzTih20=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwAPMW6Wz87xFdRZOGCNG3IaSPi0g0ejE/Mlu93hAz95pFrFjo
	uLRqbd4HjYvC02vxjDTG/RDB+zfI56tSsqXLAntb0qmY+rzV3Dcr
X-Gm-Gg: ASbGncvolILyuQrCtkD4PBbp21J4ZRvyZRN0778VNtFlCPiSCRIxyhP+SukcLsc7hfV
	Bhqj/DhEUI1oSroWhT0DpvWjKSk35edzip0xElzdHhwPJ9tgJ8IATpA3A5g6XCl77Tfl1jmoORM
	V08Fz0aYGTIq2Z/gNTV0LlqX4QEPXO/7Y6v9tC4WXRJ0hNbeYPhW2pkE+N7xcpQgvxUNU0SvugS
	5sz0nGMnRfEYTzPNSc08Tdc2WISDrnvCTz3jxdiW6vu5EaqLD49elCASIgxYlnL1LIwuhO3Drn0
	Sdasztvgvm9O7GRVtdhr/dZVydoLabtgyozvy3CSB0ftpt6a1yHiMPwAUgCwtcALxeAc
X-Google-Smtp-Source: AGHT+IGXH3QhYImzslzT4d+BYSdlO38JoErquXF3tDK1WvkYjwRybP9spHTVyKnKE2ZXhilgfqU5GA==
X-Received: by 2002:a2e:9cc9:0:b0:300:2ddb:aaa5 with SMTP id 38308e7fff4ca-30a5b20d7b5mr55610181fa.30.1740483689963;
        Tue, 25 Feb 2025 03:41:29 -0800 (PST)
Received: from rand-ubuntu-development.dl.local (mail.confident.ru. [85.114.29.218])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a819e1462sm2107311fa.21.2025.02.25.03.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 03:41:29 -0800 (PST)
From: Rand Deeb <rand.sec96@gmail.com>
To: Dave Kleikamp <shaggy@kernel.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: deeb.rand@confident.ru,
	lvc-project@linuxtesting.org,
	voskresenski.stanislav@confident.ru,
	Rand Deeb <rand.sec96@gmail.com>
Subject: [PATCH] fs/jfs: prevent potential integer overflow in dbMapFileSizeToMapSize
Date: Tue, 25 Feb 2025 14:41:10 +0300
Message-Id: <20250225114110.1775745-1-rand.sec96@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In dbMapFileSizeToMapSize(), the calculation involving 'complete' and
'LPERCTL' can result in a 32-bit integer overflow when handling large
filesystems. Specifically, multiplying 'complete' by LPERCTL * LPERCTL
(1,048,576) can exceed the 32-bit integer limit if 'complete' is greater
than approximately 2,047.

While there is no evidence that 'complete' can exceed this threshold,
theoretically, this is possible. To ensure robustness and maintainability,
this patch casts only 'complete' to s64 (64-bit integer) before performing
the multiplication. This guarantees that the arithmetic is conducted in
64-bit space, accommodating larger values without overflow.

This change enhances the reliability of the JFS filesystem when managing
large volumes and preemptively addresses potential overflow issues.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
---
 fs/jfs/jfs_dmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index edb22cf9521a..380e73c516ee 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -4059,7 +4059,7 @@ s64 dbMapFileSizeToMapSize(struct inode * ipbmap)
 		factor =
 		    (i == 2) ? MAXL1PAGES : ((i == 1) ? MAXL0PAGES : 1);
 		complete = (u32) npages / factor;
-		ndmaps += complete * ((i == 2) ? LPERCTL * LPERCTL :
+		ndmaps += (s64)complete * ((i == 2) ? LPERCTL * LPERCTL :
 				      ((i == 1) ? LPERCTL : 1));
 
 		/* pages in last/incomplete child */
-- 
2.34.1


