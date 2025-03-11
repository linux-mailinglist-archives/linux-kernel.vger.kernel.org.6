Return-Path: <linux-kernel+bounces-556198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC3EA5C252
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDB247A8F0E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034522566F4;
	Tue, 11 Mar 2025 13:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yu471ND5"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FCF2222BC
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 13:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741699117; cv=none; b=Pdnur/mYPpDLRHoaVh/tyKA9DCVcfHQVKbR3v0ENAGBRdgfPPLuIycn37Ba0K7OvAdV/+BGZeS7/C1vQxlntFa4qe3NTFB/xmDH2AkgVIzvZADwj/gnOZctvFzfWdLkZLDrWnJxbGDFLJz9z09tfZO8ZFXSOy+pTfR1z+draB/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741699117; c=relaxed/simple;
	bh=0ffvNk6pyNEvDSJ71JGiz95WEqGo3Pzu7Vx603nXPak=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Da94of0uo1eLjB5KQt70zmEaf/29txrscNSQPswrzb6o17x0UD4wMqU1RzwWLLilDvOzeseS6haAQbMGdnVgn4lEneMEeodQfUxuvDnBQdF48DGzklZLN83UauoPqd0e3CrLj5ZXNPVAReiTUoATX8p4DLtL5PFJ6w/joSldYbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yu471ND5; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-438da39bb69so38726525e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 06:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741699114; x=1742303914; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vEpPGTTI1xwsz2Fyvp18/EwqSXfTpjR75q3+Kl9ryQ0=;
        b=yu471ND5enBTBqHrJbxY8o/M7TppQgg9d+D0V12Zxwykl9xD1ialBSGin3kbi5NWpd
         2b23svAeQEQY/mP1iC1+pahEfXx/nvQUHMnK+A0gquSZwGApqdNXkbmW88P1qmHJhbw4
         uGTtn1MNsoS5GGwlfPVxJO49kirfmqg9/3hTVTbeCfsFsaSUYiYmJ21EpS2ikFg0a7+9
         mlssHdfiimWgVZNzWf8Uv2QxYhmt6T6CvkczgNFacudosMfBLVlopW+6SuJCznZJ8ZwV
         oP/6rKQdZnhE2oqTJsnhv8qkJq6wAl/I8eL6ie8eIACrvrYd2Q+83gdmoY9yUX4h6pDm
         j/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741699114; x=1742303914;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vEpPGTTI1xwsz2Fyvp18/EwqSXfTpjR75q3+Kl9ryQ0=;
        b=c7owYc6J7hA4IbESbnQCkYYdcJa1ytd/NwA2W2xI9CPJbm4mQj2OFKrV19Y4WnLfeP
         dXYrZ6R9Xo2bq2KJkFmsDq363cjXoAfx5XDkGe5NFs8qLMD28nkPNkb9ppddQarN0Wn7
         tJeT88X2dKBm/Ex153IV00pAVS1SM8RD7C7vh2P1zLMqI4UgC/Toy7NJP/VAzJVGPfIj
         zxrFRmSuFEIePfyu7ZpMCJgLopHXSrLr36WdDTo985Yz7iCIA95S73OzYS8OGZWIqPCY
         LgHeBg34DPb/whMJSjzXC/gCFEzBr1+VHIQiv5elE1yJwqyMg+90XPLebI9FoXoroJD6
         CfCg==
X-Forwarded-Encrypted: i=1; AJvYcCXuWk7bk0T9C0mqvq6n8aySbg7m+gjm7FwjW5PNIE4PIQsSAZ0zmbwcZytEqSuSyaKZ4GvoG3CD3rgEPbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1qhvZ73QO3yNIdyXGv1SG0AlpKgy5Ueq0LQCemRtmdUThOo+q
	bfhim4kvVku+3BRrZcVJPoNmbc/79zjFxrrVR1s4ClNTbSKQLy3vIrSr2C2at5ezvtxS4aQr5Aw
	FmiMa8FxQGw==
X-Google-Smtp-Source: AGHT+IF4wKnonit+EpSv5UW7OYNEJNWqpKGUxuJH1HQv+WZ5yf0iB3xBzk58+Z6A+0FjREeEmIvwD2nZ9cCRYA==
X-Received: from wmgg10.prod.google.com ([2002:a05:600d:a:b0:43d:10b:2c42])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1547:b0:43c:fceb:91f with SMTP id 5b1f17b1804b1-43cfceb0aedmr83968355e9.11.1741699114176;
 Tue, 11 Mar 2025 06:18:34 -0700 (PDT)
Date: Tue, 11 Mar 2025 13:18:19 +0000
In-Reply-To: <20250311-mm-selftests-v4-0-dec210a658f5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250311-mm-selftests-v4-0-dec210a658f5@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250311-mm-selftests-v4-8-dec210a658f5@google.com>
Subject: [PATCH v4 08/12] selftests/mm: Skip gup_longterm tests on weird filesystems
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

Some filesystems don't support ftruncate()ing unlinked files. They return
ENOENT. In that case, skip the test.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/mm/gup_longterm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
index 15335820656b1c143b440b8a1065a025378e22a2..03271442aae5aed060fd44010df552a2eedcdafc 100644
--- a/tools/testing/selftests/mm/gup_longterm.c
+++ b/tools/testing/selftests/mm/gup_longterm.c
@@ -96,7 +96,15 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 	int ret;
 
 	if (ftruncate(fd, size)) {
-		ksft_test_result_fail("ftruncate() failed (%s)\n", strerror(errno));
+		if (errno == ENOENT) {
+			/*
+			 * This can happen if the file has been unlinked and the
+			 * filesystem doesn't support truncating unlinked files.
+			 */
+			ksft_test_result_skip("ftruncate() failed with ENOENT\n");
+		} else {
+			ksft_test_result_fail("ftruncate() failed (%s)\n", strerror(errno));
+		}
 		return;
 	}
 

-- 
2.49.0.rc0.332.g42c0ae87b1-goog


