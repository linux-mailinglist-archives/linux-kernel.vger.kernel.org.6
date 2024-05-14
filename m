Return-Path: <linux-kernel+bounces-178224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C8E8C4AAF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 02:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CDB4286E68
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 00:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88ACA15CE;
	Tue, 14 May 2024 00:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oY3KfLib"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635B61860
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 00:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715648307; cv=none; b=ZPcD4Wr7sNTEjhGjyyjUdzkytjsuaqkYfxGWiFA0Us5T/KUzQcn2wguDIIrh8hXNKK2PtA428Y5P83F87y5GYqLD0x66q7Lug7Br4tx6b+Cht+ilIeUZNBzR38iYy69Od0cDna4ihsO+XDDkAFU7hAXwXKwyqVn0MexeqBLId+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715648307; c=relaxed/simple;
	bh=1aJXaxtR743Y5B2wWmBdyGVJQ50lqnRotVWf2SJQcWE=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=QCR0s5r/PFXygAEurhAMHiA4564xsNEma1/tQj+srBxTZl+85q/gPs5GpoZtCLCgPThSNyGKVN3Te7PFaFFAXgR/xQ1dwV3DHfZUAkZ8RHv3SYxYikN7UXD6GusJnx8AVLjlWmdMCf2PurxYYEOSHXh3aWcO5e9cLpAHP9VQqEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oY3KfLib; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de61a10141fso6726014276.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 17:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715648305; x=1716253105; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s2sukg1GCI2hJZTn42HZ21UbBfW3BzwbxeWrkeRgvm0=;
        b=oY3KfLib6Fw3cbz0cUIrGb/Y/EUDGhuwXsaakVu2rigI43QgAFzX7Gk/z7U7zlyPUJ
         RonUSWQumII0GCb4U3stbZYgb3T4Y65ayCVzaZRKHZirO3UwjFFc00LbCoKhP6zlKbkU
         +ilH23GIHoqWWNRMvub2nQ5cNsmA8Z6fJc/gyv/D///7H3kb4qLZlmNtsTAtE3Q80kps
         v1j04nsDjfVFxeXowpIsach5aHVUq1Dfj3htKDf3d+eic3VVwz//8RjvypvnRk/qir+0
         RldJIwC9nDr0d97wNP5ys7e1HNvUSuqkVmLmfggSn5CCAshari5WrQZMbziBYXiuS/js
         15HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715648305; x=1716253105;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s2sukg1GCI2hJZTn42HZ21UbBfW3BzwbxeWrkeRgvm0=;
        b=gN5BJTaPY5iUWJTCFBhQe+eE0j8OHKZtp6JJbYtD6qHHXJRB+jNpp7e5q6JflMVaHG
         Ghze+rnh1ECg94R60Y5nvX3zsRjap+E2uj6VF15BYlRb7iElF6LbMjdFtnu50bwZkzxw
         Z6oAj6cChgdG9aushDLj0RNqS7HOTUdxV7Sn01h7ROKNh2GLOUS6t7OzT5WI4ffIiErS
         mQqSYQqW8W6Vkxu+k9Nftvh9Ze7kXSTN+ACU8+3Hw6fNYv5w+FCnw72E+koUDZzczrhV
         BOp82bk49FvIkk15Jokb7lMZH946vfBCTgnWOJwz2G3EXiQb1summSaOSWW6f+k/Y0Wq
         /ORQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRTu0vDz2Ox8ZCxQ9Oog5Bo02PXAjtKQ3TF9yAYffpmMeH51PTUyPgRuG2eddpSn6sqzRj6S6+hD1DJEQS+LJhT5dF6DaTJf/NdB5g
X-Gm-Message-State: AOJu0Ywf+CaXYmdRDKwoYVvVdDjaiaq4MB3x0tA879rsZgvM1NSD21AR
	HA5//VA65eXH9OEv3pkijSZtumHmNjzMrdY+bHevQKNV0pReot9rmzXzfHVhk7itlqFfGQ5Cmiu
	TSLsmKA==
X-Google-Smtp-Source: AGHT+IE3Qo2riARh11Xyb99Kg7W53h01T1aY8FeLCppXhR7pjJUuLClid4ORP2BqinJmJiPrlX4wHcGhjCZ4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6e66:3031:b400:2dc8])
 (user=irogers job=sendgmr) by 2002:a25:8d03:0:b0:de5:1ea2:fc75 with SMTP id
 3f1490d57ef6-dee4f2deb83mr871815276.7.1715648305354; Mon, 13 May 2024
 17:58:25 -0700 (PDT)
Date: Mon, 13 May 2024 17:58:17 -0700
Message-Id: <20240514005817.2902473-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [RFC PATCH v1] perf Documentation: Describe the PMU naming convention
From: Ian Rogers <irogers@google.com>
To: Randy Dunlap <rdunlap@infradead.org>, Tuan Phan <tuanphan@os.amperecomputing.com>, 
	Robin Murphy <robin.murphy@arm.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Bhaskara Budiredla <bbudiredla@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

It is an existing convention to use suffixes with PMU names. Try to
capture that convention so that future PMU devices may adhere to it.

The name of the file and date within the file try to follow existing
conventions, particularly sysfs-bus-event_source-devices-events.
---
 .../testing/sysfs-bus-event_source-devices    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices b/Documentation/ABI/testing/sysfs-bus-event_source-devices
new file mode 100644
index 000000000000..3f7e53e82de7
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices
@@ -0,0 +1,24 @@
+What: /sys/bus/event_source/devices/<pmu>
+Date: 2014/02/24
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:	Performance Monitoring Unit (<pmu>)
+
+		Each <pmu> directory, for a PMU device, is a name
+		optionally followed by an underscore and then either a
+		decimal or hexadecimal number. For example, cpu is a
+		PMU name without a suffix as is intel_bts,
+		uncore_imc_0 is a PMU name with a 0 numeric suffix,
+		ddr_pmu_87e1b0000000 is a PMU name with a hex
+		suffix. The hex suffix must be more than two
+		characters long to avoid ambiguity with PMUs like the
+		S390 cpum_cf.
+
+		Tools can treat PMUs with the same name that differ by
+		suffix as instances of the same PMU for the sake of,
+		for example, opening an event. For example, the PMUs
+		uncore_imc_free_running_0 and
+		uncore_imc_free_running_1 have an event data_read,
+		opening the data_read event on a PMU specified as
+		uncore_imc_free_running should be treated as opening
+		the data_read event on PMU uncore_imc_free_running_0
+		and PMU uncore_imc_free_running_1.
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


