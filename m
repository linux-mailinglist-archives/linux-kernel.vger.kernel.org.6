Return-Path: <linux-kernel+bounces-222309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0927490FF8B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94745281C31
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5571ABCA5;
	Thu, 20 Jun 2024 08:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X7VeeHkV"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A7B1AB91D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873404; cv=none; b=Un5hLJMDvidEh78JGMzJ0MwPQVX7BRxmrlWgvnCc4iFZWigeH85A232skC91deZ7D8EFUXeTNKsydBV4L9MvnJC3igk+Nh1J1J34HkkQwcG87dqT6DA3Vl5pPVJ/+SQvmFe2pqIQ71oUDestjRcjWD7DqX2EKim9FtlkZiJdS1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873404; c=relaxed/simple;
	bh=E/xlmU084aOXXwFw807wZImjGPqm1ANMchdMOU8QUug=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=r7+oKMZJaXU9WX0HHYo057Gf9BkGVXe2MA2rR9opdJHKgldgzyBVxPMBzsjMw2FwjG54uyulgtnHnaxniTShu9xdKvRnCpVdQG8iTMVf//1Yl9WDvbpvB0Zkq6aK0rKEiN002kpo691NIfSDtxPr052t/5a8ojPVc7/XkeFj8pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X7VeeHkV; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a689ad8d1f6so67691466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 01:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718873401; x=1719478201; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vPUY4GnBpPiQcbABkIr/cid7Dg+9bQhVw0p/ZhNJByA=;
        b=X7VeeHkVNnoM4c/vIDPSHLEFNAAE4h9jolRxuo4ZEwsFzcqN+IX6rwhyn8CUVcnBIK
         Ljoq08b58s8IVqjm/YIRJqY6l/ZxLVNhufoUil9vwHs2po8Rtn7Y8FaxVL6OeAt7/0ZI
         AcVuC9RjRbP4YPbT96GAyM3SlWQmbK6ilbUTPX9M2x6p79SJJ700XoHAigMkqt698fWF
         CE2HNrthqHlMWLDNqMDYvVBjEVnZpYCFvhqvoKxYM4phuyg0YwnIBEU7SrlQEX8HwgT4
         /NH0kKw1qGodIboCMVqbdaoecvAIafSn6rOgr96Fj5BQc/Dtn8eQEOCo0MtZXW//9izk
         fICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718873401; x=1719478201;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vPUY4GnBpPiQcbABkIr/cid7Dg+9bQhVw0p/ZhNJByA=;
        b=V3bGgfSIbrXI7OPT7qxO45NtkUGYY8E4hii0Q0IQy/459cOHJ8NsasC2P69m0h7hTw
         ZZxwL6hKHSyvcM9B6pqgiZTuiQZIli9jfh5lJRuvqPoBXuCVKRxdNN7/O6P/BwZ2P1iz
         UF37tfGUjnPmDCTSD5uDf394cd4FcEBk1tnObY4juuxCyY+B2HaV5MhbrAsFzgLv6Bon
         runPFy7lbfe/xEwyWr+k30Ym4+CL/ZdkrtiOwWjryZbstaIIgZD+LC79feRVMwx2HLSD
         z+xJni9CjBLU48A8KFBUOiIPmi4P8qJCNZERXBpTp3ZybRu7J22Ccl5cUUxuOQu/jBLD
         mSJg==
X-Forwarded-Encrypted: i=1; AJvYcCVruavMrj6nBSHmsUNSOUT1InSgpxaedvrGXiTxPiwXc1KpnTKUwPOPozi4JISXbxD3hoOlnPD9E51jcSertNXxdTZwb7WyFQ2wesAN
X-Gm-Message-State: AOJu0Ywg1o0gJa8Dqkwk0Bygx+GXT1Urh4i9euL0ZkqAhII1tDMm4VTU
	z7UMpqDzPUxWBks8J5/ZHiuKZyrG5doQmlHOeSVi+7QlbI7RsSX/BJf7Wx057fA=
X-Google-Smtp-Source: AGHT+IGeRQpttQkvdYS0dTEFzVkziwzBfpxbBi4M6n3CVQkw5KiESUy5y3Tp6fSmCv99sCUYOBBX3g==
X-Received: by 2002:a17:907:c70d:b0:a6f:1045:d5e2 with SMTP id a640c23a62f3a-a6fab60b27amr291477766b.4.1718873401051;
        Thu, 20 Jun 2024 01:50:01 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f5f377dd8sm694535966b.146.2024.06.20.01.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 01:50:00 -0700 (PDT)
Date: Thu, 20 Jun 2024 11:49:57 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] tracing: Fix NULL vs IS_ERR() check in enable_instances()
Message-ID: <9b23ea03-d709-435f-a309-461c3d747457@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The trace_array_create_systems() function returns error pointers, not
NULL.  Fix the check to match.

Fixes: e645535a954a ("tracing: Add option to use memmapped memory for trace boot instance")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 71cca10581d6..5462fb10ff64 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10507,7 +10507,7 @@ __init static void enable_instances(void)
 		}
 
 		tr = trace_array_create_systems(name, NULL, addr, size);
-		if (!tr) {
+		if (IS_ERR(tr)) {
 			pr_warn("Tracing: Failed to create instance buffer %s\n", curr_str);
 			continue;
 		}
-- 
2.43.0


