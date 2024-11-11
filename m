Return-Path: <linux-kernel+bounces-404397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8659C434C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8984FB23489
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4771A08C2;
	Mon, 11 Nov 2024 17:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcvI2Ze/"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012CB2AF1C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 17:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731345023; cv=none; b=ckUKLuKlfIdHLvr3pfEF37YZwvCJDBoSeRyfNagD3+f5i3/a+idpCjtf9Yc1CgkXCOLdAjz4DfYdf4b+O3tbckfYGQFmVRZ0exTnLC/TZnFXPSn2/IttFoIjEpe3D7/GbfWAakin+FHKblrqtkI8hOUbGZHn6N2sFvak0CtJ0Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731345023; c=relaxed/simple;
	bh=f6HKmU0BnhqArbMEdHgt52C/V4l6/0SHG91cR5UNajo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=T0GVU0m4aFCvYg3RnKlbC7WhJPoxZUJt3lkrjD+i9fbN0v7gUHGIteYvmEY9jaLfDeXINtLsu3MXZbEcIpAASVWaT794qgYbXyyBoZjeVi5MOY/UiwITDtkdZGQ9wSX+pNr5k3cwzsGjzYgyuv+KJi2vISypszNHdpQUeecu5ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GcvI2Ze/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c6f492d2dso52012125ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731345021; x=1731949821; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7TmUgvo3rAWWE5RdXfwA5YP+7FX339w5GtAM0VCDDD0=;
        b=GcvI2Ze/XmPmKgNe2RTspQeHdVjYtJU9C6p8cylN5sqQfMsiDpBkqyPJgIxK/0T5Rp
         CXmF4Cr5YE0GPNi4IG8s3OdDoIBYgmm1d3AhYum6LUlYB7MP3L2XUed6c9XdCAgjKBLS
         8Ve13cvsFNQdx5pljVTpjH0eO84H6EdTVWel8m+c05DuFLW1ykmVAhIEfH/xONI/QxGU
         gwJBw57xOAaL6L2OyBJwvEMoOm4weXi+H5UsaWnAkp0wUbIVpd1EGcuoSTRii2vwZNtQ
         R8L5ChFwk7A5EVYxps2ohola0jSnvpGnyE3ebO1hNpXXhMYGXAEY+XPqEkNtN98xzFe+
         l8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731345021; x=1731949821;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7TmUgvo3rAWWE5RdXfwA5YP+7FX339w5GtAM0VCDDD0=;
        b=EfXdmRRqOECXeIUG/lTTO5jJV2LiL6Kb3ogNghJEIokDw2bPfXfDGjKAVzfuQONvbe
         hoFC9QUF6DJWScap7+U5/ryddySYqeKby5GUCQiHmyRUIUX+oaCgwEhktwejowf1RioU
         Ty5MKsNWlOxBkjWSoqFfvDF8pJP92MuUsTRtzivOpwATExjy+dyRReCBFpAQT+zxh0Kr
         bZNOvmSPUjgJ6n3w5rCr7o5N70C4hfi8PMg1TIWJFtjjPAButnXl8QNORArYS2pdn289
         rNHs+6VmssztAMg8n9T9bPHXulXaO9pWvqBSUI3ixprgCUf2QLuhd64iD6fuWWNRu60w
         3qTg==
X-Forwarded-Encrypted: i=1; AJvYcCW9SPpHq0uJLyAFyuqb++NES6w+n84tFTFNsE7qjO8SLGq+DTe3GC84jIqt+B0EfUBVwGkuAgNeuzEJV4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKp8vx9PBG7x05bOoEEvSb7bSGCKsvhKMpQkpAL74LHNfcPLV9
	btgcxF0Kg56VLhokwrCbzy/PbSGlNRaQ7rUobRouK3CRShwVJxZZ
X-Google-Smtp-Source: AGHT+IGD1ihYcH9brUb7aGVIfVLJtUoQAP/4IyOgHMw8BdSSSs6Gal7OVKQdot3j4F9M9LWLtKEVxw==
X-Received: by 2002:a17:902:f641:b0:20b:58f2:e1a0 with SMTP id d9443c01a7336-2118350b048mr197466545ad.18.1731345019981;
        Mon, 11 Nov 2024 09:10:19 -0800 (PST)
Received: from Emma ([2401:4900:1c94:38cd:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e41884sm78216555ad.119.2024.11.11.09.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 09:10:19 -0800 (PST)
From: Karan Sanghavi <karansanghvi98@gmail.com>
Date: Mon, 11 Nov 2024 17:10:14 +0000
Subject: [PATCH] mm: shmem: Fix variable type to int to evaluate negative
 conditions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-unsignedcompare1601569-v1-1-c4a9c3c75a52@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHY6MmcC/x2MQQqAIBAAvxJ7TnBNhfpKdDBbbQ9ZKEUQ/T1pb
 nOYeaBQZiowNA9kurjwnqpg24BfXYokeKkOSiqNFXGmwjHR4vftcJnQSjS2F9LMpu8UakMBanx
 kCnz/43F63w+Y7ChHaAAAAA==
To: Hugh Dickins <hughd@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Gabriel Krisman Bertazi <gabriel@krisman.be>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Karan Sanghavi <karansanghvi98@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731345016; l=1302;
 i=karansanghvi98@gmail.com; s=20241017; h=from:subject:message-id;
 bh=f6HKmU0BnhqArbMEdHgt52C/V4l6/0SHG91cR5UNajo=;
 b=bdyobIMGN6Bm/v1Ve6FUxxV44b3xLkYGetIq5ykQsmBrIdSIc1b2u9JazqbzbhlsLHW37m05d
 Asasy9eUt3/Dt/C+a5scNEjXyYpd27srLaOmzomKxwQkbvCb/P7Z5t0
X-Developer-Key: i=karansanghvi98@gmail.com; a=ed25519;
 pk=UAcbefT1C06npNVDJHdgpPqTm4WE9IhaA1fmJb3A37Y=

version variable captures return value from utf8_parse_version
function which can be negative, but unsigned won't
let it capture, thus missing the further checks on negative values.

Fixes: 58e55efd6c72 ("tmpfs: Add casefold lookup support")
Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
---
Coverity Message:
CID 1601569: (#1 of 1): Unsigned compared against 0 (NO_EFFECT)
unsigned_compare: This less-than-zero comparison of an unsigned 
value is never true. version < 0U

Coverity Link:
https://scan7.scan.coverity.com/#/project-view/10043/11354?selectedIssue=1601569
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 7987deb2be9b..17a1d4fa8870 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4367,7 +4367,7 @@ static int shmem_parse_opt_casefold(struct fs_context *fc, struct fs_parameter *
 				    bool latest_version)
 {
 	struct shmem_options *ctx = fc->fs_private;
-	unsigned int version = UTF8_LATEST;
+	int version = UTF8_LATEST;
 	struct unicode_map *encoding;
 	char *version_str = param->string + 5;
 

---
base-commit: 6d59cab07b8d74d0f0422b750038123334f6ecc2
change-id: 20241111-unsignedcompare1601569-05b5932145ef

Best regards,
-- 
Karan Sanghavi <karansanghvi98@gmail.com>


