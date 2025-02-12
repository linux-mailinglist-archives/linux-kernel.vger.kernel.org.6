Return-Path: <linux-kernel+bounces-511361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83452A32A03
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5365518870F8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE2B212B21;
	Wed, 12 Feb 2025 15:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="laZvZrLv"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC57211700
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 15:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739374074; cv=none; b=uhWmoqqkiT/Gad0Yseqv6nnHCUv5rGgMpCxCfULYnXtYbD+jH3OBEXUqdyJwtD4BMY4p2fwSP3GFcAUsAE8fcXOa3MwKNs0jFfH/zm6Sw+JeaieMXh1epRtaNCuiZ2YW1NGLn0KZhb/5CeGM4n7HJxWDB6J+/AQFQSSibGtpytQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739374074; c=relaxed/simple;
	bh=nGOHHKMn8GtXJDicwnkL8tmz9VcKp2LxDT7FzaficDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GO/gI5SdOXLdQt09kwMHwa06n1F0QlqjG1gecxaLLn+wzcWC4jbmkfPlwRhIqjJWTEtC2wR6DV/LnxLJLSOwOTCGmG1pp8Bh6Gqf+eQzXFSAdhrS5owuEAV9amx5fm72v8dyNTzvmztDga4NVvjm5RYm67Rnd8bwn0Mq0stx5oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=laZvZrLv; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab7d3bcf1ceso487304066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 07:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739374070; x=1739978870; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gIK/hsLjBmZb4Q7phf+8q1FhCeVWqfbKwX81hLs6leU=;
        b=laZvZrLvajbe2NVmhCSHQkDLWb84Kp2eSfV0E9fjiZ0hDzBWt7T15XZM3Anp8FpC/8
         75KKTUx5rQ3P2ObiIGcxyImsSbpRd4t3LlCiZQ6QAMMppDnnupbyWUWqPIlM4gAvNxOo
         diABh2kPy4TFr9xlDiW+2LzDex9uU5LlDOCqpJMgQTrdLcaQfPm6UVkfXgessfNkr6no
         mUtquWoWyCCjxbWCxWy09TOjRzvRDughZg6V7GVyC7oHFTutcWYAIpd+bxu63mXmIxO3
         Axi6Cplv2dqrfgjLH9WWGIuSNTi4ujywvZhQSOoZ/rAtOUVMToDtZqP9Hs302RaWrNXw
         ZvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739374070; x=1739978870;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gIK/hsLjBmZb4Q7phf+8q1FhCeVWqfbKwX81hLs6leU=;
        b=gTdh/rVa8C45Pqcf324vvDfVWc66ClgsGRWzzsCszw5w/gQDqJU5XdAN3Bq/SaecZd
         raHYUMWZjTLH2vpJ5HaarAT4LDzfPLSYTpThDW2jTOHxvZnSB83F8+udiS8OW7pPX8/N
         woKZeWDDeZ4wSPlvIXj02MPCidWUyW1LwPAcgi+xIGunFAHmQ8Ghjs2QUdb0waBHmJ/F
         y7pYKdPpvYIhJ62YnLKX3cnnP+v1FL33Qk6aJeoAW9FHslwJUest2BsF77Gk4LuIBPcd
         ynIOdT7fez3kzQ7qli/8MPrrQF8ltQvhLXWbVFD+lj11PZMbo0BaO+qdOvyopjVbEcYk
         BRyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcbt9u2unz4QYWFGyW7KJlqynGfs+Tcjhl3hKtU9SKUWe2SnZxzo2jvBfGpWfV1s1JEiPXkqaucEx0s4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3HvhVeLkNiy2oxJn6JGXbmWr/wBwlqFngq6H/VKimkhcT28YO
	zo+9EL69v6amTkiveCjGBkRak+BzlmH98BaqapFXXarx++tEKaBWPU3ZTc5l1S1bP8khki/6DWr
	X
X-Gm-Gg: ASbGncvox8zuAoGP+BefeEIdVU8w3PXs70AmQrR2zM2EqPXOMoOJV8s2T1y+Bv1PvZp
	pLPG5zdJrFDV6yGEAb2fDIMaIhip/AaKKRJNBOInPLuO9VHRKe+0V1lm4M7JmJrhlFT3jEbYJ/m
	tJGbzpfCUXqV1gO6+B068g7jNGyH7OXlALwiI0b+DY+8UppK/gX5/M0qYhC4f56fqI9aid/JpOv
	UXlidfSPVx3qqLrVvJde5tph2dJjZrxKxvHbEn/N5utx4L+VV7GHqarOF0DKSQfq7K7ma2xKyOz
	C/at4CsU1HlncVXG8czi
X-Google-Smtp-Source: AGHT+IFpL8Nw1g0cPCijD/OhpU2DBTaHM0/BqrJs7pa0K+2D+M9iqhuvdq5hwJqMDWlN3ZppYMHMIA==
X-Received: by 2002:a17:906:dc91:b0:ab7:eeae:b23b with SMTP id a640c23a62f3a-ab7f354ed67mr381322466b.0.1739374070037;
        Wed, 12 Feb 2025 07:27:50 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ab79d9ced43sm967079866b.78.2025.02.12.07.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 07:27:49 -0800 (PST)
Date: Wed, 12 Feb 2025 18:27:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] fs/dax: Remove unnecessary check in dax_break_layout_final()
Message-ID: <ddd61469-637c-4a1f-a024-141574fd76a8@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "page" pointer is always NULL at this point.  Adding a check is
a bit confusing.  Delete it.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/dax.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 9e4940a0b286..21a743996f90 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -987,8 +987,7 @@ void dax_break_layout_final(struct inode *inode)
 		wait_page_idle_uninterruptible(page, inode);
 	} while (true);
 
-	if (!page)
-		dax_delete_mapping_range(inode->i_mapping, 0, LLONG_MAX);
+	dax_delete_mapping_range(inode->i_mapping, 0, LLONG_MAX);
 }
 EXPORT_SYMBOL_GPL(dax_break_layout_final);
 
-- 
2.47.2


