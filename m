Return-Path: <linux-kernel+bounces-576249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E4EA70CBA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 23:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BB4F3B6BF9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2964C269CFA;
	Tue, 25 Mar 2025 22:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="dpLTqJz7"
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED84269D1A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 22:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742941211; cv=none; b=fVas9G10Tu1EMdWecn4++JP44Ym6kzislYH43m4wd+ykMpOuIRhSXEtLhP6NCSNN8K/zb6PKy0o69yk+Cg3LEnpJo3p2QYih4WdABa0XwHXExwTGbtcjBQ+IzOk+bhIG62GlcqpDI/NKFY+cJH3FgmUMLn/d8xX+2j/MBx0cBpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742941211; c=relaxed/simple;
	bh=NeRkZlcvaCBRIUNhcAknsxh2pPI89exFKSolPCOwHZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mXvK+fluE2bNLrZMkl0CnY4uzqEpvnau9GQqEMCUdGV4WAk5+FFT4lLe1iI9iivIQhUCN7phb5XQkEnS9QHjG4px0jREP+xwwN23kiglFQwD9fB2m+t1Zk3sE1KeAUhdwNgV/igvFmBZwjs27TG3JWS+ryaBO0nsoKrIu+9BrdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=dpLTqJz7; arc=none smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-6f6ca9a3425so62382397b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742941208; x=1743546008; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P8dONTFM6RC8uRNfo7doEMwcZfV7041orR9CUS1WNic=;
        b=dpLTqJz77dNB2PodaHyDQmKAThY6hSgYyHc1wGnQhVzNj4cRGZ1fSiocj/tpNOb4VE
         ohxLDKa0NYyYGiXyqRxd8ltvM7nNq3FsXXfpdWrU2qnpuwv2x93r90B222FN5s7UGYj4
         jiwItdje7ozCLsXKGb+NqfqnWyuBNYO2xCDAu0oH1mOGc2NE8v8TcXvGJsLABJq6wzZO
         Fq3cZxJFatqh+FBdw5xlTabbCXpFWACN/YpeErCq0nJpbEPbu/1yCjC3ks6XkYqTbPO4
         QsHeb3R9DamnkkR9X6AlMoVOtlqsVJeXNlp+KFuPLpy1hCF2dB5tFGYJA6ISgNNL4qW4
         ArPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742941208; x=1743546008;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8dONTFM6RC8uRNfo7doEMwcZfV7041orR9CUS1WNic=;
        b=biLgVraWklV2PuwBjB8wjE5z+I1INjMCnDQ5+jfSGpdeK3wj729DdOwIfZd1ziA3wK
         FLJ9EqCDYNY+DF1nmfu1c0NWJLLHgf95nbdd1viMwPOXejw058EWvwXcaJvBzTnUXqCI
         UrxrJWAywgK+bHR+xxgm4mr2RNOPPz0XeTdbL87k1GICaiNUNo+s7OMjtykiN+/e4hn3
         FMXt5Zm/L0BQcm5L8OsOHnN7+UIrDqtIne+2E7IDly4C3i6roFtzuEr+7wRAM9GakV1F
         KlKvOWF1iXVFI5vqoersG5E2FmLM6xOqesk922bXXy0pyCVmcEK4joCJ/JPir3sJzDkq
         Y0wg==
X-Forwarded-Encrypted: i=1; AJvYcCUJZcTdo1bVx0uC97mPBLcUWRQBXWph8ubMLRn++JmkbmOth0SdEsFCr96jlkRCTWpXI88Bj1Wpowg4XcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXLp/apuC00r/DJViIrJW85Faz+4DrHUsPd0FK3WT+bWmg7Oue
	eAE5pxDdkwGggFrRVoapW3aYHQ7Nnr1y3wjTGM2lHt4kNpo1GaeDr6YDre8auwpm+bnH8kP5RnM
	UHcsRJdBJJztFqHjGVwXilTuz3yEi5Oa0gYuE1K+RkdECZU1/
X-Gm-Gg: ASbGncvK9kEJ6270I89SY0irf+cCO9E4RU4jSIuf2jqX31ejgOkXGRq1QyQ6pK8bs8I
	zbk6TuEn1w5JpuPUxwdgQY2SElg1MgLYxRMRHD9EyFY/YJFNEM6xstAejPCXHTP4aj/Yv8tIkLs
	N2Meb9xcJ4L8bvv1NNPHg0CUzKh9Hl8cjK+7DEi2DgL+BcNcLYhXDaB9iAvWVITtwhpEPLhe/tR
	AQ/Hdj4iOrGZFrxwAWuYnU+241ZHovHrsK+E0j2loFMxxS+Hxy5+bUByNhH8bF3i5yfrQ2UvPfd
	ykDJ7vaCiUphp90QAAHNzeOFJrdOX1AS3KI=
X-Google-Smtp-Source: AGHT+IGkV8dFuwx5r2yLmkio5J6J8fr4hQ3tR+zgbUM8xz8jKTp4WzA8Bx5pOB3XzpAT281kk+7kSZkfNhRd
X-Received: by 2002:a05:690c:a8b:b0:6fe:e76a:4d38 with SMTP id 00721157ae682-700bac5e14emr258757897b3.21.1742941208289;
        Tue, 25 Mar 2025 15:20:08 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-700ba82d5a9sm3786797b3.46.2025.03.25.15.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 15:20:08 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 5B1ED3404E1;
	Tue, 25 Mar 2025 16:20:06 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 4E772E415C9; Tue, 25 Mar 2025 16:20:06 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 25 Mar 2025 16:19:33 -0600
Subject: [PATCH 3/4] selftests: ublk: kublk: ignore SIGCHLD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-ublk_timeout-v1-3-262f0121a7bd@purestorage.com>
References: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
In-Reply-To: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

SIGCHLD from exiting children can arrive during io_uring_wait_cqe and
cause it to return early with -EINTR. Since we don't have a handler for
SIGCHLD, avoid this issue by ignoring SIGCHLD.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 tools/testing/selftests/ublk/kublk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index ded1b93e7913011499ae5dae7b40f0e425982ee4..064a5bb6f12f35892065b8dfacb6f57f6fc16aee 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -890,6 +890,7 @@ static int cmd_dev_add(struct dev_ctx *ctx)
 		exit(-1);
 	}
 
+	signal(SIGCHLD, SIG_IGN);
 	setsid();
 	res = fork();
 	if (res == 0) {

-- 
2.34.1


