Return-Path: <linux-kernel+bounces-250745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB4192FC35
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45B42B22BB0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA53B171664;
	Fri, 12 Jul 2024 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XCt1Cpaw"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FC2125D6
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 14:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720793262; cv=none; b=eAmRTDCuWjCBbF8qN/9rZdYe5qEbcOY2Lj4DIQgOtcfKuau1S0ZFdfhepkWdYCQapCHu00Ed11th03p/QkdMBBV8jXlJaO/e/IWjqzaLRKJMf3qN0nq9hi/M4QgGPazYrulZml6Pz2kT2y5Ta9Ap+7DT79HZYlK+c4GEDvXQMOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720793262; c=relaxed/simple;
	bh=SfyLdJmWIl09BqrLT3s5UZpOh+WQ4L3Y+LeTeNjzYvc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oj0bD3IS7GcUDnzzpMf63KdABVSWosTN/fhrh8SdcMCmqjvPow6S78FflhYJ/sbkPXIvcNuqxKFzpFukcK2So7myN7o2cC3hAhEJA7bbEUuVHJ3A11wrfWmHLcUxxQSB/1PzkSCm0FwzlonKE9+X/Sd06uj3w6GA17Zwx4QnFQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XCt1Cpaw; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5ccfdc3157dso286262eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 07:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720793260; x=1721398060; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/kDrIianMg+3X2yJ60OXLpyMU7e0jBqRLYg/AtDIiSk=;
        b=XCt1CpawhEs2zmeR7RI6jlzeBzM0wFj8MfIsgtasolujsMu37/pkZtssjkgqBvSbhd
         atg9w7PgzfXgqtmwQt8lA+eYUYUtEFfGrF9MCkhqU4tYNnOrqRdiK77zKJlM+HJaqNWE
         pkbKBfD7ttSLuyJsCiqxPZDz+hjV9lb68ZRuoFzDjg2Wr6FgV1bQknK6McqE/hIdZ6VW
         ZiIRRz+coMUDboxPKQEgazHInB6WtjIgJW4P42swT8n8yKqYldSHV3ZFI8Em/vo6GORK
         Rn7pfkldkdXlhroV5XIpv/26OG8fz/2rIf3ML9z8LBynXEseeOISHGESWGJs/0l9pq4j
         JwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720793260; x=1721398060;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/kDrIianMg+3X2yJ60OXLpyMU7e0jBqRLYg/AtDIiSk=;
        b=HTK/vz50/T4RS85I9gQbL9cEPe6TIfM9YX2Wu5EFHVa/FdVQKJ154Bdx1NaOyCEKqT
         bjQxNl77lUmjdt/e6JID8wj6YvOrKOnSaNIklfbac2w/C1TYV6dgdRnMkHftU+JTys7q
         sXxtOwfaprz5kDX+S5omG9CekcMmF2nR36dK3+8di+hTYMc1crWnLRlzVfEkV6akoYOL
         L+X4awngDlgTrmlvvStslgVVe7QpB7T/7fasIZ/iRlNEsvSqypXx2YSxz2YppWj8xvy2
         OrM9WWXOgpEuUl68GEv50DpfSgu50DucUAs7hClkUMh0UmMsNYBCYhQRgR33eMyS7Lvw
         DvEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBpyAG/XDZlvykECo3Mv1p4lLKHauzUsD9pni/E1m2Ia/kTtzhJ44JBYf16SPHFcIDJhR6xzmCSoZT6eWrWxieZxHKRg9rj6pP/Oih
X-Gm-Message-State: AOJu0Yy0BfZIMfveyaw0ebhrnN5OCA8H8eUeEkKf4NFlik6GoIAJo2RF
	i98RPDfOjMUFRJaEUnSY7Zyd5vWoOBR/IsJVZXufio20bdnv/IOfOABacxnUC8g=
X-Google-Smtp-Source: AGHT+IH0XTKXSXVxdXKq83umC1HPIu3utFplrKBotLtfEPjZGT5ZNt/dC043fyKGyZP2rTqqiVF5+A==
X-Received: by 2002:a05:6870:f10e:b0:260:246e:99aa with SMTP id 586e51a60fabf-26052cd32aamr1168947fac.11.1720793259963;
        Fri, 12 Jul 2024 07:07:39 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:d26:9826:56eb:a2e5])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25eaa2a148esm2242391fac.54.2024.07.12.07.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 07:07:39 -0700 (PDT)
Date: Fri, 12 Jul 2024 09:07:36 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chandan Babu R <chandan.babu@oracle.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] xfs: remove unnecessary check
Message-ID: <a6c945f8-b07c-4474-a603-ff360b8fb0f4@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

We checked that "pip" is non-NULL at the start of the if else statement
so there is no need to check again here.  Delete the check.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/xfs/libxfs/xfs_inode_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_inode_util.c b/fs/xfs/libxfs/xfs_inode_util.c
index 032333289113..cc38e1c3c3e1 100644
--- a/fs/xfs/libxfs/xfs_inode_util.c
+++ b/fs/xfs/libxfs/xfs_inode_util.c
@@ -308,7 +308,7 @@ xfs_inode_init(
 		    !vfsgid_in_group_p(i_gid_into_vfsgid(args->idmap, inode)))
 			inode->i_mode &= ~S_ISGID;
 
-		ip->i_projid = pip ? xfs_get_initial_prid(pip) : 0;
+		ip->i_projid = xfs_get_initial_prid(pip);
 	}
 
 	ip->i_disk_size = 0;
-- 
2.43.0


