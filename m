Return-Path: <linux-kernel+bounces-303095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8650796074F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 305B01F238E2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5614419E7D3;
	Tue, 27 Aug 2024 10:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DhN5J9Ym"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D235F19D08C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 10:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724754077; cv=none; b=i5AgiE6WVcfRl1NQMK1ac3A6GwXoaEji3K4t+UZyL0n3cUAlEg5MzRIr+78B19K2oV7wFacTKuUXFPHbVrJEyXhN1sbKHkmdYADUffzVc40vQkC2dRlLO2UdUCzPnkiJj2m5rj3PFssD4BByzrKNCBUyD5MNEbcJId5yXvT8utQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724754077; c=relaxed/simple;
	bh=WpkEbJXN36l/+w1BQOU69FzZ4FVKiYj7MJY7doQoJGc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MTcLJ+LHNqOsQS4unHBQ+jwTHzag5eQhm1ko28iIdQwn+vk+CZZ/SFUTow9N9FZVlRNY+Gqpuxng/AJ9m7uv1Pg+U3FWH+fl6wpR/JmejxhpmWx1Cg8m4HQot8Wy07l1VCkd82bP6tZZq7EK6+oLMzCC+tBdddNhipOwFDOvmHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DhN5J9Ym; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5bed83488b3so6174792a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 03:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724754074; x=1725358874; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u5veQCoN8lYQBQJD74SRhygXarb8IsubhyDY9LmHaE8=;
        b=DhN5J9YmRY5Q9YoG4kQjrRIcsppKQME509CjTpkFh4nl2nac3hFv+RN1vKCz7Cmr+W
         wIPCTQWwPJqUJO5Zn+pSm4wCIdBP2s/AquB+5zOjD4aXI2e1qzfcNoKZ+3q5WU5R5O2h
         byxLi/gukyVTLoU4KTQPVg8G3RXslWgtvHdROsSWNc/EOKHLm4deRyqDAWdKP+8W1sTA
         36G18PW24493hYtUOubFHWief1aVmwZGYNsaf4r2rtSDPiX0SM+GwMaTGO7BKsi8If/8
         kKn0fXJNojyDyN6UBntldKtGLkzfzod/bqryYehgTywcIEG/KHgDDUwzZqvTlpL2hNts
         1v4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724754074; x=1725358874;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u5veQCoN8lYQBQJD74SRhygXarb8IsubhyDY9LmHaE8=;
        b=Km42B0J3qXudl7vsUbQt9SRD9yontKmg21mzHChYm081t+86aTlVKDIr+BFyYVJEze
         zhQoztbnUX5esEX9OorLeP44Xe3dnoMB98YpibYxDCWqQ9xVZiGXMo96W8VG+/yRj433
         bYVrz00kk1BAIeaoOXJx+IoLtDZ/c6E65qzWEB4xWA1I2nbMaGSdBcjtElkODOE3W1hx
         xyFY35ZKXW29inNc46WTzJ4qM/6g3SwyiT++U3UaC/vvMdKXwsuuwYqG07J9/MR+aNPx
         74H4UlMXLCKi71G+IY/X/i8kjhzzFIOoZS9CqnNDytbBRllo1lUZE8trpMc7vZO+jYub
         A/rg==
X-Forwarded-Encrypted: i=1; AJvYcCUFGPoOuG42g0WbwR/lZlSxp5b4z2cxgUt57ggv86qfFQGMa4bMR0uWYbK/aABvENB1kOJAgZmdSmywnj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCAbyltpn83pDvvfqBuXR4QFP/Dz/eypukRfjFFZFQhTlWjL6T
	L4C5F8Ly7o0uLhPfXFbDi0A9tdKJ+cEUu3lKhPxk/hGdoHLcA3RVEOdd8AB28gEwHnwJMObUA21
	C
X-Google-Smtp-Source: AGHT+IE3u9uTSQrOf4wWogLmsvncGtloKgibZM4lvdiulZe+XAmFxDCcQwrH57K4f9IJ0qqGDj8VOQ==
X-Received: by 2002:a05:6402:1ecc:b0:5bf:38:f676 with SMTP id 4fb4d7f45d1cf-5c08915aac7mr9644088a12.1.1724754074115;
        Tue, 27 Aug 2024 03:21:14 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb4715b0sm832135a12.62.2024.08.27.03.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 03:21:13 -0700 (PDT)
Date: Tue, 27 Aug 2024 13:21:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Li Zetao <lizetao1@huawei.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] btrfs: Fix reversed condition in copy_inline_to_page()
Message-ID: <3a05145b-6c24-4101-948e-1a457b92ea3e@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This if statement is reversed leading to locking issues.

Fixes: 8e603cfe05f0 ("btrfs: convert copy_inline_to_page() to use folio")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
This patch is obviously correct but it's from static analysis so additional
testing would be good as well.

 fs/btrfs/reflink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 1681d63f03dd..f0824c948cb7 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -146,7 +146,7 @@ static int copy_inline_to_page(struct btrfs_inode *inode,
 	btrfs_folio_clear_checked(fs_info, folio, file_offset, block_size);
 	btrfs_folio_set_dirty(fs_info, folio, file_offset, block_size);
 out_unlock:
-	if (IS_ERR(folio)) {
+	if (!IS_ERR(folio)) {
 		folio_unlock(folio);
 		folio_put(folio);
 	}
-- 
2.43.0


