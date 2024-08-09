Return-Path: <linux-kernel+bounces-280870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6AD94D045
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E4761C20EDD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860E71946B5;
	Fri,  9 Aug 2024 12:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IiRELPhf"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF831DFF5
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 12:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723206758; cv=none; b=l9xjAwdBVRdoVJZgyBnKwLMcirrUZdZkLtJIBc5bgtjXS9kiKMB1uUWqMewAq9QDIvAwIhnx1q5Uq4kCG9o9fYwbghguU8Bc2jWWAec3HmrVSuJw2toxCsuv72u+oHx69DtDOvHtZ91HGkSaw/a5h5GJbNSxergoUPz9iEHRk8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723206758; c=relaxed/simple;
	bh=QNcaoqLsaVCec6Cy7SIaExvsGVbtIi52cpW6p62gqfU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ekOneJJJq+FroPppMFgfcA30jHq3kL6eQ6oiEb0ucSKMV6RdDb7KGcRhCSeacnMP18Ykk4hHg2XZyJUD5w3LNjyBEY883PpMpX/aV1BnQwBzIY+1cYvfas7b0ltnvaFOn1PssuCh4dubH86teOVXuceaBQZ2tdUqP4SgXeGUd2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IiRELPhf; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52efd08e6d9so2561156e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 05:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723206755; x=1723811555; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XEvmrJApAdAdB8IUGlSUXCcZKgELg0TXzRkX9FYQA2E=;
        b=IiRELPhffhyMMLf9Mkhbx5pVy7wSrrlRl2m5A7RuUOv8hgePIATFegZEYow0ytnnl6
         3V4qbdwEmcwS76zXHfVbikZCgIMxwEm+v9T2g4hpTaZOOER71xh68PTrfVE2J6TQBcbu
         i4pPUAVNsPFyIIelLvbmmLcariEOS2P+f4JZaWh7JeiPu5Zl2Aha7HHQ2hSXq3GY5jSU
         EoJC8kysXtJEOVEFwu5iGGOLLklOEnMv7yKG4blbs0VpdNegiMrYJKKqlyQga/iEjQWh
         Nbh6gXXEnAdTR2q3eYMKj7DyBvYMKWh4ufZIRgCe9UcEaY3Oe5V8kd7WBaBp0JaEh+TO
         XOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723206755; x=1723811555;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XEvmrJApAdAdB8IUGlSUXCcZKgELg0TXzRkX9FYQA2E=;
        b=pT845mVESzbPWX7EBeZKKiZeLhbHHVEc22cMo6Yj9aXMrKrsKcGCNT93GAH0IdGk6B
         eX8QZcW9dD4f5dR5Kebg3nfnJuccfhRQziJ4ZPCno2XSxAbRYH1hbjQtiXdHBFnEGEab
         hUuds/Y3Aiix5TJWQXWM4uTYkchU5kCFyIKaAnlYrATmkJZizRvfVy9iRQO4QT2x9z67
         sjGNwDJoaLDNaFHANRlhWlUmE1JIJrGeafiQokF69asFlbLERdSIfL1kL2aHUcEBJ6ET
         LDEsSBFhFtxsTbrV509qCzOyTcVZTrweYqHBCPxbPjpzoaAUX7qlQdQtH0MWPF4Is8ho
         7f6g==
X-Forwarded-Encrypted: i=1; AJvYcCVIDV5z8r72nBKwXka1fOtzbNBwfQ5IO+V4M8n1WsS+Y5k0C8SIJlSR2+dUOJc3621YshcqLq2Ca2zX3ZJzdqCEgxy/aPBNulsSewbL
X-Gm-Message-State: AOJu0YyqmUR9r3DCaP3rXZ2UDVLA4FSlzUdiSFVGxtzTVBpkDhRcqLeQ
	J+E5zwfy2SEpsII+uGNG8xAAAvZfknQPV/xK96+ztKmbHmpRi1tK9BeYW5ytDuA=
X-Google-Smtp-Source: AGHT+IGzPu2doVLDNZ6syQ8+456inTtlzazWj4IP4I0oNXM1Sz9cwjKQLoWzh+mGsvT5bHuN4rBo4A==
X-Received: by 2002:a05:6512:3b0b:b0:52c:6461:e913 with SMTP id 2adb3069b0e04-530ee97436fmr1248689e87.16.1723206754996;
        Fri, 09 Aug 2024 05:32:34 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2bf8666sm1495151a12.9.2024.08.09.05.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 05:32:34 -0700 (PDT)
Date: Fri, 9 Aug 2024 15:32:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dev Jain <dev.jain@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] selftests/mm: compaction_test: Fix off by one in
 check_compaction()
Message-ID: <87470c06-b45a-4e83-92ff-aac2e7b9c6ba@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "initial_nr_hugepages" variable is unsigned long so it takes up to
20 characters to print, plus 1 more character for the NUL terminator.
Unfortunately, this buffer is not quite large enough for the terminator
to fit.  Also use snprintf() for a belt and suspenders approach.

Fixes: fb9293b6b015 ("selftests/mm: compaction_test: fix bogus test success and reduce probability of OOM-killer invocation")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 tools/testing/selftests/mm/compaction_test.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
index e140558e6f53..2c3a0eb6b22d 100644
--- a/tools/testing/selftests/mm/compaction_test.c
+++ b/tools/testing/selftests/mm/compaction_test.c
@@ -89,9 +89,10 @@ int check_compaction(unsigned long mem_free, unsigned long hugepage_size,
 	int fd, ret = -1;
 	int compaction_index = 0;
 	char nr_hugepages[20] = {0};
-	char init_nr_hugepages[20] = {0};
+	char init_nr_hugepages[24] = {0};
 
-	sprintf(init_nr_hugepages, "%lu", initial_nr_hugepages);
+	snprintf(init_nr_hugepages, sizeof(init_nr_hugepages),
+		 "%lu", initial_nr_hugepages);
 
 	/* We want to test with 80% of available memory. Else, OOM killer comes
 	   in to play */
-- 
2.43.0


