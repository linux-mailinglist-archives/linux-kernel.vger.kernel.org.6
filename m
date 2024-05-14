Return-Path: <linux-kernel+bounces-178325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4A78C4BF2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 07:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5A2FB22826
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 05:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C4E1802E;
	Tue, 14 May 2024 05:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4DQzo5I4"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EC7171AB
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 05:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715664253; cv=none; b=HuwY2OqxSMMmdt1xYu9Jid++mOEL9U3PPWgRg/WfKO5RrOAqwnlk43xonlfKdsxYl9A+ntZrtXZJ4J8uu8lKHQG3HP7dOy5EmOG/7dCkEoMOOME8ULZ3u0MOfsBpe91tOZcNSN9KCPIHFBod77ZP8kEvtHHDb5HV2U0AACUnIaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715664253; c=relaxed/simple;
	bh=xYjH557dYWB2d8/5HQKZEVQpIIfcAGTGYy+PxA0o/vE=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=qjqurq1q7RxeT8xaWmlsmtcUrUMUQwQVR6fJBHtv/wkKorj5BdKX/Hd5fdzIl5F0Rll8STu9cYki6WbHabVWHhe8sk4Iu0FFYwkfLP3flJw8C5nDC6R/XFHpAbC7gLamxVecJZLV0njj6KBjOoUT/Jm3Gh04e4B7Nb4oxn1qNFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4DQzo5I4; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de8b6847956so8683082276.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 22:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715664250; x=1716269050; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hRn+JnVwl6IEnu61W6Gn+QDoOOES1k1Rqc3j0WDLThg=;
        b=4DQzo5I4bDmCzxGu1Nm+VFbLG1romp/CVgwP5cV32jMM5N1RTCUdIxtH0BBEXmgMEA
         iwKEoeVuAykXcXRBVrrTVAdl91QAVjKYv09ckXxynhmyBxJgn0oL2GS8wzMBkXh4E0CS
         RjUTqm8jwkEjmeu8baBUXdGsOb6mHQMMNQIKxKoEZZ+iRYh0xxGcLK2SBBm+uhJELZGJ
         hDfjwMyQP+taQaoJ1KdgFRFnCCoDb//MSiTtQv5Ld6O20cTP55hLeVLNS7ttFFKwDg7z
         NFD7Pw8HOoXlBskBNKPlIc2K2gKr75PBfMIhXCTFagA4ghv3MzSoe1j251BlHoq2oI73
         gmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715664250; x=1716269050;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hRn+JnVwl6IEnu61W6Gn+QDoOOES1k1Rqc3j0WDLThg=;
        b=fiJFRHzRQYFycXWNXMeG1SuW8TAq6x4VtYNQu9oNEndQdPHNVEIldI6LeQQDoEkv0l
         HNpNEzGYm35kNK9hePEYrpDXcGhOT2uASUCpK6idB+sYJdkvYcy8s7fPFsFmLAkL1S0v
         R1o99Vb4MOAX8LQkJo7S4PCzmwD+K+Oc8PMTfLuo0KnBujB6X8E3CssgYg9OEPnB5aBL
         cPDdUwhd4n0vll8SXEQMhE8Cf/VinUdNgX0a2iJTchvF5vwWgtZh0Nb1c4k0g94ClxL1
         /CduBF1HmUGHKN3pZJr0+GdvRsCezjUc8bBqWbnlOzh1EVUIxSEGXFZm9Cf8pjO6Eg3L
         9vtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXf8CZ/4Q1vchl2wg2RWBXk2UZG3OfOVNVS0+k1Fku7PKVvgsAx/YdQ/lAvr4Qxw95ERpn3ilyTa9qgCzE8ZqkvuDtx6kVoKPf8pbx4
X-Gm-Message-State: AOJu0YzAdIu4DhqoJjhZ1t/Rwx/n1+7hxF3rLxCd/rIVoxSJsGfD+3Y7
	XhJ1I9QI+JWBVEpa9PkkMXUMKQ3WlHTiMoEdIUWq3fsLsDxG9OXX1us7uMaP7DxKYwG21XOxf/C
	faa9E1A==
X-Google-Smtp-Source: AGHT+IG4VRGn/GKcVi3X2Zn45IYZUTpeS6Y/zFvj6MaqetVuFKTdhDz4pFXbcXfO8FwrUYoTqi6n67cjD3LS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6e66:3031:b400:2dc8])
 (user=irogers job=sendgmr) by 2002:a05:6902:c0e:b0:dda:c4ec:7db5 with SMTP id
 3f1490d57ef6-dee4e57a059mr3480030276.4.1715664250139; Mon, 13 May 2024
 22:24:10 -0700 (PDT)
Date: Mon, 13 May 2024 22:24:02 -0700
Message-Id: <20240514052402.3031871-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1] perf arm-spe: Unaligned pointer work around
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Use get_unaligned_leXX instead of leXX_to_cpu to handle unaligned
pointers. Such pointers occur with libFuzzer testing.

A similar change for intel-pt was done in:
https://lore.kernel.org/r/20231005190451.175568-6-adrian.hunter@intel.com

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 23 ++++---------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index a454c6737563..7bf607d0f6d8 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -10,24 +10,11 @@
 #include <byteswap.h>
 #include <linux/bitops.h>
 #include <stdarg.h>
+#include <linux/kernel.h>
+#include <asm-generic/unaligned.h>
 
 #include "arm-spe-pkt-decoder.h"
 
-#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
-#define le16_to_cpu bswap_16
-#define le32_to_cpu bswap_32
-#define le64_to_cpu bswap_64
-#define memcpy_le64(d, s, n) do { \
-	memcpy((d), (s), (n));    \
-	*(d) = le64_to_cpu(*(d)); \
-} while (0)
-#else
-#define le16_to_cpu
-#define le32_to_cpu
-#define le64_to_cpu
-#define memcpy_le64 memcpy
-#endif
-
 static const char * const arm_spe_packet_name[] = {
 	[ARM_SPE_PAD]		= "PAD",
 	[ARM_SPE_END]		= "END",
@@ -70,9 +57,9 @@ static int arm_spe_get_payload(const unsigned char *buf, size_t len,
 
 	switch (payload_len) {
 	case 1: packet->payload = *(uint8_t *)buf; break;
-	case 2: packet->payload = le16_to_cpu(*(uint16_t *)buf); break;
-	case 4: packet->payload = le32_to_cpu(*(uint32_t *)buf); break;
-	case 8: packet->payload = le64_to_cpu(*(uint64_t *)buf); break;
+	case 2: packet->payload = get_unaligned_le16(buf); break;
+	case 4: packet->payload = get_unaligned_le32(buf); break;
+	case 8: packet->payload = get_unaligned_le64(buf); break;
 	default: return ARM_SPE_BAD_PACKET;
 	}
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


