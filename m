Return-Path: <linux-kernel+bounces-277233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7420A949E3D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A32231C21924
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 03:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C4D17AE0C;
	Wed,  7 Aug 2024 03:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="c0U+rNIW"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B292119
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 03:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723000832; cv=none; b=jVCzyveyiIWR8jMZRnvdqQL2r14Fxfu4b6w6t+A2FSfBuk5gkEU2Kkjc+cnay4bBl+ZhuNw7Vqa7T+MKGa4/IR7ji2ZO9CXnmflrO2L5vqqJF1i4FQCw8bzMpcLkSRAhXcws6eOtgdt1SlAoEpjELB3kN3pdLJXELim6tCvCTUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723000832; c=relaxed/simple;
	bh=PSf2FfGfwm9hvlShXvVH4qt+MH+zYsoIu02haAiBcHY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mbgfhlN6pdQoN6aMafp3GNDK1GhURq58gfXTcJafWmhmN4Jo2PPzo1cTEP9wsULHLLYekk5x7pvCuAxbpPKdhCbwN84HHOVNdT9rXt1znIZQF5Bbp5VX6o50yQpHhPC7jwhQF6hGaAPAYe7SthJKThSn7uwFXyD2AFAPrLDZEro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=c0U+rNIW; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc49c0aaffso11623965ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 20:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723000830; x=1723605630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fHWiHDDtgEmQfrOkHzWRCozF8QLif4Nw1j5YmDMQe9M=;
        b=c0U+rNIWnBohP0GwDwyasSzCr/cAbMJdxMUe/gQkGnzg0zCNVBeHdzNOB7kGD9vjTE
         7c2nOgeVW9o69jSWlRyJdOenqb+ItUOr+EnlaYpqXqF6W/JHXpPz2WPK5kUlJZXeoJrs
         PI7Dgo9eGDddwMy1rYdrLo7zbZxlGH4YY8gqQeIPbv0ovZbBttzf6iNJIOSQ2hXAtq8e
         T1Y04j8aYvPs8Wn0ZV4y9oBCyoNzK0jIpvDuclr68Uz13x6sv3yPYCF1dqjhyEDhdgt1
         uGZZkC2P2ikhLeCNNyXWlS/xc3T2SNGs1HUrzqpmvxiTLppezxQeb+z29R/FRFNoOS7x
         XCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723000830; x=1723605630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fHWiHDDtgEmQfrOkHzWRCozF8QLif4Nw1j5YmDMQe9M=;
        b=Dt8Mlw4sxc44+EzLZP8g+jgnjymtnZeH38T/g/8pljJiQFE1wvBHUYGEVkk0sdnnJ3
         n6t1dKoYk3chLfb8J0R8e5Lu4uaGDG+EoDCRlQE5I/5RGSUQtfTC4Jj7hiVCpQS1tt6n
         Sq4ZQ694p16TsxL0RrZ68Mkvjh7ohYK8/4qjUsMJM8vYt+N4b2NAFJCNyCMehD692Km5
         EL4JOkEDFDtdGN0ECcRSkPUjw6tjmKu3mBSLN5KdnngHKiUQMEviFGBvAleB1uuZRlwh
         Pp7IlNRrMv1VdNliYZ8+1zJ/uzPZpu4NSvyGWWbDcm7pbtObOAjxieQdmNzK7b68t4i1
         y7yg==
X-Forwarded-Encrypted: i=1; AJvYcCXJsbGdJ5PTg6+rpQY5le9A4XVWmq572s/sohy+bIXEvtYuBUAUYeVqNE5Lf6mEccWP7CquSEUrWagwd8uHA323WgNoYP5mFQVk2zqw
X-Gm-Message-State: AOJu0YwIpSNZKHb79CYRXaLMrLPbC+XbkNM471MBOePLCDRGZBkJLEq1
	7sDc4tIXJEWVkaWkHgzWWlrvSutANnX864k3+Gk3d+BZFlxTh6zH4L5netUtF+A=
X-Google-Smtp-Source: AGHT+IHcZhOwKMlgZxd+felWeQBdrODExJiQTByT1SqKlSR20ml+DJFyfgohKhYvwQ4TtYQyvN/XTQ==
X-Received: by 2002:a17:902:f68a:b0:1f9:c508:acd5 with SMTP id d9443c01a7336-1ff57257f5dmr135329335ad.5.1723000830203;
        Tue, 06 Aug 2024 20:20:30 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f19ebasm95116175ad.23.2024.08.06.20.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 20:20:29 -0700 (PDT)
From: Yang Jihong <yangjihong@bytedance.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	leo.yan@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH v3 0/3] perf: build: Minor fixes for build failures
Date: Wed,  7 Aug 2024 11:20:16 +0800
Message-Id: <20240807032019.1828674-1-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v2:
 - patch1: change LIBDW_VERSION to follow up the style of
   LIBTRACEEVENT_VERSION. (by Leo's suggestion)
 - patch2: Use a new line for the -ldl dependency and with comment,
   synchronize tools/perf/Makefile.config. (by Leo's suggestion)
 - patch3: include header files in alphabetical order,
   add reviewed-by tag from Leo. (by Leo's suggestion)

Changes since v1:
 - patch3: Remove UTF-8 characters from build failure logs

Yang Jihong (3):
  perf: build: Fix static compilation error when libdw is not installed
  perf: build: Fix build feature-dwarf_getlocations fail for old libdw
  perf dwarf-aux: Fix build fail when HAVE_DWARF_GETLOCATIONS_SUPPORT
    undefined

 tools/build/feature/Makefile | 5 ++++-
 tools/perf/Makefile.config   | 7 +++++--
 tools/perf/util/dwarf-aux.h  | 1 +
 3 files changed, 10 insertions(+), 3 deletions(-)

-- 
2.25.1


