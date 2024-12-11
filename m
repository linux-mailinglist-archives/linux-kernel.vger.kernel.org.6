Return-Path: <linux-kernel+bounces-441068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1659EC8F6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 934C5284AC5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C10236FBD;
	Wed, 11 Dec 2024 09:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w5tOqLQ8"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089F6236FAA
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 09:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908906; cv=none; b=er61aAXYoC51YBa5vyo5I1hw/JhHznNpvyvauWY12jrdBXoxYskRtoMb+E5r9lFOEvdQG6F2ZZrqGRKYG34WZ9mLHvIxO0Mop6PfTOgOJ4olzJv38Vm8rr+j8hlVugPdjqrrAc5QXiD6eDW1JJ01q2+HG3Pbxu2++ftcdWbxNdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908906; c=relaxed/simple;
	bh=8s9qU3NpcFIH9Ro8KpQpyXvRMnrSRjRKQsDDyH7NfpY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KXIn58OWzpb1UvIpmdk2/TS24tJ92X8roZGVcfNolqS9zP5kjVfDXK+/vIGQLi7b6+ZfZ0ZrnWU6OqBxwb1w1OmThcrxu33erQ0uXpx9XKybSHon6iDR2nRpRyMMt5bq6OHQeeQgiFBH48t/O2v1Oe3RHFlbNysoWn9yVdd9b78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w5tOqLQ8; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434fef8203fso16510405e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 01:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733908903; x=1734513703; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0DLsS1CyBK/Moo7ZlFFxPYN1OuvOVl2Ay8BHF7WI398=;
        b=w5tOqLQ8gwo1ial/8x5zs3Ko239KwgcdYt2Y8xrAixNNRQ8Z9a+Mfk0EDhmHGOxIU3
         B3MUmKWLB0JUIZnWuF4F1lxnZK0SbmduZYNEgbtJPgrOyvetMtCm3wJaYE63rWGUd73a
         m3+xXHnEKEd4jnRqiWxgKv9riDgJqe7XCr4y0ov8JoogtX8JTAeAGQHstWfgLbKtqk9R
         Jkrd8xHOFlEjVxWg/tdR7Ri0ZNsTKatpxG4X9qgzyafM63aPAw4LnHkQHdMNdGipqlmS
         58sxhf5SUvnKkQS9C2fgAbGfBqBmWmI8iPm5cv4S1umnPBMpbU5qNOuBKk8J3gO6J3jx
         doig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733908903; x=1734513703;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0DLsS1CyBK/Moo7ZlFFxPYN1OuvOVl2Ay8BHF7WI398=;
        b=rPp3nTLS9Sl8qOU4kzRKKdBDJxYdxYvysqpUP8XTqZa7bH/wf+ZFPfHLpPKn0y+708
         MMvUnzzfWhTDII/jp/8SkRuq0ENUpMRZydsTmZEaFGRneqt4mP1zEqTEuPdf/PXL4gZd
         dmBNhX3gIUA0l+tgcUmFYbszqlyf4sg4okqkN0r+p8LFxdQ3BFVeac2tTIBqRYZofni5
         MnhoIl6yEDko/jY2qCRT/gWBIGXZcl/1CbhVN6U9U4BcyJ7Da4/6/9IJOH5Vrg/PL8Zq
         c/vBDR427fiCzQj8BMOUDWBNSGdaxy+QMO+Op4Tdx9GlJuxIa3VNtDksTpWTxVNqw5Iu
         0MqA==
X-Forwarded-Encrypted: i=1; AJvYcCWHXBN51T3LpFGgruwJV8YLJv+/o8IYFc+MaetSa9zplf1QfCee35sVaTynH818a2dw7ra5ox17O3wtL/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg0bucpYl8XCUbYOOnFdFH1h3/DnAy8DeypDAVFFnUzJJrUdyc
	ExoHPv60k7L9s3dzlCVNwa/Fg9/fJx4+91V4SbmLg77WOoJw80vRgDlNJUHgU28=
X-Gm-Gg: ASbGncsrrOzTWmXU3wE/fCYPVtipz+nRsH9gW/5PhY1oEyA9Xx99Q6SLISphRk+AAnD
	Y/NXu0/lKzQOQed8iDN4L+2z4RofcFP8tRSUGvMos/O+kzdV2Dz/2z1Nzt6ILMV2NCfaKiJrghj
	lMg+fok7/0lUJRhhb3+So0vAMhukbRLoPcA0H2f+r4XFUOuyDFyHDeizctBnnSyJOs2c75s1ZAM
	nPwN6KczXjW3YrnLCXTo3NXK4NUuM4hI52HAUxq2/6S3OH1a5d2vFe4Qes=
X-Google-Smtp-Source: AGHT+IGPYeRitgpKtJOXyRZn4COfRNxYFbNQZ+CVZoA5uGWAMNXxGSSG6fybBnG6Xshn8ee/kKy9Ig==
X-Received: by 2002:a05:600c:1907:b0:434:a902:97cd with SMTP id 5b1f17b1804b1-4361c3b9d1bmr13850245e9.12.1733908903351;
        Wed, 11 Dec 2024 01:21:43 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4361e54ef20sm12271745e9.5.2024.12.11.01.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 01:21:42 -0800 (PST)
Date: Wed, 11 Dec 2024 12:21:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] binfmt_elf: Fix potential Oops in load_elf_binary()
Message-ID: <5952b626-ef08-4293-8a73-f1496af4e987@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This function call was changed from allow_write_access() which has a NULL
check to exe_file_allow_write_access() which doesn't.  Check for NULL
before calling it.

Fixes: 871387b27c20 ("fs: don't block write during exec on pre-content watched files")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/binfmt_elf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 8054f44d39cf..db9cb4c20125 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1354,9 +1354,10 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	kfree(interp_elf_ex);
 	kfree(interp_elf_phdata);
 out_free_file:
-	exe_file_allow_write_access(interpreter);
-	if (interpreter)
+	if (interpreter) {
+		exe_file_allow_write_access(interpreter);
 		fput(interpreter);
+	}
 out_free_ph:
 	kfree(elf_phdata);
 	goto out;
-- 
2.45.2


