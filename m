Return-Path: <linux-kernel+bounces-572116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A75A6C6A7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 01:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B4DD7A62EC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 00:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FFD3FD1;
	Sat, 22 Mar 2025 00:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IUs9Euz/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C262E338E
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 00:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742602897; cv=none; b=Hbjh75chY1tlL2AMGMD2ssih4eFNkmkrDA/yn4jKrn762XbWPPA/b1CsruMFincROWLeWCzczwhY3h9sG92GvlwmDFg7nM3CQ57HAse9UfUBoHZSy/Z/M+SA8PggDkIo8KoQRLqes8yROGWJaZ8sZwGUNrQ5MLS2Hr8vc2YswVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742602897; c=relaxed/simple;
	bh=RTZ9cc+sNaQxMdvKSjWld41AH0XbRrm6kSg8HH77yNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FHSd4D2b/zcXXEf07X6RTMSmNW2y1ESD7N4LlliGHjx+e/KNo0W/6OglIzKKGviflrWvnKJLNfKGOxL1jICeKnupRac8tGlbdxG7/a4sIpRZDsTFSz48hR5gdcqIE6aaXQnpKiIBmO7n+lDYynq3yUG2zKXPaRxaohP4wW+Hq28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IUs9Euz/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742602892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RurK/c4nWFnZ2sp5EDpYEg0Hunh+TYZj9n6rHmYHzCo=;
	b=IUs9Euz/NJS8kpVL/hL1WrCdrDQepXKNWLRqGVVCrzGpl2LvsFGKrZOJibH1BSEW7e3hp4
	N5G8tDWlHm+XWLyuCw7mqwuIjTWlO7lN2Uv1rRd8Pjhlggj+aDqRZPB3vTb0ILM4pkkOyj
	2vCYiOmeQnOxkckPSs+SshtNoAUS7Zo=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-feWwOg9lNDm1lKqnoFtxNg-1; Fri, 21 Mar 2025 20:21:30 -0400
X-MC-Unique: feWwOg9lNDm1lKqnoFtxNg-1
X-Mimecast-MFC-AGG-ID: feWwOg9lNDm1lKqnoFtxNg_1742602890
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-851a991cf8bso309955439f.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742602889; x=1743207689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RurK/c4nWFnZ2sp5EDpYEg0Hunh+TYZj9n6rHmYHzCo=;
        b=u2pbq/TxvEOq+BGj95eEDpdKOtmZeziEa62vJlqoX9+1TubD/4Id2uFwTLdy5HxPHH
         ZoEdd4refqUNDPCMO3Ipz6/mmzZMnxcurlXOUcMsDJxdADrQ4kBo3QSzMEaVi6dKuy6H
         +Qkq//xGKgibkyTTuVPHp3wwz6m1BT+Gfd1VKtrlD/bXDzGAamHdMLMxUZ3y2slG54mv
         BI9j74+Nt4JXgTzBa1ZcnNg7ACabjIp7BrbdEORSzL9kgj8EvFf4Oi7KsFQ3NWW5LxiG
         e08ryfhvOOgYD9dyd8sglTmm/jLZUyVuOAF+JeBielMYerNLxEF8Y95wG1/PbJCsUiPt
         pMZA==
X-Gm-Message-State: AOJu0Yy2gXZuGsOPh4cBSpE/9CqffnTwigauGk1u58envyckb2Os9OY4
	qopVyMZ0l0Y0ehsxHE1V9xiBNVu7mDNrddpxdVJXwuAqUas47xOm0di6goJhc5vuyaOaNFAZ7Nj
	SviPbbWLR8uL+VNPKwoYLOkI3cmfHcLxFoPAq5rAOR/aPqB/4+irtk2v71y6LrkdfLtVHRUSbDY
	p/E8Ed2GihQOGJOsSP2eY0rpuPRBlO70qgMfnz6wKTSz4=
X-Gm-Gg: ASbGnct8t0xS/4ct/IVzYpMk5y4YvGfmZIr8HmO1EVP3g8Gj1xZh7QmhLjs8zquacD+
	5iWKLvQShZBE/PNeYOGabsMcrMIPlC19E6iAkOQN1D6wi4tBFh1Iy0i6KUOQE6MFheV2Ajsh3fu
	Xvl45xQ+45z/nyjKK2dj6HPL0tM8vnqcdPnLcE6nKefF0L4DGnsBm/qigcM5uwUsBWdj+hlEl2v
	TvTFp6saNRAPbGA8ODZqDCGFJvb/I+zDZKWTShqMSS5jMeyKDSGAf2ps/Re9URWfrMlvtMtlqx9
	Y2W7
X-Received: by 2002:a05:6e02:9d:b0:3d4:44:958a with SMTP id e9e14a558f8ab-3d595edd857mr58048065ab.3.1742602889001;
        Fri, 21 Mar 2025 17:21:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgWAPyTO6hkibDh4Iwe07NWGGtssdR2z/lnCURasqGP2OflI6qlHclGSmthd8MwfrGMEzNfQ==
X-Received: by 2002:a05:6e02:9d:b0:3d4:44:958a with SMTP id e9e14a558f8ab-3d595edd857mr58047885ab.3.1742602888522;
        Fri, 21 Mar 2025 17:21:28 -0700 (PDT)
Received: from x1.com ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d595fc77b6sm6756285ab.0.2025.03.21.17.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 17:21:27 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: peterx@redhat.com,
	Axel Rasmussen <axelrasmussen@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] MAINTAINERS: Add myself as userfaultfd reviewer
Date: Fri, 21 Mar 2025 20:21:24 -0400
Message-ID: <20250322002124.131736-1-peterx@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an entry for userfaultfd and make myself a reviewer of it, just in case
it helps people manage the cc list.

I named it MEMORY USERFAULTFD, could be a bad name, but then it can be
together with the MEMORY* entries when everything is in alphabetic order,
which is definitely a benefit.

The line may not change much on how I'd work with userfaultfd; I think I'll
do the same as before..  But maybe it still, more or less, adds some
responsibility on top, indeed.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e714ea3a7c9f..844e3e1e05d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15220,6 +15220,17 @@ F:	mm/vma.h
 F:	mm/vma_internal.h
 F:	tools/testing/vma/
 
+MEMORY USERFAULTFD
+M:	Andrew Morton <akpm@linux-foundation.org>
+R:	Peter Xu <peterx@redhat.com>
+S:	Maintained
+F:	mm/userfaultfd.c
+F:	fs/userfaultfd.c
+F:	include/uapi/linux/userfaultfd.h
+F:	include/asm-generic/pgtable_uffd.h
+F:	Documentation/admin-guide/mm/userfaultfd.rst
+F:	tools/testing/selftests/mm/uffd-*.[ch]
+
 MEMORY TECHNOLOGY DEVICES (MTD)
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
 M:	Richard Weinberger <richard@nod.at>
-- 
2.48.1


