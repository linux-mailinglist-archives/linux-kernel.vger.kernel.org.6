Return-Path: <linux-kernel+bounces-397310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4DE9BDA4F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 01:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 656DB28534F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 00:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167144207A;
	Wed,  6 Nov 2024 00:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4eUFfcqb"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B2B1F16B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 00:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730853017; cv=none; b=SHs8OtueIW6LrQ6NJopmjQnkR7Hp0I7vfw8uNhDnbXxjj0gnOG241XQg8MF9Oqa5LMeCUQoeou6W2u1tiJPpWEmSs0rOfHmM+VgHy5Vc4TaTGJLIg/ezdC03Yd3TGQ8IJYsG1CmEOXEYjB9UHRSab8SIgBkooEQvhsmZuYw/Lxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730853017; c=relaxed/simple;
	bh=g5UOkC+QOKsPi8rYoWr9DxRcdSXdub4gIgnL6eCiAr8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jlJ3MXLJMqF/ziBsZC6BfZsNAWtzaJI9fn3z9MzNARXtU/2iVhDBC8wbYpv+RZBYpnm8ZGKkYws7W1Xu1/d2RPg5wy9OACGEd4MDKG1JJsG4WYkJU0hYipWukcm5XoknczDz/oWaH+4zfGhUO3UNjGLv3UhbhIB52T582rwcOTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4eUFfcqb; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e30cf48435fso10378724276.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 16:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730853011; x=1731457811; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xBr0xX9gpaT/nqSu7Tbbxob1cCNZEBjFx1fUb7xZh2Q=;
        b=4eUFfcqbutVnrb735XHkrJsIqq0esRfUliXrSPBSKg/wSe69vI4LLCEmkgQ15sO4cR
         sy4eBhEP/Fhab6eU0bQCUfE4qUyFUnMambr0hcgTOQM1/ktBumdXckXu/0SrJRicOpjX
         +McvVKsIRkw8qCGpyHXmGoOlze7RpPBkcvV7HsOQR9xENMJBDhVUeBiamERIfnTGKcuV
         wJGSUVeK5idYUXwyFvA7YKOSlmJVh8ZICWEO/vdiSsSwyC900EVvnR2yzA1xURGLys62
         akYNZH3EoxzNihsfC2v0bfxro31qXpNkcTmIEpICzsLEXYKMTL77U14BJ74VmpD8OuXP
         CciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730853011; x=1731457811;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xBr0xX9gpaT/nqSu7Tbbxob1cCNZEBjFx1fUb7xZh2Q=;
        b=rlkCAuvHoiCPW1VD3EnxRqxvH3T8o2AQbwsFLtC1qOqzF/Lmprjth5IhpZz0gUQR/p
         vRZrh3jLEaiPgHNu5TZHczTg9ZPnvTwZHZ2NSoFmq0HoTiNBeDIisYBfPsnr/wTED9qB
         79XDzSguqv4F6eDONIKanZwdt1C5NhtEVkCm1ZgGlKAH7dTRcb/xc1XLFET/GRUGjr3A
         Qnrv26U5CvM9lNGlx2L6Lz5VoGfqsidg4Jtbout0KqdZJApyH5E4qoOBRKpn6ix66Kqz
         6ZHY6+VwZy6My/8f/6lzp1g4PPwb2LxD0btD+LrMmFyimY1RChlH1DN+3i0uJTA6iE9f
         wkfA==
X-Gm-Message-State: AOJu0YypOmjE0PRyj7oejnVvQ6/YB2p29xir9ByKiQfvb1eltS66tE8S
	zh2QlpHtlRlbOmwz9PbRftG0IDnDPr9lMQatAN8eoVnTJlnsLL9CsOfE6GgySW1iYGT5OwQIKGa
	AXZwF9NO3YA1FRmNlknnHlnxi1PS2VYjhwC3PQChUaFjNYXBro7gY6LOLEkAziIAGoRv23Wm39x
	vXCCsRhQRdL9ZIr3B/i2iw9o739nv9yefP1ys4jzbd
X-Google-Smtp-Source: AGHT+IHEVYrnOIwcKVO6y2sG839Qj5Yb6EUo8qEZcIlOf4OqEj+odepl50hTuQFwpk2TRWJrgHlyArvnYOk=
X-Received: from colette.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:ce7])
 (user=ctshao job=sendgmr) by 2002:a25:aa66:0:b0:e29:6e61:3daf with SMTP id
 3f1490d57ef6-e30cf3e6ac7mr15820276.2.1730853010735; Tue, 05 Nov 2024 16:30:10
 -0800 (PST)
Date: Wed,  6 Nov 2024 00:30:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241106003007.2112584-1-ctshao@google.com>
Subject: [PATCH v3 1/3] perf evsel: Improve the evsel__open_strerror for EBUSY
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ze Gao <zegao2021@gmail.com>, 
	Chun-Tse Shao <ctshao@google.com>, Weilin Wang <weilin.wang@intel.com>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ian Rogers <irogers@google.com>

The existing EBUSY strerror message is:

  The sys_perf_event_open() syscall returned with 16 (Device or resource busy) for event (intel_bts//).
  "dmesg | grep -i perf" may provide additional information.

The dmesg won't be useful. What is more useful is knowing what
processes are potentially using the PMU, which some procfs scanning can
reveal. When parallel testing tests/shell/stat_all_pmu.sh this yields:

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

Which gets a little closer to finding the issue.

Signed-off-by: Ian Rogers <irogers@google.com>
Change-Id: Ie1ed8688286c44e8f44a35e98fed8be3e2a344df
---
 tools/perf/util/evsel.c | 79 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dbf9c8cee3c56..d001ecfa26bf7 100644
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
+		char buf[256];
+		DIR *fd_dir;
+		struct dirent *fd_entry;
+		int fd_dir_fd;
+
+		if (proc_entry->d_type != DT_DIR ||
+		    !isdigit(proc_entry->d_name[0]) ||
+		    strlen(proc_entry->d_name) > sizeof(buf) - 4)
+			continue;
+
+		scnprintf(buf, sizeof(buf), "%s/fd", proc_entry->d_name);
+		fd_dir_fd = openat(dirfd(proc_dir), buf, O_DIRECTORY);
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
+			link_size = readlinkat(fd_dir_fd, fd_entry->d_name, buf, sizeof(buf));
+			if (link_size < 0)
+				continue;
+			/* Take care as readlink doesn't null terminate the string. */
+			if (!strncmp(buf, "anon_inode:[perf_event]", link_size)) {
+				int cmdline_fd;
+				ssize_t cmdline_size;
+
+				scnprintf(buf, sizeof(buf), "%s/cmdline", proc_entry->d_name);
+				cmdline_fd = openat(dirfd(proc_dir), buf, O_RDONLY);
+				if (cmdline_fd == -1)
+					continue;
+				cmdline_size = read(cmdline_fd, buf, sizeof(buf) - 1);
+				close(cmdline_fd);
+				if (cmdline_size < 0)
+					continue;
+				buf[cmdline_size] = '\0';
+				for (ssize_t i = 0; i < cmdline_size; i++) {
+					if (buf[i] == '\0')
+						buf[i] = ' ';
+				}
+
+				if (printed == 0)
+					printed += scnprintf(msg, size, "Possible processes:\n");
+
+				printed += scnprintf(msg + printed, size - printed,
+						"%s %s\n", proc_entry->d_name, buf);
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
2.47.0.199.ga7371fff76-goog


