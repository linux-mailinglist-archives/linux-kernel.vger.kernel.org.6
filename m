Return-Path: <linux-kernel+bounces-412741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 533D39D0E8B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8FB11F222B5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E2E19412E;
	Mon, 18 Nov 2024 10:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GiOMVz4d"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1836C192D80
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731925866; cv=none; b=IQUvhntcxdSp1nj3viUJFXW1k1XvW7ll7d3FHvMypoxaoSjW/Db8A7LKuIlZk0sp9oQ4p/88XJZKI40q0r2dFI7UUMkwamKSZBvHQRwFiJElqpbvxQYZlOuC1RynwpCam+3TCCTmjMOVb0dPyxlePNfLlmjRr3djG5qhDevQJ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731925866; c=relaxed/simple;
	bh=hWe40PeRwqchhdjkiM+bFseyNXT4rLIrzqG3AD4BN5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G0xk1rB/gtQ+XZuRc1G8DcRrXkZzxggcub1FrlJ9aL208fJgEePTTrWOEvYpW/OCEPADNFLUMolrY1EiPJuM+dbouv33XEpii4OM0KjYQiRNU329DtOtOeC5PWnw4qjG+Bl62TnMDVv3TwMDjQD9vmb3intbpv37hNuW/accfCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GiOMVz4d; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7f8095a200eso2764261a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 02:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731925863; x=1732530663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hfhPoYU22fu60AZkfd8s9hywh58AWPEyBD6Ti+IVZRg=;
        b=GiOMVz4dLh+dPj/lRLFMcpc64IWStrTjM00P5A9r6cFzgcqxOOzODX/SSS1v4U8vY5
         WPJfaBq76og2kid2kzxtAs6aQS8iLJoSrbrSswKGGwU+hUHx+8D9UgAvktY31oQHjUug
         2shYQB9Gfl/vgFj6O1j1YEF79R7T62FGQB6rA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731925863; x=1732530663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hfhPoYU22fu60AZkfd8s9hywh58AWPEyBD6Ti+IVZRg=;
        b=beBTeUED7RFSp7iCZKvoen3pQ/i6hGEOUoodwhW/1vaUaV61hUClPOX33E+3wC0Hci
         aoQ4G15Z/zrmPo+wMTpKccURAKvtv8gwZ2ZNcjxlyNSKNBxX5WfXyESNyOM93vDc2Ve1
         YWcjtwlKQcHUGY0lw3AF1gv06687Im10dbyAlhMl3AW4bkzQFy0mx3kiJbi5OfwrLSXE
         CbzzXvdkdCq1YN8OozqSdkN30fP6cC1aY4RqyOSweywvSe8RKGgLsJ9Oq1ZLHGrt1tqK
         t7AiqOhdCdKJfqX9jff7rxE1NrfYlLKiAjgAQJFDgbBx+r3n4uSv0HQpHH/O2fx8kdv6
         ujRQ==
X-Gm-Message-State: AOJu0YxwLkRg/donqEzOeZaWwfgQ3HTpHf+hTMFbcTXgbjXwq+6gv6qt
	RPZB/sftlnwS1DBk9ehvXPqLN76qoDJ+HcEBGB3u5VqrLfO2Fwp+i0R90pHl6EpdW8PsowOgRbk
	=
X-Google-Smtp-Source: AGHT+IEY8k6odiyKxs2+melHcZslRmufs2gBhItCmhFu+vTqamj+rrNQMOE4OTdvy2aecd0cxs0buQ==
X-Received: by 2002:a05:6a20:7292:b0:1d7:e76:6040 with SMTP id adf61e73a8af0-1dc805101d9mr28192069637.4.1731925863370;
        Mon, 18 Nov 2024 02:31:03 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:8826:78b8:a8fe:1066])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7f8c1c13354sm5657473a12.10.2024.11.18.02.31.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 02:31:02 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC PATCH 0/8] zram: introduce multi-handle entries
Date: Mon, 18 Nov 2024 19:30:31 +0900
Message-ID: <20241118103054.3191944-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

*** RFC ***

: Given that it's merge window time, consider this low priority.

	ZRAM_HUGE objects are incompressible and each takes a whole
physical page on the zsmalloc side.  zsmalloc pool, natually, has
some internal memory fragmentation (within size-classes) and what
we can do for ZRAM_HUGE objects is to split them into several
smaller objects (2 at this point) and store those parts individually
in regular size-classes (hence multi-handle entries). This, basically,
lets us to use already allocated (but unused) zspage memory for
ZRAM_HUGE objects, instead of unconditional allocation of 0-order
page for each ZRAM_HUGE object.

Sergey Senozhatsky (8):
  zram: cond_resched() in writeback loop
  zram: free slot memory early during write
  zram: remove entry element member
  zram: handle ZRAM_SAME immediately
  zram: factor out ZRAM_HUGE write
  zram: factor out ZRAM_HUGE read
  zsmalloc: move ZS_HANDLE_SIZE to zmslloc header
  zram: introduce multi-handle entries

 drivers/block/zram/zram_drv.c | 351 +++++++++++++++++++++-------------
 drivers/block/zram/zram_drv.h |  12 +-
 include/linux/zsmalloc.h      |   2 +
 mm/zsmalloc.c                 |   2 -
 4 files changed, 236 insertions(+), 131 deletions(-)

-- 
2.47.0.338.g60cca15819-goog


