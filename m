Return-Path: <linux-kernel+bounces-278662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EA894B348
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 00:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 785C61C20C95
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 22:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D471155321;
	Wed,  7 Aug 2024 22:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="M0vVn6q2"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59321153BEE
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 22:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723071520; cv=none; b=JCj7oy0JBTrsw+KUryuDfKEe8x17spf+pdqf9DlWvCytinkCBDQp+XE6TVn/UEIlJ60yqmXF22T98RbHioCKddCE6QcM2n9si+nxuMPBR/Axtq1XGXkHy/Zxd50BxabZ+NIiif7gx+eTMc2ToeRD9jg/WfhiqcYhfbOFuKUIuFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723071520; c=relaxed/simple;
	bh=jrAMGvbH0SDgFLoc2rnAO7ghu3IrjMzhLU1CuaePcqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EcGy4VttCfhSjMuW1LFnMZMdcTu8H6QgwWcZQrHS5flu6vx4TLkQBxSF/kVfj7p12Y4NL8mtid70uGzvmI5hRWQgTdm64sqV/LycYx0LM0LxVQZXAo/5HX2+bPem08dIGwlw97ofZl/vjk3ndwmSkDt0Cszv76pWAA3r3BfOo14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=M0vVn6q2; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6b7b349a98aso3876266d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 15:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1723071517; x=1723676317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZutKaF6SdOWz1k7kyafWuql30ajKsBcjvYSYRDagsrU=;
        b=M0vVn6q24r4XxHtQ81z5KLSyVeIPVyMdn6NE6GiybbGez1DYCgIbDDbAWAzScYkmTO
         XeyRnFiAQTg5nN+N4X+lfEQZRJN1sXVUL1JtvJeu76pQTXkzBPY3PLwVEn5kKIEot7Qs
         sz0Sh1JTfCz123QoSV8MPXdF4Z1D6uoP5KKPbp5WRPpCdieeSCBjbvIhPrxUzp/mQhfi
         b1pHB6z0zpCepQbhEPFn/SvuJZ2juGGnVy3CrSwFf+EIPrkpjwQxIT0v430j+O54H+zE
         cF4RnAV1ZcwD/uAIGyFjirebEPRRQNRfeJWcJ9cApDb+IFHOYxNG6333pGY72ev001js
         vRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723071517; x=1723676317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZutKaF6SdOWz1k7kyafWuql30ajKsBcjvYSYRDagsrU=;
        b=d5nUQSR/pNcmS2sKlK15pBsMDHa73j8MNqUskeJUaXweu9UocVlrrWuFr2828sb6sn
         xIKVSQHT3edYAWZ8hfrJUVP2LHqSvPjFF1umGI1WTYLAuzGxHz68mM9+5hS4iU7AWtZm
         uLjAr0huoOr+GcUEziPsHnFleg0nvc7wsfcv7iKh+dgVETqFznZE18rTDdYwXL+Z+xvv
         o3e/vAu0qd38btuZMcrByTKDDBlrV/QQy0YsiE97yrVUzszkApRCZ8WYtOAguIX6iuhq
         JnAPH+cVTDH3KQmbAXQpCPrDWZuoI+uFKqsIsRujXBqYdK+WhE2w/wERIqrVK5NKVqVh
         ocTA==
X-Gm-Message-State: AOJu0Yxb1iRIqSF+Lr0f6B45AOEzCHrTRWOiN2/FOnpV0T4JWrygcoTC
	AZaJj1XAY8jjBJmg3+2d6wG1s28RDT0JVs0XONlzDFvUBcaQOeTksRsZpJm4iL4=
X-Google-Smtp-Source: AGHT+IF5BktstHYrHWotu4YyqQgntJRdwILIR+1LenNlhEiEcNuH8phOeFVeezna1eXyKzuw2I6PDg==
X-Received: by 2002:a05:6214:3d8c:b0:6b5:e190:435 with SMTP id 6a1803df08f44-6bd6bda2d34mr1532896d6.50.1723071517006;
        Wed, 07 Aug 2024 15:58:37 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c7b82cbsm59997096d6.61.2024.08.07.15.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 15:58:36 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	ying.huang@intel.com,
	nphamcs@gmail.com,
	nehagholkar@meta.com,
	abhishekd@meta.com
Subject: [PATCH 0/3] mm,TPP: Enable promotion of unmapped pagecache
Date: Sat,  3 Aug 2024 05:47:12 -0400
Message-ID: <20240803094715.23900-1-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unmapped pagecache pages can be demoted to low-tier memory, but 
they can only be promoted if a process maps the pages into the
memory space (so that NUMA hint faults can be caught).  This can
cause significant performance degradation as the pagecache ages
and unmapped, cached files are accessed.

This patch series enables the pagecache to request a promotion of
a folio when it is accessed via the pagecache.

We add a new `numa_hint_page_cache` counter in vmstat to capture
information on when these migrations occur.

Gregory Price (3):
  migrate: Allow migrate_misplaced_folio APIs without a VMA
  memory: allow non-fault migration in numa_migrate_prep path
  swap: enable promotion for unmapped pagecache on access

 include/linux/migrate.h       |  6 ++----
 include/linux/vm_event_item.h |  1 +
 mm/huge_memory.c              |  2 +-
 mm/memory.c                   | 21 +++++++++++----------
 mm/mempolicy.c                | 25 +++++++++++++++++--------
 mm/migrate.c                  |  7 +++----
 mm/swap.c                     | 20 ++++++++++++++++++++
 mm/vmstat.c                   |  1 +
 8 files changed, 56 insertions(+), 27 deletions(-)

-- 
2.43.0


