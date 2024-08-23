Return-Path: <linux-kernel+bounces-298183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 411E495C397
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 05:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F290A2836C7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 03:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EFE2E3EB;
	Fri, 23 Aug 2024 03:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6YeG7pK"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47AB29406
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 03:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724382346; cv=none; b=sH1UgO38Zd0vUY9EKmz3Zw2l/Z+q20qfgmGTq7rgwDPwLBv5Z9MYsp1Q76R+hW5WTjHZOJNj+6i2/ZdS2MGTkRPBy0NDigzvx91+Yys0tm01U1iSwsPF+Nely00ByNE2IiuxuJljihSaXG3yMqYIb7Cf4DMZtjStcH4vfaKU6eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724382346; c=relaxed/simple;
	bh=PDBb6gF2R+iMrzKWkesA5uHNXQG2EqCGOeZvygJGW+c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EkDY8uCUHVabUaNB+DZADccoP0mMu9B6ZsxoBYbsHRtlAnAUw3bZVFRz/pfqDXJpsNU94QSaGExX+nAF+AjR9aMl9CpjLZAS8KCcbQWVWSWfKS+75Ht+Il3PEa6bQzCUFHX++BlqDHdJuTi9TIBICYyAAZWLmeWN8bt/SC9usvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6YeG7pK; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7cd830e0711so1442613a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 20:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724382344; x=1724987144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pq0C1aRzAHoVhXyS4kaMh7Wg4xyGpeAa9UnKZXVrjAA=;
        b=Y6YeG7pKMmexLRN2Z9e4vkNzxHqCkKW+SfqfaJ5F0I5CSMES2fmIs/vjH0Hv7udmbv
         Fqj6qiN98u7kApnqAenAG5jbBW5GmeircZZQVQ+jbHUgUDv6pmRFT+PYjV99gXWxbvBa
         QZHba3jZfIudUeawmsyfCX5Y85nraOS6kkaauzmPxGoQRLPqpgFMbUiZqvEH61uzA846
         7A7LApxh+uHviG+qlBnGHM+VTQb7Pa85lHMxIS5UtD2rYlr7IOJST/imq1FBC9McQVem
         BMt00aIM6XkxJwiXK0vdvcP6U57W8Kc8A9Mt8fXwnVo7/MfJ++c5c9Mu/6PU6PtcPHFu
         xFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724382344; x=1724987144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pq0C1aRzAHoVhXyS4kaMh7Wg4xyGpeAa9UnKZXVrjAA=;
        b=urcsgsSze6AZgTYNdeBzojjPAhTs60ur0IaBN/gX7+cAI5hY0DP/dZZotHVzBVZWEs
         krzzOcCDQJrZ7U6TjMXzKS37NYDkTYUkmItq8/n4qIDazLlN1Qs2/EWxANv5vSChCMbl
         3Glx7tZERPNmH3oyJbXlfGzqGdH3DSlT8Rq6n/ztPlQFsqtOhPIPGu8j8qVXSSaOotPM
         BLA++9gG4yd02iFZfzScFA+gdLDZpnuju20B2Cig9VK9h9sPbm0hCiYka9UuY4M9gkeZ
         lVC/QzU/Gj1xRHja7362+h7B5srIU6hV3EWa/BGvdMWjB+Q2Pk57z0TQwDdye7ePZYa2
         l0NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuPt4zgtESf2Mf5CrJtCiNo3x2o9QGCHmZko2v0wiBzlazJr92MZXYm6AzCNEU61mIhxvXWgp3HUdGvZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNSI5xuQj0aCQ+FVtTEJFgROghSehqAsqkGuXqP46ZU/Izu9t5
	U7yKevOlColGqLMpBGi9cMZKUdaWoJSSxQvWg2Icc1qS93MFmiuR
X-Google-Smtp-Source: AGHT+IHRxxjWzMo/gQ86LcVvFpreUA+pLbsL7cJKw/E5UqRrCouKYM+QHAsdGLolQuq5mhtnBzgT6w==
X-Received: by 2002:a17:90b:188a:b0:2cf:dd3c:9b0d with SMTP id 98e67ed59e1d1-2d60a8cb8afmr7527855a91.2.1724382343787;
        Thu, 22 Aug 2024 20:05:43 -0700 (PDT)
Received: from mi.mioffice.cn ([2408:8607:1b00:8:8eec:4bff:fe94:a95d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d61391fe09sm2756114a91.19.2024.08.22.20.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 20:05:43 -0700 (PDT)
From: liujinbao1 <jinbaoliu365@gmail.com>
To: xiang@kernel.org
Cc: chao@kernel.org,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	mazhenhua@xiaomi.com,
	liujinbao1 <liujinbao1@xiaomi.com>
Subject: [PATCH] erofs: [PATCH v2] Prevent entering an infinite loop when i is 0
Date: Fri, 23 Aug 2024 11:05:25 +0800
Message-Id: <20240823030525.4081970-1-jinbaoliu365@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: liujinbao1 <liujinbao1@xiaomi.com>

When i=0 and err is not equal to 0,
the while(-1) loop will enter into an
infinite loop. This patch avoids this issue.

Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>
---
 fs/erofs/decompressor.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

>Hi,
> 
>On 2024/8/22 14:27, liujinbao1 wrote:
>> From: liujinbao1 <liujinbao1@xiaomi.com>
>> 
>> When i=0 and err is not equal to 0,
>> the while(-1) loop will enter into an
>> infinite loop. This patch avoids this issue.
> 
>Missing your Signed-off-by here.
> 
>> ---
>>  fs/erofs/decompressor.c | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c index 
>> c2253b6a5416..1b2b8cc7911c 100644
>> --- a/fs/erofs/decompressor.c
>> +++ b/fs/erofs/decompressor.c
>> @@ -539,6 +539,8 @@ int __init z_erofs_init_decompressor(void)
>>      for (i = 0; i < Z_EROFS_COMPRESSION_MAX; ++i) {
>>              err = z_erofs_decomp[i] ? z_erofs_decomp[i]->init() : 0;
>>              if (err) {
>> +                    if (!i)
>> +                            return err;
>>                      while (--i)
>>                              if (z_erofs_decomp[i])
>>                                      z_erofs_decomp[i]->exit();
> 
> 
>Thanks for catching this, how about the following diff (space-demaged).
> 
>If it looks good to you, could you please send another version?

>diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c index c2253b6a5416..c9b2bc1309d2 100644
>--- a/fs/erofs/decompressor.c
>+++ b/fs/erofs/decompressor.c
>@@ -534,18 +534,16 @@ int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
> 
> int __init z_erofs_init_decompressor(void)
> {
>-      int i, err;
>+      int i, err = 0;
> 
>        for (i = 0; i < Z_EROFS_COMPRESSION_MAX; ++i) {
>                err = z_erofs_decomp[i] ? z_erofs_decomp[i]->init() : 0;
>-              if (err) {
>+              if (err && i)
>                        while (--i)
>                                if (z_erofs_decomp[i])
>                                        z_erofs_decomp[i]->exit();
>-                      return err;
+						break;
>-              }
>        }
>-      return 0;
>+      return err;
> }
>
missing break?
-- 
2.25.1


