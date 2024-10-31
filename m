Return-Path: <linux-kernel+bounces-391398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E96A9B8629
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 23:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2355D1F21DD3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8129E1CDFC5;
	Thu, 31 Oct 2024 22:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I10qsQp7"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157F81953AD
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 22:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730414399; cv=none; b=rufhBWs3wjzx+p2ESKnIWBHipn/dsA3XRN+ifCRaLbyKAZS0CFV5KzNxDvTRI/bcK0ceFGiFs4O38lvB6iuCZK8WeGcqbAxaUz0/K6ifKZ8WacNOoxGpoxK52uMkYFEKpK7se6BNA0+pa2xqDlyHYgT76hs5BxtVMs5M6vofZvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730414399; c=relaxed/simple;
	bh=1K+1EzPZRuDuWAazdL34ULZOOR+K2+dU7Cnwhnj3bHc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lwDSiP2H4ET3JwxN4m5djXRst6v9OX3AOB4HZ8ttyhXuWyP3bmtUEhUruW/ex3w1qo9+NfdM9aA7sevNy5q0yMNMRwvZxvd4t73YdUwc1MQW1rDb3Z1D1ePrz7hW1H+kcp1EZshUAkek1Rb8D/2AdysgPUYpYIev2Bf8uF18R0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I10qsQp7; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-71ec3392c25so1660935b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730414393; x=1731019193; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oWSTQrojMVMrsYh9AlNbCklcB9qjvy1WDWZ7XTJeoJ8=;
        b=I10qsQp7DoG6Q+ekBVxdugZvHc7YnpitHxQNWKSlC3DV2eLdU+ySLGm49BKVuBreBT
         70tDGF871zOca2LaCRkusXQx+YnOCSkCozhF+eaTq61gCHu4Eg1rYFL2l3K/jAe730vR
         pkpelvIiNredJFxrBMXP8SFa9eihEaph19fgw9EHVftGqOM54o2nlPq4U48IRhGkWMUk
         rvpkIa3P5NKUzgpzrMFVxVbWr6snvS7EiIX4hv2U5EdASGcPjLX4/TSgfy7eMtjm00hH
         C2CRZMyhHEU5h5qrWG8INLk8+gXXE8Bu67BX0Fbu+b+oSYhLDboGmRP9PLDfXn1XjaUU
         v9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730414393; x=1731019193;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oWSTQrojMVMrsYh9AlNbCklcB9qjvy1WDWZ7XTJeoJ8=;
        b=Jikz+1FIQo+3cMqiXy13wNchwLUsLt53K9rDZvFcc55az8kMgYvp8zygoD5rQWTlu/
         nlIErGnY04D/Iwhs94/wyzfg5vvU/s/ulOcSRnblZaj0ADmyMhCeLtSGwAhhgyk06Rg0
         EOEtbgDC2mOH4BUP3mgHzCaxsElGflkvuNt6lwlsCiPN8PQoEg8mXVe2NkBVCpF4J8QS
         YGRs+I2bXkN08UnfXj70SZ4j1RXvwOS1T6RteV6s9KrJlGQY7op0zEaAWJ6CB0Cm4BP8
         SxKAwi7/HgvQcZXfmPYXPsYl+CSL+juJerY852/Raz7N84nPw2QbMk7gAb2iKM8RxhyV
         q+NQ==
X-Gm-Message-State: AOJu0YyrhHNCH9OkR//67Y6Ae2/hnxVW2B6ecy8XKW85zXj3PCOR7ex7
	pttLn9cau7fXS7IUV1KsQ1hhIHs29FNOCePtmN1PIh1npzsjiiHPmKcpS52Tvya854TG3A2ZDrB
	7/8ReLW+0mLbEHF66Cayp5bC6SVUkl5jVXFGIwCWpWuIfIJ2OsorqnE2O86qb5Yj1R8DYyhOnVw
	QBSubp5NPmU9vjhYfVhljF5fiuEVYV5cNLYWY2ShNM
X-Google-Smtp-Source: AGHT+IE1yDy5/ekyNCt0cQuTHC9rjP5gdZ1iZnN2zHSFuCpS1ZZd2YFR1tYEu2/RWRUTfDsD7/TNpoJ0RIA=
X-Received: from colette.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:ce7])
 (user=ctshao job=sendgmr) by 2002:aa7:8758:0:b0:71e:5261:b156 with SMTP id
 d2e1a72fcca58-720c98a1a74mr2554b3a.2.1730414391614; Thu, 31 Oct 2024 15:39:51
 -0700 (PDT)
Date: Thu, 31 Oct 2024 22:39:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241031223948.4179222-1-ctshao@google.com>
Subject: [PATCH 1/3] perf evsel: Improve the evsel__open_strerror for EBUSY
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, Ze Gao <zegao2021@gmail.com>, 
	Chun-Tse Shao <ctshao@google.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ian Rogers <irogers@google.com>

