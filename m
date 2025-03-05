Return-Path: <linux-kernel+bounces-547112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3535BA50327
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AA0E189716F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EDA2500C0;
	Wed,  5 Mar 2025 15:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jf8Hzd7N"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CC224EF78
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186925; cv=none; b=qF1MFqFy4XA4ME5YwfvuyHROdlNNFnTT/rhiwu0Rr20PJnnuQnEAiPF1609PHJ4BtzRqRwo3v9/a9XmOGFaje2UOca6+5PqYEQRlFdJrC+uL0tWtLupF+YybzAS4lyCUOj0sVFsbchB/6xi/4cEH0nonEJIWeGGXLSdFdXKsbG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186925; c=relaxed/simple;
	bh=AZOTwFYWbPNw3YuwetCS180YuQ8bs6mW3Lff9LCM/Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hHOmitMsE71BrPVhQPF5TrjDHZQqtfUV2g2pjEQWY1xNr5fOWq7K8ZGxgKCm+Z426tqPpvGRdm/y+Y5u+yB/T9p7E3S/nuLwbbQ9yXFmpueZ7HKZURdKElmVZe64TuKlh72nXEo0EmzajcQGJtoTFR+eqFZ2jjZG5n1f64Jap54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jf8Hzd7N; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-390f5f48eafso2509053f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 07:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741186922; x=1741791722; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=quIzHQCFH7E36KayRdIr1tq1n0GnpOtfG9r6i1uUzGM=;
        b=jf8Hzd7N1UQieBqwMtFyPFlowLytWYKCN2izwlkXdGE/fFZxuPXH9ITKUWQY45qqPe
         z/9QT+gf1DhrV9ICaotrstqCK6hsMLtJp9CkUySUv/SSPysceC7cMdNJ+TOiVZ8wpgh/
         nnShK1NpTg1xrcC/LOlvUjFCWVbahnAjLuAunx6b0/WAHQSuLEItm47REGKmSjnA7Do+
         LKBoYRqQqOkrKpeDxi6V7O6Ogq0oScNR3vf7Nmed2JidNd2eQZw0Rj/WX1Wh/N9/8DJv
         /9QPytj0KcIFgGRqps8NcHd2fMxeZk8I9kT1GppGXhOP93wOlmhCkWjslcYhk3ROPylr
         5rmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741186922; x=1741791722;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=quIzHQCFH7E36KayRdIr1tq1n0GnpOtfG9r6i1uUzGM=;
        b=k7SyJcBdSf6G/yP27obpc9ZdPUUXsbnPND49vcVLEBP+bXSNLgOjQjd/Ostb1XYldO
         +bd2S4386NFUmRs37Uwjkhk1wB11LbsI8+9vD9yCbnoruRYL/+qh7bz5xcq5/sUxgoC1
         BY21sxyqqPCYGSxxVFoOQg+EfapSEiLbstmoVWfttuGHFFT5HScpHzH8WtgrFzemBxJp
         bgJV5sJAI8Vg1eQ45hi+k3oxo53ZrFcc/mYGBM2QL7bKbOtd44I1a5qcFcr6TA7N5yzH
         PyJR3G/Pb1zZvPaFowzqEBBSEjqEC7N3OU7DaEpfKnraWcABzr7o9pgR/XiijFce/wE+
         2u7A==
X-Forwarded-Encrypted: i=1; AJvYcCVg6UCqpBgRSIzJHP0fZnKMAUKafGuyJStzQVtfMLqYq1XVnxkFK6GM0WSAszTh0ugfyAVz9L4yu+s+4w8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7FAAsPBqfwGmxjy+MKFa3IBWN8j9/lSw15RHD5y2OpY0upc45
	hUPKxtwa7nbu77jwiUM/cUEk6V5R0SDSUZNqpoPaW65S7lQMJUmhTu6c+8QoubQ=
X-Gm-Gg: ASbGncsLG5I9cN3az0KstlkywKNQJY5Xfi9+Z6JqnezcP9G2eB+wRSbSUFFXSAY5pC3
	WyvQpPssDuyeUhs8noE5fIbDsWPWz/auv7ZsbjUPCe2L9ykeaAYccrHBfQV9xywye47nNvi396h
	l2q3zfzjqLhjObFiLktuaDaidpZU2iEQWMFA48nhwoOEq0Dfd+L7gzGf8R63RwHimfnikfE4o8Q
	554376xQ6wsnSRW1nm+NxKbruHHDZSzZZjIYgHMremDT5PPcUBV07CXmKelbEUHy6Fxojvyn303
	NImpH8yTxn4UaPcKtBCaIy+SJEmhhYAYnGQbT4PRaLLcpkyIEw==
X-Google-Smtp-Source: AGHT+IFepSDmvEhbE2UKLwqNcX3nTfRjGIucY9eQ6hTOqgtRykqc80R9HD8DtvfhRl/fMPeU5nq5wA==
X-Received: by 2002:a05:6000:1fa6:b0:390:f6aa:4e80 with SMTP id ffacd0b85a97d-3911f7d238dmr2965078f8f.53.1741186921645;
        Wed, 05 Mar 2025 07:02:01 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bd4352e29sm19571995e9.32.2025.03.05.07.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 07:02:01 -0800 (PST)
Date: Wed, 5 Mar 2025 18:01:57 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] btrfs: return a literal instead of a variable
Message-ID: <2b27721b-7ef9-482d-91bb-55a9fed2c0f7@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This is just a small clean up, it doesn't change how the code works.
Originally this code had a goto so we needed to set "ret = 0;" but now
it returns directly and so we can simplify it a bit by doing a
"return 0;" and removing the assignment.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/btrfs/dev-replace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 1a82e88ec5c1..53d7d85cb4be 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -103,7 +103,6 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
 			"found replace target device without a valid replace item");
 			return -EUCLEAN;
 		}
-		ret = 0;
 		dev_replace->replace_state =
 			BTRFS_IOCTL_DEV_REPLACE_STATE_NEVER_STARTED;
 		dev_replace->cont_reading_from_srcdev_mode =
@@ -120,7 +119,7 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
 		dev_replace->tgtdev = NULL;
 		dev_replace->is_valid = 0;
 		dev_replace->item_needs_writeback = 0;
-		return ret;
+		return 0;
 	}
 	slot = path->slots[0];
 	eb = path->nodes[0];
-- 
2.47.2


