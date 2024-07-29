Return-Path: <linux-kernel+bounces-266553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC8694018D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 01:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 851162835FD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 23:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D7B18FC66;
	Mon, 29 Jul 2024 23:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="cIQmsoZk"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B5618F2F0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 23:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722294667; cv=none; b=eKTV/22F2d34KhcAh8tXZWcylYrFJekhIdztnTQChVHt6laPPUfidYN3KrTwkke5ayanaIUJ/Lagwb64GmpcsTJvjQ9aj3NPY88rzUJ0Lv0BfqWcy295xGwokZSig/0mU2EsyGyXK0LdHB2O5/L5XotiC9lZ6CRvfyjRvrIiFG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722294667; c=relaxed/simple;
	bh=5HHOtQIso9qtWjfwf6FJh2CMKju6bDNni/rw1/SKRoc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Q9iebRP/0CGZ217nbfdQnUlEB8tJyhOVCLqPrVq2ueSnF+NsdA40gaTfsKj4IelGeLUx+TK/i5dq2RU85m8dYPmqaEQuzEKEAOriQAcSyRCz9f7FLnixLV9UFPj+8vfQqYrhlUmvvmfBXftRWQV3H0uK2F5OPxSD/wX1jjuG6QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=cIQmsoZk; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-260e12aac26so2858164fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722294665; x=1722899465; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Kq2aqigLfOIOLKw3DvfLTvrf9ebVnlwFLXvqIP00zA=;
        b=cIQmsoZkwJazUnmph2u99p27cOkIrrIiOY658NaLjfAhZ/xIsN4Fg6I8wLPk9gwC0F
         Rs7ohIuWujRHPZM8vUSJWbRJtBK7ixaHNeTLjh8A+IHbrN5aE6+QbOdyEmzUKZKeNPeT
         xPBIDXQGaDaPpHc1mzkDo4lCzJpj1Uj6Fyx5Zdlo7Li4D1swGO75JJW0MGVm2CoQGXNl
         si90HDUgjCy4uSzqE4TwOSqe6JqxAVuMDi7L2wd4DsJ+PMPb5fgPTf7bjJu+88+G17mG
         1o1zf9oCEF7YjcYRY4tfuT47eaJIzTDCiZVKoBUfwtnn30DdlYkGmYN5yQBKmLte+LTP
         UaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722294665; x=1722899465;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Kq2aqigLfOIOLKw3DvfLTvrf9ebVnlwFLXvqIP00zA=;
        b=FaQ00TX7QR45fUleZzcvx08dFUisT7gde6oaf7rQZ9jrjlD5ZGu2YCvrkV+yGWMIsU
         TYwsAdIHm7SkCe3pmPemMdF9qci86rPa+X7vrAMZd+mVbWYVCiuiDcGqbqhLzL3YwMjQ
         42KPsl8A+uAU1/xcPmXZFS8mjI5vd0pN8zrp3VrQ1rz0gifO+SW70kROLWpt0hVhzmF0
         eG5Cs8RzrcYg5b/t9vijiopKrlk1j8Bnp/FzH7FmEIouA2liDlteIgxGPwQ0Mb00TYAg
         V59ujYmgTqb4NhV4g6lfjmQDi7MEw4WR84bC0RFZtAfZx2h3r2hoRxU2D8hZ/ZzKlVEI
         dkGw==
X-Gm-Message-State: AOJu0YwV4gtl2um7GeAxHKrDvAOm7+fL6prU4RsHV6+bnrONv/YaChjR
	9B1x8iHrpRPCUCO/ucf8q74BKhaXPIU4clW8VfVLHXuOu8q7LLlCp1/Jk+dp+I4L0Th+4fsEpvc
	C
X-Google-Smtp-Source: AGHT+IGVjl/yM957QxIvLIkxsZNfZeWQKhKMrBsGgDcXMwFFnSfipbM0NLq25wywYQ45nmmiDSP+JQ==
X-Received: by 2002:a05:6871:3384:b0:261:1eb4:dd7e with SMTP id 586e51a60fabf-267d4d16846mr10827646fac.2.1722294664783;
        Mon, 29 Jul 2024 16:11:04 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead72ba2csm7558919b3a.93.2024.07.29.16.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 16:11:04 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 29 Jul 2024 16:11:02 -0700
Subject: [PATCH] libperf: Add gitignore
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-libperf_gitignore-v1-1-1c70dd98edf9@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAIUhqGYC/x3MTQqAIBBA4avIrBNKin6uEhGZow2EyRgRiHdPW
 n6L9xJEZMIIk0jA+FCkyxc0lYD92LxDSaYYVK3aulejPEkHZLs6usn5i1FiN5hR91Z3jYHSBUZ
 L7/+cl5w/u5juM2MAAAA=
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722294663; l=618;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=5HHOtQIso9qtWjfwf6FJh2CMKju6bDNni/rw1/SKRoc=;
 b=DwvByIRDgyAFj0qhuwRS8O42MNVSIXMojZdsJN8l/DW3DXVf2LxIaBK449Pbd22gHagOoMFT9
 h3/IZuCdnw3DXsFXDcaBmeuJIgZgHsqj+hyzie3TUpc8kms/HWzQlk7
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Ignore files that are generated by libperf and libperf tests.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/lib/perf/.gitignore | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/lib/perf/.gitignore b/tools/lib/perf/.gitignore
new file mode 100644
index 000000000000..0f5b4af63f62
--- /dev/null
+++ b/tools/lib/perf/.gitignore
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+libperf.pc
+libperf.so.*
+tests-shared
+tests-static

---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240729-libperf_gitignore-e58d9b7fb51d
-- 
- Charlie


