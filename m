Return-Path: <linux-kernel+bounces-200022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFE38FA95D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 06:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA47285D81
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 04:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8C013D88F;
	Tue,  4 Jun 2024 04:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsafrwNP"
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DCF13D612
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 04:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717476158; cv=none; b=D2hjhMOnltvExi3r6K9Y1vKdjNnbt7IxtVC1wCuy9BkfvrZB1SkGcFVrqXcUxaRelmR/PsfiPZ3v1uCmdqXJ0yzb+yJLFaEjcJ7r2m6lbFnqM+NARyNW1reVUehkmw265wH77BAF1aCI3iPwt7n3CybN+jUiOlfgmwuyfGZmCco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717476158; c=relaxed/simple;
	bh=e/hzSQPioGhqZWn+FtCqDm09GQWDMpuuNzGi6YPvPqo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VbG+cc4xUksCt7wH1SP3hbrpNHF4XToZScHri089VVsgD5fyoYSZs8XRBfvULszvM2v4BITfxNMm21+piHGAS1qv/a2x8ZDhS7dZigHosauX1b8Q9Vo0fVMh9l05JYMjJduE/S/UumrPJ0C5e7kzYJWLIkjKfCPnnW7A19kBWXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsafrwNP; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-702555eb23bso2190272b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 21:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717476156; x=1718080956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BkvEv3qr0/x9ovLj/Wv9So8nnYSCd63OyQtFRSRnJ0Y=;
        b=RsafrwNP1JJC6q036rQgdWS5ETWc7LbJaB5E+wntCXVJN9JjHPLzUsHvjbvBHw8/9V
         QVGpVBxQinayBEPcWPO91CGQ8EY2W5Z6KOeTmfpzJJ3GShEdjxXrY8/5KzPP0EyHG5+C
         iCOvx71ej+DQveFXr+u2esvjYvk3iCXXa9/5epjoAjqky1nq+MGIoIixo2UMdsNX2d59
         aJBmwVlQll/DV+JOiBYSQaWbvZVav6GFJeqqaF3twFHrIZeQFKA7eK1j4SWD3qsev1hi
         4f+LxHsPfen7Wj/sq9XZDkVtvVgGnUqKduOpUWf1PJCSBqFvqKeQkhs7EKs7VhDiAkge
         OcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717476156; x=1718080956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BkvEv3qr0/x9ovLj/Wv9So8nnYSCd63OyQtFRSRnJ0Y=;
        b=IhcFIZRHlzJDsLZLIm1S+/IJBCoKKJnzzULiVmxqIbdvVDecCYMfv5XjXHTxaZ2HPD
         Mb4DNUePOD340mKgei8LGi16GMrEuIcuTUYi1crm3Rx7PxT5Pa/BHukuFSviux6Uq4yO
         Ykw/e0tHzHLyZdTMmAW2AY7yQ/6IsIrtoGkoC3uUvE7jsK6C1QEM0inpkBIxyO+Hw5GA
         VqA9JjxuMamwbkpTUQRKSYY8urcs5d4evlY+Y1O3JFBD3bgBSkWik/GkeaKAz/B9VkSh
         hcMLKQIHZ84ueAI5TY7F+fKK1OVkY0UntmTcQRh219H38o3VWJiTRwUnzw6EAt1DrC5f
         BgJw==
X-Forwarded-Encrypted: i=1; AJvYcCXG66b95y08ckBcfOSTzHY7oRD2E5QkK6Byx6XKu/ZEl7D8waNqPRfAC6rpvL3RBJ2ZEiOdomwqjpI50nPayoFFwwEG6ypAwEg/2Sj1
X-Gm-Message-State: AOJu0YxDr3ZzPlt4hhtk25Js/xI2u866SptNCZ1GYx4nSlY7DTImqRgB
	GoCoxZH5BCO+dO7+v8cF06pCwD7i+G7sfMd2AX+yLTqfjTegQr0A
X-Google-Smtp-Source: AGHT+IEUwlMaCN9VQPEkSiUpGSmfy26ZgyEA8e/o12YEcl420arHgmfeFEu01GwgpxIpidvJWxSeKA==
X-Received: by 2002:a05:6a20:6a09:b0:1af:a53b:89e with SMTP id adf61e73a8af0-1b26f0f19efmr11223962637.10.1717476155618;
        Mon, 03 Jun 2024 21:42:35 -0700 (PDT)
Received: from kylin-ThinkPad-pc.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323562b6sm73128515ad.73.2024.06.03.21.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 21:42:35 -0700 (PDT)
From: liujinlong <mingliu6104@gmail.com>
X-Google-Original-From: liujinlong <liujinlong@kylinos.cn>
To: kees@kernel.org
Cc: thunder.leizhen@huawei.com,
	yonghong.song@linux.dev,
	ndesaulniers@google.com,
	song@kernel.org,
	ardb@kernel.org,
	maninder1.s@samsung.com,
	azeemshaikh38@gmail.com,
	linux-kernel@vger.kernel.org,
	liujinlong <liujinlong@kylinos.cn>,
	k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] sprint_symbol: Replace strcpy with memmove to handle potential overlap
Date: Tue,  4 Jun 2024 12:42:28 +0800
Message-Id: <20240604044228.2910712-1-liujinlong@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the function __sprint_symbol, replace strcpy with memmove to ensure
correct behavior even if the source and destination buffers overlap.
This change prevents potential undefined behavior flagged by recent
compilers as [-Werror=restrict].

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: liujinlong <liujinlong@kylinos.cn>
---
 kernel/kallsyms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 22ea19a36e6e..3c3a77fcd020 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -489,7 +489,7 @@ static int __sprint_symbol(char *buffer, unsigned long address,
 		return sprintf(buffer, "0x%lx", address - symbol_offset);
 
 	if (name != buffer)
-		strcpy(buffer, name);
+		memmove(buffer, name, strlen(name) + 1);
 	len = strlen(buffer);
 	offset -= symbol_offset;
 
-- 
2.17.1


