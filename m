Return-Path: <linux-kernel+bounces-385283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B5A9B3507
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1E602829FF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084981DE4D8;
	Mon, 28 Oct 2024 15:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ydy77of1"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FF81DE2C1
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730129799; cv=none; b=o1cZufc5vMZJePNdL8cdZZYzDNSfWD6NowrbjFsdEZYpoNBKJbBXNnsleudXwQbI8jGhb8tkAB4tA8FjKxH2g6oWnl9H1+E4Ga/LHdyGsQnBnGk4i0K/30tYlRwRDiO/wos8FOgNU2K1XKd4rBOIhd42RBdUmIklv2q4jZQRKoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730129799; c=relaxed/simple;
	bh=D8qVhLY7cp5ZrIFs787hS9zu2zE924eQQ00QtofptCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GNCOl7r+RDOQPy1/UJ3luBaOT+xwxomWTidFkzaItYuZsY3NBbhdg9AXdysryx6zmkBSuVLFRX7OWOEejFtu1fOFwS+B2sjWaC6YWncl428lYWNLctKstosgb7Qwnp4KjEjRS+b7PKMUdA4iM6KEHetd0+0jhNokhgwdFq/MKs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ydy77of1; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20cbcd71012so46700515ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 08:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730129797; x=1730734597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VekKtOcIL2XlAiZyaRpPMpDMSW/07N1v4rzhUHMgj/M=;
        b=Ydy77of1RvgWx0TfYnC/BC2hnOv71Tcxc4eJUmQwimYL6iqYl9Zg4bznKaI/MweqeS
         wAwwtMDh2EY/vsZfQZ1Zk7SGMW3/SvzKFe7zy68Z87RrGlADCt+YSIXPEBu4KfprWY9F
         XmDXE036gIKMZqYG1UKS1OL7x1D6qGgH5BEeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730129797; x=1730734597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VekKtOcIL2XlAiZyaRpPMpDMSW/07N1v4rzhUHMgj/M=;
        b=hbu1ZfZjXmuo0pIaPI7OMYJ9b4Hn+QHUAIcVVOOsD3lIQlKIg2Qx5pR50zuFR9Go7g
         jkI1ugA7/zug2pWn4plS49YLVSj/8IdPEFFuGR74GxvEQxUfKisQBCf+FMoyMfawtyIF
         CzOcAAuQtdv6fmlLpXZihXgauEre2qulOp8iy/RwNHLmaqecJP4wae1nX0xt8r/qSkJx
         mprma4Dh3iCtuDE0NfRfgYgaoe3X1dVdl+fgtE+3d2aIJUEjpQ1fsrNLNWg0DDXwtQGP
         eORXoTZnvceKLNnbDkN9wFM2nCXp0MOKTpNazFDtez+Qwma/ECfDCeEbb/P/AX+Aijop
         aYEw==
X-Forwarded-Encrypted: i=1; AJvYcCX45ewx/y3GKBnAhV/Pj9UYhJyHziJdLc6TyCnqQFebNFMf6FpYPkmZQnAHA14UemEsSBVKIG4dUlMr0ak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0QgWz2k2WI8i10AQ7AHKLxBHS8yUuqYLhk15DIiIZir3MTm8M
	nze2kvulZjMdGnGURKBcbz9Lz+MpbfEQb3UR6iCzeMwIjkmON3suOseBRdNhcw==
X-Google-Smtp-Source: AGHT+IEoIA3Hzn8CW7zUq26D/IwpzgMrKpXv7lx8YAfS3tHdZM4tQamdP55uxpfeZjalR4wKk14uRg==
X-Received: by 2002:a17:903:2283:b0:20c:8331:cb6e with SMTP id d9443c01a7336-210c68c951cmr134720385ad.19.1730129796825;
        Mon, 28 Oct 2024 08:36:36 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:f1f8:97e1:9c5b:d66f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf4a230sm52148315ad.31.2024.10.28.08.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 08:36:36 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 1/2] zram: clear IDLE flag after recompression
Date: Tue, 29 Oct 2024 00:36:14 +0900
Message-ID: <20241028153629.1479791-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
In-Reply-To: <20241028153629.1479791-1-senozhatsky@chromium.org>
References: <20241028153629.1479791-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recompression should clear ZRAM_IDLE flag on the entries
it has accessed, because otherwise some entries, specifically
those for which recompression has failed, become immediate
candidate entries for another post-processing (e.g. writeback).

Consider the following case:
- recompression marks entries IDLE every 4 hours and attempts
  to recompress them
- some entries are incompressible, so we keep them intact and
  hence preserve IDLE flag
- writeback marks entries IDLE every 8 hours and writebacks
  IDLE entries, however we have IDLE entries left from
  recompression, so writeback prematurely writebacks those
  entries.

The bug was reported by Shin Kawamura.

Fixes: 84b33bf78889 ("zram: introduce recompress sysfs knob")
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e6d12e81241d..a16dbffcdca3 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1864,6 +1864,13 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 	if (ret)
 		return ret;
 
+	/*
+	 * We touched this entry so mark it as non-IDLE. This makes sure that
+	 * we don't preserve IDLE flag and don't incorrectly pick this entry
+	 * for different post-processing type (e.g. writeback).
+	 */
+	zram_clear_flag(zram, index, ZRAM_IDLE);
+
 	class_index_old = zs_lookup_class_index(zram->mem_pool, comp_len_old);
 	/*
 	 * Iterate the secondary comp algorithms list (in order of priority)
-- 
2.47.0.163.g1226f6d8fa-goog


