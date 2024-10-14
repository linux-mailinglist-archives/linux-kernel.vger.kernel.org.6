Return-Path: <linux-kernel+bounces-364147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4450899CBCB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D84AFB22AD6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19BC2744E;
	Mon, 14 Oct 2024 13:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=batbytes-com.20230601.gappssmtp.com header.i=@batbytes-com.20230601.gappssmtp.com header.b="OYKL0oFj"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7BC8F70
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728913593; cv=none; b=gV2DGuOe7EmYb0VytNV9e6zcIn5Y4VbQdxYtMHUtLe0I+h2afNu6VW0pRxxw8HzqjIC9BwhMhrwZsdNNv9FMHUSh/5KRwJ3Bz2w1SnFuU8cZI8Gs8zFYkmpM0K+Vzf3B+0U4Nl+GXP/ufhnG/xdsYTOC2W6vRA5xlV6s6pbaOZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728913593; c=relaxed/simple;
	bh=/qI5UcMNRHR66S9xG4yowTz/slqyiym4+xUDmifwVCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TBifk7+1zzDk7W9GLP3VFrnySSR+PHnyfHMF6UqTA1sy8qOiOf1zwPeOGBbl0zCUY/ZArmmXTfoHVCHkbB19OTWoqmUYt6zkSX6vdE3itl9QF8fDpsYsBmCcyR3060YOlxaYGlaHYVeY9iFTV7c/WkgHm8TrHuL2JGITS4uXstY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=batbytes.com; spf=none smtp.mailfrom=batbytes.com; dkim=pass (2048-bit key) header.d=batbytes-com.20230601.gappssmtp.com header.i=@batbytes-com.20230601.gappssmtp.com header.b=OYKL0oFj; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=batbytes.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=batbytes.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6cbf693d794so21679686d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=batbytes-com.20230601.gappssmtp.com; s=20230601; t=1728913590; x=1729518390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=crqj33oZHxX79g7WIfZIRty3wF/s5+QQhWMYPqOuedM=;
        b=OYKL0oFj9Lp8Cij6UBXwAhgphRqppNuqwBOkdHRvDl6r3UqgLINm6Rq0CLpaNdrG+D
         773ShV4LZ1AaMMMsBH27lfYjhiRW1D91tDnr2pxTrvaLLZug9dOPADmDtXS9K7rgRIIi
         j8YXkVZHPe6nTf6HRXYcrMiKfRJ2wzs+BUOdge0fGnsOXgi+qshjtwN9Uj6G/B0eoZ7C
         dmwl3wxmTFurzwLkAzJPhFS5vqVVbTVdb4VISVgGo68oqEZ/aGokGEqzfzELDX17E559
         dVCT6Epw5UgHcviCyj7M1Tvo4XJ78ew+F3FBZmzyvdwZ1Z1IDuPH7dnNdC4NHU952UGJ
         QZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728913590; x=1729518390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=crqj33oZHxX79g7WIfZIRty3wF/s5+QQhWMYPqOuedM=;
        b=gri/cOCGLzw2gHMuJxIgG7pyDm3pc7/TZCMKoTTAUe+ZUcIh573AjCY3/lQjTKF2RK
         6GUN05MgqWnSO+5y5o/Nn8tcELmK4FO5Byxfw/LeIgc2i2an7fPaCg9i4/imFBSnJo9l
         Dy6OREzQ8EA97DpY5pOcP7A5UG+gI5Pm/DAe40EBQU/vODfpNstkFZ3F+XKjANcy7heg
         eyyuo+JXA8O0+hjfTdXAjL9HVBQzAwkkIuuaHd3J2OBw4g5Vc8aAIhPgAuAZgz6wk2w2
         xRcuuKb7v/xDl7GihpobunoljVTZ+piKGyIh0fDNZvTYnEsFd9Nf0y/MdLwEKBunrvWL
         y2fA==
X-Forwarded-Encrypted: i=1; AJvYcCVgXUYTqMmvCCtc/oC7fN+DS1wYxonbFreadZ2WSyKeuNdktgmPlHvSeqOB0d6wJOHBE8Y9rzAYKb5mjJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjBhsR3TfmlbqsHvogseJiY/EUhBTmtxerqW+G4tG4FemF9Xk0
	EGR7fwc+qha5E+BehlZHAY/zNA/80RtzkQAYSWl+sbAD2nXLtAxz5s89FqF0GQ==
X-Google-Smtp-Source: AGHT+IEiC+HwEdLjgAYy8MxWH9fW+9EeCReHgvGFDOV5UFEUPy97V6+O/7xZcMFu75Yfallz1txEFA==
X-Received: by 2002:ad4:5f46:0:b0:6cb:440c:c44 with SMTP id 6a1803df08f44-6cbe52024a8mr256666466d6.1.1728913590195;
        Mon, 14 Oct 2024 06:46:30 -0700 (PDT)
Received: from batbytes.com ([216.212.123.7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe85a7700sm45584966d6.7.2024.10.14.06.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 06:46:29 -0700 (PDT)
From: Patrick Donnelly <batrick@batbytes.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubli@redhat.com>
Cc: Patrick Donnelly <pdonnell@redhat.com>,
	ceph-devel@vger.kernel.org (open list:CEPH DISTRIBUTED FILE SYSTEM CLIENT (CEPH)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/2] ceph: use entity name from new device string
Date: Mon, 14 Oct 2024 09:46:22 -0400
Message-ID: <20241014134625.700634-1-batrick@batbytes.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrick Donnelly <pdonnell@redhat.com>

Respinning this because the last series accidentally included patches from
another set.

Patrick Donnelly (2):
  ceph: requalify some char pointers as const
  ceph: extract entity name from device id

 fs/ceph/super.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)


base-commit: 7234e2ea0edd00bfb6bb2159e55878c19885ce68
-- 
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D


