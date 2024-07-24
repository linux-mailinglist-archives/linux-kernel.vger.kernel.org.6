Return-Path: <linux-kernel+bounces-261576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B37493B953
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 00:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4AC2845C0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E5D143882;
	Wed, 24 Jul 2024 22:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="oI/1eCgE"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6660013C918
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 22:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721861674; cv=none; b=frmwgJgwpRv6jYZ5X/nNmESBydlkzj6Uib6G3U1A3S5Lce1Kwbd2/z9Sx3o8frs14NzwI8KW5fetyYgVMGe0IQJfEXG37VlhaLT2h4fFLRgEO1EP/riRReJD3g5vMee+ZcCL9Ul1NGDZ2hPCL+Lkz8ra1hC6ZWY02cniM8d0ZGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721861674; c=relaxed/simple;
	bh=4M35RJ0MrhFzvtO/gpzcZAZGyvkPqgVAOXcftDMuvps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BjDuAbkIAxec235eI7+eD4qTHxb9UDGoukHjI55joqVBpyFnPJkugcWKbQD4A/T7Wg4GGgZ4JBPrQaoDvNMxa2SJu1gEfWNDh2alEihx5PDpSD4rUwpwVynL5Kg/LtKNhMuOnV+y9vBpPDhl78z28CXW0SIOSeHEN82WGUDFENw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=oI/1eCgE; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-260e5b2dfb5so145500fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 15:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721861671; x=1722466471; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BSkmGq7ZrZbXdHouXcfFGOgcX1f8uJ3n8uj4r7vA1PE=;
        b=oI/1eCgECsTYCFEA0gQCJhXJ82oFmmIiP04yF7Fe5eVU2zyiHJ+yyX/uEMtzPNwSIz
         +UjB75/bMxLwy3ShA+p9pgkbwyuY1Ythp6O5wKE6Zzg4+fJiV5u1RQ4WoDfqlX3GSD2J
         YBzY4pV6zLXcyqBuFxie0xqnzP8UTDQdkgckkqXmqh/E2/NbM8VZLtMrWp8IBQaRFHpa
         RZec0u1CZSr16Lkf+jMGPxPWCuLzaH6Q4i5elCeR6pUfe64lsZJbggOvZkBVZ3ytBmTR
         huEirdnB1u7dIOslpeSer/oKuVkk/7uMQHeg2nF88sP1HG7kV1rNjGAiwEgRk2f10RBj
         2Iig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721861671; x=1722466471;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BSkmGq7ZrZbXdHouXcfFGOgcX1f8uJ3n8uj4r7vA1PE=;
        b=iNavehxR7EjS6VGSe63GwKN4Mna6Glc7Kz+kEwTp2Ou8NinN+P9co85xKGA5BjdcIW
         7JKoiWAEcldYL4XvRvEyjwgjsNEAdkkaKOJk1QoNNKOWfoRbYDnW4ryAVz9hCgs1Frug
         Mm6Ae0/jL/f8FJlHcLt7PItBfmgr1BfbXoAXw7FYXoFDG986qXZp8FSZ3tzg4H2emyBQ
         C0CPVmPO4XABuy0eZ64VftpE41h7wTckzbtxojtjWPbIxtS1lTcxjmPi7wj6yrP+MYUP
         UtIr2M2IZVDc1vgrNq6R1Fyf8AspLoiQhUSYJEbjuPnw45aFn4ZALrtOlbIFUh8iAqlu
         mUDw==
X-Forwarded-Encrypted: i=1; AJvYcCVp5NVsagHEtUXX/0OCMB4LUIwgd/ZOxnRwLZzLHEiz5DzQVs2ISLH65o+NvfydXuWmtD0Py3F5bgbSM4G3+rsOe8lKtKo6SRh176Gu
X-Gm-Message-State: AOJu0YwB1PU47hCpdmmsERRBbSzpITrNii+eaGWm1LGVkJzl36CGLpdX
	paRX2mNelCBJHNyuLb73RMn7R1x7bAShGfLOK8bUACR4RkkwuzfxnV6hmKT4KzTxeNt/CUBxUHq
	V
X-Google-Smtp-Source: AGHT+IEkOVbZUMgs8KjJIn54klAlrolAUh6zjRu2D3dQNCcUv5496n2AzBl9GvX9rDRx8tTdsQtvTw==
X-Received: by 2002:a05:6871:6001:b0:260:fc8c:2d28 with SMTP id 586e51a60fabf-264a0e0b39cmr1137866fac.22.1721861671250;
        Wed, 24 Jul 2024 15:54:31 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead874c6fsm74992b3a.165.2024.07.24.15.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 15:54:30 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 24 Jul 2024 15:54:12 -0700
Subject: [PATCH 2/2] perf: Document PERF_EVENT_IOC_SET_EVENT_LIMIT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-perf_set_event_limit-v1-2-e680c93eca55@rivosinc.com>
References: <20240724-perf_set_event_limit-v1-0-e680c93eca55@rivosinc.com>
In-Reply-To: <20240724-perf_set_event_limit-v1-0-e680c93eca55@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Atish Patra <atishp@rivosinc.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721861667; l=886;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=4M35RJ0MrhFzvtO/gpzcZAZGyvkPqgVAOXcftDMuvps=;
 b=Ft1lYHdZdmWJU19FBYN1LMTLSqpqK9Wblkotv6+rB4MEMMnCzwlA1VGTJPEZ6Ma4ZEXBf2s4b
 gWs9Eg58Rr4AyJkOjYV2FmoT85V2BsuXM+5lI0uCnMS6HfFmTK5vsvq
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Introduce PERF_EVENT_IOC_SET_EVENT_LIMIT and explain the differences
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
2.44.0


