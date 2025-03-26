Return-Path: <linux-kernel+bounces-576462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A46FA70FAD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 04:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA44C1730F5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 03:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B6116C69F;
	Wed, 26 Mar 2025 03:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z3YUBf9w"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353F1185920
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 03:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742961076; cv=none; b=YH6Oyy5t8/iEBTRED7qfxHA00E8n/QhphsIcz4oMnE0X9Xu0x8oSazmfj/l8NoYpkLi8MpU2jlZegvCjq3xzjEZKIK3LHoysMPiJAoIB956FNimaur9ODi5JlCdTC1Z4nXmAEPK5t8ScveW87DGyPLVJ6mCBSboHZQv25M7HtBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742961076; c=relaxed/simple;
	bh=x9WzSkt15367O1g9MyuIlk/pYCokLWkTCrAxR8G2AK4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R54hBOaEaWPanGpZax8NNRrp9HkQr5B6xaInfoYoPtzelKtrByjUCHWgrgHS/fXJyJyq6bJfKDz0HXnL62QH6Tlp+KjA4tZqNz+hWu4EatRMxMTDGGTp81IgJV0k087u1O/fxnc4Kow/XA93aKnwjCxK2CkAw78k+fyzwz96Nt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z3YUBf9w; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2242f3fd213so100264355ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 20:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742961074; x=1743565874; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ctVsz7hgWpIU/uH3VF5e2aMQbQTrsjnfwBUoye3blFY=;
        b=Z3YUBf9wvuiAEOasRR3uljAmbTAUq66iDM162PqykaM3A9uiMHOfPOyR4z7OIOawAh
         EEbtk217oJJidcKO7n+ouk/b21atcdK1zIc5PbupAmU8rYxrI77N9KkR7iWH3TENxrdm
         cBUex3eMjPO0D0L3HwxlZC4t9M7bswIe8AAC/4po763mCntP3HdkViI8pjhqLqzdSEkv
         kiKlOuK1A7OtqmedLkG5ORqyfbj0ZxR2V8kG7A8WwvqRhfd5Zrj7GtYZ9V27ysgdJkk7
         3a9Kx/TW0oWh2+Bn4wAvb/CsUsrXzRugFhOGjdORjTgFfQeUVeBTpy+89NENRdVfumlC
         5UVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742961074; x=1743565874;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ctVsz7hgWpIU/uH3VF5e2aMQbQTrsjnfwBUoye3blFY=;
        b=MnMDJdtAmQ2QtjcIhi9ywbQV6XSQ5qZTSQ0STkPnN5r77QCce3bDwIENnW55LfFXor
         dpXebJMTpEE5b/8mavuivJn5TDnj1K3kMLqqMVTq409nB/DpIOtJb7jViBMJ+bhOTIR4
         706RVLvZLR+1aVMz1zhol14DcmEkljo+XUZXQfofv3A4VjxzlBUXn/mEy1iutmYVRI0P
         FBkS6XdiUiY+hZclyhPEwobuSyUJaiR8U0XF24/gH396p4wkI23gG6ZYaXqAnBIPb5qd
         AUwmlkz0usys6upwLnE+uE6xSyKp7ge0Zn6QumkIV0N8KxAwZN1kokLjUwbszsRxJVwa
         5JtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4woepN9Mcfiq0MVkxDeohb8GBHh4nY2anmFLsJVvh9shj6RxAMWqhqSpFyJR2hSW9ul1caWAI2VXVtwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBhyU4uv/siX4zdBW8W5RwyuCW48X2bEyVMtWX8o4fqYxbbSKT
	+vKeCRpJqpLatKEdDMYkKaUlAn4WvCOUohn1so1gmP0h1ojRv4z/NicNCHDzEdaBIXKf2jBNmeW
	uUpLZ7g==
X-Google-Smtp-Source: AGHT+IFuIYPt5fZK8YyYW50wNwsUW0E0QHMb5IXd5j8+kU/hV6iPRt1mTz1isNYFhwUfLx1ZPXqwltN8EATv
X-Received: from pffx4.prod.google.com ([2002:aa7:93a4:0:b0:736:47b8:9b89])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:888a:0:b0:736:3c2f:acdd
 with SMTP id d2e1a72fcca58-739059c1873mr29119546b3a.14.1742961074328; Tue, 25
 Mar 2025 20:51:14 -0700 (PDT)
Date: Tue, 25 Mar 2025 20:50:45 -0700
In-Reply-To: <20250326035045.129440-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250326035045.129440-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250326035045.129440-5-irogers@google.com>
Subject: [PATCH v2 4/4] perf tests: Add a DRM PMU test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, Junhao He <hejunhao3@huawei.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

The test opens any DRM devices so that the shell has fdinfo files
containing the DRM data. The test then uses perf stat to make sure the
events can be read.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/drm_pmu.sh | 77 +++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100755 tools/perf/tests/shell/drm_pmu.sh

diff --git a/tools/perf/tests/shell/drm_pmu.sh b/tools/perf/tests/shell/drm_pmu.sh
new file mode 100755
index 000000000000..55477603a80f
--- /dev/null
+++ b/tools/perf/tests/shell/drm_pmu.sh
@@ -0,0 +1,77 @@
+#!/bin/bash
+# DRM PMU
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+output=$(mktemp /tmp/perf.drm_pmu.XXXXXX.txt)
+
+cleanup() {
+  rm -f "${output}"
+
+  trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+  echo "Unexpected signal in ${FUNCNAME[1]}"
+  cleanup
+  exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+# Array to store file descriptors and device names
+declare -A device_fds
+
+# Open all devices and store file descriptors. Opening the device will create a
+# /proc/$$/fdinfo file containing the DRM statistics.
+fd_count=3 # Start with file descriptor 3
+for device in /dev/dri/*
+do
+  if [[ ! -c "$device" ]]
+  then
+    continue
+  fi
+  major=$(stat -c "%Hr" "$device")
+  if [[ "$major" != 226 ]]
+  then
+    continue
+  fi
+  echo "Opening $device"
+  eval "exec $fd_count<\"$device\""
+  echo "fdinfo for: $device (FD: $fd_count)"
+  cat "/proc/$$/fdinfo/$fd_count"
+  echo
+  device_fds["$device"]="$fd_count"
+  fd_count=$((fd_count + 1))
+done
+
+if [[ ${#device_fds[@]} -eq 0 ]]
+then
+  echo "No DRM devices found [Skip]"
+  exit 2
+fi
+
+# For each DRM event
+err=0
+for p in $(perf list --raw-dump drm-)
+do
+  echo -n "Testing perf stat of $p. "
+  perf stat -e "$p" --pid=$$ true > "$output" 2>&1
+  if ! grep -q "$p" "$output"
+  then
+    echo "Missing DRM event in: [Failed]"
+    cat "$output"
+    err=1
+  else
+    echo "[OK]"
+  fi
+done
+
+# Close all file descriptors
+for fd in "${device_fds[@]}"; do
+  eval "exec $fd<&-"
+done
+
+# Finished
+cleanup
+exit $err
-- 
2.49.0.395.g12beb8f557-goog


