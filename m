Return-Path: <linux-kernel+bounces-307161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C78A96495B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3597A284D63
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29561B29CD;
	Thu, 29 Aug 2024 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2fagBM+X"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FED01B29AA
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943738; cv=none; b=Qzw7M7fdVQKJhbj1SAV7fZDQu1ucW/7ca+pt78slNlr2AnsBOgkkbZFyei0e0pcrMn9PQdATElwjmYxxuFwQ2jiYmtwDNxUcOyaVHy3oSMefdaFLSXXPuy6IGAVvfYcTH+Af6nS99Nf5YTnOpxCAkn0ofKAs665xRTqbMh/oy1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943738; c=relaxed/simple;
	bh=YbH/w7Q2IRfQc3HCYtBu77nA+Z23ro96SsDZawy8A6g=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Rn4jKwzDeHErNAmWjlLUFdQqak5lp43g1TNrkQW+TBFUeJQyokwrAqUNwwIEev1LeCc/40uf6o11eIRJ70p/UQLreF0Y6o2cXfoI22CcIKk3koSN68MRigkKTuaPiBPCuP0nh0yEHIrrYviHISEh1M/A1G7rorByyQeuvxHjPqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2fagBM+X; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02b5792baaso1241467276.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724943736; x=1725548536; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=26cUqoseK8PMtNLolCaTO1poipR4Q8jBH4RycCyqvMg=;
        b=2fagBM+XR4Ww+O1YYXwhVI76KAvuOv6sfbToDAGfIN6IBBx2TFXSpSnFtwfSh2004P
         HKDya02j0zajeZhe8cKgXzY2T7UN/KucVGKll7+BYD1hbEOyN3aT57IwrX76abt7w17J
         8IQUmQrw/7Ekm8R9KqTjxw6/a2EzQy36SUZJt4KkvDPUelCQS6Kw8A7v6jiYa3MuGCwM
         v2u5TD4fNPrHAlGsy4ahD+581geDoC/6AWXQ22vJTafgA3cXv5+NeU9xw84A8izYVmZr
         nvAN89cF8SNdTMeyh/IPAfu6mSEsqEkR7vcF3PIR9S7GqvTnrHtgiWLRJwhzqjQ/HE13
         SCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724943736; x=1725548536;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=26cUqoseK8PMtNLolCaTO1poipR4Q8jBH4RycCyqvMg=;
        b=CP8NAc9AmDhM5kKMz6Gtaa5SaP67qmJ0sPnKEET6dPb86uCVnvb9jt9CWAszT69anJ
         fETLg3r9dRirOg5ufgDEXt8UOF3A0sTSNZQtf3Ur0t7inJZtaIvRJctexrw3GlewVeJy
         nFKlERZYMg77YcBiynnG0+p60AvyLfycWFBP2L6WRstOrc96GplFcpWsY0UN+2DXeApC
         7hQmly2clOHCT/qBvqfooNBQI24Q9TdtjbTGaYKB6bbMGHDfs219wEAJnybDoqaNOW40
         aTD6o2sA2gIONy15TstYZ4HlO/F5pCDQt3vO/I/OYl4thnEsC4cbIS87tgvyrihGMfAD
         XXmg==
X-Forwarded-Encrypted: i=1; AJvYcCURQOEb6KORBp3WVwDMnTUnQ9cjACYVhMD383igyAIt3Omugqy58aj+qDtMWSfrVLI9RySuzyjfvI6j3a4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk2D9SyPIN0YaWaV3n0PjhMcH/Ok3HSPwsT63Jl+nDSY9soe0x
	rF4w8kDI/i7hfWy0HLzzc+krIevjz81Nh5Nr0uyxa3pgdG4ova77RKwUB3L9RkS9D6DLRcmhb9n
	bVP6QFA==
