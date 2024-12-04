Return-Path: <linux-kernel+bounces-430527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2ED9E3222
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 04:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22D26283397
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 03:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A20155C97;
	Wed,  4 Dec 2024 03:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HrdDNHTD"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F36C14F9F7
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 03:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733283179; cv=none; b=RgaUG4RO2XDiMN2wPSOdkYncwMTryEf0YiYP3Es4EvEmGNsDfsGfNmQdYC6q1Ow9nQ48+D8FVOR0BLBGpdbyqouCEM2WADEeC8MKlCAvlMjqyVLWnKmmIHNxFvGjOnFC8YKGS0i0LEBa+S/0KI2xrzSGI09Yy9CXDkUq9w8b1Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733283179; c=relaxed/simple;
	bh=HETMPyYFonTIlUEtDkB4W+NGpx0pChnBvtqpUMwbz5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4kwQEjUFU3JbFWhv3C0GS8f5UFewkEVNaYZRnRzH6yzxAz4yncPnNILhfPKlWUARHRa+zeaUsEzo8+XTDF9ENCV0W8ilDBBoN67K5A9nwTaNXBGuUVdsWgpdc5eHQUz729emN+c7cAQtlIydLRZRIbqxWkM0Ib9Qi2umIRFo9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HrdDNHTD; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4348f65e373so7381845e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 19:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733283175; x=1733887975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyQZbBp455IiiS0cimMqLKVcykFWRydlh8NnN31mrV4=;
        b=HrdDNHTD9DwHwb7xvHvSwiMY3SSdcxaT0xZewai1RP+/nETanu6wWDUD8Y3WAvw+5z
         +F6TGbIdPfQP+wR0rFLdn8DjHkhBbl2W6bZge9gfLp2h9oPOiuigEsD2YDgEOZg3s4H7
         5ucvKFvoXV4dsC/I4lqzUU40avdJrgfeXvGNDof2SfY3QeMZhVVY7tBTo43huu53cKZq
         RTL34c49Z8guY++MOwSHcXbTtXI0kATRCLvwNIpXMSmDyBidM/ae2OXgAesJWeZQWYMn
         SU9TG0xfbyvC7R6wThyC7JRWVFLXpkaUH2Z9kNnrNcXAj4feWFc+V3xutDR5SwACYzuB
         53ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733283175; x=1733887975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IyQZbBp455IiiS0cimMqLKVcykFWRydlh8NnN31mrV4=;
        b=iTG3OonR6Ro3oHbe6N1vGuPOBt26C7NqLE+gnApwp5MfSyPoiy5z3slVx3bD7KctvX
         W9Lpc/+vqD8+g8YeaBN152Cq4gg8fS0NGltzzpTDwJTueF87Alz8o9G3IaSZ13JGgXnX
         AGLX9mSkoIPVUznJUYcbKeWEVSa7O4F6SgpiLbuCYs1f3rTiuWb6hP5TDttDmBZnC5GN
         Bp0Mlan91+5nk/ttzGdJoV3XVTB0E1X+qpFDhtGOgbRkw0vtjAwl0ouClpY1kI2ADZF1
         9BcLQEnNNcKtHQezPliLPGW/Cs5DXQScqeXCLdJkfxt+6/QCRuJm9MWb2gfFPxtE7Dd4
         3AKA==
X-Forwarded-Encrypted: i=1; AJvYcCXKY5FjgU2HF7WAbC6Rt15Z3Yd7mzblZn57+TmksSs9oZWIiwc1m0eBuM981iqMv179+1OLMuztRmXxBuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHEp3JVXgzw3VmKWpcQDtZzqsGqupDRxStxskKwJWWXXvTs72Z
	fvGLEmwb+M+tB/TpKAX5lpY/1+M5lrCifFtWolW9eKOkdkw4MLDBCQUBDDBB/mp0eC9PHTP4Rvm
	lRl24HA==
X-Gm-Gg: ASbGncvNBDn6ycb4uON9vVm0pFXDNZhExU9Cz+gFQL5YVxEAQb4y3oWALnhmQVr7dzu
	guTLf+Qdj+7hY7LWZWIFW/m+qm224wpc4MIhZm8TSPmHsUO24wS4fwIpYx5BHOiMs2THpxrIBvt
	n42VZFdsSuUOGLZv/QUzZgR5JL4tonWDgSSGtDeSfv6mumTehdFLVJMpROL7sgJFLDCTeQzWnkG
	BrLSVPWDtvbXWW8CaxxqDLL9MgxuEUTYqpk9/bOqqb28hgZjXj/4FgO6gkubQ==
X-Google-Smtp-Source: AGHT+IE/jHB53rXLi5u7lvRJEF+CPq4Zu3rqIEuQoyRi8fGpj8biZzILxPOqXkFg+fFvWqVlPTnhJQ==
X-Received: by 2002:a5d:6dae:0:b0:385:e10a:4d98 with SMTP id ffacd0b85a97d-385fd3cfcb3mr1524139f8f.8.1733283175560;
        Tue, 03 Dec 2024 19:32:55 -0800 (PST)
Received: from localhost.localdomain ([114.254.72.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215a04dc249sm37476025ad.203.2024.12.03.19.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 19:32:54 -0800 (PST)
From: Heming Zhao <heming.zhao@suse.com>
To: joseph.qi@linux.alibaba.com,
	ocfs2-devel@lists.linux.dev
Cc: Heming Zhao <heming.zhao@suse.com>,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	gregkh@linuxfoundation.org,
	Heming Zhao <heing.zhao@suse.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] ocfs2: Revert "ocfs2: fix the la space leak when unmounting an ocfs2 volume"
Date: Wed,  4 Dec 2024 11:32:39 +0800
Message-ID: <20241204033243.8273-2-heming.zhao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204033243.8273-1-heming.zhao@suse.com>
References: <20241204033243.8273-1-heming.zhao@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit dfe6c5692fb5 ("ocfs2: fix the la space leak when
unmounting an ocfs2 volume").

In commit dfe6c5692fb5, the commit log stating "This bug has existed
since the initial OCFS2 code." is incorrect. The correct introduction
commit is 30dd3478c3cd ("ocfs2: correctly use ocfs2_find_next_zero_bit()").

Fixes: dfe6c5692fb5 ("ocfs2: fix the la space leak when unmounting an ocfs2 volume")
Signed-off-by: Heming Zhao <heing.zhao@suse.com>
Cc: <stable@vger.kernel.org>
---
 fs/ocfs2/localalloc.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/fs/ocfs2/localalloc.c b/fs/ocfs2/localalloc.c
index 8ac42ea81a17..5df34561c551 100644
--- a/fs/ocfs2/localalloc.c
+++ b/fs/ocfs2/localalloc.c
@@ -1002,25 +1002,6 @@ static int ocfs2_sync_local_to_main(struct ocfs2_super *osb,
 		start = bit_off + 1;
 	}
 
-	/* clear the contiguous bits until the end boundary */
-	if (count) {
-		blkno = la_start_blk +
-			ocfs2_clusters_to_blocks(osb->sb,
-					start - count);
-
-		trace_ocfs2_sync_local_to_main_free(
-				count, start - count,
-				(unsigned long long)la_start_blk,
-				(unsigned long long)blkno);
-
-		status = ocfs2_release_clusters(handle,
-				main_bm_inode,
-				main_bm_bh, blkno,
-				count);
-		if (status < 0)
-			mlog_errno(status);
-	}
-
 bail:
 	if (status)
 		mlog_errno(status);
-- 
2.43.0


