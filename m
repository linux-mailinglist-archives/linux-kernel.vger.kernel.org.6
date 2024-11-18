Return-Path: <linux-kernel+bounces-412742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FC09D0EC0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 880C0B2582D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC197194A64;
	Mon, 18 Nov 2024 10:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z76QeQVH"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01B4194A54
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731925870; cv=none; b=u2hk+Kl7BTISXC6bHR0G0DK0hy8wUOAq9gQiG0ETeU41xMq/DBcGs5PkGs6zQ21gAvDIFmrzCh2z+rrRQOI6nq6voSF4xkXKWTW/zRbThaLZYbsBOAyBUsy+lgBcv4fO9KAxRQD+hobjIhZa/XStjvhwzh8IwLRRUP4Cnrx9KJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731925870; c=relaxed/simple;
	bh=Iv+4BLJ1ZpMsSNIr1yjl5CpmahtKfvS6PpzJl9HXyyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M68yK+OjCkMtp/zv0kz+PeZ0fmTTmTfTnme/ht6TBRMxhGoPcsocOgtVhmKz23HRST0AqGKgYzCEJg0dnhCdL1LqCKpzFMBr7jpI1YC/K0BpqCJqo9VGOWhCNxFkCocWC8VDtzIFrffTSex9VP0cP0B01ewJBJY9NyUFRGbuBP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Z76QeQVH; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7240fa50694so2344087b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 02:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731925868; x=1732530668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmtF7lyA0iLc/Yt6HZB9ijwUzmrAEUIH4YeSOeYoLmo=;
        b=Z76QeQVHlECt/XVLMxty9PEfeW8BmHuin7++b+zXsZoIRnDLVzXA77ElZ6wJ0ihNXg
         keDbO8T5CEpGgHVVlc5UJWJ07EHQphAoRb0VQQZjCtCdf5dJQheZyN4KPXt45PFyc8JS
         IG/jaXc2XDI8/FCTg5g3MVBnAVHkL2rPZ79YA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731925868; x=1732530668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmtF7lyA0iLc/Yt6HZB9ijwUzmrAEUIH4YeSOeYoLmo=;
        b=BEhGQTApx/t17kntg0P9wuz9eyxJPBtSiNEwr23WNGTkvTHxW1bJ6lmr/gFAX772DL
         15I/dx5FxCY9gzryp5oKMrJwy2VPwme9IkJfc7N3wbqJhrUTsEikpEeZvWfLCj9MOB3x
         rywbpvaH2++2FlR+YTTB3ypVxrinXqsr5IQaIT+nfAvHE08i4977dA0zyhW+cybKB6cD
         lRj5E6sVxHXPvS7YZw42GAK7qa4KN13rUuJR+lPD0roEHRvoBZnruATXAJc2JHJav9+z
         bNlZ+wHc0TBZxNHwnWvhhZXoOTfDcKdGj3cLtyS5Y0YH6iCbtku5boXhf1OdemWfP+dv
         d2aQ==
X-Gm-Message-State: AOJu0YyCgZiqk/fFPMLf8Y3Kd8m8dU5b3KpPEeWA/q9xjaWp+DSJgnoC
	Q8eamwSQBbpP52d1yXLHYdB5vrpcrQmXaJAOBEa5uKcnwUjHj9ywSfUMFd/mbq+xX8xwzw9FG6w
	=
X-Google-Smtp-Source: AGHT+IGAGA2exT/xw+8VVpdGTtxlUnBRppXPyEFCjjAjHw4kKWYrB2li3/2hnqjgbK6eOUVKVyb6fQ==
X-Received: by 2002:a17:90b:250d:b0:2ea:2a8d:dd24 with SMTP id 98e67ed59e1d1-2ea2a8decb2mr11299390a91.24.1731925868295;
        Mon, 18 Nov 2024 02:31:08 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:8826:78b8:a8fe:1066])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2ea7752f0a0sm1554913a91.50.2024.11.18.02.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 02:31:07 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC PATCH 1/8] zram: cond_resched() in writeback loop
Date: Mon, 18 Nov 2024 19:30:32 +0900
Message-ID: <20241118103054.3191944-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241118103054.3191944-1-senozhatsky@chromium.org>
References: <20241118103054.3191944-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Writeback loop can run for quite a while (depending on
wb device performance, compression algorithm and the
number of entries we writeback), so we need to do
cond_resched() there, similarly to what we do in
recompress loop.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 3dee026988dc..882a32d46a75 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -883,6 +883,8 @@ static ssize_t writeback_store(struct device *dev,
 next:
 		zram_slot_unlock(zram, index);
 		release_pp_slot(zram, pps);
+
+		cond_resched();
 	}
 
 	if (blk_idx)
-- 
2.47.0.338.g60cca15819-goog


