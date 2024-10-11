Return-Path: <linux-kernel+bounces-360655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F18999DCD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7959428650F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1525209F5E;
	Fri, 11 Oct 2024 07:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ic7MTMqD"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB269209F36
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728631407; cv=none; b=u7jAWtHuNtmy8w6o8AFXrdE/ZCLai28xy4aRigoRZU3Qn+dQB+JkRLwdC5fV8K8TPEvwsmevJgKJbJ47ajVmtRMQZEZc+PMt+Hq/yruh0zPyd8ploQMbYbf72SaS97xZiAx4UutxgmIHEvLmrSnegKedjPa9mEEbcUT5LJtB440=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728631407; c=relaxed/simple;
	bh=BMgEaXBnjaxMBpYLWjVqH6DNopDXyup4Gqb/t5sSzbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CUSIH8P7i0NeHBZVdTmNh8w3tQU11neXRuAZJuLS1JLdtfTNdSd64O3vLYyNZ82KelrHbGkpSoM5uBZGqkgtWrxYvLmQBLg4L4+OE1uZcChmtV/+R2mbFsbYz5W1AbhcPebmTk/eme3c0wRPUEKTewDi4h3C5l6vkuiA/2U4ueI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ic7MTMqD; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c71603217so15968875ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 00:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728631405; x=1729236205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XnEaqowfcnk7jkRXbNgb4/5Y6pMvkA79KiBX2pek4eE=;
        b=ic7MTMqD38t1GYHGKFfWBuIDAwT+UsZZ2qbiTyY9Ztj2U+CTU1H1K0JU/U+QDVjXqp
         h9b3K/k/vHnYbf2XhEOPdOjinmkJatNnUAwXWmyyJYPLbSFJgQIbw2jKpqpVXi22Ztjy
         wmv/KCSbVOU9W8GxYImCnW8vGBycFw/ug3wlU+evSGx3s2ZMx752Hc0FoJnDEBwSatEq
         sj3Vh2qklFeW/ABaPg8beKn5ZS3y0Oses8uSgp6S5zf96LCA488YWCF/kKcPpPN5la2Q
         ndKHcvQeEiZq5D0DNbH919lTOrA5qNDHlqSgl+LAmM0rJLdS4VpXnO8SwOgmYpF90A+j
         V3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728631405; x=1729236205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XnEaqowfcnk7jkRXbNgb4/5Y6pMvkA79KiBX2pek4eE=;
        b=Maq927CGnA7tuJg2GScsalFEcM7mWLWxZFBrtl8i9eJkLhaHJw+YOR4DMsB1FldwQG
         WSAcACox6JUIzPtpiDY4x2kKMtTtYLhekZYHl0Arn56AT18U64EMhr2DYWnb7gFKQHb6
         9LVwbzx38hmCiWXoZskmUzm8tgaxWoiyGiiwSfyiDHXKaDUlve3FuK6c2Ro+9Xdxz9d0
         OSZSfcs5uIuNaaP9AiB+rZTdUo3o25//G2KbHysvf0xsysjZZUQ/DBdwkFeurQRw/zKP
         LHMN24dFynrehRKGoCjdKdpOtKh/U2W16OVMfWG8poRQTmfpwbBjQZCP2abigiYPPdqS
         5bsg==
X-Forwarded-Encrypted: i=1; AJvYcCU1q37oYVrIp20kZYttr9cOr+kKyyaY9uvV8xVLkU4M/Nj5EYgo3mDXMnjbvRMWsnXi5nl0khCy0tcvtjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyriz+CbHgC9esURp0YpzLB8gkngLFRlHX8CDazPdrd6GJiJJ2E
	nCE39xBH3r7u941oPvkIFwEuSbAmeeqCEQDqQpmLveP/6il3Jq1I
X-Google-Smtp-Source: AGHT+IEFSIOyyGQ8iJm7Cv2Shmsw3hdd0D/3Fh+uN3QrHhs9C/KyWtczMqCxJnNMNXv5/J4NljymUg==
X-Received: by 2002:a17:902:d4ca:b0:20b:7a46:1071 with SMTP id d9443c01a7336-20ca13f7200mr21256995ad.4.1728631404978;
        Fri, 11 Oct 2024 00:23:24 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bad335dsm18825155ad.50.2024.10.11.00.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 00:23:24 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Donet Tom <donettom@linux.vnet.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Sachin P Bappalige <sachinpb@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v2 0/4] cma: powerpc fadump fixes
Date: Fri, 11 Oct 2024 12:53:08 +0530
Message-ID: <cover.1728585512.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please find the v2 of cma related powerpc fadump fixes.

Patch-1 is a change in mm/cma.c to make sure we return an error if someone uses
cma_init_reserved_mem() before the pageblock_order is initalized.

I guess, it's best if Patch-1 goes via mm tree and since rest of the changes
are powerpc fadump fixes hence those should go via powerpc tree. Right?

v1 -> v2:
=========
1. Review comments from David to call fadump_cma_init() after the
   pageblock_order is initialized. Also to catch usages if someone tries
   to call cma_init_reserved_mem() before pageblock_order is initialized.

[v1]: https://lore.kernel.org/linuxppc-dev/c1e66d3e69c8d90988c02b84c79db5d9dd93f053.1728386179.git.ritesh.list@gmail.com/

Ritesh Harjani (IBM) (4):
  cma: Enforce non-zero pageblock_order during cma_init_reserved_mem()
  fadump: Refactor and prepare fadump_cma_init for late init
  fadump: Reserve page-aligned boot_memory_size during fadump_reserve_mem
  fadump: Move fadump_cma_init to setup_arch() after initmem_init()

 arch/powerpc/include/asm/fadump.h  |  7 ++++
 arch/powerpc/kernel/fadump.c       | 55 +++++++++++++++---------------
 arch/powerpc/kernel/setup-common.c |  6 ++--
 mm/cma.c                           |  9 +++++
 4 files changed, 48 insertions(+), 29 deletions(-)

--
2.46.0


