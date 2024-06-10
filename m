Return-Path: <linux-kernel+bounces-208370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DA7902421
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE0911C22390
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA73139CEC;
	Mon, 10 Jun 2024 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IndhcYva"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D7D38FB0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718029883; cv=none; b=hMywQxaDhTJPDF4Bkegv9eP7WfvYbouv4DWRsUBTZHaY18Nc/qd9z68IACHpSASZ165PlTMuDfhALFeEZqJgTOHCZ7wwCLdA5HJZcSVD0IugdF/HFiLV6qvnA9FyBLblD5yzREZpR/M62I9qDwRs0Qo71QQ/nOaAgiIs5+sFId8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718029883; c=relaxed/simple;
	bh=VwUpWbn1eWCMUzpw9sv+oHFcN1ZTLQ6ELIhkrq62WKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JkG2J9c84rT4rB16zwbSqH35K7FxuALWoPxpnIn7IO4OuiSM2/A6SJSy2yJNcFS2lvsxgOUNc3EeZ7m4lT3gyE88k8sgsa1R7CEoAgZ1KBSghR2OHxgYer06ZgkikSivEKAKtRxJR73dl9/NHgE7l1pc6ELQNgIggaN3ivrBkkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IndhcYva; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-79776e3e351so43958685a.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 07:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718029881; x=1718634681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vmkoYQdN2TcqhXW6bXeE/domfSCU9DERaxqlSrdPGI0=;
        b=IndhcYvatTFcfkxBcy1lTKkhoAd2iwUa4MMdxYZ5hKJGX02jjZwIVDaLTNmH/+bgXc
         SDI5HcCMHfoNrr2Ip8oiorAdJ+6GLBLCsdL3aaxcsgePE3D5uUfPV+5IBnW4UhxzkCEK
         O0WyiJKWvGyFWW9o8nMA77MbNhnXUQKPogRM86+ymPhYob7NnIH7Zw7tpz3IbJzvdy6t
         f6KrgdnAf9XN9Zo7+xnGv+DFk4mvx2asZI9tck7ySdbe6hvuDEvYfQYPYzHsu+i4won6
         KXbXqgVEJyLUlwRmn2ziNLjJVgoL+fqrfO0TrWUq2/sT0vwFK+iLrqG+hQBzQd7y9nqW
         jXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718029881; x=1718634681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vmkoYQdN2TcqhXW6bXeE/domfSCU9DERaxqlSrdPGI0=;
        b=iZLKWMXM+ixgs5qCEbYoyrblvG5MBezLXLsKKZ/w3de72IH9us8JEoYlWwmq4TynAv
         hdK9ifeaBVueD/Z2/WcxFBfsc/4hJvUZ9WhOqoM8oiZUJ1qH/n20Q4d+j1+NCZu46HHm
         CZEGpGhhQg8NaOsJngoN4vyZHPuFuTDpDC4vmHgqN2Vo3kYq6gaZi3yIczoH1f339nwt
         3yaS5Vnxe7JHvLFevfYkWK5fmFdqXsZouezbfRM8XK81YLwAKGQrjNc1m1xPBNXwKAYg
         n1EiOd2wARMidqd9nCzBQI9/6mvhGJmZ/J/gecoEk/4FyKTeQ+9LdD4tQnwFmQ2OviX2
         uFPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1HWBkQHESDVmTVPPbX0aMaHXSHX7qNJEcAGLW5D9TJ9ZZxEGqpA5pCPvtDuhv4VLoexlq9/Kc3HiRYg4Pd6elebwYCaK/AnaXZOYa
X-Gm-Message-State: AOJu0Yw2J2QfvRYWDHBq/GOtr6z23BSY6MYE6a3eLtYYJBimTMa4lF2g
	mGa8CI+2rDkA1UnZ35IdsAhqffxIyXCaIIl00e28PRyVyJ3h2ymB
X-Google-Smtp-Source: AGHT+IFPp5RhKtZQ9MvS14DPNDaymoojuA/+cEjt/zxS95yHDKvW19lgNaZZnsBE9iCx7f/aMTPNsQ==
X-Received: by 2002:a05:620a:4556:b0:797:a649:bdbf with SMTP id af79cd13be357-797a649c0fdmr156842085a.13.1718029880727;
        Mon, 10 Jun 2024 07:31:20 -0700 (PDT)
Received: from localhost (fwdproxy-ash-006.fbsv.net. [2a03:2880:20ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-795593165e7sm195488185a.65.2024.06.10.07.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 07:31:20 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH] mm: Do not start/end writeback for pages stored in zswap
Date: Mon, 10 Jun 2024 15:30:37 +0100
Message-ID: <20240610143037.812955-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

start/end writeback combination incorrectly increments NR_WRITTEN
counter, eventhough the pages aren't written to disk. Pages successfully
stored in zswap should just unlock folio and return from writepage.

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 mm/page_io.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index a360857cf75d..501784d79977 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -196,9 +196,7 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 		return ret;
 	}
 	if (zswap_store(folio)) {
-		folio_start_writeback(folio);
 		folio_unlock(folio);
-		folio_end_writeback(folio);
 		return 0;
 	}
 	if (!mem_cgroup_zswap_writeback_enabled(folio_memcg(folio))) {
-- 
2.43.0