X-Google-Smtp-Source: AGHT+IE5Puj8WGaPepDdvNVYEm+iM1nKWd1L3XPtWu5Ysb0Sv/gFkGsoPfS165yMmxR1Go63SQBsjBYpq0qu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e51a:f73b:d117:cb13])
 (user=irogers job=sendgmr) by 2002:a25:8489:0:b0:e11:584f:c2ca with SMTP id
 3f1490d57ef6-e1a5ac86f68mr33881276.6.1724943735472; Thu, 29 Aug 2024 08:02:15
 -0700 (PDT)
Date: Thu, 29 Aug 2024 08:01:48 -0700
In-Reply-To: <20240829150154.37929-1-irogers@google.com>
Message-Id: <20240829150154.37929-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240829150154.37929-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Subject: [PATCH v1 2/8] perf session: Document struct and constify auxtrace
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nick Terrell <terrelln@fb.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Yicong Yang <yangyicong@hisilicon.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

perf_session is a central data structure to the tool so let's comment
it. The auxtrace callbacks are never modified in session so constify.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/session.h | 48 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index 7c8dd6956330..e56518639711 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -26,26 +26,72 @@ struct decomp_data {
 	struct zstd_data *zstd_decomp;
 };
 
+/**
+ * struct perf_session- A Perf session holds the main state when the program is
+ * working with live perf events or reading data from an input file.
+ *
+ * The rough organization of a perf_session is:
+ * ```
+ * +--------------+           +-----------+           +------------+
+ * |   Session    |1..* ----->|  Machine  |1..* ----->|   Thread   |
+ * +--------------+           +-----------+           +------------+
+ * ```
+ */
 struct perf_session {
+	/**
+	 * @header: The read version of a perf_file_header, or captures global
+	 * information from a live session.
+	 */
 	struct perf_header	header;
+	/** @machines: Machines within the session a host and 0 or more guests. */
 	struct machines		machines;
+	/** @evlist: List of evsels/events of the session. */
 	struct evlist	*evlist;
-	struct auxtrace		*auxtrace;
+	/** @auxtrace: callbacks to allow AUX area data decoding. */
+	const struct auxtrace	*auxtrace;
+	/** @itrace_synth_opts: AUX area tracing synthesis options. */
 	struct itrace_synth_opts *itrace_synth_opts;
+	/** @auxtrace_index: index of AUX area tracing events within a perf.data file. */
 	struct list_head	auxtrace_index;
 #ifdef HAVE_LIBTRACEEVENT
+	/** @tevent: handles for libtraceevent and plugins. */
 	struct trace_event	tevent;
 #endif
+	/** @time_conv: Holds contents of last PERF_RECORD_TIME_CONV event. */
 	struct perf_record_time_conv	time_conv;
+	/**
+	 * @repipe: When set causes certain reading (header and trace events) to
+	 * also write events. The written file descriptor must be provided for
+	 * the header but is implicitly stdout for trace events.
+	 */
 	bool			repipe;
+	/**
+	 * @one_mmap: The reader will use a single mmap by default. There may be
+	 * multiple data files in particular for aux events. If this is true
+	 * then the single big mmap for the data file can be assumed.
+	 */
 	bool			one_mmap;
+	/** @one_mmap_addr: Address of initial perf data file reader mmap. */
 	void			*one_mmap_addr;
+	/** @one_mmap_offset: File offset in perf.data file when mapped. */
 	u64			one_mmap_offset;
+	/** @ordered_events: Used to turn unordered events into ordered ones. */
 	struct ordered_events	ordered_events;
+	/** @data: Optional perf data file being read from. */
 	struct perf_data	*data;
+	/** @tool: callbacks for event handling. */
 	const struct perf_tool	*tool;
+	/**
+	 * @bytes_transferred: Used by perf record to count written bytes before
+	 * compression.
+	 */
 	u64			bytes_transferred;
+	/**
+	 * @bytes_compressed: Used by perf record to count written bytes after
+	 * compression.
+	 */
 	u64			bytes_compressed;
+	/** @zstd_data: Owner of global compression state, buffers, etc. */
 	struct zstd_data	zstd_data;
 	struct decomp_data	decomp_data;
 	struct decomp_data	*active_decomp;
-- 
2.46.0.295.g3b9ea8a38a-goog