The existing EBUSY strerror message is:
```
The sys_perf_event_open() syscall returned with 16 (Device or resource busy) for event (intel_bts//).
"dmesg | grep -i perf" may provide additional information.
```
The dmesg won't be useful. What is more useful is knowing what
processes are potentially using the PMU, which some procfs scanning can
reveal. When parallel testing tests/shell/stat_all_pmu.sh this yields:
```
Testing intel_bts//
Error:
The PMU intel_bts counters are busy and in use by another process.
Possible processes:
2585882 perf list
2585902 perf list -j -o /tmp/__perf_test.list_output.json.KF9MY
2585904 perf list
2585911 perf record -e task-clock --filter period > 1 -o /dev/null --quiet true
2585912 perf list
2585915 perf list
2586042 /tmp/perf/perf record -asdg -e cpu-clock -o /tmp/perftool-testsuite_report.dIF/perf_report/perf.data -- sleep 2
2589078 perf record -g -e task-clock:u -o - perf test -w noploop
2589148 /tmp/perf/perf record --control=fifo:control,ack -e cpu-clock -m 1 sleep 10
2589379 perf --buildid-dir /tmp/perf.debug.Umx record --buildid-all -o /tmp/perf.data.YBm /tmp/perf.ex.MD5.ZQW
2589568 perf record -o /tmp/__perf_test.program.mtcZH/perf.data --branch-filter any,save_type,u -- perf test -w brstack
2589649 perf record --per-thread -o /tmp/__perf_test.perf.data.5d3dc perf test -w thloop
2589898 perf record -o /tmp/perf-test-script.BX2b27Dcnj/pp-perf.data --sample-cpu uname
```
Which gets a little closer to finding the issue.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 79 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dbf9c8cee3c56..9a5b6a6f8d2e5 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3286,6 +3286,78 @@ static bool find_process(const char *name)
 	return ret ? false : true;
 }

+static int dump_perf_event_processes(char *msg, size_t size)
+{
+	DIR *proc_dir;
+	struct dirent *proc_entry;
+	int printed = 0;
+
+	proc_dir = opendir(procfs__mountpoint());
+	if (!proc_dir)
+		return 0;
+
+	/* Walk through the /proc directory. */
+	while ((proc_entry = readdir(proc_dir)) != NULL) {
+		char path[PATH_MAX];
+		DIR *fd_dir;
+		struct dirent *fd_entry;
+		int fd_dir_fd;
+
+		if ((proc_entry->d_type != DT_DIR) ||
+		     !strcmp(".", proc_entry->d_name) ||
+		     !strcmp("..", proc_entry->d_name))
+			continue;
+
+		scnprintf(path, sizeof(path), "%s/fd", proc_entry->d_name);
+		fd_dir_fd = openat(dirfd(proc_dir), path, O_DIRECTORY);
+		if (fd_dir_fd == -1)
+			continue;
+		fd_dir = fdopendir(fd_dir_fd);
+		if (!fd_dir) {
+			close(fd_dir_fd);
+			continue;
+		}
+		while ((fd_entry = readdir(fd_dir)) != NULL) {
+			ssize_t link_size;
+
+			if (fd_entry->d_type != DT_LNK)
+				continue;
+			link_size = readlinkat(fd_dir_fd, fd_entry->d_name, path, sizeof(path));
+			if (link_size < 0)
+				continue;
+			/* Take care as readlink doesn't null terminate the string. */
+			if (!strncmp(path, "anon_inode:[perf_event]", link_size)) {
+				int cmdline_fd;
+				ssize_t cmdline_size;
+
+				scnprintf(path, sizeof(path), "%s/cmdline", proc_entry->d_name);
+				cmdline_fd = openat(dirfd(proc_dir), path, O_RDONLY);
+				if (cmdline_fd == -1)
+					continue;
+				cmdline_size = read(cmdline_fd, path, sizeof(path) - 1);
+				close(cmdline_fd);
+				if (cmdline_size < 0)
+					continue;
+				path[cmdline_size] = '\0';
+				for (ssize_t i = 0; i < cmdline_size; i++) {
+					if (path[i] == '\0')
+						path[i] = ' ';
+				}
+
+				if (printed == 0)
+					printed += scnprintf(msg, size, "Possible processes:\n");
+
+				printed += scnprintf(msg + printed, size - printed,
+						"%s %s\n", proc_entry->d_name, path);
+				break;
+			}
+		}
+		closedir(fd_dir);
+	}
+	closedir(proc_dir);
+	return printed;
+}
+
 int __weak arch_evsel__open_strerror(struct evsel *evsel __maybe_unused,
 				     char *msg __maybe_unused,
 				     size_t size __maybe_unused)
@@ -3319,7 +3391,7 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			printed += scnprintf(msg, size,
 				"No permission to enable %s event.\n\n", evsel__name(evsel));

-		return scnprintf(msg + printed, size - printed,
+		return printed + scnprintf(msg + printed, size - printed,
 		 "Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open\n"
 		 "access to performance monitoring and observability operations for processes\n"
 		 "without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Linux capability.\n"
@@ -3382,6 +3454,11 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			return scnprintf(msg, size,
 	"The PMU counters are busy/taken by another profiler.\n"
 	"We found oprofile daemon running, please stop it and try again.");
+		printed += scnprintf(
+			msg, size,
+			"The PMU %s counters are busy and in use by another process.\n",
+			evsel->pmu ? evsel->pmu->name : "");
+		return printed + dump_perf_event_processes(msg + printed, size - printed);
 		break;
 	case EINVAL:
 		if (evsel->core.attr.sample_type & PERF_SAMPLE_CODE_PAGE_SIZE && perf_missing_features.code_page_size)
--
2.47.0.163.g1226f6d8fa-goog


