Return-Path: <linux-kernel+bounces-557571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F862A5DAEA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43F071895E4E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C428A23E34F;
	Wed, 12 Mar 2025 10:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+lXqLt7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49DE23C8AC
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741776776; cv=none; b=OJUGApFyHvSLfealSdstjy8yxr1NUKc3kkWbmI8FxmAAFysFbz/9gPP0UWPXvT8blQP3feFSEIaSlrtHvUAYnJbNY4U1NZ1c7UGhIWt8T990SFDmIQ7DuiWu6HtNXSTuOU9WAdXy3+Teh7C1cBRl0/P9h9DvqD6w2iDLZS2+hwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741776776; c=relaxed/simple;
	bh=g/scs/pN3Let8KEraGJIBQSC7SxJlkJiwmDbwWyJ1hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=toMaM2Sa/QUZmL6MDBLXsedygbGjbIhU1gR1FtqF5Nyj2LULfSqBMmegWlE1px6UjPWMa+wzETTmebOWPuqrTy6HDKCD5yYm7xQaIdtCkxqihOxJHeMel9RCfCJj+VhLwp0zNCwTEoXiXftG7N1R1iziBDwagvXdQqEjLwSTbYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L+lXqLt7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741776772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Zt2jIoMP95QFHC64XcBt2AaAmIniRQUF+dwuamUL77w=;
	b=L+lXqLt7ae+J8NkxQgepmVNPBHzES0nj2Hp5CmRIDVQmt2PfXIuHDloTLZaxy9pn7oP2kG
	erKuXtrhoJ9ybBiX+XLlID0+6VqvnZQXvovVoNk4t9MLrLxXi61NgvHgHK3lFBwjF2wNDF
	/fqZv3sSCCF6NaeR7h4mxgjJ/kfnR6U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-vQkr9dnhO_2fRpk1XSV0hg-1; Wed, 12 Mar 2025 06:52:51 -0400
X-MC-Unique: vQkr9dnhO_2fRpk1XSV0hg-1
X-Mimecast-MFC-AGG-ID: vQkr9dnhO_2fRpk1XSV0hg_1741776770
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d0830c3f7so9040655e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 03:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741776770; x=1742381570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zt2jIoMP95QFHC64XcBt2AaAmIniRQUF+dwuamUL77w=;
        b=DFHBMg9dgdLPX8ZihMDvG6e5FmB5hXcrxXphnHYAJRsvu8uJTe1VBSuiS8QTrGvmRw
         DgtKb+o8qCgpzS4Bfj83mI4oNyIBlw+U/hIJ38/A2jbmfngY0v09YLppDc2WBESV+CwR
         9eZmv3E4rWeVwCCqnWdBiXmkTAPtuho2uaC3Kxd3CctVPZ5emFaKrRoo1bQcpMxAcS12
         5ihPV+BgBqAU8Oix3NyCesD0P0N4ciTjr62H/jp3AhltpkGNTjK4pq7DSG8djwPiM1Gs
         09wuzky74Hg/5GmTt9zBQuDYPO3AV86YC2U7Ui97Ten8bCuuY+xpHxETYI9GTFxL41tJ
         uKtw==
X-Forwarded-Encrypted: i=1; AJvYcCWAEu22BRYHnBioZX26xYl5VZe2iPWFNxzL4rTYKH11ZYDJFq+gIAl0K/1q179CI8LDpTDtgTv413329GU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0V7RiPn8c5Bm0JmZwnkDOVZ0IpmIm/WViZaX75pxgYFuq0s1+
	bTEx4I3Q3Km51p5aFPAXS0yaSS36RibkzKDLhjZRlCnIQflJlBt2MSxuQK9xIyVHzjDRgejTzGg
	kEe1JGqSWVoh31d2dkUCfo7GghBYTqk795petcZkgWe+4btnVCW1F4DQuKy5uHg==
X-Gm-Gg: ASbGncuMfqpU9N1UpHqVtWmJbhWLUmW7Rud2WxEMRZ382sTkad5Tde/uRDKR7zwRg8Z
	7z4jtiDBJHylYeven3Nr6LQOr5S/hlQ6cf/BQdGYXzMwCGHRhijjNc2u1fC6VCudG/nzIblmiQ5
	YNLcG5X+o2yHc7kC8eFftJsSW+xKf3bofI2h0/F/au3YXNwxoKiEwdZV26dbyIpGaHdfYI1HKYb
	z23cLyh+D+nAiM4nJ+yWeBZ5li8YdMBgMuANoyYPXcG7gyKn0CuQGvve6Q4VoukjdaMM56zeaV9
	Odhy5XSf4dwW5/e19uK0/ybKMImxmtGja1usE+UM/ClUUqb5Ws+IioXFVewK2r8=
X-Received: by 2002:a05:600c:4f90:b0:43c:fad6:fa5a with SMTP id 5b1f17b1804b1-43cfad6fe22mr81540065e9.24.1741776770142;
        Wed, 12 Mar 2025 03:52:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6uqPVmMPsyJoxPmFKLAy4usaZoIJd+/VqyaxpL8A36an+EVc9YTROv1eG/no43mSDucSFSw==
X-Received: by 2002:a05:600c:4f90:b0:43c:fad6:fa5a with SMTP id 5b1f17b1804b1-43cfad6fe22mr81539915e9.24.1741776769695;
        Wed, 12 Mar 2025 03:52:49 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c11e9desm20403712f8f.101.2025.03.12.03.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 03:52:49 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	"Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH RESEND] MAINTAINERS: adjust file entry in MAPLE TREE
Date: Wed, 12 Mar 2025 11:52:45 +0100
Message-ID: <20250312105245.216302-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 0f3b602e1bad ("tools: separate out shared radix-tree components")
moves files from radix-tree/linux to shared/linux in the
./tools/testing/ directory, but misses to adjust a file entry in MAPLE
TREE. Hence, ./scripts/get_maintainer.pl --self-test=patterns complains
about a broken reference.

Adjust the file entry in MAPLE TREE.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
Andrew, please pick this minor non-urgent patch. Thanks.

v1:
  https://lore.kernel.org/lkml/20240826110215.19894-1-lukas.bulwahn@redhat.com/

Patch was sent six months ago, but was not yet applied. Issue still
exists.

v1 to v1-resend:
  - added Acked-by and Reviewed-by tags from v1

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e6609b78998d..96ae7f628da4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14129,8 +14129,8 @@ F:	include/linux/maple_tree.h
 F:	include/trace/events/maple_tree.h
 F:	lib/maple_tree.c
 F:	lib/test_maple_tree.c
-F:	tools/testing/radix-tree/linux/maple_tree.h
 F:	tools/testing/radix-tree/maple.c
+F:	tools/testing/shared/linux/maple_tree.h
 
 MARDUK (CREATOR CI40) DEVICE TREE SUPPORT
 M:	Rahul Bedarkar <rahulbedarkar89@gmail.com>
-- 
2.48.1


