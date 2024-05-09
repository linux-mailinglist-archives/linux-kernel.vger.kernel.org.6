Return-Path: <linux-kernel+bounces-174937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9928C17AE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 878D71C219AE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125D380034;
	Thu,  9 May 2024 20:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vNJnzrOL"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3C578C98
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 20:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715287154; cv=none; b=PETkZgSKlra9xIf5daTAbt7ZLLKCv1f2E/XaznE1eSxfAu2yg0wv1li4BE5NXITU+UyVj5BY330CN1OyonbxXSLKHADj8a9YTvn9M0vhP4ZvqKwQ3AqLIxEA3Ru+fmpokVximpBzJMcxhHr6VInQIzN0ZqgmLHtWxrDIuDF5pN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715287154; c=relaxed/simple;
	bh=OFtfeZMgbGqPFPCcL0g1X880SGx7GmE9rDbCocfF/LE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IYGGJTW3phKlFtv83XkEADenhzrGfmcFzG2PkuQ+kf2ZnImaJuPmhu9BCWTJ41+erG7dBf53CeVwwLmmTIcTWOFtxTKRnLjzT38wg6SXDg9WdDe8s3brVADQyLfYhui2aCKld307a+qhRpVxtJhnAikL8n9CCRvnbRtEaKYlCHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--axelrasmussen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vNJnzrOL; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--axelrasmussen.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so1776963276.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 13:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715287152; x=1715891952; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8H0foUzLc+DNKUibRdC2bbcsFy9WZnKfOBJjcXN9vjM=;
        b=vNJnzrOLy9dtBOv0ba9LKcFPEXHLb4vETgVR1+DEnxWA/2Llp7054SwpVxOLMTmmch
         yrgmndLe62SmbpnRH4RUmyezYwCTxXBMzKF3reMCANWkNbsCxb3Auc8PKLsAOSUFSf1A
         KkG0PRBghKW285bglVQrD5gaNbQfMFoh0PMyWJNp5LzZHtzBSJxyGWTdVx1YdcA74nex
         zfePHah3PkGaorYayqFAkEK9HcUuXk8yaEqSsKMwZ3D1HaGsrH7nXH9cPvRXk+85/40m
         NB4WWBWgKorq3JwwPq83xH3zeRrvG7JcwqFioXglU1mS3zok1r72/MNjzmGo6+bb5g72
         KQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715287152; x=1715891952;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8H0foUzLc+DNKUibRdC2bbcsFy9WZnKfOBJjcXN9vjM=;
        b=naq17/l0Mxf2qC3U5ymzDO0VGahBu73RpRF14Dsh4Zqs3nv90TA+HMH5w7qb31RcxN
         k8egsuu/U8ffNLieUQr6o+xc+GGohqksUMR7BYtWuGuCG3D8Gayk5f3F1friTiTHBVSK
         uobYZWtx3MiR9Ag87EN3wXkHFalz5UoGxlFKyNxBgk/Hgq62GyugRAMN2aTJLgJJFK0n
         d/MOEKSJytbDkYd25QVfbA4fNjcm6PsvQU41iWetnEAQHz65SAydTeDD6kdc5KaSYzVP
         l6gxoVzm28BlPcfZrUiObDL5AANYPDmhOxJMsMvmzQfuzLgKsUfDSqFPxkJ9kZ9HvUuq
         ALvg==
X-Forwarded-Encrypted: i=1; AJvYcCUkiIO17EVT2P3skYN5gJBdh04S/8P6+/B/V/p8UnD7pqsjD+fLs/tx/SqHbCRmQJ1DPehppX32vMtrRrGxJvW6fdAaV+f2fue6n/pf
X-Gm-Message-State: AOJu0Yzka5lzBf3TDirryZwoJYLO0+R2zykuj51SKHzZDbvJbZaCSifp
	F29P5gDjZHl05IICdfOjnaqAtL5AwZxf88eLzIuk2CoDx6QwSEqs+wVYk8u+7zn3NdubeVHoMGB
	TXD9+CKiR6j/I6cZcxW0ov5fFXmla8g==
X-Google-Smtp-Source: AGHT+IHw+Ly/UkJisBJVqZ94ZjHYJRR327iKkqlhJCNLn3MTfbX2oJhIScyImN5vnpoTsLVJRylwSVasWSMq7OxW06/3
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:22b1:9c9e:3544:83b8])
 (user=axelrasmussen job=sendgmr) by 2002:a25:1982:0:b0:dcd:2f3e:4d18 with
 SMTP id 3f1490d57ef6-dee4f364f84mr62533276.12.1715287151918; Thu, 09 May 2024
 13:39:11 -0700 (PDT)
Date: Thu,  9 May 2024 13:39:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509203907.504891-1-axelrasmussen@google.com>
Subject: [PATCH 0/1] arch/fault: don't print logs for simulated poison errors
From: Axel Rasmussen <axelrasmussen@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Hildenbrand <david@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>, 
	Ingo Molnar <mingo@redhat.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, John Hubbard <jhubbard@nvidia.com>, 
	Liu Shixin <liushixin2@huawei.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Muchun Song <muchun.song@linux.dev>, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Suren Baghdasaryan <surenb@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Cc: Axel Rasmussen <axelrasmussen@google.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch expects to be applied on top of both of the following related
fixes:

- x86/fault: speed up uffd-unit-test by 10x: rate-limit "MCE: Killing" logs
  https://lore.kernel.org/r/20240507022939.236896-1-jhubbard@nvidia.com
- [0/2] Minor fixups for hugetlb fault path
  https://lore.kernel.org/r/20240509100148.22384-1-osalvador@suse.de

The latter is in mm-unstable currently, but the former is not (yet?). It
would need to be taken before this patch for it to apply cleanly.

Axel Rasmussen (1):
  arch/fault: don't print logs for simulated poison errors

 arch/parisc/mm/fault.c   | 7 +++++--
 arch/powerpc/mm/fault.c  | 6 ++++--
 arch/x86/mm/fault.c      | 6 ++++--
 include/linux/mm_types.h | 5 +++++
 mm/hugetlb.c             | 3 ++-
 mm/memory.c              | 2 +-
 6 files changed, 21 insertions(+), 8 deletions(-)

--
2.45.0.118.g7fe29c98d7-goog


