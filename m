Return-Path: <linux-kernel+bounces-278711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2093394B3F3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 02:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFF451F23636
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 00:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD671EEA9;
	Thu,  8 Aug 2024 00:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="edtpsP8l"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1564A33
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 00:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723075367; cv=none; b=RnW4D/I7ckxmEGXp9SHjJM4khokiGI7ZE9b+DlRC0d31ZpYMRC9noFyGxAJr+TheegRE/Nuu9Xd8+em8bR0ohAZnE6GlKYEarb0d8od+JIkBIFCOJAH5Eogwsgi5pfu2oJB125+zRIf5pkQcAXars52JwpgVUMnfgedxpRt7Pto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723075367; c=relaxed/simple;
	bh=FXzXJ8puJjRyzaYQf/myhvlspm+dHOOl1FmtKrgxWKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sfnvY407RowXIzU4UsKS1jKClTa/M3eZtp/VoHgmdwCAtEPAfWJMbm7iE4bMF44PC26XWXpCBzt46ztxNhUhMQ0SGmhNm4HnC0fBrO1j4FpeIJjlUYZKwvHb9P3CRWGDsrDn6F91hWsRZCt+NscIG8A5qXxh2hDqIpCOlcvZZSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=edtpsP8l; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc56fd4de1so2734505ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 17:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723075365; x=1723680165; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cVEM398nfKMPG00719+LnI2T0zzUH1B6VC8Z8aO8SnY=;
        b=edtpsP8lBsuDbYcLCvNeFe+wollUJWuVAlwxg5A6ulLGV9gNOt3dyLpJoK2/KPA2A4
         3msPExSNjpH89B7Io1g11oFhMUR/zybdAJbn9KeppxMmg54Pag3DmpdUUre+aNei7huf
         G2V86sbhpDlhVbIE+SEsjlHNSzTqWXdiAGv9yZDSeccEtMNbbI+n1cUZrKwcjODOHgzP
         v00gX3RKu2J4HXXDbYMy61u0NVvEkX4Fka0mML3dDxNbkA9Y/6ZxZ6ip6O/gikX0+c4T
         v79FAo4M7sUtjKI4ReUeo3ymNJJ2eGNnwydXF3na8r3+k0l6B1J3WcwArvphl5cEj3u5
         rV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723075365; x=1723680165;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVEM398nfKMPG00719+LnI2T0zzUH1B6VC8Z8aO8SnY=;
        b=kCkZvxQ+SRkDGLRbM7fJ/NpeCLBZdUtLmZnRlmBA4u+1HoUAOFHbBxeuUE+mYoUimq
         P8DMGKpA9rVgiOmTEdgHOlFFWW1NaHWGnnCLknIlvKn2U1EkKTmBDmNoiG3VUm2hznVs
         RfMB2jA3XdNRcZgkRrRBerMFDKK04aBpKbQsimD1WPUwNSA0GNOwnANVOj3LRIjvzfoG
         MbII2kokc3atJhEsUxEqXWz4cC+e+T3Q0ZLGrRqwG1JYUTnhA5c87h1sX24h7fKcG62+
         M/QcYb4/7OLgJZNgVHL1dN7Ap+TtT0ULYwaemv5VE4Oh42cCBHt/3zr4GwxY2QlY/2eU
         E8Iw==
X-Forwarded-Encrypted: i=1; AJvYcCWBPfCfrKDhP3kt37VFF9u/xn04f+dkUjkGTP3LtA0IIpOQxoxc25cQWUqQCv2+Tua1JUZ/uHOEUyYf4XLpN5tVii3wQ29QxfDe4qbr
X-Gm-Message-State: AOJu0YyZRBks64ocRjng1ge/2xjiSAOqsnk+UOMirBB0MHtSPQn+xSTg
	1Fg0NSsVbwGtz07BDhc2KS4PRzFHUAPif7U//os0d4oNYciA2y3HM60QitYttIk=
X-Google-Smtp-Source: AGHT+IHNeWL5cfiLNEiUw9iYprrQkJwxXnC1ihODFnCQg2Ve6vzN72yDdaGjq2g1HAKVsa9e7SNefA==
X-Received: by 2002:a17:902:e5c1:b0:1fb:2ebc:d17a with SMTP id d9443c01a7336-200959a8eb9mr2828215ad.23.1723075364871;
        Wed, 07 Aug 2024 17:02:44 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f586f7sm112867015ad.90.2024.08.07.17.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 17:02:44 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 07 Aug 2024 17:02:41 -0700
Subject: [PATCH v2 2/3] perf: Document PERF_EVENT_IOC_INC_EVENT_LIMIT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240807-perf_set_event_limit-v2-2-823b78d04c76@rivosinc.com>
References: <20240807-perf_set_event_limit-v2-0-823b78d04c76@rivosinc.com>
In-Reply-To: <20240807-perf_set_event_limit-v2-0-823b78d04c76@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Atish Patra <atishp@rivosinc.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723075360; l=886;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=FXzXJ8puJjRyzaYQf/myhvlspm+dHOOl1FmtKrgxWKo=;
 b=zxkkEMsw1fY3iXS14KmuJbEETHUB2sYYNZ4YGRtAubtK784e+Rwc2ub71UN51Qt6C6UAr2WLz
 4rd2xDBV/x+BnyByKWEeHW2ZoFdgx1NQfDOnDMbQsgsQ9c47n7VdvL5
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Introduce PERF_EVENT_IOC_INC_EVENT_LIMIT and explain the differences
between it and PERF_EVENT_IOC_REFRESH.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/design.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/design.txt b/tools/perf/design.txt
index aa8cfeabb743..1626ae83785a 100644
--- a/tools/perf/design.txt
+++ b/tools/perf/design.txt
@@ -439,6 +439,11 @@ Additionally, non-inherited overflow counters can use
 
 to enable a counter for 'nr' events, after which it gets disabled again.
 
+PERF_EVENT_IOC_REFRESH will increment the event limit by 'nr' and enable the
+event. To increment the event limit without enabling it, use the following:
+
+	ioctl(fd, PERF_EVENT_IOC_INC_EVENT_LIMIT, nr);
+
 A process can enable or disable all the counter groups that are
 attached to it, using prctl:
 

-- 
2.45.0


