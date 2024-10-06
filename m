Return-Path: <linux-kernel+bounces-352431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A790991F03
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 16:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 102251F215A0
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 14:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A993F13BAF1;
	Sun,  6 Oct 2024 14:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="RxDzy/sd"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E09274040
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728226381; cv=none; b=Lix9OxKEdyWCbYYadxiwuB7iqvytirKMomDVm0t5p67opA1WStIfgBZ/8/Cs6qkDp/mEVkYDIl1b8kOyYMJ+JY9EZk9Egg6CTK6zcf/ffFEFZu+Zb+d/biiDnRFI1Eh0OhBADEM8J+citmcsTIidpEoQ6MLBz/Xlx7gyfHG3ROk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728226381; c=relaxed/simple;
	bh=shgDBjQqYSVf0UslaCxth3Qda0hEBLGt1sWdyIHJPVA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=npHb62y991ubB6gjEisNZggPBwhPB45VSbneA7Oa7cUtKUVDGZogo8kknjzyHjLXcDZZTuFOggdeBVLrtNVxyqHAlv3Y/sDD+CQt5N/6vDHj6e42SxoPMPUE20xkjb60hbUHm+AfeVKSTOIHxRQaeqW3pkYhS5Mg6SlQ4Bi+FtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=RxDzy/sd; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e1c91fe739so2545338a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 07:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1728226377; x=1728831177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/jN5IJB1E2Lr0al72GEamd2RYur9sqqi/hVsmg8n8rw=;
        b=RxDzy/sddpK++kRlX7NALV7binrBIaAPHAjYb1RFTHcEyReTxzdPYeLEVKFdTpt32b
         A0vj0Qs1satPkjmFxWMZJxNmmrmisCuhLu2B2RHyAt56mkTDTOBXw69D8q1+jULwQToH
         xJn17BmCM0zyRWrdRDJjkXB5fE+Oen2MQDlULNFP4S1VdXtdWNUvSitS4lrB5DnVPf5n
         XlUps8LrX7Plkieoq7wiWJRk7Vipob8RmCBQyQF3qNm2iSbzG6QCzCp6xUTd64i6ub+k
         ptddsiyFX7jwkGJm5/f1Cidq+r/mX1dsiSRW1bAwYFm0qyt3RsKFrpVEzExCIo6GUJcp
         2DGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728226377; x=1728831177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jN5IJB1E2Lr0al72GEamd2RYur9sqqi/hVsmg8n8rw=;
        b=JzRJqlZky1aFVjahOtZuFAx2G+c8slnsB3MazAKpxi+uPTloZq4WrBRrCNPbDPJkTr
         /hGd2WmcnQcgpQ4biA3I7TCIJbsMeVDXnoezgt2fc+F/qZ5G7omc6kaiJ/wnyNeJDX2Q
         awAzXWGaXtpr+O3YZluIVcTAG6lFTeZnqyCLWpQtDVu9Y9ikFxfq0l2G2ADX8t1/cHlT
         7CynbLDy9oV+iWjYk76n6CRgnDDjCZNb/meSxaeQumpvQhP8VdyBW2xqF/Fligw2Bjr1
         z/cGnv3VIMO1JSddQLvOuMUGZjaQ1nQO09k4pt3hz5YUZ+Ypg4MfkMQjqXDmcBZ530c1
         feoA==
X-Gm-Message-State: AOJu0Yym5QoVtT+Z1PC75S2KTaO+GZCoXWiejBocPLHb03L0mxeG6Le1
	FEudWDahQPuR9B+WfNmWcY4JX7ciD1BB0znDBCAj13MPXTbW0Tz5mb3c2Nank99Oh6YQs7pzzv0
	J
X-Google-Smtp-Source: AGHT+IGuPc5eZvJWKPTOyXTikGuhJmkR+fXTXGygxbFH1nWXgpOcVKkQSkjknXHFwPK0qUQPDVGQDA==
X-Received: by 2002:a17:90a:4bc6:b0:2d3:ca3f:7f2a with SMTP id 98e67ed59e1d1-2e1e62674damr9537001a91.22.1728226377448;
        Sun, 06 Oct 2024 07:52:57 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e8664bfasm5213680a91.44.2024.10.06.07.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 07:52:56 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: jack@suse.cz,
	hch@infradead.org,
	willy@infradead.org,
	akpm@linux-foundation.org,
	chandan.babu@oracle.com
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH v2 0/3] Cleanup some writeback codes
Date: Sun,  6 Oct 2024 23:28:46 +0800
Message-Id: <20241006152849.247152-1-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

v2:
PATCH #1: Rename BANDWIDTH_INTERVAL to BW_DIRTYLIMIT_INTERVAL and update
some comments.

PATCH #2: Pick up Jan's Reviewed-by tag.

PATCH #3: xfs_max_map_length() was written following the logic of
writeback_chunk_size().


Tang Yizhou (3):
  mm/page-writeback.c: Rename BANDWIDTH_INTERVAL to
    BW_DIRTYLIMIT_INTERVAL
  mm/page-writeback.c: Fix comment of wb_domain_writeout_add()
  xfs: Let the max iomap length be consistent with the writeback code

 fs/fs-writeback.c         |  5 ----
 fs/xfs/xfs_iomap.c        | 52 ++++++++++++++++++++++++---------------
 include/linux/writeback.h |  5 ++++
 mm/page-writeback.c       | 18 +++++++-------
 4 files changed, 46 insertions(+), 34 deletions(-)

-- 
2.25.1


